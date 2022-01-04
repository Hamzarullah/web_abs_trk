
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
    var productionPlanningOrderApprovalItemDetailLastRowId = 0, productionPlanningOrderApprovalItemDetailLastSel = -1;
    var                                    
        txtProductionPlanningOrderApprovalCode = $("#productionPlanningOrderApproval\\.code"),
        dtpProductionPlanningOrderApprovalTransactionDate = $("#productionPlanningOrderApproval\\.transactionDate"),
        dtpProductionPlanningOrderApprovalTargetDate = $("#productionPlanningOrderApproval\\.targetDate"),
        txtProductionPlanningOrderApprovalBranchCode = $("#productionPlanningOrderApproval\\.branch\\.code"),
        txtProductionPlanningOrderApprovalBranchName = $("#productionPlanningOrderApproval\\.branch\\.name"),
        txtProductionPlanningOrderApprovalDocumentCode = $("#productionPlanningOrderApproval\\.documentCode"),
        txtProductionPlanningOrderApprovalCustomerCode = $("#productionPlanningOrderApproval\\.customer\\.code"),
        txtProductionPlanningOrderApprovalCustomerName = $("#productionPlanningOrderApproval\\.customer\\.name");
        txtproductionPlanningOrderApprovalReasonCode = $("#productionPlanningOrderApproval\\.reason\\.code"),
        txtproductionPlanningOrderApprovalReasonName = $("#productionPlanningOrderApproval\\.reason\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedPPOOptions=false;
        flagIsConfirmedPPO=false;
        hoverButton();
        
        //Set Default View Approval
//        if($("#productionPlanningOrderApprovalUpdateMode").val() === 'true'){

            var documentType = $("#productionPlanningOrderApproval\\.documentType").val();
            if(documentType === 'SO'){
                $('#productionPlanningOrderApprovalDocumentTypeRadSO').prop('checked',true);
                $('#productionPlanningOrderApprovalDocumentTypeRadBO').prop('disabled',true);
                $('#productionPlanningOrderApprovalDocumentTypeRadIM').prop('disabled',true);
            }else if(documentType === 'BO'){
                $('#productionPlanningOrderApprovalDocumentTypeRadBO').prop('checked',true);
                $('#productionPlanningOrderApprovalDocumentTypeRadSO').prop('disabled',true);
                $('#productionPlanningOrderApprovalDocumentTypeRadIM').prop('disabled',true);
            }else{
                $('#productionPlanningOrderApprovalDocumentTypeRadIM').prop('checked',true);
                $('#productionPlanningOrderApprovalDocumentTypeRadBO').prop('disabled',true);
                $('#productionPlanningOrderApprovalDocumentTypeRadSO').prop('disabled',true);
            }
            loadApprovalDataProductionPlanningOrderApprovalDocumentItemDetail();
//        }
        
        //Set Default View
        $('input[name="productionPlanningOrderApprovalDocumentTypeRad"][value="SO"]').change(function(ev){
            $("#productionPlanningOrderApproval\\.documentType").val("SO");
        });
                
        $('input[name="productionPlanningOrderApprovalDocumentTypeRad"][value="BO"]').change(function(ev){
            $("#productionPlanningOrderApproval\\.documentType").val("BO");
        });
        
        $('input[name="productionPlanningOrderApprovalDocumentTypeRad"][value="IM"]').change(function(ev){
            $("#productionPlanningOrderApproval\\.documentType").val("IM");
        });
        //RDB Approved Status
        $('input[name="productionPlanningOrderApprovalApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#productionPlanningOrderApproval\\.approvalStatus").val(value);
        });
         $('input[name="productionPlanningOrderApprovalApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#productionPlanningOrderApproval\\.approvalStatus").val(value);
        });
        
        $('#btnProductionPlanningOrderApprovalSave').click(function(ev) {
            
            if ($("#productionPlanningOrderApproval\\.approvalStatus").val()==="PENDING"){
                 alertMessage("Please choose one Approval Status");
                 return;
            }  
            
            formatDateProductionPlanningOrderApproval();
            var url="ppic/production-planning-order-approval-save";
            var params = $("#frmProductionPlanningOrderApprovalInput").serialize();
            $.post(url, params, function(data) {
                $("#dlgLoading").dialog("close");
                if (data.error) {
                    formatDateProductionPlanningOrderApproval(); 
                    alert(data.errorMessage);
                    return;
                }
                closeLoading();
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
                                            var url = "ppic/production-planning-order-approval";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER_APPROVAL");
                                        }
                                    }]
                });
            });
            
            
        });
               
        $('#btnProductionPlanningOrderApprovalCancel').click(function(ev) {
            var url = "purchasing/production-planning-order-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER_APPROVAL"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("ProductionPlanningOrderApprovalItemDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==productionPlanningOrderApprovalItemDetailLastSel) {
                $('#productionPlanningOrderApprovalItemDetailInput_grid').jqGrid("saveRow",productionPlanningOrderApprovalItemDetailLastSel); 
                $('#productionPlanningOrderApprovalItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                productionPlanningOrderApprovalItemDetailLastSel=selectedRowID;
            }
            else{
                $('#productionPlanningOrderApprovalItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
    }); //EOF Ready
    
    function setProductionPlanningOrderApprovalDocumentType(){
        switch($("#productionPlanningOrderApproval\\.documentType").val()){
            case "SO":
                $('input[name="productionPlanningOrderApprovalDocumentRad"][value="YES"]').prop('checked',true);
                break;
            case "BO":
                $('input[name="productionPlanningOrderApprovalDocumentRad"][value="NO"]').prop('checked',true);
                break;
            case "IM":
                $('input[name="productionPlanningOrderApprovalDocumentRad"][value="IM"]').prop('checked',true);
                break;
        } 
    }
    
    function loadApprovalDataProductionPlanningOrderApprovalDocumentItemDetail() {
        
        var url = "ppic/production-planning-order-approval-detail-data";
        var params = "productionPlanningOrderApproval.documentType=" + $('#productionPlanningOrderApproval\\.documentType') .val();
            params += "&productionPlanningOrderApproval.code=" + txtProductionPlanningOrderApprovalCode.val();
//        alert(params);
        $.getJSON(url, params, function(data) {
            productionPlanningOrderApprovalItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listProductionPlanningOrderApprovalItemDetail.length; i++) {
                productionPlanningOrderApprovalItemDetailLastRowId++;
                $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid("addRowData", productionPlanningOrderApprovalItemDetailLastRowId, data.listProductionPlanningOrderApprovalItemDetail[i]);
                $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid('setRowData',productionPlanningOrderApprovalItemDetailLastRowId,{
                    
                    productionPlanningOrderApprovalItemDetailDocumentDetailCode             : data.listProductionPlanningOrderApprovalItemDetail[i].documentDetailCode,
                    productionPlanningOrderApprovalItemDetailSortNo                         : data.listProductionPlanningOrderApprovalItemDetail[i].documentSortNo,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsCode            : data.listProductionPlanningOrderApprovalItemDetail[i].itemFinishGoodsCode,
                    productionPlanningOrderApprovalItemDetailBillOfMaterialCode             : data.listProductionPlanningOrderApprovalItemDetail[i].billOfMaterialCode,
                    productionPlanningOrderApprovalItemDetailValveTag                       : data.listProductionPlanningOrderApprovalItemDetail[i].valveTag,
                    productionPlanningOrderApprovalItemDetailDataSheet                      : data.listProductionPlanningOrderApprovalItemDetail[i].dataSheet,
                    productionPlanningOrderApprovalItemDetailDescription                    : data.listProductionPlanningOrderApprovalItemDetail[i].description,
                    
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstCode   : data.listProductionPlanningOrderApprovalItemDetail[i].itemBodyConstructionCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstName   : data.listProductionPlanningOrderApprovalItemDetail[i].itemBodyConstructionName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignCode  : data.listProductionPlanningOrderApprovalItemDetail[i].itemTypeDesignCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignName  : data.listProductionPlanningOrderApprovalItemDetail[i].itemTypeDesignName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignCode  : data.listProductionPlanningOrderApprovalItemDetail[i].itemSeatDesignCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignName  : data.listProductionPlanningOrderApprovalItemDetail[i].itemSeatDesignName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemSizeCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemSizeName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingCode      : data.listProductionPlanningOrderApprovalItemDetail[i].itemRatingCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingName      : data.listProductionPlanningOrderApprovalItemDetail[i].itemRatingName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBoreCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBoreName,
                    
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConCode      : data.listProductionPlanningOrderApprovalItemDetail[i].itemEndConCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConName      : data.listProductionPlanningOrderApprovalItemDetail[i].itemEndConName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBodyCode,   
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBodyName,   
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBallCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBallCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBallName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBallName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemSeatCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemSeatName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertCode  : data.listProductionPlanningOrderApprovalItemDetail[i].itemSeatInsertCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertName  : data.listProductionPlanningOrderApprovalItemDetail[i].itemSeatInsertName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsStemCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemStemCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsStemName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemStemName,
                    
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSealCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemSealCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSealName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemSealName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBoltCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemBoltName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscCode        : data.listProductionPlanningOrderApprovalItemDetail[i].itemDiscCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscName        : data.listProductionPlanningOrderApprovalItemDetail[i].itemDiscName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesCode      : data.listProductionPlanningOrderApprovalItemDetail[i].itemPlatesCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesName      : data.listProductionPlanningOrderApprovalItemDetail[i].itemPlatesName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftCode       : data.listProductionPlanningOrderApprovalItemDetail[i].itemShaftCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftName       : data.listProductionPlanningOrderApprovalItemDetail[i].itemShaftName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringCode      : data.listProductionPlanningOrderApprovalItemDetail[i].itemSpringCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringName      : data.listProductionPlanningOrderApprovalItemDetail[i].itemSpringName,
                    
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinCode      : data.listProductionPlanningOrderApprovalItemDetail[i].itemArmPinCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinName      : data.listProductionPlanningOrderApprovalItemDetail[i].itemArmPinName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatCode    : data.listProductionPlanningOrderApprovalItemDetail[i].itemBackSeatCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatName    : data.listProductionPlanningOrderApprovalItemDetail[i].itemBackSeatName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsArmCode         : data.listProductionPlanningOrderApprovalItemDetail[i].itemArmCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsArmName         : data.listProductionPlanningOrderApprovalItemDetail[i].itemArmName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinCode    : data.listProductionPlanningOrderApprovalItemDetail[i].itemHingePinCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinName    : data.listProductionPlanningOrderApprovalItemDetail[i].itemHingePinName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinCode     : data.listProductionPlanningOrderApprovalItemDetail[i].itemStopPinCode,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinName     : data.listProductionPlanningOrderApprovalItemDetail[i].itemStopPinName,
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorCode    : data.listProductionPlanningOrderApprovalItemDetail[i].itemOperatorCode, 
                    productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorName    : data.listProductionPlanningOrderApprovalItemDetail[i].itemOperatorName, 
                    
                    productionPlanningOrderApprovalItemDetailOrderQuantity                  : data.listProductionPlanningOrderApprovalItemDetail[i].orderQuantity,
                    productionPlanningOrderApprovalItemDetailProcessedQuantity              : data.listProductionPlanningOrderApprovalItemDetail[i].processedQty,
                    productionPlanningOrderApprovalItemDetailBalanceQuantity                : data.listProductionPlanningOrderApprovalItemDetail[i].balancedQty,
                    productionPlanningOrderApprovalItemDetailQuantity                       : data.listProductionPlanningOrderApprovalItemDetail[i].quantity
                });
            }
        });
    }
    
    // function Grid Detail
    function setHeightGridProductionPlanningOrderApprovalItemDetail(){
        var ids = jQuery("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#productionPlanningOrderApprovalItemDetailInput_grid"+" tr").eq(1).height();
            $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function productionPlanningOrderApprovalItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#productionPlanningOrderApprovalItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridProductionPlanningOrderApprovalItemDetail();
    } 
    
    function formatDateProductionPlanningOrderApproval(){
        var transactionDate=formatDatePPO(dtpProductionPlanningOrderApprovalTransactionDate.val(),false);
        dtpProductionPlanningOrderApprovalTransactionDate.val(transactionDate);  
        var targetDate=formatDatePPO(dtpProductionPlanningOrderApprovalTargetDate.val(),false);
        dtpProductionPlanningOrderApprovalTargetDate.val(targetDate);  
    }
    
    function handlers_input_production_planning_order(){
        
        if(txtProductionPlanningOrderApprovalBranchCode.val()===""){
            handlersInput(txtProductionPlanningOrderApprovalBranchCode);
        }else{
            unHandlersInput(txtProductionPlanningOrderApprovalBranchCode);
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
<s:url id="remotedetailurlProductionPlanningOrderApprovalItemDetailInput" action="" />

<b>PRODUCTION PLANNING ORDER APPROVAL</b>
<hr>
<br class="spacer" />

<div id="productionPlanningOrderApprovalInput" class="content ui-widget">
    <s:form id="frmProductionPlanningOrderApprovalInput">
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td align="right" width="100px"><b>PPO No *</b></td>
                            <td><s:textfield id="productionPlanningOrderApproval.code" name="productionPlanningOrderApproval.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="productionPlanningOrderApproval.branch.code" name="productionPlanningOrderApproval.branch.code" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="productionPlanningOrderApproval.branch.name" name="productionPlanningOrderApproval.branch.name" size="25" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="110px"><B>Transaction Date *</B></td>
                            <td>
                            <sj:datepicker id="productionPlanningOrderApproval.transactionDate" name="productionPlanningOrderApproval.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Document Type * </B></td>
                            <td colspan="2">
                                <table>
                                    <tr>
                                        <td>
                                            <s:radio id="productionPlanningOrderApprovalDocumentTypeRad" name="productionPlanningOrderApprovalDocumentTypeRad" label="Type" list="{'SO','BO','IM'}"></s:radio>
                                            <s:textfield id="productionPlanningOrderApproval.documentType" name="productionPlanningOrderApproval.documentType" size="20" style="display:none"></s:textfield>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>SO/BO/IM *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    $('#productionPlanningOrderApproval_btnDocument').click(function(ev) {
                                        if(!flagIsConfirmedPPOOptions){
                                            alert("Confirm Document Type Options!");
                                            return;
                                        }
                                        window.open("./pages/search/search-customer-order-document.jsp?iddoc=productionPlanningOrderApproval&iddoctype="+$('#productionPlanningOrderApproval\\.documentType').val()+"&firstDate="+$("#productionPlanningOrderApprovalDateFirstSession").val()+"&lastDate="+$("#productionPlanningOrderApprovalDateLastSession").val(),"Search", "width=600, height=500");
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="productionPlanningOrderApproval.documentCode" name="productionPlanningOrderApproval.documentCode" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                                    <%--<sj:a id="productionPlanningOrderApproval_btnDocument" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>--%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="110px"><B>Target Date *</B></td>
                            <td>
                            <sj:datepicker id="productionPlanningOrderApproval.targetDate" name="productionPlanningOrderApproval.targetDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                                <s:textfield id="productionPlanningOrderApproval.customer.code" name="productionPlanningOrderApproval.customer.code" size="15" readonly="true"></s:textfield>
                                <s:textfield id="productionPlanningOrderApproval.customer.name" name="productionPlanningOrderApproval.customer.name" size="30" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td><s:textfield id="productionPlanningOrderApproval.refNo" name="productionPlanningOrderApproval.refNo" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td><s:textarea id="productionPlanningOrderApproval.remark" name="productionPlanningOrderApproval.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
                        </tr>
                        <tr hidden="true">
                            <td>
                                <s:textfield id="productionPlanningOrderApproval.createdBy" name="productionPlanningOrderApproval.createdBy"></s:textfield>
                                <sj:datepicker id="productionPlanningOrderApprovalDateFirstSession" name="productionPlanningOrderApprovalDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                                <sj:datepicker id="productionPlanningOrderApprovalDateLastSession" name="productionPlanningOrderApprovalDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td align="right">Approval Status </td>
                            <s:textfield id="productionPlanningOrderApproval.approvalStatus" name="productionPlanningOrderApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                            <td><s:radio id="productionPlanningOrderApprovalApprovalStatusRad" name="productionPlanningOrderApprovalApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Approval Reason</td>
                            <td colspan="2">
                            <script type = "text/javascript">
                                $('#productionPlanningOrderApproval_btnReason').click(function(ev) {
                                    window.open("./pages/search/search-reason.jsp?iddoc=productionPlanningOrderApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                                });
                                txtproductionPlanningOrderApprovalReasonCode.change(function(ev) {

                                    if(txtproductionPlanningOrderApprovalReasonCode.val()===""){
                                        txtproductionPlanningOrderApprovalReasonCode.val("");
                                        return;
                                    }
                                    var url = "master/reason-get";
                                    var params = "reason.code=" + txtproductionPlanningOrderApprovalReasonCode.val();
                                        params += "&reason.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.reasonTemp){
                                            txtproductionPlanningOrderApprovalReasonCode.val(data.reasonTemp.code);
                                            txtproductionPlanningOrderApprovalReasonName.val(data.reasonTemp.name);
                                        }
                                        else{
                                            alertMessage("Reason Not Found!",txtproductionPlanningOrderApprovalReasonCode);
                                            txtproductionPlanningOrderApprovalReasonCode.val("");
                                            txtproductionPlanningOrderApprovalReasonName.val("");
                                        }
                                    });
                                });
                            </script>
                                <div class="searchbox ui-widget-header" hidden="true">
                                    <s:textfield id="productionPlanningOrderApproval.approvalReason.code" name="productionPlanningOrderApproval.approvalReason.code" size="25"></s:textfield>
                                    <sj:a id="productionPlanningOrderApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="productionPlanningOrderApproval.approvalReason.name" name="productionPlanningOrderApproval.approvalReason.name" size="30" readonly="true"></s:textfield>
                            </td>    
                        </tr>
                        <tr>
                            <td align="right" valign="top">Approval Remark</td>
                            <td><s:textarea id="productionPlanningOrderApproval.approvalRemark" name="productionPlanningOrderApproval.approvalRemark"  cols="50" rows="2" height="20"></s:textarea></td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
              
        <br class="spacer" />
        <br class="spacer" />
                
        <div id="id-production-planning-order-detail">
            <div id="productionPlanningOrderApprovalItemDetailInputGrid">
                <sjg:grid
                    id="productionPlanningOrderApprovalItemDetailInput_grid"
                    caption="PRODUCTION PLANNING ITEM  DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listProductionPlanningOrderApprovalItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuProductionPlanningOrderApprovalItemDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlProductionPlanningOrderApprovalItemDetailInput}"
                    onSelectRowTopics="ProductionPlanningOrderApprovalItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="productionPlanningOrderApprovalItemDetail" index="productionPlanningOrderApprovalItemDetail" key="productionPlanningOrderApprovalItemDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailSortNo" index = "productionPlanningOrderApprovalItemDetailSortNo" 
                        key = "productionPlanningOrderApprovalItemDetailSortNo" title = "Sort No" width = "80"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailDocumentDetailCode" index = "productionPlanningOrderApprovalItemDetailDocumentDetailCode" 
                        key = "productionPlanningOrderApprovalItemDetailDocumentDetailCode" title = "Document Detail Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailBillOfMaterialCode" index = "productionPlanningOrderApprovalItemDetailBillOfMaterialCode" 
                        key = "productionPlanningOrderApprovalItemDetailBillOfMaterialCode" title = "Bom Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsCode" title = "Item Finish Goods" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailValveTag" index = "productionPlanningOrderApprovalItemDetailValveTag" 
                        key = "productionPlanningOrderApprovalItemDetailValveTag" title = "Valve Tag" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailDataSheet" index = "productionPlanningOrderApprovalItemDetailDataSheet" 
                        key = "productionPlanningOrderApprovalItemDetailDataSheet" title = "Data Sheet" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailDescription" index = "productionPlanningOrderApprovalItemDetailDescription" 
                        key = "productionPlanningOrderApprovalItemDetailDescription" title = "Description" width = "120"
                    />
<!------------------------------------>
                    <!--01 Body Cons-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstCode" title = "Body Cons Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyConstName" title = "Body Construction" width = "120"
                    />
                    <!--02 Type Design-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignCode" title = "Type Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsTypeDesignName" title = "Type Design" width = "120"
                    />
                    <!--03 Seat Design-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignCode" title = "Seat Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatDesignName" title = "Seat Design" width = "120"
                    />
                    <!--04 Size-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeCode" title = "Size Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSizeName" title = "Size" width = "120"
                    />
                    <!--05 Rating-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingCode" title = "Rating Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsRatingName" title = "Rating" width = "120"
                    />
                    <!--06 Bore-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreCode" title = "Bore Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoreName" title = "Bore" width = "120"
                    />
                    
                    <!--07 End Con-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConCode" title = "End Con Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsEndConName" title = "End Con" width = "120"
                    />
                    <!--08 Body-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyCode" title = "Body Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBodyName" title = "Body" width = "120"
                    />
                    <!--09 Ball-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBallCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBallCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBallCode" title = "Ball Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBallName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBallName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBallName" title = "Ball" width = "120"
                    />
                    <!--10 Seat-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatCode" title = "Seat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatName" title = "Seat" width = "120"
                    />
                    <!--11 Seat Insert-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertCode" title = "Seat Insert Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSeatInsertName" title = "Seat Insert" width = "120"
                    />
                    <!--12 Stem-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStemCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStemCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStemCode" title = "Stem Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStemName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStemName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStemName" title = "Stem" width = "120"
                    />
                    
                    <!--13 Seal-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSealCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSealCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSealCode" title = "Seal Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSealName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSealName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSealName" title = "Seal" width = "120"
                    />
                    <!--14 Bolt-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltCode" title = "Bolt Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBoltName" title = "Bolt" width = "120"
                    />
                    <!--15 Disc-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscCode" title = "Disc Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsDiscName" title = "Disc" width = "120"
                    />
                    <!--16 Plates-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesCode" title = "Plates Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsPlatesName" title = "Plates" width = "120"
                    />
                    <!--17 Shaft-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftCode" title = "Shaft Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsShaftName" title = "Shaft" width = "120"
                    />
                    <!--18 Spring-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringCode" title = "Spring Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsSpringName" title = "Spring" width = "120"
                    />
                    
                    <!--19 Arm Pin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinCode" title = "Arm Pin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmPinName" title = "Arm Pin" width = "120"
                    />
                    <!--20 BackSeat-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatCode" title = "BackSeat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsBackSeatName" title = "BackSeat" width = "120"
                    />
                    <!--21 Arm-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmCode" title = "Arm Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsArmName" title = "Arm" width = "120"
                    />
                    <!--22 HingePin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinCode" title = "HingePin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsHingePinName" title = "HingePin" width = "120"
                    />
                    <!--23 StopPin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinCode" title = "StopPin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsStopPinName" title = "StopPin" width = "120"
                    />
                    <!--24 Operator-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorCode" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorCode" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorCode" title = "Operator Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorName" index = "productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorName" 
                        key = "productionPlanningOrderApprovalItemDetailItemFinishGoodsOperatorName" title = "Operator" width = "120"
                    />
                    
                    <sjg:gridColumn
                        name="productionPlanningOrderApprovalItemDetailOrderQuantity" index="productionPlanningOrderApprovalItemDetailOrderQuantity" key="productionPlanningOrderApprovalItemDetailOrderQuantity" title="Order Quantity" 
                        width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderApprovalItemDetailProcessedQuantity" index="productionPlanningOrderApprovalItemDetailProcessedQuantity" key="productionPlanningOrderApprovalItemDetailProcessedQuantity" 
                        title="Processed Quantity" width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderApprovalItemDetailBalanceQuantity" index="productionPlanningOrderApprovalItemDetailBalanceQuantity" key="productionPlanningOrderApprovalItemDetailBalanceQuantity" 
                        title="Balance Quantity" width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderApprovalItemDetailQuantity" index="productionPlanningOrderApprovalItemDetailQuantity" key="productionPlanningOrderApprovalItemDetailQuantity" title="PPO Quantity" 
                        width="150" align="right" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >      
                <br class="spacer" />
            </div>
        </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnProductionPlanningOrderApprovalSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnProductionPlanningOrderApprovalCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="productionPlanningOrderApprovalUpdateMode" name="productionPlanningOrderApprovalUpdateMode"></s:textfield>
                </td>
            </tr>
        </table>      
                
         
    </s:form>
</div>
    

