<%-- 
    Document   : assembly-job-order-input
    Created on : Dec 10, 2019, 2:18:25 PM
    Author     : Rayis
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close,#assemblyJobOrderItemDetailInput_grid_pager_center{
        display: none;
    }
    #errmsgAddRow{
        color: red;
    }
</style>

<script type="text/javascript">
    
    var assemblyJobOrderBomItemDetail_lastSel = -1, assemblyJobOrderBomItemDetail_lastRowId=0;   
    var assemblyJobOrderItemDetail_lastSel = -1, assemblyJobOrderItemDetail_lastRowId=0;   
 
    var txtAssemblyJobOrderCode = $("#assemblyJobOrder\\.code"),
        txtAssemblyJobOrderBranchCode = $("#assemblyJobOrder\\.branch\\.code"),
        txtAssemblyJobOrderBranchName = $("#assemblyJobOrder\\.branch\\.name"),
        txtAssemblyJobOrderBomCode = $("#assemblyJobOrder\\.division\\.code"),
        txtAssemblyJobOrderBomName = $("#assemblyJobOrder\\.division\\.name"),
        txtAssemblyJobOrderFinishGoodsCode = $("#assemblyJobOrder\\.finishGoods\\.code"),
        txtAssemblyJobOrderFinishGoodsName = $("#assemblyJobOrder\\.finishGoods\\.name"),
        txtAssemblyJobOrderFinishGoodsQuantity = $("#assemblyJobOrder\\.finishGoodsQuantity"),
        txtAssemblyJobOrderWarehouseCode = $("#assemblyJobOrder\\.warehouse\\.code"),
        txtAssemblyJobOrderWarehouseName = $("#assemblyJobOrder\\.warehouse\\.name"),
        dtpAssemblyJobOrderTransactionDate = $("#assemblyJobOrder\\.transactionDate"),
        txtAssemblyJobOrderBillOfMaterialCode = $("#assemblyJobOrder\\.billOfMaterial\\.code"),
        txtAssemblyJobOrderBillOfMaterialName = $("#assemblyJobOrder\\.billOfMaterial\\.name"),
        txtAssemblyJobOrderRefNo = $("#assemblyJobOrder\\.refNo"),
        txtAssemblyJobOrderRemark = $("#assemblyJobOrder\\.remark"),
        txtAssemblyJobOrderCreatedBy = $("#assemblyJobOrder\\.createdBy"),
        dtpAssemblyJobOrderCreatedDate = $("#assemblyJobOrder\\.createdDate");
        
    $(document).ready(function(){
       
        flagConfirmAssemblyJobOrder1=false;
        flagConfirmAssemblyJobOrder2=false;
        flagConfirmAssemblyJobOrder3=false;
    
        $.subscribe("assemblyJobOrderItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#assemblyJobOrderItemDetailInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==assemblyJobOrderItemDetail_lastSel) {
                $("#assemblyJobOrderItemDetailInput_grid").jqGrid('saveRow',assemblyJobOrderItemDetail_lastSel); 
                $("#assemblyJobOrderItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                assemblyJobOrderItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#assemblyJobOrderItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });  
        
        /*Set Default Input View*/
        $("#btnUnConfirmAssemblyJobOrder3").css("display", "none");
        $("#btnConfirmAssemblyJobOrder3").css("display", "block");
        $("#btnUnConfirmAssemblyJobOrder1").css("display", "none");
        $("#btnConfirmAssemblyJobOrder1").css("display", "block");
        $("#assemblyJobOrderBomItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#assemblyJobOrderItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#div-header-asm-job-order-bill-material-group").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
      
        $("#btnConfirmAssemblyJobOrder1").click(function(ev){
            if(!$("#frmAssemblyJobOrderInput").valid()) {
                ev.preventDefault();
                return;
            }
            
            var date1 = dtpAssemblyJobOrderTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            
            var date2 = $("#assemblyJobOrderTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#assemblyJobOrderUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#assemblyJobOrderTransactionDate").val(),dtpAssemblyJobOrderTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpAssemblyJobOrderTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#assemblyJobOrderUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#assemblyJobOrderTransactionDate").val(),dtpAssemblyJobOrderTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpAssemblyJobOrderTransactionDate);
                }
                return;
            }

            flagConfirmAssemblyJobOrder1=true;
            $("#div-header-asm-job-order-code-group").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#div-header-asm-job-order-bill-material-group").unblock();
            $("#btnUnConfirmAssemblyJobOrder1").css("display", "block");
            $("#btnConfirmAssemblyJobOrder1").css("display", "none");
        });
        
        $("#btnUnConfirmAssemblyJobOrder1").click(function(ev){
            flagConfirmAssemblyJobOrder1=false;
            flagConfirmAssemblyJobOrder3=false;
            $("#assemblyJobOrderBomItemDetailInput_grid").jqGrid('clearGridData');
            $("#assemblyJobOrderItemDetailInput_grid").jqGrid('clearGridData');
            $("#div-header-asm-job-order-code-group").unblock();
            $("#div-header-asm-job-order-bill-material-group").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#assemblyJobOrderBomItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#assemblyJobOrderItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#btnUnConfirmAssemblyJobOrder1").css("display", "none");
            $("#btnConfirmAssemblyJobOrder1").css("display", "block");
            $("#btnUnConfirmAssemblyJobOrder3").css("display", "none");
            $("#btnConfirmAssemblyJobOrder3").css("display", "block");
            txtAssemblyJobOrderBillOfMaterialCode.val("");
            txtAssemblyJobOrderBillOfMaterialName.val("");
        });
 
        $("#btnConfirmAssemblyJobOrder3").click(function(ev) {
            if(!flagConfirmAssemblyJobOrder1){
                return;
            }
            if(!$("#frmAssemblyJobOrder3Input").valid()) {
                ev.preventDefault();
                return;
            }
            
            flagConfirmAssemblyJobOrder3=true;
            $("#div-header-asm-job-order-bill-material-group").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#btnUnConfirmAssemblyJobOrder3").css("display", "block");
            $("#btnConfirmAssemblyJobOrder3").css("display", "none");
            $("#assemblyJobOrderBomItemDetailInputGrid").unblock();
            $("#assemblyJobOrderItemDetailInputGrid").unblock();
            
            /* GET DATA BOM DETAIL */
            var url = "master/bill-of-material-component-data";
            var params= "searchBillOfMaterial.code=" + txtAssemblyJobOrderBillOfMaterialCode.val();

            $.post(url, params, function(data) {

               var assemblyJobOrderBomItemDetail_lastRowId=0;
               $("#assemblyJobOrderBomItemDetailInput_grid").jqGrid('clearGridData'); 

                for (var i=0; i<data.listBillOfMaterialDetailTemp.length; i++) {
                    
                    var finishGoodsQty = removeCommas(txtAssemblyJobOrderFinishGoodsQuantity.val());
                    var jobQty = parseFloat(finishGoodsQty)*parseFloat(data.listBillOfMaterialDetailTemp[i].quantity);
                    
                    $("#assemblyJobOrderBomItemDetailInput_grid").jqGrid("addRowData", assemblyJobOrderBomItemDetail_lastRowId, data.listBillOfMaterialDetailTemp[i]);
                    $("#assemblyJobOrderBomItemDetailInput_grid").jqGrid('setRowData',assemblyJobOrderBomItemDetail_lastRowId,{
                        assemblyJobOrderBomItemDetailItemMaterialCode           : data.listBillOfMaterialDetailTemp[i].itemMaterialCode,
                        assemblyJobOrderBomItemDetailItemMaterialName           : data.listBillOfMaterialDetailTemp[i].itemMaterialName,
                        assemblyJobOrderBomItemDetailQuantity                   : data.listBillOfMaterialDetailTemp[i].quantity,
                        assemblyJobOrderBomItemDetailJobQuantity                : jobQty,
                        assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode          : data.listBillOfMaterialDetailTemp[i].itemMaterialUnitOfMeasureCode
                    });

                    assemblyJobOrderBomItemDetail_lastRowId++;
                }
            });
            
            $.post(url, params, function(data) {

               var assemblyJobOrderItemDetail_lastRowId=0;
               $("#assemblyJobOrderItemDetailInput_grid").jqGrid('clearGridData'); 

                for (var i=0; i<data.listBillOfMaterialDetailTemp.length; i++) {
                    
                    var finishGoodsQty = removeCommas(txtAssemblyJobOrderFinishGoodsQuantity.val());
                    var jobQty = parseFloat(finishGoodsQty)*parseFloat(data.listBillOfMaterialDetailTemp[i].quantity);
                    
                    $("#assemblyJobOrderItemDetailInput_grid").jqGrid("addRowData", assemblyJobOrderItemDetail_lastRowId, data.listBillOfMaterialDetailTemp[i]);
                    $("#assemblyJobOrderItemDetailInput_grid").jqGrid('setRowData',assemblyJobOrderItemDetail_lastRowId,{
                        assemblyJobOrderItemDetailItemMaterialCode                       : data.listBillOfMaterialDetailTemp[i].itemMaterialCode,
                        assemblyJobOrderItemDetailItemMaterialName                       : data.listBillOfMaterialDetailTemp[i].itemMaterialName,
                    //    assemblyJobOrderItemDetailBOMQuantity                          : data.listBillOfMaterialDetailTemp[i].quantity,
                        assemblyJobOrderItemDetailQuantity                               : jobQty,
                        assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode          : data.listBillOfMaterialDetailTemp[i].itemMaterialUnitOfMeasureCode
                    });

                    assemblyJobOrderItemDetail_lastRowId++;
                }
            });
        });
        
        $("#btnUnConfirmAssemblyJobOrder3").click(function(ev) {
            flagConfirmAssemblyJobOrder3=false;
            $("#assemblyJobOrderItemDetailInput_grid").jqGrid('clearGridData');
            $("#assemblyJobOrderBomItemDetailInput_grid").jqGrid('clearGridData');
            $("#div-header-asm-job-order-bill-material-group").unblock();
            $("#assemblyJobOrderBomItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#assemblyJobOrderItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#btnUnConfirmAssemblyJobOrder3").css("display", "none");
            $("#btnConfirmAssemblyJobOrder3").css("display", "block");
        });
        
        $("#btnAssemblyJobOrderSave").click(function(ev) {
            if(!flagConfirmAssemblyJobOrder3){
                return;
            }
            
            if(assemblyJobOrderItemDetail_lastSel !== -1) {
                $('#assemblyJobOrderItemDetailInput_grid').jqGrid("saveRow",assemblyJobOrderItemDetail_lastSel);
            }
            
            formatDateAssemblyJobOrder();
            
            var listAssemblyJobOrderItemDetail = new Array(); 
            var ids = jQuery("#assemblyJobOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#assemblyJobOrderItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                
                var assemblyJobOrderItemDetail = {
                    itemMaterial            : { code : data.assemblyJobOrderItemDetailItemMaterialCode },
                    quantity        : data.assemblyJobOrderItemDetailQuantity
                };
                listAssemblyJobOrderItemDetail[i] = assemblyJobOrderItemDetail;
            }
            
            var url = "inventory/assembly-job-order-save";
            
            var params = $("#frmAssemblyJobOrderInput").serialize(); 
                params +="&"+ $("#frmAssemblyJobOrder2Input").serialize(); 
                params +="&"+ $("#frmAssemblyJobOrder3Input").serialize(); 
                params +="&listAssemblyJobOrderItemDetailJSON=" + $.toJSON(listAssemblyJobOrderItemDetail);;
            
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateAssemblyJobOrder();
                    return;
                }

                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 500,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "Yes",
                                        click : function() {
                                            $(this).dialog("close");
                                            params = "";
                                            var url = "inventory/assembly-job-order-input";
                                            pageLoad(url, params, "#tabmnuASSEMBLY_JOB_ORDER");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");
                                            params = "";
                                            var url = "inventory/assembly-job-order";
                                            pageLoad(url, params, "#tabmnuASSEMBLY_JOB_ORDER");
                                        }
                                    }]
                });
            });
        });
        
        $("#btnAssemblyJobOrderCancel").click(function(ev){
            var params = "";
            var url = "inventory/assembly-job-order";
            pageLoad(url, params, "#tabmnuASSEMBLY_JOB_ORDER");
        });

        $('#assemblyJobOrder_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=assemblyJobOrder&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#assemblyJobOrder_btnFinishGoods').click(function(ev) {
            window.open("./pages/search/search-item-material.jsp?iddoc=assemblyJobOrder&idsubdoc=finishGoods&idivt=Inventory&modulType=finishGoods&departmentCode="+$("#assemblyJobOrder\\.division\\.department\\.code").val(),"Search", "Scrollbars=1,width=600, height=500");
        });
        
        $("#assemblyJobOrder_btnBillOfMaterial").click(function(ev) {
            window.open("./pages/search/search-bill-of-material.jsp?iddoc=assemblyJobOrder&idsubdoc=billOfMaterial&idtype=Internal","Search", "scrollbars=1,width=600, height=500");
        });
        
        $("#assemblyJobOrder_btnWarehouse").click(function(ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=assemblyJobOrder&idsubdoc=warehouse","Search", "scrollbars=1,width=600, height=500");
        });
        
         $('#btnAssemblyJobOrderAddDetail').click(function(ev) {
            if(flagConfirmAssemblyJobOrder3===false){
                alertMessage("Please Confirm!",$("#btnAssemblyJobOrderConfirm"));
                return;
            }
            
            var totalCount = parseFloat(removeCommas($("#txtAssemblyJobOrderAddDetail").val()));
            for(var i=0; i<totalCount; i++){
                var defRow = {
                    assemblyJobOrderItemDetailDeleteDelete   :"delete",
                    assemblyJobOrderItemDetailDeleteSearch   :"...",
                    purchaseRequestDetailItemStockCodeTemp   :" "
                };
                assemblyJobOrderItemDetail_lastRowId++;
                $("#assemblyJobOrderItemDetailInput_grid").jqGrid("addRowData", assemblyJobOrderItemDetail_lastRowId, defRow);
                ev.preventDefault();
            }
            $("#txtAssemblyJobOrderAddDetail").val("1");
            setHeightGridLoadDriver();
        });
       
        
    });//EOF Ready

    function assemblyJobOrderItemDetailInputGrid_SearchItem_OnClick(){
        var headercode= txtAssemblyJobOrderBillOfMaterialCode.val();
        var finishGoodsQty = removeCommas(txtAssemblyJobOrderFinishGoodsQuantity.val());
    //    alert(headercode);
        window.open("./pages/search/search-bill-of-material-commponent-item.jsp?iddoc=assemblyJobOrderItemDetail&headercode="+headercode+"&finishGoodsQty="+finishGoodsQty+"&idsubdoc=assemblyJobOrderItemDetail&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function assemblyJobOrderItemDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#assemblyJobOrderItemDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#assemblyJobOrderItemDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridAssemblyJobOrderItemDetail();
    }
        
    function setHeightGridAssemblyJobOrderItemDetail(){
        var ids = jQuery("#assemblyJobOrderItemDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#assemblyJobOrderItemDetailInput_grid"+" tr").eq(1).height();
            $("#assemblyJobOrderItemDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#assemblyJobOrderItemDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function formatDateAssemblyJobOrder(){
        var transactionDate=formatDate(dtpAssemblyJobOrderTransactionDate.val(),false);
        dtpAssemblyJobOrderTransactionDate.val(transactionDate);
        
        var createdDate=formatDate(dtpAssemblyJobOrderCreatedDate.val(),false);
        dtpAssemblyJobOrderCreatedDate.val(createdDate);        
    }
    
    function assemblyJobOrderTransactionDateOnChange(){
        if($("#assemblyJobOrderUpdateMode").val()!=="true"){
            $("#assemblyJobOrderTransactionDate").val(dtpAssemblyJobOrderTransactionDate.val());
        }
    }
    
</script>
<b>ASSEMBLY JOB ORDER</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlAssemblyJobOrderItemDetailInput" action="" />

<div id="assemblyJobOrderInput" class="content ui-widget">
    <s:form id="frmAssemblyJobOrderInput">
        <s:form id="frmAssemblyJobOrder1Input">
            <div id="div-header-asm-job-order-code-group">
                <table cellpadding="2" cellspacing="2" width="100%">
                    <tr>
                        <td align="right" width="140px"><B>ASM-JOB No *</B></td>
                        <td>
                            <s:textfield id="assemblyJobOrder.code" name="assemblyJobOrder.code" size="20" readonly="true" ></s:textfield>
                            <s:textfield id="assemblyJobOrderUpdateMode" name="assemblyJobOrderUpdateMode" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Branch *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">

                                txtAssemblyJobOrderBranchCode.change(function(ev) {

                                    if(txtAssemblyJobOrderBranchCode.val()===""){
                                        txtAssemblyJobOrderBranchName.val("");
                                        return;
                                    }
                                    var url = "master/branch-get";
                                    var params = "branch.code=" + txtAssemblyJobOrderBranchCode.val();
                                        params += "&branch.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.branchTemp){
                                            txtAssemblyJobOrderBranchCode.val(data.branchTemp.code);
                                            txtAssemblyJobOrderBranchName.val(data.branchTemp.name);
                                        }
                                        else{
                                            alertMessage("Branch Not Found!",txtAssemblyJobOrderBranchCode);
                                            txtAssemblyJobOrderBranchCode.val("");
                                            txtAssemblyJobOrderBranchName.val("");
                                        }
                                    });
                                });

                                if($("#assemblyJobOrderUpdateMode").val()==="true"){
                                    txtAssemblyJobOrderBranchCode.attr("readonly",true);
                                    $("#assemblyJobOrder_btnBranch").hide();
                                    $("#ui-icon-search-branch-assembly-job-order").hide();
                                }else{
                                    txtAssemblyJobOrderBranchCode.attr("readonly",false);
                                    $("#assemblyJobOrder_btnBranch").show();
                                    $("#ui-icon-search-branch-assembly-job-order").show();
                                }
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="assemblyJobOrder.branch.code" name="assemblyJobOrder.branch.code" required="true" cssClass="required" title="*" size="20"></s:textfield>
                                <sj:a id="assemblyJobOrder_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-assembly-job-order"/></sj:a>
                            </div>
                            <s:textfield id="assemblyJobOrder.branch.name" name="assemblyJobOrder.branch.name" cssStyle="width:20%" readonly="true"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Transaction Date *</B></td>
                        <td>
                            <sj:datepicker id="assemblyJobOrder.transactionDate" name="assemblyJobOrder.transactionDate"  title="*" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="20" onchange="assemblyJobOrderTransactionDateOnChange()" readonly="false"></sj:datepicker>
                            <sj:datepicker id="assemblyJobOrderTransactionDate" name="assemblyJobOrderTransactionDate"  title="*" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="20" cssStyle="display:none"></sj:datepicker>
                        </td>
                    </tr>
                    <tr>
                    <td align="right"><B>Warehouse *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            
                             txtAssemblyJobOrderWarehouseCode.change(function(ev) {

                            if(txtAssemblyJobOrderWarehouseCode.val()===""){
                                txtAssemblyJobOrderWarehouseName.val("");
                                return;
                            }
                            var url = "master/warehouse-get-user";
                            var params = "warehouse.code=" + txtAssemblyJobOrderWarehouseCode.val();

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.warehouseTemp){
                                    txtAssemblyJobOrderWarehouseCode.val(data.warehouseTemp.code);
                                    txtAssemblyJobOrderWarehouseName.val(data.warehouseTemp.name);
                                }
                                else{
                                    alertMessage("Warehouse Not Found!",txtAssemblyJobOrderWarehouseCode);
                                    txtAssemblyJobOrderWarehouseCode.val("");
                                    txtAssemblyJobOrderWarehouseName.val("");
                                }
                            });
                        });                      

                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="assemblyJobOrder.warehouse.code" name="assemblyJobOrder.warehouse.code" size="20" title="*" required="true" cssClass="required" ></s:textfield>
                            <sj:a id="assemblyJobOrder_btnWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="assemblyJobOrder.warehouse.name" name="assemblyJobOrder.warehouse.name" cssStyle="width:20%"  readonly="true" ></s:textfield>
                    </td>
                </tr>
                    <tr>
                        <td align="right" width="140px"><B>Finish Goods *</B></td>
                        <td colspan="2">
                        <script type = "text/javascript">

                            txtAssemblyJobOrderFinishGoodsCode.change(function(ev) {

                                if(txtAssemblyJobOrderFinishGoodsCode.val()===""){
                                    txtAssemblyJobOrderFinishGoodsName.val("");
                                    return;
                                }
                                var url = "master/item-material-get";
                                var params = "itemMaterial.code=" + txtAssemblyJobOrderFinishGoodsCode.val();
                                    params += "&itemMaterial.activeStatus=" + true;

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.itemMaterialTemp){
                                        txtAssemblyJobOrderFinishGoodsCode.val(data.itemMaterialTemp.code);
                                        txtAssemblyJobOrderFinishGoodsName.val(data.itemMaterialTemp.name);
                                    }
                                    else{
                                        alertMessage("Finish Goods Not Found!",txtAssemblyJobOrderFinishGoodsCode);
                                        txtAssemblyJobOrderFinishGoodsCode.val("");
                                        txtAssemblyJobOrderFinishGoodsName.val("");
                                    }
                                });
                            });                      
                        </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="assemblyJobOrder.finishGoods.code" name="assemblyJobOrder.finishGoods.code" required="true" cssClass="required" title="*" size="20"></s:textfield>
                                <sj:a id="assemblyJobOrder_btnFinishGoods" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-finishGoods" class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="assemblyJobOrder.finishGoods.name" name="assemblyJobOrder.finishGoods.name" cssStyle="width:20%" readonly="true"></s:textfield>
                        </td>    
                    </tr>
                    
                </table>
            </div>
            <table>
                <tr>
                    <td colspan="2">
                        <sj:a cssStyle="width:-moz-fit-content" href="#" id="btnConfirmAssemblyJobOrder1" button="true">Confirm</sj:a>
                        <sj:a cssStyle="width:-moz-fit-content" href="#" id="btnUnConfirmAssemblyJobOrder1" button="true">UnConfirm</sj:a>
                    </td>
                </tr>
            </table>
        </s:form>
        <s:form id="frmAssemblyJobOrder3Input">
            <div id="div-header-asm-job-order-bill-material-group">
                <table cellpadding="2" cellspacing="2" width="100%">    
                    <tr>
                        <td align="right" width="140px"><B>BOM *</B></td>
                        <td colspan="2">
                            <script type = "text/javascript">

                            txtAssemblyJobOrderBillOfMaterialCode.change(function(ev) {

                                if(txtAssemblyJobOrderBillOfMaterialCode.val()===""){
                                    txtAssemblyJobOrderBillOfMaterialName.val("");
                                    return;
                                }
                                var url = "master/bill-of-material-get";
                                var params = "billOfMaterial.code=" + txtAssemblyJobOrderBillOfMaterialCode.val();

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.billOfMaterialTemp){
                                        txtAssemblyJobOrderBillOfMaterialCode.val(data.billOfMaterialTemp.code);
                                        txtAssemblyJobOrderBillOfMaterialName.val(data.billOfMaterialTemp.name);
                                    }
                                    else{
                                        alertMessage("BillOfMaterial Not Found!",txtAssemblyJobOrderBillOfMaterialCode);
                                        txtAssemblyJobOrderBillOfMaterialCode.val("");
                                        txtAssemblyJobOrderBillOfMaterialName.val("");
                                    }
                                });
                            });                      
                            </script>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="assemblyJobOrder.billOfMaterial.code" name="assemblyJobOrder.billOfMaterial.code" size="20" title="*" required="true" cssClass="required" ></s:textfield>
                                <sj:a id="assemblyJobOrder_btnBillOfMaterial" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="assemblyJobOrder.billOfMaterial.name" name="assemblyJobOrder.billOfMaterial.name" cssStyle="width:20%" readonly="true" ></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="140px"><B>Finish Goods Quantity*</B></td>
                        <td colspan="2"><s:textfield id="assemblyJobOrder.finishGoodsQuantity" name="assemblyJobOrder.finishGoodsQuantity" size="10" required="true" cssClass="required" cssStyle="text-align:right"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Ref No</td>
                        <td><s:textfield id="assemblyJobOrder.refNo" name="assemblyJobOrder.refNo" size="30" ></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td><s:textarea id="assemblyJobOrder.remark" name="assemblyJobOrder.remark"  rows="3" cols="40" ></s:textarea> </td>
                    </tr>
                    <tr hidden="true">
                        <td>
                            <sj:datepicker id="assemblyJobOrderTransactionDateFirstSession" name="assemblyJobOrderTransactionDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                            <sj:datepicker id="assemblyJobOrderTransactionDateLastSession" name="assemblyJobOrderTransactionDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                            <s:textfield id="assemblyJobOrder.createdBy" name="assemblyJobOrder.createdBy" key="assemblyJobOrder.createdBy" readonly="true" size="22"></s:textfield>
                            <sj:datepicker id="assemblyJobOrder.createdDate" name="assemblyJobOrder.createdDate" title="*" displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus"></sj:datepicker>
                        </td>
                    </tr>
                </table>
            </div>
        </s:form>
        <br class="spacer" />
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td colspan="2">
                    <sj:a cssStyle="width:-moz-fit-content" href="#" id="btnConfirmAssemblyJobOrder3" button="true">Confirm</sj:a>
                    <sj:a cssStyle="width:-moz-fit-content" href="#" id="btnUnConfirmAssemblyJobOrder3" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
        <div id="assemblyJobOrderBomItemDetailInputGrid">
            <sjg:grid
                id="assemblyJobOrderBomItemDetailInput_grid"
                caption="BOM Detail"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAssemblyJobOrderBomItemDetail"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="625"
                editinline="true"
                editurl="%{remotedetailurlAssemblyJobOrderBomItemDetailInput}"
                onSelectRowTopics="assemblyJobOrderBomItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name = "assemblyJobOrderBomItemDetailItemMaterialCode" index = "assemblyJobOrderBomItemDetailItemMaterialCode" key = "assemblyJobOrderBomItemDetailItemMaterialCode" 
                    title = "Item Code *" width = "100" edittype="text"
                />
                <sjg:gridColumn
                    name = "assemblyJobOrderBomItemDetailItemMaterialName" index = "assemblyJobOrderBomItemDetailItemMaterialName" key = "assemblyJobOrderBomItemDetailItemMaterialName" 
                    title = "Item Name" width = "200"
                />
                <sjg:gridColumn
                    name="assemblyJobOrderBomItemDetailQuantity" index="assemblyJobOrderBomItemDetailQuantity" key="assemblyJobOrderBomItemDetailQuantity" 
                    title="BOM Quantity *" width="100" align="right" edittype="text" editable="false"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode" index = "assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode" key = "assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode" 
                    title = "Unit" width = "150" edittype="text" editable="false" align="left"
                />
            </sjg:grid >
        </div>
        <br class="spacer" />
        <div id="assemblyJobOrderItemDetailInputGrid">
            <sjg:grid
                id="assemblyJobOrderItemDetailInput_grid"
                caption="Assembly Job Order Item Detail"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAssemblyJobOrderItemDetail"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="760"
                editinline="true"
                editurl="%{remotedetailurlAssemblyJobOrderItemDetailInput}"
                onSelectRowTopics="assemblyJobOrderItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                name="assemblyJobOrderItemDetailDelete" index="assemblyJobOrderItemDetailDelete" title="" width="50" align="center"
                editable="true"
                edittype="button"
                editoptions="{onClick:'assemblyJobOrderItemDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="assemblyJobOrderItemDetailSearch" index="assemblyJobOrderItemDetailSearch" title="" width="25" align="center"
                    editable="true" dataType="html" edittype="button"
                    editoptions="{onClick:'assemblyJobOrderItemDetailInputGrid_SearchItem_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name = "assemblyJobOrderItemDetailItemMaterialCode" index = "assemblyJobOrderItemDetailItemMaterialCode" key = "assemblyJobOrderItemDetailItemMaterialCode" 
                    title = "Item Code *" width = "100" edittype="text" editable="true"
                />
                <sjg:gridColumn
                    name = "assemblyJobOrderItemDetailItemMaterialName" index = "assemblyJobOrderItemDetailItemMaterialName" key = "assemblyJobOrderItemDetailItemMaterialName" 
                    title = "Item Name" width = "200"
                />
                <sjg:gridColumn
                    name="assemblyJobOrderItemDetailQuantity" index="assemblyJobOrderItemDetailQuantity" key="assemblyJobOrderItemDetailQuantity" 
                    title="ASM-JOB Quantity *" width="150" align="right" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode" index = "assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode" key = "assemblyJobOrderItemDetaiItemMaterialUnitOfMeasureCode" 
                    title = "Unit" width = "150" edittype="text" editable="false" align="left"
                />
            </sjg:grid >
        </div>
        <tr>    
            <td align="left">
               <s:textfield id="txtAssemblyJobOrderAddDetail"  name="txtAssemblyJobOrderAddDetail" style="text-align: right;width: 40px;" value="1"></s:textfield>
               &nbsp; &nbsp; <sj:a href="#" id="btnAssemblyJobOrderAddDetail" button="true" style="width: 50px">Add</sj:a>
            </td>
        </tr>
        <table width="100%">
            <tr>    
                <td>      
                    <sj:a href="#" id="btnAssemblyJobOrderSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAssemblyJobOrderCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        
    </s:form>
</div>