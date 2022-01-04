
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style> 
    #purchaseRequestNonItemMaterialRequestClosingDetailInput_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
    var purchaseRequestNonItemMaterialRequestClosingDetailLastRowId = 0;
    
    var                                    
        txtPurchaseRequestNonItemMaterialRequestClosingCode = $("#purchaseRequestNonItemMaterialRequestClosing\\.code"),
        txtPurchaseRequestNonItemMaterialRequestClosingReasonCode = $("#purchaseRequestNonItemMaterialRequestClosing\\.closingReason\\.code"),
        txtPurchaseRequestNonItemMaterialRequestClosingReasonName = $("#purchaseRequestNonItemMaterialRequestClosing\\.closingReason\\.name");
    
        
    $(document).ready(function(){
        hoverButton();        
          
        $('#btnCancelPurchaseRequestNonItemMaterialRequestClosing').click(function(ev) {
            var url = "purchasing/purchase-request-non-item-material-request-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR_CLOSING"); 
        });
        
        $('#btnApprovePurchaseRequestNonItemMaterialRequestClosing').click(function(ev) {
            if($('#purchaseRequestNonItemMaterialRequestClosing\\.approvalStatus').val()===""){
                alertMessage("Please select one Options Status Approval!",300,"");
                return;
            }
            
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are you sure to processed this Transaction: '+txtPurchaseRequestNonItemMaterialRequestClosingCode.val()+'<br/></div>');
            dynamicDialog.dialog({
                title           : "Confirmation",
                closeOnEscape   : false,
                modal           : true,
                width           : 500,
                resizable       : false,
                buttons         : 
                                [{
                                    text : "Yes",
                                    click : function() {
                                        $(this).dialog("close");
                                        
                                        var url="purchasing/purchase-request-non-item-material-request-closing-save";
                                        var params = $("#frmPurchaseRequestNonItemMaterialRequestClosingInput").serialize();
                                            
                                        showLoading();
                                        $.post(url, params, function(data) {
                                            closeLoading();
                                            if (data.error) {
                                                alert(data.errorMessage);
                                                return;
                                            }

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
                                                                        var url = "purchasing/purchase-request-non-item-material-request-closing";
                                                                        var params = "";
                                                                        pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR_CLOSING");
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
    
    function loadDataPurchaseRequestNonItemMaterialRequestClosingDetail() {
        
        var url = "purchasing/purchase-request-non-item-material-request-detail-data";
        var params = "purchaseRequestNonItemMaterialRequest.code=" + txtPurchaseRequestNonItemMaterialRequestClosingCode.val();
        
        $.getJSON(url, params, function(data) {
            purchaseRequestNonItemMaterialRequestClosingDetailLastRowId = 0;

            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseRequestNonItemMaterialRequestClosingDetailLastRowId++;
                $("#purchaseRequestNonItemMaterialRequestClosingDetailInput_grid").jqGrid("addRowData", purchaseRequestNonItemMaterialRequestClosingDetailLastRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseRequestNonItemMaterialRequestClosingDetailInput_grid").jqGrid('setRowData',purchaseRequestNonItemMaterialRequestClosingDetailLastRowId,{
                    purchaseRequestNonItemMaterialRequestClosingDetailItemDelete                    : "delete",
                    purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialSearch            : "...",
                    purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialCode              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialName              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseRequestNonItemMaterialRequestClosingDetailQuantity                      : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseRequestNonItemMaterialRequestClosingDetailOnHandStock                   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].onHandStock,
                    purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureCode             : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureName             : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseRequestNonItemMaterialRequestClosingDetailRemark                        : data.listPurchaseRequestNonItemMaterialRequestDetail[i].remark
                });
            }
        });
    }

</script>
<s:url id="remotedetailurlPurchaseRequestNonItemMaterialRequestClosingDetailInput" action="" />

<b>PURCHASE REQUEST NON ITEM MATERIAL REQUEST APPROVAL</b>
<hr>
<br class="spacer" />

<div id="purchaseRequestNonItemMaterialRequestClosingInput" class="content ui-widget">
    <s:form id="frmPurchaseRequestNonItemMaterialRequestClosingInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerPurchaseRequestNonItemMaterialRequestClosingInput">
            <tr>
                <td align="right" width="100px">PRQ-Non IMR No</td>
                <td>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.code" name="purchaseRequestNonItemMaterialRequestClosing.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                    <script type = "text/javascript">

                        txtPurchaseRequestNonItemMaterialRequestClosingCode.after(function(ev) {
                            loadDataPurchaseRequestNonItemMaterialRequestClosingDetail();
                        });
                    
                    </script>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px">Transaction Date</td>
                <td>
                    <sj:datepicker id="purchaseRequestNonItemMaterialRequestClosing.transactionDate" name="purchaseRequestNonItemMaterialRequestClosing.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.branch.code" name="purchaseRequestNonItemMaterialRequestClosing.branch.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.branch.name" name="purchaseRequestNonItemMaterialRequestClosing.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Division</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.division.code" name="purchaseRequestNonItemMaterialRequestClosing.division.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.division.name" name="purchaseRequestNonItemMaterialRequestClosing.division.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Department</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.division.department.code" name="purchaseRequestNonItemMaterialRequestClosing.division.department.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.division.department.name" name="purchaseRequestNonItemMaterialRequestClosing.division.department.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequestClosing.requestBy" name="purchaseRequestNonItemMaterialRequestClosing.requestBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequestClosing.refNo" name="purchaseRequestNonItemMaterialRequestClosing.refNo" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="purchaseRequestNonItemMaterialRequestClosing.remark" name="purchaseRequestNonItemMaterialRequestClosing.remark" cols="53" rows="3" readonly="true"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td align="right">Status </td>
                <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.closingStatus" name="purchaseRequestNonItemMaterialRequestClosing.closingStatus" readonly="false" size="15" style="display:none"></s:textfield>
            </tr>
            <tr>
                <td align="right">Reason</td>
                    <td colspan="2">
                    <script type = "text/javascript">
                        
                        $('#purchaseRequestNonItemMaterialRequestClosing_btnReason').click(function(ev) {
                            window.open("./pages/search/search-reason.jsp?iddoc=purchaseRequestNonItemMaterialRequestClosing&idsubdoc=closingReason","Search", "width=600, height=500");
                        });

                        txtPurchaseRequestNonItemMaterialRequestClosingReasonCode.change(function(ev) {

                            if(txtPurchaseRequestNonItemMaterialRequestClosingReasonCode.val()===""){
                                txtPurchaseRequestNonItemMaterialRequestClosingReasonName.val("");
                                return;
                            }
                            var url = "master/reason-get";
                            var params = "reason.code=" + txtPurchaseRequestNonItemMaterialRequestClosingReasonCode.val();
                                params += "&reason.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.reasonTemp){
                                    txtPurchaseRequestNonItemMaterialRequestClosingReasonCode.val(data.reasonTemp.code);
                                    txtPurchaseRequestNonItemMaterialRequestClosingReasonName.val(data.reasonTemp.name);
                                }
                                else{
                                    alertMessage("Reason Not Found!",txtPurchaseRequestNonItemMaterialRequestClosingReasonCode);
                                    txtPurchaseRequestNonItemMaterialRequestClosingReasonCode.val("");
                                    txtPurchaseRequestNonItemMaterialRequestClosingReasonName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.closingReason.code" name="purchaseRequestNonItemMaterialRequestClosing.closingReason.code" size="25"></s:textfield>
                        <sj:a id="purchaseRequestNonItemMaterialRequestClosing_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.closingReason.name" name="purchaseRequestNonItemMaterialRequestClosing.closingReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr>
                <td align="right">Closing Remark</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequestClosing.closingRemark" name="purchaseRequestNonItemMaterialRequestClosing.closingRemark" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr height="10px"/>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnApprovePurchaseRequestNonItemMaterialRequestClosing" button="true">Close</sj:a>
                    <sj:a href="#" id="btnCancelPurchaseRequestNonItemMaterialRequestClosing" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />        
        <div id="id-purchase-request-non-so-detail">
            <div id="purchaseRequestNonItemMaterialRequestClosingDetailInputGrid">
                <sjg:grid
                    id="purchaseRequestNonItemMaterialRequestClosingDetailInput_grid"
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
                    width="$('#tabmnuPurchaseRequestNonItemMaterialRequestClosingDetail').width()"
                >
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestClosingDetail" index="purchaseRequestNonItemMaterialRequestClosingDetail" key="purchaseRequestNonItemMaterialRequestClosingDetail" title=""  hidden="true"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialCode" index = "purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialCode" key = "purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialCode" title = "Item Code" width = "120"
                        editoptions="{onchange:'purchaseRequestNonItemMaterialRequestClosingDetailInputGrid_SearchItem_OnChange()'}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialName" index = "purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialName" key = "purchaseRequestNonItemMaterialRequestClosingDetailItemMaterialName" title = "Item Name" width = "150"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestClosingDetailRemark" index="purchaseRequestNonItemMaterialRequestClosingDetailRemark" key="purchaseRequestNonItemMaterialRequestClosingDetailRemark" title="Remark" width="150" 
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestClosingDetailOnHandStock" index="purchaseRequestNonItemMaterialRequestClosingDetailOnHandStock" key="purchaseRequestNonItemMaterialRequestClosingDetailOnHandStock" title="On Hand Stock" 
                        width="150" align="right" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestClosingDetailQuantity" index="purchaseRequestNonItemMaterialRequestClosingDetailQuantity" key="purchaseRequestNonItemMaterialRequestClosingDetailQuantity" title="Request Quantity" 
                        width="150" align="right" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureCode" index = "purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureCode" key = "purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureCode" title = "UOM" width = "100"
                        hidden="true"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureName" index = "purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureName" key = "purchaseRequestNonItemMaterialRequestClosingDetailUnitOfMeasureName" title = "UOM" width = "100"
                    />
                </sjg:grid >
            </div>
        </div>     
    </s:form>
</div>
    

