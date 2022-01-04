
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
</style>
<script type="text/javascript">
    var billOfMaterialTemplateItemDetailLastRowId = 0, billOfMaterialTemplateItemDetailLastSel = -1;
    var                                    
        txtBillOfMaterialTemplateCode = $("#billOfMaterialTemplate\\.code"),
        dtpBillOfMaterialTemplateTransactionDate = $("#billOfMaterialTemplate\\.transactionDate"),
        txtBillOfMaterialTemplateEndUserCode = $("#billOfMaterialTemplate\\.itemFinishGoods\\.endUserCode"),
        txtBillOfMaterialTemplateEndUserName = $("#billOfMaterialTemplate\\.itemFinishGoods\\.endUserName"),
        txtBillOfMaterialTemplateItemFinishGoodsCode = $("#billOfMaterialTemplate\\.itemFinishGoodsName\\.code"),
        txtBillOfMaterialTemplateDocumentCode = $("#billOfMaterialTemplate\\.documentCode"),
        txtBillOfMaterialTemplateEndUserCode = $("#billOfMaterialTemplate\\.customer\\.code"),
        txtBillOfMaterialTemplateEndUserName = $("#billOfMaterialTemplate\\.customer\\.name");
        
    $(document).ready(function(){
        
        hoverButton();
        
        //Detail        
        $.subscribe("billOfMaterialTemplateDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#billOfMaterialTemplateDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==billOfMaterialTemplateItemDetailLastSel) {
                $('#billOfMaterialTemplateDetailInput_grid').jqGrid("saveRow",billOfMaterialTemplateItemDetailLastSel); 
                $('#billOfMaterialTemplateDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                billOfMaterialTemplateItemDetailLastSel=selectedRowID;
            }
            else{
                $('#billOfMaterialTemplateDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        if($("#billOfMaterialTemplateUpdateMode").val() === "true"){
            //load item finish Goods
            loadBomItemFinishGoods();
            loadBomItemFinishGoodsDetail();
        }
        
        $('#btnBillOfMaterialTemplateDetailSortNo').click(function(ev) {
            if($("#billOfMaterialTemplateDetailInput_grid").jqGrid('getDataIDs').length===0){
                {alertMessage("Grid Detail Can't Be Empty!");
                return;}
            }
            
            if(billOfMaterialTemplateItemDetailLastSel !== -1) {
                $('#billOfMaterialTemplateDetailInput_grid').jqGrid("saveRow",billOfMaterialTemplateItemDetailLastSel);  
            }
            
            var ids = jQuery("#billOfMaterialTemplateDetailInput_grid").jqGrid('getDataIDs');
            var listBillOfMaterialTemplateItemDetail = new Array();

            for(var k=0;k<ids.length;k++){
                var detail = $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getRowData',ids[k]);
                
                if(detail.billOfMaterialTemplateDetailSortNo===""){
                    alertMessage("Sort No Can't Empty!");
                    return;
                }

                if(detail.billOfMaterialTemplateDetailSortNo=== '0' ){
                    alertMessage("Sort No Can't Zero!");
                    return;
                }
                
                for(var j=k; j<=ids.length-1; j++){
                var details = $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getRowData',ids[j+1]);
                if(detail.billOfMaterialTemplateDetailSortNo === details.billOfMaterialTemplateDetailSortNo){
                    alertMessage("Sort No Can't Be The Same!");
                    return;
                }
              }
            
            var data = $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getRowData',ids[k]);    
            var billOfMaterialTemplateItemDetail = { 
                    part                            : { code : data.billOfMaterialTemplateDetailPartCode, name :data.billOfMaterialTemplateDetailPartName},
                    sortNo                          : data.billOfMaterialTemplateDetailSortNo,
                    partNo                          : data.billOfMaterialTemplateDetailPartNo,
                    drawingCode                     : data.billOfMaterialTemplateDetailDrawingCode,
                    dimension                       : data.billOfMaterialTemplateDetailDimension,
                    material                        : data.billOfMaterialTemplateDetailMaterial,
                    quantity                        : data.billOfMaterialTemplateDetailQuantity,
                    requirement                     : data.billOfMaterialTemplateDetailRequirement,
                    processedStatus                 : data.billOfMaterialTemplateDetailProcessedStatus,
                    activeStatus                    : data.billOfMaterialTemplateDetailActiveStatus,
                    remark                          : data.billOfMaterialTemplateDetailRemark,
                    x                               : data.billOfMaterialTemplateDetailX
                    
                };
                listBillOfMaterialTemplateItemDetail[k] = billOfMaterialTemplateItemDetail;
            }
      
            var result = Enumerable.From(listBillOfMaterialTemplateItemDetail)
                            .OrderBy('$.sortNo')
                            .Select()
                            .ToArray();
        
            $("#billOfMaterialTemplateDetailInput_grid").jqGrid('clearGridData');
            billOfMaterialTemplateItemDetailLastSel = 0;
                for(var i = 0; i < result.length; i++){
                    billOfMaterialTemplateItemDetailLastSel ++;
                    $("#billOfMaterialTemplateDetailInput_grid").jqGrid("addRowData",billOfMaterialTemplateItemDetailLastSel, result[i]);
                    $("#billOfMaterialTemplateDetailInput_grid").jqGrid('setRowData',billOfMaterialTemplateItemDetailLastSel,{
                        
                    customerPurchaseOrderItemDetailQuotationNo                      : result[i].part.code,
                    billOfMaterialTemplateDetailSortNo                              : result[i].sortNo,
                    billOfMaterialTemplateDetailPartNo                              : result[i].part.code,
                    billOfMaterialTemplateDetailPartCode                            : result[i].part.code,
                    billOfMaterialTemplateDetailPartName                            : result[i].part.name,
                    billOfMaterialTemplateDetailDrawingCode                         : result[i].drawingCode,
                    billOfMaterialTemplateDetailDimension                           : result[i].dimension,
                    billOfMaterialTemplateDetailMaterial                            : result[i].material,
                    billOfMaterialTemplateDetailQuantity                            : result[i].quantity,
                    billOfMaterialTemplateDetailRequirement                         : result[i].requirement,
                    billOfMaterialTemplateDetailProcessedStatus                     : result[i].processedStatus,
                    billOfMaterialTemplateDetailActiveStatus                        : result[i].activeStatus,
                    billOfMaterialTemplateDetailX                                   : result[i].x
               });    
            }
        
        });
        
        $('#btnBillOfMaterialTemplateSave').click(function(ev) {
//            txtBillOfMaterialTemplateItemFinishGoodsCode      
            if($('#billOfMaterialTemplate\\.itemFinishGoods\\.code').val() === "") {
                alertMessage("Item Finish Goods Cant be Empty");
                return;
            }
            if(billOfMaterialTemplateItemDetailLastSel !== -1) {
                $('#billOfMaterialTemplateDetailInput_grid').jqGrid("saveRow",billOfMaterialTemplateItemDetailLastSel);
            }
            
            //Prepare Save Detail Grid
            var listBillOfMaterialTemplateDetail = new Array();
            var ids = $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getRowData',ids[i]);

                var billOfMaterialTemplateDetail = {
                    part                            : { code : data.billOfMaterialTemplateDetailPartCode },
                    sortNo                          : data.billOfMaterialTemplateDetailSortNo,
                    partNo                          : data.billOfMaterialTemplateDetailPartNo,
                    drawingCode                     : data.billOfMaterialTemplateDetailDrawingCode,
                    dimension                       : data.billOfMaterialTemplateDetailDimension,
                    requiredLength                  : data.billOfMaterialTemplateDetailRequiredLength,
                    material                        : data.billOfMaterialTemplateDetailMaterial,
                    quantity                        : data.billOfMaterialTemplateDetailQuantity,
                    requirement                     : data.billOfMaterialTemplateDetailRequirement,
                    processedStatus                 : data.billOfMaterialTemplateDetailProcessedStatus,
                    activeStatus                    : data.billOfMaterialTemplateDetailActiveStatus,
                    x                               : data.billOfMaterialTemplateDetailX
                };
                
                listBillOfMaterialTemplateDetail[i] = billOfMaterialTemplateDetail;
            }
            //END Prepare Save Detail Grid

            formatDateBillOfMaterialTemplate();
            var url="master/bill-of-material-template-save";
            var params = $("#frmBillOfMaterialTemplateInput").serialize();
                params += "&listBillOfMaterialTemplateDetailJSON=" + $.toJSON(listBillOfMaterialTemplateDetail); 

            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateBillOfMaterialTemplate(); 
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
                                var url = "master/bill-of-material-template";
                                var param = "";
                                pageLoad(url, param, "#tabmnuBILL_OF_MATERIAL_TEMPLATE");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "master/bill-of-material-template";
                                var params = "";
                                pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL_TEMPLATE");
                            }
                        }]
                });
            });
            
        });
               
        $('#btnBillOfMaterialTemplateCancel').click(function(ev) {
            var url = "master/bill-of-material-template";
            var params = "";
            pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL_TEMPLATE"); 
        });
        
        // Grid Detail button Function
        $('#btnBillOfMaterialTemplateDetailSearchPart').click(function(ev) {
            var ids = jQuery("#billOfMaterialTemplateDetailInput_grid").jqGrid('getDataIDs');
//            alert(ids.length);
             window.open("./pages/search/search-part.jsp?iddoc=billOfMaterialTemplateDetail&type=grid&rowLast="+ids.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function loadBomItemFinishGoods(){
            
        var code = txtBillOfMaterialTemplateCode.val();
        var url = "master/bill-of-material-template-get-data";
        var params = "billOfMaterialTemplate.code=" + code;
//            alert(params);
//            return;
        $.post(url, params, function(result) {
            var data = (result);
            if (data.billOfMaterialTemplateTemp){
                txtBillOfMaterialTemplateCode.val(data.billOfMaterialTemplateTemp.code);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.endUserCode").val(data.billOfMaterialTemplateTemp.endUserCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.endUserName").val(data.billOfMaterialTemplateTemp.endUserName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.valveTypeCode").val(data.billOfMaterialTemplateTemp.valveTypeCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.valveTypeName").val(data.billOfMaterialTemplateTemp.valveTypeName);
                //finishGoods
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBodyConstructionCode").val(data.billOfMaterialTemplateTemp.itemBodyConstructionCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBodyConstructionName").val(data.billOfMaterialTemplateTemp.itemBodyConstructionName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemTypeDesignCode").val(data.billOfMaterialTemplateTemp.itemTypeDesignCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemTypeDesignName").val(data.billOfMaterialTemplateTemp.itemTypeDesignName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSeatDesignCode").val(data.billOfMaterialTemplateTemp.itemSeatDesignCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSeatDesignName").val(data.billOfMaterialTemplateTemp.itemSeatDesignName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSizeCode").val(data.billOfMaterialTemplateTemp.itemSizeCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSizeName").val(data.billOfMaterialTemplateTemp.itemSizeName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemRatingCode").val(data.billOfMaterialTemplateTemp.itemRatingCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemRatingName").val(data.billOfMaterialTemplateTemp.itemRatingName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBoreCode").val(data.billOfMaterialTemplateTemp.itemBoreCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBoreName").val(data.billOfMaterialTemplateTemp.itemBoreName);
                
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemEndConCode").val(data.billOfMaterialTemplateTemp.itemEndConCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemEndConName").val(data.billOfMaterialTemplateTemp.itemEndConName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBodyCode").val(data.billOfMaterialTemplateTemp.itemBodyCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBodyName").val(data.billOfMaterialTemplateTemp.itemBodyName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBallCode").val(data.billOfMaterialTemplateTemp.itemBallCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBallName").val(data.billOfMaterialTemplateTemp.itemBallName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSeatCode").val(data.billOfMaterialTemplateTemp.itemSeatCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSeatName").val(data.billOfMaterialTemplateTemp.itemSeatName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSeatInsertCode").val(data.billOfMaterialTemplateTemp.itemSeatInsertCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSeatInsertName").val(data.billOfMaterialTemplateTemp.itemSeatInsertName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemStemCode").val(data.billOfMaterialTemplateTemp.itemStemCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemStemName").val(data.billOfMaterialTemplateTemp.itemStemName);
                
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSealCode").val(data.billOfMaterialTemplateTemp.itemSealCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSealName").val(data.billOfMaterialTemplateTemp.itemSealName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBoltCode").val(data.billOfMaterialTemplateTemp.itemBoltCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBoltName").val(data.billOfMaterialTemplateTemp.itemBoltName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemDiscCode").val(data.billOfMaterialTemplateTemp.itemDiscCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemDiscName").val(data.billOfMaterialTemplateTemp.itemDiscName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemPlatesCode").val(data.billOfMaterialTemplateTemp.itemPlatesCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemPlatesName").val(data.billOfMaterialTemplateTemp.itemPlatesName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemShaftCode").val(data.billOfMaterialTemplateTemp.itemShaftCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemShaftName").val(data.billOfMaterialTemplateTemp.itemShaftName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSpringCode").val(data.billOfMaterialTemplateTemp.itemSpringCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemSpringName").val(data.billOfMaterialTemplateTemp.itemSpringName);
                
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemArmPinCode").val(data.billOfMaterialTemplateTemp.itemSpringName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemArmPinName").val(data.billOfMaterialTemplateTemp.itemSpringName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBackseatCode").val(data.billOfMaterialTemplateTemp.itemBackseatCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemBackseatName").val(data.billOfMaterialTemplateTemp.itemBackseatName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemArmCode").val(data.billOfMaterialTemplateTemp.itemArmCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemArmName").val(data.billOfMaterialTemplateTemp.itemArmName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemHingePinCode").val(data.billOfMaterialTemplateTemp.itemHingePinCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemHingePinName").val(data.billOfMaterialTemplateTemp.itemHingePinName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemStopPinCode").val(data.billOfMaterialTemplateTemp.itemStopPinCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemStopPinName").val(data.billOfMaterialTemplateTemp.itemStopPinName);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemOperatorCode").val(data.billOfMaterialTemplateTemp.itemOperatorCode);
                $("#billOfMaterialTemplate\\.itemFinishGoods\\.itemOperatorName").val(data.billOfMaterialTemplateTemp.itemOperatorName);

            }
        });
    }
    
    function loadBomItemFinishGoodsDetail() {
        
        var url = "master/bill-of-material-template-get-detail";
        var params = "headerCode=" + txtBillOfMaterialTemplateCode.val();
        
        $.getJSON(url, params, function(data) {
            billOfMaterialTemplateItemDetailLastRowId = 0;

            for (var i=0; i<data.listBillOfMaterialTemplateDetail.length; i++) {
                billOfMaterialTemplateItemDetailLastRowId++;
                $("#billOfMaterialTemplateDetailInput_grid").jqGrid("addRowData", billOfMaterialTemplateItemDetailLastRowId, data.listBillOfMaterialTemplateDetail[i]);
                $("#billOfMaterialTemplateDetailInput_grid").jqGrid('setRowData',billOfMaterialTemplateItemDetailLastRowId,{
                    billOfMaterialTemplateDetailDelete              : "delete",
                    billOfMaterialTemplateDetailSortNo              : data.listBillOfMaterialTemplateDetail[i].sortNo,
                    billOfMaterialTemplateDetailPartNo              : data.listBillOfMaterialTemplateDetail[i].partNo,
                    billOfMaterialTemplateDetailPartCode            : data.listBillOfMaterialTemplateDetail[i].partCode,
                    billOfMaterialTemplateDetailPartName            : data.listBillOfMaterialTemplateDetail[i].partName,
                    billOfMaterialTemplateDetailDrawingCode         : data.listBillOfMaterialTemplateDetail[i].drawingCode,
                    billOfMaterialTemplateDetailDimension           : data.listBillOfMaterialTemplateDetail[i].dimension,
                    billOfMaterialTemplateDetailRequiredLength      : data.listBillOfMaterialTemplateDetail[i].requiredLength,
                    billOfMaterialTemplateDetailMaterial            : data.listBillOfMaterialTemplateDetail[i].material,
                    billOfMaterialTemplateDetailQuantity            : data.listBillOfMaterialTemplateDetail[i].quantity,
                    billOfMaterialTemplateDetailRequirement         : data.listBillOfMaterialTemplateDetail[i].requirement,
                    billOfMaterialTemplateDetailProcessedStatus     : data.listBillOfMaterialTemplateDetail[i].processedStatus,
                    billOfMaterialTemplateDetailActiveStatus        : data.listBillOfMaterialTemplateDetail[i].activeStatus,
                    billOfMaterialTemplateDetailX                   : data.listBillOfMaterialTemplateDetail[i].x
                });
            }
        });
    }
    
    function formatDateBillOfMaterialTemplate(){
        var transactionDate=formatDateBOM(dtpBillOfMaterialTemplateTransactionDate.val(),false);
        dtpBillOfMaterialTemplateTransactionDate.val(transactionDate); 
    }
    
    function handlers_input_production_planning_order(){
        
        if(txtBillOfMaterialTemplateBranchCode.val()===""){
            handlersInput(txtBillOfMaterialTemplateBranchCode);
        }else{
            unHandlersInput(txtBillOfMaterialTemplateBranchCode);
        }
     
    }
    
    function formatDateBOM(date, useTime) {
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
    
    function billOfMaterialTemplateDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#billOfMaterialTemplateDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#billOfMaterialTemplateDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        var data= $("#billOfMaterialTemplateDetailInput_grid").jqGrid('getRowData',lastRowId);
        
            $("#billOfMaterialTemplateDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#billOfMaterialTemplateDetailInput_grid").jqGrid('setRowData',lastRowId,{
                billOfMaterialTemplateDetailDelete          : defRow.billOfMaterialTemplateDetailDelete,
                billOfMaterialTemplateDetailPartCode        : defRow.billOfMaterialTemplateDetailPartCode,
                billOfMaterialTemplateDetailPartName        : defRow.billOfMaterialTemplateDetailPartName
            });
            
        setHeightGridHeader();
    }
    
    function setHeightGridHeader(){
        var ids = jQuery("#billOfMaterialTemplateDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#billOfMaterialTemplateDetailInput_grid"+" tr").eq(1).height();
            $("#billOfMaterialTemplateDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#billOfMaterialTemplateDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        } 
    }
    
    function avoidSpcCharTemplate(){
        
        var selectedRowID = $("#billOfMaterialTemplateDetailInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#billOfMaterialTemplateDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = billOfMaterialTemplateItemDetailLastRowId;
        }
        
        let str = $("#" + selectedRowID + "_billOfMaterialTemplateDetailRequiredLength").val(); 
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_billOfMaterialTemplateDetailRequiredLength").val("");
        }
        
        let str2 = $("#" + selectedRowID + "_billOfMaterialTemplateDetailQuantity").val();
        
        if (isNaN(str2)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_billOfMaterialTemplateDetailQuantity").val("");
        }
    }
</script>
<s:url id="remoteurlBillOfMaterialTemplateDetailInput" action="" />

<b>BILL OF MATERIAL TEMPLATE</b>
<hr>
<br class="spacer" />

<div id="billOfMaterialTemplateInput" class="content ui-widget">
    <s:form id="frmBillOfMaterialTemplateInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerBillOfMaterialTemplateInput">
            <tr>
                <td>
                    <table>
                        <tr>
                            <td align="right"><b>BOM Template No *</b></td>
                            <td><s:textfield id="billOfMaterialTemplate.code" name="billOfMaterialTemplate.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                            <sj:datepicker id="billOfMaterialTemplate.transactionDate" name="billOfMaterialTemplate.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Finish Goods *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">

                                    $('#billOfMaterialTemplate_btnItemFinishGoods').click(function(ev) {
                                        window.open("./pages/search/search-item-finish-goods.jsp?iddoc=billOfMaterialTemplate&idsubdoc=itemFinishGoods&idcustomer="+"","Search", "width=600, height=500");
                                    });

                                    txtBillOfMaterialTemplateItemFinishGoodsCode.change(function(ev) {

                                        var url = "master/item-finish-goods-get";
                                        var params = "itemFinishGoods.code=" + txtBillOfMaterialTemplateItemFinishGoodsCode.val();
                                        
                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.branchTemp){
                                                txtBillOfMaterialTemplateItemFinishGoodsCode.val(data.branchTemp.code);
                                            }
                                            else{
                                                alertMessage("Branch Not Found!",txtBillOfMaterialTemplateItemFinishGoodsCode);
                                                txtBillOfMaterialTemplateItemFinishGoodsCode.val("");
                                            }
                                        });
                                    });

                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="billOfMaterialTemplate.itemFinishGoods.code" name="billOfMaterialTemplate.itemFinishGoods.code" title="*" required="true" cssClass="required" size="30" readonly="true"></s:textfield>
                                    <sj:a id="billOfMaterialTemplate_btnItemFinishGoods" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">End User Code</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.endUserCode" name="billOfMaterialTemplate.itemFinishGoods.endUserCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.endUserName" name="billOfMaterialTemplate.itemFinishGoods.endUserName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Valve Type</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.valveTypeCode" name="billOfMaterialTemplate.itemFinishGoods.valveTypeCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.valveTypeName" name="billOfMaterialTemplate.itemFinishGoods.valveTypeName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Body Construction</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBodyConstructionCode" name="billOfMaterialTemplate.itemFinishGoods.itemBodyConstructionCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBodyConstructionName" name="billOfMaterialTemplate.itemFinishGoods.itemBodyConstructionName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Type Design</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemTypeDesignCode" name="billOfMaterialTemplate.itemFinishGoods.itemTypeDesignCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemTypeDesignName" name="billOfMaterialTemplate.itemFinishGoods.itemTypeDesignName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat Design</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSeatDesignCode" name="billOfMaterialTemplate.itemFinishGoods.itemSeatDesignCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSeatDesignName" name="billOfMaterialTemplate.itemFinishGoods.itemSeatDesignName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Size</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSizeCode" name="billOfMaterialTemplate.itemFinishGoods.itemSizeCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSizeName" name="billOfMaterialTemplate.itemFinishGoods.itemSizeName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Rating</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemRatingCode" name="billOfMaterialTemplate.itemFinishGoods.itemRatingCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemRatingName" name="billOfMaterialTemplate.itemFinishGoods.itemRatingName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Bore</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBoreCode" name="billOfMaterialTemplate.itemFinishGoods.itemBoreCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBoreName" name="billOfMaterialTemplate.itemFinishGoods.itemBoreName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">End Con</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemEndConCode" name="billOfMaterialTemplate.itemFinishGoods.itemEndConCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemEndConName" name="billOfMaterialTemplate.itemFinishGoods.itemEndConName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Body</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBodyCode" name="billOfMaterialTemplate.itemFinishGoods.itemBodyCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBodyName" name="billOfMaterialTemplate.itemFinishGoods.itemBodyName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ball</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBallCode" name="billOfMaterialTemplate.itemFinishGoods.itemBallCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBallName" name="billOfMaterialTemplate.itemFinishGoods.itemBallName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSeatCode" name="billOfMaterialTemplate.itemFinishGoods.itemSeatCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSeatName" name="billOfMaterialTemplate.itemFinishGoods.itemSeatName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat Insert</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSeatInsertCode" name="billOfMaterialTemplate.itemFinishGoods.itemSeatInsertCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSeatInsertName" name="billOfMaterialTemplate.itemFinishGoods.itemSeatInsertName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Stem</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemStemCode" name="billOfMaterialTemplate.itemFinishGoods.itemStemCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemStemName" name="billOfMaterialTemplate.itemFinishGoods.itemStemName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seal</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSealCode" name="billOfMaterialTemplate.itemFinishGoods.itemSealCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSealName" name="billOfMaterialTemplate.itemFinishGoods.itemSealName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Bolt</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBoltCode" name="billOfMaterialTemplate.itemFinishGoods.itemBoltCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBoltName" name="billOfMaterialTemplate.itemFinishGoods.itemBoltName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Disc</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemDiscCode" name="billOfMaterialTemplate.itemFinishGoods.itemDiscCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemDiscName" name="billOfMaterialTemplate.itemFinishGoods.itemDiscName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Plates</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemPlatesCode" name="billOfMaterialTemplate.itemFinishGoods.itemPlatesCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemPlatesName" name="billOfMaterialTemplate.itemFinishGoods.itemPlatesName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Shaft</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemShaftCode" name="billOfMaterialTemplate.itemFinishGoods.itemShaftCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemShaftName" name="billOfMaterialTemplate.itemFinishGoods.itemShaftName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Spring</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSpringCode" name="billOfMaterialTemplate.itemFinishGoods.itemSpringCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemSpringName" name="billOfMaterialTemplate.itemFinishGoods.itemSpringName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Arm Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemArmPinCode" name="billOfMaterialTemplate.itemFinishGoods.itemArmPinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemArmPinName" name="billOfMaterialTemplate.itemFinishGoods.itemArmPinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Back Seat</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBackseatCode" name="billOfMaterialTemplate.itemFinishGoods.itemBackseatCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemBackseatName" name="billOfMaterialTemplate.itemFinishGoods.itemBackseatName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Arm</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemArmCode" name="billOfMaterialTemplate.itemFinishGoods.itemArmCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemArmName" name="billOfMaterialTemplate.itemFinishGoods.itemArmName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Hinge Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemHingePinCode" name="billOfMaterialTemplate.itemFinishGoods.itemHingePinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemHingePinName" name="billOfMaterialTemplate.itemFinishGoods.itemHingePinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Stop Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemStopPinCode" name="billOfMaterialTemplate.itemFinishGoods.itemStopPinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemStopPinName" name="billOfMaterialTemplate.itemFinishGoods.itemStopPinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Operator</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemOperatorCode" name="billOfMaterialTemplate.itemFinishGoods.itemOperatorCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialTemplate.itemFinishGoods.itemOperatorName" name="billOfMaterialTemplate.itemFinishGoods.itemOperatorName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Remark</td>
                            <td colspan="3">
                                <s:textarea id="billOfMaterialTemplate.itemFinishGoods.remark" name="billOfMaterialTemplate.itemFinishGoods.remark" rows="3" cols="40" readonly="true"></s:textarea>
                            </td>
                        </tr>
                    </table>
                </td>
                
            
                <td valign="top">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                <sj:a href="#" id="btnBillOfMaterialTemplateDetailSearchPart" button="true" style="width: 100px">Search Part</sj:a>
                                <sj:a href="#" id="btnBillOfMaterialTemplateDetailSortNo" button="true" style="width: 100px">Re-Sorting</sj:a>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <sjg:grid
                                    id="billOfMaterialTemplateDetailInput_grid"
                                    caption="Bill Of Material Template Detail"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listBillOfMaterialTemplateDetail"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    width="800"
                                    editurl="%{remoteurlBillOfMaterialTemplateDetailInput}"
                                    onSelectRowTopics="billOfMaterialTemplateDetailInput_grid_onSelect"
                                >
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetail" index="billOfMaterialTemplateDetail" 
                                        title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                    />  
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailDelete" index="billOfMaterialTemplateDetailDelete" title="" width="50" align="centre"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'billOfMaterialTemplateDetailInputGrid_Delete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailSortNo" index="billOfMaterialTemplateDetailSortNo" key="billOfMaterialTemplateDetailSortNo" title="Sort No" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailPartNo" index="billOfMaterialTemplateDetailPartNo" key="billOfMaterialTemplateDetailPartNo" title="Part No" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailPartCode" index="billOfMaterialTemplateDetailPartCode" key="billOfMaterialTemplateDetailPartCode" title="Part Code" 
                                        width="80" align="right"  edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailPartName" index="billOfMaterialTemplateDetailPartName" key="billOfMaterialTemplateDetailPartName" title="Part Name" 
                                        width="80" align="right"  edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailDrawingCode" index="billOfMaterialTemplateDetailDrawingCode" key="billOfMaterialTemplateDetailDrawingCode" title="Drawing Code" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailDimension" index="billOfMaterialTemplateDetailDimension" key="billOfMaterialTemplateDetailDimension" title="Dimension" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailRequiredLength" index="billOfMaterialTemplateDetailRequiredLength" key="billOfMaterialTemplateDetailRequiredLength" title="Required Length" 
                                        width="80" align="right" editable="true" 
                                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                        editoptions="{onKeyUp:'avoidSpcCharTemplate()'}"
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailMaterial" index="billOfMaterialTemplateDetailMaterial" key="billOfMaterialTemplateDetailMaterial" title="Material" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailQuantity" index="billOfMaterialTemplateDetailQuantity" key="billOfMaterialTemplateDetailQuantity" title="Quantity" 
                                        width="80" align="right" editable="true"
                                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                        editoptions="{onKeyUp:'avoidSpcCharTemplate()'}"
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailRequirement" index="billOfMaterialTemplateDetailRequirement" key="billOfMaterialTemplateDetailRequirement" title="Requirement" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "billOfMaterialTemplateDetailProcessedStatus" index = "billOfMaterialTemplateDetailProcessedStatus" key = "billOfMaterialTemplateDetailProcessedStatus" title = "Processed Status" width = "150" 
                                        formatter="select" align="center" formoptions="{label:'Please Select'}"
                                        editable="true" edittype="select" editoptions="{value:'MACHINING:MACHINING;NON_MACHINING:NON_MACHINING',onChange:'refreshBillOfMaterialInputanGridByOthersProcessedStatus()'}" 
                                    />
                                    <sjg:gridColumn
                                        name = "billOfMaterialTemplateDetailActiveStatus" index = "billOfMaterialTemplateDetailActiveStatus" key = "billOfMaterialTemplateDetailActiveStatus" title = "Active Status" width = "100" 
                                        formatter="select" align="center" formoptions="{label:'Please Select'}"
                                        editable="true" edittype="select" editoptions="{value:'True:Yes;False:No',onChange:'refreshBillOfMaterialInputanGridByOthersActiveStatus()'}" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailRemark" index="billOfMaterialTemplateDetailRemark" key="billOfMaterialTemplateDetailRemark" title="Remark" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="billOfMaterialTemplateDetailX" index="billOfMaterialTemplateDetailX" key="billOfMaterialTemplateDetailX" title="X" 
                                        width="80" align="right" editable="true" edittype="text" 
                                    />
                                </sjg:grid >
                            </td>
                        </tr>
                        
                    </table>
                    <br class="spacer" />        
                    <table>
                        <tr>
                            <td align="right">Ref No</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialTemplate.refNo" name="billOfMaterialTemplate.refNo" size="27" title=" "></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Description</td>
                            <td colspan="3">
                                <s:textarea id="billOfMaterialTemplate.remark" name="billOfMaterialTemplate.remark" rows="3" cols="40"></s:textarea>
                            </td>
                        </tr>
                    </table>
                    <br class="spacer" />
                    <table>
                        <tr>
                            <td colspan="2">
                                <sj:a href="#" id="btnBillOfMaterialTemplateSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnBillOfMaterialTemplateCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td>
                                <s:textfield id="billOfMaterialTemplateUpdateMode" name="billOfMaterialTemplateUpdateMode"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>     
    </s:form>
</div>
    

