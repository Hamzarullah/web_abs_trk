
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.10/lodash.min.js"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
    
<style> 
    .ui-dialog-titlebar-close{
        display: none;
    }
    
    #imrProductionPlanningOrderDetailInput_grid_pager_center,#imrBillOfMaterialDetailInput_grid_pager_center,
    #processedPart_grid_pager_center,#imrItemMaterialRequestBookedInput_grid_pager_center,#imrItemMaterialRequestBookedDetailInput_grid_pager_center,
    #imrItemMaterialRequestInput_grid_pager_center,#imrItemMaterialRequestDetailInput_grid_pager_center,
    #imrItemMaterialRequestDetailInput_grid_pager_center,#imrItemMaterialRequestDetailInput_grid_pager_center{
        display: none;
    }
    
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>
<script type="text/javascript">
    var imrProductionPlanningOrderItemDetailLastRowId = 0,
        imrProductionPlanningOrderItemDetailLastSel = -1,
        imrBillOfMaterialDetailLastRowId = 0,
        imrBillOfMaterialDetailLastSel = -1,
        processedPartRowId = 0,
        processedPartLastSel = -1,
        imrMaterialBookedRowId = 0,
        imrMaterialBookedLastSel = -1,
        imrItemMaterialRequestBookedDetailRowId = 0,
        imrItemMaterialRequestBookedDetailLastSel = -1,
        imrItemMaterialRequestRowId= 0,
        imrItemMaterialRequestLastSel= -1,
        imrItemMaterialRequestDetailRowId = 0,
        imrItemMaterialRequestDetailLastSel = -1;
    
    var                                    
        txtItemMaterialRequestCode = $("#itemMaterialRequest\\.code"),
        dtpItemMaterialRequestTransactionDate = $("#itemMaterialRequest\\.transactionDate"),
        txtItemMaterialRequestWarehouseCode = $("#itemMaterialRequest\\.warehouse\\.code"),
        txtItemMaterialRequestWarehouseName = $("#itemMaterialRequest\\.warehouse\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedPPOOptions=false;
        flagIsConfirmedIMR=false;
        hoverButton();
        
        $("#btnConfirmItemMaterialRequest").css("display", "block");
        $("#btnUnConfirmItemMaterialRequest").css("display", "none");
        $("#btnSearchItemBooked").css("display", "none");
        $("#btnSearchItemRequest").css("display", "none");
        $("#btnConfirmItemMaterialRequestProcess").css("display", "none");
        $("#btnUnConfirmItemMaterialRequestProcess").css("display", "none");
        $('#id-item-material-request-detail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $('#id-item-material-request-detail-process').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $.subscribe("imrBillOfMaterialItemDetailInput_grid_onSelect", function() {
           
            var selectedRowID = $("#imrBillOfMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==processedPartLastSel) {
                $('#imrBillOfMaterialDetailInput_grid').jqGrid("saveRow",processedPartLastSel); 
                $('#imrBillOfMaterialDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                processedPartLastSel=selectedRowID;
            }
            else{
                $('#imrBillOfMaterialDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("imrItemMaterialRequestBookedInput_grid_onSelect", function() {
           
            var selectedRowID = $("#imrItemMaterialRequestBookedInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==imrMaterialBookedLastSel) {
                $('#imrItemMaterialRequestBookedInput_grid').jqGrid("saveRow",imrMaterialBookedLastSel); 
                $('#imrItemMaterialRequestBookedInput_grid').jqGrid("editRow",selectedRowID,true);            
                imrMaterialBookedLastSel=selectedRowID;
            }
            else{
                $('#imrItemMaterialRequestBookedInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("imrItemMaterialRequestInput_grid_onSelect", function(){
           
            var selectedRowID = $("#imrItemMaterialRequestInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==imrItemMaterialRequestLastSel) {
                $('#imrItemMaterialRequestInput_grid').jqGrid("saveRow",imrItemMaterialRequestLastSel); 
                $('#imrItemMaterialRequestInput_grid').jqGrid("editRow",selectedRowID,true);            
                imrItemMaterialRequestLastSel=selectedRowID;
            }
            else{
                $('#imrItemMaterialRequestInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("imrItemMaterialRequestBookedDetailInput_grid_onSelect", function(){
           
            var selectedRowID = $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==imrItemMaterialRequestBookedDetailLastSel) {
                $('#imrItemMaterialRequestBookedDetailInput_grid').jqGrid("saveRow",imrItemMaterialRequestBookedDetailLastSel); 
                $('#imrItemMaterialRequestBookedDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                imrItemMaterialRequestBookedDetailLastSel=selectedRowID;
            }
            else{
                $('#imrItemMaterialRequestBookedDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("imrItemMaterialRequestDetailInput_grid_onSelect", function(){
           
            var selectedRowID = $("#imrItemMaterialRequestDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==imrItemMaterialRequestDetailLastSel) {
                $('#imrItemMaterialRequestDetailInput_grid').jqGrid("saveRow",imrItemMaterialRequestDetailLastSel); 
                $('#imrItemMaterialRequestDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                imrItemMaterialRequestDetailLastSel=selectedRowID;
            }
            else{
                $('#imrItemMaterialRequestDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $("#itemMaterialRequest_btnProductionPlanningOrder").click(function(ev){
            window.open("./pages/search/search-production-planning-order.jsp?iddoc=itemMaterialRequest&idsubdoc=productionPlanningOrder","Search", "scrollbars=1,width=600, height=500");
        });
        
        $("#btnConfirmItemMaterialRequest").click(function(ev){
            handlers_input_production_planning_order();
            if($("#itemMaterialRequest\\.productionPlanningOrder\\.code").val()==="") {
                alertMessage("Production Planning Order Can't Empty!");
                ev.preventDefault();
                return;
            }
            
            if($("#itemMaterialRequest\\.warehouse\\.code").val()===""){
                alertMessage("Warehouse Can't Empty!");
                ev.preventDefault();
                return;
            }
                
            flagIsConfirmedIMR=true;
            if($("#enumItemMaterialRequestActivity").val()==="UPDATE"){ 
//                    loadDataInternalMemoProductionDetail();
            }

            loadDataImrProductionPlanningOrderDocumentItemDetail();

            $("#btnConfirmItemMaterialRequest").css("display", "none");
            $("#btnUnConfirmItemMaterialRequest").css("display", "block");
            $("#btnConfirmItemMaterialRequestProcess").css("display", "block");
            $('#headerItemMaterialRequestInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#id-item-material-request-detail').unblock();
        }); 
        
        $("#btnUnConfirmItemMaterialRequest").click(function(ev){
             var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#imrProductionPlanningOrderDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                $("#btnUnConfirmItemMaterialRequest").css("display", "none");
                $("#btnConfirmItemMaterialRequestProcess").css("display", "none");
                $("#btnConfirmItemMaterialRequest").css("display", "block");
                $('#headerItemMaterialRequestInput').unblock();
                $('#id-item-material-request-detail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                flagIsConfirmedIMR=false;
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
                            flagIsConfirmedIMR=false;
                            $("#imrProductionPlanningOrderDetailInput_grid").jqGrid('clearGridData');
                            $("#imrBillOfMaterialDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmItemMaterialRequest").css("display", "none");
                            $("#btnConfirmItemMaterialRequestProcess").css("display", "none");
                            $("#btnConfirmItemMaterialRequest").css("display", "block");
                            $('#headerItemMaterialRequestInput').unblock();
                            $('#id-item-material-request-detail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#btnConfirmItemMaterialRequestProcess").click(function(ev){
            $("#processedPart_grid").jqGrid('clearGridData');
            
            if(imrBillOfMaterialDetailLastSel !== -1) {
                $('#imrBillOfMaterialDetailInput_grid').jqGrid("saveRow",imrBillOfMaterialDetailLastSel); 
            }
            
            var ids = jQuery("#imrBillOfMaterialDetailInput_grid").jqGrid('getDataIDs'); 
            for(var i=0; i<ids.length; i++){
                var data = $("#imrBillOfMaterialDetailInput_grid").jqGrid('getRowData',ids[i]);
                
                if (data.imrBillOfMaterialDetailItemMaterialCode !== ""){
                    continue;
                }
                if($("input:checkbox[id='jqg_imrBillOfMaterialDetailInput_grid_"+ids[i]+"']").is(":checked")){
                    var defRow = {
                        imrProcessedBillOfMaterialDetailDelete                      : "delete",
                        imrProcessedBillOfMaterialBOMDetailCode                     : data.imrBillOfMaterialDetailCode,
                        imrProcessedBillOfMaterialDetailDocumentDetailCode          : data.imrBillOfMaterialDetailDocumentDetailCode,
                        imrProcessedBillOfMaterialDetailItemFinishGoodsCode         : data.imrBillOfMaterialDetailItemFinishGoodsCode,
                        imrProcessedBillOfMaterialDetailItemFinishGoodsRemark       : data.imrBillOfMaterialDetailItemFinishGoodsRemark,
                        imrProcessedBillOfMaterialDetailItemPpoNo                   : data.imrBillOfMaterialDetailItemPpoNo,
                        imrProcessedBillOfMaterialDetailDocumentSortNo              : data.imrBillOfMaterialDetailDocumentSortNo,
                        imrProcessedBillOfMaterialDetailPartNo                      : data.imrBillOfMaterialDetailPartNo,
                        imrProcessedBillOfMaterialDetailPartCode                    : data.imrBillOfMaterialDetailPartCode,
                        imrProcessedBillOfMaterialDetailPartName                    : data.imrBillOfMaterialDetailPartName,   
                        imrProcessedBillOfMaterialDetailDrawingCode                 : data.imrBillOfMaterialDetailDrawingCode,
                        imrProcessedBillOfMaterialDetailDimension                   : data.imrBillOfMaterialDetailDimension,
                        imrProcessedBillOfMaterialDetailRequiredLength              : data.imrBillOfMaterialDetailRequiredLength,
                        imrProcessedBillOfMaterialDetailMaterial                    : data.imrBillOfMaterialDetailMaterial,
                        imrProcessedBillOfMaterialDetailQuantity                    : data.imrBillOfMaterialDetailQuantity,
                        imrProcessedBillOfMaterialDetailRequirement                 : data.imrBillOfMaterialDetailRequirement,
                        imrProcessedBillOfMaterialDetailProcessedStatus             : data.imrBillOfMaterialDetailProcessedStatus,
                        imrProcessedBillOfMaterialDetailRemark                      : data.imrBillOfMaterialDetailRemark,
                        imrProcessedBillOfMaterialDetailX                           : data.imrBillOfMaterialDetailX,
                        imrProcessedBillOfMaterialDetailRevNo                       : data.imrBillOfMaterialDetailRevNo
                    };
                    
                    processedPartRowId++;
                    $("#processedPart_grid").jqGrid("addRowData", processedPartRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#processedPart_grid").jqGrid('setRowData',processedPartRowId,{Buttons:be});
                    ev.preventDefault();
                }
            }
            
            let idl = jQuery("#processedPart_grid").jqGrid('getDataIDs'); 
            if (idl.length === 0){
                alertMessage("At least checked 1 grid to process");
                return;
            }
            
            $("#btnUnConfirmItemMaterialRequest").css("display", "none");
            $("#btnConfirmItemMaterialRequestProcess").css("display", "none");
            $("#btnUnConfirmItemMaterialRequestProcess").css("display", "block");
            $("#btnSearchItemBooked").css("display", "block");
            $("#btnSearchItemRequest").css("display", "block");
            $('#id-item-material-request-detail').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#id-item-material-request-detail-process').unblock();
        });
        
        $("#btnUnConfirmItemMaterialRequestProcess").click(function(ev){
             var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#processedPart_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                $("#btnUnConfirmItemMaterialRequestProcess").css("display", "none");
                $("#btnConfirmItemMaterialRequestProcess").css("display", "none");
                $("#btnUnConfirmItemMaterialRequest").css("display", "block");
                $("#btnConfirmItemMaterialRequestProcess").css("display", "block");
                $("#btnSearchItemBooked").css("display", "none");
                $("#btnSearchItemRequest").css("display", "none");
                $('#id-item-material-request-detail').unblock();
                $('#id-item-material-request-detail-process').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                            $("#processedPart_grid").jqGrid('clearGridData');
                            $("#imrItemMaterialRequestBookedInput_grid").jqGrid('clearGridData');
                            $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('clearGridData');
                            $("#imrItemMaterialRequestInput_grid").jqGrid('clearGridData');
                            $("#imrItemMaterialRequestDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmItemMaterialRequestProcess").css("display", "none");
                            $("#btnConfirmItemMaterialRequestProcess").css("display", "none");
                            $("#btnUnConfirmItemMaterialRequest").css("display", "block");
                            $("#btnConfirmItemMaterialRequestProcess").css("display", "block");
                            $("#btnSearchItemBooked").css("display", "none");
                            $("#btnSearchItemRequest").css("display", "none");
                            $('#id-item-material-request-detail').unblock();
                            $('#id-item-material-request-detail-process').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#itemMaterialRequest_btnWarehouse").click(function(ev){
            window.open("./pages/search/search-warehouse.jsp?iddoc=itemMaterialRequest&idsubdoc=warehouse","Search", "width=600, height=500");
        });
        
        $("#btnSearchItemBooked").click(function(ev){
            window.open("./pages/search/search-item-material-booking.jsp?iddoc=imrItemMaterialRequestBooked&warehouseCode="+$("#itemMaterialRequest\\.warehouse\\.code").val()+"&rowLast="+imrMaterialBookedRowId,"Search", "width=600, height=500");
        });
        
        $("#btnSearchItemRequest").click(function(ev){
            window.open("./pages/search/search-item-material-imr-request.jsp?iddoc=imrItemMaterialRequest&warehouseCode="+$("#itemMaterialRequest\\.warehouse\\.code").val()+"&rowLast="+imrItemMaterialRequestRowId,"Search", "width=600, height=500");
        });
        
        $("#btnItemMaterialRequestSave").click(function(ev){
            
            let listProcessedPartDetail = new Array();
            let ida = jQuery("#processedPart_grid").jqGrid('getDataIDs');
            
            if(ida.length === 0){
                alert("Fill Processed Grid Detail");
                return;
            }
            
            for(var i=0; i<ida.length; i++){
                var data = $("#processedPart_grid").jqGrid('getRowData',ida[i]);
                
                var processedData ={
                  documentSortNo                    : data.imrProcessedBillOfMaterialDetailDocumentSortNo,
                  documentDetailCode                : data.imrProcessedBillOfMaterialDetailDocumentDetailCode,
                  itemFinishGoods                   : {code:data.imrProcessedBillOfMaterialDetailItemFinishGoodsCode},
                  itemProductionPlanningOrderNo     : data.imrProcessedBillOfMaterialDetailItemPpoNo,
                  partCode                          : data.imrProcessedBillOfMaterialDetailPartCode
                };
                
                listProcessedPartDetail[i] = processedData;
            }
            
            let listItemBookingDetail = new Array();
            let idb = jQuery("#imrItemMaterialRequestBookedInput_grid").jqGrid('getDataIDs');
            
            if(idb.length === 0){
                alert("Fill Item Material Request Booked Grid");
                return;
            }
            
            for (var j=0; j<idb.length; j++){
                var dataBook = $("#imrItemMaterialRequestBookedInput_grid").jqGrid('getRowData',idb[j]);
                
                if(dataBook.imrItemMaterialRequestBookedCode === ""){
                    alert("Item Material Can't be empty ");
                    return;
                }
                
                if(parseFloat(dataBook.imrItemMaterialRequestBookQuantity) <= 0){
                    alert("Quantity must greater than 0");
                    return;
                }
                
                let bookingDetail ={
                        itemMaterial    : {code: dataBook.imrItemMaterialRequestBookedCode},
                        remark          : dataBook.imrItemMaterialRequestBookedRemark,
                        bookingQuantity : dataBook.imrItemMaterialRequestBookQuantity
                };
                
                listItemBookingDetail[j] = bookingDetail;
            }
            
            let listItemBookingPartDetail = new Array();
            let idc = jQuery("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getDataIDs');
            
            if(idc.length === 0){
                alert("Fill Part Item Material Request Booked Grid");
                return;
            }
            
            for(var k=0; k<idc.length; k++){
                var dataPartBook = $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getRowData', idc[k]);
                
                let partBookDetail ={
                  itemMaterialRequestBookingDetailCode                : dataPartBook.imrItemMaterialRequestBookedDetailItemMaterialCode,
                  itemMaterialRequestBookingDocumentDetailCode        : dataPartBook.imrItemMaterialRequestBookedDetailDocumentDetailCode,
                  itemMaterialRequestBookingFinishGoodsCode           : dataPartBook.imrItemMaterialRequestBookedDetailItemFinishGoodsCode,
                  itemMaterialRequestBookingFinishPartCode            : dataPartBook.imrItemMaterialRequestBookedDetailPartCode
                };
                
                listItemBookingPartDetail[k] = partBookDetail;
            }
            
            let listItemRequestDetail = new Array();
            let idd = jQuery("#imrItemMaterialRequestInput_grid").jqGrid('getDataIDs');
            
            if(idd.length === 0){
                alert("Fill Item Material Requested Grid");
                return;
            }
            
            for(var l=0; l<idd.length; l++){
                var dataRequest = $("#imrItemMaterialRequestInput_grid").jqGrid('getRowData', idd[l]);
                
                let requestDetail={
                    itemMaterial    : {code: dataRequest.imrItemMaterialCodeRequest},
                    remark          : dataRequest.imrItemMaterialRemarkRequest,
                    quantity        : dataRequest.imrItemMaterialPrqQuantityRequest
                };
                
                listItemRequestDetail[l] = requestDetail;
            }
            
            let listItemRequestPartDetail = new Array();
            let ide = jQuery("#imrItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs');
            
            if(ide.length === 0){
                alert("Fill Part Item Material Requested Grid");
                return;
            }
            
            for(var m=0; m<ide.length; m++){
                var dataPartRequest = $("#imrItemMaterialRequestDetailInput_grid").jqGrid('getRowData', ide[m]);
                
                let partRequestDetail ={
                    itemMaterialRequestPurchaseRequestDetailCode            : dataPartRequest.imrItemMaterialRequestDetailItemMaterialCode,
                    itemMaterialRequestPurchaseRequestDocumentDetailCode    : dataPartRequest.imrItemMaterialRequestDetailDocumentDetailCode,
                    itemMaterialRequestPurchaseRequestFinishGoodsCode       : dataPartRequest.imrItemMaterialRequestDetailItemFinishGoodsCode,
                    itemMaterialRequestPurchaseRequestPartCode              : dataPartRequest.imrItemMaterialRequestDetailPartCode
                };
                
                listItemRequestPartDetail[m] = partRequestDetail;
            }
            
            var oligarki = validate();
            if(!oligarki){
                alert("Processed Data Grid Must be exist between Item Booked and Item Request");
                return;
            }
            
            formatDateIMR();
            let url = "ppic/item-material-request-save";
            var params = $("#frmItemMaterialRequestInput").serialize();
                params += "&listItemMaterialRequestItemProcessedPartDetailJSON=" + $.toJSON(listProcessedPartDetail);
                params += "&listItemMaterialRequestItemBookingDetailJSON=" + $.toJSON(listItemBookingDetail);
                params += "&listItemMaterialRequestItemBookingPartDetailJSON=" + $.toJSON(listItemBookingPartDetail);
                params += "&listItemMaterialRequestItemRequestDetailJSON=" + $.toJSON(listItemRequestDetail);
                params += "&listItemMaterialRequestItemRequestPartDetailJSON=" + $.toJSON(listItemRequestPartDetail);
            
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateIMR(); 
                    alertMessage(data.errorMessage);
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
                                var url = "ppic/item-material-request-input";
                                var param = "enumItemMaterialRequestActivity=NEW";
                                pageLoad(url, param, "#tabmnuITEM_MATERIAL_REQUEST");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "ppic/item-material-request";
                                var params = "";
                                pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST");
                            }
                        }]
                });
            }); 
            
        });
        
        $("#btnItemMaterialRequestCancel").click(function(ev){
           var url = "ppice/item-material-request";
           var params="";
           pageLoad(url,params,"#tabmnuITEM_MATERIAL_REQUEST");
        });
        
    }); //EOF Ready
    
   function validate(){
       let ids = $("#processedPart_grid").jqGrid('getDataIDs');
       let idk = $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getDataIDs');
       let idl = $("#imrItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs');
       
       let arrayObjectProcessedPart = new Array();
       var arrayObjectBookRequestPart = new Array();
       
       for (var i=0; i<ids.length; i++){
           var dataProcessed = $("#processedPart_grid").jqGrid('getRowData', ids[i]);
           arrayObjectProcessedPart[i] = dataProcessed.imrProcessedBillOfMaterialBOMDetailCode;
       }
       
       for(var k=0; k<idk.length; k++){
           var dataBooked = $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getRowData', idk[k]);     
           arrayObjectBookRequestPart[k] = dataBooked.imrItemMaterialRequestBookedBOMDetailCode;
       }
       
        for(var l=0; l<idl.length; l++){
          var dataRequest = $("#imrItemMaterialRequestDetailInput_grid").jqGrid('getRowData', idl[l]);
              if(arrayObjectBookRequestPart[l] === dataRequest.imrItemMaterialRequestDetailBomDetailCode){
                  continue;
              }else{
                  arrayObjectBookRequestPart[k++] = dataRequest.imrItemMaterialRequestDetailBomDetailCode;
              }
        } 
        
        for(var m = 0; m<ids.length; m++){
            var hasil = arrayObjectBookRequestPart.includes(arrayObjectProcessedPart[m]);
            if(!hasil){
                break;
            }
        }
        
        return hasil;
       
   }
    
    function itemMaterialRequestDocumentType(doctype){
        if (doctype === 'SO'){
             $('#imrProductionPlanningOrderDocumentTypeRadSO').prop('checked',true);
             $('#imrProductionPlanningOrderDocumentTypeRadBO').prop('disabled',true);
             $('#imrProductionPlanningOrderDocumentTypeRadIM').prop('disabled',true);
        }
        else if (doctype === 'BO'){
            $('#imrProductionPlanningOrderDocumentTypeRadBO').prop('checked',true);
            $('#imrProductionPlanningOrderDocumentTypeRadSO').prop('disabled',true);
            $('#imrProductionPlanningOrderDocumentTypeRadIM').prop('disabled',true);
        } 
        else{
            $('#imrProductionPlanningOrderDocumentTypeRadIM').prop('checked',true);
            $('#imrProductionPlanningOrderDocumentTypeRadSO').prop('disabled',true);
            $('#imrProductionPlanningOrderDocumentTypeRadBO').prop('disabled',true);
        }
    }
    
    function loadDataImrProductionPlanningOrderDocumentItemDetail(){
        var url = "ppic/production-planning-order-detail-data";
        var params = "productionPlanningOrder.code=" + $("#itemMaterialRequest\\.productionPlanningOrder\\.code").val();
            params += "&productionPlanningOrder.documentType=" + $('#itemMaterialRequest\\.productionPlanningOrder\\.documentType') .val();

        $.getJSON(url, params, function(data) {
            imrProductionPlanningOrderItemDetailLastRowId = 0;
            
            for (var i=0; i<data.listProductionPlanningOrderItemDetail.length; i++) {
                imrProductionPlanningOrderItemDetailLastRowId++;
                $("#imrProductionPlanningOrderDetailInput_grid").jqGrid("addRowData", imrProductionPlanningOrderItemDetailLastRowId, data.listProductionPlanningOrderItemDetail[i]);
                $("#imrProductionPlanningOrderDetailInput_grid").jqGrid('setRowData',imrProductionPlanningOrderItemDetailLastRowId,{
                    
                    imrProductionPlanningOrderDetailDocumentDetailCode             : data.listProductionPlanningOrderItemDetail[i].documentDetailCode,
                    imrProductionPlanningOrderDetailSortNo                         : data.listProductionPlanningOrderItemDetail[i].documentSortNo,
                    imrProductionPlanningOrderDetailItemFinishGoodsCode            : data.listProductionPlanningOrderItemDetail[i].itemFinishGoodsCode,
                    imrProductionPlanningOrderDetailBillOfMaterialCode             : data.listProductionPlanningOrderItemDetail[i].billOfMaterialCode,
                    imrProductionPlanningOrderDetailValveTag                       : data.listProductionPlanningOrderItemDetail[i].valveTag,
                    imrProductionPlanningOrderDetailDataSheet                      : data.listProductionPlanningOrderItemDetail[i].dataSheet,
                    imrProductionPlanningOrderDetailDescription                    : data.listProductionPlanningOrderItemDetail[i].description,
                    
                    imrProductionPlanningOrderDetailItemFinishGoodsBodyConstCode   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsBodyConstName   : data.listProductionPlanningOrderItemDetail[i].itemBodyConstructionName,
                    imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignName  : data.listProductionPlanningOrderItemDetail[i].itemTypeDesignName,
                    imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignName  : data.listProductionPlanningOrderItemDetail[i].itemSeatDesignName,
                    imrProductionPlanningOrderDetailItemFinishGoodsSizeCode        : data.listProductionPlanningOrderItemDetail[i].itemSizeCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsSizeName        : data.listProductionPlanningOrderItemDetail[i].itemSizeName,
                    imrProductionPlanningOrderDetailItemFinishGoodsRatingCode      : data.listProductionPlanningOrderItemDetail[i].itemRatingCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsRatingName      : data.listProductionPlanningOrderItemDetail[i].itemRatingName,
                    imrProductionPlanningOrderDetailItemFinishGoodsBoreCode        : data.listProductionPlanningOrderItemDetail[i].itemBoreCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsBoreName        : data.listProductionPlanningOrderItemDetail[i].itemBoreName,
                    
                    imrProductionPlanningOrderDetailItemFinishGoodsEndConCode      : data.listProductionPlanningOrderItemDetail[i].itemEndConCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsEndConName      : data.listProductionPlanningOrderItemDetail[i].itemEndConName,
                    imrProductionPlanningOrderDetailItemFinishGoodsBodyCode        : data.listProductionPlanningOrderItemDetail[i].itemBodyCode,   
                    imrProductionPlanningOrderDetailItemFinishGoodsBodyName        : data.listProductionPlanningOrderItemDetail[i].itemBodyName,   
                    imrProductionPlanningOrderDetailItemFinishGoodsBallCode        : data.listProductionPlanningOrderItemDetail[i].itemBallCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsBallName        : data.listProductionPlanningOrderItemDetail[i].itemBallName,
                    imrProductionPlanningOrderDetailItemFinishGoodsSeatCode        : data.listProductionPlanningOrderItemDetail[i].itemSeatCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsSeatName        : data.listProductionPlanningOrderItemDetail[i].itemSeatName,
                    imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertName  : data.listProductionPlanningOrderItemDetail[i].itemSeatInsertName,
                    imrProductionPlanningOrderDetailItemFinishGoodsStemCode        : data.listProductionPlanningOrderItemDetail[i].itemStemCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsStemName        : data.listProductionPlanningOrderItemDetail[i].itemStemName,
                    
                    imrProductionPlanningOrderDetailItemFinishGoodsSealCode        : data.listProductionPlanningOrderItemDetail[i].itemSealCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsSealName        : data.listProductionPlanningOrderItemDetail[i].itemSealName,
                    imrProductionPlanningOrderDetailItemFinishGoodsBoltCode        : data.listProductionPlanningOrderItemDetail[i].itemBoltCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsBoltName        : data.listProductionPlanningOrderItemDetail[i].itemBoltName,
                    imrProductionPlanningOrderDetailItemFinishGoodsDiscCode        : data.listProductionPlanningOrderItemDetail[i].itemDiscCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsDiscName        : data.listProductionPlanningOrderItemDetail[i].itemDiscName,
                    imrProductionPlanningOrderDetailItemFinishGoodsPlatesCode      : data.listProductionPlanningOrderItemDetail[i].itemPlatesCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsPlatesName      : data.listProductionPlanningOrderItemDetail[i].itemPlatesName,
                    imrProductionPlanningOrderDetailItemFinishGoodsShaftCode       : data.listProductionPlanningOrderItemDetail[i].itemShaftCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsShaftName       : data.listProductionPlanningOrderItemDetail[i].itemShaftName,
                    imrProductionPlanningOrderDetailItemFinishGoodsSpringCode      : data.listProductionPlanningOrderItemDetail[i].itemSpringCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsSpringName      : data.listProductionPlanningOrderItemDetail[i].itemSpringName,
                    
                    imrProductionPlanningOrderDetailItemFinishGoodsArmPinCode      : data.listProductionPlanningOrderItemDetail[i].itemArmPinCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsArmPinName      : data.listProductionPlanningOrderItemDetail[i].itemArmPinName,
                    imrProductionPlanningOrderDetailItemFinishGoodsBackSeatCode    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsBackSeatName    : data.listProductionPlanningOrderItemDetail[i].itemBackSeatName,
                    imrProductionPlanningOrderDetailItemFinishGoodsArmCode         : data.listProductionPlanningOrderItemDetail[i].itemArmCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsArmName         : data.listProductionPlanningOrderItemDetail[i].itemArmName,
                    imrProductionPlanningOrderDetailItemFinishGoodsHingePinCode    : data.listProductionPlanningOrderItemDetail[i].itemHingePinCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsHingePinName    : data.listProductionPlanningOrderItemDetail[i].itemHingePinName,
                    imrProductionPlanningOrderDetailItemFinishGoodsStopPinCode     : data.listProductionPlanningOrderItemDetail[i].itemStopPinCode,
                    imrProductionPlanningOrderDetailItemFinishGoodsStopPinName     : data.listProductionPlanningOrderItemDetail[i].itemStopPinName,
                    imrProductionPlanningOrderDetailItemFinishGoodsOperatorCode    : data.listProductionPlanningOrderItemDetail[i].itemOperatorCode, 
                    imrProductionPlanningOrderDetailItemFinishGoodsOperatorName    : data.listProductionPlanningOrderItemDetail[i].itemOperatorName, 
                    
                    imrProductionPlanningOrderDetailQuantity                       : data.listProductionPlanningOrderItemDetail[i].quantity
                });
            }
            bomDetail();
        });
    }
    
    function bomDetail(){
       var url = "engineering/bill-of-material-for-imr";
       var params = "docDetailCode=" + $("#itemMaterialRequest\\.productionPlanningOrder\\.code").val();
       
       $.getJSON(url,params,function(data){
           imrBillOfMaterialDetailLastRowId = 0;
           
           for (var i=0; i<data.listBillOfMaterialPartDetail.length; i++) {
                imrBillOfMaterialDetailLastRowId++;
                $("#imrBillOfMaterialDetailInput_grid").jqGrid("addRowData", imrBillOfMaterialDetailLastRowId, data.listBillOfMaterialPartDetail[i]);
                $("#imrBillOfMaterialDetailInput_grid").jqGrid('setRowData',imrBillOfMaterialDetailLastRowId,{
                    
                    imrBillOfMaterialDetailCode                           : data.listBillOfMaterialPartDetail[i].code,
                    imrBillOfMaterialDetailDocumentDetailCode             : data.listBillOfMaterialPartDetail[i].documentDetailCode,
                    imrBillOfMaterialDetailItemFinishGoodsCode            : data.listBillOfMaterialPartDetail[i].itemFinishGoodsCode,
                    imrBillOfMaterialDetailItemFinishGoodsRemark          : data.listBillOfMaterialPartDetail[i].itemFinishGoodsRemark,
                    imrBillOfMaterialDetailItemPpoNo                      : data.listBillOfMaterialPartDetail[i].itemPPONo,
                    imrBillOfMaterialDetailDocumentSortNo                 : data.listBillOfMaterialPartDetail[i].documentSortNo,
                    imrBillOfMaterialDetailPartNo                         : data.listBillOfMaterialPartDetail[i].partNo,
                    imrBillOfMaterialDetailPartCode                       : data.listBillOfMaterialPartDetail[i].partCode,
                    imrBillOfMaterialDetailPartName                       : data.listBillOfMaterialPartDetail[i].partName,
                    imrBillOfMaterialDetailDrawingCode                    : data.listBillOfMaterialPartDetail[i].drawingCode,
                    imrBillOfMaterialDetailDimension                      : data.listBillOfMaterialPartDetail[i].dimension,
                    imrBillOfMaterialDetailRequiredLength                 : data.listBillOfMaterialPartDetail[i].requiredLength,
                    imrBillOfMaterialDetailMaterial                       : data.listBillOfMaterialPartDetail[i].material,
                    imrBillOfMaterialDetailQuantity                       : data.listBillOfMaterialPartDetail[i].quantity,
                    imrBillOfMaterialDetailRequirement                    : data.listBillOfMaterialPartDetail[i].requirement,
                    imrBillOfMaterialDetailProcessedStatus                : data.listBillOfMaterialPartDetail[i].processedStatus,
                    imrBillOfMaterialDetailRemark                         : data.listBillOfMaterialPartDetail[i].remark,
                    imrBillOfMaterialDetailX                              : data.listBillOfMaterialPartDetail[i].x,
                    imrBillOfMaterialDetailRevNo                          : data.listBillOfMaterialPartDetail[i].revNo
                });
            }
       });
       
    }
    
    function itemMaterialRequestPartDetail_OnClick(){
        if($("#processedPart_grid").jqGrid('getDataIDs').length===0){
            alertMessage("Grid Processed Part Can't Be Empty!");
            return;
        }
        
        var selectedRowID = $("#imrItemMaterialRequestBookedInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#imrItemMaterialRequestBookedInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = imrMaterialBookedRowId;
        }
        
        if(imrMaterialBookedLastSel !== -1) {
            $('#imrItemMaterialRequestBookedInput_grid').jqGrid("saveRow",imrMaterialBookedLastSel);  
        }
        
        var imrBooked = $("#imrItemMaterialRequestBookedInput_grid").jqGrid('getRowData', selectedRowID);
        var itemMaterialCode = imrBooked.imrItemMaterialRequestBookedCode;
        var itemMaterialName = imrBooked.imrItemMaterialRequestBookedName;
        var onHandStock = imrBooked.imrItemMaterialRequestBookedOnHandStock;
        var booked = imrBooked.imrItemMaterialRequestBookedQuantity;
        var available = imrBooked.imrItemMaterialRequestBookedAvailable;
        var bookQuantity = imrBooked.imrItemMaterialRequestBookQuantity;
        var uomCode = imrBooked.imrItemMaterialRequestBookedUnitOfMeasureCode;

        window.open("./pages/search/search-imr-processed-part.jsp?iddoc=imrItemMaterialRequestBookedDetail&type=grid&itemMaterialCode="
        +itemMaterialCode+"&itemMaterialName="
        +itemMaterialName+"&onHandStock="
        +onHandStock+"&booked="
        +booked+"&available="
        +available+"&bookQuantity="
        +bookQuantity+"&uomCode="
        +uomCode+"&rowLast="+imrItemMaterialRequestBookedDetailRowId,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function imrItemMaterialRequestPartDetail_OnClick(){
        if($("#processedPart_grid").jqGrid('getDataIDs').length===0){
            alertMessage("Grid Processed Part Can't Be Empty!");
            return;

        }
        
        var selectedRowID = $("#imrItemMaterialRequestInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#imrItemMaterialRequestInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = imrItemMaterialRequestRowId;
        }
        
        if(imrItemMaterialRequestLastSel !== -1) {
            $('#imrItemMaterialRequestInput_grid').jqGrid("saveRow",imrItemMaterialRequestLastSel);  
        }
        
        var imrRequest = $("#imrItemMaterialRequestInput_grid").jqGrid('getRowData', selectedRowID);
        var itemMaterialCode = imrRequest.imrItemMaterialCodeRequest;
        var itemMaterialName = imrRequest.imrItemMaterialNameRequest;
        var onHandStock = imrRequest.imrItemMaterialOnHandStockRequest;
        var prQuantity = imrRequest.imrItemMaterialPrqQuantityRequest;
        var uomCode = imrRequest.imrItemMaterialUnitOfMeasureCodeRequest;

        window.open("./pages/search/search-imr-processed-part.jsp?iddoc=imrItemMaterialRequestDetail&type=grid&itemMaterialCode="+itemMaterialCode+
        "&itemMaterialName="+itemMaterialName+
        "&onHandStock="+onHandStock+
        "&uomCode="+uomCode+
        "&prQuantity="+prQuantity+
        "&rowLast="+imrItemMaterialRequestDetailRowId,"Search", "scrollbars=1,width=600, height=500");
    }
    
    function addRowDataMultiSelectedImrBooked(lastRowId,defRow){
        
        var ids = jQuery("#imrItemMaterialRequestBookedInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
        imrMaterialBookedRowId = lastRowId;
        
            $("#imrItemMaterialRequestBookedInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#imrItemMaterialRequestBookedInput_grid").jqGrid('setRowData',lastRowId,{
                imrItemMaterialRequestBookedDelete             : defRow.imrItemMaterialRequestBookedDelete,
                imrItemMaterialRequestBookedCode               : defRow.imrItemMaterialRequestBookedCode,
                imrItemMaterialRequestBookedName               : defRow.imrItemMaterialRequestBookedName,
                imrItemMaterialRequestBookedOnHandStock        : defRow.imrItemMaterialRequestBookedOnHandStock,
                imrItemMaterialRequestBookedQuantity           : defRow.imrItemMaterialRequestBookedQuantity,
                imrItemMaterialRequestBookedAvailable          : (defRow.imrItemMaterialRequestBookedOnHandStock - defRow.imrItemMaterialRequestBookedQuantity),
                imrItemMaterialRequestBookedUnitOfMeasureCode  : defRow.imrItemMaterialRequestBookedUnitOfMeasureCode,
                imrItemMaterialRequestBookedUnitOfMeasureName  : defRow.imrItemMaterialRequestBookedUnitOfMeasureName
                
            });
            
        setHeightGridHeader();
    }
    
    function addRowDataMultiSelectedRequestBooked(lastRowId, defRow){
        var ids = jQuery("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
        imrItemMaterialRequestBookedDetailRowId = lastRowId;
        
        $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('setRowData',lastRowId,{
            imrItemMaterialRequestBookedDetailDelete                      : defRow.imrItemMaterialRequestBookedDetailDelete,
            imrItemMaterialRequestBookedBOMDetailCode                     : defRow.imrItemMaterialRequestBookedBOMDetailCode,
            imrItemMaterialRequestBookedDetailItemMaterialCode            : defRow.imrItemMaterialRequestBookedDetailItemMaterialCode,
            imrItemMaterialRequestBookedDetailItemMaterialName            : defRow.imrItemMaterialRequestBookedDetailItemMaterialName,
            imrItemMaterialRequestBookedDetailDocumentDetailCode          : defRow.imrItemMaterialRequestBookedDetailDocumentDetailCode,
            imrItemMaterialRequestBookedDetailItemFinishGoodsCode         : defRow.imrItemMaterialRequestBookedDetailItemFinishGoodsCode,
            imrItemMaterialRequestBookedDetailItemFinishGoodsRemark       : defRow.imrItemMaterialRequestBookedDetailItemFinishGoodsRemark,
            imrItemMaterialRequestBookedDetailItemPpoNo                   : defRow.imrItemMaterialRequestBookedDetailItemPpoNo,
            imrItemMaterialRequestBookedDetailPartNo                      : defRow.imrItemMaterialRequestBookedDetailPartNo,
            imrItemMaterialRequestBookedDetailPartCode                    : defRow.imrItemMaterialRequestBookedDetailPartCode,
            imrItemMaterialRequestBookedDetailPartName                    : defRow.imrItemMaterialRequestBookedDetailPartName,
            imrItemMaterialRequestBookedDetailDrawingCode                 : defRow.imrItemMaterialRequestBookedDetailDrawingCode,
            imrItemMaterialRequestBookedDetailDimension                   : defRow.imrItemMaterialRequestBookedDetailDimension,
            imrItemMaterialRequestBookedDetailRequiredLength              : defRow.imrItemMaterialRequestBookedDetailRequiredLength,
            imrItemMaterialRequestBookedDetailMaterial                    : defRow.imrItemMaterialRequestBookedDetailMaterial,
            imrItemMaterialRequestBookedDetailQuantity                    : defRow.imrItemMaterialRequestBookedDetailQuantity,
            imrItemMaterialRequestBookedDetailRequirement                 : defRow.imrItemMaterialRequestBookedDetailRequirement,
            imrItemMaterialRequestBookedDetailProcessedStatus             : defRow.imrItemMaterialRequestBookedDetailProcessedStatus,
            imrItemMaterialRequestBookedDetailRemark                      : defRow.imrItemMaterialRequestBookedDetailRemark,
            imrItemMaterialRequestBookedDetailX                           : defRow.imrItemMaterialRequestBookedDetailX,
            imrItemMaterialRequestBookedDetailRevNo                       : defRow.imrItemMaterialRequestBookedDetailRevNo

        });
    }
    
    function addRowDataMultiSelectedRequest(lastRowId, defRow){
        var ids = jQuery("#imrItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
        imrItemMaterialRequestDetailRowId=lastRowId;
        
        $("#imrItemMaterialRequestDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
        $("#imrItemMaterialRequestDetailInput_grid").jqGrid('setRowData',lastRowId,{
            imrItemMaterialRequestDetailDelete                      : defRow.imrItemMaterialRequestDetailDelete,
            imrItemMaterialRequestDetailBomDetailCode               : defRow.imrItemMaterialRequestDetailBomDetailCode,
            imrItemMaterialRequestDetailDocumentDetailCode          : defRow.imrItemMaterialRequestDetailDocumentDetailCode,
            imrItemMaterialRequestDetailItemFinishGoodsCode         : defRow.imrItemMaterialRequestDetailItemFinishGoodsCode,
            imrItemMaterialRequestDetailItemFinishGoodsRemark       : defRow.imrItemMaterialRequestDetailItemFinishGoodsRemark,
            imrItemMaterialRequestDetailItemPpoNo                   : defRow.imrItemMaterialRequestDetailItemPpoNo,
            imrItemMaterialRequestDetailPartNo                      : defRow.imrItemMaterialRequestDetailPartNo,
            imrItemMaterialRequestDetailPartCode                    : defRow.imrItemMaterialRequestDetailPartCode,
            imrItemMaterialRequestDetailPartName                    : defRow.imrItemMaterialRequestDetailPartName,
            imrItemMaterialRequestDetailDrawingCode                 : defRow.imrItemMaterialRequestDetailDrawingCode,
            imrItemMaterialRequestDetailDimension                   : defRow.imrItemMaterialRequestDetailDimension,
            imrItemMaterialRequestDetailRequiredLength              : defRow.imrItemMaterialRequestDetailRequiredLength,
            imrItemMaterialRequestDetailMaterial                    : defRow.imrItemMaterialRequestDetailMaterial,
            imrItemMaterialRequestDetailQuantity                    : defRow.imrItemMaterialRequestDetailQuantity,
            imrItemMaterialRequestDetailRequirement                 : defRow.imrItemMaterialRequestDetailRequirement,
            imrItemMaterialRequestDetailProcessedStatus             : defRow.imrItemMaterialRequestDetailProcessedStatus,
            imrItemMaterialRequestDetailRemark                      : defRow.imrItemMaterialRequestDetailRemark,
            imrItemMaterialRequestDetailX                           : defRow.imrItemMaterialRequestDetailX,
            imrItemMaterialRequestDetailRevNo                       : defRow.imrItemMaterialRequestDetailRevNo

        });
    }
    
    function addRowDataMultiSelectedImrRequest(lastRowId,defRow){
        
        var ids = jQuery("#imrItemMaterialRequestInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        imrItemMaterialRequestRowId = lastRowId;
            $("#imrItemMaterialRequestInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#imrItemMaterialRequestInput_grid").jqGrid('setRowData',lastRowId,{
                imrItemMaterialDeleteRequest            : defRow.imrItemMaterialDeleteRequest,
                imrItemMaterialCodeRequest              : defRow.imrItemMaterialCodeRequest,
                imrItemMaterialNameRequest              : defRow.imrItemMaterialNameRequest,
                imrItemMaterialUnitOfMeasureCodeRequest : defRow.imrItemMaterialUnitOfMeasureCodeRequest,
                imrItemMaterialUnitOfMeasureNameRequest : defRow.imrItemMaterialUnitOfMeasureNameRequest,
                imrItemMaterialOnHandStockRequest       : defRow.imrItemMaterialOnHandStockRequest
                
            });
            
//        setHeightGridHeader();
    }
    
    function setHeightGridHeader(){
        var ids = jQuery("#imrItemMaterialRequestBookedInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#imrItemMaterialRequestBookedInput_grid"+" tr").eq(1).height();
            $("#imrItemMaterialRequestBookedInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#imrItemMaterialRequestBookedInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function imrBillOfMaterialDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#processedPart_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#processedPart_grid").jqGrid('delRowData',selectDetailRowId);        
    } 
    
    function imrItemMaterialRequestBookedDeleteGrid_Delete_OnClick(){
        var selectDetailRowId = $("#imrItemMaterialRequestBookedInput_grid").jqGrid('getGridParam','selrow');
        var imrBooking = $("#imrItemMaterialRequestBookedInput_grid").jqGrid("getRowData", selectDetailRowId);
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        var idi = jQuery("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getDataIDs'); 
        if(idi.length===0){
            $("#imrItemMaterialRequestBookedInput_grid").jqGrid('delRowData',selectDetailRowId);
        }
        for(var i=0;i < idi.length ;i++){
            var data = $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getRowData',idi[i]);
            if (data.imrItemMaterialRequestBookedDetailItemMaterialCode === imrBooking.imrItemMaterialRequestBookedCode){
                $("#imrItemMaterialRequestBookedInput_grid").jqGrid('delRowData',selectDetailRowId);
                $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('delRowData',idi[i]);
            }
        }      
    } 
    
    function imrItemMaterialRequestBookedDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#imrItemMaterialRequestBookedDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
    } 
    
    function imrItemMaterialDeleteRequestGrid_Delete_OnClick(){
        var selectDetailRowId = $("#imrItemMaterialRequestInput_grid").jqGrid('getGridParam','selrow');
        var imrRequest = $("#imrItemMaterialRequestInput_grid").jqGrid("getRowData", selectDetailRowId);
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        var idi = jQuery("#imrItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs'); 
        if(idi.length===0){
            $("#imrItemMaterialRequestInput_grid").jqGrid('delRowData',selectDetailRowId);
        }
        for(var i=0;i < idi.length ;i++){
            var data = $("#imrItemMaterialRequestDetailInput_grid").jqGrid('getRowData',idi[i]);
            if (data.imrItemMaterialRequestDetailItemMaterialCode === imrRequest.imrItemMaterialCodeRequest){
                $("#imrItemMaterialRequestInput_grid").jqGrid('delRowData',selectDetailRowId);
                $("#imrItemMaterialRequestDetailInput_grid").jqGrid('delRowData',idi[i]);
            }
        }     
    } 
    
    function imrItemMaterialRequestDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#imrItemMaterialRequestDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#imrItemMaterialRequestDetailInput_grid").jqGrid('delRowData',selectDetailRowId);        
    } 
    
    function handlers_input_production_planning_order(){
        if(txtItemMaterialRequestWarehouseCode.val()===""){
            handlersInput(txtItemMaterialRequestWarehouseCode);
        }else{
            unHandlersInput(txtItemMaterialRequestWarehouseCode);
        }
    }
    
    function avoidCharIMR(){
        
        var selectedRowID = $("#imrItemMaterialRequestBookedInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#imrItemMaterialRequestBookedInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = imrMaterialBookedRowId;
        }
        
        let str = $("#" + selectedRowID + "_imrItemMaterialRequestBookQuantity").val(); 
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_imrItemMaterialRequestBookQuantity").val("");
        }
    }
    
    function avoidCharIMRReq(){
        
        var selectedRowID = $("#imrItemMaterialRequestInput_grid").jqGrid("getGridParam", "selrow");
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#imrItemMaterialRequestInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = imrMaterialBookedRowId;
        }
        
        let str = $("#" + selectedRowID + "_imrItemMaterialPrqQuantityRequest").val(); 
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_imrItemMaterialPrqQuantityRequest").val("");
        }
    }
    
    function formatDateIMR(){
        var transactionDateSplit=dtpItemMaterialRequestTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpItemMaterialRequestTransactionDate.val(transactionDate);
    }
</script>
<s:url id="remotedetailurlItemMaterialRequestItemDetailInput" action="" />
<s:url id="remoteurlBillOfMaterialProcessedInput" action="" />
<s:url id="remoteurlimrItemMaterialRequestBookedInput" action="" />
<s:url id="remoteurlimrItemMaterialRequestBookedDetailInput" action="" />
<s:url id="remoteurlimrItemMaterialRequestInput" action="" />
<s:url id="remoteurlimrItemMaterialRequestDetailInput" action="" />

<b>ITEM MATERIAL REQUEST</b>
<hr>
<br class="spacer" />

<div id="productionPlanningOrderInput" class="content ui-widget">
    <s:form id="frmItemMaterialRequestInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerItemMaterialRequestInput">
            <tr>
                <td align="right" width="100px"><b>IMR No *</b></td>
                <td><s:textfield id="itemMaterialRequest.code" name="itemMaterialRequest.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequest.transactionDate" name="itemMaterialRequest.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>PPO NO </B></td>
                <td colspan="2">
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterialRequest.productionPlanningOrder.code" name="itemMaterialRequest.productionPlanningOrder.code" size="20" readonly = "true"></s:textfield>
                        <sj:a id="itemMaterialRequest_btnProductionPlanningOrder" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right" width="100px">Branch</td>
                <td><s:textfield id="itemMaterialRequest.branch.code" name="itemMaterialRequest.branch.code" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>PPO Date </B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequest.productionPlanningOrder.transactionDate" name="itemMaterialRequest.productionPlanningOrder.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Document Type </B></td>
                <td colspan="2">
                    <table>
                        <tr>
                            <td>
                                <s:radio id="imrProductionPlanningOrderDocumentTypeRad" name="imrProductionPlanningOrderDocumentTypeRad" label="Type" list="{'SO','BO','IM'}"></s:radio>
                                <s:textfield id="itemMaterialRequest.productionPlanningOrder.documentType" name="itemMaterialRequest.productionPlanningOrder.documentType" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="right"><B>SO/BO/IM </B></td>
                <td><s:textfield id="itemMaterialRequest.productionPlanningOrder.documentCode" name="itemMaterialRequest.productionPlanningOrder.documentCode" size="20" readonly="true"></s:textfield></td>
                </td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Target Date </B></td>
                <td>
                    <sj:datepicker id="itemMaterialRequest.productionPlanningOrder.targetDate" name="itemMaterialRequest.productionPlanningOrder.targetDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="20" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Customer *</B></td>
                <td colspan="2">
                    <s:textfield id="itemMaterialRequest.productionPlanningOrder.customer.code" name="itemMaterialRequest.productionPlanningOrder.customer.code" size="20" readonly="true"></s:textfield>
                    <s:textfield id="itemMaterialRequest.productionPlanningOrder.customer.name" name="itemMaterialRequest.productionPlanningOrder.customer.name" size="30" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Warehouse *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">   

                        txtItemMaterialRequestWarehouseCode.change(function(ev) {

                            if(txtItemMaterialRequestWarehouseCode.val()===""){
                                txtItemMaterialRequestWarehouseName.val("");
                                return;
                            }
                            var url = "master/warehouse-get";
                            var params = "warehouse.code=" + txtItemMaterialRequestWarehouseCode.val();
                                params += "&warehouse.activeStatus=true";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.warehouseTemp){
                                    txtItemMaterialRequestWarehouseCode.val(data.warehouseTemp.code);
                                    txtItemMaterialRequestWarehouseName.val(data.warehouseTemp.name);
                                }else{
                                    alertMessage("Warehouse Not Found!",txtItemMaterialRequestWarehouseCode);
                                    txtItemMaterialRequestWarehouseCode.val("");
                                    txtItemMaterialRequestWarehouseName.val("");
                                }    
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="itemMaterialRequest.warehouse.code" name="itemMaterialRequest.warehouse.code" size="20" title=" " required="true" cssClass="required" ></s:textfield>
                        <sj:a id="itemMaterialRequest_btnWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="itemMaterialRequest.warehouse.name" name="itemMaterialRequest.warehouse.name" size="30" readonly="true" ></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="itemMaterialRequest.refNo" name="itemMaterialRequest.refNo" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="itemMaterialRequest.remark" name="itemMaterialRequest.remark" cols="53" rows="3" ></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="itemMaterialRequest.createdBy" name="itemMaterialRequest.createdBy"></s:textfield>
                    <sj:datepicker id="itemMaterialRequestDateFirstSession" name="itemMaterialRequestDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="itemMaterialRequestDateLastSession" name="itemMaterialRequestDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumItemMaterialRequestActivity" name="enumItemMaterialRequestActivity"></s:textfield>
                </td>
            </tr>
        </table>
                
        <table>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnConfirmItemMaterialRequest" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmItemMaterialRequest" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
              
        <br class="spacer" />
        <br class="spacer" />
                
        <div id="id-item-material-request-detail">
            <div id="imrProductionPlanningOrderDetailInputGrid">
                <sjg:grid
                    id="imrProductionPlanningOrderDetailInput_grid"
                    caption="PPO DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="true"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listProductionPlanningOrderItemDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuImrProductionPlanningOrderDetail').width()"
                    onSelectRowTopics="ImrProductionPlanningOrderInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="imrProductionPlanningOrderDetail" index="imrProductionPlanningOrderDetail" key="imrProductionPlanningOrderDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailSortNo" index = "imrProductionPlanningOrderDetailSortNo" 
                        key = "imrProductionPlanningOrderDetailSortNo" title = "Sort No" width = "80"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailDocumentDetailCode" index = "imrProductionPlanningOrderDetailDocumentDetailCode" 
                        key = "imrProductionPlanningOrderDetailDocumentDetailCode" title = "Document Detail Code" width = "150"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailBillOfMaterialCode" index = "imrProductionPlanningOrderDetailBillOfMaterialCode" 
                        key = "imrProductionPlanningOrderDetailBillOfMaterialCode" title = "BOM Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsCode" title = "Item Finish Goods" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailValveTag" index = "imrProductionPlanningOrderDetailValveTag" 
                        key = "imrProductionPlanningOrderDetailValveTag" title = "Valve Tag" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailDataSheet" index = "imrProductionPlanningOrderDetailDataSheet" 
                        key = "imrProductionPlanningOrderDetailDataSheet" title = "Data Sheet" width = "120"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailDescription" index = "imrProductionPlanningOrderDetailDescription" 
                        key = "imrProductionPlanningOrderDetailDescription" title = "Description" width = "120"
                    />
<!------------------------------------>
                    <!--01 Body Cons-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBodyConstCode" title = "Body Cons Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBodyConstName" index = "imrProductionPlanningOrderDetailItemFinishGoodsBodyConstName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBodyConstName" title = "Body Construction" width = "120"
                    />
                    <!--02 Type Design-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignCode" title = "Type Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" index = "imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsTypeDesignName" title = "Type Design" width = "120"
                    />
                    <!--03 Seat Design-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignCode" title = "Seat Design Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" index = "imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSeatDesignName" title = "Seat Design" width = "120"
                    />
                    <!--04 Size-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSizeCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsSizeCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSizeCode" title = "Size Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSizeName" index = "imrProductionPlanningOrderDetailItemFinishGoodsSizeName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSizeName" title = "Size" width = "120"
                    />
                    <!--05 Rating-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsRatingCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsRatingCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsRatingCode" title = "Rating Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsRatingName" index = "imrProductionPlanningOrderDetailItemFinishGoodsRatingName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsRatingName" title = "Rating" width = "120"
                    />
                    <!--06 Bore-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBoreCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsBoreCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBoreCode" title = "Bore Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBoreName" index = "imrProductionPlanningOrderDetailItemFinishGoodsBoreName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBoreName" title = "Bore" width = "120"
                    />
                    
                    <!--07 End Con-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsEndConCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsEndConCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsEndConCode" title = "End Con Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsEndConName" index = "imrProductionPlanningOrderDetailItemFinishGoodsEndConName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsEndConName" title = "End Con" width = "120"
                    />
                    <!--08 Body-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBodyCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsBodyCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBodyCode" title = "Body Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBodyName" index = "imrProductionPlanningOrderDetailItemFinishGoodsBodyName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBodyName" title = "Body" width = "120"
                    />
                    <!--09 Ball-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBallCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsBallCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBallCode" title = "Ball Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBallName" index = "imrProductionPlanningOrderDetailItemFinishGoodsBallName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBallName" title = "Ball" width = "120"
                    />
                    <!--10 Seat-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSeatCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsSeatCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSeatCode" title = "Seat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSeatName" index = "imrProductionPlanningOrderDetailItemFinishGoodsSeatName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSeatName" title = "Seat" width = "120"
                    />
                    <!--11 Seat Insert-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertCode" title = "Seat Insert Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" index = "imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSeatInsertName" title = "Seat Insert" width = "120"
                    />
                    <!--12 Stem-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsStemCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsStemCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsStemCode" title = "Stem Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsStemName" index = "imrProductionPlanningOrderDetailItemFinishGoodsStemName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsStemName" title = "Stem" width = "120"
                    />
                    
                    <!--13 Seal-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSealCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsSealCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSealCode" title = "Seal Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSealName" index = "imrProductionPlanningOrderDetailItemFinishGoodsSealName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSealName" title = "Seal" width = "120"
                    />
                    <!--14 Bolt-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBoltCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsBoltCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBoltCode" title = "Bolt Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBoltName" index = "imrProductionPlanningOrderDetailItemFinishGoodsBoltName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBoltName" title = "Bolt" width = "120"
                    />
                    <!--15 Disc-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsDiscCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsDiscCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsDiscCode" title = "Disc Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsDiscName" index = "imrProductionPlanningOrderDetailItemFinishGoodsDiscName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsDiscName" title = "Disc" width = "120"
                    />
                    <!--16 Plates-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsPlatesCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsPlatesCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsPlatesCode" title = "Plates Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsPlatesName" index = "imrProductionPlanningOrderDetailItemFinishGoodsPlatesName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsPlatesName" title = "Plates" width = "120"
                    />
                    <!--17 Shaft-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsShaftCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsShaftCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsShaftCode" title = "Shaft Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsShaftName" index = "imrProductionPlanningOrderDetailItemFinishGoodsShaftName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsShaftName" title = "Shaft" width = "120"
                    />
                    <!--18 Spring-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSpringCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsSpringCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSpringCode" title = "Spring Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsSpringName" index = "imrProductionPlanningOrderDetailItemFinishGoodsSpringName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsSpringName" title = "Spring" width = "120"
                    />
                    
                    <!--19 Arm Pin-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsArmPinCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsArmPinCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsArmPinCode" title = "Arm Pin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsArmPinName" index = "imrProductionPlanningOrderDetailItemFinishGoodsArmPinName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsArmPinName" title = "Arm Pin" width = "120"
                    />
                    <!--20 BackSeat-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBackSeatCode" title = "BackSeat Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsBackSeatName" index = "imrProductionPlanningOrderDetailItemFinishGoodsBackSeatName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsBackSeatName" title = "BackSeat" width = "120"
                    />
                    <!--21 Arm-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsArmCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsArmCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsArmCode" title = "Arm Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsArmName" index = "imrProductionPlanningOrderDetailItemFinishGoodsArmName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsArmName" title = "Arm" width = "120"
                    />
                    <!--22 HingePin-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsHingePinCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsHingePinCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsHingePinCode" title = "HingePin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsHingePinName" index = "imrProductionPlanningOrderDetailItemFinishGoodsHingePinName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsHingePinName" title = "HingePin" width = "120"
                    />
                    <!--23 StopPin-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsStopPinCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsStopPinCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsStopPinCode" title = "StopPin Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsStopPinName" index = "imrProductionPlanningOrderDetailItemFinishGoodsStopPinName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsStopPinName" title = "StopPin" width = "120"
                    />
                    <!--24 Operator-->
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsOperatorCode" index = "imrProductionPlanningOrderDetailItemFinishGoodsOperatorCode" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsOperatorCode" title = "Operator Code" width = "120" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "imrProductionPlanningOrderDetailItemFinishGoodsOperatorName" index = "imrProductionPlanningOrderDetailItemFinishGoodsOperatorName" 
                        key = "imrProductionPlanningOrderDetailItemFinishGoodsOperatorName" title = "Operator" width = "120"
                    />
                    <sjg:gridColumn
                        name="imrProductionPlanningOrderDetailQuantity" index="imrProductionPlanningOrderDetailQuantity" key="imrProductionPlanningOrderDetailQuantity" title="PPO Quantity" 
                        width="150" align="right"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >  
            </div>
                <br class="spacer" />
                <div>
                    <sjg:grid
                        id="imrBillOfMaterialDetailInput_grid"
                        caption="Bill Of Material"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listBillOfMaterialPartDetail"
                        multiselect="true"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        editinline="true"
                        width="$('#tabmnuImrBillOfMaterialDetail').width()"
                        onSelectRowTopics="imrBillOfMaterialItemDetailInput_grid_onSelect"
                    >
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetail" index="imrBillOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailCode" index="imrBillOfMaterialDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailDocumentSortNo" index="imrBillOfMaterialDetailDocumentSortNo" key="imrBillOfMaterialDetailDocumentSortNo" title="Document Sort No" 
                            width="80" hidden="true"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailDocumentDetailCode" index="imrBillOfMaterialDetailDocumentDetailCode" key="imrBillOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailItemFinishGoodsCode" index="imrBillOfMaterialDetailItemFinishGoodsCode" key="imrBillOfMaterialDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailItemFinishGoodsRemark" index="imrBillOfMaterialDetailItemFinishGoodsRemark" key="imrBillOfMaterialDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="200" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailItemPpoNo" index="imrBillOfMaterialDetailItemPpoNo" key="imrBillOfMaterialDetailItemPpoNo" title="Item PPO No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailItemMaterialCode" index="imrBillOfMaterialDetailItemMaterialCode" key="imrBillOfMaterialDetailItemMaterialCode" title="IMR No" 
                            width="180"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailItemMaterialDate" index="imrBillOfMaterialDetailItemMaterialDate" key="imrBillOfMaterialDetailItemMaterialDate" title="IMR Date" 
                            width="180" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailPartNo" index="imrBillOfMaterialDetailPartNo" key="imrBillOfMaterialDetailPartNo" title="Part No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailPartCode" index="imrBillOfMaterialDetailPartCode" key="imrBillOfMaterialDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailPartName" index="imrBillOfMaterialDetailPartName" key="imrBillOfMaterialDetailPartName" title="Part Name" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailDrawingCode" index="imrBillOfMaterialDetailDrawingCode" key="imrBillOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailDimension" index="imrBillOfMaterialDetailDimension" key="imrBillOfMaterialDetailDimension" title="Dimension" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailRequiredLength" index="imrBillOfMaterialDetailRequiredLength" key="imrBillOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailMaterial" index="imrBillOfMaterialDetailMaterial" key="imrBillOfMaterialDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailQuantity" index="imrBillOfMaterialDetailQuantity" key="imrBillOfMaterialDetailQuantity" title="Quantity BOM" 
                            width="80" 
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailRequirement" index="imrBillOfMaterialDetailRequirement" key="imrBillOfMaterialDetailRequirement" title="Requirement" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name = "imrBillOfMaterialDetailProcessedStatus" index = "imrBillOfMaterialDetailProcessedStatus" key = "imrBillOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailRemark" index="imrBillOfMaterialDetailRemark" key="imrBillOfMaterialDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailX" index="imrBillOfMaterialDetailX" key="imrBillOfMaterialDetailX" title="X" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrBillOfMaterialDetailRevNo" index="imrBillOfMaterialDetailRevNo" key="imrBillOfMaterialDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >
                </div>
            </div>
                <table>
                    <tr>
                        <td></td>
                        <td>
                            <sj:a href="#" id="btnConfirmItemMaterialRequestProcess" button="true">Confirm</sj:a>
                            <sj:a href="#" id="btnUnConfirmItemMaterialRequestProcess" button="true">UnConfirm</sj:a>
                        </td>
                    </tr>
                </table>
                <br class="spacer" />
            <div id = "id-item-material-request-detail-process">
                <div>
                    <sjg:grid
                        id="processedPart_grid"
                        caption="Procssed Part"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listBillOfMaterialDetail"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false" 
                        editinline="true"
                        width="$('#tabmnuBillOfMaterialDetail').width()"
                        editurl="%{remoteurlBillOfMaterialProcessedInput}"
                        onSelectRowTopics="imrBillOfMaterialItemDetailInput_grid_onSelect"
                    >
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetail" index="imrProcessedBillOfMaterialDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailCode" index="imrProcessedBillOfMaterialDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialBOMDetailCode" index="imrProcessedBillOfMaterialBOMDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailDelete" index="imrProcessedBillOfMaterialDetailDelete" title="" width="50" align="centre"
                            editable="true"
                            edittype="button"
                            editoptions="{onClick:'imrBillOfMaterialDetailInputGrid_Delete_OnClick()', value:'delete'}"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailDocumentSortNo" index="imrProcessedBillOfMaterialDetailDocumentSortNo" key="imrProcessedBillOfMaterialDetailDocumentSortNo" title="Doc Sort No" 
                            width="80" hidden="true"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailDocumentDetailCode" index="imrProcessedBillOfMaterialDetailDocumentDetailCode" key="imrProcessedBillOfMaterialDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailItemFinishGoodsCode" index="imrProcessedBillOfMaterialDetailItemFinishGoodsCode" key="imrProcessedBillOfMaterialDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailItemFinishGoodsRemark" index="imrProcessedBillOfMaterialDetailItemFinishGoodsRemark" key="imrProcessedBillOfMaterialDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailItemPpoNo" index="imrProcessedBillOfMaterialDetailItemPpoNo" key="imrProcessedBillOfMaterialDetailItemPpoNo" title="Item PPO No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailPartNo" index="imrProcessedBillOfMaterialDetailPartNo" key="imrProcessedBillOfMaterialDetailPartNo" title="Part No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailPartCode" index="imrProcessedBillOfMaterialDetailPartCode" key="imrProcessedBillOfMaterialDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailPartName" index="imrProcessedBillOfMaterialDetailPartName" key="imrProcessedBillOfMaterialDetailPartName" title="Part Name" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailDrawingCode" index="imrProcessedBillOfMaterialDetailDrawingCode" key="imrProcessedBillOfMaterialDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailDimension" index="imrProcessedBillOfMaterialDetailDimension" key="imrProcessedBillOfMaterialDetailDimension" title="Dimension" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailRequiredLength" index="imrProcessedBillOfMaterialDetailRequiredLength" key="imrProcessedBillOfMaterialDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailMaterial" index="imrProcessedBillOfMaterialDetailMaterial" key="imrProcessedBillOfMaterialDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailQuantity" index="imrProcessedBillOfMaterialDetailQuantity" key="imrProcessedBillOfMaterialDetailQuantity" title="Quantity BOM" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailRequirement" index="imrProcessedBillOfMaterialDetailRequirement" key="imrProcessedBillOfMaterialDetailRequirement" title="Requirement" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name = "imrProcessedBillOfMaterialDetailProcessedStatus" index = "imrProcessedBillOfMaterialDetailProcessedStatus" key = "imrProcessedBillOfMaterialDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailRemark" index="imrProcessedBillOfMaterialDetailRemark" key="imrProcessedBillOfMaterialDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailX" index="imrProcessedBillOfMaterialDetailX" key="imrProcessedBillOfMaterialDetailX" title="X" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrProcessedBillOfMaterialDetailRevNo" index="imrProcessedBillOfMaterialDetailRevNo" key="imrProcessedBillOfMaterialDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >
                    <br class="spacer" />
                    <div>
                        <table>
                            <tr>
                                <td>
                                    <sj:a href="#" id="btnSearchItemBooked" button="true">Search Item</sj:a>
                                </td>
                            </tr>
                        </table>  
                        <table width="100%">
                            
                            <tr>
                                <td width="200px">
                                    <table>
                                        <tr>
                                            <td colspan="2">
                                                <sjg:grid
                                                    id="imrItemMaterialRequestBookedInput_grid"
                                                    caption="Item Material Booking"
                                                    dataType="json"                    
                                                    pager="true"
                                                    navigator="false"
                                                    navigatorView="false"
                                                    navigatorRefresh="false"
                                                    navigatorDelete="false"
                                                    navigatorAdd="false"
                                                    navigatorEdit="false"
                                                    gridModel="listItemMaterialRequestItemMaterialBooking"
                                                    viewrecords="true"
                                                    rownumbers="true"
                                                    shrinkToFit="false"
                                                    width="1000"
                                                    editinline = "true"
                                                    editurl="%{remoteurlimrItemMaterialRequestBookedInput}"
                                                    onSelectRowTopics="imrItemMaterialRequestBookedInput_grid_onSelect"
                                                >
                                                    <sjg:gridColumn
                                                        name="imrItemMaterialRequestBookedCodeDetail" index="imrItemMaterialRequestBookedCodeDetail" key="imrItemMaterialRequestBookedCodeDetail" 
                                                        title="" width="150" sortable="true" hidden="true" editable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrItemMaterialRequestBookedCodeImrBookCode" index="imrItemMaterialRequestBookedCodeImrBookCode" key="imrItemMaterialRequestBookedCodeImrBookCode" 
                                                        title="" width="150" sortable="true" hidden="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrItemMaterialRequestBookedDelete" index="imrItemMaterialRequestBookedDelete" title="" width="50" align="centre"
                                                        editable="true"
                                                        edittype="button"
                                                        editoptions="{onClick:'imrItemMaterialRequestBookedDeleteGrid_Delete_OnClick()', value:'delete'}"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrItemMaterialRequestBookedCode" index="imrItemMaterialRequestBookedCode" key="imrItemMaterialRequestBookedCode" 
                                                        title="Item Material Code" width="150" sortable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrItemMaterialRequestBookedName" index="imrItemMaterialRequestBookedName" key="imrItemMaterialRequestBookedName" 
                                                        title="Item Material Name" width="150" sortable="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookedRemark" index = "imrItemMaterialRequestBookedRemark" key = "imrItemMaterialRequestBookedRemark" 
                                                        title = "Remark" width = "80" editable="true" edittype="text" 
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookedOnHandStock" index = "imrItemMaterialRequestBookedOnHandStock" key = "imrItemMaterialRequestBookedOnHandStock" 
                                                        title = "On Hand Stock" width = "80" formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookedQuantity" index = "imrItemMaterialRequestBookedQuantity" key = "imrItemMaterialRequestBookedQuantity" 
                                                        title = "Booked Quantity" width = "80" formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookedAvailable" index = "imrItemMaterialRequestBookedAvailable" key = "imrItemMaterialRequestBookedAvailable" 
                                                        title = "Available" width = "80" formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookQuantity" index = "imrItemMaterialRequestBookQuantity" key = "imrItemMaterialRequestBookQuantity" 
                                                        title = "Book Quantity" width = "80" editable="true" edittype="text" formatter="number" editrules="{ double: true }"
                                                        formatoptions= "{ thousandsSeparator:','}"
                                                        editoptions="{onKeyUp:'avoidCharIMR()'}"
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookedUnitOfMeasureCode" index = "imrItemMaterialRequestBookedUnitOfMeasureCode" key = "imrItemMaterialRequestBookedUnitOfMeasureCode" 
                                                        title = "Unit" width = "80" 
                                                    />
                                                    <sjg:gridColumn
                                                        name = "imrItemMaterialRequestBookedUnitOfMeasureName" index = "imrItemMaterialRequestBookedUnitOfMeasureName" key = "imrItemMaterialRequestBookedUnitOfMeasureName" 
                                                        title = "Unit" width = "80" hidden="true"
                                                    />
                                                    <sjg:gridColumn
                                                        name="imrItemMaterialRequestBookedPartDetail" index="imrItemMaterialRequestBookedPartDetail" title="" width="80" align="centre"
                                                        editable="true"
                                                        edittype="button"
                                                        editoptions="{onClick:'itemMaterialRequestPartDetail_OnClick()', value:'Part Detail'}"
                                                    />
                                                </sjg:grid >
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div>
                    <sjg:grid
                        id="imrItemMaterialRequestBookedDetailInput_grid"
                        dataType="local"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listItemMaterialRequestProcessedPart"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false" 
                        editinline="true"
                        width="$('#tabmnuBillOfMaterialDetail').width()"
                        editurl="%{remoteurlimrItemMaterialRequestBookedDetailInput}"
                        onSelectRowTopics="imrItemMaterialRequestBookedDetailInput_grid_onSelect"
                    >
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetail" index="imrItemMaterialRequestBookedDetail" 
                            title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailCode" index="imrItemMaterialRequestBookedDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedBOMDetailCode" index="imrItemMaterialRequestBookedBOMDetailCode" 
                            title=" " width="50" sortable="true" hidden="true"
                        />  
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailDelete" index="imrItemMaterialRequestBookedDetailDelete" title="" width="50" align="centre"
                            editable="true"
                            edittype="button"
                            editoptions="{onClick:'imrItemMaterialRequestBookedDetailInputGrid_Delete_OnClick()', value:'delete'}"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailItemMaterialCode" index="imrItemMaterialRequestBookedDetailItemMaterialCode" key="imrItemMaterialRequestBookedDetailItemMaterialCode" title="Item Material Code" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailItemMaterialName" index="imrItemMaterialRequestBookedDetailItemMaterialName" key="imrItemMaterialRequestBookedDetailItemMaterialName" title="Item Material Name" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailDocumentDetailCode" index="imrItemMaterialRequestBookedDetailDocumentDetailCode" key="imrItemMaterialRequestBookedDetailDocumentDetailCode" title="Document Detail" 
                            width="150" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailItemFinishGoodsCode" index="imrItemMaterialRequestBookedDetailItemFinishGoodsCode" key="imrItemMaterialRequestBookedDetailItemFinishGoodsCode" title="IFG Code" 
                            width="180" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailItemFinishGoodsRemark" index="imrItemMaterialRequestBookedDetailItemFinishGoodsRemark" key="imrItemMaterialRequestBookedDetailItemFinishGoodsRemark" title="IFG Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailItemPpoNo" index="imrItemMaterialRequestBookedDetailItemPpoNo" key="imrItemMaterialRequestBookedDetailItemPpoNo" title="Item PPO No" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailPartNo" index="imrItemMaterialRequestBookedDetailPartNo" key="imrItemMaterialRequestBookedDetailPartNo" title="Part No" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailPartCode" index="imrItemMaterialRequestBookedDetailPartCode" key="imrItemMaterialRequestBookedDetailPartCode" title="Part Code" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailPartName" index="imrItemMaterialRequestBookedDetailPartName" key="imrItemMaterialRequestBookedDetailPartName" title="Part Name" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailDrawingCode" index="imrItemMaterialRequestBookedDetailDrawingCode" key="imrItemMaterialRequestBookedDetailDrawingCode" title="Drawing Code" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailDimension" index="imrItemMaterialRequestBookedDetailDimension" key="imrItemMaterialRequestBookedDetailDimension" title="Dimension" 
                            width="80"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailRequiredLength" index="imrItemMaterialRequestBookedDetailRequiredLength" key="imrItemMaterialRequestBookedDetailRequiredLength" title="Required Length" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailMaterial" index="imrItemMaterialRequestBookedDetailMaterial" key="imrItemMaterialRequestBookedDetailMaterial" title="Material" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailQuantity" index="imrItemMaterialRequestBookedDetailQuantity" key="imrItemMaterialRequestBookedDetailQuantity" title="Quantity BOM" 
                            width="80" align="right" editable="false"
                            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailRequirement" index="imrItemMaterialRequestBookedDetailRequirement" key="imrItemMaterialRequestBookedDetailRequirement" title="Requirement" 
                            width="80" align="right" sortable="true"
                        />
                        <sjg:gridColumn
                            name = "imrItemMaterialRequestBookedDetailProcessedStatus" index = "imrItemMaterialRequestBookedDetailProcessedStatus" key = "imrItemMaterialRequestBookedDetailProcessedStatus" title = "Processed Status" width = "100" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailRemark" index="imrItemMaterialRequestBookedDetailRemark" key="imrItemMaterialRequestBookedDetailRemark" title="Remark" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailX" index="imrItemMaterialRequestBookedDetailX" key="imrItemMaterialRequestBookedDetailX" title="X" 
                            width="80" 
                        />
                        <sjg:gridColumn
                            name="imrItemMaterialRequestBookedDetailRevNo" index="imrItemMaterialRequestBookedDetailRevNo" key="imrItemMaterialRequestBookedDetailRevNo" title="Rev No" 
                            width="80" 
                        />
                    </sjg:grid >    
                </div>
                <br class="spacer" />
                <div>
                    <table>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnSearchItemRequest" button="true">Search Item</sj:a>
                            </td>
                        </tr>
                    </table>
                    <table>  
                        <tr>
                            <td width="200px" valign="top">
                                <sjg:grid
                                    id="imrItemMaterialRequestInput_grid"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listItemMaterialRequestProcessedPart2"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="800"
                                    editinline="true"
                                    editurl="%{remoteurlimrItemMaterialRequestInput}"
                                    onSelectRowTopics="imrItemMaterialRequestInput_grid_onSelect"
                                >
                                    <sjg:gridColumn
                                        name="imrItemMaterialCodeRequestDetail" index="imrItemMaterialCodeRequestDetail" key="imrItemMaterialCodeRequestDetail" 
                                        title="" width="150" sortable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrItemMaterialCodeRequestCode" index="imrItemMaterialCodeRequestCode" key="imrItemMaterialCodeRequestCode" 
                                        title="" width="150" sortable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrItemMaterialDeleteRequest" index="imrItemMaterialDeleteRequest" title="" width="50" align="centre"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'imrItemMaterialDeleteRequestGrid_Delete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="imrItemMaterialCodeRequest" index="imrItemMaterialCodeRequest" key="imrItemMaterialCodeRequest" 
                                        title="Item Material Code" width="150" sortable="true"
                                    />
                                    <sjg:gridColumn
                                        name="imrItemMaterialNameRequest" index="imrItemMaterialNameRequest" key="imrItemMaterialNameRequest" 
                                        title="Item Material Name" width="150" sortable="true" 
                                    />
                                    <sjg:gridColumn
                                        name = "imrItemMaterialRemarkRequest" index = "imrItemMaterialRemarkRequest" key = "imrItemMaterialRemarkRequest" 
                                        title = "Remark" width = "80" edittype="text" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name = "imrItemMaterialPrqQuantityRequest" index = "imrItemMaterialPrqQuantityRequest" key = "imrItemMaterialPrqQuantityRequest" 
                                        title = "PRQ Quantity" width = "80" editable="true"
                                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                        editoptions="{onKeyUp:'avoidCharIMRReq()'}"
                                    />
                                    <sjg:gridColumn
                                        name = "imrItemMaterialUnitOfMeasureCodeRequest" index = "imrItemMaterialUnitOfMeasureCodeRequest" key = "imrItemMaterialUnitOfMeasureCodeRequest" 
                                        title = "Unit" width = "80" 
                                    />
                                    <sjg:gridColumn
                                        name = "imrItemMaterialUnitOfMeasureNameRequest" index = "imrItemMaterialUnitOfMeasureNameRequest" key = "imrItemMaterialUnitOfMeasureNameRequest" 
                                        title = "Unit" width = "80" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name = "imrItemMaterialOnHandStockRequest" index = "imrItemMaterialOnHandStockRequest" key = "imrItemMaterialOnHandStockRequest" 
                                        title = "On Hand Stock" width = "80" formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                        hidden = "true"
                                    />
                                    <sjg:gridColumn
                                        name="imrItemMaterialRequestPartDetail" index="imrItemMaterialRequestPartDetail" title="" width="80" align="centre"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'imrItemMaterialRequestPartDetail_OnClick()', value:'Part Detail'}"
                                    />
                                </sjg:grid >
                            </td>       
                       </tr>
                    </table>
                </div>
                        <div>
                            <sjg:grid
                                id="imrItemMaterialRequestDetailInput_grid"
                                dataType="local"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listItemMaterialRequestProcessedPart"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false" 
                                editinline="true"
                                width="$('#tabmnuBillOfMaterialDetail').width()"
                                editurl="%{remoteurlimrItemMaterialRequestDetailInput}"
                                onSelectRowTopics="imrItemMaterialRequestDetailInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetail" index="imrItemMaterialRequestDetail" 
                                    title=" " width="50" sortable="true" editable="true" edittype="text" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailCode" index="imrItemMaterialRequestDetailCode" 
                                    title=" " width="50" sortable="true" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailBomDetailCode" index="imrItemMaterialRequestDetailBomDetailCode" 
                                    title=" " width="50" sortable="true" hidden="true"
                                />  
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailDelete" index="imrItemMaterialRequestDetailDelete" title="" width="50" align="centre"
                                    editable="true"
                                    edittype="button"
                                    editoptions="{onClick:'imrItemMaterialRequestDetailInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailItemMaterialCode" index="imrItemMaterialRequestDetailItemMaterialCode" key="imrItemMaterialRequestDetailItemMaterialCode" title="Item Material Code" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailItemMaterialName" index="imrItemMaterialRequestDetailItemMaterialName" key="imrItemMaterialRequestDetailItemMaterialName" title="Item Material Name" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailDocumentDetailCode" index="imrItemMaterialRequestDetailDocumentDetailCode" key="imrItemMaterialRequestDetailDocumentDetailCode" title="Document Detail" 
                                    width="150" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailItemFinishGoodsCode" index="imrItemMaterialRequestDetailItemFinishGoodsCode" key="imrItemMaterialRequestDetailItemFinishGoodsCode" title="IFG Code" 
                                    width="180" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailItemFinishGoodsRemark" index="imrItemMaterialRequestDetailItemFinishGoodsRemark" key="imrItemMaterialRequestDetailItemFinishGoodsRemark" title="IFG Remark" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailItemPpoNo" index="imrItemMaterialRequestDetailItemPpoNo" key="imrItemMaterialRequestDetailItemPpoNo" title="Item PPO No" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailPartNo" index="imrItemMaterialRequestDetailPartNo" key="imrItemMaterialRequestDetailPartNo" title="Part No" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailPartCode" index="imrItemMaterialRequestDetailPartCode" key="imrItemMaterialRequestDetailPartCode" title="Part Code" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailPartName" index="imrItemMaterialRequestDetailPartName" key="imrItemMaterialRequestDetailPartName" title="Part Name" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailDrawingCode" index="imrItemMaterialRequestDetailDrawingCode" key="imrItemMaterialRequestDetailDrawingCode" title="Drawing Code" 
                                    width="80" align="right" sortable="true"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailDimension" index="imrItemMaterialRequestDetailDimension" key="imrItemMaterialRequestDetailDimension" title="Dimension" 
                                    width="80"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailRequiredLength" index="imrItemMaterialRequestDetailRequiredLength" key="imrItemMaterialRequestDetailRequiredLength" title="Required Length" 
                                    width="80" align="right" editable="false"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailMaterial" index="imrItemMaterialRequestDetailMaterial" key="imrItemMaterialRequestDetailMaterial" title="Material" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailQuantity" index="imrItemMaterialRequestDetailQuantity" key="imrItemMaterialRequestDetailQuantity" title="Quantity BOM" 
                                    width="80" align="right" editable="false"
                                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailRequirement" index="imrItemMaterialRequestDetailRequirement" key="imrItemMaterialRequestDetailRequirement" title="Requirement" 
                                    width="80" align="right" sortable="true"
                                />
                                <sjg:gridColumn
                                    name = "imrItemMaterialRequestDetailProcessedStatus" index = "imrItemMaterialRequestDetailProcessedStatus" key = "imrItemMaterialRequestDetailProcessedStatus" title = "Processed Status" width = "100" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailRemark" index="imrItemMaterialRequestDetailRemark" key="imrItemMaterialRequestDetailRemark" title="Remark" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailX" index="imrItemMaterialRequestDetailX" key="imrItemMaterialRequestDetailX" title="X" 
                                    width="80" 
                                />
                                <sjg:gridColumn
                                    name="imrItemMaterialRequestDetailRevNo" index="imrItemMaterialRequestDetailRevNo" key="imrItemMaterialRequestDetailRevNo" title="Rev No" 
                                    width="80" 
                                />
                            </sjg:grid>    
                        </div>
                    </div>
                </div>
            </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnItemMaterialRequestSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnItemMaterialRequestCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>      
                
    </s:form>
</div>
    

