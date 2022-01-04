
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
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>
<script type="text/javascript">
    var internalMemoMaterialApprovalDetailLastRowId = 0, internalMemoMaterialApprovalDetailLastSel = -1;
    var                                    
        txtInternalMemoMaterialApprovalCode = $("#internalMemoMaterialApproval\\.code"),
        dtpInternalMemoMaterialApprovalTransactionDate = $("#internalMemoMaterialApproval\\.transactionDate"),
        txtInternalMemoMaterialApprovalReasonCode = $("#internalMemoMaterialApproval\\.reason\\.code"),
        txtInternalMemoMaterialApprovalReasonName = $("#internalMemoMaterialApproval\\.reason\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedIMM=false;
        hoverButton();
        
        $('input[name="internalMemoMaterialApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#internalMemoMaterialApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="internalMemoMaterialApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#internalMemoMaterialApproval\\.approvalStatus").val("REJECTED ");
        });
        
    //Set Default View
        loadDataInternalMemoMaterialApprovalDetail();
       
        $('#btnInternalMemoMaterialApprovalSave').click(function(ev) {
            
            if($('#internalMemoMaterialApproval\\.approvalStatus').val()===""){
                alertMessage("Please select one Options Status Approval!",250,"");
                return;
            }
            
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 5px 15px 0;">'+
                '</span>Are you sure to upadate the status?: '+txtInternalMemoMaterialApprovalCode.val()+'<br/></div>');
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
                                        var url="sales/internal-memo-material-approval-save";
                                        var params = $("#frmInternalMemoMaterialApprovalInput").serialize();
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
                                                                        var url = "sales/internal-memo-material-approval";
                                                                        var params = "";
                                                                        pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_APPROVAL");
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
               
        $('#btnInternalMemoMaterialApprovalCancel').click(function(ev) {
            var url = "sales/internal-memo-material-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_APPROVAL"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("InternalMemoMaterialApprovalDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#internalMemoMaterialApprovalDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==internalMemoMaterialApprovalDetailLastSel) {
                $('#internalMemoMaterialApprovalDetailInput_grid').jqGrid("saveRow",internalMemoMaterialApprovalDetailLastSel); 
                $('#internalMemoMaterialApprovalDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                internalMemoMaterialApprovalDetailLastSel=selectedRowID;
            }
            else{
                $('#internalMemoMaterialApprovalDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
    }); //EOF Ready
    
    function loadDataInternalMemoMaterialApprovalDetail() {
        
        var url = "sales/internal-memo-material-detail-approval-data";
        var params = "internalMemoMaterialApproval.code=" + txtInternalMemoMaterialApprovalCode.val();
        
        $.getJSON(url, params, function(data) {
            internalMemoMaterialApprovalDetailLastRowId = 0;

            for (var i=0; i<data.listInternalMemoMaterialApprovalDetail.length; i++) {
                internalMemoMaterialApprovalDetailLastRowId++;
                $("#internalMemoMaterialApprovalDetailInput_grid").jqGrid("addRowData", internalMemoMaterialApprovalDetailLastRowId, data.listInternalMemoMaterialApprovalDetail[i]);
                $("#internalMemoMaterialApprovalDetailInput_grid").jqGrid('setRowData',internalMemoMaterialApprovalDetailLastRowId,{
                    internalMemoMaterialApprovalDetailItemDelete                   : "delete",
                    internalMemoMaterialApprovalDetailItemMaterialSearch            : "...",
                    internalMemoMaterialApprovalDetailItemMaterialCode              : data.listInternalMemoMaterialApprovalDetail[i].itemMaterialCode,
                    internalMemoMaterialApprovalDetailItemMaterialName              : data.listInternalMemoMaterialApprovalDetail[i].itemMaterialName,
                    internalMemoMaterialApprovalDetailQuantity                      : data.listInternalMemoMaterialApprovalDetail[i].quantity,
                    internalMemoMaterialApprovalDetailOnHandStock                   : data.listInternalMemoMaterialApprovalDetail[i].onHandStock,
                    internalMemoMaterialApprovalDetailUnitOfMeasureCode             : data.listInternalMemoMaterialApprovalDetail[i].unitOfMeasureCode,
                    internalMemoMaterialApprovalDetailUnitOfMeasureName             : data.listInternalMemoMaterialApprovalDetail[i].unitOfMeasureName,
                    internalMemoMaterialApprovalDetailRemark                        : data.listInternalMemoMaterialApprovalDetail[i].remark
                });
            }
        });
    }
    
    // function Grid Detail
    function setHeightGridPurchaseOrderNonSoDetail(){
        var ids = jQuery("#internalMemoMaterialApprovalDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#internalMemoMaterialApprovalDetailInput_grid"+" tr").eq(1).height();
            $("#internalMemoMaterialApprovalDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#internalMemoMaterialApprovalDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    // END function Grid Detail
    function formatDateInternalMemoMaterialApproval(){
        var transactionDate=formatDate(dtpInternalMemoMaterialApprovalTransactionDate.val());
        dtpInternalMemoMaterialApprovalTransactionDate.val(transactionDate);  
    }
    
    
</script>
<s:url id="remotedetailurlInternalMemoMaterialApprovalDetailInput" action="" />

<b>INTERNAL MEMO MATERIAL APPROVAL</b>
<hr>
<br class="spacer" />

<div id="internalMemoMaterialApprovalInput" class="content ui-widget">
    <s:form id="frmInternalMemoMaterialApprovalInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerInternalMemoMaterialApprovalInput">
            <tr>
                <td align="right" width="100px"><b>IMM No *</b></td>
                <td><s:textfield id="internalMemoMaterialApproval.code" name="internalMemoMaterialApproval.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="internalMemoMaterialApproval.transactionDate" name="internalMemoMaterialApproval.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                        <s:textfield id="internalMemoMaterialApproval.branch.code" name="internalMemoMaterialApproval.branch.code" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                        <s:textfield id="internalMemoMaterialApproval.branch.name" name="internalMemoMaterialApproval.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Division</td>
                <td colspan="2">
                    <s:textfield id="internalMemoMaterialApproval.division.code" name="internalMemoMaterialApproval.division.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="internalMemoMaterialApproval.division.name" name="internalMemoMaterialApproval.division.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Department</td>
                <td colspan="2">
                    <s:textfield id="internalMemoMaterialApproval.division.department.code" name="internalMemoMaterialApproval.division.department.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="internalMemoMaterialApproval.division.department.name" name="internalMemoMaterialApproval.division.department.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id="internalMemoMaterialApproval.requestBy" name="internalMemoMaterialApproval.requestBy" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="internalMemoMaterialApproval.refNo" name="internalMemoMaterialApproval.refNo" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="internalMemoMaterialApproval.remark" name="internalMemoMaterialApproval.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
            </tr>
            <tr>
                <td align="right">Status </td>
                <s:textfield id="internalMemoMaterialApproval.approvalStatus" name="internalMemoMaterialApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                <td><s:radio id="internalMemoMaterialApprovalStatusRad" name="internalMemoMaterialApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
            </tr>
            <tr>
                <td align="right">Reason</td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        
                        $('#internalMemoMaterialApproval_btnReason').click(function(ev) {
                            window.open("./pages/search/search-reason.jsp?iddoc=internalMemoMaterialApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                        });

                        txtInternalMemoMaterialApprovalReasonCode.change(function(ev) {

                            if(txtInternalMemoMaterialApprovalReasonCode.val()===""){
                                txtInternalMemoMaterialApprovalReasonName.val("");
                                return;
                            }
                            var url = "master/reason-get";
                            var params = "reason.code=" + txtInternalMemoMaterialApprovalReasonCode.val();
                                params += "&reason.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.reasonTemp){
                                    txtInternalMemoMaterialApprovalReasonCode.val(data.reasonTemp.code);
                                    txtInternalMemoMaterialApprovalReasonName.val(data.reasonTemp.name);
                                }
                                else{
                                    alertMessage("Reason Not Found!",txtInternalMemoMaterialApprovalReasonCode);
                                    txtInternalMemoMaterialApprovalReasonCode.val("");
                                    txtInternalMemoMaterialApprovalReasonName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="internalMemoMaterialApproval.approvalReason.code" name="internalMemoMaterialApproval.approvalReason.code" size="25"></s:textfield>
                        <sj:a id="internalMemoMaterialApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="internalMemoMaterialApproval.approvalReason.name" name="internalMemoMaterialApproval.approvalReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="internalMemoMaterialApproval.createdBy" name="internalMemoMaterialApproval.createdBy"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <br class="spacer" />        
                
        <div id="id-internal-memo-material-approval-detail">
            <div id="internalMemoMaterialApprovalDetailInputGrid">
                <sjg:grid
                    id="internalMemoMaterialApprovalDetailInput_grid"
                    caption="INTERNAL MEMO MATERIAL DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listInternalMemoMaterialApprovalDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuInternalMemoMaterialApprovalDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlInternalMemoMaterialApprovalDetailInput}"
                    onSelectRowTopics="InternalMemoMaterialApprovalDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="internalMemoMaterialApprovalDetail" index="internalMemoMaterialApprovalDetail" key="internalMemoMaterialApprovalDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialApprovalDetailItemMaterialCode" index = "internalMemoMaterialApprovalDetailItemMaterialCode" key = "internalMemoMaterialApprovalDetailItemMaterialCode" title = "Item Code" width = "120" editable="false"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialApprovalDetailItemMaterialName" index = "internalMemoMaterialApprovalDetailItemMaterialName" key = "internalMemoMaterialApprovalDetailItemMaterialName" title = "Item Name" width = "150"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialApprovalDetailRemark" index="internalMemoMaterialApprovalDetailRemark" key="internalMemoMaterialApprovalDetailRemark" title="Remark" width="150"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialApprovalDetailOnHandStock" index="internalMemoMaterialApprovalDetailOnHandStock" key="internalMemoMaterialApprovalDetailOnHandStock" title="On Hand Stock" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialApprovalDetailQuantity" index="internalMemoMaterialApprovalDetailQuantity" key="internalMemoMaterialApprovalDetailQuantity" title="IMM Quantity" 
                        width="150" align="right" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialApprovalDetailUnitOfMeasureCode" index = "internalMemoMaterialApprovalDetailUnitOfMeasureCode" key = "internalMemoMaterialApprovalDetailUnitOfMeasureCode" title = "UOM" width = "100"
                        hidden="true"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialApprovalDetailUnitOfMeasureName" index = "internalMemoMaterialApprovalDetailUnitOfMeasureName" key = "internalMemoMaterialApprovalDetailUnitOfMeasureName" title = "UOM" width = "100"
                    />
                </sjg:grid >      
                <br class="spacer" />
            </div>
        </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnInternalMemoMaterialApprovalSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnInternalMemoMaterialApprovalCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>      
    </s:form>
</div>
    

