
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #vendorCreditNoteDetailInput_grid_pager_center{
        display: none;
    }
    #errmsgExchangeRate,#errmsgAddRow{
        color: red;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var vendorCreditNoteDetaillastRowId=0,vendorCreditNoteDetail_lastSel = -1;
    var vendorCreditNoteFlagConfirmed=false;
    var 
        txtVendorCreditNoteCode= $("#vendorCreditNote\\.code"),
        txtVendorCreditNoteBranchCode = $("#vendorCreditNote\\.branch\\.code"),
        txtVendorCreditNoteBranchName = $("#vendorCreditNote\\.branch\\.name"),
        dtpVendorCreditNoteTransactionDate= $("#vendorCreditNote\\.transactionDate"),
        dtpVendorCreditNoteDueDate = $("#vendorCreditNote\\.dueDate"),
        txtVendorCreditNoteExchangeRate= $("#vendorCreditNote\\.exchangeRate"),
        txtVendorCreditNoteCurrencyCode= $("#vendorCreditNote\\.currency\\.code"),
        txtVendorCreditNoteCurrencyName= $("#vendorCreditNote\\.currency\\.name"),
        txtVendorCreditNoteDiscountAccountCode= $("#vendorCreditNote\\.discountAccount\\.code"),
        txtVendorCreditNoteDiscountAccountName= $("#vendorCreditNote\\.discountAccount\\.name"),
        txtVendorCreditNoteVendorCode= $("#vendorCreditNote\\.vendor\\.code"),
        txtVendorCreditNoteVendorName= $("#vendorCreditNote\\.vendor\\.name"),
        txtVendorCreditNoteTaxInvoiceNo= $("#vendorCreditNote\\.taxInvoiceNo"),
        dtpVendorCreditNoteTaxInvoiceDate= $("#vendorCreditNote\\.taxInvoiceDate"),
        txtVendorCreditNoteVendorInvoiceNo= $("#vendorCreditNote\\.vendorInvoiceNo"),
        dtpVendorCreditNoteVendorInvoiceDate= $("#vendorCreditNote\\.vendorInvoiceDate"),
        txtVendorCreditNoteRefNo = $("#vendorCreditNote\\.refNo"),
        txtVendorCreditNoteRemark = $("#vendorCreditNote\\.remark"),
        txtVendorCreditNoteTotalTransactionAmount = $("#vendorCreditNote\\.totalTransactionAmount"),
        txtVendorCreditNoteDiscountPercent = $("#vendorCreditNote\\.discountPercent"),
        txtVendorCreditNoteDiscountAmount = $("#vendorCreditNote\\.discountAmount"),
        txtVendorCreditNoteSubTotalAmount = $("#vendorCreditNoteSubTotal"),
        txtVendorCreditNoteVATPercent = $("#vendorCreditNote\\.vatPercent"),
        txtVendorCreditNoteVATAmount = $("#vendorCreditNote\\.vatAmount"),
        txtVendorCreditNoteGrandTotalAmount = $("#vendorCreditNote\\.grandTotalAmount"),
        dtpVendorCreditNoteCreatedDate = $("#vendorCreditNote\\.createdDate"),
        txtVendorCreditNotePaymentTermCode = $("#vendorCreditNote\\.paymentTerm\\.code"),
        txtVendorCreditNotePaymentTermName = $("#vendorCreditNote\\.paymentTerm\\.name"),
        txtVendorCreditNotePaymentTermDays = $("#vendorCreditNote\\.paymentTerm\\.days"),
        
        allVendorCreditNoteFields = $([])
            .add(txtVendorCreditNoteVendorCode)
            .add(txtVendorCreditNotePaymentTermCode)
            .add(txtVendorCreditNotePaymentTermName)
            .add(txtVendorCreditNotePaymentTermDays)
            .add(txtVendorCreditNoteCurrencyName)
            .add(txtVendorCreditNoteTaxInvoiceNo)
            .add(txtVendorCreditNoteRefNo)
            .add(txtVendorCreditNoteRemark);

    
    $(document).ready(function() {
        
        vendorCreditNoteFlagConfirmed=false;      
        vendorCreditNoteLoadExchangeRate();
        vendorCreditNoteFormatNumeric();
        if($("#vendorCreditNoteUpdateMode").val()==="false"){
            setCurrency();
        }
        $("#vendorCreditNoteDetailAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#vendorCreditNoteDetailAddRow").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommas(value);
            });
        });
        
        $("#vendorCreditNote\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorCreditNote\\.exchangeRate").change(function(e){
            var exrate=$("#vendorCreditNote\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#vendorCreditNote\\.exchangeRate").val("1.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
                
        $("#vendorCreditNote\\.discountPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#vendorCreditNote\\.discountPercent").change(function(e){
            var amount=$("#vendorCreditNote\\.discountPercent").val();
            if(amount===""){
               $("#vendorCreditNote\\.discountPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $("#vendorCreditNote\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorCreditNote\\.vatPercent").change(function(e){
            var amount=$("#vendorCreditNote\\.vatPercent").val();
            if(amount===""){
               $("#vendorCreditNote\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        

        $('#btnVendorCreditNoteSave').click(function(ev) {
            
            if(!vendorCreditNoteFlagConfirmed){
                alertMessage("Please Confirm!",$("#btnConfirmVendorCreditNote"));
                return;
            }
            
            if(vendorCreditNoteDetail_lastSel !== -1) {
                $('#vendorCreditNoteDetailInput_grid').jqGrid("saveRow",vendorCreditNoteDetail_lastSel); 
            }

            var listVendorCreditNoteDetail = new Array(); 
            var ids = jQuery("#vendorCreditNoteDetailInput_grid").jqGrid('getDataIDs'); 

            if(ids.length===0){
                alertMessage("Data Detail Can't Empty!");
                return;
            }
            

            for(var i=0;i < ids.length;i++){ 
                var data = $("#vendorCreditNoteDetailInput_grid").jqGrid('getRowData',ids[i]); 


                if(data.vendorCreditNoteDetailChartOfAccountCode===""){
                    alertMessage("Chart Of Account Code Can't Empty!");
                    return;
                }
                
                if(data.vendorCreditNoteDetailUnitOfMeasureCode===""){
                    alertMessage("Unit Of Measure Code Can't Empty!");
                    return;
                }

                var vendorCreditNoteDetail = { 
                    remark              : data.vendorCreditNoteDetailRemark,
                    chartOfAccount          : {code:data.vendorCreditNoteDetailChartOfAccountCode},
                    quantity            : data.vendorCreditNoteDetailQuantity,
                    unitOfMeasure          : {code:data.vendorCreditNoteDetailUnitOfMeasureCode},
                    branch              : {code:data.vendorCreditNoteDetailBranchCode},
                    price               : data.vendorCreditNoteDetailPrice,
                    totalAmount         : data.vendorCreditNoteDetailTotal
                };

                listVendorCreditNoteDetail[i] = vendorCreditNoteDetail;
            }
            
            if(parseFloat(txtVendorCreditNoteTotalTransactionAmount.val())===0.00){
                alertMessage("Can't be 0 value for Total Transaction!");
                return;
            }
            
            if(txtVendorCreditNoteDiscountPercent.val()!=0 && txtVendorCreditNoteDiscountAccountCode.val()===""){
                alertMessage("Discount Account Cant be Empty");
                return;
            }
            
            unHandlersInput(txtVendorCreditNoteDiscountPercent);
            
            vendorCreditNoteFormatDate();
            vendorCreditNoteUnFormatNumeric();
            
            var url = "finance/vendor-credit-note-save";
            var params = $("#frmVendorCreditNoteInput").serialize();
                params += "&listVendorCreditNoteDetailJSON=" + $.toJSON(listVendorCreditNoteDetail);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    vendorCreditNoteFormatDate();
                    vendorCreditNoteFormatNumeric();
                    alertMessage(data.errorMessage);
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
                                var url = "finance/vendor-credit-note-input";
                                var params = "";
                                pageLoad(url, params, "#tabmnuVENDOR_CREDIT_NOTE");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "finance/vendor-credit-note";
                                var params = "";
                                pageLoad(url, params, "#tabmnuVENDOR_CREDIT_NOTE");

                            }
                        }]
                });
            });
        });

        $("#btnUnConfirmVendorCreditNote").css("display", "none");
        $('#vendorCreditNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmVendorCreditNote").click(function(ev) {
            vendor_credit_note_handlers_input();
            vendorCreditNoteTransactionDateOnChange();
             if(txtVendorCreditNoteBranchCode.val()===''){
                alertMessage("Branch Cant be Empty");
                return;
            }
            if(txtVendorCreditNoteCurrencyCode.val()===''){
                alertMessage("Currency Cant be Empty");
                return;
            }
            if(txtVendorCreditNoteVendorCode.val()===''){
                alertMessage("Vendor Cant be Empty");
                return;
            }
            if(txtVendorCreditNotePaymentTermCode.val()===''){
                alertMessage("Payment Term Cant be Empty");
                return;
            }
        
            if(parseFloat(txtVendorCreditNoteExchangeRate.val())<=1 && txtVendorCreditNoteCurrencyCode.val()!=="IDR"){
           
                txtVendorCreditNoteExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtVendorCreditNoteCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtVendorCreditNoteExchangeRate.attr("style","color:black");
            }
            var date1 = dtpVendorCreditNoteTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#vendorCreditNoteTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#vendorCreditNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#vendorCreditNoteTransactionDate").val(),dtpVendorCreditNoteTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpVendorCreditNoteTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#vendorCreditNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#vendorCreditNoteTransactionDate").val(),dtpVendorCreditNoteTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpVendorCreditNoteTransactionDate);
                }
                return;
            }
            
            vendorCreditNoteFlagConfirmed=true;
            $("#btnUnConfirmVendorCreditNote").css("display", "block");
            $("#btnConfirmVendorCreditNote").css("display", "none");
            $('#vendorCreditNoteHeaderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#vendorCreditNoteDetailInputGrid').unblock();
            
            if($("#vendorCreditNoteUpdateMode").val()==="true"){
                vendorCreditNoteLoadDetail();
            }
        });
        
        $("#btnUnConfirmVendorCreditNote").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
                
            var rows = jQuery("#vendorCreditNoteDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                vendorCreditNoteFlagConfirmed=false;
                $("#btnUnConfirmVendorCreditNote").css("display", "none");
                $("#btnConfirmVendorCreditNote").css("display", "block");
                $('#vendorCreditNoteHeaderInput').unblock();
                $('#vendorCreditNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                            vendorCreditNoteFlagConfirmed=false;
                            $("#vendorCreditNoteDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmVendorCreditNote").css("display", "none");
                            $("#btnConfirmVendorCreditNote").css("display", "block");
                            $('#vendorCreditNoteHeaderInput').unblock();
                            $('#vendorCreditNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

        $.subscribe("vendorCreditNoteDetailInput_grid_onSelect", function() {

            var selectedRowID = $("#vendorCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==vendorCreditNoteDetail_lastSel) {

                $('#vendorCreditNoteDetailInput_grid').jqGrid("saveRow",vendorCreditNoteDetail_lastSel); 
                $('#vendorCreditNoteDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                vendorCreditNoteDetail_lastSel = selectedRowID;

            }else{
                $('#vendorCreditNoteDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
    
    
        $('#btnVendorCreditNoteAddDetail').click(function(ev) {
                
                if(!vendorCreditNoteFlagConfirmed){
                    alertMessage("Please Confirm!",$("#btnConfirmVendorCreditNote"));
                    return;
                }
                var AddRowCount =parseFloat($("#vendorCreditNoteDetailAddRow").val().replace(/,/g, ""));
                
                for(var i=0; i<AddRowCount; i++){
                    var defRow = {
                        vendorCreditNoteDetailBranchCode : txtVendorCreditNoteBranchCode.val()
                    };
                    vendorCreditNoteDetaillastRowId++;
                    
                    $("#vendorCreditNoteDetailInput_grid").jqGrid("addRowData", vendorCreditNoteDetaillastRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#vendorCreditNoteDetailInput_grid").jqGrid('setRowData',vendorCreditNoteDetaillastRowId,{Buttons:be});
                    ev.preventDefault();
                }
                $("#vendorCreditNoteDetailAddRow").val("1"); 
        });
    
            
        $('#btnVendorCreditNoteCancel').click(function(ev) {
            var url = "finance/vendor-credit-note";
            var params = "";
            pageLoad(url, params, "#tabmnuVENDOR_CREDIT_NOTE"); 
            
        });
            
        $('#vendorCreditNote_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=vendorCreditNote&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#vendorCreditNote_btnChartOfAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorCreditNote&idsubdoc=discountAccount","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#vendorCreditNote_btnVendor').click(function(ev) {
            window.open("./pages/search/search-vendor.jsp?iddoc=vendorCreditNote&idsubdoc=vendor","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#vendorCreditNote_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=vendorCreditNote&idsubdoc=paymentTerm","Search", "scrollbars=1, width=600, height=500");
        });

        $('#vendorCreditNote_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=vendorCreditNote&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
    });//EOF Ready
    
    function vendorCreditNoteTransactionDateOnChange(){
        if($("#vendorCreditNoteUpdateMode").val()!=="true"){
            $("#vendorCreditNoteTransactionDate").val(dtpVendorCreditNoteTransactionDate.val());
        }
        
        var contraBon = formatDate($("#vendorCreditNote\\.transactionDate").val(),false);
        var paymentTermDays = $("#vendorCreditNote\\.paymentTerm\\.days").val();
        if (paymentTermDays === "") {
            paymentTermDays = 0;
        }
        
        var newDate = new Date();
        var someDate = new Date(contraBon);
        newDate.setDate(someDate.getDate() + parseInt(paymentTermDays));
        
        var dd = newDate.getDate();
        var mm = newDate.getMonth() + 1;
        var y = newDate.getFullYear();
        
        var someFormattedDate = "";
        
        if(parseInt(dd) < 10){
            someFormattedDate = '0' + dd + '/';
        }else{
            someFormattedDate = dd + '/';
        }
        
        if(parseInt(mm) < 10){
            someFormattedDate += '0' + mm + '/';
        }else{
            someFormattedDate += mm + '/';
        }
        
        someFormattedDate += y;
        
        $("#vendorCreditNote\\.dueDate").val(someFormattedDate);
    }
    
    function calculateVendorCreditNoteDetail() {
        var selectedRowID = $("#vendorCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#vendorCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = vendorCreditNoteDetaillastRowId;
        }
        var qty = $("#" + selectedRowID + "_vendorCreditNoteDetailQuantity").val();
        var amount = $("#" + selectedRowID + "_vendorCreditNoteDetailPrice").val();

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID, "vendorCreditNoteDetailTotal", subAmount);

        vendorCreditNoteCalculateHeader();
    }
        
    function vendorCreditNoteCalculateHeader() {
        var totalTransaction = 0;
        var discPercent=removeCommas(txtVendorCreditNoteDiscountPercent.val());
        var vatPercent=removeCommas(txtVendorCreditNoteVATPercent.val());
        var ids = jQuery("#vendorCreditNoteDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#vendorCreditNoteDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.vendorCreditNoteDetailTotal);
        }
        
        if(txtVendorCreditNoteDiscountPercent.val()===""){
            discPercent=0;
        }
        if(txtVendorCreditNoteVATPercent.val()===""){
            vatPercent=0;
        }
        
        var discAmount = (totalTransaction *  parseFloat(discPercent))/100;
        var subTotalAmount = (totalTransaction - parseFloat(discAmount.toFixed(2)));
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotalAmount =(parseFloat(subTotalAmount) + parseFloat(vatAmount.toFixed(2)));
        
        txtVendorCreditNoteTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        txtVendorCreditNoteDiscountAmount.val(formatNumber(parseFloat(discAmount.toFixed(2)),2));
        $("#vendorCreditNoteSubTotal").val(formatNumber(subTotalAmount,2));
        txtVendorCreditNoteVATAmount.val(formatNumber(parseFloat(vatAmount.toFixed(2)),2));        
        txtVendorCreditNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));

    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
        
    function vendorCreditNoteLoadDetail() {
        var url = "purchasing/vendor-credit-note-detail-data";
        var params = "vendorCreditNote.code=" + txtVendorCreditNoteCode.val();
        
        $.getJSON(url, params, function(data) {
            vendorCreditNoteDetaillastRowId = 0;
            for (var i=0; i<data.listVendorCreditNoteDetailTemp.length; i++) {
                vendorCreditNoteDetaillastRowId++;
                $("#vendorCreditNoteDetailInput_grid").jqGrid("addRowData", vendorCreditNoteDetaillastRowId, data.listVendorCreditNoteDetailTemp[i]);
                $("#vendorCreditNoteDetailInput_grid").jqGrid('setRowData',vendorCreditNoteDetaillastRowId,{
                    vendorCreditNoteDetailCode                : data.listVendorCreditNoteDetailTemp[i].code,
                    vendorCreditNoteDetailDelete              : "delete",
                    vendorCreditNoteDetailSearchChartOfAccount    : "...",
                    vendorCreditNoteDetailQuantity            : data.listVendorCreditNoteDetailTemp[i].quantity,
                    vendorCreditNoteDetailChartOfAccountCode      : data.listVendorCreditNoteDetailTemp[i].chartOfAccountCode,
                    vendorCreditNoteDetailChartOfAccountName      : data.listVendorCreditNoteDetailTemp[i].chartOfAccountName,
                    vendorCreditNoteDetailPrice               : data.listVendorCreditNoteDetailTemp[i].price,
                    vendorCreditNoteDetailUnitOfMeasureCode      : data.listVendorCreditNoteDetailTemp[i].unitOfMeasureCode,
                    vendorCreditNoteDetailUnitOfMeasureName      : data.listVendorCreditNoteDetailTemp[i].unitOfMeasureName,
                    vendorCreditNoteDetailBranchCode      : data.listVendorCreditNoteDetailTemp[i].branchCode,
                    vendorCreditNoteDetailRemark              : data.listVendorCreditNoteDetailTemp[i].remark,
                    vendorCreditNoteDetailTotal               : ((data.listVendorCreditNoteDetailTemp[i].quantity * data.listVendorCreditNoteDetailTemp[i].price))
                });
            }
            vendorCreditNoteCalculateHeader();
        });
    }
        
    function vendorCreditNoteFormatDate(){
        var transactionDate=dtpVendorCreditNoteTransactionDate.val();
        var dateValuesTemp= transactionDate.split(' ');
        var dateValues= dateValuesTemp[0].split('/');
        var transactionDateValue =dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+dateValuesTemp[1];
        dtpVendorCreditNoteTransactionDate.val(transactionDateValue);   
        $("#vendorCreditNoteTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var taxInvoiceDate=dtpVendorCreditNoteTaxInvoiceDate.val();
        var taxInvoiceDateTemp= taxInvoiceDate.split(' ');
        var taxInvoiceDateValues= taxInvoiceDateTemp[0].split('/');
        var taxInvoiceDateValue =taxInvoiceDateValues[1]+"/"+taxInvoiceDateValues[0]+"/"+taxInvoiceDateValues[2]+" "+taxInvoiceDateTemp[1];
        dtpVendorCreditNoteTaxInvoiceDate.val(taxInvoiceDateValue);   
        $("#vendorCreditNoteTemp\\.taxInvoiceDateTemp").val(taxInvoiceDateValue);
        
        var vendorInvoiceDate=dtpVendorCreditNoteVendorInvoiceDate.val();
        var vendorInvoiceDateTemp= vendorInvoiceDate.split(' ');
        var vendorInvoiceDateValues= vendorInvoiceDateTemp[0].split('/');
        var vendorInvoiceDateValue =vendorInvoiceDateValues[1]+"/"+vendorInvoiceDateValues[0]+"/"+vendorInvoiceDateValues[2]+" "+vendorInvoiceDateTemp[1];
        dtpVendorCreditNoteVendorInvoiceDate.val(vendorInvoiceDateValue);   
        $("#vendorCreditNoteTemp\\.vendorInvoiceDateTemp").val(vendorInvoiceDateValue);
        
        var createdDate=dtpVendorCreditNoteCreatedDate.val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpVendorCreditNoteCreatedDate.val(createdDateValue);
        $("#vendorCreditNoteTemp\\.createdDateTemp").val(createdDateValue);
        
        var dueDate=dtpVendorCreditNoteDueDate.val();
        var dueDateValuesTemp= dueDate.split(' ');
        var dueDateValues= dueDateValuesTemp[0].split('/');
        var dueDateValue =dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2]+" "+dueDateValuesTemp[1];
        dtpVendorCreditNoteDueDate.val(dueDateValue);
  //      $("#vendorCreditNoteTemp\\.transactionDateTemp").val(dtpVendorCreditNoteTransactionDate.val());
 
    }
    
    function vendorCreditNoteFormatNumeric(){
        var exchangerate =parseFloat(txtVendorCreditNoteExchangeRate.val());
        txtVendorCreditNoteExchangeRate.val(formatNumber(exchangerate,2));
        var totalTransactionAmount=parseFloat(txtVendorCreditNoteTotalTransactionAmount.val());
        txtVendorCreditNoteTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent=parseFloat(txtVendorCreditNoteDiscountPercent.val());
        txtVendorCreditNoteDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount=parseFloat(txtVendorCreditNoteDiscountAmount.val());
        txtVendorCreditNoteDiscountAmount.val(formatNumber(discountAmount,2));
        var vatPercent=parseFloat(txtVendorCreditNoteVATPercent.val());
        txtVendorCreditNoteVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount=parseFloat(txtVendorCreditNoteVATAmount.val());
        txtVendorCreditNoteVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtVendorCreditNoteGrandTotalAmount.val());
        txtVendorCreditNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }
    
    function vendorCreditNoteUnFormatNumeric(){
        var exchangerate =removeCommas(txtVendorCreditNoteExchangeRate.val());
        txtVendorCreditNoteExchangeRate.val(exchangerate);
        var totalTransactionAmount =removeCommas(txtVendorCreditNoteTotalTransactionAmount.val());
        txtVendorCreditNoteTotalTransactionAmount.val(totalTransactionAmount);
        var discountPercent =removeCommas(txtVendorCreditNoteDiscountPercent.val());
        txtVendorCreditNoteDiscountPercent.val(discountPercent);
        var discountAmount =removeCommas(txtVendorCreditNoteDiscountAmount.val());
        txtVendorCreditNoteDiscountAmount.val(discountAmount);
        var vatPercent =removeCommas(txtVendorCreditNoteVATPercent.val());
        txtVendorCreditNoteVATPercent.val(vatPercent);
        var vatAmount=removeCommas(txtVendorCreditNoteVATAmount.val());
        txtVendorCreditNoteVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtVendorCreditNoteGrandTotalAmount.val());
        txtVendorCreditNoteGrandTotalAmount.val(grandTotalAmount);
    }

    function vendorCreditNoteDetailInputGrid_SearchChartOfAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorCreditNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function vendorCreditNoteDetailInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=vendorCreditNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function vendorCreditNoteDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#vendorCreditNoteDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#vendorCreditNoteDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        vendorCreditNoteCalculateHeader();
        
    }
    
    function vendorCreditNoteOnChangeChartOfAccount(){
        var selectedRowID = $("#vendorCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var chartOfAccountCode = $("#" + selectedRowID + "_vendorCreditNoteDetailChartOfAccountCode").val();

        var url = "master/chart-of-account-get";
        var params = "chartOfAccount.code=" + chartOfAccountCode;
            params+= "&chartOfAccount.activeStatus=TRUE";

        if(chartOfAccountCode.trim()===""){
            $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorCreditNoteDetailChartOfAccountName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_salesOrderDetailFeeReceiverCode5").val(data.chartOfAccountTemp.code);
                $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorCreditNoteDetailChartOfAccountName",data.chartOfAccountTemp.name);
            }
            else{
                alertMessage("Chart Of Account Not Found!",$("#" + selectedRowID + "_vendorCreditNoteDetailChartOfAccountSearch"));
                $("#" + selectedRowID + "_vendorCreditNoteDetailChartOfAccountCode").val("");
                $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorCreditNoteDetailChartOfAccounttName"," ");
            }
        });
    }
    
    function vendorCreditNoteOnChangeUnitOfMeasure(){
        var selectedRowID = $("#vendorCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var unitOfMeasureCode = $("#" + selectedRowID + "_vendorCreditNoteDetailUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + unitOfMeasureCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";

        if(unitOfMeasureCode.trim()===""){
            $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorCreditNoteDetailUnitOfMeasureName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_vendorCreditNoteDetailUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
                $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorCreditNoteDetailUnitOfMeasureName",data.unitOfMeasureTemp.name);
            }
            else{
                alertMessage("UOM Not Found!",$("#" + selectedRowID + "_vendorCreditNoteDetailUnitOfMeasureSearch"));
                $("#" + selectedRowID + "_vendorCreditNoteDetailUnitOfMeasureCode").val("");
                $("#vendorCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorCreditNoteDetailUnitOfMeasuretName"," ");
            }
        });
    }
    
   
 
      function vendorCreditNoteLoadExchangeRate(){
        if($("#vendorCreditNoteUpdateMode").val()==="false"){
            if(txtVendorCreditNoteCurrencyCode.val()==="IDR"){
                txtVendorCreditNoteExchangeRate.val("1.00");
                txtVendorCreditNoteExchangeRate.attr('readonly',true);
            }else{
                txtVendorCreditNoteExchangeRate.val("0.00");
                txtVendorCreditNoteExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtVendorCreditNoteCurrencyCode.val()==="IDR"){
                txtVendorCreditNoteExchangeRate.val("1.00");
                txtVendorCreditNoteExchangeRate.attr('readonly',true);
            }else{
                txtVendorCreditNoteExchangeRate.attr('readonly',false);
            }
        }
    }    
      function setCurrency(){

            var url = "master/currency-get";
            var params = "currency.code=IDR";
                params+= "&currency.activeStatus=TRUE";

            $.post(url, params, function(result) {
                var data = (result);
                if (data.currencyTemp){
                    txtVendorCreditNoteCurrencyCode.val(data.currencyTemp.code);
                    txtVendorCreditNoteCurrencyName.val(data.currencyTemp.name);
                    vendorCreditNoteLoadExchangeRate();
                }
                else{
                    alertMessage("Currency Not Found!",txtVendorCreditNoteCurrencyCode);
                    txtVendorCreditNoteCurrencyCode.val("");
                    txtVendorCreditNoteCurrencyName.val("");
                    txtVendorCreditNoteExchangeRate.val("0.00");
                    txtVendorCreditNoteExchangeRate.attr("readonly",true);
                }
            });
    }
    function vendor_credit_note_handlers_input(){
        if(txtVendorCreditNoteBranchCode.val()===""){
            handlersInput(txtVendorCreditNoteBranchCode);
        }else{
            unHandlersInput(txtVendorCreditNoteBranchCode);
        }
        
        if(dtpVendorCreditNoteTransactionDate.val()===""){
            handlersInput(dtpVendorCreditNoteTransactionDate);
        }else{
            unHandlersInput(dtpVendorCreditNoteTransactionDate);
        }
        
        if(txtVendorCreditNoteCurrencyCode.val()===""){
            handlersInput(txtVendorCreditNoteCurrencyCode);
        }else{
            unHandlersInput(txtVendorCreditNoteCurrencyCode);
        }
        
        if(txtVendorCreditNoteVendorCode.val()===""){
            handlersInput(txtVendorCreditNoteVendorCode);
        }else{
            unHandlersInput(txtVendorCreditNoteVendorCode);
        }
        if(txtVendorCreditNotePaymentTermCode.val()===""){
            handlersInput(txtVendorCreditNotePaymentTermCode);
        }else{
            unHandlersInput(txtVendorCreditNotePaymentTermCode);
        }
        
    }
</script>
<s:url id="remoteurlVendorCreditNoteDetailInput" action="vendor-credit-note-detail-data" />
<b>VENDOR CREDIT NOTE</b>
<hr>
<br class="spacer" />
<div id="vendorCreditNoteInput" class="content ui-widget">
    <s:form id="frmVendorCreditNoteInput">
        <table cellpadding="2" cellspacing="2" id="vendorCreditNoteHeaderInput">
            
            <tr>
                <td align="right"><B>VCN No*</B></td>
                <td colspan="3">
                    <s:textfield id="vendorCreditNote.code" name="vendorCreditNote.code" readonly="true" size="27"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td colspan="3">
                    <sj:datepicker id="vendorCreditNote.transactionDate" name="vendorCreditNote.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="vendorCreditNoteTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="vendorCreditNoteTransactionDate" name="vendorCreditNoteTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Payment Term *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtVendorCreditNotePaymentTermCode.change(function(ev) {
                            if(txtVendorCreditNotePaymentTermCode.val()===""){
                                txtVendorCreditNotePaymentTermName.val("");
                                txtVendorCreditNotePaymentTermDays.val("0");
                                return;
                            }
                            var url = "master/payment-term-get";
                            var params = "paymentTerm.code=" + txtVendorCreditNotePaymentTermCode.val();
                                params+= "&paymentTerm.activeStatus=TRUE";
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.paymentTermTemp){
                                    txtVendorCreditNotePaymentTermCode.val(data.paymentTermTemp.code);
                                    txtVendorCreditNotePaymentTermName.val(data.paymentTermTemp.name);
                                    txtVendorCreditNotePaymentTermDays.val(data.paymentTermTemp.days);
                                }
                                else{
                                    alertMessage("Payment Term Not Found!",txtVendorCreditNotePaymentTermCode);
                                    txtVendorCreditNotePaymentTermCode.val("");
                                    txtVendorCreditNotePaymentTermName.val("");
                                    txtVendorCreditNotePaymentTermDays.val("0");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="vendorCreditNote.paymentTerm.code" name="vendorCreditNote.paymentTerm.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="vendorCreditNote_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorCreditNote.paymentTerm.name" name="vendorCreditNote.paymentTerm.name" size="40" readonly="true"></s:textfield>
                        <s:textfield id="vendorCreditNote.paymentTerm.days" name="vendorCreditNote.paymentTerm.days" size="20" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Due Date</B></td>
                <td><sj:datepicker id="vendorCreditNote.dueDate" name="vendorCreditNote.dueDate" readonly="true" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="false" timepickerFormat="hh:mm:ss"></sj:datepicker></td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">

                        txtVendorCreditNoteBranchCode.change(function(ev) {

                            if(txtVendorCreditNoteBranchCode.val()===""){
                                txtVendorCreditNoteBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtVendorCreditNoteBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtVendorCreditNoteBranchCode.val(data.branchTemp.code);
                                    txtVendorCreditNoteBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtVendorCreditNoteBranchCode);
                                    txtVendorCreditNoteBranchCode.val("");
                                    txtVendorCreditNoteBranchName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="vendorCreditNote.branch.code" name="vendorCreditNote.branch.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                        <sj:a id="vendorCreditNote_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorCreditNote.branch.name" name="vendorCreditNote.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Currency *</B></td>
                <td colspan="3">
                    <script type = "text/javascript">

                        txtVendorCreditNoteCurrencyCode.change(function(ev) {

                            if(txtVendorCreditNoteCurrencyCode.val()===""){
                                txtVendorCreditNoteCurrencyName.val("");
                                txtVendorCreditNoteExchangeRate.val("0.00");
                                txtVendorCreditNoteExchangeRate.attr('readonly',true);
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtVendorCreditNoteCurrencyCode.val();
                                params+= "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtVendorCreditNoteCurrencyCode.val(data.currencyTemp.code);
                                    txtVendorCreditNoteCurrencyName.val(data.currencyTemp.name);
                                    vendorCreditNoteLoadExchangeRate();
                                }
                                else{
                                    alertMessage("Currency Not Found",txtVendorCreditNoteCurrencyCode);
                                    txtVendorCreditNoteCurrencyCode.val("");
                                    txtVendorCreditNoteCurrencyName.val("");
                                    txtVendorCreditNoteExchangeRate.val("0.00");
                                    txtVendorCreditNoteExchangeRate.attr("readonly",true);
//                                    calculateVendorCreditNoteTotalTransactionAmountIDR();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendorCreditNote.currency.code" name="vendorCreditNote.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="vendorCreditNote_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorCreditNote.currency.name" name="vendorCreditNote.currency.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Exchange Rate *</B></td>
                <td>
                    <s:textfield id="vendorCreditNote.exchangeRate" name="vendorCreditNote.exchangeRate" size="20" cssStyle="text-align:right" required="true" cssClass="required"></s:textfield>&nbsp;<span id="errmsgExchangeRate"></span>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Vendor *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtVendorCreditNoteVendorCode.change(function(ev) {
                            
                            if(txtVendorCreditNoteVendorCode.val()===""){
                                txtVendorCreditNoteVendorName.val("");
                                return;
                            }
                            var url = "master/vendor-get";
                            var params = "vendor.code=" + txtVendorCreditNoteVendorCode.val();
                                params +="&vendor.activeStatus=true";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.vendorTemp){
                                    txtVendorCreditNoteVendorCode.val(data.vendorTemp.code);
                                    txtVendorCreditNoteVendorName.val(data.vendorTemp.name);
                                }
                                else{
                                    alertMessage("Vendor Not Found!",txtVendorCreditNoteVendorCode);
                                    txtVendorCreditNoteVendorCode.val("");
                                    txtVendorCreditNoteVendorName.val("");
                                }   
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="vendorCreditNote.vendor.code" name="vendorCreditNote.vendor.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                        <sj:a id="vendorCreditNote_btnVendor" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorCreditNote.vendor.name" name="vendorCreditNote.vendor.name" size="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Tax Invoice No</td>
                <td><s:textfield id="vendorCreditNote.taxInvoiceNo" name="vendorCreditNote.taxInvoiceNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Tax Invoice Date</td>
                <td>
                    <sj:datepicker id="vendorCreditNote.taxInvoiceDate" name="vendorCreditNote.taxInvoiceDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Vendor Invoice No</td>
                <td><s:textfield id="vendorCreditNote.vendorInvoiceNo" name="vendorCreditNote.vendorInvoiceNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Vendor Invoice Date</td>
                <td>
                    <sj:datepicker id="vendorCreditNote.vendorInvoiceDate" name="vendorCreditNote.vendorInvoiceDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="vendorCreditNote.refNo" name="vendorCreditNote.refNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3"><s:textarea id="vendorCreditNote.remark" name="vendorCreditNote.remark"  cols="60" rows="2" height="20"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="vendorCreditNoteUpdateMode" name="vendorCreditNoteUpdateMode"></s:textfield>
                    <s:textfield id="vendorCreditNoteTemp.transactionDateTemp" name="vendorCreditNoteTemp.transactionDateTemp"></s:textfield>
                    <s:textfield id="vendorCreditNoteTemp.taxInvoiceDateTemp" name="vendorCreditNoteTemp.taxInvoiceDateTemp"></s:textfield>
                    <s:textfield id="vendorCreditNoteTemp.vendorInvoiceDateTemp" name="vendorCreditNoteTemp.vendorInvoiceDateTemp"></s:textfield>
                    <sj:datepicker id="vendorCreditNoteDateFirstSession" name="vendorCreditNoteDateFirstSession" size="15" showOn="focus"></sj:datepicker>
                    <sj:datepicker id="vendorCreditNoteDateLastSession" name="vendorCreditNoteDateLastSession" size="15" showOn="focus"></sj:datepicker>
                    <s:textfield id="vendorCreditNote.createdBy" name="vendorCreditNote.createdBy" key="vendorCreditNote.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="vendorCreditNote.createdDate" name="vendorCreditNote.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="vendorCreditNoteTemp.createdDateTemp" name="vendorCreditNoteTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table> 
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmVendorCreditNote" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmVendorCreditNote" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
                
        <div id="vendorCreditNoteDetailInputGrid">
            
            <br class="spacer" />
            <br class="spacer" />
            <table width="20%">
                <script>
                    $('#btnVendorCreditNoteAdditionalFee').click(function(ev) {

                        if(!vendorCreditNoteFlagConfirmed){
                            alertMessage("Please Confirm!",$("#btnConfirmVendorCreditNote"));
                            return;
                        }

                        var ids = $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('getDataIDs');
                        //alert(ids.length);
                        window.open("./pages/search/search-good-received-note-additional-fee-by-vendor-credit-note.jsp?iddoc=vendorCreditNoteAdditionalFeeDetail&rowLast="+ids.length+"&type=grid&vendorCode="+txtVendorCreditNoteVendorCode.val()+"&currencyCode="+txtVendorCreditNoteCurrencyCode.val(),"Search", "scrollbars=1,width=900, height=600");
                    });
                
                    function addRowDataMultiSelected(lastRowId,defRow){ 
                        lastRowId++;
                        
                        $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid("addRowData",lastRowId,defRow);
                        $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('setRowData',lastRowId,{
                                vendorCreditNoteAdditionalFeeDetailBranchCode                           : txtVendorCreditNoteBranchCode.val(),
                                vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode    : defRow.vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode,
                                vendorCreditNoteAdditionalFeeDetailRemark                               : defRow.vendorCreditNoteAdditionalFeeDetailRemark,
                                vendorCreditNoteAdditionalFeeDetailCurrencyCode                         : defRow.vendorCreditNoteAdditionalFeeDetailCurrencyCode,
                                vendorCreditNoteAdditionalFeeDetailCurrencyName                         : defRow.vendorCreditNoteAdditionalFeeDetailCurrencyName,
                                vendorCreditNoteAdditionalFeeDetailExchangeRate                         : parseFloat(removeCommas(txtVendorCreditNoteExchangeRate.val())),
                                vendorCreditNoteAdditionalFeeDetailUnitOfMeasureCode                    : defRow.vendorCreditNoteAdditionalFeeDetailUnitOfMeasureCode,
                                vendorCreditNoteAdditionalFeeDetailQuantity                             : defRow.vendorCreditNoteAdditionalFeeDetailQuantity,
                                vendorCreditNoteAdditionalFeeDetailPrice                                : defRow.vendorCreditNoteAdditionalFeeDetailPrice,
                                vendorCreditNoteAdditionalFeeDetailTotal                                : defRow.vendorCreditNoteAdditionalFeeDetailTotal
                        });

                        setHeightGridDetail();
                    }
                    
                    function setHeightGridDetail(){
                        var ids = jQuery("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('getDataIDs'); 
                        if(ids.length > 15){
                            var rowHeight = $("#vendorCreditNoteAdditionalFeeDetailInput_grid"+" tr").eq(1).height();
                            $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
                        }else{
                            $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('setGridHeight', "100%", true);
                        }
                    }
                    
                    function vendorCreditNoteAdditionalFeeDetailInputGrid_Delete_OnClick(){
                        var selectDetailRowId = $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('getGridParam','selrow');

                        if (selectDetailRowId === null) {
                            alert("Please Select Row");
                            return;
                        }

                        $("#vendorCreditNoteAdditionalFeeDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
                        vendorCreditNoteCalculateHeader();

                    }
                    
                    function vendorCreditNoteAdditionalFeeDetailInputGrid_SearchChartOfAccount_OnClick(){
                        window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorCreditNoteAdditionalFeeDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
                    }
                </script>
                <tr>
                    <td>
                        <sj:a href="#" id="btnVendorCreditNoteAdditionalFee" button="true" style="width: 90%">Search</sj:a> 
                    </td>
                </tr>
            </table>  
            <sjg:grid
                id="vendorCreditNoteAdditionalFeeDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listVendorCreditNoteAdditionalFeeTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuVendorCreditNoteAdditionalFeeDetail').width()"
                editurl="%{remoteurlVendorCreditNoteAdditionalFeeDetailInput}"
                onSelectRowTopics="vendorCreditNoteAdditionalFeeDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetail" index="vendorCreditNoteAdditionalFeeDetail" title="" width="50" hidden="true"
                    editable="true" edittype="button"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailCode" index="vendorCreditNoteAdditionalFeeDetailCode" title="vendorCreditNoteAdditionalFeeDetailCode" width="100" 
                    sortable="true" hidden="true"
                />   
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailDelete" index="vendorCreditNoteAdditionalFeeDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'vendorCreditNoteAdditionalFeeDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailBranchCode" index="vendorCreditNoteAdditionalFeeDetailBranchCode" key="vendorCreditNoteAdditionalFeeDetailBranchCode" 
                    title="Branch" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode" index="vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode" key="vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode" 
                    title="GRN Additional Fee Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailChartOfAccountSearch" index="vendorCreditNoteAdditionalFeeDetailChartOfAccountSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'vendorCreditNoteAdditionalFeeDetailInputGrid_SearchChartOfAccount_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailChartOfAccountCode" index="vendorCreditNoteAdditionalFeeDetailChartOfAccountCode" title="Chart Of Account Code" width="200" 
                    sortable="true" editable="true" editoptions="{onChange:'vendorCreditNoteAdditionalFeeOnChangeChartOfAccount()'}"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailChartOfAccountName" index="vendorCreditNoteAdditionalFeeDetailChartOfAccountName" title="Chart Of Account Name" width="200" sortable="true"
                />  
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailCurrencyCode" index="vendorCreditNoteAdditionalFeeDetailCurrencyCode" title="Currency Code" width="100" 
                    sortable="true"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailCurrencyName" index="vendorCreditNoteAdditionalFeeDetailCurrencyName" title="Currency Name" width="120" 
                    sortable="true"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailExchangeRate" index="vendorCreditNoteAdditionalFeeDetailExchangeRate" title="Exchange Rate" width="120" 
                    sortable="true" formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailRemark" index="vendorCreditNoteAdditionalFeeDetailRemark" key="vendorCreditNoteAdditionalFeeDetailRemark" 
                    title="Remark" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailQuantity" index="vendorCreditNoteAdditionalFeeDetailQuantity" key="vendorCreditNoteAdditionalFeeDetailQuantity" title="Quantity" 
                    width="70" align="right"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailUnitOfMeasureCode" index="vendorCreditNoteAdditionalFeeDetailUnitOfMeasureCode" title="Unit" width="200" 
                    sortable="true"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailPrice" index="vendorCreditNoteAdditionalFeeDetailPrice" key="vendorCreditNoteAdditionalFeeDetailPrice" title="Amount" 
                    width="150" align="right"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteAdditionalFeeDetailTotal" index="vendorCreditNoteAdditionalFeeDetailTotal" key="vendorCreditNoteAdditionalFeeDetailTotal" title="Total" 
                    width="150" align="right"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />

            </sjg:grid >
            <br class="spacer" />
            <br class="spacer" /> 
                    
        <div id="vendorCreditNoteDetailInputGrid">
            <sjg:grid
                id="vendorCreditNoteDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listVendorCreditNoteTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuVendorCreditNoteDetail').width()"
                editurl="%{remoteurlVendorCreditNoteDetailInput}"
                onSelectRowTopics="vendorCreditNoteDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="vendorCreditNoteDetail" index="vendorCreditNoteDetail" title="" width="50" hidden="true"
                    editable="true" edittype="button"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailCode" index="vendorCreditNoteDetailCode" title="vendorCreditNoteDetailCode" width="100" 
                    sortable="true" hidden="true"
                />   
                <sjg:gridColumn
                    name="vendorCreditNoteDetailDelete" index="vendorCreditNoteDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'vendorCreditNoteDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailBranchCode" index="vendorCreditNoteDetailBranchCode" key="vendorCreditNoteDetailBranchCode" 
                    title="Branch" width="80" sortable="true"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailChartOfAccountSearch" index="vendorCreditNoteDetailChartOfAccountSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'vendorCreditNoteDetailInputGrid_SearchChartOfAccount_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailChartOfAccountCode" index="vendorCreditNoteDetailChartOfAccountCode" title="Chart Of Account Code" width="200" 
                    sortable="true" editable="true" editoptions="{onChange:'vendorCreditNoteOnChangeChartOfAccount()'}"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteDetailChartOfAccountName" index="vendorCreditNoteDetailChartOfAccountName" title="Chart Of Account Name" width="200" sortable="true"
                />  
                <sjg:gridColumn
                    name="vendorCreditNoteDetailRemark" index="vendorCreditNoteDetailRemark" key="vendorCreditNoteDetailRemark" 
                    title="Remark" width="200" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailQuantity" index="vendorCreditNoteDetailQuantity" key="vendorCreditNoteDetailQuantity" title="Quantity" 
                    width="70" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    editoptions="{ondblclick:'this.setSelectionRange(0, this.value.length)',onKeyUp:'calculateVendorCreditNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailUnitOfMeasureSearch" index="vendorCreditNoteDetailUnitOfMeasureSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'vendorCreditNoteDetailInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailUnitOfMeasureCode" index="vendorCreditNoteDetailUnitOfMeasureCode" title="Unit" width="80" 
                    sortable="true" editable="true" editoptions="{onChange:'vendorCreditNoteOnChangeUnitOfMeasure()'}"
                />     
                <sjg:gridColumn
                    name="vendorCreditNoteDetailPrice" index="vendorCreditNoteDetailPrice" key="vendorCreditNoteDetailPrice" title="Amount" 
                    width="150" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    editoptions="{ondblclick:'this.setSelectionRange(0, this.value.length)',onKeyUp:'calculateVendorCreditNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="vendorCreditNoteDetailTotal" index="vendorCreditNoteDetailTotal" key="vendorCreditNoteDetailTotal" title="Total" 
                    width="150" align="right" editable="false" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />

            </sjg:grid >
        </div>
        <table width="100%">
            <tr>
                <td width="15%" valign="top">
                    <table width="100%">
                        <tr>
                            <td>
                                <s:textfield id="vendorCreditNoteDetailAddRow" name="vendorCreditNoteDetailAddRow" cssStyle="text-align:right" size="10" value="1"></s:textfield>
                                <sj:a href="#" id="btnVendorCreditNoteAddDetail" button="true"  style="width: 60px">Add</sj:a>&nbsp;<span id="errmsgAddRow"></span>
                            </td>
                        </tr>
                        <tr>
                            <td height="20px"/>
                        </tr>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnVendorCreditNoteSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnVendorCreditNoteCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="70%">
                    <table width="100%">
                        <tr>
                            <td align="right"><B>Total Transaction</B></td>
                            <td width="100px">
                                <s:textfield id="vendorCreditNote.totalTransactionAmount" name="vendorCreditNote.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Discount
                                <s:textfield id="vendorCreditNote.discountPercent" onkeyup="vendorCreditNoteCalculateHeader()" name="vendorCreditNote.discountPercent" size="5" cssStyle="text-align:right"></s:textfield>
                                %
                            </td>
                            <td><s:textfield id="vendorCreditNote.discountAmount" onchange="vendorCreditNoteCalculateHeader()" name="vendorCreditNote.discountAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                        </tr>
                        
                        <tr>
                            <td align="right" style="width:120px">Discount Account </td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtVendorCreditNoteDiscountAccountCode.change(function(ev) {

                                    if(txtVendorCreditNoteDiscountAccountCode.val()===""){
                                        txtVendorCreditNoteDiscountAccountName.val("");
                                        return;
                                    }
                                    var url = "master/chart-of-account-get";
                                    var params = "chartOfAccount.code=" + txtVendorCreditNoteDiscountAccountCode.val();
                                        params += "&chartOfAccount.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.chartOfAccountTemp){
                                            txtVendorCreditNoteDiscountAccountCode.val(data.chartOfAccountTemp.code);
                                            txtVendorCreditNoteDiscountAccountName.val(data.chartOfAccountTemp.name);
                                        }
                                        else{
                                            alertMessage("Chart Of Account Not Found!",txtVendorCreditNoteDiscountAccountCode);
                                            txtVendorCreditNoteDiscountAccountCode.val("");
                                            txtVendorCreditNoteDiscountAccountName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="vendorCreditNote.discountAccount.code" name="vendorCreditNote.discountAccount.code" size="22"></s:textfield>
                                <sj:a id="vendorCreditNote_btnChartOfAccount" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="vendorCreditNote.discountAccount.name" name="vendorCreditNote.discountAccount.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right"><B>Sub Total(Tax Base)</B></td>
                            <td>
                                <s:textfield id="vendorCreditNoteSubTotal" name="vendorCreditNoteSubTotal"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">VAT
                            <s:textfield id="vendorCreditNote.vatPercent" onkeyup="vendorCreditNoteCalculateHeader()" name="vendorCreditNote.vatPercent" size="5" cssStyle="text-align:right"></s:textfield>
                                %
                            </td>
                            <td><s:textfield id="vendorCreditNote.vatAmount" name="vendorCreditNote.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="vendorCreditNote.grandTotalAmount" name="vendorCreditNote.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>     
    