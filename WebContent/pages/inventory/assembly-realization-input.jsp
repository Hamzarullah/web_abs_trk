<%-- 
    Document   : assembly-realization-input
    Created on : Dec 10, 2019, 9:04:30 PM
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
    .ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgAddRow{
        color: red;
    }
</style>

<script type="text/javascript">
    
    var assemblyRealizationItemBaseOnBOM_lastSel = -1, assemblyRealizationItemBaseOnBOM_lastRowId=0;    
    var assemblyRealizationItemBaseOnRealization_lastSel = -1, assemblyRealizationItemBaseOnRealization_lastRowId=0;
    
    var txtAssemblyRealizationCode = $("#assemblyRealization\\.code"),
        txtAssemblyRealizationAssemblyJobOrderCode = $("#assemblyRealization\\.assemblyJobOrder\\.code"),
        txtAssemblyRealizationAssemblyJobOrderBranchCode = $("#assemblyRealization\\.assemblyJobOrder\\.branch\\.code"),
        txtAssemblyRealizationAssemblyJobOrderBranchName = $("#assemblyRealization\\.assemblyJobOrder\\.branch\\.name"),
        txtAssemblyRealizationAssemblyJobOrderFinishGoodsQuantity = $("#assemblyRealization\\.assemblyJobOrder\\.finishGoodsQuantity"),
        txtAssemblyRealizationFinishGoodsQuantity = $("#assemblyRealization\\.realizationQuantity"),
        txtAssemblyRealizationAssemblyJobOrderFinishGoodsCode = $("#assemblyRealization\\.assemblyJobOrder\\.finishGoods\\.code"),
        txtAssemblyRealizationAssemblyJobOrderFinishGoodsName = $("#assemblyRealization\\.assemblyJobOrder\\.finishGoods\\.name"),
        dtpAssemblyRealizationTransactionDate = $("#assemblyRealization\\.transactionDate"),
        txtAssemblyRealizationWarehouseCode = $("#assemblyRealization\\.warehouse\\.code"),
        txtAssemblyRealizationWarehouseName = $("#assemblyRealization\\.warehouse\\.name"),
        txtAssemblyRealizationRefNo = $("#assemblyRealization\\.refNo"),
        txtAssemblyRealizationRemark = $("#assemblyRealization\\.remark"),
        txtAssemblyRealizationCreatedBy = $("#assemblyRealization\\.createdBy"),
        dtpAssemblyRealizationCreatedDate = $("#assemblyRealization\\.createdDate");
        
    $(document).ready(function(){
       
        flagConfirmAssemblyRealization=false;
        flagConfirmAssemblyRealizationDetail=false;
        
        $.subscribe("assemblyRealizationItemBaseOnBOMInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==assemblyRealizationItemBaseOnBOM_lastSel) {
                $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('saveRow',assemblyRealizationItemBaseOnBOM_lastSel); 
                $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('editRow',selectedRowID,true); 
                assemblyRealizationItemBaseOnBOM_lastSel=selectedRowID;
            }
            else{
                $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });   
        
        $.subscribe("assemblyRealizationItemBaseOnRealizationInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid("getGridParam", "selrow");
            
            if(selectedRowID!==assemblyRealizationItemBaseOnRealization_lastSel) {
                $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('saveRow',assemblyRealizationItemBaseOnRealization_lastSel); 
                $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('editRow',selectedRowID,true); 
                assemblyRealizationItemBaseOnRealization_lastSel=selectedRowID;
            }
            else{
                $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });  
        
            $("#assemblyRealization\\.realizationQuantity").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        
        $("#assemblyRealization\\.realizationQuantity").click(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommas(value); 
            });
           
        });
        
        $("#assemblyRealization\\.realizationQuantity").change(function(e){
            var exrate=$("#assemblyRealization\\.realizationQuantity").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#assemblyRealization\\.realizationQuantity").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#btnUnConfirmAssemblyRealization").css("display", "none");
        $("#btnConfirmAssemblyRealization").css("display", "block");
        $("#btnUnConfirmAssemblyRealizationDetail").css("display", "none");
        $("#btnConfirmAssemblyRealizationDetail").css("display", "block");
        
        $("#assemblyRealizationItemBaseOnBOMInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#assemblyRealizationItemBaseOnRealizationInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});  

        $("#btnConfirmAssemblyRealization").click(function(ev) {
            if(!$("#frmAssemblyRealizationInput").valid()) {
                ev.preventDefault();
                return;
            }
            
            var date1 = dtpAssemblyRealizationTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            
            var date2 = $("#assemblyRealizationTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#assemblyRealizationUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#assemblyRealizationTransactionDate").val(),dtpAssemblyRealizationTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpAssemblyRealizationTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#assemblyRealizationUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#assemblyRealizationTransactionDate").val(),dtpAssemblyRealizationTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpAssemblyRealizationTransactionDate);
                }
                return;
            }
            
            flagConfirmAssemblyRealization=true;
            $("#div-header-asm-realization").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#btnUnConfirmAssemblyRealization").css("display", "block");
            $("#btnConfirmAssemblyRealization").css("display", "none");
            $("#assemblyRealizationItemBaseOnBOMInputGrid").unblock();
            
            /* GET DATA BOM DETAIL FROM ASM JOB ORDER */
            var url = "inventory/assembly-job-order-item-detail-data";
            var params= "assemblyJobOrder.code=" + txtAssemblyRealizationAssemblyJobOrderCode.val();

            $.post(url, params, function(data) {

               var assemblyRealizationItemBaseOnBOM_lastRowId=0;
               $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('clearGridData'); 

                for (var i=0; i<data.listAssemblyJobOrderItemDetail.length; i++) {
                    
                    var finishGoodsQty = removeCommas(txtAssemblyRealizationFinishGoodsQuantity.val());
                    var jobQty = parseFloat(finishGoodsQty)*parseFloat(data.listAssemblyJobOrderItemDetail[i].quantity);
                    
                    $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid("addRowData", assemblyRealizationItemBaseOnBOM_lastRowId, data.listAssemblyJobOrderItemDetail[i]);
                    $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('setRowData',assemblyRealizationItemBaseOnBOM_lastRowId,{
                        assemblyRealizationItemBaseOnBOMItemMaterialCode          : data.listAssemblyJobOrderItemDetail[i].itemMaterialCode,
                        assemblyRealizationItemBaseOnBOMItemMaterialName          : data.listAssemblyJobOrderItemDetail[i].itemMaterialName,
                        assemblyRealizationItemBaseOnBOMBOMQuantity               : data.listAssemblyJobOrderItemDetail[i].quantity,
                        assemblyRealizationItemBaseOnBOMJobQuantity               : jobQty,
                        assemblyRealizationItemBaseOnBOMJobTotalQuantity          : jobQty,
                        assemblyRealizationItemBaseOnBOMUnitOfMeasureCode         : data.listAssemblyJobOrderItemDetail[i].unitOfMeasureCode
                    });

                    assemblyRealizationItemBaseOnBOM_lastRowId++;
                }
            }); 
        });
        
        $("#btnUnConfirmAssemblyRealization").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm This Item Detail?</div>');
            var rows = jQuery("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagConfirmAssemblyRealization=false;  
                $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('clearGridData');
                $("#btnUnConfirmAssemblyRealization").css("display", "none");
                $("#btnConfirmAssemblyRealization").css("display", "block");
                $("#div-header-asm-realization").unblock();
                $('#assemblyRealizationItemBaseOnBOMInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                return;
            }
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
                                            flagConfirmAssemblyRealization=false;
                                            $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('clearGridData');
                                            $("#btnUnConfirmAssemblyRealization").css("display", "none");
                                            $("#btnConfirmAssemblyRealization").css("display", "block");
                                            $("#div-header-asm-realization").unblock();
                                            $('#assemblyRealizationItemBaseOnBOMInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#btnConfirmAssemblyRealizationDetail").click(function(ev){
            
            flagConfirmAssemblyRealizationDetail = true;
            $("#btnUnConfirmAssemblyRealization").css("display", "block");
            $("#btnConfirmAssemblyRealization").css("display", "none");
            $("#assemblyRealizationItemBaseOnRealizationInputGrid").unblock();
            
            if($("#assemblyRealizationUpdateMode").val()==="true"){
                    loadAssemblyRealizationCOGSDB();
                }else{
                   loadAssemblyRealizationCOGS();
            }
            
        //    loadAssemblyRealizationCOGS();
        });
        
        $("#btnUnConfirmAssemblyRealizationDetail").click(function(ev){
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm This Item Detail?</div>');
            var rows = jQuery("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagConfirmAssemblyRealizationDetail = false;
                $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('clearGridData');
                $("#btnUnConfirmAssemblyRealization").css("display", "none");
                $("#btnConfirmAssemblyRealization").css("display", "block");
                $('#assemblyRealizationItemBaseOnRealizationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                return;
            }
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
                                            flagConfirmAssemblyRealizationDetail = false;
                                            $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('clearGridData');
                                            $("#btnUnConfirmAssemblyRealization").css("display", "none");
                                            $("#btnConfirmAssemblyRealization").css("display", "block");
                                            $('#assemblyRealizationItemBaseOnRealizationInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#btnAssemblyRealizationSave").click(function(ev) {
            
            if(assemblyRealizationItemBaseOnBOM_lastSel !== -1) {
                $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('saveRow',assemblyRealizationItemBaseOnBOM_lastSel); 
            }
            
            if(assemblyRealizationItemBaseOnRealization_lastSel !== -1) {
                $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('saveRow',assemblyRealizationItemBaseOnRealization_lastSel); 
            }

            var listAssemblyRealizationItemDetail = new Array(); 
            var ids = jQuery("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getRowData',ids[i]); 

                var assemblyRealizationItemDetail = {
                    itemMaterial    : { code : data.assemblyRealizationItemBaseOnBOMItemMaterialCode },
                    quantity        : data.assemblyRealizationItemBaseOnBOMJobTotalQuantity
                };
                listAssemblyRealizationItemDetail[i] = assemblyRealizationItemDetail;
            }
            
            var listAssemblyRealizationCOGS = new Array(); 
            var idsCOGS = jQuery("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < idsCOGS.length;i++){ 
                var data = $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('getRowData',idsCOGS[i]); 
                
                var assemblyRealizationCOGS = {
                    itemMaterial           : { code : data.assemblyRealizationItemBaseOnRealizationItemMaterialCode },
                    warehouse              : { code : txtAssemblyRealizationWarehouseCode.val() },
                    quantity               : data.assemblyRealizationItemBaseOnRealizationQuantity,
                    inDocumentType         : data.assemblyRealizationItemBaseOnRealizationInDocumentType,
                    remark                 : data.assemblyRealizationItemBaseOnRealizationRemark,
                    rack                   : { code : data.assemblyRealizationItemBaseOnRealizationRackCode }
                };
                listAssemblyRealizationCOGS[i] = assemblyRealizationCOGS;
            }
        
            formatDateASMWO();
            var url = "inventory/assembly-realization-save";
            var params = $("#frmAssemblyRealizationInput").serialize(); 
                params+= "&listAssemblyRealizationItemDetailJSON=" + $.toJSON(listAssemblyRealizationItemDetail);
                params+= "&listAssemblyRealizationCOGSJSON=" + $.toJSON(listAssemblyRealizationCOGS);
            
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateASMWO();
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
                                            var url = "inventory/assembly-realization-input";
                                            pageLoad(url, params, "#tabmnuASSEMBLY_REALIZATION");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");
                                            params = "";
                                            var url = "inventory/assembly-realization";
                                            pageLoad(url, params, "#tabmnuASSEMBLY_REALIZATION");
                                        }
                                    }]
                });
            });
        });
        
        $("#btnAssemblyRealizationCancel").click(function(ev){
            var params = "";
            var url = "inventory/assembly-realization";
            pageLoad(url, params, "#tabmnuASSEMBLY_REALIZATION");
        });

        $('#assemblyRealization_btnAssemblyJobOrder').click(function(ev) {
            
            var firstdate = $("#assemblyRealizationTransactionDateFirstSession").val();
            var lastdate = $("#assemblyRealizationTransactionDateLastSession").val();
            window.open("./pages/search/search-assembly-job-order.jsp?iddoc=assemblyRealization&idsubdoc=assemblyJobOrder&firstdate="+firstdate+"&lastdate="+lastdate,"Search", "Scrollbars=1,width=600, height=500");
        });
        
        $("#assemblyRealization_btnWarehouse").click(function(ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=assemblyRealization&idsubdoc=warehouse&modulecode=006_MNF_ASSEMBLY_REALIZATION","Search", "scrollbars=1,width=600, height=500");
        });
        
    });//EOF Ready
    
    function formatDateASMWO(){
        var transactionDate=formatDate(dtpAssemblyRealizationTransactionDate.val(),false);
        dtpAssemblyRealizationTransactionDate.val(transactionDate);
        
        var createdDate=formatDate(dtpAssemblyRealizationCreatedDate.val(),false);
        dtpAssemblyRealizationCreatedDate.val(createdDate);        
    }
    
    function assemblyRealizationTransactionDateOnChange(){
        if($("#assemblyRealizationUpdateMode").val()!=="true"){
            $("#assemblyRealizationTransactionDate").val(dtpAssemblyRealizationTransactionDate.val());
        }
    }
    
    function loadAssemblyRealizationCOGS(){
        
        if(assemblyRealizationItemBaseOnBOM_lastSel !== -1) {
            $('#assemblyRealizationItemBaseOnBOMInput_grid').jqGrid("saveRow",assemblyRealizationItemBaseOnBOM_lastSel);
        }

        var ids = jQuery("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getDataIDs');
        var listInventoryActualStock=new Array();
        var warehouseCode=txtAssemblyRealizationWarehouseCode.val();            
        var x=-1;                    
        for(var i=0;i < ids.length;i++){                
            var data = $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getRowData',ids[i]);             
            x++;
            var inventoryActualStock = {
                warehouse       : {code:warehouseCode},
                itemMaterial    : {code:data.assemblyRealizationItemBaseOnBOMItemMaterialCode},
                actualStock     : data.assemblyRealizationItemBaseOnBOMJobQuantity,
                TransactionCode : txtAssemblyRealizationCode.val()
            };
            listInventoryActualStock[x]=inventoryActualStock;
        }

        var url = "master/item-current-stock-assembly-realization-item-data";
        var params= "listInventoryActualStockJSON=" + $.toJSON(listInventoryActualStock);
    //    alert(params);
        showLoading();
        $.post(url, params, function(data) {
            closeLoading();
            if (data.error) {
                $("#btnUnConfirmAssemblyRealizationDetail").css("display", "none");
                $("#btnConfirmAssemblyRealizationDetail").css("display", "block");
                alertMessage(data.errorMessage);
                return;
            }

            assemblyRealizationItemBaseOnRealization_lastRowId = 0;
            
            $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid("clearGridData");
            
            for (var i=0; i<data.listIvtActualStock.length; i++) {

                if(data.listIvtActualStock[i].quantity>0){
                    assemblyRealizationItemBaseOnRealization_lastRowId++;

                    $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid("addRowData", assemblyRealizationItemBaseOnRealization_lastRowId, data.listIvtActualStock[i]);
                    $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('setRowData',assemblyRealizationItemBaseOnRealization_lastRowId,{
                        assemblyRealizationItemBaseOnRealizationItemMaterialCode          : data.listIvtActualStock[i].itemMaterialCode,
                        assemblyRealizationItemBaseOnRealizationItemMaterialName          : data.listIvtActualStock[i].itemMaterialName,
                        assemblyRealizationItemBaseOnRealizationInDocumentType            : data.listIvtActualStock[i].inventoryType,
                        assemblyRealizationItemBaseOnRealizationStockQuantity             : data.listIvtActualStock[i].quantity,
                        assemblyRealizationItemBaseOnRealizationUnitOfMeasureCode         : data.listIvtActualStock[i].unitOfMeasureCode,
                        assemblyRealizationItemBaseOnRealizationRackCode                  : data.listIvtActualStock[i].rackCode,
                        assemblyRealizationItemBaseOnRealizationRackName                  : data.listIvtActualStock[i].rackName
                    });
                }
            }
        });
   
    }
    
    function loadAssemblyRealizationCOGSDB(){
        
        if(assemblyRealizationItemBaseOnBOM_lastSel !== -1) {
            $('#assemblyRealizationItemBaseOnBOMInput_grid').jqGrid("saveRow",assemblyRealizationItemBaseOnBOM_lastSel);
        }

        var ids = jQuery("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getDataIDs');
        var listInventoryActualStock=new Array();
        var warehouseCode=txtAssemblyRealizationWarehouseCode.val();  
        var x=-1;   
        for(var i=0;i < ids.length;i++){                
            var data = $("#assemblyRealizationItemBaseOnBOMInput_grid").jqGrid('getRowData',ids[i]);             
            x++;
            var inventoryActualStock = {
                warehouse       : {code:warehouseCode},
                itemMaterial    : {code:data.assemblyRealizationItemBaseOnBOMItemMaterialCode},
                actualStock     : data.assemblyRealizationItemBaseOnBOMJobQuantity,
                TransactionCode : txtAssemblyRealizationCode.val()
            };
            listInventoryActualStock[x]=inventoryActualStock;
        }

        var url = "master/item-current-stock-assembly-realization-item-data";
        var params= "listInventoryActualStockJSON=" + $.toJSON(listInventoryActualStock);
    //    alert(params);
        showLoading();
        $.post(url, params, function(data) {
            closeLoading();
            if (data.error) {
                $("#btnUnConfirmAssemblyRealizationDetail").css("display", "none");
                $("#btnConfirmAssemblyRealizationDetail").css("display", "block");
                alertMessage(data.errorMessage);
                return;
            }

            assemblyRealizationItemBaseOnRealization_lastRowId = 0;
            
            $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid("clearGridData");
            
            for (var i=0; i<data.listIvtActualStock.length; i++) {

                if(data.listIvtActualStock[i].quantity>0){
                    assemblyRealizationItemBaseOnRealization_lastRowId++;

                    $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid("addRowData", assemblyRealizationItemBaseOnRealization_lastRowId, data.listIvtActualStock[i]);
                    $("#assemblyRealizationItemBaseOnRealizationInput_grid").jqGrid('setRowData',assemblyRealizationItemBaseOnRealization_lastRowId,{
                        assemblyRealizationItemBaseOnRealizationItemMaterialCode          : data.listIvtActualStock[i].itemMaterialCode,
                        assemblyRealizationItemBaseOnRealizationItemMaterialName          : data.listIvtActualStock[i].itemMaterialName,
                        assemblyRealizationItemBaseOnRealizationInDocumentType            : data.listIvtActualStock[i].inventoryType,
                        assemblyRealizationItemBaseOnRealizationStockQuantity             : data.listIvtActualStock[i].quantity,
                        assemblyRealizationItemBaseOnRealizationQuantity                  : data.listIvtActualStock[i].quantity,
                        assemblyRealizationItemBaseOnRealizationUnitOfMeasureCode         : data.listIvtActualStock[i].unitOfMeasureCode,
                        assemblyRealizationItemBaseOnRealizationRemark                    : data.listIvtActualStock[i].remark,
                        assemblyRealizationItemBaseOnRealizationRackCode                  : data.listIvtActualStock[i].rackCode,
                        assemblyRealizationItemBaseOnRealizationRackName                  : data.listIvtActualStock[i].rackName
                    });
                }
            }
        });
   
    }
    
     function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
</script>
<b>ASSEMBLY REALIZATION</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlAssemblyRealizationItemDetailInput" action="" />

<div id="assemblyRealizationInput" class="content ui-widget">
    <s:form id="frmAssemblyRealizationInput">
        <div id="div-header-asm-realization">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Code *</B></td>
                    <td>
                        <s:textfield id="assemblyRealization.code" name="assemblyRealization.code" size="30" readonly="true" ></s:textfield>
                        <s:textfield id="assemblyRealizationUpdateMode" name="assemblyRealizationUpdateMode" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="assemblyRealization.transactionDate" name="assemblyRealization.transactionDate"  title="*" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="30" onchange="assemblyRealizationTransactionDateOnChange()"></sj:datepicker>
                        <sj:datepicker id="assemblyRealizationTransactionDate" name="assemblyRealizationTransactionDate"  title="*" required="true" cssClass="required" showOn="focus" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="30" cssStyle="display:none"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:120px"><B>ASM-JOB *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            txtAssemblyRealizationAssemblyJobOrderCode.change(function(ev) {

                                if(txtAssemblyRealizationAssemblyJobOrderCode.val()===""){
                                    return;
                                }
                                var url = "master/assembly-job-order-get";
                                var params = "assemblyJobOrder.code=" + txtAssemblyRealizationAssemblyJobOrderCode.val();
            
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.assemblyJobOrderTemp){
                                        txtAssemblyRealizationAssemblyJobOrderCode.val(data.assemblyJobOrderTemp.code);
                                    }
                                    else{
                                        alertMessage("AssemblyJobOrder Not Found!",txtAssemblyRealizationAssemblyJobOrderCode);
                                        txtAssemblyRealizationAssemblyJobOrderCode.val("");
                                    }
                                });
                            });
                            
                            if($("#assemblyRealizationUpdateMode").val()==="true"){
                                txtAssemblyRealizationAssemblyJobOrderCode.attr("readonly",true);
                                $("#assemblyRealization_btnAssemblyJobOrder").hide();
                                $("#ui-icon-search-assemblyJobOrder-assembly-realization").hide();
                            }else{
                                txtAssemblyRealizationAssemblyJobOrderCode.attr("readonly",false);
                                $("#assemblyRealization_btnAssemblyJobOrder").show();
                                $("#ui-icon-search-assemblyJobOrder-assembly-realization").show();
                            }
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                            <s:textfield id="assemblyRealization.assemblyJobOrder.code" name="assemblyRealization.assemblyJobOrder.code" required="true" cssClass="required" title="*" size="25"></s:textfield>
                            <sj:a id="assemblyRealization_btnAssemblyJobOrder" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-assemblyJobOrder-assembly-realization"/></sj:a>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:120px">Branch</td>
                    <td colspan="2">
                        <s:textfield id="assemblyRealization.assemblyJobOrder.branch.code" name="assemblyRealization.assemblyJobOrder.branch.code" required="true" cssClass="required" readonly="true" title="*" size="30"></s:textfield>
                        <s:textfield id="assemblyRealization.assemblyJobOrder.branch.name" name="assemblyRealization.assemblyJobOrder.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">Finish Goods </td>
                    <td colspan="2">
                        <s:textfield id="assemblyRealization.assemblyJobOrder.finishGoods.code" name="assemblyRealization.assemblyJobOrder.finishGoods.code" required="true" readonly="true" cssClass="required" title="*" size="30"></s:textfield>
                        <s:textfield id="assemblyRealization.assemblyJobOrder.finishGoods.name" name="assemblyRealization.assemblyJobOrder.finishGoods.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>    
                </tr>
                <tr>
                    <td align="right">BOM</td>
                    <td colspan="2">
                        <s:textfield id="assemblyRealization.assemblyJobOrder.billOfMaterial.code" name="assemblyRealization.assemblyJobOrder.billOfMaterial.code" readonly="true" size="30" title="*" required="true" cssClass="required"></s:textfield>
                        <s:textfield id="assemblyRealization.assemblyJobOrder.billOfMaterial.name" name="assemblyRealization.assemblyJobOrder.billOfMaterial.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Job Quantity</td>
                    <td><s:textfield readonly="true" id="assemblyRealization.assemblyJobOrder.finishGoodsQuantity" name="assemblyRealization.assemblyJobOrder.finishGoodsQuantity" size="10" cssStyle="text-align:right"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Warehouse *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            
                        txtAssemblyRealizationWarehouseCode.change(function(ev) {

                            if(txtAssemblyRealizationWarehouseCode.val()===""){
                                txtAssemblyRealizationWarehouseName.val("");
                                return;
                            }
                            var url = "master/warehouse-get";
                            var params = "warehouse.code=" + txtAssemblyRealizationWarehouseCode.val();

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.warehouseTemp){
                                    txtAssemblyRealizationWarehouseCode.val(data.warehouseTemp.code);
                                    txtAssemblyRealizationWarehouseName.val(data.warehouseTemp.name);
                                }
                                else{
                                    alertMessage("Warehouse Not Found!",txtAssemblyRealizationWarehouseCode);
                                    txtAssemblyRealizationWarehouseCode.val("");
                                    txtAssemblyRealizationWarehouseName.val("");
                                }
                            });
                        });                      
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="assemblyRealization.warehouse.code" name="assemblyRealization.warehouse.code" size="25" title="*" required="true" cssClass="required" ></s:textfield>
                            <sj:a id="assemblyRealization_btnWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="assemblyRealization.warehouse.name" name="assemblyRealization.warehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Realization Quantity *</B></td>
                    <td><s:textfield id="assemblyRealization.realizationQuantity" name="assemblyRealization.realizationQuantity" size="10" cssStyle="text-align:right"></s:textfield>&nbsp;<span class="errMsgNumric" id="errmsgExchangeRate"></span></td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td><s:textfield id="assemblyRealization.refNo" name="assemblyRealization.refNo" size="30" ></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td><s:textarea id="assemblyRealization.remark" name="assemblyRealization.remark"  rows="3" cols="70" ></s:textarea> </td>
                </tr>
                <tr hidden="true">
                    <td>
                        <sj:datepicker id="assemblyRealizationTransactionDateFirstSession" name="assemblyRealizationTransactionDateFirstSession" size="15" displayFormat="dd/mm/yy" showOn="focus" style="display:none"></sj:datepicker>
                        <sj:datepicker id="assemblyRealizationTransactionDateLastSession" name="assemblyRealizationTransactionDateLastSession" size="15" displayFormat="dd/mm/yy" showOn="focus" style="display:none"></sj:datepicker>
                        <s:textfield id="assemblyRealization.createdBy" name="assemblyRealization.createdBy" key="assemblyRealization.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="assemblyRealization.createdDate" name="assemblyRealization.createdDate" title="*" displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
            </table>
        </div>
        <br class="spacer" />
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnConfirmAssemblyRealization" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmAssemblyRealization" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
        <div id="assemblyRealizationItemBaseOnBOMInputGrid">
            <sjg:grid
                id="assemblyRealizationItemBaseOnBOMInput_grid"
                caption="Base On Job Order"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAssemblyRealizationItemDetailTemp"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuAssemblyRealization').width()"
                editinline="true"
                editurl="%{remotedetailurlAssemblyRealizationItemDetailInput}"
                onSelectRowTopics="assemblyRealizationItemBaseOnBOMInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnBOMItemMaterialCode" index = "assemblyRealizationItemBaseOnBOMItemMaterialCode" key = "assemblyRealizationItemBaseOnBOMItemMaterialCode" 
                    title = "Item Code *" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnBOMItemMaterialName" index = "assemblyRealizationItemBaseOnBOMItemMaterialName" key = "assemblyRealizationItemBaseOnBOMItemMaterialName" 
                    title = "Item Name" width = "250"
                />
                <sjg:gridColumn
                    name="assemblyRealizationItemBaseOnBOMBOMQuantity" index="assemblyRealizationItemBaseOnBOMBOMQuantity" key="assemblyRealizationItemBaseOnBOMBOMQuantity" 
                    title="BOM Quantity" width="100" align="right" edittype="text" editable="false"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="assemblyRealizationItemBaseOnBOMJobQuantity" index="assemblyRealizationItemBaseOnBOMJobQuantity" key="assemblyRealizationItemBaseOnBOMJobQuantity" 
                    title="Formula" width="100" align="right" edittype="text" editable="false"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="assemblyRealizationItemBaseOnBOMJobTotalQuantity" index="assemblyRealizationItemBaseOnBOMJobTotalQuantity" key="assemblyRealizationItemBaseOnBOMJobQuantity" 
                    title="Total Quantity" width="150" align="right" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnBOMUnitOfMeasureCode" index = "assemblyRealizationItemBaseOnBOMUnitOfMeasureCode" key = "assemblyRealizationItemBaseOnBOMUnitOfMeasureCode" 
                    title = "Unit Code" width = "150" edittype="text" editable="false"
                />
            </sjg:grid >
        </div>
        
        <br class="spacer" />
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnConfirmAssemblyRealizationDetail" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmAssemblyRealizationDetail" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
        
        <div id="assemblyRealizationItemBaseOnRealizationInputGrid">
            <sjg:grid
                id="assemblyRealizationItemBaseOnRealizationInput_grid"
                caption="Base On Realization"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAssemblyRealizationItemDetailTemp"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuAssemblyRealization').width()"
                editinline="true"
                editurl="%{remotedetailurlAssemblyRealizationItemDetailInput}"
                onSelectRowTopics="assemblyRealizationItemBaseOnRealizationInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationItemMaterialCode" index = "assemblyRealizationItemBaseOnRealizationItemMaterialCode" key = "assemblyRealizationItemBaseOnRealizationItemMaterialCode" 
                    title = "Item Code *" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationItemMaterialName" index = "assemblyRealizationItemBaseOnRealizationItemMaterialName" key = "assemblyRealizationItemBaseOnRealizationItemMaterialName" 
                    title = "Item Name" width = "250"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationInDocumentType" index="assemblyRealizationItemBaseOnRealizationInDocumentType" key="assemblyRealizationItemBaseOnRealizationInDocumentType" title="In Document Type" width="100" edittype="text" hidden="true"
                />
                <sjg:gridColumn
                    name="assemblyRealizationItemBaseOnRealizationStockQuantity" index="assemblyRealizationItemBaseOnRealizationStockQuantity" key="assemblyRealizationItemBaseOnRealizationStockQuantity" 
                    title="Stock Quantity" width="150" align="right" edittype="text" editable="false"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="assemblyRealizationItemBaseOnRealizationQuantity" index="assemblyRealizationItemBaseOnRealizationQuantity" key="assemblyRealizationItemBaseOnRealizationQuantity" 
                    title="Quantity " width="100" align="left" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationUnitOfMeasureCode" index = "assemblyRealizationItemBaseOnRealizationUnitOfMeasureCode" key = "assemblyRealizationItemBaseOnRealizationUnitOfMeasureCode" 
                    title = "UOM" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationRemark" index = "assemblyRealizationItemBaseOnRealizationRemark" key = "assemblyRealizationItemBaseOnRealizationRemark" 
                    title = "Remark" width = "150" edittype="text" editable="true"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationRackCode" index = "assemblyRealizationItemBaseOnRealizationRackCode" key = "assemblyRealizationItemBaseOnRealizationRackCode" 
                    title = "Rack Code *" width = "150" edittype="text" editable="false"
                />
                <sjg:gridColumn
                    name = "assemblyRealizationItemBaseOnRealizationRackName" index = "assemblyRealizationItemBaseOnRealizationRackName" key = "assemblyRealizationItemBaseOnRealizationRackName" 
                    title = "Rack Name" width = "250"
                />
            </sjg:grid >
        </div>
        <br class="spacer" />
        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnAssemblyRealizationSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAssemblyRealizationCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        
    </s:form>
</div>