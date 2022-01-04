<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #salesQuotationDetailInput_grid_pager_center,.ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgExchangeRate,#errmsgAddRow{
        color: red;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    .tableBottomSQ{
        table-layout: fixed;
        width: 100%;
    }
</style>

<script type="text/javascript">
    
    var salesQuotationDetaillastRowId=0,salesQuotationDetail_lastSel = -1;
    var salesQuotationDetaillastRowErrorId=0,salesQuotationDetail_lastSelError = -1;
    var 
        txtSalesQuotationCode = $("#salesQuotation\\.code"),
        txtSalesQuotationCodeTemp = $("#salesQuotationTemp\\.code"),
        txtSalesQuotationSALQUONo = $("#salesQuotation\\.salQuoNo"),
        txtSalesQuotationRefSalQUOCode = $("#salesQuotation\\.refSalQUOCode"),
        txtSalesQuotationRevision= $("#salesQuotation\\.revision"),
        txtSalesQuotationShipToCode = $("#salesQuotation\\.city\\.code"),
        txtSalesQuotationShipToName = $("#salesQuotation\\.city\\.name"),
        txtSalesQuotationTermOfDeliveryCode = $("#salesQuotation\\.termOfDelivery\\.code"),
        txtSalesQuotationTermOfDeliveryName = $("#salesQuotation\\.termOfDelivery\\.name"),
        txtSalesQuotationValveTypeCode = $("#salesQuotation\\.valveType\\.code"),
        txtSalesQuotationValveTypeName = $("#salesQuotation\\.valveType\\.name"),
        dtpSalesQuotationTransactionDate = $("#salesQuotation\\.transactionDate"),
        txtSalesQuotationRefNo = $("#salesQuotation\\.refNo"),
        txtSalesQuotationRemark = $("#salesQuotation\\.remark"),
        txtSalesQuotationCreatedBy = $("#salesQuotation\\.createdBy"),
        txtSalesQuotationRequestForQuotationCode = $("#salesQuotation\\.requestForQuotation\\.code"),
        txtSalesQuotationRequestForQuotationBranchCode = $("#salesQuotation\\.requestForQuotation\\.branchCode"),
        txtSalesQuotationRequestForQuotationBranchName = $("#salesQuotation\\.requestForQuotation\\.branchName"),
        txtSalesQuotationRequestForQuotationProjectCode = $("#salesQuotation\\.requestForQuotation\\.projectCode"),
        txtSalesQuotationRequestForQuotationProjectName = $("#salesQuotation\\.requestForQuotation\\.projectName"),
        txtSalesQuotationRequestForQuotationCurrencyCode = $("#salesQuotation\\.requestForQuotation\\.currencyCode"),
        txtSalesQuotationRequestForQuotationCurrencyName = $("#salesQuotation\\.requestForQuotation\\.currencyName"),
        txtSalesQuotationRequestForQuotationCustomerCode = $("#salesQuotation\\.requestForQuotation\\.customerCode"),
        txtSalesQuotationRequestForQuotationCustomerName = $("#salesQuotation\\.requestForQuotation\\.customerName"),
        txtSalesQuotationRequestForQuotationEndUserCode = $("#salesQuotation\\.requestForQuotation\\.endUserCode"),
        txtSalesQuotationRequestForQuotationEndUserName = $("#salesQuotation\\.requestForQuotation\\.endUserName"),
        txtSalesQuotationRequestForQuotationSalesPersonCode = $("#salesQuotation\\.requestForQuotation\\.salesPersonCode"),
        txtSalesQuotationRequestForQuotationSalesPersonName = $("#salesQuotation\\.requestForQuotation\\.salesPersonName"),
        txtSalesQuotationRequestForQuotationSubject = $("#salesQuotation\\.requestForQuotation\\.subject"),
        txtSalesQuotationRequestForQuotationAttn = $("#salesQuotation\\.requestForQuotation\\.attn"),
        rdbSalesQuotationRequestForQuotationOrderStatus = $("#salesQuotation\\.requestForQuotation\\.orderStatus"),
        dtpSalesQuotationCreatedDate = $("#salesQuotation\\.createdDate"),
        txtSalesQuotationTotalTransactionAmount = $("#salesQuotation\\.totalTransactionAmount"),
        txtSalesQuotationDiscountPercent = $("#salesQuotation\\.discountPercent"),
        txtSalesQuotationDiscountAmount = $("#salesQuotation\\.discountAmount"),
        txtSalesQuotationSubTotalAmount= $("#salesQuotation\\.taxBaseAmount"),
        txtSalesQuotationVATPercent = $("#salesQuotation\\.vatPercent"),
        txtSalesQuotationVATAmount = $("#salesQuotation\\.vatAmount"),
        txtSalesQuotationGrandTotalAmount = $("#salesQuotation\\.grandTotalAmount"),

                
        allFieldsSalesQuotation = $([])

            .add(txtSalesQuotationCode)
            .add(txtSalesQuotationCodeTemp)
            .add(txtSalesQuotationRefSalQUOCode)
            .add(txtSalesQuotationSALQUONo)
            .add(txtSalesQuotationRevision)
            .add(txtSalesQuotationRefNo)
            .add(txtSalesQuotationRemark)
            .add(txtSalesQuotationRequestForQuotationCode)
            .add(txtSalesQuotationRequestForQuotationBranchCode)
            .add(txtSalesQuotationRequestForQuotationBranchName)
            .add(txtSalesQuotationRequestForQuotationProjectCode)
            .add(txtSalesQuotationRequestForQuotationProjectName)
            .add(txtSalesQuotationRequestForQuotationCurrencyCode)
            .add(txtSalesQuotationRequestForQuotationCurrencyName)
            .add(txtSalesQuotationRequestForQuotationCustomerCode)
            .add(txtSalesQuotationRequestForQuotationCustomerName)
            .add(txtSalesQuotationRequestForQuotationEndUserCode)
            .add(txtSalesQuotationRequestForQuotationEndUserName)
            .add(txtSalesQuotationRequestForQuotationSalesPersonCode)
            .add(txtSalesQuotationRequestForQuotationSalesPersonName)
            .add(txtSalesQuotationRequestForQuotationSubject)
            .add(txtSalesQuotationRequestForQuotationAttn)
            .add(txtSalesQuotationTotalTransactionAmount)
            .add(txtSalesQuotationDiscountPercent)
            .add(txtSalesQuotationDiscountAmount)
            .add(txtSalesQuotationSubTotalAmount)
            .add(txtSalesQuotationVATPercent)
            .add(txtSalesQuotationVATAmount)
            .add(txtSalesQuotationGrandTotalAmount);


    $(document).ready(function() {
 
        flagIsConfirmedCCN=false;

        $("#salesQuotation\\.discountPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#salesQuotation\\.discountPercent").change(function(e){
            var amount=$("#salesQuotation\\.discountPercent").val();
            if(amount===""){
               $("#salesQuotation\\.discountPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $("#salesQuotation\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#salesQuotation\\.vatPercent").change(function(e){
            var amount=$("#salesQuotation\\.vatPercent").val();
            if(amount===""){
               $("#salesQuotation\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        if($("#salesQuotationUpdateMode").val()==="true"){
            salesQuotationRequestForQuotationLoad(rdbSalesQuotationRequestForQuotationOrderStatus.val());
            formatNumericCCN();
        }
        if($("#salesQuotationCloneMode").val()==="true"){
            $("#salesQuotationTemp\\.code").val($("#salesQuotation\\.code").val());
            $('#salesQuotation\\.code').attr('readonly',true);
            $("#salesQuotation\\.code").val("AUTO");
            formatNumericCCN();
            salesQuotationRequestForQuotationLoad(rdbSalesQuotationRequestForQuotationOrderStatus.val());
        }
        if($("#salesQuotationReviseMode").val()==="true"){
            formatNumericCCN();
            salesQuotationRequestForQuotationLoad(rdbSalesQuotationRequestForQuotationOrderStatus.val());
        }
        if($("#salesQuotationUpdateMode").val()==="false" && $("#salesQuotationCloneMode").val()==="false" && $("#salesQuotationReviseMode").val()==="false"){
            $('#salesQuotationRequestForQuotationRadBLANKET_ORDER').prop('checked',true);
            $('#salesQuotationRequestForQuotationRadBLANKET_ORDER').prop('disabled',true);
            $('#salesQuotationRequestForQuotationRadSALES_ORDER').prop('disabled',true);
        }
        
        $("#btnUnConfirmSalesQuotation").css("display", "none");
        $('#salesQuotationDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmSalesQuotation").click(function(ev) {
//            handlers_input_customer_credit_note();
//
            if(txtSalesQuotationRequestForQuotationCode.val()===''){
                alertMessage("RFQ Cant be Empty");
                return;
            }            
            if(txtSalesQuotationShipToCode.val()===''){
                alertMessage("Ship To Cant be Empty");
                return;
            }            
            if(txtSalesQuotationTermOfDeliveryCode.val()===''){
                alertMessage("Term Of Delivery Cant be Empty");
                return;
            }            
            
            var date1 = dtpSalesQuotationTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#salesQuotationTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");

            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#salesQuotationUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#salesQuotationTransactionDate").val(),dtpSalesQuotationTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpSalesQuotationTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#salesQuotationUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#salesQuotationTransactionDate").val(),dtpSalesQuotationTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpSalesQuotationTransactionDate);
                }
                return;
            }

            if($("#salesQuotationUpdateMode").val()==="true"){
                salesQuotationLoadDataDetail();
            }
            if($("#salesQuotationCloneMode").val()==="true"){
                salesQuotationLoadDataDetailOne();
            }
            if($("#salesQuotationReviseMode").val()==="true"){
                salesQuotationLoadDataDetailRev();
            }
            
            flagIsConfirmedCCN=true;
            $("#btnUnConfirmSalesQuotation").css("display", "block");
            $("#btnConfirmSalesQuotation").css("display", "none");   
            $('#headerSalesQuotationInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#salesQuotationDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmSalesQuotation").click(function(ev) {
            $('#salesQuotation\\.valveType\\.code').val("");
            $('#salesQuotation\\.valveType\\.name').val("");
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#salesQuotationDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    $("#btnUnConfirmSalesQuotation").css("display", "none");
                    $("#btnConfirmSalesQuotation").css("display", "block");
                    $('#headerSalesQuotationInput').unblock();
                    $('#salesQuotationDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    $('#sqExcel').val("");
                    $("#salesQuotationDetailErrorInput_grid").jqGrid("clearGridData");
                    flagIsConfirmedCCN=false;
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
                                flagIsConfirmedCCN=false;
                                $("#salesQuotationDetailInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmSalesQuotation").css("display", "none");
                                $("#btnConfirmSalesQuotation").css("display", "block");
                                $('#headerSalesQuotationInput').unblock();
                                $('#salesQuotationDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                                $('#sqExcel').val("");
                                $("#salesQuotationDetailErrorInput_grid").jqGrid("clearGridData");
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

        $.subscribe("salesQuotationDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesQuotationDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==salesQuotationDetail_lastSel) {

                $('#salesQuotationDetailInput_grid').jqGrid("saveRow",salesQuotationDetail_lastSel); 
                $('#salesQuotationDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                salesQuotationDetail_lastSel=selectedRowID;

            }
            else{
                $('#salesQuotationDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnSalesQuotationSave').click(function(ev) {
            var ids = jQuery("#salesQuotationDetailErrorInput_grid").jqGrid('getDataIDs');
            if(ids.length > 0){
                alertMessage("Please Correction The Error!");
                return;
            }     
            
            if($("#salesQuotationReviseMode").val()==="true"){
                if(!flagIsConfirmedCCN){
                    alertMessage("Please Confirm!",$("#btnConfirmSalesQuotation"));
                    return;
                    }

                    if(salesQuotationDetail_lastSel !== -1) {
                    $('#salesQuotationDetailInput_grid').jqGrid("saveRow",salesQuotationDetail_lastSel); 
                    }
                    
                     var listSalesQuotationDetail = new Array();
                     var ids = jQuery("#salesQuotationDetailInput_grid").jqGrid('getDataIDs');
             
                        for(var i=0;i < ids.length;i++){
                            var data = $("#salesQuotationDetailInput_grid").jqGrid('getRowData',ids[i]);

                            if(data.salesQuotationDetailItem === ""){
                                alertMessage("Item Detail Can't Empty! ");
                                return;
                            }

                            var salesQuotationDetail = {
                                valveType           : {code:data.salesQuotationDetailValveTypeCode},
                                bodyConstruction    : data.salesQuotationDetailDescription,
                                valveTag            : data.salesQuotationDetailValveTag ,
                                dataSheet           : data.salesQuotationDetailDataSheet ,
                                description         : data.salesQuotationDetailDescription ,
                                typeDesign          : data.salesQuotationDetailTypeDesign ,
                                bore                : data.salesQuotationDetailBore ,
                                size                : data.salesQuotationDetailSize ,
                                rating              : data.salesQuotationDetailRating ,
                                endCon              : data.salesQuotationDetailEndCon ,
                                body                : data.salesQuotationDetailBody ,
                                ball                : data.salesQuotationDetailBall ,
                                seat                : data.salesQuotationDetailSeat ,
                                stem                : data.salesQuotationDetailStem ,
                                seatInsert          : data.salesQuotationDetailSeatInsert ,
                                seal                : data.salesQuotationDetailSeal ,
                                bolt                : data.salesQuotationDetailBolting ,
                                seatDesign          : data.salesQuotationDetailSeatDesign ,
                                oper                : data.salesQuotationDetailOper ,
                                disc                : data.salesQuotationDetailDisc ,
                                plates              : data.salesQuotationDetailPlates ,
                                shaft               : data.salesQuotationDetailShaft ,
                                spring              : data.salesQuotationDetailSpring ,
                                armPin              : data.salesQuotationDetailArmPin ,
                                backseat            : data.salesQuotationDetailBackseat ,
                                arm                 : data.salesQuotationDetailArm ,
                                hingePin            : data.salesQuotationDetailhingePin ,
                                stopPin             : data.salesQuotationDetailstopPin ,
                                note                : data.salesQuotationDetailNote ,
                                quantity            : data.salesQuotationDetailQuantity,
                                unitPrice           : data.salesQuotationDetailUnitPrice,
                                totalAmount         : data.salesQuotationDetailTotal 
                            };
                            listSalesQuotationDetail[i] = salesQuotationDetail;
                        }
                    unFormatNumericCCN();
                    formatDateCCN();  
                    var url="sales/sales-quotation-save-revise";
                    var params = $("#frmSalesQuotationInput").serialize();
                         params += "&"+$("#frmSalesQuotation").serialize();
                         params += "&listSalesQuotationDetailJSON=" + $.toJSON(listSalesQuotationDetail);
                         
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            formatNumericCCN();
                            formatDateCCN(); 
                            alert(data.errorMessage);
                            return;
                        }
                        closeLoading();
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
                                        var url = "sales/sales-quotation-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuSALES_QUOTATION");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "sales/sales-quotation";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuSALES_QUOTATION");
                                    }
                                }]
                        });
                    });
                }else if($("#salesQuotationUpdateMode").val()==="true"){
                    if(!flagIsConfirmedCCN){
                        alertMessage("Please Confirm!",$("#btnConfirmSalesQuotation"));
                        return;
                    }

                    if(salesQuotationDetail_lastSel !== -1) {
                        $('#salesQuotationDetailInput_grid').jqGrid("saveRow",salesQuotationDetail_lastSel); 
                    }
                    
                     var listSalesQuotationDetail = new Array();
                     var ids = jQuery("#salesQuotationDetailInput_grid").jqGrid('getDataIDs');
             
                        for(var i=0;i < ids.length;i++){
                            var data = $("#salesQuotationDetailInput_grid").jqGrid('getRowData',ids[i]);

                            if(data.salesQuotationDetailItem === ""){
                                alertMessage("Item Detail Can't Empty! ");
                                return;
                            }

                            var salesQuotationDetail = {
                                valveType           : {code:data.salesQuotationDetailValveTypeCode},
                                bodyConstruction    : data.salesQuotationDetailDescription,
                                valveTag            : data.salesQuotationDetailValveTag ,
                                dataSheet           : data.salesQuotationDetailDataSheet ,
                                description         : data.salesQuotationDetailDescription ,
                                typeDesign          : data.salesQuotationDetailTypeDesign ,
                                bore                : data.salesQuotationDetailBore ,
                                size                : data.salesQuotationDetailSize ,
                                rating              : data.salesQuotationDetailRating ,
                                endCon              : data.salesQuotationDetailEndCon ,
                                body                : data.salesQuotationDetailBody ,
                                ball                : data.salesQuotationDetailBall ,
                                seat                : data.salesQuotationDetailSeat ,
                                stem                : data.salesQuotationDetailStem ,
                                seatInsert          : data.salesQuotationDetailSeatInsert ,
                                seal                : data.salesQuotationDetailSeal ,
                                bolt                : data.salesQuotationDetailBolting ,
                                seatDesign          : data.salesQuotationDetailSeatDesign ,
                                oper                : data.salesQuotationDetailOper ,
                                disc                : data.salesQuotationDetailDisc ,
                                plates              : data.salesQuotationDetailPlates ,
                                shaft               : data.salesQuotationDetailShaft ,
                                spring              : data.salesQuotationDetailSpring ,
                                armPin              : data.salesQuotationDetailArmPin ,
                                backseat            : data.salesQuotationDetailBackseat ,
                                arm                 : data.salesQuotationDetailArm ,
                                hingePin            : data.salesQuotationDetailhingePin ,
                                stopPin             : data.salesQuotationDetailstopPin ,
                                note                : data.salesQuotationDetailNote ,
                                quantity            : data.salesQuotationDetailQuantity,
                                unitPrice           : data.salesQuotationDetailUnitPrice,
                                totalAmount         : data.salesQuotationDetailTotal 
                            };
                            listSalesQuotationDetail[i] = salesQuotationDetail;
                        }
                    unFormatNumericCCN();
                    formatDateCCN();  
                    var url="sales/sales-quotation-update";
                    var params = $("#frmSalesQuotationInput").serialize();
                         params += "&"+$("#frmSalesQuotation").serialize();
                         params += "&listSalesQuotationDetailJSON=" + $.toJSON(listSalesQuotationDetail);
                         
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            formatNumericCCN();
                            formatDateCCN(); 
                            alert(data.errorMessage);
                            return;
                        }if(data.errorMessage){
                        alertMessage(data.errorMessage);
                        return;
                        }
                        closeLoading();
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
                                        var url = "sales/sales-quotation-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuSALES_QUOTATION");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "sales/sales-quotation";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuSALES_QUOTATION");
                                    }
                                }]
                        });
                    });
                }else{
                    if(!flagIsConfirmedCCN){
                        alertMessage("Please Confirm!",$("#btnConfirmSalesQuotation"));
                        return;
                    }

                    if(salesQuotationDetail_lastSel !== -1) {
                        $('#salesQuotationDetailInput_grid').jqGrid("saveRow",salesQuotationDetail_lastSel); 
                    }
                    
                    var listSalesQuotationDetail = new Array();
                    var ids = jQuery("#salesQuotationDetailInput_grid").jqGrid('getDataIDs');
                    var idl = jQuery("#salesQuotationDetailErrorInput_grid").jqGrid('getDataIDs');
             
                    if(idl.length > 0){
                        alertMessage("Tolong Perbaiki Data Excel!");

                    }
                        for(var i=0;i < ids.length;i++){
                            var data = $("#salesQuotationDetailInput_grid").jqGrid('getRowData',ids[i]);

                            var salesQuotationDetail = {
                                valveType           : {code:data.salesQuotationDetailValveTypeCode},
                                bodyConstruction    : data.salesQuotationDetailDescription,
                                valveTag            : data.salesQuotationDetailValveTag ,
                                dataSheet           : data.salesQuotationDetailDataSheet ,
                                description         : data.salesQuotationDetailDescription ,
                                typeDesign          : data.salesQuotationDetailTypeDesign ,
                                bore                : data.salesQuotationDetailBore ,
                                size                : data.salesQuotationDetailSize ,
                                rating              : data.salesQuotationDetailRating ,
                                endCon              : data.salesQuotationDetailEndCon ,
                                body                : data.salesQuotationDetailBody ,
                                ball                : data.salesQuotationDetailBall ,
                                seat                : data.salesQuotationDetailSeat ,
                                stem                : data.salesQuotationDetailStem ,
                                seatInsert          : data.salesQuotationDetailSeatInsert ,
                                seal                : data.salesQuotationDetailSeal ,
                                bolt                : data.salesQuotationDetailBolting ,
                                seatDesign          : data.salesQuotationDetailSeatDesign ,
                                oper                : data.salesQuotationDetailOper ,
                                disc                : data.salesQuotationDetailDisc ,
                                plates              : data.salesQuotationDetailPlates ,
                                shaft               : data.salesQuotationDetailShaft ,
                                spring              : data.salesQuotationDetailSpring ,
                                armPin              : data.salesQuotationDetailArmPin ,
                                arm                 : data.salesQuotationDetailArm ,
                                hingePin            : data.salesQuotationDetailhingePin ,
                                stopPin             : data.salesQuotationDetailstopPin ,
                                backseat            : data.salesQuotationDetailBackseat ,
                                note                : data.salesQuotationDetailNote ,
                                quantity            : data.salesQuotationDetailQuantity,
                                unitPrice           : data.salesQuotationDetailUnitPrice,
                                totalAmount         : data.salesQuotationDetailTotal 
                            };
                            listSalesQuotationDetail[i] = salesQuotationDetail;
                        }
                    unFormatNumericCCN();
                    formatDateCCN();
                     var url = "sales/sales-quotation-save";
                     var params = $("#frmSalesQuotationInput").serialize();
                         params += "&"+$("#frmSalesQuotation").serialize();
                         params += "&listSalesQuotationDetailJSON=" + $.toJSON(listSalesQuotationDetail);
                     
                    $.post(url, params, function(data) {
                        $("#dlgLoading").dialog("close");
                        if (data.error) {
                            formatNumericCCN();
                            formatDateCCN(); 
                            alert(data.errorMessage);
                            return;
                        }
                        closeLoading();
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
                                        var url = "sales/sales-quotation-input";
                                        var param = "";
                                        pageLoad(url, param, "#tabmnuSALES_QUOTATION");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        var url = "sales/sales-quotation";
                                        var params = "";
                                        pageLoad(url, params, "#tabmnuSALES_QUOTATION");
                                    }
                                }]
                        });
                    });
                }
            if(!flagIsConfirmedCCN){
                alertMessage("Please Confirm!",$("#btnConfirmSalesQuotation"));
                return;
            }
        });
  
        $('#btnSalesQuotationCancel').click(function(ev) {
            var url = "sales/sales-quotation";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_QUOTATION"); 
        });
        
        $('#salesQuotation_btnCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=salesQuotation&idsubdoc=city","Search", "Scrollbars=1,width=600, height=500");
        });
     
        $('#salesQuotation_btnTermOfDelivery').click(function(ev) {
            window.open("./pages/search/search-term-of-delivery.jsp?iddoc=salesQuotation&idsubdoc=termOfDelivery","Search", "scrollbars=1, width=600, height=500");
        });
        $('#salesQuotation_btnRequestForQuotation').click(function(ev) {
            window.open("./pages/search/search-request-for-quotation.jsp?iddoc=salesQuotation&idsubdoc=requestForQuotation&firstDate="+$("#salesQuotationTransactionDateFirstSession").val()+"&lastDate="+$("#salesQuotationTransactionDateLastSession").val(),"Search", "scrollbars=1, width=600, height=500");
        });
     
    }); //EOF Ready
    
    function salesQuotationTransactionDateOnChange(){
        if($("#salesQuotationUpdateMode").val()!=="true"){
            $("#salesQuotationTransactionDate").val(dtpSalesQuotationTransactionDate.val());
        }
        if($("#salesQuotationCloneMode").val()!=="true"){
            $("#salesQuotationTransactionDate").val(dtpSalesQuotationTransactionDate.val());
        }
        if($("#salesQuotationReviseMode").val()!=="true"){
            $("#salesQuotationTransactionDate").val(dtpSalesQuotationTransactionDate.val());
        }
    }
    
     function formatDate(date) {
        var dateSplit = date.split('/');
        var dateFormat = dateSplit[1] + "/" + dateSplit[0] + "/" + dateSplit[2];
        return dateFormat;
    }
    function formatDateRemoveT(date, useTime) {
        var dateValues = date.split('T');
        var dateValuesTemp = dateValues[0].split('-');
        var dateValue = dateValuesTemp[2] + "/" + dateValuesTemp[1] + "/" + dateValuesTemp[0];
        var dateValuesTemps;

        if (useTime) {
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    function formatDateCCN(){
        var transactionDate=formatDate(dtpSalesQuotationTransactionDate.val());
        dtpSalesQuotationTransactionDate.val(transactionDate);  
        
        var createdDate = formatDate(dtpSalesQuotationCreatedDate.val());
        dtpSalesQuotationCreatedDate.val(createdDate);
        
    }
    
    function unFormatNumericCCN(){
        var totalTransaction = txtSalesQuotationTotalTransactionAmount.val().replace(/,/g, "");
        var discountPercent = txtSalesQuotationDiscountPercent.val().replace(/,/g, "");
        var discountAmount = txtSalesQuotationDiscountAmount.val().replace(/,/g, "");
        var taxVATAmount = txtSalesQuotationVATPercent.val().replace(/,/g, "");
        var taxVATPercent = txtSalesQuotationVATAmount.val().replace(/,/g, "");
        var otherFeeAmount = txtSalesQuotationSubTotalAmount.val().replace(/,/g, "");
        var grandTotal = txtSalesQuotationGrandTotalAmount.val().replace(/,/g, "");
            
        txtSalesQuotationTotalTransactionAmount.val(totalTransaction);
        txtSalesQuotationDiscountAmount.val(discountAmount);
        txtSalesQuotationDiscountPercent.val(discountPercent);
        txtSalesQuotationVATPercent.val(taxVATAmount);
        txtSalesQuotationVATAmount.val(taxVATPercent);
        txtSalesQuotationSubTotalAmount.val(otherFeeAmount);
        txtSalesQuotationGrandTotalAmount.val(grandTotal);
    }
    
    function formatNumericCCN(){
        var totalTransactionAmount =parseFloat(txtSalesQuotationTotalTransactionAmount.val());
        var discountPercent =parseFloat(txtSalesQuotationDiscountPercent.val());
        var discountAmount =parseFloat(txtSalesQuotationDiscountAmount.val());
        var vatPercent =parseFloat(txtSalesQuotationVATPercent.val());
        var vatAmount =parseFloat(txtSalesQuotationVATAmount.val());
        var otherFeeAmount = parseFloat(txtSalesQuotationSubTotalAmount.val());
        var grandTotalAmount =parseFloat(txtSalesQuotationGrandTotalAmount.val());
            
        txtSalesQuotationTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        txtSalesQuotationDiscountPercent.val(formatNumber(discountPercent,2));
        txtSalesQuotationDiscountAmount.val(formatNumber(discountAmount,2));
        txtSalesQuotationVATPercent.val(formatNumber(vatPercent,2));
        txtSalesQuotationVATAmount.val(formatNumber(vatAmount,2));
        txtSalesQuotationSubTotalAmount.val(formatNumber(otherFeeAmount,2));
        txtSalesQuotationGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }
    
    function numberWithCommas(x) {
       var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function calculateSalesQuotationDetail() {
        var selectedRowID = $("#salesQuotationDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#salesQuotationDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = salesQuotationDetaillastRowId;
        }
        var qty = $("#" + selectedRowID + "_salesQuotationDetailQuantity").val();
        var amount = $("#" + selectedRowID + "_salesQuotationDetailUnitPrice").val();

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#salesQuotationDetailInput_grid").jqGrid("setCell", selectedRowID, "salesQuotationDetailTotal", subAmount);


        calculateSalesQuotationHeader();
    }
        
    function calculateSalesQuotationHeader() {
        var totalTransaction = 0;
        var discPercent=removeCommas(txtSalesQuotationDiscountPercent.val());
        var vatPercent=removeCommas(txtSalesQuotationVATPercent.val());
        var ids = jQuery("#salesQuotationDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#salesQuotationDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.salesQuotationDetailTotal);
        }
        
        if(txtSalesQuotationDiscountPercent.val()===""){
            discPercent=0;
        }
        if(txtSalesQuotationVATPercent.val()===""){
            vatPercent=0;
        }
        
        var discAmount = (totalTransaction *  parseFloat(discPercent))/100;
        var subTotalAmount = (totalTransaction - parseFloat(discAmount.toFixed(2)));
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotal =(parseFloat(subTotalAmount) + parseFloat(vatAmount.toFixed(2)));
        
        txtSalesQuotationTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        txtSalesQuotationDiscountAmount.val(formatNumber(parseFloat(discAmount.toFixed(2)),2));
        txtSalesQuotationSubTotalAmount.val(formatNumber(subTotalAmount,2));
        txtSalesQuotationVATAmount.val(formatNumber(parseFloat(vatAmount.toFixed(2)),2));        
        txtSalesQuotationGrandTotalAmount.val(formatNumber(grandTotal,2));

    }

    function salesQuotationDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#salesQuotationDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#salesQuotationDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        calculateSalesQuotationHeader();
        
    }
    
    function salesQuotationLoadDataDetail() {
        var url = "sales/sales-quotation-detail-data";
        var params = "salesQuotation.code=" + txtSalesQuotationCode.val();
            
            $.getJSON(url, params, function(data) {
                salesQuotationDetaillastRowId = 0;
                for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                    salesQuotationDetaillastRowId++;
                    $("#salesQuotationDetailInput_grid").jqGrid("addRowData", salesQuotationDetaillastRowId, data.listSalesQuotationDetailTemp[i]);
                    $("#salesQuotationDetailInput_grid").jqGrid('setRowData',salesQuotationDetaillastRowId,{
                        salesQuotationDetailDelete              : "delete",
                        salesQuotationDetailBodyConstruction    : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                        salesQuotationDetailBore                : data.listSalesQuotationDetailTemp[i].bore,
                        salesQuotationDetailDisc                : data.listSalesQuotationDetailTemp[i].disc,
                        salesQuotationDetailPlates              : data.listSalesQuotationDetailTemp[i].plates,
                        salesQuotationDetailShaft               : data.listSalesQuotationDetailTemp[i].shaft,
                        salesQuotationDetailSpring              : data.listSalesQuotationDetailTemp[i].spring,
                        salesQuotationDetailArmPin              : data.listSalesQuotationDetailTemp[i].armPin,
                        salesQuotationDetailBackseat            : data.listSalesQuotationDetailTemp[i].backseat,
                        salesQuotationDetailUnitPrice           : data.listSalesQuotationDetailTemp[i].unitPrice,
                        salesQuotationDetailNote                : data.listSalesQuotationDetailTemp[i].note,
                        salesQuotationDetailValveTag            : data.listSalesQuotationDetailTemp[i].valveTag,
                        salesQuotationDetailDataSheet           : data.listSalesQuotationDetailTemp[i].dataSheet,
                        salesQuotationDetailDescription         : data.listSalesQuotationDetailTemp[i].description,
                        salesQuotationDetailType                : data.listSalesQuotationDetailTemp[i].type,
                        salesQuotationDetailSize                : data.listSalesQuotationDetailTemp[i].size,
                        salesQuotationDetailRating              : data.listSalesQuotationDetailTemp[i].rating,
                        salesQuotationDetailEndCon              : data.listSalesQuotationDetailTemp[i].endCon,
                        salesQuotationDetailBody                : data.listSalesQuotationDetailTemp[i].body,
                        salesQuotationDetailBall                : data.listSalesQuotationDetailTemp[i].ball,
                        salesQuotationDetailSeat                : data.listSalesQuotationDetailTemp[i].seat,
                        salesQuotationDetailStem                : data.listSalesQuotationDetailTemp[i].stem,
                        salesQuotationDetailSeatInsert          : data.listSalesQuotationDetailTemp[i].seatInsert,
                        salesQuotationDetailSeal                : data.listSalesQuotationDetailTemp[i].seal,
                        salesQuotationDetailBolting             : data.listSalesQuotationDetailTemp[i].bolt,
                        salesQuotationDetailSeatDesign          : data.listSalesQuotationDetailTemp[i].seatDesign,
                        salesQuotationDetailOper                : data.listSalesQuotationDetailTemp[i].oper,
                        salesQuotationDetailArm                 : data.listSalesQuotationDetailTemp[i].arm,
                        salesQuotationDetailHingePin            : data.listSalesQuotationDetailTemp[i].hingePin,
                        salesQuotationDetailStopPin             : data.listSalesQuotationDetailTemp[i].stopPin,
                        salesQuotationDetailQuantity            : data.listSalesQuotationDetailTemp[i].quantity,
                        salesQuotationDetailTotal               : data.listSalesQuotationDetailTemp[i].total,
                        salesQuotationDetailValveTypeCode       : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                        salesQuotationDetailValveTypeName       : data.listSalesQuotationDetailTemp[i].valveTypeName
                    });
                }
//                }  calculateSalesQuotationDetail();
            });
    }
    function salesQuotationLoadDataDetailOne() {
        var url = "sales/sales-quotation-detail-data";
        var params = "salesQuotation.code=" + txtSalesQuotationCodeTemp.val();
            $.getJSON(url, params, function(data) {
                salesQuotationDetaillastRowId = 0;
                for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                    salesQuotationDetaillastRowId++;
                    $("#salesQuotationDetailInput_grid").jqGrid("addRowData", salesQuotationDetaillastRowId, data.listSalesQuotationDetailTemp[i]);
                    $("#salesQuotationDetailInput_grid").jqGrid('setRowData',salesQuotationDetaillastRowId,{
                       salesQuotationDetailDelete              : "delete",
                        salesQuotationDetailBodyConstruction    : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                        salesQuotationDetailBore                : data.listSalesQuotationDetailTemp[i].bore,
                        salesQuotationDetailDisc                : data.listSalesQuotationDetailTemp[i].disc,
                        salesQuotationDetailPlates              : data.listSalesQuotationDetailTemp[i].plates,
                        salesQuotationDetailShaft               : data.listSalesQuotationDetailTemp[i].shaft,
                        salesQuotationDetailSpring              : data.listSalesQuotationDetailTemp[i].spring,
                        salesQuotationDetailArmPin              : data.listSalesQuotationDetailTemp[i].armPin,
                        salesQuotationDetailBackseat            : data.listSalesQuotationDetailTemp[i].backseat,
                        salesQuotationDetailUnitPrice           : data.listSalesQuotationDetailTemp[i].unitPrice,
                        salesQuotationDetailNote                : data.listSalesQuotationDetailTemp[i].note,
                        salesQuotationDetailValveTag            : data.listSalesQuotationDetailTemp[i].valveTag,
                        salesQuotationDetailDataSheet           : data.listSalesQuotationDetailTemp[i].dataSheet,
                        salesQuotationDetailDescription         : data.listSalesQuotationDetailTemp[i].description,
                        salesQuotationDetailType                : data.listSalesQuotationDetailTemp[i].type,
                        salesQuotationDetailSize                : data.listSalesQuotationDetailTemp[i].size,
                        salesQuotationDetailRating              : data.listSalesQuotationDetailTemp[i].rating,
                        salesQuotationDetailEndCon              : data.listSalesQuotationDetailTemp[i].endCon,
                        salesQuotationDetailBody                : data.listSalesQuotationDetailTemp[i].body,
                        salesQuotationDetailBall                : data.listSalesQuotationDetailTemp[i].ball,
                        salesQuotationDetailSeat                : data.listSalesQuotationDetailTemp[i].seat,
                        salesQuotationDetailStem                : data.listSalesQuotationDetailTemp[i].stem,
                        salesQuotationDetailSeatInsert          : data.listSalesQuotationDetailTemp[i].seatInsert,
                        salesQuotationDetailSeal                : data.listSalesQuotationDetailTemp[i].seal,
                        salesQuotationDetailBolting             : data.listSalesQuotationDetailTemp[i].bolt,
                        salesQuotationDetailSeatDesign          : data.listSalesQuotationDetailTemp[i].seatDesign,
                        salesQuotationDetailOper                : data.listSalesQuotationDetailTemp[i].oper,
                        salesQuotationDetailArm                 : data.listSalesQuotationDetailTemp[i].arm,
                        salesQuotationDetailHingePin            : data.listSalesQuotationDetailTemp[i].hingePin,
                        salesQuotationDetailStopPin             : data.listSalesQuotationDetailTemp[i].stopPin,
                        salesQuotationDetailQuantity            : data.listSalesQuotationDetailTemp[i].quantity,
                        salesQuotationDetailTotal               : data.listSalesQuotationDetailTemp[i].total,
                        salesQuotationDetailValveTypeCode       : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                        salesQuotationDetailValveTypeName       : data.listSalesQuotationDetailTemp[i].valveTypeName
                    });
                }
//                }  calculateSalesQuotationDetail();
            });
    }
        
    function salesQuotationLoadDataDetailRev() {
        var url = "sales/sales-quotation-detail-data";
        var params = "salesQuotation.code=" + txtSalesQuotationRefSalQUOCode.val();
            $.getJSON(url, params, function(data) {
                salesQuotationDetaillastRowId = 0;
                for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                    salesQuotationDetaillastRowId++;
                    $("#salesQuotationDetailInput_grid").jqGrid("addRowData", salesQuotationDetaillastRowId, data.listSalesQuotationDetailTemp[i]);
                    $("#salesQuotationDetailInput_grid").jqGrid('setRowData',salesQuotationDetaillastRowId,{
                        salesQuotationDetailDelete              : "delete",
                        salesQuotationDetailBodyConstruction    : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                        salesQuotationDetailBore                : data.listSalesQuotationDetailTemp[i].bore,
                        salesQuotationDetailDisc                : data.listSalesQuotationDetailTemp[i].disc,
                        salesQuotationDetailPlates              : data.listSalesQuotationDetailTemp[i].plates,
                        salesQuotationDetailShaft               : data.listSalesQuotationDetailTemp[i].shaft,
                        salesQuotationDetailSpring              : data.listSalesQuotationDetailTemp[i].spring,
                        salesQuotationDetailArmPin              : data.listSalesQuotationDetailTemp[i].armPin,
                        salesQuotationDetailBackseat            : data.listSalesQuotationDetailTemp[i].backseat,
                        salesQuotationDetailUnitPrice           : data.listSalesQuotationDetailTemp[i].unitPrice,
                        salesQuotationDetailNote                : data.listSalesQuotationDetailTemp[i].note,
                        salesQuotationDetailValveTag            : data.listSalesQuotationDetailTemp[i].valveTag,
                        salesQuotationDetailDataSheet           : data.listSalesQuotationDetailTemp[i].dataSheet,
                        salesQuotationDetailDescription         : data.listSalesQuotationDetailTemp[i].description,
                        salesQuotationDetailType                : data.listSalesQuotationDetailTemp[i].type,
                        salesQuotationDetailSize                : data.listSalesQuotationDetailTemp[i].size,
                        salesQuotationDetailRating              : data.listSalesQuotationDetailTemp[i].rating,
                        salesQuotationDetailEndCon              : data.listSalesQuotationDetailTemp[i].endCon,
                        salesQuotationDetailBody                : data.listSalesQuotationDetailTemp[i].body,
                        salesQuotationDetailBall                : data.listSalesQuotationDetailTemp[i].ball,
                        salesQuotationDetailSeat                : data.listSalesQuotationDetailTemp[i].seat,
                        salesQuotationDetailStem                : data.listSalesQuotationDetailTemp[i].stem,
                        salesQuotationDetailSeatInsert          : data.listSalesQuotationDetailTemp[i].seatInsert,
                        salesQuotationDetailSeal                : data.listSalesQuotationDetailTemp[i].seal,
                        salesQuotationDetailBolting             : data.listSalesQuotationDetailTemp[i].bolt,
                        salesQuotationDetailSeatDesign          : data.listSalesQuotationDetailTemp[i].seatDesign,
                        salesQuotationDetailOper                : data.listSalesQuotationDetailTemp[i].oper,
                        salesQuotationDetailQuantity            : data.listSalesQuotationDetailTemp[i].quantity,
                        salesQuotationDetailTotal               : data.listSalesQuotationDetailTemp[i].total,
                        salesQuotationDetailValveTypeCode       : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                        salesQuotationDetailValveTypeName       : data.listSalesQuotationDetailTemp[i].valveTypeName
                    });
                }
//                }  calculateSalesQuotationDetail();
            });
    }
        
    function handlers_input_customer_credit_note(){
        
        if(dtpSalesQuotationTransactionDate.val()===""){
            handlersInput(dtpSalesQuotationTransactionDate);
        }else{
            unHandlersInput(dtpSalesQuotationTransactionDate);
        }
     
    }
    
    function salesQuotationRequestForQuotationLoad(orderStatus){
        if (orderStatus === 'BLANKET_ORDER'){
             $('#salesQuotationRequestForQuotationRadBLANKET_ORDER').prop('checked',true);
             $('#salesQuotationRequestForQuotationRadSALES_ORDER').prop('disabled',true);
        }
        if (orderStatus === 'SALES_ORDER'){
            $('#salesQuotationRequestForQuotationRadSALES_ORDER').prop('checked',true);
            $('#salesQuotationRequestForQuotationRadBLANKET_ORDER').prop('disabled',true);
        }
    }
    
    function checkFileSize(inputFile, holder, noimage,holder2) {
        
         if(!(hasExtension(inputFile.value, ['.xlsx'])|| hasExtension(inputFile.value, ['.xlsx']) )){
             alert("File have to excel file");
             inputFile.value = null;
             $(holder).attr('src', noimage);
             $(holder2).attr('href',noimage);
         }
        
         if (inputFile.files && inputFile.files[0]) {
             var reader = new FileReader();
             reader.onload = function(e) {
                 $(holder).attr('src', e.target.result);
                 $(holder2).attr('href',e.target.result);
             };
             reader.readAsDataURL(inputFile.files[0]);
         }
    }
    
    function hasExtension(fileName, exts) {
        return (new RegExp('(' + exts.join('|').replace(/\./g, '\\.') + ')$')).test(fileName);
    }
    
    function pr_AjaxFileUpload(){
        if(txtSalesQuotationValveTypeCode.val()===""){
            alertMessage("Valve Type Code Must be Filled");
            return false;
        }
        var imgVal = $('#sqExcel').val(); 
        if(imgVal==='') 
        { 
            alertMessage("No File Selected "); 
            return false; 
        } 
        
        showLoading();
        var uploadMode = true;
        var valveType = $("#salesQuotation\\.valveType\\.code").val();
        $("#frmUploadFileSQInput").ajaxForm({
            url:'sales/sales-quotation-excel-import?',
            dataType: 'json',
            data:{uploadMode:uploadMode, 
                  valveType:valveType},
            iframe: true,
            success: function(data) {  
                
                if (data.error) {
                    alertMessage(data.errorMessage);
                    closeLoading();
                    return;
                }
                var msg = '';   
                var no= 0;
                var error_rowid = 0;
                
                $("#salesQuotationDetailErrorInput_grid").jqGrid("clearGridData");
                for(var i=0; i<data.listSalesQuotationDetailTemp.length; i++){
                    for (var k in data.listSalesQuotationDetailTemp[i].list_msg){
                        var datas = data.listSalesQuotationDetailTemp[i].list_msg[k].split(",");
                        var defRow= {
                           salesQuotationDetailErrorNo    :  datas[0],
                           salesQuotationDetailErrorExcel :  datas[1]
                        };
                        $("#salesQuotationDetailErrorInput_grid").jqGrid("addRowData", error_rowid ,defRow);
                        error_rowid++;
                    }
                }
                validationValveTypeComponent(data);
                calculateSalesQuotationHeader();
            }
        });
         closeLoading();
    }
    
    function validationValveTypeComponent(data){
    var ids = jQuery("#salesQuotationDetailErrorInput_grid").jqGrid('getDataIDs');
    if(ids.length > 0){
        alertMessage("Please Review Below Warning!");
        $('#sqExcel').val('');
        return false;
    }else{
            for(var i=0; i<data.listSalesQuotationDetailTemp.length; i++){
                var total = parseFloat(data.listSalesQuotationDetailTemp[i].quantity) * parseFloat(data.listSalesQuotationDetailTemp[i].unitPrice);
                salesQuotationDetaillastRowId++;
                $("#salesQuotationDetailInput_grid").jqGrid("addRowData", salesQuotationDetaillastRowId, data.listSalesQuotationDetailTemp[i]);
                $("#salesQuotationDetailInput_grid").jqGrid('setRowData',salesQuotationDetaillastRowId,{
                    salesQuotationDetailDelete              : "delete",
                    salesQuotationDetailValveTypeCode       : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                    salesQuotationDetailValveTypeName       : data.listSalesQuotationDetailTemp[i].valveTypeName,
                    salesQuotationDetailValveTag            : data.listSalesQuotationDetailTemp[i].valveTag,
                    salesQuotationDetailDataSheet           : data.listSalesQuotationDetailTemp[i].dataSheet,
                    salesQuotationDetailDescription         : data.listSalesQuotationDetailTemp[i].description,
                    salesQuotationDetailTypeDesign          : data.listSalesQuotationDetailTemp[i].typeDesign,
                    salesQuotationDetailBodyConstruction    : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                    salesQuotationDetailSize                : data.listSalesQuotationDetailTemp[i].size,
                    salesQuotationDetailRating              : data.listSalesQuotationDetailTemp[i].rating,
                    salesQuotationDetailEndCon              : data.listSalesQuotationDetailTemp[i].endCon,
                    salesQuotationDetailBody                : data.listSalesQuotationDetailTemp[i].body,
                    salesQuotationDetailBall                : data.listSalesQuotationDetailTemp[i].ball,
                    salesQuotationDetailSeat                : data.listSalesQuotationDetailTemp[i].seat,
                    salesQuotationDetailStem                : data.listSalesQuotationDetailTemp[i].stem,
                    salesQuotationDetailSeatInsert          : data.listSalesQuotationDetailTemp[i].seatInsert,
                    salesQuotationDetailSeal                : data.listSalesQuotationDetailTemp[i].seal,
                    salesQuotationDetailBolting             : data.listSalesQuotationDetailTemp[i].bolt,
                    salesQuotationDetailSeatDesign          : data.listSalesQuotationDetailTemp[i].seatDesign,
                    salesQuotationDetailOper                : data.listSalesQuotationDetailTemp[i].oper,
                    salesQuotationDetailDisc                : data.listSalesQuotationDetailTemp[i].disc,
                    salesQuotationDetailPlates              : data.listSalesQuotationDetailTemp[i].plates,
                    salesQuotationDetailShaft               : data.listSalesQuotationDetailTemp[i].shaft,
                    salesQuotationDetailSpring              : data.listSalesQuotationDetailTemp[i].spring,
                    salesQuotationDetailArmPin              : data.listSalesQuotationDetailTemp[i].armPin,
                    salesQuotationDetailBackseat            : data.listSalesQuotationDetailTemp[i].backseat,
                    salesQuotationDetailBore                : data.listSalesQuotationDetailTemp[i].bore,
                    salesQuotationDetailArm                 : data.listSalesQuotationDetailTemp[i].arm,
                    salesQuotationDetailHingePin            : data.listSalesQuotationDetailTemp[i].hingePin,
                    salesQuotationDetailStopPin             : data.listSalesQuotationDetailTemp[i].stopPin,
                    salesQuotationDetailNote                : data.listSalesQuotationDetailTemp[i].note,
                    salesQuotationDetailUnitPrice           : data.listSalesQuotationDetailTemp[i].unitPrice,
                    salesQuotationDetailQuantity            : data.listSalesQuotationDetailTemp[i].quantity,
                    salesQuotationDetailTotal               : total

                });
            }
            $('#sqExcel').val('');
        }
 }
    
</script>

<s:url id="remoteurlSalesQuotationDetailInput" action="" />
<b>SALES QUOTATION</b>
<hr>
<br class="spacer" />

<div id="salesQuotationInput" class="content ui-widget">
    <s:form id="frmSalesQuotationInput">
        <table cellpadding="2" cellspacing="2" id="headerSalesQuotationInput">
        <tr>
            <td valign="top">
         <table>
           <tr>
                <td align="right" hidden = "true">SLS-QOU No
                <s:textfield id="salesQuotation.salQuoNo" name="salesQuotation.salQuoNo" key="salesQuotation.salQuoNo" size="25"></s:textfield>
                <s:textfield id="salesQuotationUpdateMode" name="salesQuotationUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationCloneMode" name="salesQuotationCloneMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationReviseMode" name="salesQuotationReviseMode" size="20" cssStyle="display:none"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>SLS-QOU No *</B></td>
                <td>
                    <s:textfield id="salesQuotation.code" name="salesQuotation.code" key="salesQuotation.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="salesQuotationTemp.code" name="salesQuotationTemp.code" key="salesQuotationTemp.code" readonly="true" hidden = "true" size="22"></s:textfield>
                    <s:textfield id="salesQuotationUpdateMode" name="salesQuotationUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="salesQuotationCloneMode" name="salesQuotationCloneMode" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="salesQuotationReviseMode" name="salesQuotationReviseMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" hidden = "true">Revision
                <s:textfield id="salesQuotation.revision" name="salesQuotation.revision" key="salesQuotation.revision" size="25"></s:textfield>
                <s:textfield id="salesQuotationUpdateMode" name="salesQuotationUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationCloneMode" name="salesQuotationCloneMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationReviseMode" name="salesQuotationReviseMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref Sal Quo No </td>
                <td><s:textfield id="salesQuotation.refSalQUOCode" name="salesQuotation.refSalQUOCode" key="salesQuotation.refSalQUOCode" readonly="true" size="25"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="salesQuotation.transactionDate" name="salesQuotation.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="salesQuotationTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                    <sj:datepicker id="salesQuotationTransactionDate" name="salesQuotationTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="salesQuotationTemp.transactionDateTemp" name="salesQuotationTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>RFQ No *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtSalesQuotationRequestForQuotationCode.change(function(ev) {
                        if(txtSalesQuotationRequestForQuotationCode.val()===""){
                            txtSalesQuotationRequestForQuotationBranchCode.val("");
                            txtSalesQuotationRequestForQuotationBranchName.val("");
                            txtSalesQuotationRequestForQuotationProjectCode.val("");
                            txtSalesQuotationRequestForQuotationProjectName.val("");
                            txtSalesQuotationRequestForQuotationCurrencyCode.val("");
                            txtSalesQuotationRequestForQuotationCurrencyName.val("");
                            txtSalesQuotationRequestForQuotationCustomerCode.val("");
                            txtSalesQuotationRequestForQuotationCustomerName.val("");
                            txtSalesQuotationRequestForQuotationEndUserCode.val("");
                            txtSalesQuotationRequestForQuotationEndUserName.val("");
                            txtSalesQuotationRequestForQuotationSalesPersonCode.val("");
                            txtSalesQuotationRequestForQuotationSalesPersonName.val("");
                            txtSalesQuotationRequestForQuotationSubject.val("");
                            txtSalesQuotationRequestForQuotationAttn.val("");
                            rdbSalesQuotationRequestForQuotationOrderStatus.val("");
                            return;
                        }

                        var url = "sales/request-for-quotation-get";
                        var params = "requestForQuotation.code=" +txtSalesQuotationRequestForQuotationCode.val();
//                                        params += "&RequestForQuotation.activeStatus=true";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.requestForQuotationTemp){
                                txtSalesQuotationRequestForQuotationCode.val(data.requestForQuotationTemp.code);
                                txtSalesQuotationRequestForQuotationBranchCode.val(data.requestForQuotationTemp.branchCode);
                                txtSalesQuotationRequestForQuotationBranchName.val(data.requestForQuotationTemp.branchName);
                                txtSalesQuotationRequestForQuotationProjectCode.val(data.requestForQuotationTemp.projectCode);
                                txtSalesQuotationRequestForQuotationProjectName.val(data.requestForQuotationTemp.projectName);
                                txtSalesQuotationRequestForQuotationCurrencyCode.val(data.requestForQuotationTemp.currencyCode);
                                txtSalesQuotationRequestForQuotationCurrencyName.val(data.requestForQuotationTemp.currencyName);
                                txtSalesQuotationRequestForQuotationCustomerCode.val(data.requestForQuotationTemp.customerUserCode);
                                txtSalesQuotationRequestForQuotationCustomerName.val(data.requestForQuotationTemp.customerUserName);
                                txtSalesQuotationRequestForQuotationEndUserCode.val(data.requestForQuotationTemp.endUserCode);
                                txtSalesQuotationRequestForQuotationEndUserName.val(data.requestForQuotationTemp.endUserName);
                                txtSalesQuotationRequestForQuotationSalesPersonCode.val(data.requestForQuotationTemp.salesPersonCode);
                                txtSalesQuotationRequestForQuotationSalesPersonName.val(data.requestForQuotationTemp.salesPersonName);
                                txtSalesQuotationRequestForQuotationSubject.val(data.requestForQuotationTemp.subject);
                                txtSalesQuotationRequestForQuotationAttn.val(data.requestForQuotationTemp.attn);
                                rdbSalesQuotationRequestForQuotationOrderStatus.val(data.requestForQuotationTemp.orderStatus);
                                salesQuotationRequestForQuotationLoad();
                            }

                            else{
                                alertMessage("RFQ Not Found!",txtSalesQuotationRequestForQuotationCode);
                                txtSalesQuotationRequestForQuotationCode.val("");
                                txtSalesQuotationRequestForQuotationBranchCode.val("");
                                txtSalesQuotationRequestForQuotationBranchName.val("");
                                txtSalesQuotationRequestForQuotationProjectCode.val("");
                                txtSalesQuotationRequestForQuotationProjectName.val("");
                                txtSalesQuotationRequestForQuotationCurrencyCode.val("");
                                txtSalesQuotationRequestForQuotationCurrencyName.val("");
                                txtSalesQuotationRequestForQuotationCustomerCode.val("");
                                txtSalesQuotationRequestForQuotationCustomerName.val("");
                                txtSalesQuotationRequestForQuotationEndUserCode.val("");
                                txtSalesQuotationRequestForQuotationEndUserName.val("");
                                txtSalesQuotationRequestForQuotationSalesPersonCode.val("");
                                txtSalesQuotationRequestForQuotationSalesPersonName.val("");
                                txtSalesQuotationRequestForQuotationSubject.val("");
                                txtSalesQuotationRequestForQuotationAttn.val("");
                                rdbSalesQuotationRequestForQuotationOrderStatus.val("");
                            }
                        });
                    });

                    </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="salesQuotation.requestForQuotation.code" name="salesQuotation.requestForQuotation.code" title=" " required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                            <sj:a id="salesQuotation_btnRequestForQuotation" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                </td>
            </tr>
            <tr>
            <td align="right">Order Status</td>
            <td>
                <s:textfield id="salesQuotation.requestForQuotation.orderStatus" name="salesQuotation.requestForQuotation.orderStatus" readonly="true" size="20" style="display:none"></s:textfield>
                <s:textfield id="salesQuotation.orderStatus" name="salesQuotation.orderStatus" readonly="true" size="20" style="display:none"></s:textfield>
                <s:radio id="salesQuotationRequestForQuotationRad" name="salesQuotationRequestForQuotationRad" list="{'BLANKET_ORDER','SALES_ORDER'}" ></s:radio></td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.branch.code" name="salesQuotation.requestForQuotation.branch.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.requestForQuotation.branch.name" name="salesQuotation.requestForQuotation.branch.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.branch.code" name="salesQuotation.branch.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                    <s:textfield id="salesQuotation.branch.name" name="salesQuotation.branch.name" size="35%" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Project</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.project.code" name="salesQuotation.requestForQuotation.project.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.requestForQuotation.project.name" name="salesQuotation.requestForQuotation.project.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.project.code" name="salesQuotation.project.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                    <s:textfield id="salesQuotation.project.name" name="salesQuotation.project.name" size="35%" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Subject</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.subject" name="salesQuotation.requestForQuotation.subject" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.subject" name="salesQuotation.subject" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Currency</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.currency.code" name="salesQuotation.requestForQuotation.currency.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.requestForQuotation.currency.name" name="salesQuotation.requestForQuotation.currency.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.currency.code" name="salesQuotation.currency.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                    <s:textfield id="salesQuotation.currency.name" name="salesQuotation.currency.name" size="35%" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.customer.code" name="salesQuotation.requestForQuotation.customer.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.requestForQuotation.customer.name" name="salesQuotation.requestForQuotation.customer.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.customer.code" name="salesQuotation.customer.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                    <s:textfield id="salesQuotation.customer.name" name="salesQuotation.customer.name" size="35%" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">End User</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.endUser.code" name="salesQuotation.requestForQuotation.endUser.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.requestForQuotation.endUser.name" name="salesQuotation.requestForQuotation.endUser.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.endUser.code" name="salesQuotation.endUser.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                    <s:textfield id="salesQuotation.endUser.name" name="salesQuotation.endUser.name" size="35%" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Attn</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.attn" name="salesQuotation.requestForQuotation.attn" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.attn" name="salesQuotation.attn" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Sales Person</td>
                <td>
                    <s:textfield id="salesQuotation.requestForQuotation.salesPerson.code" name="salesQuotation.requestForQuotation.salesPerson.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.requestForQuotation.salesPerson.name" name="salesQuotation.requestForQuotation.salesPerson.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotation.salesPerson.code" name="salesQuotation.salesPerson.code" size="20" maxLength="45" readonly="true" hidden="true"></s:textfield>
                    <s:textfield id="salesQuotation.salesPerson.name" name="salesQuotation.salesPerson.name" size="35%" maxLength="45" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:120px"><B>Ship To (City) *</B></td>
                <td colspan="2">
                <script type = "text/javascript">

                    txtSalesQuotationShipToCode.change(function(ev) {

                        if(txtSalesQuotationShipToCode.val()===""){
                            txtSalesQuotationShipToName.val("");
                            return;
                        }
                        var url = "master/city-get";
                        var params = "city.code=" + txtSalesQuotationShipToCode.val();
                            params += "&city.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.cityTemp){
                                txtSalesQuotationShipToCode.val(data.cityTemp.code);
                                txtSalesQuotationShipToName.val(data.cityTemp.name);
                            }
                            else{
                                alertMessage("City Not Found!",txtSalesQuotationShipToCode);
                                txtSalesQuotationShipToCode.val("");
                                txtSalesQuotationShipToName.val("");
                            }
                        });
                    });

                </script>
                <div class="searchbox ui-widget-header" hidden="true">
                    <s:textfield id="salesQuotation.city.code" name="salesQuotation.city.code" size="22"></s:textfield>
                    <sj:a id="salesQuotation_btnCity" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                </div>
                    <s:textfield id="salesQuotation.city.name" name="salesQuotation.city.name" size="25" readonly="true" required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:120px"><B>Term Of Delivery *</B></td>
                <td colspan="2">
                <script type = "text/javascript">

                    txtSalesQuotationTermOfDeliveryCode.change(function(ev) {

                        if(txtSalesQuotationTermOfDeliveryCode.val()===""){
                            txtSalesQuotationTermOfDeliveryName.val("");
                            return;
                        }
                        var url = "master/term-of-delivery-get";
                        var params = "termOfDelivery.code=" + txtSalesQuotationTermOfDeliveryCode.val();
                            params += "&termOfDelivery.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.termOfDeliveryTemp){
                                txtSalesQuotationTermOfDeliveryCode.val(data.termOfDeliveryTemp.code);
                                txtSalesQuotationTermOfDeliveryName.val(data.termOfDeliveryTemp.name);
                            }
                            else{
                                alertMessage("Term Of Delivery Not Found!",txtSalesQuotationTermOfDeliveryCode);
                                txtSalesQuotationTermOfDeliveryCode.val("");
                                txtSalesQuotationTermOfDeliveryName.val("");
                            }
                        });
                    });

                </script>
                <div class="searchbox ui-widget-header" hidden="true">
                    <s:textfield id="salesQuotation.termOfDelivery.code" name="salesQuotation.termOfDelivery.code" size="22"></s:textfield>
                    <sj:a id="salesQuotation_btnTermOfDelivery" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                </div>
                    <s:textfield id="salesQuotation.termOfDelivery.name" name="salesQuotation.termOfDelivery.name" size="25" readonly="true" required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            </table>
       </td>
       <td valign="top">
       <table>
            <tr>
                <td align="right">Price Validity</td>
                <td colspan="3">
                    <s:textfield id="salesQuotation.priceValidity" name="salesQuotation.priceValidity" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Certificate Documentation</td>
                <td colspan="3">
                    <s:textarea id="salesQuotation.certificateDocumentation" name="salesQuotation.certificateDocumentation"  cols="70" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Testing</td>
                <td colspan="3">
                    <s:textarea id="salesQuotation.testing" name="salesQuotation.testing"  cols="70" rows="3" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Inspection</td>
                <td colspan="3">
                    <s:textarea id="salesQuotation.inspection" name="salesQuotation.inspection"  cols="70" rows="3" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Painting</td>
                <td colspan="3">
                    <s:textarea id="salesQuotation.painting" name="salesQuotation.painting"  cols="70" rows="3" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Packing</td>
                <td colspan="3">
                    <s:textfield id="salesQuotation.packing" name="salesQuotation.packing"  size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Tagging</td>
                <td colspan="3">
                    <s:textfield id="salesQuotation.tagging" name="salesQuotation.tagging"  size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Warranty</td>
                <td colspan="3">
                    <s:textfield id="salesQuotation.warranty" name="salesQuotation.warranty"  size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Payment</td>
                <td colspan="3">
                    <s:textarea id="salesQuotation.payment" name="salesQuotation.payment"  cols="70" rows="3" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3">
                    <s:textfield id="salesQuotation.refNo" name="salesQuotation.refNo" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="salesQuotation.remark" name="salesQuotation.remark" cols="70" rows="3" height="20"></s:textarea>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="salesQuotation.createdBy" name="salesQuotation.createdBy" key="salesQuotation.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="salesQuotation.createdDate" name="salesQuotation.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <sj:datepicker id="salesQuotationTransactionDateFirstSession" name="salesQuotationTransactionDateFirstSession" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    <sj:datepicker id="salesQuotationTransactionDateLastSession" name="salesQuotationTransactionDateLastSession" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="salesQuotationTemp.createdDateTemp" name="salesQuotationTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table>
                </td>
        <table>
            <tr>
                <td align="left">
                    <sj:a href="#" id="btnConfirmSalesQuotation" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmSalesQuotation" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        </s:form>
        <br class="spacer" />
    <div id="salesQuotationDetailInputGrid">
        <s:form id="frmUploadFileSQInput">
                <table class="tableBottomSQ">
                    <tr>
                        <td  align="left"><B>Valve Type * </B>
                            <script type = "text/javascript">

                                    $('#salesQuotation_btnValveType').click(function(ev) {
                                        window.open("./pages/search/search-valve-type.jsp?iddoc=salesQuotation&idsubdoc=valveType","Search", "width=600, height=500");
                                    });     

                            txtSalesQuotationValveTypeCode.change(function(ev) {
                                    if(txtSalesQuotationValveTypeCode.val()===""){
                                        txtSalesQuotationValveTypeCode.val("");
                                        txtSalesQuotationValveTypeName.val("");
                                        return;
                                    }

                                    var url = "master/valve-type-get";
                                    var params = "valveType.code=" + txtSalesQuotationValveTypeCode.val();
                                        params += "&valveType.activeStatus="+true;
                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.valveTypeTemp){
                                            txtSalesQuotationValveTypeCode.val(data.valveTypeTemp.code);
                                            txtSalesQuotationValveTypeName.val(data.valveTypeTemp.name);
                                        }else{ 
                                            alertMessage("Valve Type Not Found!",txtSalesQuotationValveTypeCode);
                                            txtSalesQuotationValveTypeCode.val("");
                                            txtSalesQuotationValveTypeName.val("");
                                        }
                                    });
                                });

                            </script>
                                <div class="searchbox ui-widget-header">
                                <s:textfield id="salesQuotation.valveType.code" name="salesQuotation.valveType.code" title=" " required="true" cssClass="required" size="20"></s:textfield>
                                    <sj:a id="salesQuotation_btnValveType" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                            <s:textfield id="salesQuotation.valveType.name" name="salesQuotation.valveType.name" size="30" readonly="true"></s:textfield> 
                        </td>
                    </tr>
                    <tr>
                        <td id="image-new" align="left"> Import File *
                            <s:file id="sqExcel" size="45" name="sqExcel" onchange="checkFileSize(this,'#idPreviewHolder1','images/no_image.xls','#previewHolder1')" class="input"/>
                            <button class="ui-button-text" id="buttonSaveFileSQ" onclick="return pr_AjaxFileUpload();">Process</button>
                        </td>
                    </tr>
                </table>
            </s:form>
            <sjg:grid
                id="salesQuotationDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listSalesQuotationDetailTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuSalesQuotationDetail').width()"
                editurl="%{remoteurlSalesQuotationDetailInput}"
                onSelectRowTopics="salesQuotationDetailInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name="salesQuotationDetail" index="salesQuotationDetail" key="salesQuotationDetail" title=""
                    width="200" sortable="true" editable="true" edittype="text" hidden="true"
                /> 
                <sjg:gridColumn
                    name="salesQuotationDetailDelete" index="salesQuotationDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'salesQuotationDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailValveTypeCode" index="salesQuotationDetailValveTypeCode" key="salesQuotationDetailValveTypeCode" 
                    title="Valve Type Code" width="200" sortable="true" editable="false" edittype="text"
                />     
                <sjg:gridColumn
                    name="salesQuotationDetailValveTypeName" index="salesQuotationDetailValveTypeName" key="salesQuotationDetailValveTypeName" 
                    title="Valve Type Name" width="200" sortable="true" editable="false" edittype="text" 
                />     
                <sjg:gridColumn
                    name="salesQuotationDetailValveTag" index="salesQuotationDetailValveTag" key="salesQuotationDetailValveTag" 
                    title="Valve Tag" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailDataSheet" index="salesQuotationDetailDataSheet" key="salesQuotationDetailDataSheet" 
                    title="Data Sheet" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailDescription" index="salesQuotationDetailDescription" key="salesQuotationDetailDescription" 
                    title="Description" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailBodyConstruction" index="salesQuotationDetailBodyConstruction" key="salesQuotationDetailBodyConstruction" 
                    title="Body Construction (01)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailTypeDesign" index="salesQuotationDetailTypeDesign" key="salesQuotationDetailTypeDesign" 
                    title="Type Design (02)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailSeatDesign" index="salesQuotationDetailSeatDesign" key="salesQuotationDetailSeatDesign" 
                    title="Seat Design (03)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailSize" index="salesQuotationDetailSize" key="salesQuotationDetailSize" 
                    title="Size (04)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailRating" index="salesQuotationDetailRating" key="salesQuotationDetailRating" 
                    title="Rating (05)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailBore" index="salesQuotationDetailBore" key="salesQuotationDetailBore" 
                    title="Bore (06)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailEndCon" index="salesQuotationDetailEndCon" key="salesQuotationDetailEndCon" 
                    title="End Con (07)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailBody" index="salesQuotationDetailBody" key="salesQuotationDetailBody" 
                    title="Body (08)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailBall" index="salesQuotationDetailBall" key="salesQuotationDetailBall" 
                    title="Ball (09)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailSeat" index="salesQuotationDetailSeat" key="salesQuotationDetailSeat" 
                    title="Seat (10)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailSeatInsert" index="salesQuotationDetailSeatInsert" key="salesQuotationDetailSeatInsert" 
                    title="Seat Insert (11)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailStem" index="salesQuotationDetailStem" key="salesQuotationDetailStem" 
                    title="Stem (12)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailSeal" index="salesQuotationDetailSeal" key="salesQuotationDetailSeal" 
                    title="Seal (13)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailBolting" index="salesQuotationDetailBolting" key="salesQuotationDetailBolting" 
                    title="Bolt (14)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailDisc" index="salesQuotationDetailDisc" key="salesQuotationDetailDisc" 
                    title="Disc (15)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailPlates" index="salesQuotationDetailPlates" key="salesQuotationDetailPlates" 
                    title="Plates (16)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailShaft" index="salesQuotationDetailShaft" key="salesQuotationDetailShaft" 
                    title="Shaft (17)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailSpring" index="salesQuotationDetailSpring" key="salesQuotationDetailSpring" 
                    title="Spring (18)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailArmPin" index="salesQuotationDetailArmPin" key="salesQuotationDetailArmPin" 
                    title="Arm Pin (19)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailBackseat" index="salesQuotationDetailBackseat" key="salesQuotationDetailBackseat" 
                    title="Backseat (20)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailArm" index="salesQuotationDetailArm" key="salesQuotationDetailArm" 
                    title="Arm (21)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailHingePin" index="salesQuotationDetailHingePin" key="salesQuotationDetailHingePin" 
                    title="Hinge Pin (22)" width="150" sortable="true" editable="false"
                /> 
                <sjg:gridColumn
                    name="salesQuotationDetailStopPin" index="salesQuotationDetailStopPin" key="salesQuotationDetailStopPin" 
                    title="Stop Pin (23)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailOper" index="salesQuotationDetailOper" key="salesQuotationDetailOper" 
                    title="Oper (99)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailNote" index="salesQuotationDetailNote" key="salesQuotationDetailNote" 
                    title="Note" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailQuantity" index="salesQuotationDetailQuantity" key="salesQuotationDetailQuantity" title="Quantity" 
                    width="80" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }"
                    editoptions="{onKeyUp:'calculateSalesQuotationDetail()'}"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailUnitPrice" index="salesQuotationDetailUnitPrice" key="salesQuotationDetailUnitPrice" title="UnitPrice" 
                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                    formatter="number" editrules="{ double: true }"
                    editoptions="{onKeyUp:'calculateSalesQuotationDetail()'}"
                />
                <sjg:gridColumn
                    name="salesQuotationDetailTotal" index="salesQuotationDetailTotal" key="salesQuotationDetailTotal" title="Total" 
                    width="150" align="right" editable="false" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
            </sjg:grid >
        </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                       <tr height="10px"/>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnSalesQuotationSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnSalesQuotationCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
        </table>


        <s:form id="frmSalesQuotation">
            <table width="100%">
                <tr>
                    <td align="right"><B>Total Transaction</B></td>
                    <td width="100px">
                        <s:textfield id="salesQuotation.totalTransactionAmount" name="salesQuotation.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Discount
                        <s:textfield id="salesQuotation.discountPercent" onkeyup="calculateSalesQuotationHeader()" name="salesQuotation.discountPercent" size="5" cssStyle="text-align:right"></s:textfield>
                        %
                    </td>
                    <td><s:textfield id="salesQuotation.discountAmount" onchange="calculateSalesQuotationHeader()" name="salesQuotation.discountAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Sub Total(Tax Base)</B></td>
                    <td>
                        <s:textfield id="salesQuotation.taxBaseAmount" name="salesQuotation.taxBaseAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">VAT
                    <s:textfield id="salesQuotation.vatPercent" onkeyup="calculateSalesQuotationHeader()" name="salesQuotation.vatPercent" size="5" cssStyle="text-align:right"></s:textfield>
                        %
                    </td>
                    <td><s:textfield id="salesQuotation.vatAmount" name="salesQuotation.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Grand Total</B></td>
                    <td>
                        <s:textfield id="salesQuotation.grandTotalAmount" name="salesQuotation.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
        </s:form>              
           
    <div>                        
       <sjg:grid
                id="salesQuotationDetailErrorInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listErrorMessageImportExcel"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuSalesQuotationDetail').width()"
                editurl="%{remoteurlSalesQuotationDetailInput}"
                onSelectRowTopics="salesQuotationDetailInput_grid_onSelect"
                >   
                <sjg:gridColumn
                    name="salesQuotationDetailErrorNo" index="salesQuotationDetailErrorNo" key="salesQuotationDetailErrorNo" 
                    title="Row No" width="100" sortable="true" editable="false" edittype="text" 
                />     
                <sjg:gridColumn
                    name="salesQuotationDetailErrorExcel" index="salesQuotationDetailErrorExcel" key="salesQuotationDetailErrorExcel" 
                    title="Error Message" width="350" sortable="true" editable="false" 
                />
        </sjg:grid >   
    </div>  
</div> 
<br class="spacer" />
<br class="spacer" />
        
    