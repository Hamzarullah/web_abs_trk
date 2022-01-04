
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style> 
    #purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
    var purchaseRequestNonItemMaterialRequestApprovalDetailLastRowId = 0, purchaseRequestNonItemMaterialRequestApprovalDetailLastSel = -1;
    
    var                                    
        txtPurchaseRequestNonItemMaterialRequestApprovalCode = $("#purchaseRequestNonItemMaterialRequestApproval\\.code"),
        txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode = $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalReason\\.code"),
        txtPurchaseRequestNonItemMaterialRequestApprovalReasonName = $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalReason\\.name");
    
        
    $(document).ready(function(){
        hoverButton();
          
        $('input[name="purchaseRequestNonItemMaterialRequestApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="purchaseRequestNonItemMaterialRequestApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("REJECTED ");
        });
        
          
        $('#btnCancelPurchaseRequestNonItemMaterialRequestApproval').click(function(ev) {
            var url = "purchasing/purchase-request-non-item-material-request-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR_APPROVAL"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("PurchaseRequestNonItemMaterialRequestApprovalDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==purchaseRequestNonItemMaterialRequestApprovalDetailLastSel) {
                $('#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid').jqGrid("saveRow",purchaseRequestNonItemMaterialRequestApprovalDetailLastSel); 
                $('#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid').jqGrid("editRow",selectedRowID,false);            
                purchaseRequestNonItemMaterialRequestApprovalDetailLastSel=selectedRowID;
            }
            else{
                $('#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnApprovePurchaseRequestNonItemMaterialRequestApproval').click(function(ev) {
            if($('#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus').val()===""){
                alertMessage("Please select one Options Status Approval!",250,"");
                return;
            }
            
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 5px 15px 0;">'+
                '</span>Are you sure to upadate the status?: '+txtPurchaseRequestNonItemMaterialRequestApprovalCode.val()+'<br/></div>');
            dynamicDialog.dialog({
                title           : "Confirmation",
                closeOnEscape   : false,
                modal           : true,
                width           : 250,
                resizable       : false,
                buttons         : 
                                [{
                                    text : "Yes",
                                    click : function() {
                                        $(this).dialog("close");
                                        if(purchaseRequestNonItemMaterialRequestApprovalDetailLastSel !== -1) {
                                            $('#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid').jqGrid("saveRow",purchaseRequestNonItemMaterialRequestApprovalDetailLastSel);
                                        }

                                        var listPurchaseRequestNonItemMaterialRequestDetail = new Array();
                                        var ids = jQuery("#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid").jqGrid('getDataIDs');

                                        for(var i=0;i < ids.length;i++){
                                            var data = $("#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid").jqGrid('getRowData',ids[i]);

                                            var purchaseRequestNonItemMaterialRequestDetail = {
                                                itemMaterial   : { code : data.purchaseRequestNonItemMaterialRequestApprovalDetailItemCode },
                                                quantity       : data.purchaseRequestNonItemMaterialRequestApprovalDetailQuantity,
                                                remark         : data.purchaseRequestNonItemMaterialRequestApprovalDetailRemark
                                            };

                                            listPurchaseRequestNonItemMaterialRequestDetail[i] = purchaseRequestNonItemMaterialRequestDetail;
                                        }
                                        
                                        var url="purchasing/purchase-request-non-item-material-request-approval-save";
                                        var params = $("#frmPurchaseRequestNonItemMaterialRequestApprovalInput").serialize();
                                            params += "&listPurchaseRequestNonItemMaterialRequestDetailJSON=" + $.toJSON(listPurchaseRequestNonItemMaterialRequestDetail); 
                                        showLoading();
                                        $.post(url, params, function(data) {
                                            closeLoading();
                                            if (data.error) {
                                                alert(data.errorMessage);
                                                return;
                                            }

                                            var dynamicDialog= $('<div id="conformBox">'+
                                            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 5px 15px 0;">'+
                                            '</span>'+data.message+'<br/></div>');
                                            dynamicDialog.dialog({
                                                title           : "Confirmation:",
                                                closeOnEscape   : false,
                                                modal           : true,
                                                width           : 250,
                                                resizable       : false,
                                                buttons         : 
                                                                [{
                                                                    text : "OK",
                                                                    click : function() {
                                                                        $(this).dialog("close");
                                                                        var url = "purchasing/purchase-request-non-item-material-request-approval";
                                                                        var params = "";
                                                                        pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR_APPROVAL");
                                                                    }
                                                                }]
                                            });
                                       });
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                    }
                                }
                                ]
            });           
        });
        
    }); //EOF Ready
    
    function loadDataPurchaseRequestNonItemMaterialRequestApprovalDetail() {
        
        var url = "purchasing/purchase-request-non-item-material-request-detail-data";
        var params = "purchaseRequestNonItemMaterialRequest.code=" + txtPurchaseRequestNonItemMaterialRequestApprovalCode.val();
        
        $.getJSON(url, params, function(data) {
            purchaseRequestNonItemMaterialRequestApprovalDetailLastRowId = 0;

            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseRequestNonItemMaterialRequestApprovalDetailLastRowId++;
                $("#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid").jqGrid("addRowData", purchaseRequestNonItemMaterialRequestApprovalDetailLastRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid").jqGrid('setRowData',purchaseRequestNonItemMaterialRequestApprovalDetailLastRowId,{
                    purchaseRequestNonItemMaterialRequestApprovalDetailItemCode              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseRequestNonItemMaterialRequestApprovalDetailItemName              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseRequestNonItemMaterialRequestApprovalDetailOnHandStock           : data.listPurchaseRequestNonItemMaterialRequestDetail[i].onHandStock,
                    purchaseRequestNonItemMaterialRequestApprovalDetailQuantity              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureCode     : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureName     : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseRequestNonItemMaterialRequestApprovalDetailRemark                : data.listPurchaseRequestNonItemMaterialRequestDetail[i].remark
                });
            }
        });
    }
    
</script>
<s:url id="remotedetailurlPurchaseRequestNonItemMaterialRequestApprovalDetailInput" action="" />

<b>PURCHASE REQUEST NON ITEM MATERIAL REQUEST APPROVAL</b>
<hr>
<br class="spacer" />

<div id="purchaseRequestNonItemMaterialRequestApprovalInput" class="content ui-widget">
    <s:form id="frmPurchaseRequestNonItemMaterialRequestApprovalInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerPurchaseRequestNonItemMaterialRequestApprovalInput">
            <tr>
                <td align="right" width="100px">PRQ-Non IMR No</td>
                <td>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.code" name="purchaseRequestNonItemMaterialRequestApproval.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                    <script type = "text/javascript">

                        txtPurchaseRequestNonItemMaterialRequestApprovalCode.after(function(ev) {
                            loadDataPurchaseRequestNonItemMaterialRequestApprovalDetail();
                        });
                    
                    </script>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px">Transaction Date</td>
                <td>
                    <sj:datepicker id="purchaseRequestNonItemMaterialRequestApproval.transactionDate" name="purchaseRequestNonItemMaterialRequestApproval.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.branch.code" name="purchaseRequestNonItemMaterialRequestApproval.branch.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.branch.name" name="purchaseRequestNonItemMaterialRequestApproval.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Division</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.division.code" name="purchaseRequestNonItemMaterialRequestApproval.division.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.division.name" name="purchaseRequestNonItemMaterialRequestApproval.division.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Department</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.division.department.code" name="purchaseRequestNonItemMaterialRequestApproval.division.department.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.division.department.name" name="purchaseRequestNonItemMaterialRequestApproval.division.department.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequestApproval.requestBy" name="purchaseRequestNonItemMaterialRequestApproval.requestBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequestApproval.refNo" name="purchaseRequestNonItemMaterialRequestApproval.refNo" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="purchaseRequestNonItemMaterialRequestApproval.remark" name="purchaseRequestNonItemMaterialRequestApproval.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
            </tr>
            <tr>
                <td align="right">Status </td>
                <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.approvalStatus" name="purchaseRequestNonItemMaterialRequestApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                <td><s:radio id="purchaseRequestNonItemMaterialRequestApprovalStatusRad" name="purchaseRequestNonItemMaterialRequestApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
            </tr>
            <tr>
                <td align="right">Reason</td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        
                        $('#purchaseRequestNonItemMaterialRequestApproval_btnReason').click(function(ev) {
                            window.open("./pages/search/search-reason.jsp?iddoc=purchaseRequestNonItemMaterialRequestApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                        });

                        txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode.change(function(ev) {

                            if(txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode.val()===""){
                                txtPurchaseRequestNonItemMaterialRequestApprovalReasonName.val("");
                                return;
                            }
                            var url = "master/reason-get";
                            var params = "reason.code=" + txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode.val();
                                params += "&reason.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.reasonTemp){
                                    txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode.val(data.reasonTemp.code);
                                    txtPurchaseRequestNonItemMaterialRequestApprovalReasonName.val(data.reasonTemp.name);
                                }
                                else{
                                    alertMessage("Reason Not Found!",txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode);
                                    txtPurchaseRequestNonItemMaterialRequestApprovalReasonCode.val("");
                                    txtPurchaseRequestNonItemMaterialRequestApprovalReasonName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.approvalReason.code" name="purchaseRequestNonItemMaterialRequestApproval.approvalReason.code" size="25"></s:textfield>
                        <sj:a id="purchaseRequestNonItemMaterialRequestApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.approvalReason.name" name="purchaseRequestNonItemMaterialRequestApproval.approvalReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr>
                <td align="right">Approval Remark</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequestApproval.approvalRemark" name="purchaseRequestNonItemMaterialRequestApproval.approvalRemark" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr height="10px"/>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnApprovePurchaseRequestNonItemMaterialRequestApproval" button="true">Approve</sj:a>
                    <sj:a href="#" id="btnCancelPurchaseRequestNonItemMaterialRequestApproval" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />        
        <div id="id-purchase-request-non-so-detail">
            <div id="purchaseRequestNonItemMaterialRequestApprovalDetailInputGrid">
                <sjg:grid
                    id="purchaseRequestNonItemMaterialRequestApprovalDetailInput_grid"
                    caption="PURCHASE REQUEST NON SALES ORDER DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseRequestNonItemMaterialRequestDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuPurchaseRequestNonItemMaterialRequestApprovalDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlPurchaseRequestNonItemMaterialRequestApprovalDetailInput}"
                    onSelectRowTopics="PurchaseRequestNonItemMaterialRequestApprovalDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestApprovalDetail" index="purchaseRequestNonItemMaterialRequestApprovalDetail" key="purchaseRequestNonItemMaterialRequestApprovalDetail" title=""  hidden="true"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestApprovalDetailItemCode" index = "purchaseRequestNonItemMaterialRequestApprovalDetailItemCode" key = "purchaseRequestNonItemMaterialRequestApprovalDetailItemCode" title = "Item Code" width = "120"
                        editoptions="{onchange:'purchaseRequestNonItemMaterialRequestApprovalDetailInputGrid_SearchItem_OnChange()'}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestApprovalDetailItemName" index = "purchaseRequestNonItemMaterialRequestApprovalDetailItemName" key = "purchaseRequestNonItemMaterialRequestApprovalDetailItemName" title = "Item Name" width = "150"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestApprovalDetailRemark" index="purchaseRequestNonItemMaterialRequestApprovalDetailRemark" key="purchaseRequestNonItemMaterialRequestApprovalDetailRemark" title="Remark" width="150" 
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestApprovalDetailOnHandStock" index="purchaseRequestNonItemMaterialRequestApprovalDetailOnHandStock" key="purchaseRequestNonItemMaterialRequestApprovalDetailOnHandStock" title="On Hand Stock" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestApprovalDetailQuantity" index="purchaseRequestNonItemMaterialRequestApprovalDetailQuantity" key="purchaseRequestNonItemMaterialRequestApprovalDetailQuantity" title="Request Quantity" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureCode" index = "purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureCode" key = "purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureCode" title = "UOM" width = "100"
                        hidden="true"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureName" index = "purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureName" key = "purchaseRequestNonItemMaterialRequestApprovalDetailUnitOfMeasureName" title = "UOM" width = "100"
                    />
                </sjg:grid >
            </div>
        </div>     
    </s:form>
</div>
    

