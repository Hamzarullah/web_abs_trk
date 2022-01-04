
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #vendorDebitNoteDetailInput_grid_pager_center{
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
    
    var vendorDebitNoteDetaillastRowId=0,vendorDebitNoteDetail_lastSel = -1;
    var vendorDebitNoteFlagConfirmed=false;
    var 
        txtVendorDebitNoteCode= $("#vendorDebitNote\\.code"),
        txtVendorDebitNoteBranchCode = $("#vendorDebitNote\\.branch\\.code"),
        txtVendorDebitNoteBranchName = $("#vendorDebitNote\\.branch\\.name"),
        dtpVendorDebitNoteTransactionDate= $("#vendorDebitNote\\.transactionDate"),
        dtpVendorDebitNoteDueDate = $("#vendorDebitNote\\.dueDate"),
        txtVendorDebitNoteExchangeRate= $("#vendorDebitNote\\.exchangeRate"),
        txtVendorDebitNoteCurrencyCode= $("#vendorDebitNote\\.currency\\.code"),
        txtVendorDebitNoteCurrencyName= $("#vendorDebitNote\\.currency\\.name"),
        txtVendorDebitNoteDiscountAccountCode= $("#vendorDebitNote\\.discountAccount\\.code"),
        txtVendorDebitNoteDiscountAccountName= $("#vendorDebitNote\\.discountAccount\\.name"),
        txtVendorDebitNoteVendorCode= $("#vendorDebitNote\\.vendor\\.code"),
        txtVendorDebitNoteVendorName= $("#vendorDebitNote\\.vendor\\.name"),
        txtVendorDebitNoteTaxInvoiceNo= $("#vendorDebitNote\\.taxInvoiceNo"),
        dtpVendorDebitNoteTaxInvoiceDate= $("#vendorDebitNote\\.taxInvoiceDate"),
        txtVendorDebitNoteVendorInvoiceNo= $("#vendorDebitNote\\.vendorInvoiceNo"),
        dtpVendorDebitNoteVendorInvoiceDate= $("#vendorDebitNote\\.vendorInvoiceDate"),
        txtVendorDebitNoteRefNo = $("#vendorDebitNote\\.refNo"),
        txtVendorDebitNoteRemark = $("#vendorDebitNote\\.remark"),
        txtVendorDebitNoteTotalTransactionAmount = $("#vendorDebitNote\\.totalTransactionAmount"),
        txtVendorDebitNoteDiscountPercent = $("#vendorDebitNote\\.discountPercent"),
        txtVendorDebitNoteDiscountAmount = $("#vendorDebitNote\\.discountAmount"),
        txtVendorDebitNoteSubTotalAmount = $("#vendorDebitNoteSubTotal"),
        txtVendorDebitNoteVATPercent = $("#vendorDebitNote\\.vatPercent"),
        txtVendorDebitNoteVATAmount = $("#vendorDebitNote\\.vatAmount"),
        txtVendorDebitNoteGrandTotalAmount = $("#vendorDebitNote\\.grandTotalAmount"),
        dtpVendorDebitNoteCreatedDate = $("#vendorDebitNote\\.createdDate"),
        txtVendorDebitNotePaymentTermCode = $("#vendorDebitNote\\.paymentTerm\\.code"),
        txtVendorDebitNotePaymentTermName = $("#vendorDebitNote\\.paymentTerm\\.name"),
        txtVendorDebitNotePaymentTermDays = $("#vendorDebitNote\\.paymentTerm\\.days"),
        
        allVendorDebitNoteFields = $([])
            .add(txtVendorDebitNoteVendorCode)
            .add(txtVendorDebitNotePaymentTermCode)
            .add(txtVendorDebitNotePaymentTermName)
            .add(txtVendorDebitNotePaymentTermDays)
            .add(txtVendorDebitNoteCurrencyName)
            .add(txtVendorDebitNoteTaxInvoiceNo)
            .add(txtVendorDebitNoteRefNo)
            .add(txtVendorDebitNoteRemark);

    
    $(document).ready(function() {
        
        vendorDebitNoteFlagConfirmed=false;      
        vendorDebitNoteLoadExchangeRate();
        vendorDebitNoteFormatNumeric();
        if($("#vendorDebitNoteUpdateMode").val()==="false"){
            setCurrency();
        }
        $("#vendorDebitNoteDetailAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#vendorDebitNoteDetailAddRow").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return numberWithCommas(value);
            });
        });
        
        $("#vendorDebitNote\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorDebitNote\\.exchangeRate").change(function(e){
            var exrate=$("#vendorDebitNote\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#vendorDebitNote\\.exchangeRate").val("1.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
                
        $("#vendorDebitNote\\.discountPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#vendorDebitNote\\.discountPercent").change(function(e){
            var amount=$("#vendorDebitNote\\.discountPercent").val();
            if(amount===""){
               $("#vendorDebitNote\\.discountPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $("#vendorDebitNote\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorDebitNote\\.vatPercent").change(function(e){
            var amount=$("#vendorDebitNote\\.vatPercent").val();
            if(amount===""){
               $("#vendorDebitNote\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        

        $('#btnVendorDebitNoteSave').click(function(ev) {
            
            if(!vendorDebitNoteFlagConfirmed){
                alertMessage("Please Confirm!",$("#btnConfirmVendorDebitNote"));
                return;
            }
            
            if(vendorDebitNoteDetail_lastSel !== -1) {
                $('#vendorDebitNoteDetailInput_grid').jqGrid("saveRow",vendorDebitNoteDetail_lastSel); 
            }

            var listVendorDebitNoteDetail = new Array(); 
            var ids = jQuery("#vendorDebitNoteDetailInput_grid").jqGrid('getDataIDs'); 

            if(ids.length===0){
                alertMessage("Data Detail Can't Empty!");
                return;
            }

            for(var i=0;i < ids.length;i++){ 
                var data = $("#vendorDebitNoteDetailInput_grid").jqGrid('getRowData',ids[i]); 


                if(data.vendorDebitNoteDetailChartOfAccountCode===""){
                    alertMessage("Chart Of Account Code Can't Empty!");
                    return;
                }
                
                if(data.vendorDebitNoteDetailUnitOfMeasureCode===""){
                    alertMessage("Unit Of Measure Code Can't Empty!");
                    return;
                }

                var vendorDebitNoteDetail = { 
                    remark              : data.vendorDebitNoteDetailRemark,
                    chartOfAccount          : {code:data.vendorDebitNoteDetailChartOfAccountCode},
                    quantity            : data.vendorDebitNoteDetailQuantity,
                    unitOfMeasure          : {code:data.vendorDebitNoteDetailUnitOfMeasureCode},
                    branch              : {code:data.vendorDebitNoteDetailBranchCode},
                    price               : data.vendorDebitNoteDetailPrice,
                    totalAmount         : data.vendorDebitNoteDetailTotal
                };

                listVendorDebitNoteDetail[i] = vendorDebitNoteDetail;
            }
            
            if(parseFloat(txtVendorDebitNoteTotalTransactionAmount.val())===0.00){
                alertMessage("Can't be 0 value for Total Transaction!");
                return;
            }
            if(txtVendorDebitNoteDiscountPercent.val()!=0 && txtVendorDebitNoteDiscountAccountCode.val()===""){
                alertMessage("Discount Account Cant be Empty");
                return;
            }
            
            unHandlersInput(txtVendorDebitNoteDiscountPercent);
            
            vendorDebitNoteFormatDate();
            vendorDebitNoteUnFormatNumeric();
            
            var url = "finance/vendor-debit-note-save";
            var params = $("#frmVendorDebitNoteInput").serialize();
                params += "&listVendorDebitNoteDetailJSON=" + $.toJSON(listVendorDebitNoteDetail);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    vendorDebitNoteFormatDate();
                    vendorDebitNoteFormatNumeric();
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
                                var url = "finance/vendor-debit-note-input";
                                var params = "";
                                pageLoad(url, params, "#tabmnuVENDOR_DEBIT_NOTE");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "finance/vendor-debit-note";
                                var params = "";
                                pageLoad(url, params, "#tabmnuVENDOR_DEBIT_NOTE");

                            }
                        }]
                });
            });
        });

        $("#btnUnConfirmVendorDebitNote").css("display", "none");
        $('#vendorDebitNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmVendorDebitNote").click(function(ev) {
            vendor_debit_note_handlers_input();
            vendorDebitNoteTransactionDateOnChange();
              if(txtVendorDebitNoteBranchCode.val()===''){
                alertMessage("Branch Cant be Empty");
                return;
            }
            if(txtVendorDebitNoteCurrencyCode.val()===''){
                alertMessage("Currency Cant be Empty");
                return;
            }
            if(txtVendorDebitNoteVendorCode.val()===''){
                alertMessage("Vendor Cant be Empty");
                return;
            }
            if(txtVendorDebitNotePaymentTermCode.val()===''){
                alertMessage("Payment Term Cant be Empty");
                return;
            }
            if(parseFloat(txtVendorDebitNoteExchangeRate.val())<=1 && txtVendorDebitNoteCurrencyCode.val()!=="IDR"){
           
                txtVendorDebitNoteExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtVendorDebitNoteCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtVendorDebitNoteExchangeRate.attr("style","color:black");
            }
            var date1 = dtpVendorDebitNoteTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#vendorDebitNoteTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#vendorDebitNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#vendorDebitNoteTransactionDate").val(),dtpVendorDebitNoteTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpVendorDebitNoteTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#vendorDebitNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#vendorDebitNoteTransactionDate").val(),dtpVendorDebitNoteTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpVendorDebitNoteTransactionDate);
                }
                return;
            }
            
            vendorDebitNoteFlagConfirmed=true;
            $("#btnUnConfirmVendorDebitNote").css("display", "block");
            $("#btnConfirmVendorDebitNote").css("display", "none");
            $('#vendorDebitNoteHeaderInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#vendorDebitNoteDetailInputGrid').unblock();
            
            if($("#vendorDebitNoteUpdateMode").val()==="true"){
                vendorDebitNoteLoadDetail();
            }
        });
        
        $("#btnUnConfirmVendorDebitNote").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');
                
            var rows = jQuery("#vendorDebitNoteDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                vendorDebitNoteFlagConfirmed=false;
                $("#btnUnConfirmVendorDebitNote").css("display", "none");
                $("#btnConfirmVendorDebitNote").css("display", "block");
                $('#vendorDebitNoteHeaderInput').unblock();
                $('#vendorDebitNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                            vendorDebitNoteFlagConfirmed=false;
                            $("#vendorDebitNoteDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmVendorDebitNote").css("display", "none");
                            $("#btnConfirmVendorDebitNote").css("display", "block");
                            $('#vendorDebitNoteHeaderInput').unblock();
                            $('#vendorDebitNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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

        $.subscribe("vendorDebitNoteDetailInput_grid_onSelect", function() {

            var selectedRowID = $("#vendorDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==vendorDebitNoteDetail_lastSel) {

                $('#vendorDebitNoteDetailInput_grid').jqGrid("saveRow",vendorDebitNoteDetail_lastSel); 
                $('#vendorDebitNoteDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                vendorDebitNoteDetail_lastSel = selectedRowID;

            }else{
                $('#vendorDebitNoteDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
    
    
        $('#btnVendorDebitNoteAddDetail').click(function(ev) {
                
                if(!vendorDebitNoteFlagConfirmed){
                    alertMessage("Please Confirm!",$("#btnConfirmVendorDebitNote"));
                    return;
                }
                var AddRowCount =parseFloat($("#vendorDebitNoteDetailAddRow").val().replace(/,/g, ""));
                
                for(var i=0; i<AddRowCount; i++){
                    var defRow = {
                        vendorDebitNoteDetailBranchCode : txtVendorDebitNoteBranchCode.val()
                    };
                    vendorDebitNoteDetaillastRowId++;
                    
                    $("#vendorDebitNoteDetailInput_grid").jqGrid("addRowData", vendorDebitNoteDetaillastRowId, defRow);

                    be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                    $("#vendorDebitNoteDetailInput_grid").jqGrid('setRowData',vendorDebitNoteDetaillastRowId,{Buttons:be});
                    ev.preventDefault();
                }
                $("#vendorDebitNoteDetailAddRow").val("1"); 
        });
    
            
        $('#btnVendorDebitNoteCancel').click(function(ev) {
            var url = "finance/vendor-debit-note";
            var params = "";
            pageLoad(url, params, "#tabmnuVENDOR_DEBIT_NOTE"); 
            
        });
            
        $('#vendorDebitNote_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=vendorDebitNote&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#vendorDebitNote_btnChartOfAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorDebitNote&idsubdoc=discountAccount","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#vendorDebitNote_btnVendor').click(function(ev) {
            window.open("./pages/search/search-vendor.jsp?iddoc=vendorDebitNote&idsubdoc=vendor","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#vendorDebitNote_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=vendorDebitNote&idsubdoc=paymentTerm","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#vendorDebitNote_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=vendorDebitNote&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
    });//EOF Ready
    
    function vendorDebitNoteTransactionDateOnChange(){
        if($("#vendorDebitNoteUpdateMode").val()!=="true"){
            $("#vendorDebitNoteTransactionDate").val(dtpVendorDebitNoteTransactionDate.val());
        }
        
        var contraBon = formatDate($("#vendorDebitNote\\.transactionDate").val(),false);
        var paymentTermDays = $("#vendorDebitNote\\.paymentTerm\\.days").val();
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
        
        $("#vendorDebitNote\\.dueDate").val(someFormattedDate);
    }
    
    function calculateVendorDebitNoteDetail() {
        var selectedRowID = $("#vendorDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#vendorDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = vendorDebitNoteDetaillastRowId;
        }
        var qty = $("#" + selectedRowID + "_vendorDebitNoteDetailQuantity").val();
        var amount = $("#" + selectedRowID + "_vendorDebitNoteDetailPrice").val();

        var subAmount = (parseFloat(qty) * parseFloat(amount));
        $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID, "vendorDebitNoteDetailTotal", subAmount);

        vendorDebitNoteCalculateHeader();
    }
        
    function vendorDebitNoteCalculateHeader() {
        var totalTransaction = 0;
        var discPercent=removeCommas(txtVendorDebitNoteDiscountPercent.val());
        var vatPercent=removeCommas(txtVendorDebitNoteVATPercent.val());
        var ids = jQuery("#vendorDebitNoteDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#vendorDebitNoteDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.vendorDebitNoteDetailTotal);
        }
        
        if(txtVendorDebitNoteDiscountPercent.val()===""){
            discPercent=0;
        }
        if(txtVendorDebitNoteVATPercent.val()===""){
            vatPercent=0;
        }
        
        var discAmount = (totalTransaction *  parseFloat(discPercent))/100;
        var subTotalAmount = (totalTransaction - parseFloat(discAmount.toFixed(2)));
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotalAmount =(parseFloat(subTotalAmount) + parseFloat(vatAmount.toFixed(2)));
        
        txtVendorDebitNoteTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        txtVendorDebitNoteDiscountAmount.val(formatNumber(parseFloat(discAmount.toFixed(2)),2));
        $("#vendorDebitNoteSubTotal").val(formatNumber(subTotalAmount,2));
        txtVendorDebitNoteVATAmount.val(formatNumber(parseFloat(vatAmount.toFixed(2)),2));        
        txtVendorDebitNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));

    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
        
    function vendorDebitNoteLoadDetail() {
        var url = "purchasing/vendor-debit-note-detail-data";
        var params = "vendorDebitNote.code=" + txtVendorDebitNoteCode.val();
        
        $.getJSON(url, params, function(data) {
            vendorDebitNoteDetaillastRowId = 0;
            for (var i=0; i<data.listVendorDebitNoteDetailTemp.length; i++) {
                vendorDebitNoteDetaillastRowId++;
                $("#vendorDebitNoteDetailInput_grid").jqGrid("addRowData", vendorDebitNoteDetaillastRowId, data.listVendorDebitNoteDetailTemp[i]);
                $("#vendorDebitNoteDetailInput_grid").jqGrid('setRowData',vendorDebitNoteDetaillastRowId,{
                    vendorDebitNoteDetailCode                   : data.listVendorDebitNoteDetailTemp[i].code,
                    vendorDebitNoteDetailDelete                 : "delete",
                    vendorDebitNoteDetailSearchChartOfAccount   : "...",
                    vendorDebitNoteDetailQuantity               : data.listVendorDebitNoteDetailTemp[i].quantity,
                    vendorDebitNoteDetailChartOfAccountCode     : data.listVendorDebitNoteDetailTemp[i].chartOfAccountCode,
                    vendorDebitNoteDetailChartOfAccountName     : data.listVendorDebitNoteDetailTemp[i].chartOfAccountName,
                    vendorDebitNoteDetailPrice                  : data.listVendorDebitNoteDetailTemp[i].price,
                    vendorDebitNoteDetailUnitOfMeasureCode      : data.listVendorDebitNoteDetailTemp[i].unitOfMeasureCode,
                    vendorDebitNoteDetailUnitOfMeasureName      : data.listVendorDebitNoteDetailTemp[i].unitOfMeasureName,
                    vendorDebitNoteDetailBranchCode             : data.listVendorDebitNoteDetailTemp[i].branchCode,
                    vendorDebitNoteDetailRemark                 : data.listVendorDebitNoteDetailTemp[i].remark,
                    vendorDebitNoteDetailTotal                  : ((data.listVendorDebitNoteDetailTemp[i].quantity * data.listVendorDebitNoteDetailTemp[i].price))
                });
            }
            vendorDebitNoteCalculateHeader();
        });
    }
        
    function vendorDebitNoteFormatDate(){
        var transactionDate=dtpVendorDebitNoteTransactionDate.val();
        var dateValuesTemp= transactionDate.split(' ');
        var dateValues= dateValuesTemp[0].split('/');
        var transactionDateValue =dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+dateValuesTemp[1];
        dtpVendorDebitNoteTransactionDate.val(transactionDateValue);   
        $("#vendorDebitNoteTemp\\.transactionDateTemp").val(transactionDateValue);
        
        var taxInvoiceDate=dtpVendorDebitNoteTaxInvoiceDate.val();
        var taxInvoiceDateTemp= taxInvoiceDate.split(' ');
        var taxInvoiceDateValues= taxInvoiceDateTemp[0].split('/');
        var taxInvoiceDateValue =taxInvoiceDateValues[1]+"/"+taxInvoiceDateValues[0]+"/"+taxInvoiceDateValues[2]+" "+taxInvoiceDateTemp[1];
        dtpVendorDebitNoteTaxInvoiceDate.val(taxInvoiceDateValue);   
        $("#vendorDebitNoteTemp\\.taxInvoiceDateTemp").val(taxInvoiceDateValue);
        
        var vendorInvoiceDate=dtpVendorDebitNoteVendorInvoiceDate.val();
        var vendorInvoiceDateTemp= vendorInvoiceDate.split(' ');
        var vendorInvoiceDateValues= vendorInvoiceDateTemp[0].split('/');
        var vendorInvoiceDateValue =vendorInvoiceDateValues[1]+"/"+vendorInvoiceDateValues[0]+"/"+vendorInvoiceDateValues[2]+" "+vendorInvoiceDateTemp[1];
        dtpVendorDebitNoteVendorInvoiceDate.val(vendorInvoiceDateValue);   
        $("#vendorDebitNoteTemp\\.vendorInvoiceDateTemp").val(vendorInvoiceDateValue);
        
        var createdDate=dtpVendorDebitNoteCreatedDate.val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpVendorDebitNoteCreatedDate.val(createdDateValue);
        $("#vendorDebitNoteTemp\\.createdDateTemp").val(createdDateValue);
        
        var dueDate=dtpVendorDebitNoteDueDate.val();
        var dueDateValuesTemp= dueDate.split(' ');
        var dueDateValues= dueDateValuesTemp[0].split('/');
        var dueDateValue =dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2]+" "+dueDateValuesTemp[1];
        dtpVendorDebitNoteDueDate.val(dueDateValue);
  //      $("#vendorDebitNoteTemp\\.transactionDateTemp").val(dtpVendorDebitNoteTransactionDate.val());
 
    }
    
    function vendorDebitNoteFormatNumeric(){
        var exchangerate =parseFloat(txtVendorDebitNoteExchangeRate.val());
        txtVendorDebitNoteExchangeRate.val(formatNumber(exchangerate,2));
        var totalTransactionAmount=parseFloat(txtVendorDebitNoteTotalTransactionAmount.val());
        txtVendorDebitNoteTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent=parseFloat(txtVendorDebitNoteDiscountPercent.val());
        txtVendorDebitNoteDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount=parseFloat(txtVendorDebitNoteDiscountAmount.val());
        txtVendorDebitNoteDiscountAmount.val(formatNumber(discountAmount,2));
        var vatPercent=parseFloat(txtVendorDebitNoteVATPercent.val());
        txtVendorDebitNoteVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount=parseFloat(txtVendorDebitNoteVATAmount.val());
        txtVendorDebitNoteVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtVendorDebitNoteGrandTotalAmount.val());
        txtVendorDebitNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }
    
    function vendorDebitNoteUnFormatNumeric(){
        var exchangerate =removeCommas(txtVendorDebitNoteExchangeRate.val());
        txtVendorDebitNoteExchangeRate.val(exchangerate);
        var totalTransactionAmount =removeCommas(txtVendorDebitNoteTotalTransactionAmount.val());
        txtVendorDebitNoteTotalTransactionAmount.val(totalTransactionAmount);
        var discountPercent =removeCommas(txtVendorDebitNoteDiscountPercent.val());
        txtVendorDebitNoteDiscountPercent.val(discountPercent);
        var discountAmount =removeCommas(txtVendorDebitNoteDiscountAmount.val());
        txtVendorDebitNoteDiscountAmount.val(discountAmount);
        var vatPercent =removeCommas(txtVendorDebitNoteVATPercent.val());
        txtVendorDebitNoteVATPercent.val(vatPercent);
        var vatAmount=removeCommas(txtVendorDebitNoteVATAmount.val());
        txtVendorDebitNoteVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtVendorDebitNoteGrandTotalAmount.val());
        txtVendorDebitNoteGrandTotalAmount.val(grandTotalAmount);
    }

    function vendorDebitNoteDetailInputGrid_SearchChartOfAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorDebitNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function vendorDebitNoteDetailInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=vendorDebitNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function vendorDebitNoteDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#vendorDebitNoteDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#vendorDebitNoteDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        vendorDebitNoteCalculateHeader();
        
    }
    
    function vendorDebitNoteOnChangeChartOfAccount(){
        var selectedRowID = $("#vendorDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var chartOfAccountCode = $("#" + selectedRowID + "_vendorDebitNoteDetailChartOfAccountCode").val();

        var url = "master/chart-of-account-get";
        var params = "chartOfAccount.code=" + chartOfAccountCode;
            params+= "&chartOfAccount.activeStatus=TRUE";

        if(chartOfAccountCode.trim()===""){
            $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorDebitNoteDetailChartOfAccountName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_salesOrderDetailFeeReceiverCode5").val(data.chartOfAccountTemp.code);
                $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorDebitNoteDetailChartOfAccountName",data.chartOfAccountTemp.name);
            }
            else{
                alertMessage("Chart Of Account Not Found!",$("#" + selectedRowID + "_vendorDebitNoteDetailChartOfAccountSearch"));
                $("#" + selectedRowID + "_vendorDebitNoteDetailChartOfAccountCode").val("");
                $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorDebitNoteDetailChartOfAccounttName"," ");
            }
        });
    }
    
    function vendorDebitNoteOnChangeUnitOfMeasure(){
        var selectedRowID = $("#vendorDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var unitOfMeasureCode = $("#" + selectedRowID + "_vendorDebitNoteDetailUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + unitOfMeasureCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";

        if(unitOfMeasureCode.trim()===""){
            $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorDebitNoteDetailUnitOfMeasureName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_vendorDebitNoteDetailUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
                $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorDebitNoteDetailUnitOfMeasureName",data.unitOfMeasureTemp.name);
            }
            else{
                alertMessage("UOM Not Found!",$("#" + selectedRowID + "_vendorDebitNoteDetailUnitOfMeasureSearch"));
                $("#" + selectedRowID + "_vendorDebitNoteDetailUnitOfMeasureCode").val("");
                $("#vendorDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"vendorDebitNoteDetailUnitOfMeasuretName"," ");
            }
        });
    }
    
      function vendorDebitNoteLoadExchangeRate(){
        if($("#vendorDebitNoteUpdateMode").val()==="false"){
            if(txtVendorDebitNoteCurrencyCode.val()==="IDR"){
                txtVendorDebitNoteExchangeRate.val("1.00");
                txtVendorDebitNoteExchangeRate.attr('readonly',true);
            }else{
                txtVendorDebitNoteExchangeRate.val("0.00");
                txtVendorDebitNoteExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtVendorDebitNoteCurrencyCode.val()==="IDR"){
                txtVendorDebitNoteExchangeRate.val("1.00");
                txtVendorDebitNoteExchangeRate.attr('readonly',true);
            }else{
                txtVendorDebitNoteExchangeRate.attr('readonly',false);
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
                    txtVendorDebitNoteCurrencyCode.val(data.currencyTemp.code);
                    txtVendorDebitNoteCurrencyName.val(data.currencyTemp.name);
                    vendorDebitNoteLoadExchangeRate();
                }
                else{
                    alertMessage("Currency Not Found!",txtVendorDebitNoteCurrencyCode);
                    txtVendorDebitNoteCurrencyCode.val("");
                    txtVendorDebitNoteCurrencyName.val("");
                    txtVendorDebitNoteExchangeRate.val("0.00");
                    txtVendorDebitNoteExchangeRate.attr("readonly",true);
                }
            });
    }
    function vendor_debit_note_handlers_input(){
        if(txtVendorDebitNoteBranchCode.val()===""){
            handlersInput(txtVendorDebitNoteBranchCode);
        }else{
            unHandlersInput(txtVendorDebitNoteBranchCode);
        }
        
        if(dtpVendorDebitNoteTransactionDate.val()===""){
            handlersInput(dtpVendorDebitNoteTransactionDate);
        }else{
            unHandlersInput(dtpVendorDebitNoteTransactionDate);
        }
        
        if(txtVendorDebitNoteCurrencyCode.val()===""){
            handlersInput(txtVendorDebitNoteCurrencyCode);
        }else{
            unHandlersInput(txtVendorDebitNoteCurrencyCode);
        }
        
        if(txtVendorDebitNoteVendorCode.val()===""){
            handlersInput(txtVendorDebitNoteVendorCode);
        }else{
            unHandlersInput(txtVendorDebitNoteVendorCode);
        }
         if(txtVendorDebitNotePaymentTermCode.val()===""){
            handlersInput(txtVendorDebitNotePaymentTermCode);
        }else{
            unHandlersInput(txtVendorDebitNotePaymentTermCode);
        }
        
      
    }
</script>
<s:url id="remoteurlVendorDebitNoteDetailInput" action="vendor-debit-note-detail-data" />
<b>VENDOR DEBIT NOTE</b>
<hr>
<br class="spacer" />
<div id="vendorDebitNoteInput" class="content ui-widget">
    <s:form id="frmVendorDebitNoteInput">
        <table cellpadding="2" cellspacing="2" id="vendorDebitNoteHeaderInput">
            
            <tr>
                <td align="right"><B>VDN *</B></td>
                <td colspan="3">
                    <s:textfield id="vendorDebitNote.code" name="vendorDebitNote.code" readonly="true" size="27"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td colspan="3">
                    <sj:datepicker id="vendorDebitNote.transactionDate" name="vendorDebitNote.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="vendorDebitNoteTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="vendorDebitNoteTransactionDate" name="vendorDebitNoteTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Payment Term *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtVendorDebitNotePaymentTermCode.change(function(ev) {
                            if(txtVendorDebitNotePaymentTermCode.val()===""){
                                txtVendorDebitNotePaymentTermName.val("");
                                txtVendorDebitNotePaymentTermDays.val("0");
                                return;
                            }
                            var url = "master/payment-term-get";
                            var params = "paymentTerm.code=" + txtVendorDebitNotePaymentTermCode.val();
                                params+= "&paymentTerm.activeStatus=TRUE";
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.paymentTermTemp){
                                    txtVendorDebitNotePaymentTermCode.val(data.paymentTermTemp.code);
                                    txtVendorDebitNotePaymentTermName.val(data.paymentTermTemp.name);
                                    txtVendorDebitNotePaymentTermDays.val(data.paymentTermTemp.days);
                                }
                                else{
                                    alertMessage("Payment Term Not Found!",txtVendorDebitNotePaymentTermCode);
                                    txtVendorDebitNotePaymentTermCode.val("");
                                    txtVendorDebitNotePaymentTermName.val("");
                                    txtVendorDebitNotePaymentTermDays.val("0");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="vendorDebitNote.paymentTerm.code" name="vendorDebitNote.paymentTerm.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="vendorDebitNote_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorDebitNote.paymentTerm.name" name="vendorDebitNote.paymentTerm.name" size="40" readonly="true"></s:textfield>
                        <s:textfield id="vendorDebitNote.paymentTerm.days" name="vendorDebitNote.paymentTerm.days" size="20" readonly="true"></s:textfield>
            </td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Due Date</B></td>
                <td><sj:datepicker id="vendorDebitNote.dueDate" name="vendorDebitNote.dueDate" readonly="true" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="false" timepickerFormat="hh:mm:ss"></sj:datepicker></td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">

                        txtVendorDebitNoteBranchCode.change(function(ev) {

                            if(txtVendorDebitNoteBranchCode.val()===""){
                                txtVendorDebitNoteBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtVendorDebitNoteBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtVendorDebitNoteBranchCode.val(data.branchTemp.code);
                                    txtVendorDebitNoteBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtVendorDebitNoteBranchCode);
                                    txtVendorDebitNoteBranchCode.val("");
                                    txtVendorDebitNoteBranchName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="vendorDebitNote.branch.code" name="vendorDebitNote.branch.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                        <sj:a id="vendorDebitNote_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorDebitNote.branch.name" name="vendorDebitNote.branch.name" cssStyle="width:49%" readonly="true"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Currency *</B></td>
                <td colspan="3">
                    <script type = "text/javascript">

                        txtVendorDebitNoteCurrencyCode.change(function(ev) {

                            if(txtVendorDebitNoteCurrencyCode.val()===""){
                                txtVendorDebitNoteCurrencyName.val("");
                                txtVendorDebitNoteExchangeRate.val("0.00");
                                txtVendorDebitNoteExchangeRate.attr('readonly',true);
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtVendorDebitNoteCurrencyCode.val();
                                params+= "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtVendorDebitNoteCurrencyCode.val(data.currencyTemp.code);
                                    txtVendorDebitNoteCurrencyName.val(data.currencyTemp.name);
                                    vendorDebitNoteLoadExchangeRate();
                                }
                                else{
                                    alertMessage("Currency Not Found",txtVendorDebitNoteCurrencyCode);
                                    txtVendorDebitNoteCurrencyCode.val("");
                                    txtVendorDebitNoteCurrencyName.val("");
                                    txtVendorDebitNoteExchangeRate.val("0.00");
                                    txtVendorDebitNoteExchangeRate.attr("readonly",true);
//                                    calculateVendorDebitNoteTotalTransactionAmountIDR();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendorDebitNote.currency.code" name="vendorDebitNote.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="vendorDebitNote_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorDebitNote.currency.name" name="vendorDebitNote.currency.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Exchange Rate *</B></td>
                <td>
                    <s:textfield id="vendorDebitNote.exchangeRate" name="vendorDebitNote.exchangeRate" size="20" cssStyle="text-align:right" required="true" cssClass="required"></s:textfield>&nbsp;<span id="errmsgExchangeRate"></span>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Vendor *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtVendorDebitNoteVendorCode.change(function(ev) {
                            
                            if(txtVendorDebitNoteVendorCode.val()===""){
                                txtVendorDebitNoteVendorName.val("");
                                return;
                            }
                            var url = "master/vendor-get";
                            var params = "vendor.code=" + txtVendorDebitNoteVendorCode.val();
                                params +="&vendor.activeStatus=true";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.vendorTemp){
                                    txtVendorDebitNoteVendorCode.val(data.vendorTemp.code);
                                    txtVendorDebitNoteVendorName.val(data.vendorTemp.name);
                                }
                                else{
                                    alertMessage("Vendor Not Found!",txtVendorDebitNoteVendorCode);
                                    txtVendorDebitNoteVendorCode.val("");
                                    txtVendorDebitNoteVendorName.val("");
                                }   
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="vendorDebitNote.vendor.code" name="vendorDebitNote.vendor.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                        <sj:a id="vendorDebitNote_btnVendor" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorDebitNote.vendor.name" name="vendorDebitNote.vendor.name" size="45" readonly="true"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right">Tax Invoice No</td>
                <td><s:textfield id="vendorDebitNote.taxInvoiceNo" name="vendorDebitNote.taxInvoiceNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Tax Invoice Date</td>
                <td>
                    <sj:datepicker id="vendorDebitNote.taxInvoiceDate" name="vendorDebitNote.taxInvoiceDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Vendor Invoice No</td>
                <td><s:textfield id="vendorDebitNote.vendorInvoiceNo" name="vendorDebitNote.vendorInvoiceNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Vendor Invoice Date</td>
                <td>
                    <sj:datepicker id="vendorDebitNote.vendorInvoiceDate" name="vendorDebitNote.vendorInvoiceDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="vendorDebitNote.refNo" name="vendorDebitNote.refNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3"><s:textarea id="vendorDebitNote.remark" name="vendorDebitNote.remark"  cols="60" rows="2" height="20"></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="vendorDebitNoteUpdateMode" name="vendorDebitNoteUpdateMode"></s:textfield>
                    <s:textfield id="vendorDebitNoteTemp.transactionDateTemp" name="vendorDebitNoteTemp.transactionDateTemp"></s:textfield>
                    <s:textfield id="vendorDebitNoteTemp.taxInvoiceDateTemp" name="vendorDebitNoteTemp.taxInvoiceDateTemp"></s:textfield>
                    <s:textfield id="vendorDebitNoteTemp.vendorInvoiceDateTemp" name="vendorDebitNoteTemp.vendorInvoiceDateTemp"></s:textfield>
                    <sj:datepicker id="vendorDebitNoteDateFirstSession" name="vendorDebitNoteDateFirstSession" size="15" showOn="focus"></sj:datepicker>
                    <sj:datepicker id="vendorDebitNoteDateLastSession" name="vendorDebitNoteDateLastSession" size="15" showOn="focus"></sj:datepicker>
                    <s:textfield id="vendorDebitNote.createdBy" name="vendorDebitNote.createdBy" key="vendorDebitNote.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="vendorDebitNote.createdDate" name="vendorDebitNote.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="vendorDebitNoteTemp.createdDateTemp" name="vendorDebitNoteTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table> 
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmVendorDebitNote" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmVendorDebitNote" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
                    
        <div id="vendorDebitNoteDetailInputGrid">
            <sjg:grid
                id="vendorDebitNoteDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="true"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listVendorDebitNoteTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuVendorDebitNoteDetail').width()"
                editurl="%{remoteurlVendorDebitNoteDetailInput}"
                onSelectRowTopics="vendorDebitNoteDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="vendorDebitNoteDetail" index="vendorDebitNoteDetail" title="" width="50" hidden="true"
                    editable="true" edittype="button"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailCode" index="vendorDebitNoteDetailCode" title="vendorDebitNoteDetailCode" width="100" 
                    sortable="true" hidden="true"
                />   
                <sjg:gridColumn
                    name="vendorDebitNoteDetailDelete" index="vendorDebitNoteDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'vendorDebitNoteDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailBranchCode" index="vendorDebitNoteDetailBranchCode" key="vendorDebitNoteDetailBranchCode" 
                    title="Branch" width="80" sortable="true"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailChartOfAccountSearch" index="vendorDebitNoteDetailChartOfAccountSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'vendorDebitNoteDetailInputGrid_SearchChartOfAccount_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailChartOfAccountCode" index="vendorDebitNoteDetailChartOfAccountCode" title="Chart Of Account Code" width="200" 
                    sortable="true" editable="true" editoptions="{onChange:'vendorDebitNoteOnChangeChartOfAccount()'}"
                />     
                <sjg:gridColumn
                    name="vendorDebitNoteDetailChartOfAccountName" index="vendorDebitNoteDetailChartOfAccountName" title="Chart Of Account Name" width="200" sortable="true"
                />  
                <sjg:gridColumn
                    name="vendorDebitNoteDetailRemark" index="vendorDebitNoteDetailRemark" key="vendorDebitNoteDetailRemark" 
                    title="Remark" width="200" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailQuantity" index="vendorDebitNoteDetailQuantity" key="vendorDebitNoteDetailQuantity" title="Quantity" 
                    width="70" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    editoptions="{ondblclick:'this.setSelectionRange(0, this.value.length)',onKeyUp:'calculateVendorDebitNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailUnitOfMeasureSearch" index="vendorDebitNoteDetailUnitOfMeasureSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'vendorDebitNoteDetailInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailUnitOfMeasureCode" index="vendorDebitNoteDetailUnitOfMeasureCode" title="Unit" width="80" 
                    sortable="true" editable="true" editoptions="{onChange:'vendorDebitNoteOnChangeUnitOfMeasure()'}"
                />     
                <sjg:gridColumn
                    name="vendorDebitNoteDetailPrice" index="vendorDebitNoteDetailPrice" key="vendorDebitNoteDetailPrice" title="Amount" 
                    width="150" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    editoptions="{ondblclick:'this.setSelectionRange(0, this.value.length)',onKeyUp:'calculateVendorDebitNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="vendorDebitNoteDetailTotal" index="vendorDebitNoteDetailTotal" key="vendorDebitNoteDetailTotal" title="Total" 
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
                                <s:textfield id="vendorDebitNoteDetailAddRow" name="vendorDebitNoteDetailAddRow" cssStyle="text-align:right" size="10" value="1"></s:textfield>
                                <sj:a href="#" id="btnVendorDebitNoteAddDetail" button="true"  style="width: 60px">Add</sj:a>&nbsp;<span id="errmsgAddRow"></span>
                            </td>
                        </tr>
                        <tr>
                            <td height="20px"/>
                        </tr>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnVendorDebitNoteSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnVendorDebitNoteCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td width="70%">
                    <table width="100%">
                        <tr>
                            <td align="right"><B>Total Transaction</B></td>
                            <td width="100px">
                                <s:textfield id="vendorDebitNote.totalTransactionAmount" name="vendorDebitNote.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Discount
                                <s:textfield id="vendorDebitNote.discountPercent" onkeyup="vendorDebitNoteCalculateHeader()" name="vendorDebitNote.discountPercent" size="5" cssStyle="text-align:right"></s:textfield>
                                %
                            </td>
                            <td><s:textfield id="vendorDebitNote.discountAmount" onchange="vendorDebitNoteCalculateHeader()" name="vendorDebitNote.discountAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                        </tr>
                        
                        <tr>
                            <td align="right" style="width:120px">Discount Account </td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtVendorDebitNoteDiscountAccountCode.change(function(ev) {

                                    if(txtVendorDebitNoteDiscountAccountCode.val()===""){
                                        txtVendorDebitNoteDiscountAccountName.val("");
                                        return;
                                    }
                                    var url = "master/chart-of-account-get";
                                    var params = "chartOfAccount.code=" + txtVendorDebitNoteDiscountAccountCode.val();
                                        params += "&chartOfAccount.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.chartOfAccountTemp){
                                            txtVendorDebitNoteDiscountAccountCode.val(data.chartOfAccountTemp.code);
                                            txtVendorDebitNoteDiscountAccountName.val(data.chartOfAccountTemp.name);
                                        }
                                        else{
                                            alertMessage("Chart Of Account Not Found!",txtVendorDebitNoteDiscountAccountCode);
                                            txtVendorDebitNoteDiscountAccountCode.val("");
                                            txtVendorDebitNoteDiscountAccountName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="vendorDebitNote.discountAccount.code" name="vendorDebitNote.discountAccount.code" size="22"></s:textfield>
                                <sj:a id="vendorDebitNote_btnChartOfAccount" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="vendorDebitNote.discountAccount.name" name="vendorDebitNote.discountAccount.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right"><B>Sub Total(Tax Base)</B></td>
                            <td>
                                <s:textfield id="vendorDebitNoteSubTotal" name="vendorDebitNoteSubTotal"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">VAT
                            <s:textfield id="vendorDebitNote.vatPercent" onkeyup="vendorDebitNoteCalculateHeader()" name="vendorDebitNote.vatPercent" size="5" cssStyle="text-align:right"></s:textfield>
                                %
                            </td>
                            <td><s:textfield id="vendorDebitNote.vatAmount" name="vendorDebitNote.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="vendorDebitNote.grandTotalAmount" name="vendorDebitNote.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>     
    