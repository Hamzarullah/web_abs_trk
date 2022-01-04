
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
    var productionPlanningOrderClosingItemDetailLastRowId = 0, productionPlanningOrderClosingItemDetailLastSel = -1;
    var                                    
        txtProductionPlanningOrderClosingCode = $("#productionPlanningOrderClosing\\.code"),
        dtpProductionPlanningOrderClosingTransactionDate = $("#productionPlanningOrderClosing\\.transactionDate"),
        dtpProductionPlanningOrderClosingTargetDate = $("#productionPlanningOrderClosing\\.targetDate"),
        txtProductionPlanningOrderClosingBranchCode = $("#productionPlanningOrderClosing\\.branch\\.code"),
        txtProductionPlanningOrderClosingBranchName = $("#productionPlanningOrderClosing\\.branch\\.name"),
        txtProductionPlanningOrderClosingDocumentCode = $("#productionPlanningOrderClosing\\.documentCode"),
        txtProductionPlanningOrderClosingCustomerCode = $("#productionPlanningOrderClosing\\.customer\\.code"),
        txtProductionPlanningOrderClosingCustomerName = $("#productionPlanningOrderClosing\\.customer\\.name");
        txtproductionPlanningOrderClosingReasonCode = $("#productionPlanningOrderClosing\\.reason\\.code");
        txtproductionPlanningOrderClosingReasonName = $("#productionPlanningOrderClosing\\.reason\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedPPOOptions=false;
        flagIsConfirmedPPO=false;
        hoverButton();
        
        //Set Default View Approval
//        if($("#productionPlanningOrderClosingUpdateMode").val() === 'true'){

            var documentType = $("#productionPlanningOrderClosing\\.documentType").val();
            if(documentType === 'SO'){
                $('#productionPlanningOrderClosingDocumentTypeRadSO').prop('checked',true);
                $('#productionPlanningOrderClosingDocumentTypeRadBO').prop('disabled',true);
                $('#productionPlanningOrderClosingDocumentTypeRadIM').prop('disabled',true);
            }else if(documentType === 'BO'){
                $('#productionPlanningOrderClosingDocumentTypeRadBO').prop('checked',true);
                $('#productionPlanningOrderClosingDocumentTypeRadSO').prop('disabled',true);
                $('#productionPlanningOrderClosingDocumentTypeRadIM').prop('disabled',true);
            }else{
                $('#productionPlanningOrderClosingDocumentTypeRadIM').prop('checked',true);
                $('#productionPlanningOrderClosingDocumentTypeRadBO').prop('disabled',true);
                $('#productionPlanningOrderClosingDocumentTypeRadSO').prop('disabled',true);
            }
            loadApprovalDataProductionPlanningOrderClosingDocumentItemDetail();
//        }
        
        //Set Default View
        $('input[name="productionPlanningOrderClosingDocumentTypeRad"][value="SO"]').change(function(ev){
            $("#productionPlanningOrderClosing\\.documentType").val("SO");
        });
                
        $('input[name="productionPlanningOrderClosingDocumentTypeRad"][value="BO"]').change(function(ev){
            $("#productionPlanningOrderClosing\\.documentType").val("BO");
        });
        
        $('input[name="productionPlanningOrderClosingDocumentTypeRad"][value="IM"]').change(function(ev){
            $("#productionPlanningOrderClosing\\.documentType").val("IM");
        });
        
        $('#btnProductionPlanningOrderClosingSave').click(function(ev) {
            
            if ($("#productionPlanningOrderClosing\\.approvalStatus").val()==="PENDING"){
                 alertMessage("Please choose one Approval Status");
                 return;
            }  
            
            formatDateProductionPlanningOrderClosing();
            var url="ppic/production-planning-order-closing-save";
            var params = $("#frmProductionPlanningOrderClosingInput").serialize();
            $.post(url, params, function(data) {
                $("#dlgLoading").dialog("close");
                if (data.error) {
                    formatDateProductionPlanningOrderClosing(); 
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
                                            var url = "ppic/production-planning-order-closing";
                                            var params = "";
                                            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER_CLOSING");
                                        }
                                    }]
                });
            });
            
            
        });
               
        $('#btnProductionPlanningOrderClosingCancel').click(function(ev) {
            var url = "purchasing/production-planning-order-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER_CLOSING"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("ProductionPlanningOrderClosingItemDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==productionPlanningOrderClosingItemDetailLastSel) {
                $('#productionPlanningOrderClosingItemDetailInput_grid').jqGrid("saveRow",productionPlanningOrderClosingItemDetailLastSel); 
                $('#productionPlanningOrderClosingItemDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                productionPlanningOrderClosingItemDetailLastSel=selectedRowID;
            }
            else{
                $('#productionPlanningOrderClosingItemDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
    }); //EOF Ready
    
    function setProductionPlanningOrderClosingDocumentType(){
        switch($("#productionPlanningOrderClosing\\.documentType").val()){
            case "SO":
                $('input[name="productionPlanningOrderClosingDocumentRad"][value="YES"]').prop('checked',true);
                break;
            case "BO":
                $('input[name="productionPlanningOrderClosingDocumentRad"][value="NO"]').prop('checked',true);
                break;
            case "IM":
                $('input[name="productionPlanningOrderClosingDocumentRad"][value="IM"]').prop('checked',true);
                break;
        } 
    }
    
    function loadApprovalDataProductionPlanningOrderClosingDocumentItemDetail() {
        
        var url = "ppic/production-planning-order-closing-detail-data";
        var params = "productionPlanningOrderClosing.documentType=" + $('#productionPlanningOrderClosing\\.documentType') .val();
            params += "&productionPlanningOrderClosing.code=" + txtProductionPlanningOrderClosingCode.val();
//        alert(params);
        $.getJSON(url, params, function(data) {
            productionPlanningOrderClosingItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listProductionPlanningOrderClosingItemDetail.length; i++) {
                productionPlanningOrderClosingItemDetailLastRowId++;
                $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid("addRowData", productionPlanningOrderClosingItemDetailLastRowId, data.listProductionPlanningOrderClosingItemDetail[i]);
                $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid('setRowData',productionPlanningOrderClosingItemDetailLastRowId,{
                    
                    productionPlanningOrderClosingItemDetailDocumentDetailCode             : data.listProductionPlanningOrderClosingItemDetail[i].documentDetailCode,
                    productionPlanningOrderClosingItemDetailSortNo                         : data.listProductionPlanningOrderClosingItemDetail[i].documentSortNo,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsCode            : data.listProductionPlanningOrderClosingItemDetail[i].itemFinishGoodsCode,
                    productionPlanningOrderClosingItemDetailBillOfMaterialCode             : data.listProductionPlanningOrderClosingItemDetail[i].billOfMaterialCode,
                    productionPlanningOrderClosingItemDetailValveTag                       : data.listProductionPlanningOrderClosingItemDetail[i].valveTag,
                    productionPlanningOrderClosingItemDetailDataSheet                      : data.listProductionPlanningOrderClosingItemDetail[i].dataSheet,
                    productionPlanningOrderClosingItemDetailDescription                    : data.listProductionPlanningOrderClosingItemDetail[i].description,
                    
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstCode   : data.listProductionPlanningOrderClosingItemDetail[i].itemBodyConstructionCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstName   : data.listProductionPlanningOrderClosingItemDetail[i].itemBodyConstructionName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignCode  : data.listProductionPlanningOrderClosingItemDetail[i].itemTypeDesignCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignName  : data.listProductionPlanningOrderClosingItemDetail[i].itemTypeDesignName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignCode  : data.listProductionPlanningOrderClosingItemDetail[i].itemSeatDesignCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignName  : data.listProductionPlanningOrderClosingItemDetail[i].itemSeatDesignName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSizeCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemSizeCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSizeName        : data.listProductionPlanningOrderClosingItemDetail[i].itemSizeName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsRatingCode      : data.listProductionPlanningOrderClosingItemDetail[i].itemRatingCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsRatingName      : data.listProductionPlanningOrderClosingItemDetail[i].itemRatingName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBoreCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemBoreCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBoreName        : data.listProductionPlanningOrderClosingItemDetail[i].itemBoreName,
                    
                    productionPlanningOrderClosingItemDetailItemFinishGoodsEndConCode      : data.listProductionPlanningOrderClosingItemDetail[i].itemEndConCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsEndConName      : data.listProductionPlanningOrderClosingItemDetail[i].itemEndConName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBodyCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemBodyCode,   
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBodyName        : data.listProductionPlanningOrderClosingItemDetail[i].itemBodyName,   
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBallCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemBallCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBallName        : data.listProductionPlanningOrderClosingItemDetail[i].itemBallName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSeatCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemSeatCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSeatName        : data.listProductionPlanningOrderClosingItemDetail[i].itemSeatName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertCode  : data.listProductionPlanningOrderClosingItemDetail[i].itemSeatInsertCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertName  : data.listProductionPlanningOrderClosingItemDetail[i].itemSeatInsertName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsStemCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemStemCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsStemName        : data.listProductionPlanningOrderClosingItemDetail[i].itemStemName,
                    
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSealCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemSealCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSealName        : data.listProductionPlanningOrderClosingItemDetail[i].itemSealName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBoltCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemBoltCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBoltName        : data.listProductionPlanningOrderClosingItemDetail[i].itemBoltName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsDiscCode        : data.listProductionPlanningOrderClosingItemDetail[i].itemDiscCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsDiscName        : data.listProductionPlanningOrderClosingItemDetail[i].itemDiscName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesCode      : data.listProductionPlanningOrderClosingItemDetail[i].itemPlatesCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesName      : data.listProductionPlanningOrderClosingItemDetail[i].itemPlatesName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsShaftCode       : data.listProductionPlanningOrderClosingItemDetail[i].itemShaftCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsShaftName       : data.listProductionPlanningOrderClosingItemDetail[i].itemShaftName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSpringCode      : data.listProductionPlanningOrderClosingItemDetail[i].itemSpringCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsSpringName      : data.listProductionPlanningOrderClosingItemDetail[i].itemSpringName,
                    
                    productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinCode      : data.listProductionPlanningOrderClosingItemDetail[i].itemArmPinCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinName      : data.listProductionPlanningOrderClosingItemDetail[i].itemArmPinName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatCode    : data.listProductionPlanningOrderClosingItemDetail[i].itemBackSeatCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatName    : data.listProductionPlanningOrderClosingItemDetail[i].itemBackSeatName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsArmCode         : data.listProductionPlanningOrderClosingItemDetail[i].itemArmCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsArmName         : data.listProductionPlanningOrderClosingItemDetail[i].itemArmName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinCode    : data.listProductionPlanningOrderClosingItemDetail[i].itemHingePinCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinName    : data.listProductionPlanningOrderClosingItemDetail[i].itemHingePinName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinCode     : data.listProductionPlanningOrderClosingItemDetail[i].itemStopPinCode,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinName     : data.listProductionPlanningOrderClosingItemDetail[i].itemStopPinName,
                    productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorCode    : data.listProductionPlanningOrderClosingItemDetail[i].itemOperatorCode, 
                    productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorName    : data.listProductionPlanningOrderClosingItemDetail[i].itemOperatorName, 
                    
                    productionPlanningOrderClosingItemDetailOrderQuantity                  : data.listProductionPlanningOrderClosingItemDetail[i].orderQuantity,
                    productionPlanningOrderClosingItemDetailProcessedQuantity              : data.listProductionPlanningOrderClosingItemDetail[i].processedQty,
                    productionPlanningOrderClosingItemDetailBalanceQuantity                : data.listProductionPlanningOrderClosingItemDetail[i].balancedQty,
                    productionPlanningOrderClosingItemDetailQuantity                       : data.listProductionPlanningOrderClosingItemDetail[i].quantity
                });
            }
        });
    }
    
    // function Grid Detail
    function setHeightGridProductionPlanningOrderClosingItemDetail(){
        var ids = jQuery("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#productionPlanningOrderClosingItemDetailInput_grid"+" tr").eq(1).height();
            $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function productionPlanningOrderClosingItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#productionPlanningOrderClosingItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridProductionPlanningOrderClosingItemDetail();
    }
    
    function formatDateProductionPlanningOrderClosing(){
        var transactionDate=formatDatePPO(dtpProductionPlanningOrderClosingTransactionDate.val(),false);
        dtpProductionPlanningOrderClosingTransactionDate.val(transactionDate);  
        var targetDate=formatDatePPO(dtpProductionPlanningOrderClosingTargetDate.val(),false);
        dtpProductionPlanningOrderClosingTargetDate.val(targetDate);  
    }
    
    function handlers_input_production_planning_order(){
        
        if(txtProductionPlanningOrderClosingBranchCode.val()===""){
            handlersInput(txtProductionPlanningOrderClosingBranchCode);
        }else{
            unHandlersInput(txtProductionPlanningOrderClosingBranchCode);
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
<s:url id="remotedetailurlProductionPlanningOrderClosingItemDetailInput" action="" />

<b>PRODUCTION PLANNING ORDER CLOSING</b>
<hr>
<br class="spacer" />

<div id="productionPlanningOrderClosingInput" class="content ui-widget">
    <s:form id="frmProductionPlanningOrderClosingInput">
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td align="right" width="100px"><b>PPO No *</b></td>
                            <td><s:textfield id="productionPlanningOrderClosing.code" name="productionPlanningOrderClosing.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="productionPlanningOrderClosing.branch.code" name="productionPlanningOrderClosing.branch.code" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                                </div>
                                    <s:textfield id="productionPlanningOrderClosing.branch.name" name="productionPlanningOrderClosing.branch.name" size="25" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="110px"><B>Transaction Date *</B></td>
                            <td>
                            <sj:datepicker id="productionPlanningOrderClosing.transactionDate" name="productionPlanningOrderClosing.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Document Type * </B></td>
                            <td colspan="2">
                                <table>
                                    <tr>
                                        <td>
                                            <s:radio id="productionPlanningOrderClosingDocumentTypeRad" name="productionPlanningOrderClosingDocumentTypeRad" label="Type" list="{'SO','BO','IM'}"></s:radio>
                                            <s:textfield id="productionPlanningOrderClosing.documentType" name="productionPlanningOrderClosing.documentType" size="20" style="display:none"></s:textfield>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>SO/BO/IM *</B></td>
                            <td colspan="2">
                                <script type = "text/javascript">
                                    $('#productionPlanningOrderClosing_btnDocument').click(function(ev) {
                                        if(!flagIsConfirmedPPOOptions){
                                            alert("Confirm Document Type Options!");
                                            return;
                                        }
                                        window.open("./pages/search/search-customer-order-document.jsp?iddoc=productionPlanningOrderClosing&iddoctype="+$('#productionPlanningOrderClosing\\.documentType').val()+"&firstDate="+$("#productionPlanningOrderClosingDateFirstSession").val()+"&lastDate="+$("#productionPlanningOrderClosingDateLastSession").val(),"Search", "width=600, height=500");
                                    });
                                </script>
                                <div class="searchbox ui-widget-header">
                                    <s:textfield id="productionPlanningOrderClosing.documentCode" name="productionPlanningOrderClosing.documentCode" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                                    <%--<sj:a id="productionPlanningOrderClosing_btnDocument" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>--%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="110px"><B>Target Date *</B></td>
                            <td>
                            <sj:datepicker id="productionPlanningOrderClosing.targetDate" name="productionPlanningOrderClosing.targetDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer *</B></td>
                            <td colspan="2">
                                <s:textfield id="productionPlanningOrderClosing.customer.code" name="productionPlanningOrderClosing.customer.code" size="15" readonly="true"></s:textfield>
                                <s:textfield id="productionPlanningOrderClosing.customer.name" name="productionPlanningOrderClosing.customer.name" size="30" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Ref No</td>
                            <td><s:textfield id="productionPlanningOrderClosing.refNo" name="productionPlanningOrderClosing.refNo" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td><s:textarea id="productionPlanningOrderClosing.remark" name="productionPlanningOrderClosing.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Closing Remark</td>
                            <td><s:textarea id="productionPlanningOrderClosing.closingRemark" name="productionPlanningOrderClosing.closingRemark"  cols="50" rows="2" height="20"></s:textarea></td>
                        </tr>
                        <tr hidden="true">
                            <td>
                                <s:textfield id="productionPlanningOrderClosing.createdBy" name="productionPlanningOrderClosing.createdBy"></s:textfield>
                                <sj:datepicker id="productionPlanningOrderClosingDateFirstSession" name="productionPlanningOrderClosingDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                                <sj:datepicker id="productionPlanningOrderClosingDateLastSession" name="productionPlanningOrderClosingDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
              
        <br class="spacer" />
        <br class="spacer" />
                
        <div id="id-production-planning-order-detail">
            <div id="productionPlanningOrderClosingItemDetailInputGrid">
                <sjg:grid
                    id="productionPlanningOrderClosingItemDetailInput_grid"
                    caption="PRODUCTION PLANNING ITEM  DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listProductionPlanningOrderClosingItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuProductionPlanningOrderClosingItemDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlProductionPlanningOrderClosingItemDetailInput}"
                    onSelectRowTopics="ProductionPlanningOrderClosingItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="productionPlanningOrderClosingItemDetail" index="productionPlanningOrderClosingItemDetail" key="productionPlanningOrderClosingItemDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailSortNo" index = "productionPlanningOrderClosingItemDetailSortNo" 
                        key = "productionPlanningOrderClosingItemDetailSortNo" title = "Sort No" width = "80"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailDocumentDetailCode" index = "productionPlanningOrderClosingItemDetailDocumentDetailCode" 
                        key = "productionPlanningOrderClosingItemDetailDocumentDetailCode" title = "Document Detail Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsCode" title = "Item Finish Goods" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailBillOfMaterialCode" index = "productionPlanningOrderClosingItemDetailBillOfMaterialCode" 
                        key = "productionPlanningOrderClosingItemDetailBillOfMaterialCode" title = "BOM Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailValveTag" index = "productionPlanningOrderClosingItemDetailValveTag" 
                        key = "productionPlanningOrderClosingItemDetailValveTag" title = "Valve Tag" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailDataSheet" index = "productionPlanningOrderClosingItemDetailDataSheet" 
                        key = "productionPlanningOrderClosingItemDetailDataSheet" title = "Data Sheet" width = "120"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailDescription" index = "productionPlanningOrderClosingItemDetailDescription" 
                        key = "productionPlanningOrderClosingItemDetailDescription" title = "Description" width = "120"
                    />
<!------------------------------------>
                    <!--01 Body Cons-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstCode" title = "Body Cons Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyConstName" title = "Body Construction" width = "120"
                    />
                    <!--02 Type Design-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignCode" title = "Type Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsTypeDesignName" title = "Type Design" width = "120"
                    />
                    <!--03 Seat Design-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignCode" title = "Seat Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatDesignName" title = "Seat Design" width = "120"
                    />
                    <!--04 Size-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSizeCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSizeCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSizeCode" title = "Size Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSizeName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSizeName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSizeName" title = "Size" width = "120"
                    />
                    <!--05 Rating-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsRatingCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsRatingCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsRatingCode" title = "Rating Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsRatingName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsRatingName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsRatingName" title = "Rating" width = "120"
                    />
                    <!--06 Bore-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoreCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoreCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoreCode" title = "Bore Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoreName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoreName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoreName" title = "Bore" width = "120"
                    />
                    
                    <!--07 End Con-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsEndConCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsEndConCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsEndConCode" title = "End Con Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsEndConName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsEndConName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsEndConName" title = "End Con" width = "120"
                    />
                    <!--08 Body-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyCode" title = "Body Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBodyName" title = "Body" width = "120"
                    />
                    <!--09 Ball-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBallCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBallCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBallCode" title = "Ball Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBallName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBallName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBallName" title = "Ball" width = "120"
                    />
                    <!--10 Seat-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatCode" title = "Seat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatName" title = "Seat" width = "120"
                    />
                    <!--11 Seat Insert-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertCode" title = "Seat Insert Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSeatInsertName" title = "Seat Insert" width = "120"
                    />
                    <!--12 Stem-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsStemCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsStemCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsStemCode" title = "Stem Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsStemName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsStemName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsStemName" title = "Stem" width = "120"
                    />
                    
                    <!--13 Seal-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSealCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSealCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSealCode" title = "Seal Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSealName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSealName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSealName" title = "Seal" width = "120"
                    />
                    <!--14 Bolt-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoltCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoltCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoltCode" title = "Bolt Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoltName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoltName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBoltName" title = "Bolt" width = "120"
                    />
                    <!--15 Disc-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsDiscCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsDiscCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsDiscCode" title = "Disc Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsDiscName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsDiscName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsDiscName" title = "Disc" width = "120"
                    />
                    <!--16 Plates-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesCode" title = "Plates Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsPlatesName" title = "Plates" width = "120"
                    />
                    <!--17 Shaft-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsShaftCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsShaftCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsShaftCode" title = "Shaft Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsShaftName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsShaftName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsShaftName" title = "Shaft" width = "120"
                    />
                    <!--18 Spring-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSpringCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSpringCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSpringCode" title = "Spring Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsSpringName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsSpringName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsSpringName" title = "Spring" width = "120"
                    />
                    
                    <!--19 Arm Pin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinCode" title = "Arm Pin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmPinName" title = "Arm Pin" width = "120"
                    />
                    <!--20 BackSeat-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatCode" title = "BackSeat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsBackSeatName" title = "BackSeat" width = "120"
                    />
                    <!--21 Arm-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmCode" title = "Arm Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsArmName" title = "Arm" width = "120"
                    />
                    <!--22 HingePin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinCode" title = "HingePin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsHingePinName" title = "HingePin" width = "120"
                    />
                    <!--23 StopPin-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinCode" title = "StopPin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsStopPinName" title = "StopPin" width = "120"
                    />
                    <!--24 Operator-->
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorCode" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorCode" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorCode" title = "Operator Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorName" index = "productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorName" 
                        key = "productionPlanningOrderClosingItemDetailItemFinishGoodsOperatorName" title = "Operator" width = "120"
                    />
                    
                    <sjg:gridColumn
                        name="productionPlanningOrderClosingItemDetailOrderQuantity" index="productionPlanningOrderClosingItemDetailOrderQuantity" key="productionPlanningOrderClosingItemDetailOrderQuantity" title="Order Quantity" 
                        width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderClosingItemDetailProcessedQuantity" index="productionPlanningOrderClosingItemDetailProcessedQuantity" key="productionPlanningOrderClosingItemDetailProcessedQuantity" 
                        title="Processed Quantity" width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderClosingItemDetailBalanceQuantity" index="productionPlanningOrderClosingItemDetailBalanceQuantity" key="productionPlanningOrderClosingItemDetailBalanceQuantity" 
                        title="Balance Quantity" width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="productionPlanningOrderClosingItemDetailQuantity" index="productionPlanningOrderClosingItemDetailQuantity" key="productionPlanningOrderClosingItemDetailQuantity" title="PPO Quantity" 
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
                    <sj:a href="#" id="btnProductionPlanningOrderClosingSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnProductionPlanningOrderClosingCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="productionPlanningOrderClosingUpdateMode" name="productionPlanningOrderClosingUpdateMode"></s:textfield>
                </td>
            </tr>
        </table>      
                
         
    </s:form>
</div>
    

