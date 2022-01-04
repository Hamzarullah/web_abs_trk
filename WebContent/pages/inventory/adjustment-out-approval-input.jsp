
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #adjustmentOutApprovalItemDetailInput_grid_pager_center,#adjustmentOutApprovalSerialNoDetailInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgAddRow{
        color: red;
    }
</style>

<script type="text/javascript">
        
    var txtAdjustmentOutApprovalCode = $("#adjustmentOutApproval\\.code"),
        txtAdjustmentOutApprovalBranchCode = $("#adjustmentOutApproval\\.branch\\.code"),
        txtAdjustmentOutApprovalBranchName = $("#adjustmentOutApproval\\.branch\\.name"),
        dtpAdjustmentOutApprovalTransactionDate = $("#adjustmentOutApproval\\.transactionDate"),
        txtAdjustmentOutApprovalCurrencyCode = $("#adjustmentOutApproval\\.currency\\.code"),
        txtAdjustmentOutApprovalExchangeRate = $("#adjustmentOutApproval\\.exchangeRate"),
        txtAdjustmentOutApprovalWarehouseCode = $("#adjustmentOutApproval\\.warehouse\\.code"),
        txtAdjustmentOutApprovalWarehouseName = $("#adjustmentOutApproval\\.warehouse\\.name"),
        txtAdjustmentOutApprovalApprovalStatus = $("#adjustmentOutApproval\\.approvalStatus"),
        txtAdjustmentOutApprovalReasonCode = $("#adjustmentOutApproval\\.approvalReason\\.code"),
        txtAdjustmentOutApprovalReasonName = $("#adjustmentOutApproval\\.approvalReason\\.name"),
        txtadjustmentOutApprovalRemark = $("#adjustmentOutApproval\\.approvalRemark"),
        txtAdjustmentOutApprovalRefNo = $("#adjustmentOutApproval\\.refNo"),
        txtAdjustmentOutApprovalRemark = $("#adjustmentOutApproval\\.remark"),
        dtpAdjustmentOutApprovalUpdatedDate = $("#adjustmentOutApproval\\.updatedDate"),
        dtpAdjustmentOutApprovalCreatedDate = $("#adjustmentOutApproval\\.createdDate");
    
    $(document).ready(function(){       
                      
        $('#adjustmentOutApprovalApprovalStatusRadAPPROVED').prop('checked',true);
        var value="APPROVED";
        $("#adjustmentOutApproval\\.approvalStatus").val(value);
        
        $('input[name="adjustmentOutApprovalApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#adjustmentOutApproval\\.approvalStatus").val(value);
        });
        
        $('input[name="adjustmentOutApprovalApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#adjustmentOutApproval\\.approvalStatus").val(value);
        });
        
        $("#btnAdjustmentOutApprovalSave").click(function(ev) {     
            var listAdjustmentOutApprovalItemDetail = new Array();     
            var listAdjustmentOutApprovalSerialNoDetail = new Array();  
//            var listItemCode= new Array();
            
            var ids = jQuery("#adjustmentOutApprovalItemDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#adjustmentOutApprovalItemDetailInput_grid").jqGrid('getRowData',ids[i]); 

                var adjustmentOutItemDetail = { 
                    code        : data.adjustmentOutApprovalItemDetailCode,
                    itemMaterial: {code:data.adjustmentOutApprovalItemDetailItemCode},
                    reason      : { code : data.adjustmentOutApprovalItemDetailReasonCode},
                    quantity    : data.adjustmentOutApprovalItemDetailQuantity,
                    rack        : {code:data.adjustmentOutApprovalItemDetailRackCode},
                    remark      : data.adjustmentOutApprovalItemDetailRemark
                    
                };
                listAdjustmentOutApprovalItemDetail[i] = adjustmentOutItemDetail;
                
            }
            
            var idx = jQuery("#adjustmentOutApprovalSerialNoDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var x=0;x < idx.length;x++){
                var data = $("#adjustmentOutApprovalSerialNoDetailInput_grid").jqGrid('getRowData',idx[x]); 
                                                
                var adjustmentOutSerialNoDetail = {
                    itemMaterial    : {code:data.adjustmentOutApprovalSerialNoDetailItemCode},
                    reason          : { code : data.adjustmentOutApprovalSerialNoDetailReasonCode},
                    serialNo        : data.adjustmentOutApprovalSerialNoDetailSerialNo,
                    capacity        : data.adjustmentOutApprovalSerialNoDetailIotCapacity,
                    rack            : { code : data.adjustmentOutApprovalSerialNoDetailRackCode}
                };
                listAdjustmentOutApprovalSerialNoDetail[x] = adjustmentOutSerialNoDetail;
                
            }
                        
            formatDateIOTApproval();
            var url = "inventory/adjustment-out-save-approval-data";
            var params= $("#frmAdjustmentOutApprovalInput").serialize();
                params+= "&listAdjustmentOutItemDetailJSON=" + $.toJSON(listAdjustmentOutApprovalItemDetail);
                params+= "&listAdjustmentOutSerialNoDetailJSON=" + $.toJSON(listAdjustmentOutApprovalSerialNoDetail);

            showLoading();
            
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateIOTApproval();
                    return;
                }
                
                alertMessage(data.message);
                var params = "";
                var url = "inventory/adjustment-out-approval";
                pageLoad(url, params, "#tabmnuADJUSTMENT_OUT_APPROVAL");
            
            });
        });
        
        $("#btnAdjustmentOutApprovalCancel").click(function(ev){
            var params = "";
            var url = "inventory/adjustment-out-approval";
            pageLoad(url, params, "#tabmnuADJUSTMENT_OUT_APPROVAL");
        });
        
    });//EOF Ready
    
    
    function loadDataItemDetailAdjustmentOutApproval(){
        var url = "adjustmentOut/adjustment-out-item-detail-data";
        var params = "adjustmentOut.code=" + txtAdjustmentOutApprovalCode.val();
        
        $.post(url, params, function(data) {
            var adjustmentOutApprovalItemDetaillastRowId = 0;
            for (var i=0; i<data.listAdjustmentOutItemDetail.length; i++) {
                adjustmentOutApprovalItemDetaillastRowId++;
                
                $("#adjustmentOutApprovalItemDetailInput_grid").jqGrid("addRowData", adjustmentOutApprovalItemDetaillastRowId, data.listAdjustmentOutItemDetail[i]);
                $("#adjustmentOutApprovalItemDetailInput_grid").jqGrid('setRowData',adjustmentOutApprovalItemDetaillastRowId,{
                    adjustmentOutApprovalItemDetailCode                       : data.listAdjustmentOutItemDetail[i].code,
                    adjustmentOutApprovalItemDetailItemCode                   : data.listAdjustmentOutItemDetail[i].itemMaterialCode,
                    adjustmentOutApprovalItemDetailItemName                   : data.listAdjustmentOutItemDetail[i].itemMaterialName,
                    adjustmentOutApprovalItemDetailItemSerialNoStatus         : data.listAdjustmentOutItemDetail[i].itemMaterialSerialNoStatus,
                    adjustmentOutApprovalItemDetailQuantity                   : data.listAdjustmentOutItemDetail[i].quantity,
                    adjustmentOutApprovalItemDetailItemUnitOfMeasureCode      : data.listAdjustmentOutItemDetail[i].itemMaterialUnitOfMeasureCode,
                    adjustmentOutApprovalItemDetailRemark                     : data.listAdjustmentOutItemDetail[i].remark,
                    adjustmentOutApprovalItemDetailReasonCode                 : data.listAdjustmentOutItemDetail[i].reasonCode,
                    adjustmentOutApprovalItemDetailReasonName                 : data.listAdjustmentOutItemDetail[i].reasonName,
                    adjustmentOutApprovalItemDetailRackCode                   : data.listAdjustmentOutItemDetail[i].rackCode,
                    adjustmentOutApprovalItemDetailRackName                   : data.listAdjustmentOutItemDetail[i].rackName
                });
            }
        });
    }
    
    function loadDataSerialNoDetailAdjustmentOutApproval(){
        
        var url = "inventory/adjustment-out-serial-no-detail-data";
        var params= "adjustmentOut.code=" + txtAdjustmentOutApprovalCode.val();
                
        $.post(url, params, function(data) {
            var adjustmentOutApprovalSerialNoDetaillastRowId = 0;
            
            for (var i=0; i<data.listAdjustmentOutSerialNoDetail.length; i++) {
                adjustmentOutApprovalSerialNoDetaillastRowId++;

                
                $("#adjustmentOutApprovalSerialNoDetailInput_grid").jqGrid("addRowData", adjustmentOutApprovalSerialNoDetaillastRowId, data.listAdjustmentOutSerialNoDetail[i]);
                $("#adjustmentOutApprovalSerialNoDetailInput_grid").jqGrid('setRowData',adjustmentOutApprovalSerialNoDetaillastRowId,{
                    adjustmentOutApprovalSerialNoDetailItemCode         : data.listAdjustmentOutSerialNoDetail[i].itemMaterialCode,
                    adjustmentOutApprovalSerialNoDetailItemName         : data.listAdjustmentOutSerialNoDetail[i].itemMaterialName,
                    adjustmentOutApprovalSerialNoDetailSerialNo         : data.listAdjustmentOutSerialNoDetail[i].serialNo,
                    adjustmentOutApprovalSerialNoDetailReasonCode       : data.listAdjustmentOutSerialNoDetail[i].reasonCode,
                    adjustmentOutApprovalSerialNoDetailReasonName       : data.listAdjustmentOutSerialNoDetail[i].reasonName,
                    adjustmentOutApprovalSerialNoDetailCapacity         : data.listAdjustmentOutSerialNoDetail[i].capacity,
                    adjustmentOutApprovalSerialNoDetailUsedCapacity     : data.listAdjustmentOutSerialNoDetail[i].capacity,
                    adjustmentOutApprovalSerialNoDetailBalanceCapacity  : data.listAdjustmentOutSerialNoDetail[i].capacity,
                    adjustmentOutApprovalSerialNoDetailIotCapacity      : data.listAdjustmentOutSerialNoDetail[i].capacity,
//                    adjustmentOutApprovalSerialNoDetailUnitOfMeasureCode: data.listAdjustmentOutSerialNoDetail[i].uomCode,
                    adjustmentOutApprovalSerialNoDetailRackCode         : data.listAdjustmentOutSerialNoDetail[i].rackCode,
                    adjustmentOutApprovalSerialNoDetailRackName         : data.listAdjustmentOutSerialNoDetail[i].rackName
                   
                });
                
            }
        });
    }
    
    function formatDateIOTApproval(){
        
        var transactionDateValue=dtpAdjustmentOutApprovalTransactionDate.val();
        var transactionDateValuesTemp=transactionDateValue.split(' ');
        var transactionDateValues=transactionDateValuesTemp[0].split('/');
        var transactionDate = transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2]+" "+transactionDateValuesTemp[1];
        dtpAdjustmentOutApprovalTransactionDate.val(transactionDate);
        $("#adjustmentOutApproval\\.transactionDateTemp").val(transactionDate);
        
        var updatedDateValue=dtpAdjustmentOutApprovalUpdatedDate.val();
        var updatedDateValueTemp=updatedDateValue.split(' ');
        var updatedDateValues=updatedDateValueTemp[0].split('/');
        var updatedDate = updatedDateValues[1]+"/"+updatedDateValues[0]+"/"+updatedDateValues[2]+" "+updatedDateValueTemp[1];
        dtpAdjustmentOutApprovalUpdatedDate.val(updatedDate);
        $("#adjustmentOutApproval\\.updatedDateTemp").val(updatedDate);
        
        var createdDateValue=dtpAdjustmentOutApprovalCreatedDate.val();
        var createdDateValuesTemp=createdDateValue.split(' ');
        var createdDateValues=createdDateValuesTemp[0].split('/');
        var createdDate = createdDateValues[1]+"/"+createdDateValues[0]+"/"+createdDateValues[2]+" "+createdDateValuesTemp[1];
        dtpAdjustmentOutApprovalCreatedDate.val(createdDate);
        $("#adjustmentOutApproval\\.createdDateTemp").val(createdDate);
       
    }
    
    function setHeightGridIOTApproval(){
        var ids = jQuery("#adjustmentOutApprovalItemDetailInput_grid").jqGrid('getDataIDs'); 
        
        if(ids.length > 15){
            var rowHeight = $("#adjustmentOutApprovalItemDetailInput_grid"+" tr").eq(1).height();
            $("#adjustmentOutApprovalItemDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#adjustmentOutApprovalItemDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    
</script>
<b> ADJUSTMENT OUT APPROVAL</b>
<hr>
<br class="spacer" />

<div id="adjustmentOutApprovalInput" class="content ui-widget">
    <s:form id="frmAdjustmentOutApprovalInput">
        <div id="div-header-iot-approval">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>IOT No *</B></td>
                    <td>
                        <s:textfield id="adjustmentOutApproval.code" name="adjustmentOutApproval.code" size="20" readonly="true"></s:textfield>
                    </td>
                    <script type = "text/javascript">
                            txtAdjustmentOutApprovalCode.after(function(ev) {
                                loadDataItemDetailAdjustmentOutApproval();
                                loadDataSerialNoDetailAdjustmentOutApproval();
                            });
                    </script>
                </tr>
                <tr>
                    <td align="right" valign="top"><B>Branch *</B></td>
                    <td colspan="2">
                        <s:textfield id="adjustmentOutApproval.branch.code" name="adjustmentOutApproval.branch.code" required="true" cssClass="required" title=" " size="20" readonly="true"></s:textfield>
                        <s:textfield id="adjustmentOutApproval.branch.name" name="adjustmentOutApproval.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td align="right" valign="top"><B>Currency *</B></td>
                    <td colspan="2">
                        <s:textfield id="adjustmentOutApproval.currency.code" name="adjustmentOutApproval.currency.code" required="true" cssClass="required" title=" " size="20" readonly="true"></s:textfield>
                        <s:textfield id="adjustmentOutApproval.currency.name" name="adjustmentOutApproval.currency.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td size="15" align="right"><B>Exchange Rate *</B>
                    <td>
                        <s:textfield id="adjustmentOutApproval.exchangeRate" name="adjustmentOutApproval.exchangeRate" formatter="number" required="true" cssStyle="text-align:right" ></s:textfield><B>IDR</B>
                    </td>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="adjustmentOutApproval.transactionDate" name="adjustmentOutApproval.transactionDate" displayFormat="dd/mm/yy"  title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" readonly="true" ></sj:datepicker>
                    </td>
                </tr>
               
                <tr>
                    <td align="right"><B>Warehouse *</B></td>
                    <td colspan="2">
                        <s:textfield id="adjustmentOutApproval.warehouse.code" name="adjustmentOutApproval.warehouse.code" size="25" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                        <s:textfield id="adjustmentOutApproval.warehouse.name" name="adjustmentOutApproval.warehouse.name" size="45" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="adjustmentOutApproval.refNo" name="adjustmentOutApproval.refNo" size="30" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td>
                        <s:textarea id="adjustmentOutApproval.remark" name="adjustmentOutApproval.remark"  rows="3" cols="70" readonly="true"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Status *</B></td>
                    <td>
                        <s:radio id="adjustmentOutApprovalApprovalStatusRad" name="adjustmentOutApprovalApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="adjustmentOutApproval.approvalStatus" name="adjustmentOutApproval.approvalStatus" size="5" style="display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                <td width="120px" align="right"><B>Reason *</B> </td>
                <td>
                        <script type = "text/javascript">
                            $('#AdjustmentOut_btnReason').click(function(ev) {
                                window.open("./pages/search/search-reason.jsp?iddoc=adjustmentOutApproval&idsubdoc=approvalReason&modulecode="+$("#adjustmentOutApprovalModuleCode").val(),"Search", "Scrollbars=1,width=600, height=500");
                            });
                            txtAdjustmentOutApprovalReasonCode.change(function(ev) {

                                if(txtAdjustmentOutApprovalReasonCode.val()===""){
                                    txtAdjustmentOutApprovalReasonName.val("");
                                    return;
                                }
                                var url = "master/reason-get";
                                var params = "reason.code=" + txtAdjustmentOutApprovalReasonCode.val();
                                    params += "&reason.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.reasonTemp){
                                        txtAdjustmentOutApprovalReasonCode.val(data.reasonTemp.code);
                                        txtAdjustmentOutApprovalReasonName.val(data.reasonTemp.name);
                                    }
                                    else{
                                        alertMessage("Reason Not Found!",txtAdjustmentOutApprovalReasonCode);
                                        txtAdjustmentOutApprovalReasonCode.val("");
                                        txtAdjustmentOutApprovalReasonName.val("");
                                    }
                                });
                            });

                            if($("#purchaseOrderUpdateMode").val()==="true"){
                                txtAdjustmentOutApprovalReasonCode.attr("readonly",true);
                                $("#AdjustmentOut_btnReason").hide();
                                $("#ui-icon-search-reason-purchase-order").hide();
                            }else{
                                txtAdjustmentOutApprovalReasonCode.attr("readonly",false);
                                $("#AdjustmentOut_btnReason").show();
                                $("#ui-icon-search-reason-purchase-order").show();
                            }
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="adjustmentOutApproval.approvalReason.code" name="adjustmentOutApproval.approvalReason.code" cssClass="required" required="true" title=" " size="15"></s:textfield>
                            <sj:a id="AdjustmentOut_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-reason-purchase-order"/></sj:a>
                        </div>
                        <s:textfield id="adjustmentOutApproval.approvalReason.name" name="adjustmentOutApproval.approvalReason.name" size="30" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Remark *</B> </td>
                    <td>
                        <s:textfield id="adjustmentOutApproval.approvalRemark" name="adjustmentOutApproval.approvalRemark" size="51" cols="40" cssClass="required" required="true" title=" " rows="3"></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td align="right">
                        <s:textfield id="adjustmentOutApproval.transactionDateTemp" name="adjustmentOutApproval.transactionDateTemp"></s:textfield>
                        <s:textfield id="adjustmentOutApproval.createdBy" name="adjustmentOutApproval.createdBy " size="5"></s:textfield>
                        <sj:datepicker id="adjustmentOutApproval.createdDate" name="adjustmentOutApproval.createdDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" readonly="true"></sj:datepicker>
                        <s:textfield id="adjustmentOutApproval.createdDateTemp" name="adjustmentOutApproval.createdDateTemp" size="20"></s:textfield>
                        <s:textfield id="adjustmentOutApproval.updatedBy" name="adjustmentOutApproval.updatedBy " size="5"></s:textfield>
                        <sj:datepicker id="adjustmentOutApproval.updatedDate" name="adjustmentOutApproval.updatedDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" readonly="true"></sj:datepicker>
                        <s:textfield id="adjustmentOutApproval.updatedDateTemp" name="adjustmentOutApproval.updatedDateTemp" size="20"></s:textfield>
                    </td>
                </tr>
            </table>
        
            <br class="spacer" />

            <div id="adjustmentOutApprovalItemDetailInputGrid">
                <sjg:grid
                    id="adjustmentOutApprovalItemDetailInput_grid"
                    caption="Adjustment Out Item Detail"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listAdjustmentOutItemDetail"
                    rowList="10,20,30"
                    rowNum="10000"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuAdjustmentOutApproval').width()"
                >
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailCode" index = "adjustmentOutApprovalItemDetailCode" key = "adjustmentOutApprovalItemDetailCode" 
                        title = "Code" width = "150" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailItemCode" index = "adjustmentOutApprovalItemDetailItemCode" key = "adjustmentOutApprovalItemDetailItemCode" 
                        title = "Item Code *" width = "100" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailItemName" index = "adjustmentOutApprovalItemDetailItemName" key = "adjustmentOutApprovalItemDetailItemName" 
                        title = "Item Name" width = "250"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailItemSerialNoStatus" index = "adjustmentOutApprovalItemDetailItemSerialNoStatus" key = "adjustmentOutApprovalItemDetailItemSerialNoStatus" 
                        title = "Serial No Status" width = "80"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutApprovalItemDetailQuantity" index="adjustmentOutApprovalItemDetailQuantity" key="adjustmentOutApprovalItemDetailQuantity" 
                        title="Quantity *" width="80" align="right" edittype="text" editable="true"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailItemUnitOfMeasureCode" index = "adjustmentOutApprovalItemDetailItemUnitOfMeasureCode" key = "adjustmentOutApprovalItemDetailItemUnitOfMeasureCode" 
                        title = "Unit" width = "100"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailRemark" index="adjustmentOutApprovalItemDetailRemark" key="adjustmentOutApprovalItemDetailRemark" title="Remark" width="250"  editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailReasonCode" index = "adjustmentOutApprovalItemDetailReasonCode" key = "adjustmentOutApprovalItemDetailReasonCode" 
                        title = "Reason Code" width = "150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailReasonName" index = "adjustmentOutApprovalItemDetailReasonName" key = "adjustmentOutApprovalItemDetailReasonName" 
                        title = "Reason Name" width = "250"
                    />
                     <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailRackCode" index = "adjustmentOutApprovalItemDetailRackCode" key = "adjustmentOutApprovalItemDetailRackCode" 
                        title = "Rack Code" width = "150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutApprovalItemDetailRackName" index = "adjustmentOutApprovalItemDetailRackName" key = "adjustmentOutApprovalItemDetailRackName" 
                        title = "Rack Name" width = "250"
                    />
                </sjg:grid >
            </div>
        </div>
     
        <br class="spacer" />
    
        <div id="adjustmentOutApprovalSerialNoDetailInputGrid">
            <sjg:grid
                id="adjustmentOutApprovalSerialNoDetailInput_grid"
                caption="Adjustment Out Serial No Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAdjustmentOutSerialNoDetail"
                viewrecords="true"
                rownumbers="true"
                rowNum="10000"
                shrinkToFit="false"
                width="$('#tabmnuadjustmentoutapproval').width()"
                >
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailItemCode" index="adjustmentOutApprovalSerialNoDetailItemCode" key="adjustmentOutApprovalSerialNoDetailItemCode" 
                    title="Item Code" width="100" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailItemName" index="adjustmentOutApprovalSerialNoDetailItemName" key="adjustmentOutApprovalSerialNoDetailItemName" 
                    title="Item Name" width="150" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailSerialNo" index="adjustmentOutApprovalSerialNoDetailSerialNo" key="adjustmentOutApprovalSerialNoDetailSerialNo" 
                    title="Serial No" width="100" edittype="text"
                />
                 <sjg:gridColumn
                    name = "adjustmentOutApprovalSerialNoDetailReasonCode" index = "adjustmentOutApprovalSerialNoDetailReasonCode" key = "adjustmentOutApprovalSerialNoDetailReasonCode" 
                    title = "Reason Code *" width = "150" edittype="text" editable="true"
                />
                <sjg:gridColumn
                    name = "adjustmentOutApprovalSerialNoDetailReasonName" index = "adjustmentOutApprovalSerialNoDetailReasonName" key = "adjustmentOutApprovalSerialNoDetailReasonName" 
                    title = "Reason Name" width = "250"
                />
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailCapacity" index="adjustmentOutApprovalSerialNoDetailCapacity" key="adjustmentOutApprovalSerialNoDetailCapacity" 
                    title="Capacity" width="80" align="right" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailUsedCapacity" index="adjustmentOutApprovalSerialNoDetailUsedCapacity" key="adjustmentOutApprovalSerialNoDetailUsedCapacity" 
                    title="Used Capacity *" width="90" align="right" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailBalancedCapacity" index="adjustmentOutApprovalSerialNoDetailBalancedCapacity" key="adjustmentOutApprovalSerialNoDetailBalancedCapacity" 
                    title="Balance Capacity *" width="100" align="right" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                 <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailIotCapacity" index="adjustmentOutApprovalSerialNoDetailIotCapacity" key="adjustmentOutApprovalSerialNoDetailIotCapacity" 
                    title="IOT Capacity *" width="90" align="right" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
               <%--<sjg:gridColumn
                    name = "adjustmentOutApprovalSerialNoDetailUnitOfMeasureCode" index = "adjustmentOutApprovalSerialNoDetailUnitOfMeasureCode" key = "adjustmentOutApprovalSerialNoDetailUnitOfMeasureCode" 
                    title = "UOM" width = "100"
                />--%>
                 <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailRackCode" index="adjustmentOutApprovalSerialNoDetailRackCode" key="adjustmentOutApprovalSerialNoDetailRackCode" 
                    title="Rack Code *" width="100" editable="true"
                />
                <sjg:gridColumn
                    name="adjustmentOutApprovalSerialNoDetailRackName" index="adjustmentOutApprovalSerialNoDetailRackName" key="adjustmentOutApprovalSerialNoDetailRackName" 
                    title="Rack Name" width="100"
                />
            </sjg:grid >
        </div>        
        <br class="spacer" />
        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnAdjustmentOutApprovalSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAdjustmentOutApprovalCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        
    </s:form>
</div>