
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
    var purchaseRequestItemMaterialRequestDetailLastRowId = 0, purchaseRequestItemMaterialRequestDetailLastSel = -1;
    var                                    
        txtPurchaseRequestItemMaterialRequestCode = $("#purchaseRequestItemMaterialRequest\\.code"),
        dtpPurchaseRequestItemMaterialRequestTransactionDate = $("#purchaseRequestItemMaterialRequest\\.transactionDate"),
        txtPurchaseRequestItemMaterialRequestBranchCode = $("#purchaseRequestItemMaterialRequest\\.branch\\.code"),
        txtPurchaseRequestItemMaterialRequestBranchName = $("#purchaseRequestItemMaterialRequest\\.branch\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedPurchaseRequestItemMaterialRequest=false;
        hoverButton();
        
        //Set Default View
        $("#btnUnConfirmPurchaseRequestItemMaterialRequest").css("display", "none");
        $('#purchaseRequestItemMaterialRequestAllDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmPurchaseRequestItemMaterialRequest").click(function(ev) {
            handlers_input_purchase_request_imr();
            
            if(txtPurchaseRequestItemMaterialRequestBranchCode.val()===''){
                alertMessage("Branch Cant be Empty");
                return;
            }  
         
            flagIsConfirmedPurchaseRequestItemMaterialRequest=true;
            if($("#purchaseRequestItemMaterialRequestUpdateMode").val()==="true"){ 
                loadDataPurchaseRequestItemMaterialRequestDetail();
            }
           
            $("#btnUnConfirmPurchaseRequestItemMaterialRequest").css("display", "block");
            $("#btnConfirmPurchaseRequestItemMaterialRequest").css("display", "none");   
            $('#headerPurchaseRequestItemMaterialRequestInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#purchaseRequestItemMaterialRequestAllDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmPurchaseRequestItemMaterialRequest").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                $("#btnUnConfirmPurchaseRequestItemMaterialRequest").css("display", "none");
                $("#btnConfirmPurchaseRequestItemMaterialRequest").css("display", "block");
                $('#headerPurchaseRequestItemMaterialRequestInput').unblock();
                $('#purchaseRequestItemMaterialRequestAllDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                flagIsConfirmedPurchaseRequestItemMaterialRequest=false;
                return;
            }

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
                            flagIsConfirmedPurchaseRequestItemMaterialRequest=false;
                            $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmPurchaseRequestItemMaterialRequest").css("display", "none");
                            $("#btnConfirmPurchaseRequestItemMaterialRequest").css("display", "block");
                            $('#headerPurchaseRequestItemMaterialRequestInput').unblock();
                            $('#purchaseRequestItemMaterialRequestAllDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                        }
                    },
                    {
                        text : "No",
                        click : function() {

                            $(this).dialog("close");

                        }
                    }]
            });
        });
        
        $('#btnPurchaseRequestItemMaterialRequestSave').click(function(ev) {
                        
            if(!flagIsConfirmedPurchaseRequestItemMaterialRequest){
                alertMessage("Please Confirm!",$("#btnConfirmPurchaseRequestItemMaterialRequest"),200);
                return;
            }
            
            //Prepare Save Detail Grid
            if(purchaseRequestItemMaterialRequestDetailLastSel !== -1) {
                $('#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid').jqGrid("saveRow",purchaseRequestItemMaterialRequestDetailLastSel);
            }
            
            var listPurchaseRequestItemMaterialRequestDetail = new Array();
            var ids = jQuery("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('getRowData',ids[i]);

                var purchaseRequestItemMaterialRequestDetail = {
                    itemMaterial       : { code : data.purchaseRequestItemMaterialRequestDetailItemMaterialCode },
                    quantity       : data.purchaseRequestItemMaterialRequestDetailQuantity,
                    remark         : data.purchaseRequestItemMaterialRequestDetailRemark
                };
                
                listPurchaseRequestItemMaterialRequestDetail[i] = purchaseRequestItemMaterialRequestDetail;
            }
            //END Prepare Save Detail Grid

            formatDatePurchaseRequestItemMaterialRequest();
            var url="purchasing/purchase-request-by-sales-order-save";
            var params = $("#frmPurchaseRequestItemMaterialRequestInput ").serialize();
                params += "&listPurchaseRequestItemMaterialRequestDetailJSON=" + $.toJSON(listPurchaseRequestItemMaterialRequestDetail); 
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDatePurchaseRequestItemMaterialRequest(); 
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
                                var url = "purchasing/purchase-request-by-sales-order";
                                var param = "";
                                pageLoad(url, param, "#tabmnuPURCHASE_REQUEST");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "purchasing/purchase-request-by-sales-order";
                                var params = "";
                                pageLoad(url, params, "#tabmnuPURCHASE_REQUEST");
                            }
                        }]
                });
            });
            
        });
               
        $('#btnPurchaseRequestItemMaterialRequestCancel').click(function(ev) {
            var url = "purchasing/purchase-request-by-sales-order";
            var param = "";

            pageLoad(url, param, "#tabmnuPURCHASE_REQUEST");
        });
        
        // Grid Detail button Function
    
        $.subscribe("PurchaseRequestItemMaterialRequestDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==purchaseRequestItemMaterialRequestDetailLastSel) {
                $('#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid').jqGrid("saveRow",purchaseRequestItemMaterialRequestDetailLastSel); 
                $('#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseRequestItemMaterialRequestDetailLastSel=selectedRowID;
            }
            else{
                $('#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnPurchaseRequestItemMaterialRequestCalculateDetail').click(function(ev) {
            
        });   
        
        
    }); //EOF Ready
    
    function loadDataPurchaseRequestItemMaterialRequestDetail() {
        
        var url = "purchasing/purchase-request-by-sales-order-detail-data";
        var params = "purchaseRequestItemMaterialRequest.code=" + txtPurchaseRequestItemMaterialRequestCode.val();
        
        $.getJSON(url, params, function(data) {
            purchaseRequestItemMaterialRequestDetailLastRowId = 0;

            for (var i=0; i<data.listPurchaseRequestItemMaterialRequestDetail.length; i++) {
                purchaseRequestItemMaterialRequestDetailLastRowId++;
                $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid("addRowData", purchaseRequestItemMaterialRequestDetailLastRowId, data.listPurchaseRequestItemMaterialRequestDetail[i]);
                $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('setRowData',purchaseRequestItemMaterialRequestDetailLastRowId,{
                    purchaseRequestItemMaterialRequestDetailItemDelete            : "delete",
                    purchaseRequestItemMaterialRequestDetailItemMaterialSearch            : "...",
                    purchaseRequestItemMaterialRequestDetailItemMaterialCode              : data.listPurchaseRequestItemMaterialRequestDetail[i].itemCode,
                    purchaseRequestItemMaterialRequestDetailItemMaterialName              : data.listPurchaseRequestItemMaterialRequestDetail[i].itemName,
                    purchaseRequestItemMaterialRequestDetailQuantity              : data.listPurchaseRequestItemMaterialRequestDetail[i].quantity,
                    purchaseRequestItemMaterialRequestDetailUnitOfMeasureCode     :data.listPurchaseRequestItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseRequestItemMaterialRequestDetailUnitOfMeasureName     :data.listPurchaseRequestItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseRequestItemMaterialRequestDetailRemark                : data.listPurchaseRequestItemMaterialRequestDetail[i].remark
                });
            }
        });
    }
    
    // function Grid Detail
    function setHeightGridPurchaseOrderNonSoDetail(){
        var ids = jQuery("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid"+" tr").eq(1).height();
            $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function purchaseRequestItemMaterialRequestCustomerSalesOrderDetailDeleteInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
    }
    // END function Grid Detail
    
    function purchaseRequestItemMaterialRequestTransactionDateOnChange(){
        
        var purchaseRequestItemMaterialRequestTransactionDateSplit=$("#purchaseRequestItemMaterialRequest\\.transactionDate").val().split('/');
        var purchaseRequestItemMaterialRequestTransactionDate=purchaseRequestItemMaterialRequestTransactionDateSplit[1]+"/"+purchaseRequestItemMaterialRequestTransactionDateSplit[0]+"/"+purchaseRequestItemMaterialRequestTransactionDateSplit[2];
        $("#purchaseRequestItemMaterialRequest\\.purchaseRequestItemMaterialRequestTransactionDate").val(purchaseRequestItemMaterialRequestTransactionDate);
        
    }
    
    function formatDatePurchaseRequestItemMaterialRequest(){
        var transactionDate=formatDate(dtpPurchaseRequestItemMaterialRequestTransactionDate.val());
        dtpPurchaseRequestItemMaterialRequestTransactionDate.val(transactionDate);  
    }
    
    function handlers_input_purchase_request_imr(){
        
        if(txtPurchaseRequestItemMaterialRequestBranchCode.val()===""){
            handlersInput(txtPurchaseRequestItemMaterialRequestBranchCode);
        }else{
            unHandlersInput(txtPurchaseRequestItemMaterialRequestBranchCode);
        }
     
    }
    
</script>
<s:url id="remotedetailurlPurchaseRequestItemMaterialRequestDetailInput" action="" />

<b>PURCHASE REQUEST BY SALES ORDER</b>
<hr>
<br class="spacer" />

<div id="purchaseRequestItemMaterialRequestInput" class="content ui-widget">
    <s:form id="frmPurchaseRequestItemMaterialRequestInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerPurchaseRequestItemMaterialRequestInput">
            <tr>
                <td align="right" width="100px"><b>PRQ No *</b></td>
                <td><s:textfield id="purchaseRequestItemMaterialRequest.code" name="purchaseRequestItemMaterialRequest.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="purchaseRequestItemMaterialRequest.transactionDate" name="purchaseRequestItemMaterialRequest.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" onchange="purchaseRequestItemMaterialRequestTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="purchaseRequestItemMaterialRequest.purchaseRequestItemMaterialRequestTransactionDate" name="purchaseRequestItemMaterialRequest.purchaseRequestItemMaterialRequestTransactionDate" displayFormat="mm/dd/yy" required="true" cssClass="required" title=" " showOn="focus" disabled="true" size="20" cssStyle="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#purchaseRequestItemMaterialRequest_btnBranch').click(function(ev) {
                            window.open("./pages/search/search-branch.jsp?iddoc=purchaseRequestItemMaterialRequest&idsubdoc=branch","Search", "width=600, height=500");
                        });
                    
                        txtPurchaseRequestItemMaterialRequestBranchCode.change(function(ev) {

                            if(txtPurchaseRequestItemMaterialRequestBranchCode.val()===""){
                                txtPurchaseRequestItemMaterialRequestBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtPurchaseRequestItemMaterialRequestBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtPurchaseRequestItemMaterialRequestBranchCode.val(data.branchTemp.code);
                                    txtPurchaseRequestItemMaterialRequestBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtPurchaseRequestItemMaterialRequestBranchCode);
                                    txtPurchaseRequestItemMaterialRequestBranchCode.val("");
                                    txtPurchaseRequestItemMaterialRequestBranchName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="purchaseRequestItemMaterialRequest.branch.code" name="purchaseRequestItemMaterialRequest.branch.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="purchaseRequestItemMaterialRequest_btnBranch" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="purchaseRequestItemMaterialRequest.branch.name" name="purchaseRequestItemMaterialRequest.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>IMR No *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#purchaseRequestItemMaterialRequest_btnSalesOrder').click(function(ev) {
                            window.open("./pages/search/search-branch.jsp?iddoc=purchaseRequestItemMaterialRequest&idsubdoc=branch","Search", "width=600, height=500");
                        });
                    
                        txtPurchaseRequestItemMaterialRequestBranchCode.change(function(ev) {

                            if(txtPurchaseRequestItemMaterialRequestBranchCode.val()===""){
                                txtPurchaseRequestItemMaterialRequestBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtPurchaseRequestItemMaterialRequestBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtPurchaseRequestItemMaterialRequestBranchCode.val(data.branchTemp.code);
                                    txtPurchaseRequestItemMaterialRequestBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtPurchaseRequestItemMaterialRequestBranchCode);
                                    txtPurchaseRequestItemMaterialRequestBranchCode.val("");
                                    txtPurchaseRequestItemMaterialRequestBranchName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="purchaseRequestItemMaterialRequest.branch.code" name="purchaseRequestItemMaterialRequest.branch.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="purchaseRequestItemMaterialRequest_btnBranch" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="purchaseRequestItemMaterialRequest.branch.name" name="purchaseRequestItemMaterialRequest.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id="purchaseRequestItemMaterialRequest.requestBy" name="purchaseRequestItemMaterialRequest.requestBy" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="purchaseRequestItemMaterialRequest.refNo" name="purchaseRequestItemMaterialRequest.refNo" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="purchaseRequestItemMaterialRequest.remark" name="purchaseRequestItemMaterialRequest.remark" cols="53" rows="3" ></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="purchaseRequestItemMaterialRequestUpdateMode" name="purchaseRequestItemMaterialRequestUpdateMode"></s:textfield>
                    <s:textfield id="purchaseRequestItemMaterialRequest.createdBy" name="purchaseRequestItemMaterialRequest.createdBy"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <table>
            <tr>
                <td width="110px"/>
                <td>
                    <sj:a href="#" id="btnConfirmPurchaseRequestItemMaterialRequest" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmPurchaseRequestItemMaterialRequest" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="purchaseRequestItemMaterialRequestAllDetailInputGrid">
            <div id="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInputGrid">
            <sjg:grid
                id="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailInput_grid"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listPurchaseRequestItemMaterialRequestDetail"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="680"
                editinline="true"
                editurl="%{remotedetailurlPurchaseRequestItemMaterialRequestDetailInput}"
                onSelectRowTopics="PurchaseRequestItemMaterialRequestDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailDelete" index="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailDelete" title="" width="50" align="center"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'purchaseRequestItemMaterialRequestCustomerSalesOrderDetailDeleteInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name = "purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderItemCode" index = "purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderItemCode" key = "purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderItemCode" title = "SO Item Code" width = "120" editable="true"
                />
                <sjg:gridColumn
                    name="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderQuantity" index="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderQuantity" key="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderQuantity" title="SO Quantity" 
                    width="150" align="right" edittype="text" 
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderProcessedQuantity" index="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderProcessedQuantity" key="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderProcessedQuantity" title="Processed Quantity" 
                    width="150" align="right" edittype="text" 
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderPlanQuantity" index="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderPlanQuantity" key="purchaseRequestItemMaterialRequestCustomerSalesOrderDetailSalesOrderPlanQuantity" title="Plan Quantity" 
                    width="150" align="right" edittype="text" 
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
            </sjg:grid >      
        </div>
        <br class="spacer" />
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnPurchaseRequestItemMaterialRequestCalculateDetail" button="true" style="width: 90px">Calculate</sj:a>
                </td>
            </tr> 
        </table>
        <br class="spacer" />
        <div id="purchaseRequestItemMaterialRequestDetailInputGrid">
                <sjg:grid
                    id="purchaseRequestItemMaterialRequestDetailInput_grid"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseRequestItemMaterialRequestDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuPurchaseRequestItemMaterialRequestDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlPurchaseRequestItemMaterialRequestDetailInput}"
                    onSelectRowTopics="PurchaseRequestItemMaterialRequestDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailSalesOrderItemCode" index = "purchaseRequestItemMaterialRequestDetailSalesOrderItemCode" key = "purchaseRequestItemMaterialRequestDetailSalesOrderItemCode" title = "SO Item Code" width = "120"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailSalesOrderPartNo" index = "purchaseRequestItemMaterialRequestDetailSalesOrderPartNo" key = "purchaseRequestItemMaterialRequestDetailSalesOrderPartNo" title = "Part No (PPIC)" width = "150"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailSalesOrderPartName" index = "purchaseRequestItemMaterialRequestDetailSalesOrderPartName" key = "purchaseRequestItemMaterialRequestDetailSalesOrderPartName" title = "Part Name (PPIC)" width = "150"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailItemCode" index="purchaseRequestItemMaterialRequestDetailItemCode" key="purchaseRequestItemMaterialRequestDetailItemCode" title="Item Code (Purchasing)" width="150" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailItemName" index="purchaseRequestItemMaterialRequestDetailItemName" key="purchaseRequestItemMaterialRequestDetailItemName" title="Item Name (Purchasing)" width="200" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailRemark" index="purchaseRequestItemMaterialRequestDetailRemark" key="purchaseRequestItemMaterialRequestDetailRemark" title="Remark" width="150"  editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseRequestItemMaterialRequestDetailQuantity" index="purchaseRequestItemMaterialRequestDetailQuantity" key="purchaseRequestItemMaterialRequestDetailQuantity" title="Request Quantity" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailUnitOfMeasureCode" index = "purchaseRequestItemMaterialRequestDetailUnitOfMeasureCode" key = "purchaseRequestItemMaterialRequestDetailUnitOfMeasureCode" title = "UOM" width = "100"
                        hidden="true"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestItemMaterialRequestDetailUnitOfMeasureName" index = "purchaseRequestItemMaterialRequestDetailUnitOfMeasureName" key = "purchaseRequestItemMaterialRequestDetailUnitOfMeasureName" title = "UOM" width = "100"
                    />
                </sjg:grid >
            </div>
        </div>
        <br class="spacer" />
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnPurchaseRequestItemMaterialRequestSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnPurchaseRequestItemMaterialRequestCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>      
    </s:form>
</div>
    

