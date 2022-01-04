<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
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
     var purchaseOrderUpdateInformationDetailViewlastSel = -1,
         purchaseOrderUpdateInformationDetailViewlastRowId = 0,
         purchaseOrderUpdateInformationPurchaseRequestlastSel = -1,
         purchaseOrderUpdateInformationPurchaseRequestRowId = 0,
         purchaseOrderUpdateInformationPRNonIMRlastSel = -1,
         purchaseOrderUpdateInformationPRNonIMRRowId = 0,
         purchaseOrderUpdateInformationDetailViewRowId = 0,
         purchaseOrderUpdateInformationDetailViewlastsel = -1,
         purchaseOrderUpdateInformationDetailInputRowId = 0,
         purchaseOrderUpdateInformationDetailInputlastSel = -1,
         purchaseOrderUpdateInformationDetailViewAdditionalRowId = 0,
         purchaseOrderUpdateInformationDetailViewAdditionallastsel = -1,
         purchaseOrderUpdateInformationDetailViewItemDeliveryRowId = 0,
         purchaseOrderUpdateInformationDetailViewItemDeliverylastsel = -1;
    
    var 
        txtPurchaseOrderUpdateInformationTotalTransactionAmount = $("#purchaseOrderUpdateInformation\\.totalTransactionAmount"),
        txtPurchaseOrderUpdateInformationDiscountPercent = $("#purchaseOrderUpdateInformation\\.discountPercent"),
        txtPurchaseOrderUpdateInformationDiscountAmount = $("#purchaseOrderUpdateInformation\\.discountAmount"),
        txtPurchaseOrderUpdateInformationDiscountAccountCode = $("#purchaseOrderUpdateInformation\\.discountChartOfAccount\\.code"),
        txtPurchaseOrderUpdateInformationDiscountAccountName = $("#purchaseOrderUpdateInformation\\.discountChartOfAccount\\.name"),
        txtPurchaseOrderUpdateInformationTaxBaseSubTotalAmount = $("#purchaseOrderUpdateInformation\\.taxBaseSubTotalAmount"),
        txtPurchaseOrderUpdateInformationVATPercent = $("#purchaseOrderUpdateInformation\\.vatPercent"),
        txtPurchaseOrderUpdateInformationVATAmount = $("#purchaseOrderUpdateInformation\\.vatAmount"),
        txtPurchaseOrderUpdateInformationOtherFeeAmount = $("#purchaseOrderUpdateInformation\\.otherFeeAmount"),
        txtPurchaseOrderUpdateInformationOtherFeeAccountCode = $("#purchaseOrderUpdateInformation\\.otherFeeChartOfAccount\\.code"),
        txtPurchaseOrderUpdateInformationOtherFeeAccountName = $("#purchaseOrderUpdateInformation\\.otherFeeChartOfAccount\\.name"),
        txtPurchaseOrderUpdateInformationGrandTotalAmount = $("#purchaseOrderUpdateInformation\\.grandTotalAmount");
        
    $(document).ready(function() {
        hoverButton();
        
        formatNumericPOUpdateInformation();
        loadImportLocalUpdateInformation($("#purchaseOrderUpdateInformation\\.vendor\\.localImport").val());
        if ($("#purchaseOrderUpdateInformation\\.penaltyStatus").val() === "true"){
            $('#purchaseOrderUpdateInformationPenaltyStatusRadYES').prop('checked',true);
            enabledDisabledPenaltyPercentUpdateInformation('YES');
        }else{
            $('#purchaseOrderUpdateInformationPenaltyStatusRadNO').prop('checked',true);
            enabledDisabledPenaltyPercentUpdateInformation('NO');
        }
            loadPurchaseRequestDetailUpdateInformation();
            loadPurchaseOrderUpdateInformationPR();
            loadPODetailUpdateInformation();
            loadPOUpdateInformationAdditionalFee();
            loadItemDeliveryDateUpdateInformation();
            
        $.subscribe("purchaseOrderUpdateInformationDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==purchaseOrderUpdateInformationDetailInputlastSel) {
                $('#purchaseOrderUpdateInformationDetailInput_grid').jqGrid("saveRow",purchaseOrderUpdateInformationDetailInputlastSel); 
                $('#purchaseOrderUpdateInformationDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseOrderUpdateInformationDetailInputlastSel=selectedRowID;
            }
            else{
                $('#purchaseOrderUpdateInformationDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $.subscribe("purchaseOrderUpdateInformationItemDeliveryInput_grid_onSelect", function() {
            
            var selectedRowID = $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==purchaseOrderUpdateInformationDetailViewItemDeliverylastsel) {
                $('#purchaseOrderUpdateInformationItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderUpdateInformationDetailViewItemDeliverylastsel); 
                $('#purchaseOrderUpdateInformationItemDeliveryInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseOrderUpdateInformationDetailViewItemDeliverylastsel=selectedRowID;
            }
            else{
                $('#purchaseOrderUpdateInformationItemDeliveryInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
            
        $('#btnPurchaseOrderUpdateInformationSave').click(function(ev) {
            if(purchaseOrderUpdateInformationDetailInputlastSel !== -1) {
                $('#purchaseOrderUpdateInformationDetailInput_grid').jqGrid("saveRow",purchaseOrderUpdateInformationDetailInputlastSel); 
            }
            
            if(purchaseOrderUpdateInformationDetailViewItemDeliverylastsel !== -1) {
                $('#purchaseOrderUpdateInformationItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderUpdateInformationDetailViewItemDeliverylastsel); 
            }
            
            var listPurchaseOrderDetail = new Array();
            var idj = jQuery("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('getDataIDs');

            if(idj.length===0){
                alertEx("Data detail can not empty..!!! ");
                $("#dlgLoading").dialog("close");
                validationCommaUpdateInformation();
                return;
            }

            for(var j=0;j<idj.length;j++){
                var data = $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('getRowData',idj[j]);

                var purchaseOrderDetail = {
                    code                            : data.purchaseOrderUpdateInformationDetailViewCode,
                    purchaseRequestCode             : data.purchaseOrderUpdateInformationDetailViewPurchaseRequestCode,
                    purchaseRequestDetailCode       : data.purchaseOrderUpdateInformationDetailViewPurchaseRequestDetailCode,
                    itemMaterial                    : { code : data.purchaseOrderUpdateInformationDetailViewItemMaterialCode},
                    itemAlias                       : data.purchaseOrderUpdateInformationDetailViewItemAlias,
                    remark                          : data.purchaseOrderUpdateInformationDetailViewRemark,
                    quantity                        : data.purchaseOrderUpdateInformationDetailViewQuantity,
                    price                           : data.purchaseOrderUpdateInformationDetailViewPrice,
                    discountPercent                 : data.purchaseOrderUpdateInformationDetailViewDiscPercent,
                    discountAmount                  : data.purchaseOrderUpdateInformationDetailViewDiscAmount,
                    nettPrice                       : data.purchaseOrderUpdateInformationDetailViewNettPrice,
                    totalAmount                     : data.purchaseOrderUpdateInformationDetailViewTotalPrice
                };
                listPurchaseOrderDetail[j] = purchaseOrderDetail;
            }
            
            var idp = jQuery("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('getDataIDs');
            var listPurchaseOrderUpdateInformationDetail = new Array();
            if(idp.length === 0){
                alertEx("Data detail can not empty..!!! ");
                $("#dlgLoading").dialog("close");
                validationCommaUpdateInformation();
                return;
            }
            
            for(var i = 0; i<idp.length; i++){
                var data = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('getRowData',idp[i]);

                var purchaseOrderUpdateInformationDetail = {
                    purchaseRequestCode             : data.purchaseOrderUpdateInformationDetailInputPurchaseRequestCode,
                    purchaseRequestDetailCode       : data.purchaseOrderUpdateInformationDetailInputPurchaseRequestDetailCode,
                    itemMaterial                    : {code : data.purchaseOrderUpdateInformationDetailInputItemMaterialCode},
                    itemAlias                       : data.purchaseOrderUpdateInformationDetailInputItemAlias,
                    remark                          : data.purchaseOrderUpdateInformationDetailInputRemark,
                    quantity                        : data.purchaseOrderUpdateInformationDetailInputQuantity,
                    price                           : data.purchaseOrderUpdateInformationDetailInputPrice,
                    discountPercent                 : data.purchaseOrderUpdateInformationDetailInputDiscPercent,
                    discountAmount                  : data.purchaseOrderUpdateInformationDetailInputDiscAmount,
                    nettPrice                       : data.purchaseOrderUpdateInformationDetailInputNettPrice,
                    totalAmount                     : data.purchaseOrderUpdateInformationDetailInputTotalPrice
                };
                
                listPurchaseOrderUpdateInformationDetail[i] = purchaseOrderUpdateInformationDetail;
            }
            
            var listPurchaseOrderUpdateInformationItemDeliveryDate = new Array();
            var idm = jQuery("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('getDataIDs');

            if(idm.length===0){
                alertEx("Data detail can not empty..!!! ");
                $("#dlgLoading").dialog("close");
                validationCommaUpdateInformation();
                return;
            }

            for(var m=0;m < idm.length;m++){
                var data = $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('getRowData',idm[m]);

                var deliveryDate = data.purchaseOrderUpdateInformationItemDeliveryDeliveryDate.split('/');
                var deliveryDateNew = deliveryDate[1]+"/"+deliveryDate[0]+"/"+deliveryDate[2];
                
                var purchaseOrderItemDeliveryDate = {
                    itemMaterial            : {code : data.purchaseOrderUpdateInformationItemDeliveryItemMaterialCode},
                    quantity                : data.purchaseOrderUpdateInformationItemDeliveryQuantity,
                    deliveryDate            : deliveryDateNew
                };
                listPurchaseOrderUpdateInformationItemDeliveryDate[m] = purchaseOrderItemDeliveryDate;
            }

            unFormatNumericPOUpdateInformation();
            validationCommaUpdateInformation();
            var url="purchasing/purchase-order-update-information-save";
            var params = $("#frmPurchaseOrderUpdateInformationInput").serialize();
            params += "&listPurchaseOrderUpdateInformationDetailViewJSON=" + $.toJSON(listPurchaseOrderDetail);
            params += "&listPurchaseOrderUpdateInformationDetailInputJSON=" + $.toJSON(listPurchaseOrderUpdateInformationDetail);
            params += "&listPurchaseOrderUpdateInformationItemDeliveryDateJSON=" + $.toJSON(listPurchaseOrderUpdateInformationItemDeliveryDate);

            $.post(url, params, function(data){
            closeLoading();
            if (data.error) {
                unFormatNumericPOUpdateInformation();
                alertMessage(data.errorMessage,500);
                return;
            }

            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
            dynamicDialog.dialog({
                title        : "Confirmation:",
                closeOnEscape: false,
                modal        : true,
                width        : 500,
                resizable    : false,
                closeText    : "hide",
                buttons      : 
                            [{
                                text : "Yes",
                                click : function() {
                                    $(this).dialog("close");
                                    var url = "purchasing/purchase-order-update-information";
                                    pageLoad(url, params, "#tabmnuPURCHASE_ORDER_UPDATE_INFORMATION");
                                }
                                
                            }]
                });
            });
            
        });
        
        $('#btnPurchaseOrderUpdateInformationCancel').click(function(ev) {
            var url = "purchasing/purchase-order-update-information";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER_UPDATE_INFORMATION"); 
        });
        
        $('#btnPurchaseOrderUpdateInformationItemDetail').click(function(ev) {
            let vendor = $("#purchaseOrderUpdateInformation\\.vendor\\.code").val();
            window.open("./pages/search/search-item-material-vendor.jsp?iddoc=purchaseOrderUpdateInformation&type=grid&vendorCode="+vendor+"&rowLast="+purchaseOrderUpdateInformationDetailViewRowId,"Search", "width=600, height=500");   
        });
        
        $('#btnPurchaseOrderUpdateInformationItemDelieryAdd').click(function(ev) {
            
            var AddRowCount =parseInt(removeCommas($("#purchaseOrderUpdateInformationItemDeliveryAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    purchaseOrderUpdateInformationItemDeliveryDelete                 : "delete",
                    purchaseOrderUpdateInformationItemDeliverySearchItemMaterial     : "..."
                };
                purchaseOrderUpdateInformationDetailViewItemDeliveryRowId++;
                $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderUpdateInformationDetailViewItemDeliveryRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderUpdateInformationDetailViewItemDeliveryRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
    });
    
    function addRowDataMultiSelectedItemPoUpdateInformationDetail(lastRowId,defRow){
        
        purchaseOrderUpdateInformationDetailInputRowId = lastRowId;
        
            $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('setRowData',lastRowId,{
                purchaseOrderUpdateInformationDetailInputDelete               : defRow.purchaseOrderUpdateInformationDetailInputDelete,
                purchaseOrderUpdateInformationDetailInputItemMaterialCode     : defRow.purchaseOrderUpdateInformationDetailInputItemMaterialCode,
                purchaseOrderUpdateInformationDetailInputItemMaterialName     : defRow.purchaseOrderUpdateInformationDetailInputItemMaterialName,
                purchaseOrderUpdateInformationDetailInputUnitOfMeasureCode    : defRow.purchaseOrderUpdateInformationDetailInputUnitOfMeasureCode,
                purchaseOrderUpdateInformationDetailInputUnitOfMeasureName    : defRow.purchaseOrderUpdateInformationDetailInputUnitOfMeasureName 
            });
    }

    function loadImportLocalUpdateInformation(localImport){
        if (localImport==='LOCAL'){
             $('#purchaseOrderUpdateInformationVendorLocalImportStatusRadLocal').prop('checked',true);
             $('#purchaseOrderUpdateInformationVendorLocalImportStatusRadImport').prop('disabled',true);
             $("#purchaseOrderUpdateInformation\\.vendor\\.localImport").val("LOCAL");
        }
        else{
            $('#purchaseOrderUpdateInformationVendorLocalImportStatusRadImport').prop('checked',true);
            $('#purchaseOrderUpdateInformationVendorLocalImportStatusRadLocal').prop('disabled',true);
            $("#purchaseOrderUpdateInformation\\.vendor\\.localImport").val("IMPORT");
        }
    }
    
    function enabledDisabledPenaltyPercentUpdateInformation(percentType){
        switch(percentType){
            case "YES":   
                $("#purchaseOrderUpdateInformation\\.penaltyPercent").attr('readonly',true);
                $('#purchaseOrderUpdateInformationPenaltyStatusRadYES').prop('checked',true);
                $("#purchaseOrderUpdateInformationPenaltyStatusRadNO").prop('disabled',true);
                $("#purchaseOrderUpdateInformation\\.penaltyPercent").focus();
                $("#purchaseOrderUpdateInformation\\.maximumPenaltyPercent").attr('readonly',true);
                
                var maximumPenaltyPercent = $("#purchaseOrderUpdateInformation\\.maximumPenaltyPercent").val();
                maximumPenaltyPercent = parseFloat(maximumPenaltyPercent);
                var penaltyPercent = $("#purchaseOrderUpdateInformation\\.penaltyPercent").val();
                penaltyPercent = parseFloat(penaltyPercent);
                
                $("#purchaseOrderUpdateInformation\\.maximumPenaltyPercent").val(formatNumber(maximumPenaltyPercent,2));
                $("#purchaseOrderUpdateInformation\\.penaltyPercent").val(formatNumber(penaltyPercent,2));
                
                break;
            case "NO":
                $("#purchaseOrderUpdateInformation\\.penaltyPercent").attr('readonly',true);
                $('#purchaseOrderUpdateInformationPenaltyStatusRadNO').prop('checked',true);
                $("#purchaseOrderUpdateInformationPenaltyStatusRadYES").prop('disabled',true);
                $("#purchaseOrderUpdateInformation\\.penaltyPercent").focus();
                $("#purchaseOrderUpdateInformation\\.maximumPenaltyPercent").attr('readonly',true);
                $("#purchaseOrderUpdateInformation\\.maximumPenaltyPercent").val("0.00");
                $("#purchaseOrderUpdateInformation\\.penaltyPercent").val("0.00");
                break;
        }
    }
    
    function loadPurchaseRequestDetailUpdateInformation(){   
        
        var url = "purchase/purchase-order-purchase-request-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderUpdateInformation\\.code").val();   
        
        purchaseOrderUpdateInformationPurchaseRequestRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderPurchaseRequestDetail.length; i++) {
                purchaseOrderUpdateInformationPurchaseRequestRowId++;
                var purchaseRequestTransactionDate=formatDateRemoveT(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestTransactionDate, true);
                
                $("#purchaseOrderUpdateInformationPurchaseRequestDetailInput_grid").jqGrid("addRowData", purchaseOrderUpdateInformationPurchaseRequestRowId, data.listPurchaseOrderPurchaseRequestDetail[i]);
                $("#purchaseOrderUpdateInformationPurchaseRequestDetailInput_grid").jqGrid('setRowData',purchaseOrderUpdateInformationPurchaseRequestRowId,{
                    purchaseOrderUpdateInformationPurchaseRequestDetailCode                      : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode,
                    purchaseOrderUpdateInformationPurchaseRequestDetailTransactionDate           : purchaseRequestTransactionDate,
                    purchaseOrderUpdateInformationPurchaseRequestDetailDocumentType              : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestType,
                    purchaseOrderUpdateInformationPurchaseRequestDetailProductionPlanningCode    : data.listPurchaseOrderPurchaseRequestDetail[i].ppoCode,
                    purchaseOrderUpdateInformationPurchaseRequestDetailBranchCode                : data.listPurchaseOrderPurchaseRequestDetail[i].branchCode,
                    purchaseOrderUpdateInformationPurchaseRequestDetailBranchName                : data.listPurchaseOrderPurchaseRequestDetail[i].branchName,
                    purchaseOrderUpdateInformationPurchaseRequestDetailRequestBy                 : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRequestBy,
                    purchaseOrderUpdateInformationPurchaseRequestDetailRemark                    : data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestRemark
  
                });
                
                loadPurchaseOrderUpdateInformationPR(data.listPurchaseOrderPurchaseRequestDetail[i].purchaseRequestCode);
            }
        });
        closeLoading();
    }
    
    function loadPurchaseOrderUpdateInformationPR(data){
        var arrPurchaseOrderUpdateInformationPRQNo=new Array();
            arrPurchaseOrderUpdateInformationPRQNo.push(data);
       
        var url = "purchasing/purchase-request-item-material-request-detail-data";
        var params = "arrPurchaseOrderNo=" + arrPurchaseOrderUpdateInformationPRQNo;
        
        purchaseOrderUpdateInformationPRNonIMRRowId = 0;
        $.getJSON(url, params, function(data) {
            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseOrderUpdateInformationPRNonIMRRowId++;
                $("#purchaseOrderUpdateInformationPurchaseRequestItemDetailInput_grid").jqGrid("addRowData", purchaseOrderUpdateInformationPRNonIMRRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseOrderUpdateInformationPurchaseRequestItemDetailInput_grid").jqGrid('setRowData',purchaseOrderUpdateInformationPRNonIMRRowId,{
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestNo                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].headerCode,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestDetailNo           : data.listPurchaseRequestNonItemMaterialRequestDetail[i].code,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialCode   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialName   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailQuantity                          : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailUnitOfMeasureCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailUnitOfMeasureName                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseOrderCode                 : data.listPurchaseRequestNonItemMaterialRequestDetail[i].poCode,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailItemJnVendorCode                  : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialJnVendor,
                    purchaseOrderUpdateInformationPurchaseRequestItemDetailVendorCode                        : data.listPurchaseRequestNonItemMaterialRequestDetail[i].vendorCode
                });
            }
            
        }); 
    }
    
    function loadPODetailUpdateInformation(){            
        var url = "purchase/purchase-order-detail-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderUpdateInformation\\.code").val();   
        
        purchaseOrderUpdateInformationDetailViewRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderDetail.length; i++) {
                purchaseOrderUpdateInformationDetailViewRowId++;
                
                $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid("addRowData", purchaseOrderUpdateInformationDetailViewRowId, data.listPurchaseOrderDetail[i]);
                $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('setRowData', purchaseOrderUpdateInformationDetailViewRowId,{
                    purchaseOrderUpdateInformationDetailViewPurchaseRequestDetailCode        : data.listPurchaseOrderDetail[i].purchaseRequestDetailCode,
                    purchaseOrderUpdateInformationDetailViewPurchaseRequestCode              : data.listPurchaseOrderDetail[i].purchaseRequestCode,
                    purchaseOrderUpdateInformationDetailViewCode                             : data.listPurchaseOrderDetail[i].code,
                    purchaseOrderUpdateInformationDetailViewItemMaterialCode                 : data.listPurchaseOrderDetail[i].itemMaterialCode,
                    purchaseOrderUpdateInformationDetailViewItemMaterialName                 : data.listPurchaseOrderDetail[i].itemMaterialName,
                    purchaseOrderUpdateInformationDetailViewItemAlias                        : data.listPurchaseOrderDetail[i].itemAlias,
                    purchaseOrderUpdateInformationDetailViewRemark                           : data.listPurchaseOrderDetail[i].remark,
                    purchaseOrderUpdateInformationDetailViewQuantity                         : data.listPurchaseOrderDetail[i].quantity,
                    purchaseOrderUpdateInformationDetailViewUnitOfMeasureCode                : data.listPurchaseOrderDetail[i].unitOfMeasureCode,
                    purchaseOrderUpdateInformationDetailViewUnitOfMeasureName                : data.listPurchaseOrderDetail[i].unitOfMeasureName,
                    purchaseOrderUpdateInformationDetailViewPrice                            : data.listPurchaseOrderDetail[i].price,
                    purchaseOrderUpdateInformationDetailViewDiscPercent                      : data.listPurchaseOrderDetail[i].discountPercent,
                    purchaseOrderUpdateInformationDetailViewDiscAmount                       : data.listPurchaseOrderDetail[i].discountAmount,
                    purchaseOrderUpdateInformationDetailViewNettPrice                        : data.listPurchaseOrderDetail[i].nettPrice,
                    purchaseOrderUpdateInformationDetailViewTotalPrice                       : data.listPurchaseOrderDetail[i].totalAmount
  
                });
            }
        });
        closeLoading();
    }
    
    function loadPOUpdateInformationAdditionalFee(){
        var url = "purchase/purchase-order-additional-fee-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderUpdateInformation\\.code").val();   
        
        purchaseOrderUpdateInformationDetailViewAdditionalRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderAdditionalFee.length; i++) {
                purchaseOrderUpdateInformationDetailViewAdditionalRowId++;
                
                $("#purchaseOrderUpdateInformationAdditionalFeeInput_grid").jqGrid("addRowData", purchaseOrderUpdateInformationDetailViewAdditionalRowId, data.listPurchaseOrderAdditionalFee[i]);
                $("#purchaseOrderUpdateInformationAdditionalFeeInput_grid").jqGrid('setRowData',purchaseOrderUpdateInformationDetailViewAdditionalRowId,{
                    purchaseOrderUpdateInformationDetailViewAdditionalFeeCode                    : data.listPurchaseOrderAdditionalFee[i].code,
                    purchaseOrderUpdateInformationAdditionalFeeCode                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeCode,
                    purchaseOrderUpdateInformationAdditionalFeeName                          : data.listPurchaseOrderAdditionalFee[i].additionalFeeName,
                    purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountCode    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountCode,
                    purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountName    : data.listPurchaseOrderAdditionalFee[i].purchaseChartOfAccountName,
                    purchaseOrderUpdateInformationAdditionalFeeRemark                        : data.listPurchaseOrderAdditionalFee[i].remark,
                    purchaseOrderUpdateInformationAdditionalFeeQuantity                      : data.listPurchaseOrderAdditionalFee[i].quantity,
                    purchaseOrderUpdateInformationAdditionalFeeUnitOfMeasureCode             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureCode,
                    purchaseOrderUpdateInformationAdditionalFeeUnitOfMeasureName             : data.listPurchaseOrderAdditionalFee[i].unitOfMeasureName,
                    purchaseOrderUpdateInformationAdditionalFeePrice                         : data.listPurchaseOrderAdditionalFee[i].price,
                    purchaseOrderUpdateInformationAdditionalFeeTotal                         : data.listPurchaseOrderAdditionalFee[i].total
  
                });
            }
        });
        closeLoading();
    }
    
    function loadItemDeliveryDateUpdateInformation(){
         if($("#enumPurchaseOrderUpdateInformationActivity").val()==="NEW"){
            return;
        }                
        
        var url = "purchase/purchase-order-item-delivery-date-data";
        var params = "purchaseOrder.code="+$("#purchaseOrderUpdateInformation\\.code").val();   
        
        purchaseOrderUpdateInformationDetailViewItemDeliveryRowId=0;
        showLoading();
        $.post(url, params, function(data) {
            
            for (var i=0; i<data.listPurchaseOrderItemDeliveryDate.length; i++) {
                purchaseOrderUpdateInformationDetailViewItemDeliveryRowId++;
                var deliveryDate=formatDateRemoveT(data.listPurchaseOrderItemDeliveryDate[i].deliveryDate, false);
                $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid("addRowData", purchaseOrderUpdateInformationDetailViewItemDeliveryRowId, data.listPurchaseOrderItemDeliveryDate[i]);
                $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('setRowData',purchaseOrderUpdateInformationDetailViewItemDeliveryRowId,{
                    purchaseOrderUpdateInformationItemDeliveryItemMaterialCode               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialCode,
                    purchaseOrderUpdateInformationItemDeliveryItemMaterialName               : data.listPurchaseOrderItemDeliveryDate[i].itemMaterialName,
                    purchaseOrderUpdateInformationItemDeliveryQuantity                       : data.listPurchaseOrderItemDeliveryDate[i].quantity,
                    purchaseOrderUpdateInformationItemDeliveryDeliveryDate                   : deliveryDate
  
                });
            }
        });
        closeLoading();
    }
    
    function calculatePurchaseOrderUpdateInformationDetailPercent() {
        
        var selectedRowID = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = purchaseOrderUpdateInformationDetailInputRowId;
        }
        
        let str = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputQuantity").val(); 
        let str2 = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputPrice").val(); 
        let str3 = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscPercent").val();  
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputQuantity").val("");
            return;
        }
        
        if (isNaN(str2)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputPrice").val("");
            return;
        }
        
        if (isNaN(str3)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscPercent").val("");
            return;
        }
        
        var qty = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputQuantity").val();
        var price = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputPrice").val();
        var discPercent = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscPercent").val();
        if (discPercent === 0){
            var nettAmount = parseFloat(qty) * parseFloat(price);
        }else{
            var discAmount = (parseFloat(price)*parseFloat(discPercent)/100); 

            var nettAmount = parseFloat(price) - parseFloat(discAmount);
            var amount = (parseFloat(qty) * parseFloat(nettAmount));
            
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscAmount").val(discAmount);
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscPercent").val(discPercent);
        }
        
        $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderUpdateInformationDetailInputNettPrice", nettAmount);
        $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderUpdateInformationDetailInputTotalPrice", amount);

        calculateHeaderUpdateInformation();
    }   
    function calculatePurchaseOrderUpdateInformationDetailAmount() {
        var selectedRowID = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = purchaseOrderUpdateInformationDetailInputRowId;
        }
        
        let str = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputQuantity").val(); 
        let str2 = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputPrice").val(); 
        let str3 = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscAmount").val(); 
        
        if (isNaN(str)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputQuantity").val("");
            return;
        }
        
        if (isNaN(str2)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputPrice").val("");
            return;
        }
        
        if (isNaN(str3)){
            alert('Your Sort Number contains characters.');
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscAmount").val("");
        }
        
        var qty = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputQuantity").val();
        var price = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputPrice").val();
        var discAmount = $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscAmount").val();
        
        if(discAmount === 0){
            var nettAmount = parseFloat(qty) * parseFloat(price);
        }else{
            
            var nettAmount = parseFloat(price) - parseFloat(discAmount);
            var amount = (parseFloat(qty) * parseFloat(nettAmount));
            var discPercent=(parseFloat(discAmount)/parseFloat(price))*100;
            
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscAmount").val(discAmount);
            $("#" + selectedRowID + "_purchaseOrderUpdateInformationDetailInputDiscPercent").val(discPercent);
        }
        $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderUpdateInformationDetailInputNettPrice", nettAmount);
        $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid("setCell", selectedRowID, "purchaseOrderUpdateInformationDetailInputTotalPrice", amount);

        calculateHeaderUpdateInformation();
    }   
    
    function calculateHeaderUpdateInformation() {
        var totalTransactionPOD = 0;
        var totalTransactionPODView = 0;
        var totalTransactionAdditional = 0;
        var idk = jQuery("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('getDataIDs');
            for(var k=0;k < idk.length;k++) {
                var data_ku = $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('getRowData',idk[k]);
                totalTransactionPODView += parseFloat(data_ku.purchaseOrderUpdateInformationDetailViewTotalPrice);
            }
            
        var ids = jQuery("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('getDataIDs');
            for(var i=0;i < ids.length;i++) {
                var data = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('getRowData',ids[i]);
                totalTransactionPOD += parseFloat(data.purchaseOrderUpdateInformationDetailInputTotalPrice);
            }

        var idj = jQuery("#purchaseOrderUpdateInformationAdditionalFeeInput_grid").jqGrid('getDataIDs');
            for(var j=0;j < idj.length;j++) {
                var data_add = $("#purchaseOrderUpdateInformationAdditionalFeeInput_grid").jqGrid('getRowData',idj[j]);
                totalTransactionAdditional += parseFloat(data_add.purchaseOrderUpdateInformationAdditionalFeeTotal);
            }

        var totalTransaction = totalTransactionPOD+totalTransactionAdditional+totalTransactionPODView;
            txtPurchaseOrderUpdateInformationTotalTransactionAmount.val(formatNumber(totalTransaction, 2));

        var amount = txtPurchaseOrderUpdateInformationTotalTransactionAmount.val().replace(/,/g, "");
        var disc = (amount*txtPurchaseOrderUpdateInformationDiscountPercent.val())/100;
        var otherFeeAmount=removeCommas(txtPurchaseOrderUpdateInformationOtherFeeAmount.val());
        var totalAmount = (amount-disc);
        var tax = (totalAmount*txtPurchaseOrderUpdateInformationVATPercent.val())/100;
        var grandTotal =(parseFloat(totalAmount)+parseFloat(tax)+ parseFloat(otherFeeAmount));

        txtPurchaseOrderUpdateInformationTaxBaseSubTotalAmount.val(formatNumber(totalAmount,2));
        txtPurchaseOrderUpdateInformationDiscountAmount.val(formatNumber(disc,2));
        txtPurchaseOrderUpdateInformationVATAmount.val(formatNumber(tax,2));           
        txtPurchaseOrderUpdateInformationGrandTotalAmount.val(formatNumber(grandTotal,2));
    }
    
    function clearAmountPurchaseOrderUpdateInformationHeader(){
        txtPurchaseOrderUpdateInformationTotalTransactionAmount.val("0.00");
        txtPurchaseOrderUpdateInformationDiscountPercent.val("0.00");
        txtPurchaseOrderUpdateInformationDiscountAmount.val("0.00");
        txtPurchaseOrderUpdateInformationTaxBaseSubTotalAmount.val("0.00");
        txtPurchaseOrderUpdateInformationVATPercent.val("0.00");
        txtPurchaseOrderUpdateInformationVATAmount.val("0.00");
        txtPurchaseOrderUpdateInformationOtherFeeAmount.val("0.00");
        txtPurchaseOrderUpdateInformationGrandTotalAmount.val("0.00");
    }
    
    function validationCommaUpdateInformation(){

        var totalTransaction = txtPurchaseOrderUpdateInformationTotalTransactionAmount.val().replace(/,/g, "");
        var discountAmount = txtPurchaseOrderUpdateInformationDiscountAmount.val().replace(/,/g, "");
        var taxBaseSubTotalAmount = txtPurchaseOrderUpdateInformationTaxBaseSubTotalAmount.val().replace(/,/g, "");
        var taxAmount = txtPurchaseOrderUpdateInformationVATAmount.val().replace(/,/g, "");
        var otherFee = txtPurchaseOrderUpdateInformationOtherFeeAmount.val().replace(/,/g, "");
        var grandTotal = txtPurchaseOrderUpdateInformationGrandTotalAmount.val().replace(/,/g, "");

        txtPurchaseOrderUpdateInformationTotalTransactionAmount.val(totalTransaction);
        txtPurchaseOrderUpdateInformationDiscountAmount.val(discountAmount);
        txtPurchaseOrderUpdateInformationVATAmount.val(taxAmount);
        txtPurchaseOrderUpdateInformationTaxBaseSubTotalAmount.val(taxBaseSubTotalAmount);
        txtPurchaseOrderUpdateInformationOtherFeeAmount.val(otherFee);
        txtPurchaseOrderUpdateInformationGrandTotalAmount.val(grandTotal);

    }
    
    function purchaseOrderUpdateInformationDetailViewDelete_OnClick(){
        
        var selectDetailRowId = $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('getGridParam','selrow');
        var purchaseOrder = $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('getRowData', selectDetailRowId);
        
        let url = "inventory/goods-received-note-check-item";
        let params = "poCode=" + $("#purchaseOrderUpdateInformation\\.code").val();
            params += "&podCode=" + purchaseOrder.purchaseOrderUpdateInformationDetailViewCode;
            params += "&itemMaterialCode=" + purchaseOrder.purchaseOrderUpdateInformationDetailViewItemMaterialCode;
        
        $.post(url, params, function(data) {
            if (data.error) {
                alertMessage(data.errorMessage);
                return;
            }
            $("#purchaseOrderUpdateInformationDetailViewInput_grid").jqGrid('delRowData',selectDetailRowId); 
        });
        calculateHeaderUpdateInformation();
    }
    
    function purchaseOrderUpdateInformationDetailInputDelete_OnClick(){
        var selectDetailRowId = $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        $("#purchaseOrderUpdateInformationDetailInput_grid").jqGrid('delRowData',selectDetailRowId);    
        calculateHeaderUpdateInformation();
   }
    
    function purchaseOrderUpdateInformationItemDeliveryInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('delRowData',selectDetailRowId);        
    }
    
    function purchaseOrderUpdateInformationItemDeliveryInputGrid_SearchItemMaterial_OnClick(){   
        if($("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('getDataIDs').length===0){
            {alertMessage("Grid Item Delivery Date Can't Be Empty!");
            return;}

        }

        if(purchaseOrderUpdateInformationDetailViewItemDeliverylastsel !== -1) {
            $('#purchaseOrderUpdateInformationItemDeliveryInput_grid').jqGrid("saveRow",purchaseOrderUpdateInformationDetailViewItemDeliverylastsel);  
        }
            
        window.open("./pages/search/search-po-item-delivery.jsp?iddoc=purchaseOrderUpdateInformationItemDelivery&type=grid","Search", "scrollbars=1,width=600, height=500");
    }
    
    function unFormatNumericPOUpdateInformation(){ 
        var totalTransactionAmount = removeCommas($("#purchaseOrderUpdateInformation\\.totalTransactionAmount").val());
        var discountPercent = removeCommas($("#purchaseOrderUpdateInformation\\.discountPercent").val());
        var discountAmount = removeCommas($("#purchaseOrderUpdateInformation\\.discountAmount").val());
        var taxBaseSubTotalAmount = removeCommas($("#purchaseOrderUpdateInformation\\.taxBaseSubTotalAmount").val());
        var vatPercent = removeCommas($("#purchaseOrderUpdateInformation\\.vatPercent").val());
        var vatAmount = removeCommas($("#purchaseOrderUpdateInformation\\.vatAmount").val());
        var otherFee = removeCommas($("#purchaseOrderUpdateInformation\\.otherFeeAmount").val());
        var grandTotalAmount = removeCommas($("#purchaseOrderUpdateInformation\\.grandTotalAmount").val());

        $("#purchaseOrderUpdateInformation\\.totalTransactionAmount").val(totalTransactionAmount);
        $("#purchaseOrderUpdateInformation\\.discountPercent").val(discountPercent);
        $("#purchaseOrderUpdateInformation\\.discountAmount").val(discountAmount);
        $("#purchaseOrderUpdateInformation\\.taxBaseSubTotalAmount").val(taxBaseSubTotalAmount);
        $("#purchaseOrderUpdateInformation\\.vatPercent").val(vatPercent);
        $("#purchaseOrderUpdateInformation\\.vatAmount").val(vatAmount);
        $("#purchaseOrderUpdateInformation\\.otherFeeAmount").val(otherFee);
        $("#purchaseOrderUpdateInformation\\.grandTotalAmount").val(grandTotalAmount);
    }
    
    function alertEx(alert_message){
        var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 20px 20px 0;">'+
                        '</span>' +
                            '<table>' +
                                '<tr>' +
                                    '<td></td>'+
                                '</tr>' +
                            '</table>' +
                    '</div>');
            //Open Dialog
            dynamicDialog.dialog({
                title : "Attention:",
                closeOnEscape: false,
                modal : true,
                width: 250,
                resizable: false,
                closeText: "hide",
                buttons : 
                    [{
                        text : "OK",
                        click : function() {
                            $(this).dialog("close");
                        },
                        keyPress: function (){
                            $(this).dialog("close");
                        }
                    }]
            });
    }
    
    function onchangePurchaseOrderUpdateInformationItemDeliveryDeliveryDate(){
        
        var selectDetailRowId = $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid('getGridParam','selrow');
        var deliveryDate=$("#" + selectDetailRowId + "_purchaseOrderUpdateInformationItemDeliveryDeliveryDate").val();
        
        $("#purchaseOrderUpdateInformationItemDeliveryInput_grid").jqGrid("setCell", selectDetailRowId, "purchaseOrderUpdateInformationItemDeliveryDeliveryDateTemp",deliveryDate);
    }
    
    function formatNumericPOUpdateInformation(){
        var totalTransactionAmount =parseFloat($("#purchaseOrderUpdateInformation\\.totalTransactionAmount").val());
        $("#purchaseOrderUpdateInformation\\.totalTransactionAmount").val(formatNumber(totalTransactionAmount,2));
        var discountAmount =parseFloat($("#purchaseOrderUpdateInformation\\.discountAmount").val());
        $("#purchaseOrderUpdateInformation\\.discountAmount").val(formatNumber(discountAmount,2));
        var discountPercent =parseFloat($("#purchaseOrderUpdateInformation\\.discountPercent").val());
        $("#purchaseOrderUpdateInformation\\.discountPercent").val(formatNumber(discountPercent,2));
        var taxBaseAmount =parseFloat($("#purchaseOrderUpdateInformation\\.taxBaseSubTotalAmount").val());
        $("#purchaseOrderUpdateInformation\\.taxBaseSubTotalAmount").val(formatNumber(taxBaseAmount,2));
        var vatPercent =parseFloat($("#purchaseOrderUpdateInformation\\.vatPercent").val());
        $("#purchaseOrderUpdateInformation\\.vatPercent").val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat($("#purchaseOrderUpdateInformation\\.vatAmount").val());
        $("#purchaseOrderUpdateInformation\\.vatAmount").val(formatNumber(vatAmount,2));
        var otherFee =parseFloat($("#purchaseOrderUpdateInformation\\.otherFeeAmount").val());
        $("#purchaseOrderUpdateInformation\\.otherFeeAmount").val(formatNumber(otherFee,2));
        var grandTotalAmount =parseFloat($("#purchaseOrderUpdateInformation\\.grandTotalAmount").val());
        $("#purchaseOrderUpdateInformation\\.grandTotalAmount").val(formatNumber(grandTotalAmount,2));
    }  
    
</script>

<s:url id="remoteurlPurchaseOrderUpdateInformationDetailView" action="" />
<s:url id="remoteurlPurchaseOrderUpdateInformationDetailInput" action="" />
<s:url id="remoteurlPurchaseOrderUpdateInformationItemDeliveryInput" action="" />

<b>PURCHASE ORDER</b>
<hr>
<br class="spacer" />

<div id="purchaseOrderUpdateInformationInput" class="content ui-widget">
    <s:form id="frmPurchaseOrderUpdateInformationInput">
        <table cellpadding="2" cellspacing="2" id="headerPurchaseOrderUpdateInformationInput">
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>POD No *</B></td>
                            <td>
                                <s:textfield id="purchaseOrderUpdateInformation.code" name="purchaseOrderUpdateInformation.code" key="purchaseOrderUpdateInformation.code" readonly="true" size="25"></s:textfield>    
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Branch *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderUpdateInformation.branch.code" name="purchaseOrderUpdateInformation.branch.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderUpdateInformation.branch.name" name="purchaseOrderUpdateInformation.branch.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Transaction Date *</B></td>
                            <td>
                                <sj:datepicker id="purchaseOrderUpdateInformation.transactionDate" name="purchaseOrderUpdateInformation.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" onchange="POTransactionDateOnChange()" readonly = "true" disabled="true"></sj:datepicker>
                                <sj:datepicker id="purchaseOrderUpdateInformationTransactionDate" name="purchaseOrderUpdateInformationTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Delivery Date</td>
                            <td>
                                <sj:datepicker id="purchaseOrderUpdateInformation.deliveryDateStart" name="purchaseOrderUpdateInformation.deliveryDateStart" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true" disabled="true" readonly = "true"></sj:datepicker>
                                <s:textfield id="purchaseOrderUpdateInformation.deliveryDateStartTemp" name="purchaseOrderUpdateInformation.deliveryDateStartTemp" size="20" cssStyle="display:none"></s:textfield> 
                                <B>To *</B>
                                <sj:datepicker id="purchaseOrderUpdateInformation.deliveryDateEnd" name="purchaseOrderUpdateInformation.deliveryDateEnd" size="15" displayFormat="dd/mm/yy" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" changeMonth="true" changeYear="true" disabled="true" readonly = "true"></sj:datepicker>
                                <s:textfield id="purchaseOrderUpdateInformation.deliveryDateEndTemp" name="purchaseOrderUpdateInformation.deliveryDateEndTemp" size="20" cssStyle="display:none"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Payment Term *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderUpdateInformation.paymentTerm.code" name="purchaseOrderUpdateInformation.paymentTerm.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderUpdateInformation.paymentTerm.name" name="purchaseOrderUpdateInformation.paymentTerm.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Currency *</B></td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderUpdateInformation.currency.code" name="purchaseOrderUpdateInformation.currency.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderUpdateInformation.currency.name" name="purchaseOrderUpdateInformation.currency.name" size="20" readonly="true"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Vendor *</B></td>
                            <td>
                                <s:textfield  id="purchaseOrderUpdateInformation.vendor.code" name="purchaseOrderUpdateInformation.vendor.code" size="15" title=" " required="true" cssClass="required" readonly="true"></s:textfield>
                                <s:textfield id="purchaseOrderUpdateInformation.vendor.name" name="purchaseOrderUpdateInformation.vendor.name" size="20" readonly="true"></s:textfield>

                            </td>
                        </tr>
                        <tr>
                            <td align="right">Vendor Contact Person </td>
                            <td colspan="2">
                                <s:textfield id="purchaseOrderUpdateInformation.vendor.defaultContactPerson.code" name="purchaseOrderUpdateInformation.vendor.defaultContactPerson.code" size="20" readonly="true" cssStyle="display:none"></s:textfield>
                                <s:textfield id="purchaseOrderUpdateInformation.vendor.defaultContactPerson.name" name="purchaseOrderUpdateInformation.vendor.defaultContactPerson.name" size="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Local/Import </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderUpdateInformationVendorLocalImportStatusRad" name="purchaseOrderUpdateInformationVendorLocalImportStatusRad" label="purchaseOrderUpdateInformationVendorLocalImportStatusRad" list="{'Local','Import'}"></s:radio>
                                <s:textfield id="purchaseOrderUpdateInformation.vendor.localImport" name="purchaseOrderUpdateInformation.vendor.localImport" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Status </td>
                            <td colspan="2">
                                <s:radio id="purchaseOrderUpdateInformationPenaltyStatusRad" name="purchaseOrderUpdateInformationPenaltyStatusRad" label="purchaseOrderUpdateInformationPenaltyStatusRad" list="{'YES','NO'}"></s:radio>
                                <s:textfield id="purchaseOrderUpdateInformation.penaltyStatus" name="purchaseOrderUpdateInformation.penaltyStatus" size="20" style="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrderUpdateInformation.penaltyPercent" name="purchaseOrderUpdateInformation.penaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Maximum Penalty Percent</td>
                            <td>
                                <s:textfield id="purchaseOrderUpdateInformation.maximumPenaltyPercent" name="purchaseOrderUpdateInformation.maximumPenaltyPercent" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                        </tr>
                        <tr hidden="true">
                            <td align="right">Purchase Order Type </td>
                            <td colspan="2">
                            <s:textfield id="purchaseOrderUpdateInformation.purchaseOrderUpdateInformationType" name="purchaseOrderUpdateInformation.purchaseOrderUpdateInformationType" size="20" readonly="true" value="CPO-BO"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
                <td valign="top">
                <table>
                    <tr>
                        <td align = "right"><B>Bill To *</B></td>
                        <td colspan="2">
                            <s:textfield id="purchaseOrderUpdateInformation.billTo.code" name="purchaseOrderUpdateInformation.billTo.code" cssClass="required" required="true" title=" " cssStyle="width:78%" readonly="true"></s:textfield>
                            <s:textfield id="purchaseOrderUpdateInformation.billTo.name" name="purchaseOrderUpdateInformation.billTo.name" readonly="true" cssStyle="width:25%"></s:textfield>
                    </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrderUpdateInformation.billTo.address" name="purchaseOrderUpdateInformation.billTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrderUpdateInformation.billTo.contactPerson" name="purchaseOrderUpdateInformation.billTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrderUpdateInformation.billTo.phone1" name="purchaseOrderUpdateInformation.billTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right"><B>Ship To *</B></td>
                        <td colspan="2">
                            <s:textfield id="purchaseOrderUpdateInformation.shipTo.code" name="purchaseOrderUpdateInformation.shipTo.code" cssClass="required" required="true" title=" " cssStyle="width:78%" readonly="true"></s:textfield>
                            <s:textfield id="purchaseOrderUpdateInformation.shipTo.name" name="purchaseOrderUpdateInformation.shipTo.name" readonly="true" cssStyle="width:25%"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Address</td>
                        <td>
                        <s:textarea id="purchaseOrderUpdateInformation.shipTo.address" name="purchaseOrderUpdateInformation.shipTo.address" cols="43" rows="3" readonly="true"></s:textarea>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Contact Person</td>
                        <td><s:textfield id="purchaseOrderUpdateInformation.shipTo.contactPerson" name="purchaseOrderUpdateInformation.shipTo.contactPerson" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Phone 1</td>
                        <td><s:textfield id="purchaseOrderUpdateInformation.shipTo.phone1" name="purchaseOrderUpdateInformation.shipTo.phone1" readonly="true" cssStyle="width:25%"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right">Ref No</td>
                        <td colspan="3"><s:textfield id="purchaseOrderUpdateInformation.refNo" name="purchaseOrderUpdateInformation.refNo" size="27" readonly="true"></s:textfield></td>
                    </tr>
                    <tr>
                        <td align="right" valign="top">Remark</td>
                        <td colspan="3"><s:textarea id="purchaseOrderUpdateInformation.remark" name="purchaseOrderUpdateInformation.remark" cols="43" rows="3" height="20" readonly="true"></s:textarea></td>
                    </tr> 
                </table>
            </td>
        </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="purchaseOrderUpdateInformationDateFirstSession" name="purchaseOrderUpdateInformationDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="purchaseOrderUpdateInformationDateLastSession" name="purchaseOrderUpdateInformationDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumPurchaseOrderUpdateInformationActivity" name="enumPurchaseOrderUpdateInformationActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="purchaseOrderUpdateInformation.createdBy" name="purchaseOrderUpdateInformation.createdBy" key="purchaseOrderUpdateInformation.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="purchaseOrderUpdateInformation.createdDate" name="purchaseOrderUpdateInformation.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="purchaseOrderUpdateInformation.createdDateTemp" name="purchaseOrderUpdateInformation.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
    </table>
        
        <br class="spacer" />
        <div id="purchaseOrderUpdateInformationPurchaseRequestDetailInputGrid">
            <sjg:grid
                id="purchaseOrderUpdateInformationPurchaseRequestDetailInput_grid"
                caption="PRQ Detail"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listPurchaseOrderPurchaseRequestDetail"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="1200"
            >
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailCode" index="purchaseOrderUpdateInformationPurchaseRequestDetailCode" 
                    title="PRQ No *" width="200" sortable="true" 
                />     
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailTransactionDate" index="purchaseOrderUpdateInformationPurchaseRequestDetailTransactionDate" key="purchaseOrderUpdateInformationPurchaseRequestDetailTransactionDate" 
                    title="PRQ Date" width="130" formatter="date"  
                    formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailDocumentType" index="purchaseOrderUpdateInformationPurchaseRequestDetailDocumentType" 
                    title="Document Type" width="70" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailProductionPlanningCode" index="purchaseOrderUpdateInformationPurchaseRequestDetailProductionPlanningCode" 
                    title="PPO No" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailBranchCode" index="purchaseOrderUpdateInformationPurchaseRequestDetailBranchCode" 
                    title="Branch Code" width="100" sortable="true" 
                />
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailBranchName" index="purchaseOrderUpdateInformationPurchaseRequestDetailBranchName" 
                    title="Branch Name" width="200" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="purchaseOrderUpdateInformationPurchaseRequestDetailRequestBy" index="purchaseOrderUpdateInformationPurchaseRequestDetailRequestBy" 
                    title="Request By" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name = "purchaseOrderUpdateInformationPurchaseRequestDetailRemark" index = "purchaseOrderUpdateInformationPurchaseRequestDetailRemark" key = "purchaseOrderUpdateInformationPurchaseRequestDetailRemark" 
                    title = "Remark" width = "200" 
                />
            </sjg:grid >               
        </div>         
        <br>
        <br>
        
            <div id="purchaseOrderUpdateInformationPurchaseRequestItemDetailIMRInputGrid">
                <sjg:grid
                    id="purchaseOrderUpdateInformationPurchaseRequestItemDetailInput_grid"
                    caption="PRQ Item Detail "
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseRequestNonItemMaterialRequestDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="1100"
                >                   
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestNo" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestNo" key="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestNo" 
                        title="PRQ No" width="200" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestDetailNo" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestDetailNo" key="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestDetailNo" 
                        title="PRQ Detail" width="200" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" key="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialCode" 
                        title="Item Material Code" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialName" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialName" key="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseRequestItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailQuantity" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailQuantity" 
                        title="Quantity" width="100" sortable="true" formatter="number"
                    /> 
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailUnitOfMeasureCode" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailUnitOfMeasureCode" 
                        title="UOM" width="80" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailUnitOfMeasureName" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" hidden = "true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseOrderCode" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailPurchaseOrderCode" 
                        title="POD No" width="150" sortable="true" 
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailItemJnVendorCode" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailItemJnVendorCode" 
                        title="Item Jn Vendor" width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationPurchaseRequestItemDetailVendorCode" index="purchaseOrderUpdateInformationPurchaseRequestItemDetailVendorCode" 
                        title="Vendor" width="150" sortable="true" hidden="true"
                    />
                </sjg:grid>
            </div>
            <br>
            <br>
            
        <div id="purchaseOrderUpdateInformationDetailViewTable">    
            <div id="purchaseOrderUpdateInformationDetailView">
                <sjg:grid
                    id="purchaseOrderUpdateInformationDetailViewInput_grid"
                    caption="Purchase Order Detail View"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnupurchaseOrderUpdateInformationDetailView').width()"
                    editurl="%{remoteurlPurchaseOrderUpdateInformationDetailView}"
                    onSelectRowTopics="purchaseOrderUpdateInformationDetailViewInput_grid_onSelect"
                >          
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailView" index="purchaseOrderUpdateInformationDetailView" key="purchaseOrderUpdateInformationDetailView" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewCode" index="purchaseOrderUpdateInformationDetailViewCode" key="purchaseOrderUpdateInformationDetailViewCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true" 
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewPurchaseRequestCode" index="purchaseOrderUpdateInformationDetailViewPurchaseRequestCode" key="purchaseOrderUpdateInformationDetailViewPurchaseRequestCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true" 
                    />                 
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewPurchaseRequestDetailCode" index="purchaseOrderUpdateInformationDetailViewPurchaseRequestDetailCode" key="purchaseOrderUpdateInformationDetailViewPurchaseRequestDetailCode" 
                        title="PRQ Detail " width="150" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewDelete" index="purchaseOrderUpdateInformationDetailViewDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'purchaseOrderUpdateInformationDetailViewDelete_OnClick()', value:'delete'}"
                    />   
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewItemMaterialCode" index="purchaseOrderUpdateInformationDetailViewItemMaterialCode" key="purchaseOrderUpdateInformationDetailViewItemMaterialCode" 
                        title="Item Material Code " width="150" sortable="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewItemMaterialName" index="purchaseOrderUpdateInformationDetailViewItemMaterialName" key="purchaseOrderUpdateInformationDetailViewItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewItemAlias" index="purchaseOrderUpdateInformationDetailViewItemAlias" 
                        title="Item Alias" width="80" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewRemark" index="purchaseOrderUpdateInformationDetailViewRemark" key="purchaseOrderUpdateInformationDetailViewRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewQuantity" index="purchaseOrderUpdateInformationDetailViewQuantity" key="purchaseOrderUpdateInformationDetailViewQuantity" 
                        title="POD Quantity" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderUpdateInformationDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewUnitOfMeasureCode" index="purchaseOrderUpdateInformationDetailViewUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewUnitOfMeasureName" index="purchaseOrderUpdateInformationDetailViewUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewPrice" index="purchaseOrderUpdateInformationDetailViewPrice" key="purchaseOrderUpdateInformationDetailViewPrice" 
                        title="Price" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewDiscPercent" index="purchaseOrderUpdateInformationDetailViewDiscPercent" key="purchaseOrderUpdateInformationDetailViewDiscPercent" 
                        title="Discount Percent" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewDiscAmount" index="purchaseOrderUpdateInformationDetailViewDiscAmount" key="purchaseOrderUpdateInformationDetailViewDiscAmount" 
                        title="Discount Amount" width="150"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewNettPrice" index="purchaseOrderUpdateInformationDetailViewNettPrice" key="purchaseOrderUpdateInformationDetailViewNettPrice" 
                        title="Nett Price" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailViewTotalPrice" index="purchaseOrderUpdateInformationDetailViewTotalPrice" key="purchaseOrderUpdateInformationDetailViewTotalPrice" 
                        title="Total" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            
            <br class="spacer" />
            
            <table>
                <tr>
                    <td>
                        <sj:a href="#" id="btnPurchaseOrderUpdateInformationItemDetail" button="true" style="width: 200px">Search Item</sj:a>
                    </td>
                </tr>
            </table>
            
            <br class="spacer" />
            
            <div id="purchaseOrderUpdateInformationDetailInput">
                <sjg:grid
                    id="purchaseOrderUpdateInformationDetailInput_grid"
                    caption="Purchase Order Detail Input"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnupurchaseOrderUpdateInformationDetailInput').width()"
                    editurl="%{remoteurlPurchaseOrderUpdateInformationDetailInput}"
                    onSelectRowTopics="purchaseOrderUpdateInformationDetailInput_grid_onSelect"
                >      
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInput" index="purchaseOrderUpdateInformationDetailInput" key="purchaseOrderUpdateInformationDetailInput" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputDelete" index="purchaseOrderUpdateInformationDetailInputDelete" title="" width="50" align="centre"
                        editable="true" edittype="button"
                        editoptions="{onClick:'purchaseOrderUpdateInformationDetailInputDelete_OnClick()', value:'delete'}"
                    />   
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputPurchaseRequestCode" index="purchaseOrderUpdateInformationDetailInputPurchaseRequestCode" key="purchaseOrderUpdateInformationDetailInputPurchaseRequestCode" 
                        title="PRQ Header " width="150" sortable="true" hidden="true"
                    />                    
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputPurchaseRequestDetailCode" index="purchaseOrderUpdateInformationDetailInputPurchaseRequestDetailCode" key="purchaseOrderUpdateInformationDetailInputPurchaseRequestDetailCode" 
                        title="PRQ Detail " width="150" sortable="true" hidden="true"
                    />                    
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputDetailCode" index="purchaseOrderUpdateInformationDetailInputDetailCode" key="purchaseOrderUpdateInformationDetailInputDetailCode" 
                        title="Detail Code " width="150" sortable="true" hidden="true"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputItemMaterialCode" index="purchaseOrderUpdateInformationDetailInputItemMaterialCode" key="purchaseOrderUpdateInformationDetailInputItemMaterialCode" 
                        title="Item Material Code " width="150" sortable="true" hidden="false"
                    />                   
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputItemMaterialName" index="purchaseOrderUpdateInformationDetailInputItemMaterialName" key="purchaseOrderUpdateInformationDetailInputItemMaterialName" 
                        title="Item Material Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputItemAlias" index="purchaseOrderUpdateInformationDetailInputItemAlias" 
                        title="Item Alias" width="80" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputRemark" index="purchaseOrderUpdateInformationDetailInputRemark" key="purchaseOrderUpdateInformationDetailInputRemark" 
                        title="Remark" width="150" sortable="true" editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputQuantity" index="purchaseOrderUpdateInformationDetailInputQuantity" key="purchaseOrderUpdateInformationDetailInputQuantity" 
                        title="POD Quantity" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderUpdateInformationDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputUnitOfMeasureCode" index="purchaseOrderUpdateInformationDetailInputUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputUnitOfMeasureName" index="purchaseOrderUpdateInformationDetailInputUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true" editable="false" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputPrice" index="purchaseOrderUpdateInformationDetailInputPrice" key="purchaseOrderUpdateInformationDetailInputPrice" 
                        title="Price" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderUpdateInformationDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputDiscPercent" index="purchaseOrderUpdateInformationDetailInputDiscPercent" key="purchaseOrderUpdateInformationDetailInputDiscPercent" 
                        title="Discount Percent" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderUpdateInformationDetailPercent()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputDiscAmount" index="purchaseOrderUpdateInformationDetailInputDiscAmount" key="purchaseOrderUpdateInformationDetailInputDiscAmount" 
                        title="Discount Amount" width="150" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                        editoptions="{onKeyUp:'calculatePurchaseOrderUpdateInformationDetailAmount()'}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputNettPrice" index="purchaseOrderUpdateInformationDetailInputNettPrice" key="purchaseOrderUpdateInformationDetailInputNettPrice" 
                        title="Nett Price" width="150" sortable="true" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationDetailInputTotalPrice" index="purchaseOrderUpdateInformationDetailInputTotalPrice" key="purchaseOrderUpdateInformationDetailInputTotalPrice" 
                        title="Total" width="150" sortable="true" editable="false" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
            
            <br class="spacer" />
            
            <div id="purchaseOrderUpdateInformationDetailViewAddtional">
                <sjg:grid
                    id="purchaseOrderUpdateInformationAdditionalFeeInput_grid"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseOrderAdditonalFee"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    editinline="true"
                    width="$('#tabmnupurchaseOrderUpdateInformationAdditionalFee').width()"
                    editurl="%{remoteurlPurchaseOrderUpdateInformationAdditionalInput}"
                    onSelectRowTopics="purchaseOrderUpdateInformationAdditionalFeeInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeCode" index="purchaseOrderUpdateInformationAdditionalFeeCode" key="purchaseOrderUpdateInformationAdditionalFeeCode" 
                        title="Additional Cost Code" width="150" sortable="true"
                    />    
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeName" index="purchaseOrderUpdateInformationAdditionalFeeName" key="purchaseOrderUpdateInformationAdditionalFeeName" 
                        title="Additional Cost Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountCode" index="purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountCode" key="purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountCode" 
                        title="Chart Of Account Code" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountName" index="purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountName" key="purchaseOrderUpdateInformationAdditionalFeePurchaseChartOfAccountName" 
                        title="Chart Of Account Name" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeRemark" index="purchaseOrderUpdateInformationAdditionalFeeRemark" key="purchaseOrderUpdateInformationAdditionalFeeRemark" 
                        title="Remark" width="150" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeQuantity" index="purchaseOrderUpdateInformationAdditionalFeeQuantity" key="purchaseOrderUpdateInformationAdditionalFeeQuantity" 
                        title="Quantity" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeUnitOfMeasureCode" index="purchaseOrderUpdateInformationDetailViewUnitOfMeasureCode" 
                        title="UOM" width="100" sortable="true" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeUnitOfMeasureName" index="purchaseOrderUpdateInformationDetailViewUnitOfMeasureName" 
                        title="UOM" width="100" sortable="true"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeePrice" index="purchaseOrderUpdateInformationAdditionalFeePrice" key="purchaseOrderUpdateInformationAdditionalFeePrice" 
                        title="Price" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name="purchaseOrderUpdateInformationAdditionalFeeTotal" index="purchaseOrderUpdateInformationAdditionalFeeTotal" key="purchaseOrderUpdateInformationAdditionalFeeTotal" 
                        title="Total" width="150" sortable="true"
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                </sjg:grid >
            </div>
        </div> 
            
    <br>
    <br>
    <div id="PurchaseOrderUpdateInformationItemDeliveryDate">
        <table>
            <tr>
                <td valign="top">
                    <table width="100%">
                        <tr>
                            <td>
                                <sjg:grid
                                    id="purchaseOrderUpdateInformationItemDeliveryInput_grid"
                                    caption="Item Delivery Date"
                                    dataType="local"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listPurchaseOrderItemDeliveryDate"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    editinline="true"
                                    width="500"
                                    editurl="%{remoteurlPurchaseOrderUpdateInformationItemDeliveryInput}"
                                    onSelectRowTopics="purchaseOrderUpdateInformationItemDeliveryInput_grid_onSelect"
                                >
                                    <sjg:gridColumn
                                        name="purchaseOrderUpdateInformationItemDelivery" index="purchaseOrderUpdateInformationItemDelivery" key="purchaseOrderUpdateInformationItemDelivery" 
                                        title="" width="50" sortable="true" editable="true" hidden="true"
                                    />
                                    <sjg:gridColumn
                                        name="purchaseOrderUpdateInformationItemDeliveryDelete" index="purchaseOrderUpdateInformationItemDeliveryDelete" title="" width="50" align="centre"
                                        editable="true"
                                        edittype="button"
                                        editoptions="{onClick:'purchaseOrderUpdateInformationItemDeliveryInputGrid_Delete_OnClick()', value:'delete'}"
                                    />
                                    <sjg:gridColumn
                                        name="purchaseOrderUpdateInformationItemDeliverySearchItemMaterial" index="purchaseOrderUpdateInformationItemDeliverySearchItemMaterial" title="" width="25" align="centre"
                                        editable="true"
                                        dataType="html"
                                        edittype="button"
                                        editoptions="{onClick:'purchaseOrderUpdateInformationItemDeliveryInputGrid_SearchItemMaterial_OnClick()', value:'...'}"
                                    /> 
                                    <sjg:gridColumn
                                        name = "purchaseOrderUpdateInformationItemDeliveryItemMaterialCode" index = "purchaseOrderUpdateInformationItemDeliveryItemMaterialCode" key = "purchaseOrderUpdateInformationItemDeliveryItemMaterialCode" 
                                        title = "Item Material Code" width = "100" editable="false" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "purchaseOrderUpdateInformationItemDeliveryItemMaterialName" index = "purchaseOrderUpdateInformationItemDeliveryItemMaterialName" key = "purchaseOrderUpdateInformationItemDeliveryItemMaterialName" 
                                        title = "tem Material Name" width = "100" editable="false" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="purchaseOrderUpdateInformationItemDeliveryQuantity" index="purchaseOrderUpdateInformationItemDeliveryQuantity" key="purchaseOrderUpdateInformationItemDeliveryQuantity" title="Quantity" 
                                        width="100" align="right" editable="true" edittype="text" 
                                        formatter="number" editrules="{ double: true }"
                                    />
                                    <sjg:gridColumn
                                        name="purchaseOrderUpdateInformationItemDeliveryDeliveryDate" index="purchaseOrderUpdateInformationItemDeliveryDeliveryDate" title="Delivery Date" 
                                        sortable="false" 
                                        editable="true" align="center"
                                        formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                        width="100" editrules="{date: true, required:false}" 
                                        editoptions="{onChange:'onchangePurchaseOrderUpdateInformationItemDeliveryDeliveryDate()',size:130, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'dd/mm/yy'});}}"
                                    />
                                    <sjg:gridColumn
                                        name="purchaseOrderUpdateInformationItemDeliveryDeliveryDateTemp" index="purchaseOrderUpdateInformationItemDeliveryDeliveryDateTemp" title=" " width="80" sortable="true" hidden="true"
                                    /> 
                                </sjg:grid >
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <s:textfield id="purchaseOrderUpdateInformationItemDeliveryAddRow" name="purchaseOrderUpdateInformationItemDeliveryAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                <sj:a href="#" id="btnPurchaseOrderUpdateInformationItemDelieryAdd" button="true" style="width:60px">Add</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <table style="width: 100%;">  
            <tr>
                <td valign="top">
                </td>
                <td width="700px" >
                <fieldset> 
                    <table align="right">
                        <tr>
                            <td align="right"><B>Total Transaction</B>
                                <s:textfield id="purchaseOrderUpdateInformation.totalTransactionAmount" name="purchaseOrderUpdateInformation.totalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="left"><B>Discount</B>
                            <s:textfield id="purchaseOrderUpdateInformation.discountPercent" name="purchaseOrderUpdateInformation.discountPercent" readonly="true" cssStyle="text-align:right;" size="8"></s:textfield>
                                %
                            <s:textfield id="purchaseOrderUpdateInformation.discountAmount" name="purchaseOrderUpdateInformation.discountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td></td>
                            <td align="left"> Descriptions</td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                <s:textfield id="purchaseOrderUpdateInformation.discountChartOfAccount.code" name="purchaseOrderUpdateInformation.discountChartOfAccount.code" readonly="true" title=" " size = "15"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderUpdateInformation.discountChartOfAccount.name" name="purchaseOrderUpdateInformation.discountChartOfAccount.name" title=" " size = "20" readonly = "true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderUpdateInformation.discountDescription" name="purchaseOrderUpdateInformation.discountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Sub Total (Tax Base)</B>
                                <s:textfield id="purchaseOrderUpdateInformation.taxBaseSubTotalAmount" name="purchaseOrderUpdateInformation.taxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                            <s:textfield id="purchaseOrderUpdateInformation.vatPercent" name="purchaseOrderUpdateInformation.vatPercent" cssStyle="text-align:right;" size="8" readonly="true"></s:textfield>
                                %
                            <s:textfield id="purchaseOrderUpdateInformation.vatAmount" name="purchaseOrderUpdateInformation.vatAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                        <tr>
                            <td align="right"><B>Other Fee</B>
                                <s:textfield id="purchaseOrderUpdateInformation.otherFeeAmount" name="purchaseOrderUpdateInformation.otherFeeAmount" cssStyle="text-align:right;%" readonly="true"></s:textfield>
                            </td>
                            <td/>
                             <td align="left"> Descriptions </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Account</B>
                                <s:textfield id="purchaseOrderUpdateInformation.otherFeeChartOfAccount.code" name="purchaseOrderUpdateInformation.otherFeeChartOfAccount.code" title=" " size = "15" readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                            <s:textfield id="purchaseOrderUpdateInformation.otherFeeChartOfAccount.name" name="purchaseOrderUpdateInformation.otherFeeChartOfAccount.name" title=" " readonly="true"></s:textfield>
                            </td>
                            <td align="right">
                                <s:textfield id="purchaseOrderUpdateInformation.otherFeeDescription" name="purchaseOrderUpdateInformation.otherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B>
                                <s:textfield id="purchaseOrderUpdateInformation.grandTotalAmount" name="purchaseOrderUpdateInformation.grandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                            </td>
                            <td/>
                        </tr>
                    </table>
                </fieldset>            
                </td>
            </tr>       
        </table>
    </div>                             
    <table>
        <tr></tr>
        <tr>
            <td><sj:a href="#" id="btnPurchaseOrderUpdateInformationSave" button="true" style="width: 60px">Save</sj:a></td>
            <td> <sj:a href="#" id="btnPurchaseOrderUpdateInformationCancel" button="true" style="width: 60px">Cancel</sj:a></td>
            </tr>
    </table>
</s:form>
<br class="spacer" />
<br class="spacer" />