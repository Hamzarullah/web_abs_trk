
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
    var internalMemoMaterialClosingDetailLastRowId = 0, internalMemoMaterialClosingDetailLastSel = -1;
    var                                    
        txtInternalMemoMaterialClosingCode = $("#internalMemoMaterialClosing\\.code"),
        dtpInternalMemoMaterialClosingTransactionDate = $("#internalMemoMaterialClosing\\.transactionDate"),
        txtInternalMemoMaterialClosingReasonCode = $("#internalMemoMaterialClosing\\.reason\\.code"),
        txtInternalMemoMaterialClosingReasonName = $("#internalMemoMaterialClosing\\.reason\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedIMM=false;
        hoverButton();
        
        $('input[name="internalMemoMaterialClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#internalMemoMaterialClosing\\.closingStatus").val("CLOSED");
        });
        
        $('input[name="internalMemoMaterialClosingStatusRad"][value="OPEN]"').change(function(ev){
            $("#internalMemoMaterialClosing\\.closingStatus").val("OPEN");
        });
        
    //Set Default View
        loadDataInternalMemoMaterialClosingDetail();
       
        $('#btnInternalMemoMaterialClosingSave').click(function(ev) {
            
            if($('#internalMemoMaterialClosing\\.closingStatus').val()===""){
                alertMessage("Please select one Options Status Closing!",250,"");
                return;
            }
            
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 5px 15px 0;">'+
                '</span>Are you sure to upadate the status?: '+txtInternalMemoMaterialClosingCode.val()+'<br/></div>');
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
                                        var url="sales/internal-memo-material-closing-save";
                                        var params = $("#frmInternalMemoMaterialClosingInput").serialize();
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
                                                                        var url = "sales/internal-memo-material-closing";
                                                                        var params = "";
                                                                        pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_CLOSING");
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
               
        $('#btnInternalMemoMaterialClosingCancel').click(function(ev) {
            var url = "sales/internal-memo-material-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_CLOSING"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("InternalMemoMaterialClosingDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#internalMemoMaterialClosingDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==internalMemoMaterialClosingDetailLastSel) {
                $('#internalMemoMaterialClosingDetailInput_grid').jqGrid("saveRow",internalMemoMaterialClosingDetailLastSel); 
                $('#internalMemoMaterialClosingDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                internalMemoMaterialClosingDetailLastSel=selectedRowID;
            }
            else{
                $('#internalMemoMaterialClosingDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
    }); //EOF Ready
    
    function loadDataInternalMemoMaterialClosingDetail() {
        
        var url = "sales/internal-memo-material-detail-closing-data";
        var params = "internalMemoMaterialClosing.code=" + txtInternalMemoMaterialClosingCode.val();
        
        $.getJSON(url, params, function(data) {
            internalMemoMaterialClosingDetailLastRowId = 0;

            for (var i=0; i<data.listInternalMemoMaterialClosingDetail.length; i++) {
                internalMemoMaterialClosingDetailLastRowId++;
                $("#internalMemoMaterialClosingDetailInput_grid").jqGrid("addRowData", internalMemoMaterialClosingDetailLastRowId, data.listInternalMemoMaterialClosingDetail[i]);
                $("#internalMemoMaterialClosingDetailInput_grid").jqGrid('setRowData',internalMemoMaterialClosingDetailLastRowId,{
                    internalMemoMaterialClosingDetailItemDelete                   : "delete",
                    internalMemoMaterialClosingDetailItemMaterialSearch            : "...",
                    internalMemoMaterialClosingDetailItemMaterialCode              : data.listInternalMemoMaterialClosingDetail[i].itemMaterialCode,
                    internalMemoMaterialClosingDetailItemMaterialName              : data.listInternalMemoMaterialClosingDetail[i].itemMaterialName,
                    internalMemoMaterialClosingDetailQuantity                      : data.listInternalMemoMaterialClosingDetail[i].quantity,
                    internalMemoMaterialClosingDetailOnHandStock                   : data.listInternalMemoMaterialClosingDetail[i].onHandStock,
                    internalMemoMaterialClosingDetailUnitOfMeasureCode             : data.listInternalMemoMaterialClosingDetail[i].unitOfMeasureCode,
                    internalMemoMaterialClosingDetailUnitOfMeasureName             : data.listInternalMemoMaterialClosingDetail[i].unitOfMeasureName,
                    internalMemoMaterialClosingDetailRemark                        : data.listInternalMemoMaterialClosingDetail[i].remark
                });
            }
        });
    }
    
    // function Grid Detail
    function setHeightGridPurchaseOrderNonSoDetail(){
        var ids = jQuery("#internalMemoMaterialClosingDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#internalMemoMaterialClosingDetailInput_grid"+" tr").eq(1).height();
            $("#internalMemoMaterialClosingDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#internalMemoMaterialClosingDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    // END function Grid Detail
    
    function formatDateInternalMemoMaterialClosing(){
        var transactionDate=formatDate(dtpInternalMemoMaterialClosingTransactionDate.val());
        dtpInternalMemoMaterialClosingTransactionDate.val(transactionDate);  
    }
    
    
</script>
<s:url id="remotedetailurlInternalMemoMaterialClosingDetailInput" action="" />

<b>INTERNAL MEMO MATERIAL CLOSING</b>
<hr>
<br class="spacer" />

<div id="internalMemoMaterialClosingInput" class="content ui-widget">
    <s:form id="frmInternalMemoMaterialClosingInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerInternalMemoMaterialClosingInput">
            <tr>
                <td align="right" width="100px"><b>IMM No *</b></td>
                <td><s:textfield id="internalMemoMaterialClosing.code" name="internalMemoMaterialClosing.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="internalMemoMaterialClosing.transactionDate" name="internalMemoMaterialClosing.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                        <s:textfield id="internalMemoMaterialClosing.branch.code" name="internalMemoMaterialClosing.branch.code" title="*" required="true" cssClass="required" size="15" readonly="true"></s:textfield>
                        <s:textfield id="internalMemoMaterialClosing.branch.name" name="internalMemoMaterialClosing.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Division</td>
                <td colspan="2">
                    <s:textfield id="internalMemoMaterialClosing.division.code" name="internalMemoMaterialClosing.division.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="internalMemoMaterialClosing.division.name" name="internalMemoMaterialClosing.division.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Department</td>
                <td colspan="2">
                    <s:textfield id="internalMemoMaterialClosing.division.department.code" name="internalMemoMaterialClosing.division.department.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="internalMemoMaterialClosing.division.department.name" name="internalMemoMaterialClosing.division.department.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id="internalMemoMaterialClosing.requestBy" name="internalMemoMaterialClosing.requestBy" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="internalMemoMaterialClosing.refNo" name="internalMemoMaterialClosing.refNo" title="*" required="true" cssClass="required" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="internalMemoMaterialClosing.remark" name="internalMemoMaterialClosing.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
            </tr>
            <tr>
                <td align="right">Reason</td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        
                        $('#internalMemoMaterialClosing_btnReason').click(function(ev) {
                            window.open("./pages/search/search-reason.jsp?iddoc=internalMemoMaterialClosing&idsubdoc=closingReason","Search", "width=600, height=500");
                        });

                        txtInternalMemoMaterialClosingReasonCode.change(function(ev) {

                            if(txtInternalMemoMaterialClosingReasonCode.val()===""){
                                txtInternalMemoMaterialClosingReasonName.val("");
                                return;
                            }
                            var url = "master/reason-get";
                            var params = "reason.code=" + txtInternalMemoMaterialClosingReasonCode.val();
                                params += "&reason.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.reasonTemp){
                                    txtInternalMemoMaterialClosingReasonCode.val(data.reasonTemp.code);
                                    txtInternalMemoMaterialClosingReasonName.val(data.reasonTemp.name);
                                }
                                else{
                                    alertMessage("Reason Not Found!",txtInternalMemoMaterialClosingReasonCode);
                                    txtInternalMemoMaterialClosingReasonCode.val("");
                                    txtInternalMemoMaterialClosingReasonName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="internalMemoMaterialClosing.closingReason.code" name="internalMemoMaterialClosing.closingReason.code" size="25"></s:textfield>
                        <sj:a id="internalMemoMaterialClosing_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="internalMemoMaterialClosing.closingReason.name" name="internalMemoMaterialClosing.closingReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="internalMemoMaterialClosing.createdBy" name="internalMemoMaterialClosing.createdBy"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <br class="spacer" />        
                
        <div id="id-internal-memo-material-closing-detail">
            <div id="internalMemoMaterialClosingDetailInputGrid">
                <sjg:grid
                    id="internalMemoMaterialClosingDetailInput_grid"
                    caption="INTERNAL MEMO MATERIAL DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listInternalMemoMaterialClosingDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuInternalMemoMaterialClosingDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlInternalMemoMaterialClosingDetailInput}"
                    onSelectRowTopics="InternalMemoMaterialClosingDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="internalMemoMaterialClosingDetail" index="internalMemoMaterialClosingDetail" key="internalMemoMaterialClosingDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialClosingDetailItemMaterialCode" index = "internalMemoMaterialClosingDetailItemMaterialCode" key = "internalMemoMaterialClosingDetailItemMaterialCode" title = "Item Code" width = "120" editable="false"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialClosingDetailItemMaterialName" index = "internalMemoMaterialClosingDetailItemMaterialName" key = "internalMemoMaterialClosingDetailItemMaterialName" title = "Item Name" width = "150"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialClosingDetailRemark" index="internalMemoMaterialClosingDetailRemark" key="internalMemoMaterialClosingDetailRemark" title="Remark" width="150"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialClosingDetailOnHandStock" index="internalMemoMaterialClosingDetailOnHandStock" key="internalMemoMaterialClosingDetailOnHandStock" title="On Hand Stock" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialClosingDetailQuantity" index="internalMemoMaterialClosingDetailQuantity" key="internalMemoMaterialClosingDetailQuantity" title="IMM Quantity" 
                        width="150" align="right" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialClosingDetailUnitOfMeasureCode" index = "internalMemoMaterialClosingDetailUnitOfMeasureCode" key = "internalMemoMaterialClosingDetailUnitOfMeasureCode" title = "UOM" width = "100"
                        hidden="true"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialClosingDetailUnitOfMeasureName" index = "internalMemoMaterialClosingDetailUnitOfMeasureName" key = "internalMemoMaterialClosingDetailUnitOfMeasureName" title = "UOM" width = "100"
                    />
                </sjg:grid >      
                <br class="spacer" />
            </div>
        </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnInternalMemoMaterialClosingSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnInternalMemoMaterialClosingCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>      
    </s:form>
</div>
    

