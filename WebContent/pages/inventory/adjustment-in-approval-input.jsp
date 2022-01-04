
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #adjustmentInApprovalItemDetailInput_grid_pager_center,#adjustmentInApprovalSerialNoDetailInput_grid_pager_center{
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
    var adjustmentInApprovalItemDetail_lastSel = -1, adjustmentInApprovalItemDetaillastRowId=0;
    var adjustmentInApprovalSerialNoItemDetail_lastSel = -1, adjustmentInApprovalSerialNoItemDetaillastRowId=0;
    var txtAdjustmentInApprovalCode = $("#adjustmentInApproval\\.code"),
        txtAdjustmentInApprovalBranchCode = $("#adjustmentInApproval\\.branch\\.code"),
        txtAdjustmentInApprovalBranchName = $("#adjustmentInApproval\\.branch\\.name"),
        txtAdjustmentInApprovalCompanyCode = $("#adjustmentInApproval\\.company\\.code"),
        txtAdjustmentInApprovalCompanyName = $("#adjustmentInApproval\\.company\\.name"),
        dtpAdjustmentInApprovalTransactionDate = $("#adjustmentInApproval\\.transactionDate"),
        txtAdjustmentInApprovalCurrencyCode = $("#adjustmentInApproval\\.currency\\.code"),
        txtAdjustmentInApprovalCurrencyName = $("#adjustmentInApproval\\.currency\\.name"),
        txtAdjustmentInApprovalExchangeRate = $("#adjustmentInApproval\\.exchangeRate"),
        txtAdjustmentInApprovalWarehouseCode = $("#adjustmentInApproval\\.warehouse\\.code"),
        txtAdjustmentInApprovalWarehouseName = $("#adjustmentInApproval\\.warehouse\\.name"),
        txtAdjustmentInApprovalApprovalStatus = $("#adjustmentInApproval\\.approvalStatus"),
        txtAdjustmentInApprovalReasonCode = $("#adjustmentInApproval\\.approvalReason\\.code"),
        txtAdjustmentInApprovalReasonName = $("#adjustmentInApproval\\.approvalReason\\.name"),
        txtadjustmentInApprovalRemark = $("#adjustmentInApproval\\.approvalRemark"),
        txtAdjustmentInApprovalGrandTotalAmount = $("#adjustmentInApproval\\.grandTotalAmount"),
        txtAdjustmentInApprovalGrandTotalAmountIDR = $("#adjustmentInApprovalGrandTotalAmountIDR"),
        txtAdjustmentInApprovalRefNo = $("#adjustmentInApproval\\.refNo"),
        txtAdjustmentInApprovalRemark = $("#adjustmentInApproval\\.remark"),
        dtpAdjustmentInApprovalUpdatedDate = $("#adjustmentInApproval\\.updatedDate"),
        dtpAdjustmentInApprovalCreatedDate = $("#adjustmentInApproval\\.createdDate");
        
    
    $(document).ready(function(){  
        
        formatNumericADJINApproval(1);
        adjustmentInApprovalLoadExchangeRate();
        
        $('#adjustmentInApprovalApprovalStatusRadAPPROVED').prop('checked',true);
        var value="APPROVED";
        $("#adjustmentInApproval\\.approvalStatus").val(value);
        
//        $('input[name="adjustmentInApprovalApprovalStatusRad"][value="PENDING"]').change(function(ev){
//            var value="PENDING";
//            $("#adjustmentInApproval\\.approvalStatus").val(value);
//        });
                
        $('input[name="adjustmentInApprovalApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#adjustmentInApproval\\.approvalStatus").val(value);
        });
        
        $('input[name="adjustmentInApprovalApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#adjustmentInApproval\\.approvalStatus").val(value);
        });
        
        $("#adjustmentInApproval\\.exchangeRate").change(function(e){
            var exrate=$("#adjustmentInApproval\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#adjustmentInApproval\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $.subscribe("adjustmentInApprovalItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==adjustmentInApprovalItemDetail_lastSel) {
                $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('saveRow',adjustmentInApprovalItemDetail_lastSel); 
                $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                adjustmentInApprovalItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
             
        $.subscribe("adjustmentInApprovalSerialNoItemDetailInput_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==adjustmentInApprovalSerialNoItemDetail_lastSel) {
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('saveRow',adjustmentInApprovalSerialNoItemDetail_lastSel); 
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('editRow',selectedRowID,true); 
                adjustmentInApprovalSerialNoItemDetail_lastSel=selectedRowID;
            }
            else{
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('saveRow',selectedRowID);
            }
        });
             
        $("#btnAdjustmentInApprovalSave").click(function(ev) {
            
            if(!$("#frmAdjustmentInApprovalInput").valid()) {
                alertMessage("Field(s) Can't empty!");
                ev.preventDefault();
                return;
            }
            
            if(adjustmentInApprovalItemDetail_lastSel !== -1) {
                $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('saveRow',adjustmentInApprovalItemDetail_lastSel); 
            }
            
            if(adjustmentInApprovalSerialNoItemDetail_lastSel !== -1) {
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('saveRow',adjustmentInApprovalSerialNoItemDetail_lastSel); 
            }
            
            var listAdjustmentInApprovalItemDetail = new Array();            
            var listAdjustmentInSerialNoDetail = new Array();        
            
            var ids = jQuery("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getRowData',ids[i]); 
                
               
                var adjustmentInItemDetail = {
                    code                : data.adjustmentInApprovalItemDetailCode,
                    itemMaterial        : {code:data.adjustmentInApprovalItemDetailItemMaterialCode},
                    reason              : { code : data.adjustmentInApprovalItemDetailReasonCode},
                    quantity            : data.adjustmentInApprovalItemDetailQuantity,
                    rack                : {code:data.adjustmentInApprovalItemDetailRackCode},
                    remark              : data.adjustmentInApprovalItemDetailRemark,
                    price               : data.adjustmentInApprovalItemDetailPrice,
                    totalAmount         : data.adjustmentInApprovalItemDetailTotalAmount
                     
                };
                listAdjustmentInApprovalItemDetail[i] = adjustmentInItemDetail;
          
            }
            
            var idx = jQuery("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('getDataIDs'); 
            
            for(var x=0;x < idx.length;x++){
                var data = $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('getRowData',idx[x]); 
             
                var adjustmentInSerialNoDetail = {
                    code            : data.adjustmentInApprovalSerialNoDetailCode,
                    headerCode      : data.adjustmentInApprovalSerialNoDetailHeaderCode,
                    itemMaterial    : {code:data.adjustmentInApprovalSerialNoDetailItemMaterialCode},
                    reason          : { code : data.adjustmentInApprovalSerialNoDetailReasonCode},
                    serialNo        : data.adjustmentInApprovalSerialNoDetailSerialNo,
                    capacity        : data.adjustmentInApprovalSerialNoDetailCapacity,
                    remark          : data.adjustmentInApprovalSerialNoDetailRemark,
                    rack            : { code : data.adjustmentInApprovalSerialNoDetailRackCode},
                    price           : data.adjustmentInApprovalSerialNoDetailPrice
                };
                listAdjustmentInSerialNoDetail[x]=adjustmentInSerialNoDetail;
            }
            
         
            formatDateADJINApproval();
            formatNumericADJINApproval(0);
            
            var url = "adjustment/adjustment-in-save-approval-data";
            var params=$("#frmAdjustmentInApprovalInput").serialize();
                params+="&listAdjustmentInItemDetailJSON=" + $.toJSON(listAdjustmentInApprovalItemDetail);
                params+="&listAdjustmentInSerialNoDetailJSON=" + $.toJSON(listAdjustmentInSerialNoDetail);

            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    formatDateADJINApproval();
                    formatNumericADJINApproval(1);
                    return;
                }
                
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/></div>');

                dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 500,
                    resizable: false,
                    buttons : 
                        [{
                            text : "Ok",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "adjustment/adjustment-in-approval";
                                pageLoad(url, params, "#tabmnuADJUSTMENT_IN_APPROVAL");
                            }
                        }]
                });
            });
        });
        
        $("#btnAdjustmentInApprovalCancel").click(function(ev){
            var params = "";
            var url = "adjustment/adjustment-in-approval";
            pageLoad(url, params, "#tabmnuADJUSTMENT_IN_APPROVAL");
        });
        
    });//EOF Ready
    
     $('#adjustmentInApproval_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=adjustmentInApproval&idsubdoc=currency","Search", "Scrollbars=1,width=600, height=500");
     });
     
    function adjustmentInApprovalLoadExchangeRate(){ 
        if (txtAdjustmentInApprovalCurrencyCode.val()==="IDR"){
            txtAdjustmentInApprovalExchangeRate.val("1.00");
            txtAdjustmentInApprovalExchangeRate.attr("readonly",true);
         
        }else{
            txtAdjustmentInApprovalExchangeRate.val("0.00"); 
            txtAdjustmentInApprovalExchangeRate.attr("readonly",false);
        }
        
//        calculateAdjustmentInItemDetail();
    }
    
    function loadDataItemDetailAdjustmentInApproval(){
        var url = "adjustment/adjustment-in-item-detail-data";
        var params = "adjustmentIn.code=" + txtAdjustmentInApprovalCode.val();
        
        $.post(url, params, function(data) {
            var adjustmentInApprovalItemDetaillastRowId = 0;
            var counter=0;
            for (var i=0; i<data.listAdjustmentInItemDetail.length; i++) {
                counter++;
                adjustmentInApprovalItemDetaillastRowId++;
                var totalTransactionAmount=parseFloat(data.listAdjustmentInItemDetail[i].quantity) * parseFloat(data.listAdjustmentInItemDetail[i].price);
                
                $("#adjustmentInApprovalItemDetailInput_grid").jqGrid("addRowData", adjustmentInApprovalItemDetaillastRowId, data.listAdjustmentInItemDetail[i]);
                $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('setRowData',adjustmentInApprovalItemDetaillastRowId,{
                    adjustmentInApprovalItemDetailCode                          : data.listAdjustmentInItemDetail[i].code,
                    adjustmentInApprovalItemDetailItemMaterialCode              : data.listAdjustmentInItemDetail[i].itemMaterialCode,
                    adjustmentInApprovalItemDetailItemMaterialName              : data.listAdjustmentInItemDetail[i].itemMaterialName,
                    adjustmentInApprovalItemDetailItemMaterialUnitOfMeasureCode : data.listAdjustmentInItemDetail[i].itemMaterialUnitOfMeasureCode,
                    adjustmentInApprovalItemDetailItemMaterialSerialNoStatus    : data.listAdjustmentInItemDetail[i].itemMaterialSerialNoStatus,
                    adjustmentInApprovalItemDetailReasonCode                    : data.listAdjustmentInItemDetail[i].reasonCode,
                    adjustmentInApprovalItemDetailReasonName                    : data.listAdjustmentInItemDetail[i].reasonName,
                    adjustmentInApprovalItemDetailQuantity                      : data.listAdjustmentInItemDetail[i].quantity,
                    adjustmentInApprovalItemDetailPrice                         : data.listAdjustmentInItemDetail[i].price,
                    adjustmentInApprovalItemDetailTotalAmount                   : totalTransactionAmount,
                    adjustmentInApprovalItemDetailRemark                        : data.listAdjustmentInItemDetail[i].remark,
                    adjustmentInApprovalItemDetailRackCode                      : data.listAdjustmentInItemDetail[i].rackCode,
                    adjustmentInApprovalItemDetailRackName                      : data.listAdjustmentInItemDetail[i].rackName
                });
            }
            
            if(parseInt(data.listAdjustmentInItemDetail.length)===parseInt(counter)){
                loadDataSerialNoDetailAdjustmentInApproval();
            }
        });
    }
    
    function loadDataSerialNoDetailAdjustmentInApproval(){
        
        var listAdjustmentInItemDetail= new Array();
        var ids = jQuery("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getDataIDs'); 
        var count=0;
        for(var l=0; l< ids.length;l++){ 
            var data = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getRowData',ids[l]); 

             if(data.adjustmentInApprovalItemDetailItemMaterialSerialNoStatus==="YES"){
                var adjustmentInItemDetail = {
                    code    : data.adjustmentInApprovalItemDetailCode
                };
                listAdjustmentInItemDetail[count] = adjustmentInItemDetail;
                count++;
            }
        }

        var url = "inventory/adjustment-in-serial-no-detail-bulk-data";
        var params = "listAdjustmentInItemDetailJSON=" + $.toJSON(listAdjustmentInItemDetail);
        
        $.post(url, params, function(data) {
            var adjustmentInApprovalSerialNoDetaillastRowId = 0;
            
            for (var i=0; i<data.listAdjustmentInSerialNoDetail.length; i++) {
                adjustmentInApprovalSerialNoDetaillastRowId++;
                
//                var detailPrice=0;
//                var ids = jQuery("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getDataIDs');             
//                for(var j=0; j<ids.length; j++){
//                    var dataItemDetail = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getRowData',ids[j]);
//                    
//                    if(dataItemDetail.adjustmentInApprovalItemDetailItemMaterialCode===data.listAdjustmentInSerialNoDetail[i].itemMaterialCode){
//                        detailPrice=dataItemDetail.adjustmentInApprovalItemDetailPrice;
//                    }
//                }
                
//                var remarkDateValues=data.listAdjustmentInSerialNoDetail[i].remarkDate.split("T");
//                var remarkDateValue=remarkDateValues[0].toString().split("-");
//                var remarkDate=remarkDateValue[2]+"/"+remarkDateValue[1]+"/"+remarkDateValue[0];
                
                
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid("addRowData", adjustmentInApprovalSerialNoDetaillastRowId, data.listAdjustmentInSerialNoDetail[i]);
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('setRowData',adjustmentInApprovalSerialNoDetaillastRowId,{
                    adjustmentInApprovalSerialNoDetailCode                              : data.listAdjustmentInSerialNoDetail[i].code,
                    adjustmentInApprovalSerialNoDetailHeaderCode                        : data.listAdjustmentInSerialNoDetail[i].headerCode,
                    adjustmentInApprovalSerialNoDetailItemMaterialCode                  : data.listAdjustmentInSerialNoDetail[i].itemMaterialCode,
                    adjustmentInApprovalSerialNoDetailItemMaterialName                  : data.listAdjustmentInSerialNoDetail[i].itemMaterialName,
                    adjustmentInApprovalSerialNoDetailSerialNo                          : 'AUTO',
                    adjustmentInApprovalSerialNoDetailCapacity                          : data.listAdjustmentInSerialNoDetail[i].capacity,
                    adjustmentInApprovalSerialNoDetailItemMaterialUnitOfMeasureCode     : data.listAdjustmentInSerialNoDetail[i].itemMaterialUnitOfMeasureCode,
                    adjustmentInApprovalSerialNoDetailRemark                            : data.listAdjustmentInSerialNoDetail[i].remark,
                    adjustmentInApprovalSerialNoDetailRackCode                          : data.listAdjustmentInSerialNoDetail[i].rackCode,
                    adjustmentInApprovalSerialNoDetailRackName                          : data.listAdjustmentInSerialNoDetail[i].rackName
                });
                
            }
        });
    }
    
    function formatDateADJINApproval(){
        var transactionDateValue=dtpAdjustmentInApprovalTransactionDate.val();
        var transactionDateValuesTemp=transactionDateValue.split(' ');
        var transactionDateValues=transactionDateValuesTemp[0].split('/');
        var transactionDate = transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2]+" "+transactionDateValuesTemp[1];
        dtpAdjustmentInApprovalTransactionDate.val(transactionDate);
        $("#adjustmentInApproval\\.transactionDateTemp").val(transactionDate);
        
        var updatedDateValue=dtpAdjustmentInApprovalUpdatedDate.val();
        var updatedDateValueTemp=updatedDateValue.split(' ');
        var updatedDateValues=updatedDateValueTemp[0].split('/');
        var updatedDate = updatedDateValues[1]+"/"+updatedDateValues[0]+"/"+updatedDateValues[2]+" "+updatedDateValueTemp[1];
        dtpAdjustmentInApprovalUpdatedDate.val(updatedDate);
        $("#adjustmentInApproval\\.updatedDateTemp").val(updatedDate);
        
        var createdDateValue=dtpAdjustmentInApprovalCreatedDate.val();
        var createdDateValuesTemp=createdDateValue.split(' ');
        var createdDateValues=createdDateValuesTemp[0].split('/');
        var createdDate = createdDateValues[1]+"/"+createdDateValues[0]+"/"+createdDateValues[2]+" "+createdDateValuesTemp[1];
        dtpAdjustmentInApprovalCreatedDate.val(createdDate);
        $("#adjustmentInApproval\\.createdDateTemp").val(createdDate);
    }
    
    function formatNumericADJINApproval(flag){
        var rateValue=txtAdjustmentInApprovalExchangeRate.val();
        var grandTotalAmountValue=txtAdjustmentInApprovalGrandTotalAmount.val();
        var exchangeRate;
        var grandTotalAmount;
  
        switch(flag){
            case 0:
                exchangeRate=removeCommas(rateValue);
                grandTotalAmount=removeCommas(grandTotalAmountValue);
                break;
            case 1:
                exchangeRate=formatNumber(parseFloat(rateValue),2);
                grandTotalAmount=formatNumber(parseFloat(grandTotalAmountValue),2);
                break;
        }
        txtAdjustmentInApprovalExchangeRate.val(exchangeRate);
        txtAdjustmentInApprovalGrandTotalAmount.val(grandTotalAmount);
    }
    
        
    function setHeightGridADJIN(){
        var ids = jQuery("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getDataIDs'); 
        
        if(ids.length > 15){
            var rowHeight = $("#adjustmentInApprovalItemDetailInput_grid"+" tr").eq(1).height();
            $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
        
    }
    
     function calculateInventoryInApprovalItemDetail() {
        
        var selectedRowID = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid("getGridParam", "selrow");
        var data = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getRowData',selectedRowID);
        var itemDetailCode = data.adjustmentInApprovalItemDetailCode;
        var quantity = data.adjustmentInApprovalItemDetailQuantity;
        var price = $("#" + selectedRowID + "_adjustmentInApprovalItemDetailPrice").val();
        var exchangeRate =removeCommas(txtAdjustmentInApprovalExchangeRate.val());
        var totalAmount = 0;
        var totalAmountIDR = 0;
        var totalTransactionAmount = 0;
        
        if(exchangeRate===""){
            exchangeRate="0.00";
        }
        if(quantity===""){
            quantity="0.00";
        }
        if(price===""){
            price="0.00";
        }
                       
        totalAmount= (parseFloat(quantity) * parseFloat(price));
        
        $("#adjustmentInApprovalItemDetailInput_grid").jqGrid("setCell", selectedRowID, "adjustmentInApprovalItemDetailTotalAmount", totalAmount.toFixed(4));

        var ids = jQuery("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getDataIDs');
        var idx = jQuery("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#adjustmentInApprovalItemDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransactionAmount += parseFloat(data.adjustmentInApprovalItemDetailTotalAmount);
            
        }
        
        for(var j=0;j < idx.length;j++) {
            var dataSerial = $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid('getRowData',idx[j]);
            if(itemDetailCode===dataSerial.adjustmentInApprovalSerialNoDetailHeaderCode){
                $("#adjustmentInApprovalSerialNoDetailInput_grid").jqGrid("setCell", idx[j], "adjustmentInApprovalSerialNoDetailPrice", price);
            }
        }
        
        totalAmountIDR= totalTransactionAmount * parseFloat(exchangeRate);
        
        txtAdjustmentInApprovalGrandTotalAmount.val(formatNumber(parseFloat(totalTransactionAmount.toFixed(4)), 2));
        txtAdjustmentInApprovalGrandTotalAmountIDR.val(formatNumber(parseFloat(totalAmountIDR.toFixed(4)), 2));
        
    }
    
</script>
<b> ADJUSTMENT IN APPROVAL</b>
<hr>
<br class="spacer" />
<s:url id="remotedetailurlAdjustmentInApprovalItemDetailInput" action="" />
<s:url id="remotedetailurlAdjustmentInApprovalSerialNoItemDetailInput" action="" />
<div id="adjustmentInApprovalInput" class="content ui-widget">
    <s:form id="frmAdjustmentInApprovalInput">
        <div id="div-header-iot-approval">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>ADJ-IN NO *</B></td>
                    <td>
                        <s:textfield id="adjustmentInApproval.code" name="adjustmentInApproval.code" size="20" readonly="true"></s:textfield>
                    </td>
                    <script type = "text/javascript">
                            txtAdjustmentInApprovalCode.after(function(ev) {
                                loadDataItemDetailAdjustmentInApproval();
                                                                
//                                var adjustmentInApprovalExchangeRate=parseFloat(txtAdjustmentInApprovalExchangeRate.val());
//                                txtAdjustmentInApprovalExchangeRate.val(formatNumber(adjustmentInApprovalExchangeRate,2));
//                                
//                                var grandTotalAmount=parseFloat(txtAdjustmentInApprovalGrandTotalAmount.val());
//                                txtAdjustmentInApprovalGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
//                                
//                                var grandTotalAmountIDR=grandTotalAmount * adjustmentInApprovalExchangeRate;
//                                txtAdjustmentInApprovalGrandTotalAmountIDR.val(formatNumber(grandTotalAmountIDR,2));
                            });
                    </script>
                </tr>
                <tr>
                    <td align="right" valign="top"><B>Branch *</B></td>
                    <td colspan="2">
                        <s:textfield id="adjustmentInApproval.branch.code" name="adjustmentInApproval.branch.code" required="true" cssClass="required" title=" " size="20" readonly="true"></s:textfield>
                        <s:textfield id="adjustmentInApproval.branch.name" name="adjustmentInApproval.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td>
                        <sj:datepicker id="adjustmentInApproval.transactionDate" name="adjustmentInApproval.transactionDate"  title=" " required="true" cssClass="required" showOn="false" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" readonly="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Currency *</B></td>
                    <td colspan="2">
                    <script type = "text/javascript">

                        txtAdjustmentInApprovalCurrencyCode.change(function(ev) {

                            if(txtAdjustmentInApprovalCurrencyCode.val()===""){
                                txtAdjustmentInApprovalCurrencyName.val("");
                                txtAdjustmentInApprovalExchangeRate.val("0.00");
                                txtAdjustmentInApprovalExchangeRate.attr("readonly",true);
                                return;
                            }
                            var url = "master/currency-get";
                            var params = "currency.code=" + txtAdjustmentInApprovalCurrencyCode.val();
                                params += "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtAdjustmentInApprovalCurrencyCode.val(data.currencyTemp.code);
                                    txtAdjustmentInApprovalCurrencyName.val(data.currencyTemp.name);
                                    adjustmentInApprovalLoadExchangeRate();
//                                    calculateAdjustmentInItemDetail();
                                }
                                else{
                                    alertMessage("Currency Not Found!",txtAdjustmentInApprovalCurrencyCode);
                                    txtAdjustmentInApprovalCurrencyCode.val("");
                                    txtAdjustmentInApprovalCurrencyName.val("");
                                    txtAdjustmentInApprovalExchangeRate.val("1.00");
                                    txtAdjustmentInApprovalExchangeRate.attr("readonly",true);
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="adjustmentInApproval.currency.code" name="adjustmentInApproval.currency.code" required="true" cssClass="required" title="*" size="20"></s:textfield>
                        <sj:a id="adjustmentInApproval_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="adjustmentInApproval.currency.name" name="adjustmentInApproval.currency.name" cssStyle="width:30%" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td size="15" align="right"><B>Exchange Rate *</B>
                    <td>
                        <s:textfield id="adjustmentInApproval.exchangeRate" name="adjustmentInApproval.exchangeRate" formatter="number" required="true" cssStyle="text-align:right" ></s:textfield>
                        <B>IDR</B>
                    </td>
                    </td>
                </tr>
                <tr>
                    <td align="right">Warehouse</td>
                    <td colspan="2">
                        <s:textfield id="adjustmentInApproval.warehouse.code" name="adjustmentInApproval.warehouse.code" size="25" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                        <s:textfield id="adjustmentInApproval.warehouse.name" name="adjustmentInApproval.warehouse.name" size="45" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="adjustmentInApproval.refNo" name="adjustmentInApproval.refNo" size="30" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td>
                        <s:textarea id="adjustmentInApproval.remark" name="adjustmentInApproval.remark"  rows="3" cols="70" readonly="true"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Status *</B></td>
                    <td>
                        <s:radio id="adjustmentInApprovalApprovalStatusRad" name="adjustmentInApprovalApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="adjustmentInApproval.approvalStatus" name="adjustmentInApproval.approvalStatus" size="5" style="display:none"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td width="120px" align="right"><B>Reason *</B> </td>
                    <td>
                        <script type = "text/javascript">
                            $('#AdjustmentInApproval_btnApprovalReason').click(function(ev) {
                                window.open("./pages/search/search-reason.jsp?iddoc=adjustmentInApproval&idsubdoc=approvalReason&modulecode="+$("#adjustmentInApprovalModuleCode").val(),"Search", "Scrollbars=1,width=600, height=500");
                            });
                            txtAdjustmentInApprovalReasonCode.change(function(ev) {

                                if(txtAdjustmentInApprovalReasonCode.val()===""){
                                    txtPurchaseOrderApprovalReasonName.val("");
                                    return;
                                }
                                var url = "master/reason-get";
                                var params = "reason.code=" + txtAdjustmentInApprovalReasonCode.val();
                                    params += "&reason.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.reasonTemp){
                                        txtAdjustmentInApprovalReasonCode.val(data.reasonTemp.code);
                                        txtPurchaseOrderApprovalReasonName.val(data.reasonTemp.name);
                                    }
                                    else{
                                        alertMessage("Reason Not Found!",txtAdjustmentInApprovalReasonCode);
                                        txtAdjustmentInApprovalReasonCode.val("");
                                        txtPurchaseOrderApprovalReasonName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="adjustmentInApproval.approvalReason.code" name="adjustmentInApproval.approvalReason.code" cssClass="required" required="true" title=" " size="15"></s:textfield>
                            <sj:a id="AdjustmentInApproval_btnApprovalReason" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-reason-purchase-order"/></sj:a>
                        </div>
                        <s:textfield id="adjustmentInApproval.approvalReason.name" name="adjustmentInApproval.approvalReason.name" size="30" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Remark *</B> </td>
                    <td>
                        <s:textfield id="adjustmentInApproval.approvalRemark" name="adjustmentInApproval.approvalRemark" size="51" cols="40" cssClass="required" required="true" title="*" rows="3"></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td>
                        <s:textfield id="adjustmentInApproval.transactionDateTemp" name="adjustmentInApproval.transactionDateTemp " size="5"></s:textfield>
                        <s:textfield id="adjustmentInApproval.createdBy" name="adjustmentInApproval.createdBy" size="30" readonly="true"></s:textfield>
                        <sj:datepicker id="adjustmentInApproval.createdDate" name="adjustmentInApproval.createdDate"  title=" " required="true" cssClass="required" showOn="false" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" readonly="true"></sj:datepicker>
                        <s:textfield id="adjustmentInApproval.createdDateTemp" name="adjustmentInApproval.createdDateTemp " size="5"></s:textfield>
                        <s:textfield id="adjustmentInApproval.updatedBy" name="adjustmentInApproval.updatedBy" size="30" readonly="true"></s:textfield>
                        <sj:datepicker id="adjustmentInApproval.updatedDate" name="adjustmentInApproval.updatedDate"  title=" " required="true" cssClass="required" showOn="false" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="25" readonly="true"></sj:datepicker>
                        <s:textfield id="adjustmentInApproval.updatedDateTemp" name="adjustmentInApproval.updatedDateTemp " size="5"></s:textfield>
                    </td>
                </tr>
            </table>
        
            <br class="spacer" />

            <div id="adjustmentInApprovalItemDetailInputGrid">
                <sjg:grid
                    id="adjustmentInApprovalItemDetailInput_grid"
                    caption="Adjustment In Item Detail"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listAdjustmentInApproval"
                    rowList="10,20,30"
                    rowNum="10000"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    editurl="%{remotedetailurlAdjustmentInApprovalItemDetailInput}"
                    width="$('#tabmnuAdjustmentInApproval').width()"
                    onSelectRowTopics="adjustmentInApprovalItemDetailInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailCode" index = "adjustmentInApprovalItemDetailCode" key = "adjustmentInApprovalItemDetailCode" 
                    title = "Code" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailItemMaterialCode" index = "adjustmentInApprovalItemDetailItemMaterialCode" key = "adjustmentInApprovalItemDetailItemMaterialCode" 
                    title = "Item Code *" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailItemMaterialName" index = "adjustmentInApprovalItemDetailItemMaterialName" key = "adjustmentInApprovalItemDetailItemMaterialName" 
                    title = "Item Name" width = "250"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailItemMaterialSerialNoStatus" index = "adjustmentInApprovalItemDetailItemMaterialSerialNoStatus" key = "adjustmentInApprovalItemDetailItemMaterialSerialNoStatus" 
                    title = "SerialNo Status" width = "90"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailReasonCode" index = "adjustmentInApprovalItemDetailReasonCode" key = "adjustmentInApprovalItemDetailReasonCode" 
                    title = "Reason Code" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailReasonName" index = "adjustmentInApprovalItemDetailReasonName" key = "adjustmentInApprovalItemDetailReasonName" 
                    title = "Reason Name" width = "250"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalItemDetailQuantity" index="adjustmentInApprovalItemDetailQuantity" key="adjustmentInApprovalItemDetailQuantity" 
                    title="Quantity *" width="80" align="right" edittype="text" editable="false"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailItemMaterialUnitOfMeasureCode" index = "adjustmentInApprovalItemDetailItemMaterialUnitOfMeasureCode" key = "adjustmentInApprovalItemDetailItemMaterialUnitOfMeasureCode" 
                    title = "Unit" width = "100"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalItemDetailPrice" index="adjustmentInApprovalItemDetailPrice" key="adjustmentInApprovalItemDetailPrice" 
                    title="Price *" width="100" align="right" edittype="text" editable="true"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                    editoptions="{onChange:'calculateInventoryInApprovalItemDetail()',onKeyUp:'calculateInventoryInApprovalItemDetail()'}"
                />
                 <sjg:gridColumn
                    name="adjustmentInApprovalItemDetailTotalAmount" index="adjustmentInApprovalItemDetailTotalAmount" key="adjustmentInApprovalItemDetailTotalAmount" 
                    title="Total *" width="150" align="right" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailRemark" index="adjustmentInApprovalItemDetailRemark" key="adjustmentInApprovalItemDetailRemark" title="Remark" width="200"  editable="false" edittype="text"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailRackCode" index = "adjustmentInApprovalItemDetailRackCode" key = "adjustmentInApprovalItemDetailRackCode" 
                    title = "Rack Code" width = "150" edittype="text"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalItemDetailRackName" index = "adjustmentInApprovalItemDetailRackName" key = "adjustmentInApprovalItemDetailRackName" 
                    title = "Rack Name" width = "250"
                />
                </sjg:grid >
            </div>
        </div>
        
        <br class="spacer" />
    
        <div id="adjustmentInApprovalSerialNoDetailInputGrid">
            <sjg:grid
                id="adjustmentInApprovalSerialNoDetailInput_grid"
                caption="Adjustment In Serial No Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listAdjustmentInApprovalSerialNoDetailTemp"
                viewrecords="true"
                rownumbers="true"
                rowNum="10000"
                shrinkToFit="false"
                editinline="true"
                editurl="%{remotedetailurlAdjustmentInApprovalSerialNoItemDetailInput}"
                width="$('#tabmnuadjustmentin').width()"
                onSelectRowTopics="adjustmentInApprovalSerialNoItemDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailCode" index="adjustmentInApprovalSerialNoDetailCode" key="adjustmentInApprovalSerialNoDetailCode" 
                    title="Code" width="100" edittype="text" hidden="true"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailHeaderCode" index="adjustmentInApprovalSerialNoDetailHeaderCode" key="adjustmentInApprovalSerialNoDetailHeaderCode" 
                    title="Header Code" width="150" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailItemMaterialCode" index="adjustmentInApprovalSerialNoDetailItemMaterialCode" key="adjustmentInApprovalSerialNoDetailItemMaterialCode" 
                    title="Item Code" width="130" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailItemMaterialName" index="adjustmentInApprovalSerialNoDetailItemMaterialName" key="adjustmentInApprovalSerialNoDetailItemMaterialName" 
                    title="Item Name" width="300" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailSerialNo" index="adjustmentInApprovalSerialNoDetailSerialNo" key="adjustmentInApprovalSerialNoDetailSerialNo" 
                    title="Serial No" width="80" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailCapacity" index="adjustmentInApprovalSerialNoDetailCapacity" key="adjustmentInApprovalSerialNoDetailCapacity" 
                    title="Capacity" width="80" align="right" edittype="text" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name = "adjustmentInApprovalSerialNoDetailItemMaterialUnitOfMeasureCode" index = "adjustmentInApprovalSerialNoDetailItemMaterialUnitOfMeasureCode" key = "adjustmentInApprovalSerialNoDetailItemMaterialUnitOfMeasureCode"
                    title = "UOM" width = "100" edittype="text"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailPrice" index="adjustmentInApprovalSerialNoDetailPrice" key="adjustmentInApprovalSerialNoDetailPrice" 
                    title="Price" width="100" align="right" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailRemark" index="adjustmentInApprovalSerialNoDetailRemark" key="adjustmentInApprovalSerialNoDetailRemark" 
                    title="Remark" width="200"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailRackCode" index="adjustmentInApprovalSerialNoDetailRackCode" key="adjustmentInApprovalSerialNoDetailRackCode" 
                    title="Rack Code" width="100"
                />
                <sjg:gridColumn
                    name="adjustmentInApprovalSerialNoDetailRackName" index="adjustmentInApprovalSerialNoDetailRackName" key="adjustmentInApprovalSerialNoDetailRackName" 
                    title="Rack Name" width="100"
                />
            </sjg:grid >
        </div>   
        <table>
            <tr>
                <td>
                </td>
                <td align="right"><B>Foreign</B></td>
                <td align="right"><B>IDR</B></td>
            </tr>
            <tr>
                <td align="right"><B>Grand Total</B></td>
		<td>
                    <s:textfield 
                    id="adjustmentInApproval.grandTotalAmount" name="adjustmentInApproval.grandTotalAmount" readonly="true" cssStyle="text-align:right;width:100%"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}" ></s:textfield>
                </td>
		<td>
                    <s:textfield 
                    id="adjustmentInApprovalGrandTotalAmountIDR" name="adjustmentInApprovalGrandTotalAmountIDR" readonly="true" cssStyle="text-align:right;width:100%"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"></s:textfield>
                 </td>
             </tr>
        </table>
        <br class="spacer" />
        <table width="100%">
            <tr>
                <td>      
                    <sj:a href="#" id="btnAdjustmentInApprovalSave" button="true">Approve</sj:a>
                    <sj:a href="#" id="btnAdjustmentInApprovalCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        
    </s:form>
</div>