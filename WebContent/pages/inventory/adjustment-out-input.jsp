<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    #adjustmentOutItemDetailInput_grid_pager_center,#adjustmentOutSerialNoDetailInput_grid_pager_center{
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
    
    var adjustmentOutItemDetail_lastSel = -1, adjustmentOutItemDetail_lastRowId=0;
    var adjustmentOutSerialNoDetail_lastSel = -1, adjustmentOutSerialNoDetail_lastRowId=0;
    
    var txtAdjustmentOutCode = $("#adjustmentOut\\.code"),
        txtAdjustmentOutBranchCode = $("#adjustmentOut\\.branch\\.code"),
        txtAdjustmentOutBranchName = $("#adjustmentOut\\.branch\\.name"),
        dtpAdjustmentOutTransactionDate = $("#adjustmentOut\\.transactionDate"),
        txtAdjustmentOutWarehouseCode = $("#adjustmentOut\\.warehouse\\.code"),
        txtAdjustmentOutWarehouseName = $("#adjustmentOut\\.warehouse\\.name"),
        txtAdjustmentOutWarehouseRackCode = $('#adjustmentOut\\.warehouse\\.dockInCode'),
        txtAdjustmentOutWarehouseRackName = $('#adjustmentOut\\.warehouse\\.dockInName'),
        txtAdjustmentOutRefNo = $("#adjustmentOut\\.refNo"),
        txtAdjustmentOutRemark = $("#adjustmentOut\\.remark"),
        txtInventoryOuCreatedBy = $("#adjustmentOut\\.createdBy"),
        dtpAdjustmentOutCreatedDate = $("#adjustmentOut\\.createdDate");
        
    $(document).ready(function(){       
       
        flagConfirmAdjustmentOut=false;
        
        $.subscribe("adjustmentOutItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==adjustmentOutItemDetail_lastSel) {
                $("#adjustmentOutItemDetailInput_grid").jqGrid('saveRow',adjustmentOutItemDetail_lastSel); 
                $("#adjustmentOutItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                adjustmentOutItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#adjustmentOutItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        $.subscribe("adjustmentOutSerialNoDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentOutSerialNoDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==adjustmentOutSerialNoDetail_lastSel) {
                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('saveRow',adjustmentOutSerialNoDetail_lastSel); 
                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                adjustmentOutSerialNoDetail_lastSel=selectedRowID;
            }
            else{
                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        $("#btnUnConfirmAdjustmentOut").css("display", "none");
        $("#adjustmentOutDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmAdjustmentOut").click(function(ev) {
            handlers_input_adjustment_out();
            if(!$("#frmAdjustmentOutInput").valid()) {
                alertMessage("Field Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            var date1 = dtpAdjustmentOutTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            
            var date2 = $("#adjustmentOutTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#adjustmentOutUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#adjustmentOutTransactionDate").val(),dtpAdjustmentOutTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpAdjustmentOutTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#adjustmentOutUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#adjustmentOutTransactionDate").val(),dtpAdjustmentOutTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpAdjustmentOutTransactionDate);
                }
                return;
            }
            
            if($("#adjustmentOutUpdateMode").val()==="true"){
                autoLoadDataAdjustmentOutItemDetail();
                autoLoadDataAdjustmentOutItemSerialNoDetail();
            }
            
            
            flagConfirmAdjustmentOut=true;
            $("#div-header-iot").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#btnUnConfirmAdjustmentOut").css("display", "block");
            $("#btnConfirmAdjustmentOut").css("display", "none");
            $("#adjustmentOutDetailInputGrid").unblock();
        });
        
        $("#btnUnConfirmAdjustmentOut").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm This Item Detail?</div>');

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
                                flagConfirmAdjustmentOut=false;
                                $("#adjustmentOutItemDetailInput_grid").jqGrid('clearGridData');
                                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmAdjustmentOut").css("display", "none");
                                $("#btnConfirmAdjustmentOut").css("display", "block");
                                $("#div-header-iot").unblock();
                                $('#adjustmentOutDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#btnAdjustmentOutSave").click(function(ev) {
            
            if(!flagConfirmAdjustmentOut){
                alertMessage("Please Confirm!",$("#btnConfirmAdjustmentOut"));
                return;
            }
            
            if(adjustmentOutItemDetail_lastSel !== -1) {
                $("#adjustmentOutItemDetailInput_grid").jqGrid('saveRow',adjustmentOutItemDetail_lastSel); 
            }
            if(adjustmentOutSerialNoDetail_lastSel !== -1) {
                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('saveRow',adjustmentOutSerialNoDetail_lastSel); 
            }
            var listAdjustmentOutItemDetail = new Array(); 
            var listAdjustmentOutSerialNoDetail = new Array();  
            
            var ids = jQuery("#adjustmentOutItemDetailInput_grid").jqGrid('getDataIDs'); 
            

            for(var i=0;i < ids.length;i++){ 
                var data = $("#adjustmentOutItemDetailInput_grid").jqGrid('getRowData',ids[i]); 

                var adjustmentOutItemDetail = {
                    itemMaterial    : { code : data.adjustmentOutItemDetailItemMaterialCode},
                    reason          : { code : data.adjustmentOutItemDetailReasonCode},
                    quantity        : data.adjustmentOutItemDetailQuantity,
                    rack            : { code : data.adjustmentOutItemDetailRackCode },
                    remark          : data.adjustmentOutItemDetailRemark
                };
                listAdjustmentOutItemDetail[i] = adjustmentOutItemDetail;
            }
            
            var idx = jQuery("#adjustmentOutSerialNoDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0;i < idx.length;i++){
                var data = $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('getRowData',idx[i]); 

                if(data.adjustmentOutSerialNoDetailSerialNo===""){
                    alertMessage("Serial No Can't Empty!");
                    return;
                }
                
                if(data.adjustmentOutSerialNoDetailRackCode===""){
                    alertMessage("Rack Can't Empty!");
                    return;
                }
               
                var adjustmentOutSerialNoDetail = {
                    itemMaterial        : { code : data.adjustmentOutSerialNoDetailItemMaterialCode},
                    reason              : { code : data.adjustmentOutSerialNoDetailReasonCode},
                    serialNo            : data.adjustmentOutSerialNoDetailSerialNo,
                    serialNoDetailCode  : data.adjustmentOutSerialNoDetailCode,
                    inTransactionCode   : data.adjustmentOutSerialNoDetailTransactionCode,
                    capacity            : data.adjustmentOutSerialNoDetailIotCapacity,
                    remark              : data.adjustmentOutSerialNoDetailRemark,
                    rack                : { code : data.adjustmentOutSerialNoDetailRackCode}
                };
                listAdjustmentOutSerialNoDetail[i] = adjustmentOutSerialNoDetail;
            }
            
            formatDateAdjOut();
            var url = "inventory/adjustment-out-save";
            var params = $("#frmAdjustmentOutInput").serialize();
                params+= "&listAdjustmentOutItemDetailJSON=" + $.toJSON(listAdjustmentOutItemDetail);
                params+= "&listAdjustmentOutSerialNoDetailJSON=" + $.toJSON(listAdjustmentOutSerialNoDetail);

            showLoading();
            
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateAdjOut();
                    return;
                }

                var dynamicDialog= $('<div id="conformBox">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');

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
                                params = "";
                                var url = "inventory/adjustment-out-input";
                                pageLoad(url, params, "#tabmnuADJUSTMENT_OUT");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "inventory/adjustment-out";
                                pageLoad(url, params, "#tabmnuADJUSTMENT_OUT");
                            }
                        }]
                });
            });
        });
        
        $("#btnAdjustmentOutCancel").click(function(ev){
            var params = "";
            var url = "inventory/adjustment-out";
            pageLoad(url, params, "#tabmnuADJUSTMENT_OUT");
        });
        
        $("#btnAdjustmentOutNonSerialNoAddDetail").click(function(ev) { 
           window.open("./pages/search/search-item-material-multiple.jsp?iddoc=adjustmentOutItemDetail&idsubdoc=ItemMaterialStock&type=grid&idivt=Adjustment&idSNStatus=False"+ "&rowLast=" + adjustmentOutItemDetail_lastRowId,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $("#btnAdjustmentOutSerialNoAddDetail").click(function(ev) {
           window.open("./pages/search/search-item-material-stock-location.jsp?iddoc=adjustmentOutSerialNoDetail&type=grid&idwarehouse="+txtAdjustmentOutWarehouseCode.val()+"&idrack="+txtAdjustmentOutWarehouseRackCode.val()+ "&rowLast=" + adjustmentOutSerialNoDetail_lastRowId,"Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#adjustmentOut_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=adjustmentOut&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $("#adjustmentOut_btnWarehouse").click(function(ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=adjustmentOut&idsubdoc=warehouse&idtype=Internal","Search", "scrollbars=1,width=600, height=500");
        });
        
    });//EOF Ready
    
    function adjustmentOutCalculateDetail() {
        var selectedRowID = $("#adjustmentOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var data=$("#adjustmentOutItemDetailInput_grid").jqGrid('getRowData',selectedRowID);
                        
        var qty = $("#" + selectedRowID + "_adjustmentOutItemDetailQuantity").val();
        var cogsIdr = data.adjustmentOutItemDetailItemCogsIdr;
        var totalAmount = (parseFloat(qty) * parseFloat(cogsIdr));

        $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID, "adjustmentOutItemDetailTotalAmount", totalAmount);

        $("#"+selectedRowID+"_adjustmentOutItemDetailQuantity").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        adjustmentOutCalculateHeader();
    }
    function addRowAdjustmentOutItemDetailItemDataMultiSelected(lastRowId, defRow) {
       var ids = jQuery("#adjustmentOutItemDetailInput_grid").jqGrid('getDataIDs');
       var lastRow = [0];
       for (var i = 0; i < ids.length; i++) {
           var comp = (ids[i] - lastRow[0]) > 0;
           if (comp) {
               lastRow = [];
               lastRow.push(ids[i]);
           }
       }
       adjustmentOutItemDetail_lastRowId = lastRowId;
       
       $("#adjustmentOutItemDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
       $("#adjustmentOutItemDetailInput_grid").jqGrid('setRowData', lastRowId, {
            adjustmentOutItemDetailItemDelete                      : "delete",
            adjustmentOutItemDetailItemMaterialCode                : defRow.adjustmentInItemDetailItemCode,
            adjustmentOutItemDetailItemMaterialName                : defRow.adjustmentInItemDetailItemName,
            adjustmentOutItemDetailItemMaterialUnitOfMeasureCode   : defRow.adjustmentInItemDetailItemUnitOfMeasureCode,
            adjustmentOutItemDetailRackCode                        : txtAdjustmentOutWarehouseRackCode.val(),
            adjustmentOutItemDetailRackName                        : txtAdjustmentOutWarehouseRackName.val()
       });
   }
        
        
    function addRowAdjustmentOutSerialNoDetailSerialNoDataMultiSelected(lastRowId, defRow) {
        var ids = jQuery("#adjustmentOutSerialNoDetailInput_grid").jqGrid('getDataIDs');
        var lastRow = [0];
        for (var i = 0; i < ids.length; i++) {
            var comp = (ids[i] - lastRow[0]) > 0;
            if (comp) {
                lastRow = [];
                lastRow.push(ids[i]);
            }
        }
        adjustmentOutSerialNoDetail_lastRowId = lastRowId;
        
        $("#adjustmentOutSerialNoDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('setRowData', lastRowId, {
            adjustmentOutItemDetailItemDelete                       : "delete",
            adjustmentOutItemDetailCode                             : defRow.adjustmentOutItemDetailCode,
            adjustmentOutItemDetailItemMaterialCode                 : defRow.adjustmentOutItemDetailItemMaterialCode,
            adjustmentOutItemDetailItemMaterialName                 : defRow.adjustmentOutItemDetailItemMaterialName,
            adjustmentOutItemDetailRackCode                         : defRow.adjustmentOutItemDetailRackCode,
            adjustmentOutItemDetailRackName                         : defRow.adjustmentOutItemDetailRackName,
            adjustmentOutItemDetailItemMaterialUnitOfMeasureCode    : defRow.adjustmentOutItemDetailUnitOfMeasureCode

        });
    }
    
    function adjustmentOutCalculateHeader() {
        var totalTransaction = 0;
        var ids = jQuery("#adjustmentOutItemDetailInput_grid").jqGrid('getDataIDs');
        for(var i=0;i < ids.length;i++) {
            var data = $("#adjustmentOutItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.adjustmentOutItemDetailTotalAmount);
        }      
        $("#adjustmentOut\\.grandTotalAmount").val(totalTransaction);
    }
    
    function adjustmentOutTransactionDateOnChange(){
        if($("#adjustmentOutUpdateMode").val()!=="true"){
            $("#adjustmentOutTransactionDate").val(dtpAdjustmentOutTransactionDate.val());
        }
    }
    
    function formatDateAdjOut(){
        var transactionDateSplit=dtpAdjustmentOutTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpAdjustmentOutTransactionDate.val(transactionDate);
        
        var createdDateSplit=dtpAdjustmentOutCreatedDate.val().split('/');
        var createdDate =createdDateSplit[1]+"/"+createdDateSplit[0]+"/"+createdDateSplit[2];
        dtpAdjustmentOutCreatedDate.val(createdDate);
        $("#adjustmentOut\\.createdDateTemp").val(createdDate);
        
    }
   
    
    function adjustmentOutItemDetailInputGrid_SearchItem_OnClick(){
        window.open("./pages/search/search-item-current-stock-by-adj-out.jsp?iddoc=adjustmentOutItemDetail&idsubdoc=Item&type=grid&idwarehouse="+$("#adjustmentOut\\.warehouse\\.code").val(),"Search", "scrollbars=1,width=600, height=500");
    }
    
    function adjustmentOutItemDetailInputGrid_SearchReason_OnClick(){
        window.open("./pages/search/search-reason.jsp?iddoc=adjustmentOutItemDetail&type=grid&modulecode=003_IVT_ADJUSTMENT_OUT","Search", "scrollbars=1,width=600, height=500");
    }
    function adjustmentOutSerialNoDetailInputGrid_SearchReason_OnClick(){
        window.open("./pages/search/search-reason.jsp?iddoc=adjustmentOutSerialNoDetail&type=grid&modulecode=003_IVT_ADJUSTMENT_OUT","Search", "scrollbars=1,width=600, height=500");
    }
    function adjustmentOutItemDetailInputGrid_ItemDelete_OnClick(){
        var selectedRowID = $("#adjustmentOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if (selectedRowID === null) {
            alertMessage("Please Select Row");
            return;
        }          
        $("#adjustmentOutItemDetailInput_grid").jqGrid('delRowData',selectedRowID);
        
        adjustmentOutCalculateHeader();
    }
    
    function adjustmentOutSerialNoItemDetailInputGrid_ItemDelete_OnClick(){
        var selectedRowID = $("#adjustmentOutSerialNoDetailInput_grid").jqGrid("getGridParam", "selrow");
        if (selectedRowID === null) {
            alertMessage("Please Select Row");
            return;
        }          
        $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('delRowData',selectedRowID);
        
        //adjustmentOutCalculateHeader();
    }
    
    function clearAdjustmentOutItemDetailData(selectedRowID){
        $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailItemMaterialName"," ");
        $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailItemInventoryType"," ");
        $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailUnitOfMeasureCode"," ");
    }
    
    function onChangeAdjustmentOutItemDetailItem(){
        
        var selectedRowID = $("#adjustmentOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var itemCode = $("#" + selectedRowID + "_adjustmentOutItemDetailItemMaterialCode").val();

        var url = "master/item-get";
        var params = "item.code=" + itemCode;
            params += "&item.activeStatus=TRUE";
            params += "&itemSearchInventoryType='INVENTORY'";

        if(itemCode===""){
            clearAdjustmentOutItemDetailData(selectedRowID);
            return;
        }

        var idx = jQuery("#adjustmentOutItemDetailInput_grid").jqGrid('getDataIDs');
        
        $.post(url, params, function(result) {
            var data = (result);
            if (data.itemTemp){
                for(var i=0;i<idx.length;i++){
                    for(var j=0;j<idx.length;j++){
                        if(i!==j){
                            var dataGridItemDetailChecker = $("#adjustmentOutItemDetailInput_grid").jqGrid('getRowData',idx[j]);
                            if(data.itemTemp.code===dataGridItemDetailChecker.adjustmentOutItemDetailItemMaterialCode){                            
                                    alertMessage("Item "+ data.itemTemp.code+" has been exists in Grid!",$("#" + selectedRowID + "_adjustmentOutItemDetailItemMaterialCode"));
                                    $("#" + selectedRowID + "_adjustmentOutItemDetailItemMaterialCode").val("");
                                    clearAdjustmentOutItemDetailData(selectedRowID);
                                    return;
                            }
                        }
                    }
                }
                $("#" + selectedRowID + "_adjustmentOutItemDetailItemMaterialCode").val(data.itemTemp.code);
                $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailItemMaterialName",data.itemTemp.name);
                $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailItemInventoryType",data.itemTemp.inventoryType);
                $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailUnitOfMeasureCode",data.itemTemp.unitOfMeasureCode);
            }
            else{
                alertMessage("Item Not Found!",$("#" + selectedRowID + "_adjustmentOutItemDetailItemMaterialCode"));
                $("#" + selectedRowID + "_adjustmentOutItemDetailItemMaterialCode").val("");
                clearAdjustmentOutItemDetailData(selectedRowID);
            }
        });
    }
    
    function onChangeAdjustmentOutItemDetailReason(){
        
        var selectedRowID = $("#adjustmentOutItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var reasonCode = $("#" + selectedRowID + "_adjustmentOutItemDetailReasonCode").val();

        var url = "master/reason-get";
        var params ="reason.code=" + reasonCode;
            params+="&reason.activeStatus=TRUE";
            params+="&moduleParams=003_IVT_ADJUSTMENT_OUT";

        if(reasonCode===""){
            $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailReasonName"," ");                
            return;
        }
        
        $.post(url, params, function(result) {
            var data = (result);
            if (data.reasonTemp){
                $("#" + selectedRowID + "_adjustmentOutItemDetailReasonCode").val(data.reasonTemp.code);
                $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailReasonName",data.reasonTemp.name);                
            }
            else{
                alertMessage("Reason Not Found!",$("#" + selectedRowID + "_adjustmentOutItemDetailReasonCode"));
                $("#" + selectedRowID + "_adjustmentOutItemDetailReasonCode").val("");
                $("#adjustmentOutItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentOutItemDetailReasonName"," ");
            }
        });
    }
    
    function handlers_input_adjustment_out(){
        if(txtAdjustmentOutBranchCode.val()===""){
            handlersInput(txtAdjustmentOutBranchCode);
        }else{
            unHandlersInput(txtAdjustmentOutBranchCode);
        }
        if(dtpAdjustmentOutTransactionDate.val()===""){
            handlersInput(dtpAdjustmentOutTransactionDate);
        }else{
            unHandlersInput(dtpAdjustmentOutTransactionDate);
        }
        
        if(txtAdjustmentOutWarehouseCode.val()===""){
            handlersInput(txtAdjustmentOutWarehouseCode);
        }else{
            unHandlersInput(txtAdjustmentOutWarehouseCode);
        }
    }
</script>
<b> ADJUSTMENT OUT (DRAFT)</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlAdjustmentOutItemDetailInput" action="" />
<s:url id="remotedetailurlAdjustmentOutSerialNoDetailInput" action="" />

<div id="adjustmentOutInput" class="content ui-widget">
    <s:form id="frmAdjustmentOutInput">
        <div id="div-header-iot">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Adj-Out Code *</B></td>
                    <td>
                        <s:textfield id="adjustmentOut.code" name="adjustmentOut.code" size="20" readonly="true" ></s:textfield>
                        <s:textfield id="adjustmentOutUpdateMode" name="adjustmentOutUpdateMode" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:120px"><B>Branch *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            txtAdjustmentOutBranchCode.change(function(ev) {

                                if(txtAdjustmentOutBranchCode.val()===""){
                                    txtAdjustmentOutBranchName.val("");
                                    return;
                                }
                                var url = "master/branch-get";
                                var params = "branch.code=" + txtAdjustmentOutBranchCode.val();
                                    params += "&branch.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.branchTemp){
                                        txtAdjustmentOutBranchCode.val(data.branchTemp.code);
                                        txtAdjustmentOutBranchName.val(data.branchTemp.name);
                                    }
                                    else{
                                        alertMessage("Branch Not Found!",txtAdjustmentOutBranchCode);
                                        txtAdjustmentOutBranchCode.val("");
                                        txtAdjustmentOutBranchName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                            <s:textfield id="adjustmentOut.branch.code" name="adjustmentOut.branch.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                            <sj:a id="adjustmentOut_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-adjustment-out"/></sj:a>
                        </div>
                        <s:textfield id="adjustmentOut.branch.name" name="adjustmentOut.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="adjustmentOut.transactionDate" name="adjustmentOut.transactionDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" size="15" onchange="adjustmentOutTransactionDateOnChange()"></sj:datepicker>                        
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Warehouse *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            txtAdjustmentOutWarehouseCode.change(function(ev) {

                                if(txtAdjustmentOutWarehouseCode.val()===""){
                                    txtAdjustmentOutWarehouseName.val("");
                                    txtAdjustmentOutWarehouseRackCode.val("");
                                    txtAdjustmentOutWarehouseRackName.val("");
                                    return;
                                }
                                var url = "master/warehouse-get";
                                var params = "warehouse.code=" + txtAdjustmentOutWarehouseCode.val();
                                    params += "&warehouse.activeStatus=true";
                                
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.warehouseTemp){
                                        txtAdjustmentOutWarehouseCode.val(data.warehouseTemp.code);
                                        txtAdjustmentOutWarehouseName.val(data.warehouseTemp.name);
                                        txtAdjustmentOutWarehouseRackCode.val(data.warehouseTemp.dockInCode);
                                        txtAdjustmentOutWarehouseRackName.val(data.warehouseTemp.dockInName);
                                    }else{
                                        alertMessage("Warehouse Not Found!",txtAdjustmentOutWarehouseCode);
                                        txtAdjustmentOutWarehouseCode.val("");
                                        txtAdjustmentOutWarehouseName.val("");
                                        txtAdjustmentOutWarehouseRackCode.val("");
                                        txtAdjustmentOutWarehouseRackName.val("");
                                    }    
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="adjustmentOut.warehouse.code" name="adjustmentOut.warehouse.code" size="20" title=" " required="true" cssClass="required" ></s:textfield>
                            <sj:a id="adjustmentOut_btnWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="adjustmentOut.warehouse.name" name="adjustmentOut.warehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                            <s:textfield id="adjustmentOut.warehouse.dockInCode" name="adjustmentOut.warehouse.dockInCode" cssStyle="width:49%;display:none;" readonly="true" ></s:textfield>
                            <s:textfield id="adjustmentOut.warehouse.dockInName" name="adjustmentOut.warehouse.dockInName" cssStyle="width:49%;display:none;" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td><s:textfield id="adjustmentOut.refNo" name="adjustmentOut.refNo" size="30" ></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td><s:textarea id="adjustmentOut.remark" name="adjustmentOut.remark"  rows="3" cols="70" ></s:textarea> </td>
                </tr>
                <tr hidden="true">
                    <td/>
                    <td align="right">
                        <s:textfield id="adjustmentOut.grandTotalAmount" name="adjustmentOut.grandTotalAmount" cssClass="field-low" readonly="true" cssStyle="text-align:right"></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td>
                        <sj:datepicker id="adjustmentOutTransactionDate" name="adjustmentOutTransactionDate"  title=" " required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" size="25"></sj:datepicker>
                        <s:textfield id="adjustmentOut.transactionDateTemp" name="adjustmentOut.transactionDateTemp" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                        <s:textfield id="adjustmentOut.createdBy" name="adjustmentOut.createdBy" key="adjustmentOut.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="adjustmentOut.createdDate" name="adjustmentOut.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="adjustmentOut.createdDateTemp" name="adjustmentOut.createdDateTemp" size="20"></s:textfield>
                    </td>
                </tr>
            </table>
        </div>
        <br class="spacer" />
        
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnConfirmAdjustmentOut" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmAdjustmentOut" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
            
        <div id="adjustmentOutDetailInputGrid">
            <div id="adjustmentOutItemDetailInputGrid">
                <table>
                    <tr>
                        <td>
                            <sj:a href="#" id="btnAdjustmentOutNonSerialNoAddDetail" button="true" style="width: 90px">Search Item Material</sj:a>
                        </td>
                    </tr>
                </table> 
                <sjg:grid
                    id="adjustmentOutItemDetailInput_grid"
                    caption="Item Detail"
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
                    width="$('#tabmnuAdjustmentOut').width()"
                    editinline="true"
                    editurl="%{remotedetailurlAdjustmentOutItemDetailInput}"
                    onSelectRowTopics="adjustmentOutItemDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="adjustmentOutItemDetailTemp" index="adjustmentOutItemDetailTemp" key="adjustmentOutItemDetailTemp" title="" hidden="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutItemDetailItemDelete" index="adjustmentOutItemDetailItemDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'adjustmentOutItemDetailInputGrid_ItemDelete_OnClick()', value:'delete'}"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailItemMaterialCode" index = "adjustmentOutItemDetailItemMaterialCode" key = "adjustmentOutItemDetailItemMaterialCode" 
                        title = "Item Code *" width = "150" edittype="text" editable="true"
                        editoptions="{onChange:'onChangeAdjustmentOutItemDetailItem()'}" 
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailItemMaterialName" index = "adjustmentOutItemDetailItemMaterialName" key = "adjustmentOutItemDetailItemMaterialName" 
                        title = "Item Name" width = "250"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailItemMaterialSerialNoStatus" index = "adjustmentOutItemDetailItemMaterialSerialNoStatus" key = "adjustmentOutItemDetailItemMaterialSerialNoStatus" 
                        title = "Serial No Status" width = "100"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutItemDetailReasonSearch" index="adjustmentOutItemDetailReasonSearch" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"  
                        editoptions="{onClick:'adjustmentOutItemDetailInputGrid_SearchReason_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailReasonCode" index = "adjustmentOutItemDetailReasonCode" key = "adjustmentOutItemDetailReasonCode" 
                        title = "Reason Code *" width = "150" edittype="text" editable="true"
                        editoptions="{onChange:'onChangeAdjustmentOutItemDetailReason()'}" 
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailReasonName" index = "adjustmentOutItemDetailReasonName" key = "adjustmentOutItemDetailReasonName" 
                        title = "Reason Name" width = "250"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutItemDetailQuantity" index="adjustmentOutItemDetailQuantity" key="adjustmentOutItemDetailQuantity" 
                        title="Quantity *" width="80" align="right" edittype="text" editable="true"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"

                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailItemMaterialUnitOfMeasureCode" index = "adjustmentOutItemDetailItemMaterialUnitOfMeasureCode" key = "adjustmentOutItemDetailItemMaterialUnitOfMeasureCode" 
                        title = "UOM" width = "100"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutItemDetailRemark" index="adjustmentOutItemDetailRemark" key="adjustmentOutItemDetailRemark" title="Remark" width="250"  editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutItemDetailRackCode" index="adjustmentOutItemDetailRackCode" key="adjustmentOutItemDetailRackCode" 
                        title="Rack Code *" width="100"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutItemDetailRackName" index="adjustmentOutItemDetailRackName" key="adjustmentOutItemDetailRackName" 
                        title="Rack Name" width="100"
                    />
                </sjg:grid >
            </div>
            <br class="spacer" />
            <div id="adjustmentOutSerialNoDetailInputGrid">
                <table> 
                    <tr>
                        <td>
                            <sj:a href="#" id="btnAdjustmentOutSerialNoAddDetail" button="true" style="width: 130px">Search Item Serial</sj:a>
                        </td>
                    </tr>
                </table>
                <sjg:grid
                    id="adjustmentOutSerialNoDetailInput_grid"
                    caption="Serial No Detail"
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
                    width="$('#tabmnuadjustmentout').width()"
                    editinline="true"
                    editurl="%{remotedetailurlAdjustmentOutSerialNoDetailInput}"
                    onSelectRowTopics="adjustmentOutSerialNoDetailInput_grid_onSelect"
                    >
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetail" index="adjustmentOutSerialNoDetail" key="adjustmentOutSerialNoDetail" 
                        title="" width="50" editable="true" hidden="true" 
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailItemDelete" index="adjustmentOutSerialNoDetailItemDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'adjustmentOutSerialNoItemDetailInputGrid_ItemDelete_OnClick()', value:'delete'}"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailItemMaterialCode" index="adjustmentOutSerialNoDetailItemMaterialCode" key="adjustmentOutSerialNoDetailItemMaterialCode" 
                        title="Item Code" width="100" edittype="text"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailItemMaterialName" index="adjustmentOutSerialNoDetailItemMaterialName" key="adjustmentOutSerialNoDetailItemMaterialName" 
                        title="Item Name" width="150" edittype="text"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailSerialNo" index="adjustmentOutSerialNoDetailSerialNo" key="adjustmentOutSerialNoDetailSerialNo" 
                        title="Serial No" width="200" edittype="text"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailCode" index="adjustmentOutSerialNoDetailCode" key="adjustmentOutSerialNoDetailCode" 
                        title="SerialNoDetailCodeHIDE" width="200" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailTransactionCode" index="adjustmentOutSerialNoDetailTransactionCode" key="adjustmentOutSerialNoDetailTransactionCode" 
                        title="SerialNoDetailTransactionCodeHIDE" width="200" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailReasonSearch" index="adjustmentOutSerialNoDetailReasonSearch" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"  
                        editoptions="{onClick:'adjustmentOutSerialNoDetailInputGrid_SearchReason_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutSerialNoDetailReasonCode" index = "adjustmentOutSerialNoDetailReasonCode" key = "adjustmentOutSerialNoDetailReasonCode" 
                        title = "Reason Code *" width = "150" edittype="text" editable="true"
                        editoptions="{onChange:'onChangeAdjustmentOutSerialNoDetailReason()'}" 
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutSerialNoDetailReasonName" index = "adjustmentOutSerialNoDetailReasonName" key = "adjustmentOutSerialNoDetailReasonName" 
                        title = "Reason Name" width = "250"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailCapacity" index="adjustmentOutSerialNoDetailCapacity" key="adjustmentOutSerialNoDetailCapacity" 
                        title="Capacity" width="80" align="right" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailUsedCapacity" index="adjustmentOutSerialNoDetailUsedCapacity" key="adjustmentOutSerialNoDetailUsedCapacity" 
                        title="Used Capacity *" width="90" align="right" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailBalanceCapacity" index="adjustmentOutSerialNoDetailUsedCapacity" key="adjustmentOutSerialNoDetailUsedCapacity" 
                        title="Balance Capacity *" width="100" align="right" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailIotCapacity" index="adjustmentOutSerialNoDetailIotCapacity" key="adjustmentOutSerialNoDetailIotCapacity" 
                        title="IOT Quantity" width="80" align="right" edittype="text" editable="true"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "adjustmentOutSerialNoDetailRemark" index = "adjustmentOutSerialNoDetailRemark" key = "adjustmentOutSerialNoDetailRemark"
                        title = "Remark" width = "250" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailRackCode" index="adjustmentOutSerialNoDetailRackCode" key="adjustmentOutSerialNoDetailRackCode" 
                        title="Rack Code *" width="100"
                    />
                    <sjg:gridColumn
                        name="adjustmentOutSerialNoDetailRackName" index="adjustmentOutSerialNoDetailRackName" key="adjustmentOutSerialNoDetailRackName" 
                        title="Rack Name" width="100"
                    />
                </sjg:grid >
            </div>
        </div>
        <br class="spacer" />

        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnAdjustmentOutSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAdjustmentOutCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>
<script>
    
    
    function autoLoadDataAdjustmentOutItemDetail(){
        var url = "inventory/adjustment-out-item-detail-data";
        var params = "adjustmentOut.code=" + txtAdjustmentOutCode.val();

        showLoading();

        $.post(url, params, function(data) {
           adjustmentOutItemDetail_lastRowId=0;
            for (var i=0; i<data.listAdjustmentOutItemDetail.length; i++) {
                
                $("#adjustmentOutItemDetailInput_grid").jqGrid("addRowData", adjustmentOutItemDetail_lastRowId, data.listAdjustmentOutItemDetail[i]);
                $("#adjustmentOutItemDetailInput_grid").jqGrid('setRowData',adjustmentOutItemDetail_lastRowId,{
                    adjustmentOutItemDetailItemDelete                           : "delete",
                    adjustmentOutItemDetailItemSearch                           : "...",
                    adjustmentOutItemDetailItemMaterialCode                     : data.listAdjustmentOutItemDetail[i].itemMaterialCode,
                    adjustmentOutItemDetailItemMaterialName                     : data.listAdjustmentOutItemDetail[i].itemMaterialName,
                    adjustmentOutItemDetailItemMaterialSerialNoStatus           : data.listAdjustmentOutItemDetail[i].itemMaterialSerialNoStatus,
                    adjustmentOutItemDetailReasonSearch                         : "...",
                    adjustmentOutItemDetailReasonCode                           : data.listAdjustmentOutItemDetail[i].reasonCode,
                    adjustmentOutItemDetailReasonName                           : data.listAdjustmentOutItemDetail[i].reasonName,
                    adjustmentOutItemDetailQuantity                             : data.listAdjustmentOutItemDetail[i].quantity,
                    adjustmentOutItemDetailCOGSIDR                              : data.listAdjustmentOutItemDetail[i].cogsIdr,
                    adjustmentOutItemDetailItemMaterialUnitOfMeasureCode        : data.listAdjustmentOutItemDetail[i].itemMaterialUnitOfMeasureCode,
                    adjustmentOutItemDetailRackCode                             : data.listAdjustmentOutItemDetail[i].rackCode,
                    adjustmentOutItemDetailRackName                             : data.listAdjustmentOutItemDetail[i].rackName,
                    adjustmentOutItemDetailRemark                               : data.listAdjustmentOutItemDetail[i].remark
                });
                adjustmentOutItemDetail_lastRowId++;
            }
            //autoLoadDataAdjustmentOutItemSerialNoDetail();
            closeLoading();
        }); 
    }
     function autoLoadDataAdjustmentOutItemSerialNoDetail(){
        var urle = "inventory/adjustment-out-serial-no-detail-data";
        var paramse = "adjustmentOut.code=" + txtAdjustmentOutCode.val();
    //    alert(txtAdjustmentOutCode.val());
        showLoading();

        $.post(urle, paramse, function(datae) {
            adjustmentOutSerialNoDetail_lastRowId=0;
            
                for (var x=0; x<datae.listAdjustmentOutSerialNoDetail.length; x++) {
                adjustmentOutSerialNoDetail_lastRowId++;

                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid("addRowData", adjustmentOutSerialNoDetail_lastRowId, datae.listAdjustmentOutSerialNoDetail[x]);
                $("#adjustmentOutSerialNoDetailInput_grid").jqGrid('setRowData',adjustmentOutSerialNoDetail_lastRowId,{
                    adjustmentOutSerialNoDetailItemDelete                         : "delete",
                    adjustmentOutItemDetailItemMaterialStockSearch                : "...",
                    adjustmentOutSerialNoDetailItemMaterialCode                   : datae.listAdjustmentOutSerialNoDetail[x].itemMaterialCode,
                    adjustmentOutSerialNoDetailItemMaterialName                   : datae.listAdjustmentOutSerialNoDetail[x].itemMaterialName,
                    adjustmentOutSerialNoDetailReasonSearch                       : "...",
                    adjustmentOutSerialNoDetailReasonCode                         : datae.listAdjustmentOutSerialNoDetail[x].reasonCode,
                    adjustmentOutSerialNoDetailReasonName                         : datae.listAdjustmentOutSerialNoDetail[x].reasonName,
                    adjustmentOutSerialNoDetailSerialNo                           : datae.listAdjustmentOutSerialNoDetail[x].serialNo,
                    adjustmentOutSerialNoDetailCapacity                           : datae.listAdjustmentOutSerialNoDetail[x].capacity,
                    adjustmentOutSerialNoDetailIotCapacity                        : datae.listAdjustmentOutSerialNoDetail[x].capacity,
                    adjustmentOutSerialNoDetailRemark                             : datae.listAdjustmentOutSerialNoDetail[x].remark,
                    adjustmentOutSerialNoDetailRackCode                           : datae.listAdjustmentOutSerialNoDetail[x].rackCode,
                    adjustmentOutSerialNoDetailRackName                           : datae.listAdjustmentOutSerialNoDetail[x].rackName
                });
            }
            
            closeLoading();
            
        }); 
    }
</script>