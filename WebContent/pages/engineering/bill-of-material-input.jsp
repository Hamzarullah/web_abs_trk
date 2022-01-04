
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
    var BillOfMaterialTemplateDetailLastRowId = 0, BillOfMaterialTemplateDetailLastSelId = -1;
    var                                    
        txtBillOfMaterialCode = $("#billOfMaterial\\.code"),
        dtpBillOfMaterialTransactionDate = $("#billOfMaterial\\.transactionDate"),
        txtBillOfMaterialRemark = $("#billOfMaterial\\.remark"),
        txtBillOfMaterialInternalNote = $("#billOfMaterial\\.internalNote"),
        txtBillOfMaterialBranchCode = $("#billOfMaterial\\.branch\\.code"),
        txtBillOfMaterialBranchName = $("#billOfMaterial\\.branch\\.name"),
        txtBillOfMaterialDocumentCode = $("#billOfMaterial\\.documentOrderCode"),
        txtBillOfMaterialCustomerCode = $("#billOfMaterial\\.customer\\.code"),
        txtBillOfMaterialCustomerName = $("#billOfMaterial\\.customer\\.name");

    function enableExistingTemplate(from){
        switch (from){
            case "BOM":
                $(".templateBom").hide();
                $(".existingBom").show();
                break;
            case "Template":
                $(".templateBom").show();
                $(".existingBom").hide();
                break;
            }
    }
        
    $(document).ready(function(){
        
        if($("#enumBillOfMaterialActivity").val()==="NEW"){
            $('#billOfMaterialCopyFromRadExisting\\ BOM').prop('checked',true);
            $("#billOfMaterial\\.copyFrom").val("BOM");
            enableExistingTemplate("BOM");   
        }else{
            radioButtonCopyFrom();
            loadExistingBomCodeDetail();
        }
         
         $('#billOfMaterialCopyFromRadExisting\\ BOM').change(function (ev) {
            var value = "BOM";
            $("#billOfMaterial\\.copyFrom").val(value);
            enableExistingTemplate(value);
        });
        
        $('#billOfMaterialCopyFromRadTemplate').change(function (ev) {
            var value = "Template";
            $("#billOfMaterial\\.copyFrom").val(value);
            enableExistingTemplate(value);
        });
        
        loadItemFinishGoodsDetail();
        
        $.subscribe("billOfMaterialItemDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#billOfMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==BillOfMaterialTemplateDetailLastSelId) {
                $('#billOfMaterialDetailInput_grid').jqGrid("saveRow",BillOfMaterialTemplateDetailLastSelId); 
                $('#billOfMaterialDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                BillOfMaterialTemplateDetailLastSelId=selectedRowID;
            }
            else{
                $('#billOfMaterialDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnBillOfMaterialSave').click(function(ev) {
            handlers_input_bom();
            
             if(txtBillOfMaterialRemark.val()==="") {
                    alertMessage("Remark Must be Filled!");
                    ev.preventDefault();
                    return;
                }
             if(txtBillOfMaterialInternalNote.val()==="") {
                    alertMessage("Internal Note Must be Filled!");
                    ev.preventDefault();
                    return;
                }   
            //Prepare Save Detail Grid
            if(BillOfMaterialTemplateDetailLastSelId !== -1) {
                $('#billOfMaterialDetailInput_grid').jqGrid("saveRow",BillOfMaterialTemplateDetailLastSelId);
            }
            
            var listBillOfMaterialItemDetailPart = new Array();
            var ids = jQuery("#billOfMaterialDetailInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#billOfMaterialDetailInput_grid").jqGrid('getRowData',ids[i]);

                var billOfMaterialItemDetailPart = {
                    
                    sortNo              : data.billOfMaterialDetailSortNo,       
                    partNo              : data.billOfMaterialDetailPartNo,
                    part                : { code : data.billOfMaterialDetailPartCode },  
                    drawingCode         : data.billOfMaterialDetailDrawingCode,
                    dimension           : data.billOfMaterialDetailDimension,
                    requiredLength      : data.billOfMaterialDetailRequiredLength,
                    material            : data.billOfMaterialDetailMaterial,
                    quantity            : data.billOfMaterialDetailQuantity,
                    requirement         : data.billOfMaterialDetailRequirement,
                    processedStatus     : data.billOfMaterialDetailProcessedStatus,
                    remark              : data.billOfMaterialDetailRemark,
                    x                   : data.billOfMaterialDetailX,
                    revNo               : data.billOfMaterialDetailRevNo,
                    documentDetailCode  : data.billOfMaterialDetailDocumentDetailCode 
               };
                
                listBillOfMaterialItemDetailPart[i] = billOfMaterialItemDetailPart;
            }
            //END Prepare Save Detail Grid

            formatDateBillOfMaterial();
            var url="engineering/bill-of-material-save";
            var params = $("#frmBillOfMaterialInput").serialize();
                  params += "&listBillOfMaterialItemDetailPartJSON=" + $.toJSON(listBillOfMaterialItemDetailPart); 
            if($("#enumBillOfMaterialActivity").val()==="NEW"){
                params += "&enumBillOfMaterialActivity=NEW"; 
            }
//            console.log(params);
//            return;
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateBillOfMaterial(); 
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
                                var url = "engineering/bill-of-material";
                                var param = "";
                                pageLoad(url, param, "#tabmnuBILL_OF_MATERIAL");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "engineering/bill-of-material";
                                var params = "";
                                pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL");
                            }
                        }]
                });
            });
            
        });
               
        $('#btnBillOfMaterialCancel').click(function(ev) {
            var url = "engineering/bill-of-material";
            var params = "";
            pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL"); 
        });
        
        $('#btnBillOfMaterialExistingBomProcess').click(function(ev) {
            var existingBomCode = $('#billOfMaterial\\.existingBomCode').val();
//            alert(templateCode);
            if(existingBomCode === ''){
                alertMessage("Exsiting BOM Code Can't be Empty!");
                return;
            }else{
                 loadExistingBomCodeDetailPart(existingBomCode);
            }
            
        });
        
        $('#btnBillOfMaterialTemplateProcess').click(function(ev) {
            var templateCode = $('#billOfMaterial\\.template').val();
//            alert(templateCode);
            if(templateCode === ''){
                alertMessage("Template Code Can't be Empty!");
                return;
            }else{
                 loadTemplateDetail(templateCode);
            }
            
        });
        
        $('#btnBillOfMaterialDetailSearchPart').click(function(ev) {
            var ids = jQuery("#billOfMaterialDetailInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-part.jsp?iddoc=billOfMaterialDetail&type=grid&rowLast="+ids.length,"Search", "scrollbars=1,width=600, height=500");
        });
       
    }); //EOF Ready
    
    function addRowDataMultiSelectedBom(lastRowId,defRow){
        
        var ids = jQuery("#billOfMaterialDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        var data= $("#billOfMaterialDetailInput_grid").jqGrid('getRowData',lastRowId);
        
            $("#billOfMaterialDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#billOfMaterialDetailInput_grid").jqGrid('setRowData',lastRowId,{
                billOfMaterialDetailDelete              : defRow.billOfMaterialDetailDelete,
                billOfMaterialDetailPartCode            : defRow.billOfMaterialDetailPartCode,
                billOfMaterialDetailPartName            : defRow.billOfMaterialDetailPartName,
                billOfMaterialDetailDocumentDetailCode  : $("#billOfMaterial\\.documentDetailCode").val()
            });
            
        setHeightGridHeader();
    }
    
    function setHeightGridHeader(){
        var ids = jQuery("#billOfMaterialDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#billOfMaterialDetailInput_grid"+" tr").eq(1).height();
            $("#billOfMaterialDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#billOfMaterialDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function loadTemplateDetail(headerCode) {
        
        var url = "master/bill-of-material-template-get-detail-template";
        var params = "headerCode=" + headerCode;
        
        $.getJSON(url, params, function(data) {
            BillOfMaterialTemplateDetailLastRowId = 0;

            for (var i=0; i<data.listBillOfMaterialTemplateDetail.length; i++) {
                BillOfMaterialTemplateDetailLastRowId++;
                $("#billOfMaterialDetailInput_grid").jqGrid("addRowData", BillOfMaterialTemplateDetailLastRowId, data.listBillOfMaterialTemplateDetail[i]);
                $("#billOfMaterialDetailInput_grid").jqGrid('setRowData',BillOfMaterialTemplateDetailLastRowId,{
                    billOfMaterialDetailDelete              : "delete",
                    billOfMaterialDetailSortNo              : data.listBillOfMaterialTemplateDetail[i].sortNo,
                    billOfMaterialDetailPartNo              : data.listBillOfMaterialTemplateDetail[i].partNo,
                    billOfMaterialDetailPartCode            : data.listBillOfMaterialTemplateDetail[i].partCode,
                    billOfMaterialDetailPartName            : data.listBillOfMaterialTemplateDetail[i].partName,
                    billOfMaterialDetailDrawingCode         : data.listBillOfMaterialTemplateDetail[i].drawingCode,
                    billOfMaterialDetailDimension           : data.listBillOfMaterialTemplateDetail[i].dimension,
                    billOfMaterialDetailRequiredLength      : data.listBillOfMaterialTemplateDetail[i].requiredLength,
                    billOfMaterialDetailMaterial            : data.listBillOfMaterialTemplateDetail[i].material,
                    billOfMaterialDetailQuantity            : data.listBillOfMaterialTemplateDetail[i].quantity,
                    billOfMaterialDetailRequirement         : data.listBillOfMaterialTemplateDetail[i].requirement,
                    billOfMaterialDetailProcessedStatus     : data.listBillOfMaterialTemplateDetail[i].processedStatus,
                    billOfMaterialDetailX                   : data.listBillOfMaterialTemplateDetail[i].x,
                    billOfMaterialDetailRevNo               : data.listBillOfMaterialTemplateDetail[i].revNo,
                    billOfMaterialDetailDocumentDetailCode  : $("#billOfMaterial\\.documentDetailCode").val()
                });
            }
        });
    }
    
    function loadExistingBomCodeDetailPart(headerCode) {
        
        var url = "engineering/bill-of-material-part-detail-data";
        var params = "billOfMaterialCode=" + headerCode;
        
        $.getJSON(url, params, function(data) {
            BillOfMaterialTemplateDetailLastRowId = 0;

            for (var i=0; i<data.listBillOfMaterialPartDetail.length; i++) {
                BillOfMaterialTemplateDetailLastRowId++;
                $("#billOfMaterialDetailInput_grid").jqGrid("addRowData", BillOfMaterialTemplateDetailLastRowId, data.listBillOfMaterialPartDetail[i]);
                $("#billOfMaterialDetailInput_grid").jqGrid('setRowData',BillOfMaterialTemplateDetailLastRowId,{
                    billOfMaterialDetailDelete              : "delete",
                    billOfMaterialDetailDocumentDetailCode  : $("#billOfMaterial\\.documentDetailCode").val(),
                    billOfMaterialDetailSortNo              : data.listBillOfMaterialPartDetail[i].sortNo,
                    billOfMaterialDetailPartNo              : data.listBillOfMaterialPartDetail[i].partNo,
                    billOfMaterialDetailPartCode            : data.listBillOfMaterialPartDetail[i].partCode,
                    billOfMaterialDetailPartName            : data.listBillOfMaterialPartDetail[i].partName,
                    billOfMaterialDetailDrawingCode         : data.listBillOfMaterialPartDetail[i].drawingCode,
                    billOfMaterialDetailDimension           : data.listBillOfMaterialPartDetail[i].dimension,
                    billOfMaterialDetailRequiredLength      : data.listBillOfMaterialPartDetail[i].requiredLength,
                    billOfMaterialDetailMaterial            : data.listBillOfMaterialPartDetail[i].material,
                    billOfMaterialDetailQuantity            : data.listBillOfMaterialPartDetail[i].quantity,
                    billOfMaterialDetailRequirement         : data.listBillOfMaterialPartDetail[i].requirement,
                    billOfMaterialDetailProcessedStatus     : data.listBillOfMaterialPartDetail[i].processedStatus,
                    billOfMaterialDetailRemark              : data.listBillOfMaterialPartDetail[i].remark,
                    billOfMaterialDetailX                   : data.listBillOfMaterialPartDetail[i].x,
                    billOfMaterialDetailRevNo               : data.listBillOfMaterialPartDetail[i].revNo
                });
            }
        });
    }
    
    function loadExistingBomCodeDetail() {
        
        var url = "engineering/bill-of-material-part-detail-data";
        var params;
        if ($("#enumBillOfMaterialActivity").val()==="UPDATE"){
            params = "billOfMaterialCode=" + txtBillOfMaterialCode.val();
        }else if ($("#enumBillOfMaterialActivity").val()==="REVISE"){
            params = "billOfMaterialCode=" + $("#billOfMaterial\\.codeTemp").val();
        }
        
        $.getJSON(url, params, function(data) {
            BillOfMaterialTemplateDetailLastRowId = 0;

            for (var i=0; i<data.listBillOfMaterialPartDetail.length; i++) {
                BillOfMaterialTemplateDetailLastRowId++;
                $("#billOfMaterialDetailInput_grid").jqGrid("addRowData", BillOfMaterialTemplateDetailLastRowId, data.listBillOfMaterialPartDetail[i]);
                $("#billOfMaterialDetailInput_grid").jqGrid('setRowData',BillOfMaterialTemplateDetailLastRowId,{
                    billOfMaterialDetailDelete              : "delete",
                    billOfMaterialDetailDocumentDetailCode  : data.listBillOfMaterialPartDetail[i].documentDetailCode,
                    billOfMaterialDetailSortNo              : data.listBillOfMaterialPartDetail[i].sortNo,
                    billOfMaterialDetailPartNo              : data.listBillOfMaterialPartDetail[i].partNo,
                    billOfMaterialDetailPartCode            : data.listBillOfMaterialPartDetail[i].partCode,
                    billOfMaterialDetailPartName            : data.listBillOfMaterialPartDetail[i].partName,
                    billOfMaterialDetailDrawingCode         : data.listBillOfMaterialPartDetail[i].drawingCode,
                    billOfMaterialDetailDimension           : data.listBillOfMaterialPartDetail[i].dimension,
                    billOfMaterialDetailMaterial            : data.listBillOfMaterialPartDetail[i].material,
                    billOfMaterialDetailQuantity            : data.listBillOfMaterialPartDetail[i].quantity,
                    billOfMaterialDetailRequirement         : data.listBillOfMaterialPartDetail[i].requirement,
                    billOfMaterialDetailProcessedStatus     : data.listBillOfMaterialPartDetail[i].processedStatus,
                    billOfMaterialDetailRemark              : data.listBillOfMaterialPartDetail[i].remark,
                    billOfMaterialDetailX                   : data.listBillOfMaterialPartDetail[i].x,
                    billOfMaterialDetailRevNo               : data.listBillOfMaterialPartDetail[i].revNo
                });
            }
        });
    }
    
    function loadItemFinishGoodsDetail(){
            
        var code = $('#billOfMaterial\\.itemFinishGoods\\.code').val();
        var url = "master/item-finish-goods-get-data";
        var params = "itemFinishGoods.code=" + code;

        $.post(url, params, function(result) {
            var data = (result);
            if (data.itemFinishGoodsTemp){
                
                $("#billOfMaterial\\.customerCode").val(data.itemFinishGoodsTemp.customerCode);
                $("#billOfMaterial\\.customerName").val(data.itemFinishGoodsTemp.customerName);
                $("#billOfMaterial\\.valveTypeCode").val(data.itemFinishGoodsTemp.valveTypeCode);
                $("#billOfMaterial\\.valveTypeName").val(data.itemFinishGoodsTemp.valveTypeName);
                //finishGoods
                $("#billOfMaterial\\.itemFinishGoods\\.itemBodyConstructionCode").val(data.itemFinishGoodsTemp.itemBodyConstructionCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBodyConstructionName").val(data.itemFinishGoodsTemp.itemBodyConstructionName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemTypeDesignCode").val(data.itemFinishGoodsTemp.itemTypeDesignCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemTypeDesignName").val(data.itemFinishGoodsTemp.itemTypeDesignName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSeatDesignCode").val(data.itemFinishGoodsTemp.itemSeatDesignCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSeatDesignName").val(data.itemFinishGoodsTemp.itemSeatDesignName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSizeCode").val(data.itemFinishGoodsTemp.itemSizeCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSizeName").val(data.itemFinishGoodsTemp.itemSizeName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemRatingCode").val(data.itemFinishGoodsTemp.itemRatingCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemRatingName").val(data.itemFinishGoodsTemp.itemRatingName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBoreCode").val(data.itemFinishGoodsTemp.itemBoreCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBoreName").val(data.itemFinishGoodsTemp.itemBoreName);
                
                $("#billOfMaterial\\.itemFinishGoods\\.itemEndConCode").val(data.itemFinishGoodsTemp.itemEndConCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemEndConName").val(data.itemFinishGoodsTemp.itemEndConName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBodyCode").val(data.itemFinishGoodsTemp.itemBodyCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBodyName").val(data.itemFinishGoodsTemp.itemBodyName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBallCode").val(data.itemFinishGoodsTemp.itemBallCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBallName").val(data.itemFinishGoodsTemp.itemBallName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSeatCode").val(data.itemFinishGoodsTemp.itemSeatCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSeatName").val(data.itemFinishGoodsTemp.itemSeatName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSeatInsertCode").val(data.itemFinishGoodsTemp.itemSeatInsertCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSeatInsertName").val(data.itemFinishGoodsTemp.itemSeatInsertName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemStemCode").val(data.itemFinishGoodsTemp.itemStemCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemStemName").val(data.itemFinishGoodsTemp.itemStemName);
                
                $("#billOfMaterial\\.itemFinishGoods\\.itemSealCode").val(data.itemFinishGoodsTemp.itemSealCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSealName").val(data.itemFinishGoodsTemp.itemSealName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBoltCode").val(data.itemFinishGoodsTemp.itemBoltCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBoltName").val(data.itemFinishGoodsTemp.itemBoltName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemDiscCode").val(data.itemFinishGoodsTemp.itemDiscCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemDiscName").val(data.itemFinishGoodsTemp.itemDiscName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemPlatesCode").val(data.itemFinishGoodsTemp.itemPlatesCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemPlatesName").val(data.itemFinishGoodsTemp.itemPlatesName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemShaftCode").val(data.itemFinishGoodsTemp.itemShaftCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemShaftName").val(data.itemFinishGoodsTemp.itemShaftName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSpringCode").val(data.itemFinishGoodsTemp.itemSpringCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemSpringName").val(data.itemFinishGoodsTemp.itemSpringName);
                
                $("#billOfMaterial\\.itemFinishGoods\\.itemArmPinCode").val(data.itemFinishGoodsTemp.itemSpringName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemArmPinName").val(data.itemFinishGoodsTemp.itemSpringName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBackseatCode").val(data.itemFinishGoodsTemp.itemBackseatCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemBackseatName").val(data.itemFinishGoodsTemp.itemBackseatName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemArmCode").val(data.itemFinishGoodsTemp.itemArmCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemArmName").val(data.itemFinishGoodsTemp.itemArmName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemHingePinCode").val(data.itemFinishGoodsTemp.itemHingePinCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemHingePinName").val(data.itemFinishGoodsTemp.itemHingePinName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemStopPinCode").val(data.itemFinishGoodsTemp.itemStopPinCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemStopPinName").val(data.itemFinishGoodsTemp.itemStopPinName);
                $("#billOfMaterial\\.itemFinishGoods\\.itemOperatorCode").val(data.itemFinishGoodsTemp.itemOperatorCode);
                $("#billOfMaterial\\.itemFinishGoods\\.itemOperatorName").val(data.itemFinishGoodsTemp.itemOperatorName);

            }
        });
    }
    
    function radioButtonCopyFrom(){
        if ($("#billOfMaterial\\.copyFrom").val()==="BOM"){
            $('#billOfMaterialCopyFromRadExisting\\ BOM').prop('checked',true);
            enableExistingTemplate("BOM");
        }else{
            $('#billOfMaterialCopyFromRadTemplate').prop('checked',true);
            enableExistingTemplate("Template");
        }
    }
    
    function billOfMaterialTransactionDateOnChange(){
        if($("#enumBillOfMaterialActivity").val()!=="UPDATE"){
            var billOfMaterialTransactionDateSplit=$("#billOfMaterial\\.transactionDate").val().split('/');
            var billOfMaterialTransactionDate=billOfMaterialTransactionDateSplit[1]+"/"+billOfMaterialTransactionDateSplit[0]+"/"+billOfMaterialTransactionDateSplit[2];
            $("#billOfMaterialTransactionDate").val(billOfMaterialTransactionDate);
        }
    }
    
    function billOfMaterialDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#billOfMaterialDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#billOfMaterialDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
    }
    
    function formatDateBillOfMaterial(){
        var transactionDateSplit=dtpBillOfMaterialTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpBillOfMaterialTransactionDate.val(transactionDate);
    }
    
    function handlers_input_bom(){
        if(txtBillOfMaterialRemark.val()===""){
            handlersInput(txtBillOfMaterialRemark);
        }else{
            unHandlersInput(txtBillOfMaterialRemark);
        }
        if(txtBillOfMaterialInternalNote.val()===""){
            handlersInput(txtBillOfMaterialInternalNote);
        }else{
            unHandlersInput(txtBillOfMaterialInternalNote);
        }
    }
    
    function avoidSpcCharBom(){
        
        var selectedRowID = $("#billOfMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#billOfMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = BillOfMaterialTemplateDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_billOfMaterialDetailSortNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep = str.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_billOfMaterialDetailSortNo").val(rep);
        }
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_billOfMaterialDetailSortNo").val("");
        }
        
        let str1 = $("#" + selectedRowID + "_billOfMaterialDetailPartNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str1) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep1 = str1.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_billOfMaterialDetailPartNo").val(rep1);
        }
        
        if (isNaN(str1)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_billOfMaterialDetailPartNo").val("");
        }
        
        let str2 = $("#" + selectedRowID + "_billOfMaterialDetailRevNo").val();
        
        if(/^[a-zA-Z0-9- ]*$/.test(str2) === false){
            alert('Your Sort Number contains illegal characters.');
            var rep2 = str2.replace(/[^a-zA-Z ]/g,"");
            $("#" + selectedRowID + "_billOfMaterialDetailRevNo").val(rep2);
        }
        
        if (isNaN(str2)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_billOfMaterialDetailRevNo").val("");
        }
    }   
    
    function avoidCharBOM(){
        
        var selectedRowID = $("#billOfMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#billOfMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = BillOfMaterialTemplateDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_billOfMaterialDetailQuantity").val(); 
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "billOfMaterialDetailQuantity").val("");
        }
    }
</script>
<s:url id="remoteurlBillOfMaterialDetailInput" action="" />

<b>BILL OF MATERIAL (ENGINEERING)</b>
<hr>
<br class="spacer" />

<div id="billOfMaterialInput" class="content ui-widget">
    <s:form id="frmBillOfMaterialInput">
        <table width="100%" id="headerBillOfMaterialInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" width="100px"><b>Code *</b></td>
                            <td><s:textfield id="billOfMaterial.code" name="billOfMaterial.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                            <td><s:textfield id="billOfMaterial.codeTemp" name="billOfMaterial.codeTemp" maxLength="45" readonly="true" hidden="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px"><b>BOM No *</b></td>
                            <td><s:textfield id="billOfMaterial.bomNo" name="billOfMaterial.bomNo" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Ref Bom No </td>
                            <td><s:textfield id="billOfMaterial.refBomCode" name="billOfMaterial.refBomCode" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px"><b>Transaction Date *</b></td>
                            <td><sj:datepicker id="billOfMaterial.transactionDate" name="billOfMaterial.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange="billOfMaterialTransactionDateOnChange()"></sj:datepicker>
                                <sj:datepicker id="billOfMaterialTransactionDate" name="billOfMaterialTransactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">DOC No</td>
                            <td><s:textfield id="billOfMaterial.documentOrderCode" name="billOfMaterial.documentOrderCode" title="*" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr hidden="true">
                            <td align="right" width="100px">DOC Detail Code</td>
                            <td><s:textfield id="billOfMaterial.documentDetailCode" name="billOfMaterial.documentDetailCode" title="*" maxLength="45" size="41" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">DOC Date</td>
                            <td><sj:datepicker id="billOfMaterial.transactionDateDoc" name="billOfMaterial.transactionDateDoc" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" disabled="true" readonly="true"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">DOC Type</td>
                            <td><s:textfield id="billOfMaterial.documentType" name="billOfMaterial.documentType" title="*" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="billOfMaterial.revision" name="billOfMaterial.revision" key="billOfMaterial.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Item Finish Goods</td>
                            <td><s:textfield id="billOfMaterial.itemFinishGoods.code" name="billOfMaterial.itemFinishGoods.code" title="*" maxLength="45" size="41" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Valve Type</td>
                            <td>
                                <s:textfield id="billOfMaterial.valveTypeCode" name="billOfMaterial.valveTypeCode" title="*" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.valveTypeName" name="billOfMaterial.valveTypeName" title="*" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Customer</td>
                            <td>
                                <s:textfield id="billOfMaterial.customerCode" name="billOfMaterial.customerCode" title="*" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.customerName" name="billOfMaterial.customerName" title="*" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Drawing No </td>
                            <td><s:textfield id="billOfMaterial.drawingCode" name="billOfMaterial.drawingCode" size="15" ></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Copy From
                            <s:textfield id="billOfMaterial.copyFrom" name="billOfMaterial.copyFrom" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="billOfMaterialCopyFromRad" name="billOfMaterialCopyFromRad" list="{'Existing BOM','Template'}"></s:radio></td>                    
                        </tr>
                        <tr class="existingBom">
                            <td align="right"><B>Existing BOM *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">

                                    $('#billOfMaterial_btnExistingBom').click(function(ev) {
                                        window.open("./pages/search/search-existing-bill-of-material.jsp?iddoc=billOfMaterial","Search", "width=600, height=500");
                                    });

                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="billOfMaterial.existingBomCode" name="billOfMaterial.existingBomCode" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                                    <sj:a id="billOfMaterial_btnExistingBom" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <sj:a href="#" id="btnBillOfMaterialExistingBomProcess" button="true" style="width: 60px">Process</sj:a>
                            </td>
                        </tr>
                        <tr class="templateBom">
                            <td align="right"><B>Template *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">

                                    $('#billOfMaterial_btnTemplate').click(function(ev) {
                                        window.open("./pages/search/search-bill-of-material-template.jsp?iddoc=billOfMaterial","Search", "width=600, height=500");
                                    });

                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="billOfMaterial.template" name="billOfMaterial.template" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                                    <sj:a id="billOfMaterial_btnTemplate" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                    <sj:a href="#" id="btnBillOfMaterialTemplateProcess" button="true" style="width: 60px">Process</sj:a>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Remark *</B></td>
                            <td><s:textarea id="billOfMaterial.remark" name="billOfMaterial.remark" cols="53" rows="3" ></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Internal Note *</B></td>
                            <td><s:textarea id="billOfMaterial.internalNote" name="billOfMaterial.internalNote" cols="53" rows="3" ></s:textarea></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td align="right">Body Construction</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBodyConstructionCode" name="billOfMaterial.itemFinishGoods.itemBodyConstructionCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBodyConstructionName" name="billOfMaterial.itemFinishGoods.itemBodyConstructionName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Type Design</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemTypeDesignCode" name="billOfMaterial.itemFinishGoods.itemTypeDesignCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemTypeDesignName" name="billOfMaterial.itemFinishGoods.itemTypeDesignName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat Design</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSeatDesignCode" name="billOfMaterial.itemFinishGoods.itemSeatDesignCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSeatDesignName" name="billOfMaterial.itemFinishGoods.itemSeatDesignName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Size</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSizeCode" name="billOfMaterial.itemFinishGoods.itemSizeCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSizeName" name="billOfMaterial.itemFinishGoods.itemSizeName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Rating</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemRatingCode" name="billOfMaterial.itemFinishGoods.itemRatingCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemRatingName" name="billOfMaterial.itemFinishGoods.itemRatingName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Bore</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBoreCode" name="billOfMaterial.itemFinishGoods.itemBoreCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBoreName" name="billOfMaterial.itemFinishGoods.itemBoreName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">End Con</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemEndConCode" name="billOfMaterial.itemFinishGoods.itemEndConCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemEndConName" name="billOfMaterial.itemFinishGoods.itemEndConName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Body</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBodyCode" name="billOfMaterial.itemFinishGoods.itemBodyCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBodyName" name="billOfMaterial.itemFinishGoods.itemBodyName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ball</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBallCode" name="billOfMaterial.itemFinishGoods.itemBallCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBallName" name="billOfMaterial.itemFinishGoods.itemBallName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSeatCode" name="billOfMaterial.itemFinishGoods.itemSeatCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSeatName" name="billOfMaterial.itemFinishGoods.itemSeatName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat Insert</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSeatInsertCode" name="billOfMaterial.itemFinishGoods.itemSeatInsertCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSeatInsertName" name="billOfMaterial.itemFinishGoods.itemSeatInsertName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Stem</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemStemCode" name="billOfMaterial.itemFinishGoods.itemStemCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemStemName" name="billOfMaterial.itemFinishGoods.itemStemName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seal</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSealCode" name="billOfMaterial.itemFinishGoods.itemSealCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSealName" name="billOfMaterial.itemFinishGoods.itemSealName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Bolt</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBoltCode" name="billOfMaterial.itemFinishGoods.itemBoltCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBoltName" name="billOfMaterial.itemFinishGoods.itemBoltName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Disc</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemDiscCode" name="billOfMaterial.itemFinishGoods.itemDiscCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemDiscName" name="billOfMaterial.itemFinishGoods.itemDiscName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Plates</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemPlatesCode" name="billOfMaterial.itemFinishGoods.itemPlatesCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemPlatesName" name="billOfMaterial.itemFinishGoods.itemPlatesName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Shaft</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemShaftCode" name="billOfMaterial.itemFinishGoods.itemShaftCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemShaftName" name="billOfMaterial.itemFinishGoods.itemShaftName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Spring</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSpringCode" name="billOfMaterial.itemFinishGoods.itemSpringCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemSpringName" name="billOfMaterial.itemFinishGoods.itemSpringName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Arm Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemArmPinCode" name="billOfMaterial.itemFinishGoods.itemArmPinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemArmPinName" name="billOfMaterial.itemFinishGoods.itemArmPinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Back Seat</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBackseatCode" name="billOfMaterial.itemFinishGoods.itemBackseatCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemBackseatName" name="billOfMaterial.itemFinishGoods.itemBackseatName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Arm</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemArmCode" name="billOfMaterial.itemFinishGoods.itemArmCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemArmName" name="billOfMaterial.itemFinishGoods.itemArmName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Hinge Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemHingePinCode" name="billOfMaterial.itemFinishGoods.itemHingePinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemHingePinName" name="billOfMaterial.itemFinishGoods.itemHingePinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Stop Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemStopPinCode" name="billOfMaterial.itemFinishGoods.itemStopPinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemStopPinName" name="billOfMaterial.itemFinishGoods.itemStopPinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Operator</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemOperatorCode" name="billOfMaterial.itemFinishGoods.itemOperatorCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterial.itemFinishGoods.itemOperatorName" name="billOfMaterial.itemFinishGoods.itemOperatorName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <s:textfield id="enumBillOfMaterialActivity" name="enumBillOfMaterialActivity" size="20" cssStyle="display:none"></s:textfield>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <table width="100%">
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnBillOfMaterialDetailSearchPart" button="true" style="width: 100px">Search Part</sj:a>
                    <sj:a href="#" id="btnBillOfMaterialDetailSortNo" button="true" style="width: 100px">Re-Sorting</sj:a>
                </td>
            </tr>
            <tr>
                <td>
                    <sjg:grid
                        id="billOfMaterialDetailInput_grid"
                        caption="Bill Of Material Detail"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listBillOfMaterialDetail"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        editinline="true"
                        width="$('#tabmnuBillOfMaterialDetail').width()"
                        editurl="%{remoteurlBillOfMaterialDetailInput}"
                        onSelectRowTopics="billOfMaterialItemDetailInput_grid_onSelect"
                    >
                        <sjg:gridColumn
                            name="billOfMaterialDetail" index="billOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="billOfMaterialDetailDelete" index="billOfMaterialDetailDelete" title="" width="50" align="centre"
                            editable="true"
                            edittype="button"
                            editoptions="{onClick:'billOfMaterialDetailInputGrid_Delete_OnClick()', value:'delete'}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailDocumentDetailCode" index="billOfMaterialDetailDocumentDetailCode" key="billOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" align="right" editable="true" edittype="text" hidden="false"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailSortNo" index="billOfMaterialDetailSortNo" key="billOfMaterialDetailSortNo" title="Sort No" 
                            width="80" align="right" editable="true" edittype="text" formatter="integer"
                            editoptions="{onKeyUp:'avoidSpcCharBom()'}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailPartNo" index="billOfMaterialDetailPartNo" key="billOfMaterialDetailPartNo" title="Part No" 
                            width="80" align="right" editable="true" edittype="text" formatter="integer"
                            editoptions="{onKeyUp:'avoidSpcCharBom()'}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailPartCode" index="billOfMaterialDetailPartCode" key="billOfMaterialDetailPartCode" title="Part Code" 
                            width="80" align="right"  edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailPartName" index="billOfMaterialDetailPartName" key="billOfMaterialDetailPartName" title="Part Name" 
                            width="80" align="right"  edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailDrawingCode" index="billOfMaterialDetailDrawingCode" key="billOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" editable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailDimension" index="billOfMaterialDetailDimension" key="billOfMaterialDetailDimension" title="Dimension" 
                            width="80" align="right" editable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailRequiredLength" index="billOfMaterialDetailRequiredLength" key="billOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="true" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailMaterial" index="billOfMaterialDetailMaterial" key="billOfMaterialDetailMaterial" title="Material" 
                            width="80" align="right" editable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailQuantity" index="billOfMaterialDetailQuantity" key="billOfMaterialDetailQuantity" title="Quantity" 
                            width="80" align="right" editable="true" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                            editoptions="{onKeyUp:'avoidCharBOM()'}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailRequirement" index="billOfMaterialDetailRequirement" key="billOfMaterialDetailRequirement" title="Requirement" 
                            width="80" align="right" editable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name = "billOfMaterialDetailProcessedStatus" index = "billOfMaterialDetailProcessedStatus" key = "billOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                            formatter="select" align="center" formoptions="{label:'Please Select'}"
                            editable="true" edittype="select" editoptions="{value:'MACHINING:MACHINING;NON_MACHINING:NON_MACHINING',onChange:'refreshBillOfMaterialInputanGridByOthersProcessedStatus()'}" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailRemark" index="billOfMaterialDetailRemark" key="billOfMaterialDetailRemark" title="Remark" 
                            width="80" align="right" editable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailX" index="billOfMaterialDetailX" key="billOfMaterialDetailX" title="X" 
                            width="80" align="right" editable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialDetailRevNo" index="billOfMaterialDetailRevNo" key="billOfMaterialDetailRevNo" title="Rev No" 
                            width="80" align="right" editable="true" edittype="text" formatter="integer"
                            editoptions="{onKeyUp:'avoidSpcCharBom()'}"
                        />
                    </sjg:grid >
                </td>
            </tr>
        </table>
        <br class="spacer" />      
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnBillOfMaterialSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnBillOfMaterialCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
                
                
    </s:form>
</div>
    

