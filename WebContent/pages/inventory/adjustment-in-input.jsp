
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #adjustmentInItemDetailInput_grid_pager_center,#adjustmentInSerialNoDetailInput_grid_pager_center{
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
    
    var adjustmentInItemDetail_lastSel = -1, adjustmentInItemDetail_lastRowId=0;
    var adjustmentInSerialNoDetail_lastSel = -1, adjustmentInSerialNoDetail_lastRowId=0;
    
    var txtAdjustmentInCode = $("#adjustmentIn\\.code"),
        txtAdjustmentInBranchCode = $("#adjustmentIn\\.branch\\.code"),
        txtAdjustmentInBranchName = $("#adjustmentIn\\.branch\\.name"),
        dtpAdjustmentInTransactionDate = $("#adjustmentIn\\.transactionDate"),
        txtAdjustmentInCurrencyCode = $("#adjustmentIn\\.currency\\.code"),
        txtAdjustmentInCurrencyName = $("#adjustmentIn\\.currency\\.name"),
        txtAdjustmentInExchangeRate = $("#adjustmentIn\\.exchangeRate"),
        txtAdjustmentInWarehouseCode = $("#adjustmentIn\\.warehouse\\.code"),
        txtAdjustmentInWarehouseName = $("#adjustmentIn\\.warehouse\\.name"),
        txtAdjustmentInWarehouseRackCode = $('#adjustmentIn\\.warehouse\\.dockInCode'),
        txtAdjustmentInWarehouseRackName = $('#adjustmentIn\\.warehouse\\.dockInName'),
        txtAdjustmentInApprovalStatus = $("#adjustmentIn\\.approvalStatus"),
        txtAdjustmentInApprovalBy = $("#adjustmentIn\\.approvalBy"),
        dtpAdjustmentInApprovalDate = $("#adjustmentIn\\.approvalDate"),
        txtAdjustmentInPICEmployeeCode = $("#adjustmentIn\\.picEmployee\\.code"),
        txtAdjustmentInPICEmployeeName = $("#adjustmentIn\\.picEmployee\\.name"),
        txtAdjustmentInRefNo = $("#adjustmentIn\\.refNo"),
        txtAdjustmentInRemark = $("#adjustmentIn\\.remark"),
        txtAdjustmentInCreatedBy = $("#adjustmentIn\\.createdBy"),
        dtpAdjustmentInCreatedDate = $("#adjustmentIn\\.createdDate"),
        txtAdjustmentInGrandTotalAmount = $("#adjustmentIn\\.grandTotalAmount"),
        txtAdjustmentInGrandTotalAmountIDR = $("#adjustmentInGrandTotalAmountIDR");
        
        txtAdjustmentInSerialNoDetailRemarkText= $("#adjustmentInSerialNoDetailRemark"),
        txtAdjustmentInSerialNoDetailRemarkQuantity= $("#adjustmentInSerialNoDetailRemarkkQuantity"),
        txtAdjustmentInSerialNoDetailLocationCode= $("#adjustmentInSerialNoDetail\\.location\\.code"),
        txtAdjustmentInSerialNoDetailLocationName= $("#adjustmentInSerialNoDetail\\.location\\.name"),
         
    $(document).ready(function(){
       
        flagConfirmAdjustmentIn=false;
        flagConfirmAdjustmentInDetail=false;
        
        $("#adjustmentInAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $.subscribe("adjustmentInItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==adjustmentInItemDetail_lastSel) {
                $("#adjustmentInItemDetailInput_grid").jqGrid('saveRow',adjustmentInItemDetail_lastSel); 
                $("#adjustmentInItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                adjustmentInItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#adjustmentInItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        $.subscribe("adjustmentInSerialNoDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInSerialNoDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==adjustmentInSerialNoDetail_lastSel) {
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('saveRow',adjustmentInSerialNoDetail_lastSel); 
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                adjustmentInSerialNoDetail_lastSel=selectedRowID;
            }
            else{
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
        
        
        $("#btnConfirmAdjustmentIn").css("display", "block");
        $("#btnUnConfirmAdjustmentIn").css("display", "none");
        $("#btnConfirmAdjustmentInDetail").css("display", "none");
        $("#btnUnConfirmAdjustmentInDetail").css("display", "none");
        $("#adjustmentInItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        $("#adjustmentInSerialNoDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmAdjustmentIn").click(function(ev) {
            handlers_input_adjustment_in();
            if(!$("#frmAdjustmentInInput").valid()) {
                alertMessage("Field(s) Can't empty!");
                ev.preventDefault();
                return;
            }
            
            var date1 = dtpAdjustmentInTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val())){
                alertMessage("Transaction Month Must Between Session Period Month!",dtpAdjustmentInTransactionDate);
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val())){
                alertMessage("Transaction Year Must Between Session Period Year!",dtpAdjustmentInTransactionDate);
                return;
            }
            
            flagConfirmAdjustmentIn=true;
            flagConfirmAdjustmentInDetail=false;
            
            if($("#adjustmentInUpdateMode").val()==="true"){
                autoLoadDataAdjustmentInItemDetail();
            }
            
            $("#btnUnConfirmAdjustmentIn").css("display", "block");
            $("#btnConfirmAdjustmentIn").css("display", "none");
            $("#btnConfirmAdjustmentInDetail").css("display", "block");
            $("#btnUnConfirmAdjustmentInDetail").css("display", "none");    
            $("#div-header-adj-in").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#adjustmentInItemDetailInputGrid").unblock();
            $("#adjustmentInSerialNoDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        });
        
        $("#btnConfirmAdjustmentInDetail").click(function(ev) {
            
            var ids = jQuery("#adjustmentInItemDetailInput_grid").jqGrid('getDataIDs'); 
            if(ids.length===0){
                return;
            }
            
            if(adjustmentInItemDetail_lastSel !== -1) {
                $("#adjustmentInItemDetailInput_grid").jqGrid('saveRow',adjustmentInItemDetail_lastSel); 
            }
            
            var ids = jQuery("#adjustmentInItemDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#adjustmentInItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                
                if(data.adjustmentInItemDetailReasonCode===""){
                    alertMessage("Reason Code is Empty!");
                    return;
                }
                
                if(parseFloat(data.adjustmentInItemDetailQuantity)<=0){
                    alertMessage("Quantity Item Detail is "+data.adjustmentInItemDetailQuantity+ "!");
                    return;
                }
                
                if(data.adjustmentInItemDetailItemMaterialSerialNoStatus==="YES"){

                    var angkaBulat;
                    angkaBulat=parseFloat(data.adjustmentInItemDetailQuantity) % 1;
                    if(angkaBulat!==0){
                        alertMessage("Invalid Number of Quantity for Item "+ data.adjustmentInItemDetailItemMaterialCode+"<br>Can't be Fractional!");
                        $("#adjustmentInSerialNoDetailInput_grid").jqGrid('clearGridData');
                        return;
                    }

                    var rowCount=parseFloat(data.adjustmentInItemDetailQuantity);

                    for(var a=0; a<rowCount; a++){
                        var concatSerialDetailCodeTemp=data.adjustmentInItemDetailItemMaterialCode+data.adjustmentInItemDetailReasonCode+data.adjustmentInItemDetailRemark+data.adjustmentInItemDetailQuantity;
                        var defRow = {
                            adjustmentInSerialNoDetailCode                          :concatSerialDetailCodeTemp,
                            adjustmentInSerialNoDetailItemMaterialCode              :data.adjustmentInItemDetailItemMaterialCode,
                            adjustmentInSerialNoDetailItemMaterialName              :data.adjustmentInItemDetailItemMaterialName,
                            adjustmentInSerialNoDetailItemUnitOfMeasureCode         :data.adjustmentInItemDetailItemMaterialUnitOfMeasureCode,
                            adjustmentInSerialNoDetailRackCode                      :data.adjustmentInItemDetailRackCode,
                            adjustmentInSerialNoDetailRackName                      :data.adjustmentInItemDetailRackName
                        };             
                        adjustmentInSerialNoDetail_lastRowId++;
                        $("#adjustmentInSerialNoDetailInput_grid").jqGrid("addRowData", adjustmentInSerialNoDetail_lastRowId, defRow); 
                    }
                }
            }
                        
            flagConfirmAdjustmentInDetail=true;
            $("#btnConfirmAdjustmentInDetail").css("display", "none");
            $("#btnUnConfirmAdjustmentInDetail").css("display", "block");
            $("#adjustmentInItemDetailInputGrid").block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $("#adjustmentInSerialNoDetailInputGrid").unblock();
        });
        
        
        $("#btnUnConfirmAdjustmentIn").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm This Item Detail?</div>');
            var rows = jQuery("#adjustmentInSerialNoDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                flagConfirmAdjustmentIn=false;
                flagConfirmAdjustmentInDetail=false;
                $("#adjustmentInItemDetailInput_grid").jqGrid('clearGridData');
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('clearGridData');
                $("#btnUnConfirmAdjustmentIn").css("display", "none");
                $("#btnConfirmAdjustmentIn").css("display", "block");
                $("#btnConfirmAdjustmentInDetail").css("display", "none");
                $("#btnUnConfirmAdjustmentInDetail").css("display", "none");
                $("#div-header-adj-in").unblock();
                $('#adjustmentInItemDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#adjustmentInSerialNoDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                                flagConfirmAdjustmentIn=false;
                                flagConfirmAdjustmentInDetail=false;
                                $("#adjustmentInItemDetailInput_grid").jqGrid('clearGridData');
                                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmAdjustmentIn").css("display", "none");
                                $("#btnConfirmAdjustmentIn").css("display", "block");
                                $("#btnUnConfirmAdjustmentInDetail").css("display", "none");
                                $("#btnConfirmAdjustmentInDetail").css("display", "none");
                                $("#div-header-adj-in").unblock();
                                $('#adjustmentInItemDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $('#adjustmentInSerialNoDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $("#btnUnConfirmAdjustmentInDetail").click(function(ev) {
            
            var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm This Item Detail?</div>');
            
            var rows = jQuery("#adjustmentInSerialNoDetailInput_grid").jqGrid('getGridParam', 'records');
            if (rows < 1) {
                flagConfirmAdjustmentInDetail=false;
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('clearGridData');
                $("#btnUnConfirmAdjustmentInDetail").css("display", "none");
                $("#btnConfirmAdjustmentInDetail").css("display", "block");
                $('#adjustmentInItemDetailInputGrid').unblock();
                $('#adjustmentInSerialNoDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            }else{
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
                                flagConfirmAdjustmentInDetail=false;
                                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmAdjustmentInDetail").css("display", "none");
                                $("#btnConfirmAdjustmentInDetail").css("display", "block");
                                    
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                            }
                        }]
                });
            }
            
        });
        
        $("#btnAdjustmentInSave").click(function(ev) {
            
            if(!flagConfirmAdjustmentInDetail){
                return;
            }
                        
            if(adjustmentInSerialNoDetail_lastSel !== -1) {
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('saveRow',adjustmentInSerialNoDetail_lastSel); 
            }

            var listAdjustmentInItemDetail = new Array();            
            var listAdjustmentInSerialNoDetail = new Array();            
            
            var ids = jQuery("#adjustmentInItemDetailInput_grid").jqGrid('getDataIDs'); 
            var idx = jQuery("#adjustmentInSerialNoDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#adjustmentInItemDetailInput_grid").jqGrid('getRowData',ids[i]); 

                var adjustmentInItemDetail = { 
                    itemMaterial    : { code : data.adjustmentInItemDetailItemMaterialCode},
                    reason          : { code : data.adjustmentInItemDetailReasonCode},
                    quantity        : data.adjustmentInItemDetailQuantity,
                    remark          : data.adjustmentInItemDetailRemark,
                    rack            : { code : data.adjustmentInItemDetailRackCode}
                   
                };
                
                listAdjustmentInItemDetail[i] = adjustmentInItemDetail;
            }
            
//            var dataCheckedSerialNo=new Array();
            var idx = jQuery("#adjustmentInSerialNoDetailInput_grid").jqGrid('getDataIDs'); 

            for(var i=0;i < idx.length;i++){
                var data = $("#adjustmentInSerialNoDetailInput_grid").jqGrid('getRowData',idx[i]); 
                
//                dataCheckedSerialNo.push(data.adjustmentInSerialNoDetailSerialNo);
                
                var adjustmentInSerialNoDetail = {
                    code                : data.adjustmentInSerialNoDetailCode,
                    itemMaterial        : { code : data.adjustmentInSerialNoDetailItemMaterialCode},
                    capacity            : data.adjustmentInSerialNoDetailCapacity,
                    remark              : data.adjustmentInSerialNoDetailRemark,
                    rack                : { code : data.adjustmentInSerialNoDetailRackCode}
                };
                listAdjustmentInSerialNoDetail[i] = adjustmentInSerialNoDetail;
            }
            
//            var uniq = dataCheckedSerialNo
//            .map((name) => {
//              return {count: 1, name: name}
//            })
//            .reduce((a, b) => {
//              a[b.name] = (a[b.name] || 0) + b.count
//              return a
//            }, {})
//
//            var duplicates = Object.keys(uniq).filter((a) => uniq[a] > 1)
//            if(duplicates.length > 0){
//                alertMessage("Duplicate Serial No: </br>" +duplicates);
//                return;
//            }
            
            formatDateADJIN();
            var url = "adjustment/adjustment-in-save";
            
            var params = $("#frmAdjustmentInInput").serialize();
                params+= "&listAdjustmentInItemDetailJSON=" + $.toJSON(listAdjustmentInItemDetail);
                params+= "&listAdjustmentInSerialNoDetailJSON=" + $.toJSON(listAdjustmentInSerialNoDetail);
            
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateADJIN();
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
                                var url = "adjustment/adjustment-in-input";
                                pageLoad(url, params, "#tabmnuADJUSTMENT_IN");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "adjustment/adjustment-in";
                                pageLoad(url, params, "#tabmnuADJUSTMENT_IN");
                            }
                        }]
                });
            });
        });
        
        $("#btnAdjustmentInCancel").click(function(ev){
            var params = "";
            var url = "adjustment/adjustment-in";
            pageLoad(url, params, "#tabmnuADJUSTMENT_IN");
        });

        $('#adjustmentIn_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=adjustmentIn&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });

        $('#adjustmentIn_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=adjustmentIn&idsubdoc=currency","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $("#adjustmentIn_btnWarehouse").click(function(ev) {
            window.open("./pages/search/search-warehouse.jsp?iddoc=adjustmentIn&idsubdoc=warehouse&idtype=Internal","Search", "scrollbars=1,width=600, height=500");
        });
        
        $('#btnAdjustmentInSerialNoDetailSetAll').click(function(ev) {
        $('#adjustmentInSerialNoDetailInput_grid').jqGrid("saveRow"); 
            var idx = jQuery("#adjustmentInSerialNoDetailInput_grid").jqGrid('getDataIDs'); 
            var adjustmentInSerialNoDetailRangeIDs=$("#adjustmentInSerialNoDetailRangeID").val().trim();

            var adjustmentInSerialNoDetailRange=adjustmentInSerialNoDetailRangeIDs.split('-');
            var adjustmentInSerialNoDetailFirstRange=parseInt(adjustmentInSerialNoDetailRange[0]);
            var adjustmentInSerialNoDetailLastRange=parseInt(adjustmentInSerialNoDetailRange[1]);
            var rowCount=0;
            for(var j=0;j < idx.length;j++){
                rowCount=(j+1);
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell",idx[j],"adjustmentInSerialNoDetailRemark", txtAdjustmentInSerialNoDetailRemarkText.val());
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell",idx[j],"adjustmentInSerialNoDetailRemarkkQuantity", txtAdjustmentInSerialNoDetailRemarkQuantity.val());

                if(adjustmentInSerialNoDetailRangeIDs===""){
                    $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell",idx[j],"adjustmentInSerialNoDetailLocationCode", txtAdjustmentInSerialNoDetailLocationCode.val());
                    $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell",idx[j],"adjustmentInSerialNoDetailLocationName", txtAdjustmentInSerialNoDetailLocationName.val());
                }else{

                    if(rowCount >=adjustmentInSerialNoDetailFirstRange && rowCount<=adjustmentInSerialNoDetailLastRange){
                        $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell",idx[j],"adjustmentInSerialNoDetailLocationCode", txtAdjustmentInSerialNoDetailLocationCode.val());
                        $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell",idx[j],"adjustmentInSerialNoDetailLocationName", txtAdjustmentInSerialNoDetailLocationName.val());
                    }
                }
            }

        });
        
        $("#btnAdjustmentInAddItemDetail").click(function(ev) {
           
           window.open("./pages/search/search-item-material-multiple.jsp?iddoc=adjustmentInItemDetail&type=grid"+ "&rowLast=" + adjustmentInItemDetail_lastRowId,"Search", "scrollbars=1,width=600, height=500");
        });
    
    });//EOF Ready
    
        function addRowAdjustmentInItemDetailItemDataMultiSelected(lastRowId, defRow) {
            var ids = jQuery("#adjustmentInItemDetailInput_grid").jqGrid('getDataIDs');
            var lastRow = [0];
            for (var i = 0; i < ids.length; i++) {
                var comp = (ids[i] - lastRow[0]) > 0;
                if (comp) {
                    lastRow = [];
                    lastRow.push(ids[i]);
                }
            }
            adjustmentInItemDetail_lastRowId = lastRowId;
            
            $("#adjustmentInItemDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#adjustmentInItemDetailInput_grid").jqGrid('setRowData', lastRowId, {
                adjustmentInItemDetailItemDelete            : "delete",
                adjustmentInItemDetailItemMaterialCode              : defRow.adjustmentInItemDetailItemMaterialCode,
                adjustmentInItemDetailItemMaterialName              : defRow.adjustmentInItemDetailItemMaterialName,
                adjustmentInItemDetailItemMaterialUnitOfMeasureCode : defRow.adjustmentInItemDetailItemMaterialUnitOfMeasureCode,
                adjustmentInItemDetailRackCode                      : txtAdjustmentInWarehouseRackCode.val(),
                adjustmentInItemDetailRackName                      : txtAdjustmentInWarehouseRackName.val()

            });
        }
        
        function calculateAdjustmentInNonSerialNoDetail() {
        var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        
        var Price = $("#" + selectedRowID + "_adjustmentInItemDetailPrice").val();
        var qty = ($("#" + selectedRowID + "_adjustmentInItemDetailQuantity").val()!=="") ? parseFloat($("#" + selectedRowID + "_adjustmentInItemDetailQuantity").val()):0.00;
        var TotalAmount = (parseFloat(qty) * parseFloat(Price));
         
        $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID, "adjustmentInItemDetailTotalTransactionAmount", TotalAmount);
    }
    
    function adjustmentInReadOnlyExchangeRate(){
        if($("#adjustmentInUpdateMode").val()==="false"){
            if(txtAdjustmentInCurrencyCode.val()==="IDR"){
                txtAdjustmentInExchangeRate.attr('readonly',true);
            }else{
                txtAdjustmentInExchangeRate.attr('readonly',false);
            }
        }
    }
    
    function adjustmentInApprovalLoadExchangeRate(){ 
        if (txtAdjustmentInCurrencyCode.val()==="IDR"){
            txtAdjustmentInExchangeRate.val("1.00");
            txtAdjustmentInExchangeRate.attr("readonly",true);
        }else{
            if($("#adjustmentInUpdateMode").val()==="false"){
                txtAdjustmentInExchangeRate.val("0.00");   
            }
            txtAdjustmentInExchangeRate.attr("readonly",false);
        }
    }
    
    function formatDateADJIN(){
        var transactionDateSplit=dtpAdjustmentInTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpAdjustmentInTransactionDate.val(transactionDate);
        
        var createdDateSplit=dtpAdjustmentInCreatedDate.val().split('/');
        var createdDate =createdDateSplit[1]+"/"+createdDateSplit[0]+"/"+createdDateSplit[2];
        dtpAdjustmentInCreatedDate.val(createdDate);
        $("#adjustmentIn\\.createdDateTemp").val(createdDate);                
    }
    
    function formatNumericADJIN(flag){
        var rateValue=txtAdjustmentInExchangeRate.val();
        var grandTotalAmountValue=txtAdjustmentInGrandTotalAmount.val();
        var exchangeRate;
        var grandTotalAmount;
        switch(flag){
            case 0:
                exchangeRate=removeCommas(rateValue);
                grandTotalAmount=removeCommas(grandTotalAmountValue);
                break;
            case 1:
                exchangeRate=formatNumber(parseFloat(rateValue));
                grandTotalAmount=formatNumber(parseFloat(grandTotalAmountValue));
                break;
        }
        txtAdjustmentInExchangeRate.val(exchangeRate);
        txtAdjustmentInGrandTotalAmount.val(grandTotalAmount);
    }
    
    function adjustmentInItemDetailInputGrid_SearchReason_OnClick(){
        window.open("./pages/search/search-reason.jsp?iddoc=adjustmentInItemDetail&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function adjustmentInItemDetailInputGrid_RackSearch_OnClick(){
        window.open("./pages/search/search-rack.jsp?iddoc=adjustmentInItemDetail&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
	
    function adjustmentInItemDetailInputGrid_ItemDelete_OnClick(){
        var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        if (selectedRowID === null) {
            alertMessage("Please Select Row");
            return;
        }          
        $("#adjustmentInItemDetailInput_grid").jqGrid('delRowData',selectedRowID);

    }
    
    function autoLoadDataAdjustmentInItemDetail(){
        var url = "adjustment/adjustment-in-item-detail-data";
        var params = "adjustmentIn.code=" + txtAdjustmentInCode.val();

        showLoading();

        $.post(url, params, function(data) {
            adjustmentInItemDetail_lastRowId=0;
            
            for (var i=0; i<data.listAdjustmentInItemDetail.length; i++) {
                adjustmentInItemDetail_lastRowId++;
                console.log(data.listAdjustmentInItemDetail[i].itemSerialNoStatus);
                $("#adjustmentInItemDetailInput_grid").jqGrid("addRowData", adjustmentInItemDetail_lastRowId, data.listAdjustmentInItemDetail[i]);
                $("#adjustmentInItemDetailInput_grid").jqGrid('setRowData',adjustmentInItemDetail_lastRowId,{
                    adjustmentInItemDetailItemDelete                    : "delete",
                    adjustmentInItemDetailItemSearch                    : "...",
                    adjustmentInItemDetailItemMaterialCode              : data.listAdjustmentInItemDetail[i].itemMaterialCode,
                    adjustmentInItemDetailItemMaterialName              : data.listAdjustmentInItemDetail[i].itemMaterialName,
                    adjustmentInItemDetailItemMaterialUnitOfMeasureCode : data.listAdjustmentInItemDetail[i].itemMaterialUnitOfMeasureCode,
                    adjustmentInItemDetailItemMaterialSerialNoStatus    : data.listAdjustmentInItemDetail[i].itemSerialNoStatus.toString(),
                    adjustmentInItemDetailReasonSearch                  : "...",
                    adjustmentInItemDetailReasonCode                    : data.listAdjustmentInItemDetail[i].reasonCode,
                    adjustmentInItemDetailReasonName                    : data.listAdjustmentInItemDetail[i].reasonName,
                    adjustmentInItemDetailQuantity                      : data.listAdjustmentInItemDetail[i].quantity,
                    adjustmentInItemDetailRackCode                      : data.listAdjustmentInItemDetail[i].rackCode,
                    adjustmentInItemDetailRackName                      : data.listAdjustmentInItemDetail[i].rackName,
                    adjustmentInItemDetailRemark                        : data.listAdjustmentInItemDetail[i].remark
                });
            }
           
            closeLoading();
            
        }); 
    }
    
    function autoLoadDataAdjustmentInItemSerialNoDetail(){
        var urle = "adjustment/adjustment-in-serial-no-detail-data";
        var paramse = "adjustmentIn.code=" + txtAdjustmentInCode.val();
    //    alert(txtAdjustmentInCode.val());
        showLoading();

        $.post(urle, paramse, function(datae) {
            adjustmentInSerialNoDetail_lastRowId=0;
            
            for (var x=0; x<datae.listAdjustmentInSerialNoDetailTemp.length; x++) {
                adjustmentInSerialNoDetail_lastRowId++;

                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("addRowData", adjustmentInSerialNoDetail_lastRowId, datae.listAdjustmentInSerialNoDetailTemp[x]);
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid('setRowData',adjustmentInSerialNoDetail_lastRowId,{
                    adjustmentInSerialNoDetailItemDelete                         : "delete",
                    adjustmentInItemDetailItemSearch                             : "...",
                    adjustmentInSerialNoDetailItemMaterialCode                   : datae.listAdjustmentInSerialNoDetailTemp[x].itemMaterialCode,
                    adjustmentInSerialNoDetailItemMaterialName                   : datae.listAdjustmentInSerialNoDetailTemp[x].itemMaterialName,
                    adjustmentInSerialNoDetailReasonSearch                       : "...",
                    adjustmentInSerialNoDetailReasonCode                         : datae.listAdjustmentInSerialNoDetailTemp[x].reasonCode,
                    adjustmentInSerialNoDetailReasonName                         : datae.listAdjustmentInSerialNoDetailTemp[x].reasonName,
                    adjustmentInSerialNoDetailSerialNo                           : datae.listAdjustmentInSerialNoDetailTemp[x].serialNo,
                    adjustmentInSerialNoDetailCapacity                           : datae.listAdjustmentInSerialNoDetailTemp[x].capacity,
                    adjustmentInSerialNoDetailUnitOfMeasureCode                  : datae.listAdjustmentInSerialNoDetailTemp[x].itemMaterialUnitOfMeasureCode,
                    adjustmentInSerialNoDetailRemark                             : datae.listAdjustmentInSerialNoDetailTemp[x].remark,
                    adjustmentInSerialNoDetailRackCode                           : datae.listAdjustmentInSerialNoDetailTemp[x].rackCode,
                    adjustmentInSerialNoDetailRackName                           : datae.listAdjustmentInSerialNoDetailTemp[x].rackName
                });
            }
            
            closeLoading();
            
        }); 
    }
        
    function clearRowSelectedAdjustmentInItemDetail(){
        var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        $("#" + selectedRowID + "_adjustmentInItemDetailItemMaterialCode").val("");
        $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialName"," ");
        $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialSerialNoStatus"," ");
        $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialUnitOfMeasureCode"," ");
    }
    
    function onChangeAdjustmentInItemDetailItem(){
        var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var itemMaterialCode = $("#" + selectedRowID + "_adjustmentInItemDetailItemMaterialCode").val();
        
        if(itemMaterialCode===""){
            clearRowSelectedAdjustmentInItemDetail();
            return;
        }
        
        var ids = jQuery("#adjustmentInItemDetailInput_grid").jqGrid('getDataIDs'); 
        
        var url = "master/item-get";
        var params = "item.code="+itemMaterialCode;
            params+="&item.activeStatus=TRUE";
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.itemTemp){
                $("#" + selectedRowID + "_adjustmentInItemDetailItemMaterialCode").val(data.itemTemp.code);
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialName",data.itemTemp.name);
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialSerialNoStatus",data.itemTemp.serialNoStatus.toString());
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialUnitOfMeasureCode",data.itemTemp.unitOfMeasureCode);
                for(var i=0;i<ids.length;i++){
                    for(var j=0;j<ids.length;j++){
                        if(i!==j){
                            var dataGridItemCode = $("#adjustmentInItemDetailInput_grid").jqGrid('getRowData',ids[j]);
                            if(data.itemTemp.code===dataGridItemCode.adjustmentInItemDetailItemMaterialCode){                            
                                alertMessage("Item "+ data.itemTemp.code+" has been existing in Grid!",$("#" + selectedRowID + "_adjustmentInItemDetailItemMaterialCode"));
                                clearRowSelectedAdjustmentInItemDetail();
                                return;
                            }
                        }
                    }
                }
            }else{
                alertMessage("Item Not Found!",$("#" + selectedRowID + "_adjustmentInItemDetailItemMaterialCode"));
                $("#" + selectedRowID + "_adjustmentInItemDetailItemMaterialCode").val("");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialName"," ");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialSerialNoStatus"," ");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailItemMaterialUnitOfMeasureCode"," ");
            }
        });
    }
        
    function onChangeAdjustmentInItemDetailReason(){
        var selectedRowID = $("#adjustmentInItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var reasonCode = $("#" + selectedRowID + "_adjustmentInItemDetailReasonCode").val();
        
        if(reasonCode.trim()===""){
            $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailReasonName"," ");
            $("#" + selectedRowID + "_adjustmentInItemDetailChartOfAccountCode").val("");
            $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailChartOfAccountName"," ");
            return;
        }       
        
        var url = "master/reason-get";
        var params = "reason.code="+reasonCode;
            params+="&reason.activeStatus=TRUE";
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.reasonTemp){
                $("#" + selectedRowID + "_adjustmentInItemDetailReasonCode").val(data.reasonTemp.code);
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailReasonName",data.reasonTemp.name);
                $("#" + selectedRowID + "_adjustmentInItemDetailChartOfAccountCode").val(data.reasonTemp.chartOfAccountCode);
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailChartOfAccountName",data.reasonTemp.chartOfAccountName);
            }
            else{
                alertMessage("Reason Not Found!",$("#" + selectedRowID + "_adjustmentInItemDetailReasonCode"));
                $("#" + selectedRowID + "_adjustmentInItemDetailReasonCode").val("");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailReasonName"," ");
                $("#" + selectedRowID + "_adjustmentInItemDetailChartOfAccountCode").val("");
                $("#adjustmentInItemDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInItemDetailChartOfAccountName"," ");
            }
        });
    }
    
    function onChangeAdjustmentInSerialNoDetailReason(){
        var selectedRowID = $("#adjustmentInSerialNoDetailInput_grid").jqGrid("getGridParam", "selrow");
        var reasonCode = $("#" + selectedRowID + "_adjustmentInSerialNoDetailReasonCode").val();
        
        if(reasonCode.trim()===""){
            $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInSerialNoDetailReasonName"," ");
            $("#" + selectedRowID + "_adjustmentInSerialNoDetailChartOfAccountCode").val("");
            $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInSerialNoDetailChartOfAccountName"," ");
            return;
        }       
        
        var url = "master/reason-get";
        var params = "reason.code="+reasonCode;
            params+="&reason.activeStatus=TRUE";
            
        $.post(url, params, function(result) {
            var data = (result);
            if (data.reasonTemp){
                $("#" + selectedRowID + "_adjustmentInSerialNoDetailReasonCode").val(data.reasonTemp.code);
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInSerialNoDetailReasonName",data.reasonTemp.name);
                $("#" + selectedRowID + "_adjustmentInSerialNoDetailChartOfAccountCode").val(data.reasonTemp.chartOfAccountCode);
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInSerialNoDetailChartOfAccountName",data.reasonTemp.chartOfAccountName);
            }
            else{
                alertMessage("Reason Not Found!",$("#" + selectedRowID + "_adjustmentInSerialNoDetailReasonCode"));
                $("#" + selectedRowID + "_adjustmentInSerialNoDetailReasonCode").val("");
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInSerialNoDetailReasonName"," ");
                $("#" + selectedRowID + "_adjustmentInSerialNoDetailChartOfAccountCode").val("");
                $("#adjustmentInSerialNoDetailInput_grid").jqGrid("setCell", selectedRowID,"adjustmentInSerialNoDetailChartOfAccountName"," ");
            }
        });
    }

    function handlers_input_adjustment_in(){
        if(txtAdjustmentInBranchCode.val()===""){
            handlersInput(txtAdjustmentInBranchCode);
        }else{
            unHandlersInput(txtAdjustmentInBranchCode);
        }
//        if(txtAdjustmentInCompanyCode.val()===""){
//            handlersInput(txtAdjustmentInCompanyCode);
//        }else{
//            unHandlersInput(txtAdjustmentInCompanyCode);
//        }
        if(dtpAdjustmentInTransactionDate.val()===""){
            handlersInput(dtpAdjustmentInTransactionDate);
        }else{
            unHandlersInput(dtpAdjustmentInTransactionDate);
        }
//        if(parseFloat(txtAdjustmentInExchangeRate.val())===0){
//            handlersInput(txtAdjustmentInExchangeRate);
//        }else{
//            unHandlersInput(txtAdjustmentInExchangeRate);
//        }
//        if(txtAdjustmentInCurrencyCode.val()===""){
//            handlersInput(txtAdjustmentInCurrencyCode);
//        }else{
//            unHandlersInput(txtAdjustmentInCurrencyCode);
//        }
        if(txtAdjustmentInWarehouseCode.val()===""){
            handlersInput(txtAdjustmentInWarehouseCode);
        }else{
            unHandlersInput(txtAdjustmentInWarehouseCode);
        }
    }
</script>
<b> ADJUSTMENT IN (DRAFT)</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlAdjustmentInItemDetailInput" action="" />
<s:url id="remotedetailurlAdjustmentInSerialNoDetailInput" action="" />

<div id="adjustmentInInput" class="content ui-widget">
    <s:form id="frmAdjustmentInInput">
        <div id="div-header-adj-in">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>ADJ-IN NO *</B></td>
                    <td>
                        <s:textfield id="adjustmentIn.code" name="adjustmentIn.code" size="20" readonly="true" ></s:textfield>
                    </td>
                    <script type = "text/javascript">
                        if($("#adjustmentInUpdateMode").val()==="true"){
                            txtAdjustmentInCode.after(function(ev) {
//                                autoLoadDataAdjustmentInItemSerialNoDetail();
//                                autoLoadDataAdjustmentInItemDetail();
                                
                            });
                        }
                    </script>
                </tr>
                <tr>
                    <td align="right" style="width:120px"><B>Branch *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            txtAdjustmentInBranchCode.change(function(ev) {

                                if(txtAdjustmentInBranchCode.val()===""){
                                    txtAdjustmentInBranchName.val("");
                                    return;
                                }
                                var url = "master/branch-get";
                                var params = "branch.code=" + txtAdjustmentInBranchCode.val();
                                    params += "&branch.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.branchTemp){
                                        txtAdjustmentInBranchCode.val(data.branchTemp.code);
                                        txtAdjustmentInBranchName.val(data.branchTemp.name);
                                    }
                                    else{
                                        alertMessage("Branch Not Found!",txtAdjustmentInBranchCode);
                                        txtAdjustmentInBranchCode.val("");
                                        txtAdjustmentInBranchName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                            <s:textfield id="adjustmentIn.branch.code" name="adjustmentIn.branch.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                            <sj:a id="adjustmentIn_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-branch-adjustment-in"/></sj:a>
                        </div>
                        <s:textfield id="adjustmentIn.branch.name" name="adjustmentIn.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="adjustmentIn.transactionDate" name="adjustmentIn.transactionDate"  title=" " required="true" cssClass="required" showOn="false" displayFormat="dd/mm/yy" size="15" readonly="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Warehouse *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">   

                            txtAdjustmentInWarehouseCode.change(function(ev) {

                                if(txtAdjustmentInWarehouseCode.val()===""){
                                    txtAdjustmentInWarehouseName.val("");
                                    txtAdjustmentInWarehouseRackCode.val("");
                                    txtAdjustmentInWarehouseRackName.val("");
                                    return;
                                }
                                var url = "master/warehouse-get";
                                var params = "warehouse.code=" + txtAdjustmentInWarehouseCode.val();
                                    params += "&warehouse.activeStatus=true";
                                
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.warehouseTemp){
                                        txtAdjustmentInWarehouseCode.val(data.warehouseTemp.code);
                                        txtAdjustmentInWarehouseName.val(data.warehouseTemp.name);
                                        txtAdjustmentInWarehouseRackCode.val(data.warehouseTemp.dockInCode);
                                        txtAdjustmentInWarehouseRackName.val(data.warehouseTemp.dockInName);
                                    }else{
                                        alertMessage("Warehouse Not Found!",txtAdjustmentInWarehouseCode);
                                        txtAdjustmentInWarehouseCode.val("");
                                        txtAdjustmentInWarehouseName.val("");
                                        txtAdjustmentInWarehouseRackCode.val("");
                                        txtAdjustmentInWarehouseRackName.val("");
                                    }    
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="adjustmentIn.warehouse.code" name="adjustmentIn.warehouse.code" size="20" title=" " required="true" cssClass="required" ></s:textfield>
                            <sj:a id="adjustmentIn_btnWarehouse" href="#">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="adjustmentIn.warehouse.name" name="adjustmentIn.warehouse.name" cssStyle="width:49%" readonly="true" ></s:textfield>
                            <s:textfield id="adjustmentIn.warehouse.dockInCode" name="adjustmentIn.warehouse.dockInCode" cssStyle="width:49%;display:none;" readonly="true" ></s:textfield>
                            <s:textfield id="adjustmentIn.warehouse.dockInName" name="adjustmentIn.warehouse.dockInName" cssStyle="width:49%;display:none;" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td><s:textfield id="adjustmentIn.refNo" name="adjustmentIn.refNo" size="30" ></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td><s:textarea id="adjustmentIn.remark" name="adjustmentIn.remark"  rows="3" cols="70" ></s:textarea> </td>
                </tr>
                <tr hidden="true">
                    <td>
                        <s:textfield id="adjustmentInUpdateMode" name="adjustmentInUpdateMode" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                        <s:textfield id="adjustmentIn.transactionDateTemp" name="adjustmentIn.transactionDateTemp" size="25" readonly="true" cssStyle="display:none"></s:textfield>
                        <s:textfield id="adjustmentIn.createdBy" name="adjustmentIn.createdBy" key="adjustmentIn.createdBy" readonly="true" size="22"></s:textfield>
                        <sj:datepicker id="adjustmentIn.createdDate" name="adjustmentIn.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                        <s:textfield id="adjustmentIn.createdDateTemp" name="adjustmentIn.createdDateTemp" size="20"></s:textfield>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table>              
                <tr>
                    <td width="120px"/>
                    <td>
                        <sj:a href="#" id="btnConfirmAdjustmentIn" button="true">Confirm</sj:a>
                        <sj:a href="#" id="btnUnConfirmAdjustmentIn" button="true">Unconfirm</sj:a>
                    </td>
                </tr>
            </table>    
        </div>            
        
        <br class="spacer" /> 
        <div id="adjustmentInItemDetailInputGrid">
            <table> 
                <tr>
                    <td><sj:a href="#" id="btnAdjustmentInAddItemDetail" button="true" style="width: 90px">Search Item Material</sj:a></td>
                </tr>
            </table>
            <sjg:grid
                id="adjustmentInItemDetailInput_grid"
                caption="Item Detail"
                dataType="local"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAdjustmentInItemDetail"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuadjustmentin').width()"
                editinline="true"
                editurl="%{remotedetailurlAdjustmentInItemDetailInput}"
                onSelectRowTopics="adjustmentInItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="adjustmentInItemDetailTemp" index="adjustmentInItemDetailTemp" key="adjustmentInItemDetailTemp" title="" hidden="true" editable="true" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInItemDetailItemDelete" index="adjustmentInItemDetailItemDelete" title="" width="50" align="centre"
                    editable="true" edittype="button"
                    editoptions="{onClick:'adjustmentInItemDetailInputGrid_ItemDelete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailItemMaterialCode" index = "adjustmentInItemDetailItemMaterialCode" key = "adjustmentInItemDetailItemMaterialCode" 
                    title = "Item Code *" width = "150" edittype="text" editable="true"
                    editoptions="{onChange:'onChangeAdjustmentInItemDetailItem()'}" 
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailItemMaterialName" index = "adjustmentInItemDetailItemMaterialName" key = "adjustmentInItemDetailItemMaterialName" 
                    title = "Item Name" width = "250"
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailItemMaterialSerialNoStatus" index = "adjustmentInItemDetailItemMaterialSerialNoStatus" key = "adjustmentInItemDetailItemMaterialSerialNoStatus" 
                    title = "Serial No Status" width = "100"
                />
                <sjg:gridColumn
                    name="adjustmentInItemDetailReasonSearch" index="adjustmentInItemDetailReasonSearch" title="" width="25" align="centre"
                    editable="true" dataType="html" edittype="button"  
                    editoptions="{onClick:'adjustmentInItemDetailInputGrid_SearchReason_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailReasonCode" index = "adjustmentInItemDetailReasonCode" key = "adjustmentInItemDetailReasonCode" 
                    title = "Reason Code *" width = "150" edittype="text" editable="true"
                    editoptions="{onChange:'onChangeAdjustmentInItemDetailReason()'}" 
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailReasonName" index = "adjustmentInItemDetailReasonName" key = "adjustmentInItemDetailReasonName" 
                    title = "Reason Name" width = "250"
                />
                <sjg:gridColumn
                    name="adjustmentInItemDetailQuantity" index="adjustmentInItemDetailQuantity" key="adjustmentInItemDetailQuantity" 
                    title="Quantity *" width="80" align="right" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    editoptions="{onChange:'calculateAdjustmentInNonSerialNoDetail()'}"
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailItemMaterialUnitOfMeasureCode" index = "adjustmentInItemDetailItemMaterialUnitOfMeasureCode" key = "adjustmentInItemDetailItemMaterialUnitOfMeasureCode" 
                    title = "UOM" width = "100"
                />
                <sjg:gridColumn
                    name = "adjustmentInItemDetailRemark" index="adjustmentInItemDetailRemark" key="adjustmentInItemDetailRemark" title="Remark" width="250"  editable="true" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInItemDetailRackSearch" index="adjustmentInItemDetailRackSearch" title="" width="25" align="centre"
                    editable="true"
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'adjustmentInItemDetailInputGrid_RackSearch_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="adjustmentInItemDetailRackCode" index="adjustmentInItemDetailRackCode" key="adjustmentInItemDetailRackCode" 
                    title="Rack Code *" width="100"
                />
                <sjg:gridColumn
                    name="adjustmentInItemDetailRackName" index="adjustmentInItemDetailRackName" key="adjustmentInItemDetailRackName" 
                    title="Rack Name" width="100"
                />
            </sjg:grid >
        </div>
        <br class="spacer" />
        <table>              
            <tr>
                <td>
                    <sj:a href="#" id="btnConfirmAdjustmentInDetail" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmAdjustmentInDetail" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        
        <div id="adjustmentInSerialNoDetailInputGrid">
            <sjg:grid
                id="adjustmentInSerialNoDetailInput_grid"
                caption="Adjustment In Serial No Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAdjustmentInSerialNoDetailTemp"
                viewrecords="true"
                rownumbers="true"
                rowNum="10000"
                shrinkToFit="false"
                width="$('#tabmnuadjustmentin').width()"
                editinline="true"
                editurl="%{remotedetailurlAdjustmentInSerialNoDetailInput}"
                onSelectRowTopics="adjustmentInSerialNoDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetail" index="adjustmentInSerialNoDetail" key="adjustmentInSerialNoDetail" 
                    title="" width="50" editable="true" hidden="true" 
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailCode" index="adjustmentInSerialNoDetailCode" key="adjustmentInSerialNoDetailCode" 
                    title="Code" width="200" edittype="text" hidden="true"
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailItemMaterialCode" index="adjustmentInSerialNoDetailItemMaterialCode" key="adjustmentInSerialNoDetailItemMaterialCode" 
                    title="Item Code" width="100" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailItemMaterialName" index="adjustmentInSerialNoDetailItemMaterialName" key="adjustmentInSerialNoDetailItemMaterialName" 
                    title="Item Name" width="300" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailCapacity" index="adjustmentInSerialNoDetailCapacity" key="adjustmentInSerialNoDetailCapacity" 
                    title="Capacity *" width="80" align="right" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailItemUnitOfMeasureCode" index="adjustmentInSerialNoDetailItemUnitOfMeasureCode" key="adjustmentInSerialNoDetailItemUnitOfMeasureCode" 
                    title="UOM" width="80" edittype="text"
                />
                <sjg:gridColumn
                    name = "adjustmentInSerialNoDetailRemark" index = "adjustmentInSerialNoDetailRemark" key = "adjustmentInSerialNoDetailRemark"
                    title = "Remark" width = "250" edittype="text" editable="true"
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailRackCode" index="adjustmentInSerialNoDetailRackCode" key="adjustmentInSerialNoDetailRackCode" 
                    title="Rack Code *" width="100"
                />
                <sjg:gridColumn
                    name="adjustmentInSerialNoDetailRackName" index="adjustmentInSerialNoDetailRackName" key="adjustmentInSerialNoDetailRackName" 
                    title="Rack Name" width="100"
                />
            </sjg:grid >
        </div>        
        <br class="spacer" />
        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnAdjustmentInSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAdjustmentInCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        
    </s:form>
</div>