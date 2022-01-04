
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
    var BillOfMaterialApprovalTemplateDetailLastRowId = 0, BillOfMaterialApprovalTemplateDetailLastSelId = -1;
    var                                    
        txtBillOfMaterialApprovalCode = $("#billOfMaterialApproval\\.code"),
        dtpBillOfMaterialApprovalTransactionDate = $("#billOfMaterialApproval\\.transactionDate"),
        txtBillOfMaterialApprovalReasonCode = $("#billOfMaterialApproval\\.approvalReason\\.code"),
        txtBillOfMaterialApprovalReasonName = $("#billOfMaterialApproval\\.approvalReason\\.name"),
        txtBillOfMaterialApprovalRemark = $("#billOfMaterialApproval\\.approvalRemark");

    function enableExistingTemplateApproval(from){
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
 
        radioButtonCopyFromApproval();
        loadExistingBomCodeApprovalDetail();
        
        $('#billOfMaterialApprovalStatusRadAPPROVED').change(function(ev){
            $("#billOfMaterialApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('#billOfMaterialApprovalStatusRadREJECTED').change(function(ev){
            $("#billOfMaterialApproval\\.approvalStatus").val("REJECTED");
        });
        
        loadItemFinishGoodsDetail();
        
        $.subscribe("billOfMaterialApprovalItemDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#billOfMaterialApprovalDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==BillOfMaterialApprovalTemplateDetailLastSelId) {
                $('#billOfMaterialApprovalDetailInput_grid').jqGrid("saveRow",BillOfMaterialApprovalTemplateDetailLastSelId); 
                $('#billOfMaterialApprovalDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                BillOfMaterialApprovalTemplateDetailLastSelId=selectedRowID;
            }
            else{
                $('#billOfMaterialApprovalDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnBillOfMaterialApprovalSave').click(function(ev) {  
            handlers_input_bom_approval();
            
            if($("#billOfMaterialApproval\\.approvalStatus").val()==="PENDING"){
                alertMessage("Approval Status Must Be Filled");
                return;
            }

            formatDateBillOfMaterialApproval();
            var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Update Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>BOM No: '+$("#billOfMaterialApproval\\.code").val()+'<br/><br/>' +    
                    '</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "YES",
                                        click : function() {
                                            var url="engineering/bill-of-material-approval-save";
                                            var params = $("#frmBillOfMaterialApprovalInput").serialize();
                                            $.post(url, params, function(data) {
                                                $("#dlgLoading").dialog("close");
                                                if (data.error) {
                                                    formatDateIMApproval(); 
                                                    alert(data.errorMessage);
                                                    return;
                                                }
                                                alertMessage(data.message);
                                                closeLoading();
                                                var url = "engineering/bill-of-material-approval";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL_APPROVAL");
                                            });
                                            $(this).dialog("close");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");                                       
                                        }
                                    }]
                });
            ev.preventDefault();
            
        });
               
        $('#btnBillOfMaterialApprovalCancel').click(function(ev) {
            var url = "engineering/bill-of-material-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL_APPROVAL"); 
        });
       
    }); //EOF Ready
    
    function loadExistingBomCodeApprovalDetail() {
        
        var url = "engineering/bill-of-material-part-detail-approval-data";
        var params = "billOfMaterialCode=" + txtBillOfMaterialApprovalCode.val();
        
        $.getJSON(url, params, function(data) {
            BillOfMaterialApprovalTemplateDetailLastRowId = 0;

            for (var i=0; i<data.listBillOfMaterialApprovalPartDetail.length; i++) {
                BillOfMaterialApprovalTemplateDetailLastRowId++;
                $("#billOfMaterialApprovalDetailInput_grid").jqGrid("addRowData", BillOfMaterialApprovalTemplateDetailLastRowId, data.listBillOfMaterialApprovalPartDetail[i]);
                $("#billOfMaterialApprovalDetailInput_grid").jqGrid('setRowData',BillOfMaterialApprovalTemplateDetailLastRowId,{
                    billOfMaterialApprovalDetailDelete              : "delete",
                    billOfMaterialApprovalDetailDocumentDetailCode  : data.listBillOfMaterialApprovalPartDetail[i].code,
                    billOfMaterialApprovalDetailSortNo              : data.listBillOfMaterialApprovalPartDetail[i].sortNo,
                    billOfMaterialApprovalDetailPartNo              : data.listBillOfMaterialApprovalPartDetail[i].partNo,
                    billOfMaterialApprovalDetailPartCode            : data.listBillOfMaterialApprovalPartDetail[i].partCode,
                    billOfMaterialApprovalDetailPartName            : data.listBillOfMaterialApprovalPartDetail[i].partName,
                    billOfMaterialApprovalDetailDrawingCode         : data.listBillOfMaterialApprovalPartDetail[i].drawingCode,
                    billOfMaterialApprovalDetailRequiredLength      : data.listBillOfMaterialApprovalPartDetail[i].requiredLength,
                    billOfMaterialApprovalDetailDimension           : data.listBillOfMaterialApprovalPartDetail[i].dimension,
                    billOfMaterialApprovalDetailMaterial            : data.listBillOfMaterialApprovalPartDetail[i].material,
                    billOfMaterialApprovalDetailQuantity            : data.listBillOfMaterialApprovalPartDetail[i].quantity,
                    billOfMaterialApprovalDetailRequirement         : data.listBillOfMaterialApprovalPartDetail[i].requirement,
                    billOfMaterialApprovalDetailProcessedStatus     : data.listBillOfMaterialApprovalPartDetail[i].processedStatus,
                    billOfMaterialApprovalDetailX                   : data.listBillOfMaterialApprovalPartDetail[i].x,
                    billOfMaterialApprovalDetailRevNo               : data.listBillOfMaterialApprovalPartDetail[i].revNo
                });
            }
        });
    }
    
    function setHeightGridHeader(){
        var ids = jQuery("#billOfMaterialApprovalDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#billOfMaterialApprovalDetailInput_grid"+" tr").eq(1).height();
            $("#billOfMaterialApprovalDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#billOfMaterialApprovalDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function loadItemFinishGoodsDetail(){
            
        var code = $('#billOfMaterialApproval\\.itemFinishGoods\\.code').val();
        var url = "master/item-finish-goods-get-data";
        var params = "itemFinishGoods.code=" + code;

        $.post(url, params, function(result) {
            var data = (result);
            if (data.itemFinishGoodsTemp){
                
                $("#billOfMaterialApproval\\.customerCode").val(data.itemFinishGoodsTemp.customerCode);
                $("#billOfMaterialApproval\\.customerName").val(data.itemFinishGoodsTemp.customerName);
                $("#billOfMaterialApproval\\.valveTypeCode").val(data.itemFinishGoodsTemp.valveTypeCode);
                $("#billOfMaterialApproval\\.valveTypeName").val(data.itemFinishGoodsTemp.valveTypeName);
                //finishGoods
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyConstructionCode").val(data.itemFinishGoodsTemp.itemBodyConstructionCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyConstructionName").val(data.itemFinishGoodsTemp.itemBodyConstructionName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemTypeDesignCode").val(data.itemFinishGoodsTemp.itemTypeDesignCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemTypeDesignName").val(data.itemFinishGoodsTemp.itemTypeDesignName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatDesignCode").val(data.itemFinishGoodsTemp.itemSeatDesignCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatDesignName").val(data.itemFinishGoodsTemp.itemSeatDesignName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSizeCode").val(data.itemFinishGoodsTemp.itemSizeCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSizeName").val(data.itemFinishGoodsTemp.itemSizeName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemRatingCode").val(data.itemFinishGoodsTemp.itemRatingCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemRatingName").val(data.itemFinishGoodsTemp.itemRatingName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoreCode").val(data.itemFinishGoodsTemp.itemBoreCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoreName").val(data.itemFinishGoodsTemp.itemBoreName);
                
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemEndConCode").val(data.itemFinishGoodsTemp.itemEndConCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemEndConName").val(data.itemFinishGoodsTemp.itemEndConName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyCode").val(data.itemFinishGoodsTemp.itemBodyCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyName").val(data.itemFinishGoodsTemp.itemBodyName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBallCode").val(data.itemFinishGoodsTemp.itemBallCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBallName").val(data.itemFinishGoodsTemp.itemBallName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatCode").val(data.itemFinishGoodsTemp.itemSeatCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatName").val(data.itemFinishGoodsTemp.itemSeatName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatInsertCode").val(data.itemFinishGoodsTemp.itemSeatInsertCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatInsertName").val(data.itemFinishGoodsTemp.itemSeatInsertName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStemCode").val(data.itemFinishGoodsTemp.itemStemCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStemName").val(data.itemFinishGoodsTemp.itemStemName);
                
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSealCode").val(data.itemFinishGoodsTemp.itemSealCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSealName").val(data.itemFinishGoodsTemp.itemSealName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoltCode").val(data.itemFinishGoodsTemp.itemBoltCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoltName").val(data.itemFinishGoodsTemp.itemBoltName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemDiscCode").val(data.itemFinishGoodsTemp.itemDiscCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemDiscName").val(data.itemFinishGoodsTemp.itemDiscName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemPlatesCode").val(data.itemFinishGoodsTemp.itemPlatesCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemPlatesName").val(data.itemFinishGoodsTemp.itemPlatesName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemShaftCode").val(data.itemFinishGoodsTemp.itemShaftCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemShaftName").val(data.itemFinishGoodsTemp.itemShaftName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSpringCode").val(data.itemFinishGoodsTemp.itemSpringCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSpringName").val(data.itemFinishGoodsTemp.itemSpringName);
                
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmPinCode").val(data.itemFinishGoodsTemp.itemSpringName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmPinName").val(data.itemFinishGoodsTemp.itemSpringName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBackseatCode").val(data.itemFinishGoodsTemp.itemBackseatCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBackseatName").val(data.itemFinishGoodsTemp.itemBackseatName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmCode").val(data.itemFinishGoodsTemp.itemArmCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmName").val(data.itemFinishGoodsTemp.itemArmName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemHingePinCode").val(data.itemFinishGoodsTemp.itemHingePinCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemHingePinName").val(data.itemFinishGoodsTemp.itemHingePinName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStopPinCode").val(data.itemFinishGoodsTemp.itemStopPinCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStopPinName").val(data.itemFinishGoodsTemp.itemStopPinName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemOperatorCode").val(data.itemFinishGoodsTemp.itemOperatorCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemOperatorName").val(data.itemFinishGoodsTemp.itemOperatorName);

            }
        });
    }
    
    function radioButtonCopyFromApproval(){
        if ($("#billOfMaterialApproval\\.copyFrom").val()==="BOM"){
            $('#billOfMaterialApprovalCopyFromRadExisting\\ BOM').prop('checked',true);
            $('#billOfMaterialApprovalCopyFromRadTemplate').attr('disabled',true);
            enableExistingTemplateApproval("BOM");
        }else{
            $('#billOfMaterialApprovalCopyFromRadTemplate').prop('checked',true);
            $('#billOfMaterialApprovalCopyFromRadExisting\\ BOM').attr('disabled',true);
            enableExistingTemplateApproval("Template");
        }
    }
    
    function formatDateBillOfMaterialApproval(){
        var transactionDateSplit=dtpBillOfMaterialApprovalTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpBillOfMaterialApprovalTransactionDate.val(transactionDate);
    }
    
    function handlers_input_bom_approval(){
        if($("#billOfMaterialApproval\\.approvalStatus").val()==="PENDING"){
            handlersInput($("#billOfMaterialApproval\\.approvalStatus"));
        }else{
            unHandlersInput($("#billOfMaterialApproval\\.approvalStatus"));
        }
    }
</script>
<s:url id="remoteurlBillOfMaterialApprovalDetailInput" action="" />

<b>BILL OF MATERIAL (ENGINEERING)</b>
<hr>
<br class="spacer" />

<div id="billOfMaterialApprovalInput" class="content ui-widget">
    <s:form id="frmBillOfMaterialApprovalInput">
        <table width="100%" id="headerBillOfMaterialApprovalInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right" width="100px">Code </td>
                            <td><s:textfield id="billOfMaterialApproval.code" name="billOfMaterialApproval.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">BOM No </td>
                            <td><s:textfield id="billOfMaterialApproval.bomNo" name="billOfMaterialApproval.bomNo" title="*" required="true" cssClass="required" maxLength="45" readonly="true" ></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Transaction Date </td>
                            <td><sj:datepicker id="billOfMaterialApproval.transactionDate" name="billOfMaterialApproval.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" readonly="true" disabled="true" ></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">DOC No</td>
                            <td><s:textfield id="billOfMaterialApproval.documentOrderCode" name="billOfMaterialApproval.documentOrderCode" title="*" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr hidden="true">
                            <td align="right" width="100px">DOC Detail Code</td>
                            <td><s:textfield id="billOfMaterialApproval.documentDetailCode" name="billOfMaterialApproval.documentDetailCode" title="*" maxLength="45" size="41" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">DOC Date</td>
                            <td><sj:datepicker id="billOfMaterialApproval.transactionDateDoc" name="billOfMaterialApproval.transactionDateDoc" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" disabled="true" readonly="true"></sj:datepicker></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">DOC Type</td>
                            <td><s:textfield id="billOfMaterialApproval.documentType" name="billOfMaterialApproval.documentType" title="*" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Revision</td>
                            <td>
                                <s:textfield id="billOfMaterialApproval.revision" name="billOfMaterialApproval.revision" key="billOfMaterialApproval.revision" readonly="true" size="5"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Item Finish Goods</td>
                            <td><s:textfield id="billOfMaterialApproval.itemFinishGoods.code" name="billOfMaterialApproval.itemFinishGoods.code" title="*" maxLength="45" size="41" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Valve Type</td>
                            <td>
                                <s:textfield id="billOfMaterialApproval.valveTypeCode" name="billOfMaterialApproval.valveTypeCode" title="*" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.valveTypeName" name="billOfMaterialApproval.valveTypeName" title="*" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="100px">Customer</td>
                            <td>
                                <s:textfield id="billOfMaterialApproval.customerCode" name="billOfMaterialApproval.customerCode" title="*" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.customerName" name="billOfMaterialApproval.customerName" title="*" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Drawing No </td>
                            <td><s:textfield id="billOfMaterialApproval.drawingCode" name="billOfMaterialApproval.drawingCode" size="15" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Copy From
                            <s:textfield id="billOfMaterialApproval.copyFrom" name="billOfMaterialApproval.copyFrom" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="billOfMaterialApprovalCopyFromRad" name="billOfMaterialApprovalCopyFromRad" list="{'Existing BOM','Template'}"></s:radio></td>                    
                        </tr>
                        <tr class="existingBom">
                            <td align="right">Existing BOM </td>
                            <td colspan="2">
                                <s:textfield id="billOfMaterialApproval.existingBomCode" name="billOfMaterialApproval.existingBomCode" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr class="templateBom">
                            <td align="right">Template </td>
                            <td colspan="2">
                                <s:textfield id="billOfMaterialApproval.template" name="billOfMaterialApproval.template" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark </td>
                            <td><s:textarea id="billOfMaterialApproval.remark" name="billOfMaterialApproval.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Internal Note </td>
                            <td><s:textarea id="billOfMaterialApproval.internalNote" name="billOfMaterialApproval.internalNote" cols="53" rows="3" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Approval Status *</B></td>
                            <s:textfield id="billOfMaterialApproval.approvalStatus" name="billOfMaterialApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                            <td><s:radio id="billOfMaterialApprovalStatusRad" name="billOfMaterialApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Approval Reason</td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                $('#billOfMaterialApproval_btnReason').click(function(ev) {
                                    window.open("./pages/search/search-reason.jsp?iddoc=billOfMaterialApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                                });

                                txtBillOfMaterialApprovalReasonCode.change(function(ev) {

                                    if(txtBillOfMaterialApprovalReasonCode.val()===""){
                                        txtBillOfMaterialApprovalReasonCode.val("");
                                        txtBillOfMaterialApprovalReasonName.val("");
                                               return;
                                            }
                                    var url = "master/reason-get";
                                    var params = "reason.code=" + txtBillOfMaterialApprovalReasonCode.val();
                                        params += "&reason.activeStatus=TRUE";
                                        alert(params);
                                        return;
                                            $.post(url, params, function(result) {
                                                var data = (result);
                                        if (data.reasonTemp){
                                            txtBillOfMaterialApprovalReasonCode.val(data.reasonTemp.code);
                                            txtBillOfMaterialApprovalReasonName.val(data.reasonTemp.name);
                                        }
                                        else{
                                            alertMessage("Reason Not Found!",txtBillOfMaterialApprovalReasonCode);
                                            txtBillOfMaterialApprovalReasonCode.val("");
                                            txtBillOfMaterialApprovalReasonName.val("");
                                        }
                                            });
                                        });
                                </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="billOfMaterialApproval.approvalReason.code" name="billOfMaterialApproval.approvalReason.code" size="15"></s:textfield>
                                    <sj:a id="billOfMaterialApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="billOfMaterialApproval.approvalReason.name" name="billOfMaterialApproval.approvalReason.name" size="25" readonly="true"></s:textfield>
                            </td>    
                        </tr>
                        <tr>
                            <td align="right" valign="top">Approval Remark</td>
                            <td colspan="3">
                                <s:textarea id="billOfMaterialApproval.approvalRemark" name="billOfMaterialApproval.approvalRemark"  cols="40" rows="2" height="30" readonly="false"></s:textarea>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td align="right">Body Construction</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionCode" name="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionName" name="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Type Design</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemTypeDesignCode" name="billOfMaterialApproval.itemFinishGoods.itemTypeDesignCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemTypeDesignName" name="billOfMaterialApproval.itemFinishGoods.itemTypeDesignName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat Design</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatDesignCode" name="billOfMaterialApproval.itemFinishGoods.itemSeatDesignCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatDesignName" name="billOfMaterialApproval.itemFinishGoods.itemSeatDesignName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Size</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSizeCode" name="billOfMaterialApproval.itemFinishGoods.itemSizeCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSizeName" name="billOfMaterialApproval.itemFinishGoods.itemSizeName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Rating</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemRatingCode" name="billOfMaterialApproval.itemFinishGoods.itemRatingCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemRatingName" name="billOfMaterialApproval.itemFinishGoods.itemRatingName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Bore</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoreCode" name="billOfMaterialApproval.itemFinishGoods.itemBoreCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoreName" name="billOfMaterialApproval.itemFinishGoods.itemBoreName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">End Con</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemEndConCode" name="billOfMaterialApproval.itemFinishGoods.itemEndConCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemEndConName" name="billOfMaterialApproval.itemFinishGoods.itemEndConName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Body</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyCode" name="billOfMaterialApproval.itemFinishGoods.itemBodyCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyName" name="billOfMaterialApproval.itemFinishGoods.itemBodyName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ball</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBallCode" name="billOfMaterialApproval.itemFinishGoods.itemBallCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBallName" name="billOfMaterialApproval.itemFinishGoods.itemBallName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatCode" name="billOfMaterialApproval.itemFinishGoods.itemSeatCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatName" name="billOfMaterialApproval.itemFinishGoods.itemSeatName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seat Insert</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatInsertCode" name="billOfMaterialApproval.itemFinishGoods.itemSeatInsertCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatInsertName" name="billOfMaterialApproval.itemFinishGoods.itemSeatInsertName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Stem</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStemCode" name="billOfMaterialApproval.itemFinishGoods.itemStemCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStemName" name="billOfMaterialApproval.itemFinishGoods.itemStemName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Seal</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSealCode" name="billOfMaterialApproval.itemFinishGoods.itemSealCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSealName" name="billOfMaterialApproval.itemFinishGoods.itemSealName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Bolt</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoltCode" name="billOfMaterialApproval.itemFinishGoods.itemBoltCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoltName" name="billOfMaterialApproval.itemFinishGoods.itemBoltName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Disc</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemDiscCode" name="billOfMaterialApproval.itemFinishGoods.itemDiscCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemDiscName" name="billOfMaterialApproval.itemFinishGoods.itemDiscName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Plates</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemPlatesCode" name="billOfMaterialApproval.itemFinishGoods.itemPlatesCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemPlatesName" name="billOfMaterialApproval.itemFinishGoods.itemPlatesName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Shaft</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemShaftCode" name="billOfMaterialApproval.itemFinishGoods.itemShaftCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemShaftName" name="billOfMaterialApproval.itemFinishGoods.itemShaftName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Spring</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSpringCode" name="billOfMaterialApproval.itemFinishGoods.itemSpringCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSpringName" name="billOfMaterialApproval.itemFinishGoods.itemSpringName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Arm Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmPinCode" name="billOfMaterialApproval.itemFinishGoods.itemArmPinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmPinName" name="billOfMaterialApproval.itemFinishGoods.itemArmPinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Back Seat</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBackseatCode" name="billOfMaterialApproval.itemFinishGoods.itemBackseatCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBackseatName" name="billOfMaterialApproval.itemFinishGoods.itemBackseatName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Arm</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmCode" name="billOfMaterialApproval.itemFinishGoods.itemArmCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmName" name="billOfMaterialApproval.itemFinishGoods.itemArmName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Hinge Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemHingePinCode" name="billOfMaterialApproval.itemFinishGoods.itemHingePinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemHingePinName" name="billOfMaterialApproval.itemFinishGoods.itemHingePinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Stop Pin</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStopPinCode" name="billOfMaterialApproval.itemFinishGoods.itemStopPinCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStopPinName" name="billOfMaterialApproval.itemFinishGoods.itemStopPinName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Operator</td>
                            <td colspan="3">
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemOperatorCode" name="billOfMaterialApproval.itemFinishGoods.itemOperatorCode" size="27" title=" " readonly="true"></s:textfield>
                                <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemOperatorName" name="billOfMaterialApproval.itemFinishGoods.itemOperatorName" size="27" title=" " readonly="true"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        
        <table width="100%">
            <tr>
                <td>
                    <sjg:grid
                        id="billOfMaterialApprovalDetailInput_grid"
                        caption="Bill Of Material Template Detail"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listBillOfMaterialApprovalDetail"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        editinline="true"
                        width="$('#tabmnuBillOfMaterialApprovalDetail').width()"
                        editurl="%{remoteurlBillOfMaterialApprovalDetailInput}"
                        onSelectRowTopics="billOfMaterialApprovalItemDetailInput_grid_onSelect"
                    >
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetail" index="billOfMaterialApprovalDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailDocumentDetailCode" index="billOfMaterialApprovalDetailDocumentDetailCode" key="billOfMaterialApprovalDetailDocumentDetailCode" title="Document Detail" 
                            width="80" align="right" editable="true" edittype="text" hidden="true"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailSortNo" index="billOfMaterialApprovalDetailSortNo" key="billOfMaterialApprovalDetailSortNo" title="Sort No" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailPartNo" index="billOfMaterialApprovalDetailPartNo" key="billOfMaterialApprovalDetailPartNo" title="Part No" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailPartCode" index="billOfMaterialApprovalDetailPartCode" key="billOfMaterialApprovalDetailPartCode" title="Part Code" 
                            width="80" align="right"  edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailPartName" index="billOfMaterialApprovalDetailPartName" key="billOfMaterialApprovalDetailPartName" title="Part Name" 
                            width="80" align="right"  edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailDrawingCode" index="billOfMaterialApprovalDetailDrawingCode" key="billOfMaterialApprovalDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailDimension" index="billOfMaterialApprovalDetailDimension" key="billOfMaterialApprovalDetailDimension" title="Dimension" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailRequiredLength" index="billOfMaterialApprovalDetailRequiredLength" key="billOfMaterialApprovalDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailMaterial" index="billOfMaterialApprovalDetailMaterial" key="billOfMaterialApprovalDetailMaterial" title="Material" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailQuantity" index="billOfMaterialApprovalDetailQuantity" key="billOfMaterialApprovalDetailQuantity" title="Quantity" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailRequirement" index="billOfMaterialApprovalDetailRequirement" key="billOfMaterialApprovalDetailRequirement" title="Requirement" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name = "billOfMaterialApprovalDetailProcessedStatus" index = "billOfMaterialApprovalDetailProcessedStatus" key = "billOfMaterialApprovalDetailProcessedStatus" title = "Processed Status" width = "100" 
                            formatter="select" align="center" formoptions="{label:'Please Select'}"
                            editable="false" edittype="select" editoptions="{value:'MACHINING:MACHINING;NON_MACHINING:NON_MACHINING',onChange:'refreshBillOfMaterialApprovalInputanGridByOthersProcessedStatus()'}" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailRemark" index="billOfMaterialApprovalDetailRemark" key="billOfMaterialApprovalDetailRemark" title="Remark" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailX" index="billOfMaterialApprovalDetailX" key="billOfMaterialApprovalDetailX" title="X" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="billOfMaterialApprovalDetailRevNo" index="billOfMaterialApprovalDetailRevNo" key="billOfMaterialApprovalDetailRevNo" title="Rev No" 
                            width="80" align="right" editable="false" edittype="text" 
                        />
                    </sjg:grid >
                </td>
            </tr>
        </table>
        <br class="spacer" />      
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnBillOfMaterialApprovalSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnBillOfMaterialApprovalCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>
                
                
    </s:form>
</div>
    

