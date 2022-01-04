
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #customerDebitNoteDetailInput_grid_pager_center,.ui-dialog-titlebar-close{
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
    
    var customerDebitNoteDetaillastRowId=0,customerDebitNoteDetail_lastSel = -1;
    var 
        txtCustomerDebitNoteCode = $("#customerDebitNote\\.code"),
        txtCustomerDebitNoteBranchCode = $("#customerDebitNote\\.branch\\.code"),
        txtCustomerDebitNoteBranchName = $("#customerDebitNote\\.branch\\.name"),
        dtpCustomerDebitNoteTransactionDate = $("#customerDebitNote\\.transactionDate"),
        dtpCustomerDebitNoteDueDate = $("#customerDebitNote\\.dueDate"),
        txtCustomerDebitNoteCurrencyCode= $("#customerDebitNote\\.currency\\.code"),
        txtCustomerDebitNoteCurrencyName= $("#customerDebitNote\\.currency\\.name"),
        txtCustomerDebitNoteDiscountAccountCode= $("#customerDebitNote\\.discountAccount\\.code"),
        txtCustomerDebitNoteDiscountAccountName= $("#customerDebitNote\\.discountAccount\\.name"),
        txtCustomerDebitNoteExchangeRate = $("#customerDebitNote\\.exchangeRate"),
        txtCustomerDebitNoteCustomerCode= $("#customerDebitNote\\.customer\\.code"),
        txtCustomerDebitNoteCustomerName= $("#customerDebitNote\\.customer\\.name"),
    //    txtCustomerDebitNoteTaxInvoiceNo= $("#customerDebitNote\\.taxInvoiceNo"),
//        dtpCustomerDebitNoteTaxInvoiceDate= $("#customerDebitNote\\.taxInvoiceDate"),
        txtCustomerDebitNoteRefNo = $("#customerDebitNote\\.refNo"),
        txtCustomerDebitNoteRemark = $("#customerDebitNote\\.remark"),
        txtCustomerDebitNoteCreatedBy = $("#customerDebitNote\\.createdBy"),
        dtpCustomerDebitNoteCreatedDate = $("#customerDebitNote\\.createdDate"),
        txtCustomerDebitNoteTotalTransactionAmount = $("#customerDebitNote\\.totalTransactionAmount"),
        txtCustomerDebitNoteDiscountPercent = $("#customerDebitNote\\.discountPercent"),
        txtCustomerDebitNoteDiscountAmount = $("#customerDebitNote\\.discountAmount"),
        txtCustomerDebitNoteSubTotalAmount= $("#customerDebitNoteSubTotalAmount"),
        txtCustomerDebitNoteVATPercent = $("#customerDebitNote\\.vatPercent"),
        txtCustomerDebitNoteVATAmount = $("#customerDebitNote\\.vatAmount"),
        txtCustomerDebitNoteGrandTotalAmount = $("#customerDebitNote\\.grandTotalAmount"),
        txtCustomerDebitNotePaymentTermCode = $("#customerDebitNote\\.paymentTerm\\.code"),
        txtCustomerDebitNotePaymentTermName = $("#customerDebitNote\\.paymentTerm\\.name"),
        txtCustomerDebitNotePaymentTermDays = $("#customerDebitNote\\.paymentTerm\\.days"),
                
        allFieldsCustomerDebitNote = $([])
            .add(txtCustomerDebitNotePaymentTermCode)
            .add(txtCustomerDebitNotePaymentTermName)
            .add(txtCustomerDebitNotePaymentTermDays)
            .add(txtCustomerDebitNoteCode)
            .add(txtCustomerDebitNoteCustomerCode)
            .add(txtCustomerDebitNoteCustomerName)
            .add(txtCustomerDebitNoteRefNo)
            .add(txtCustomerDebitNoteRemark)
            .add(txtCustomerDebitNoteTotalTransactionAmount)
            .add(txtCustomerDebitNoteVATPercent)
            .add(txtCustomerDebitNoteVATAmount)
            .add(txtCustomerDebitNoteGrandTotalAmount);


    $(document).ready(function() {
        
        flagIsConfirmedCDN=false;
        customerDebitNoteLoadExchangeRate();
        formatNumericCDN();
        if($("#customerDebitNoteUpdateMode").val()==="false"){
            setCurrency();
        }
        $("#customerDebitNoteDetailAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerDebitNoteDetailAddRow").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
           
        });
        
        $("#customerDebitNote\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerDebitNote\\.exchangeRate").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
           
        });
        
        $("#customerDebitNote\\.exchangeRate").change(function(e){
            var exrate=$("#customerDebitNote\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#customerDebitNote\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerDebitNote\\.discountPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerDebitNote\\.discountPercent").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
        });
        
        $("#customerDebitNote\\.discountPercent").change(function(e){
            var disc=$("#customerDebitNote\\.discountPercent").val();
            
            if(disc==="" || parseFloat(disc)===0){
               $("#customerDebitNote\\.discountPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerDebitNote\\.discountAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });

        $("#customerDebitNote\\.discountAmount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
        });
        
        $("#customerDebitNote\\.discountAmount").change(function(e){
            var amount=$("#customerDebitNote\\.discountAmount").val();
            if(amount===""){
               $("#customerDebitNote\\.discountAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerDebitNote\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerDebitNote\\.vatPercent").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
        });
        
        $("#customerDebitNote\\.vatPercent").change(function(e){
            var amount=$("#customerDebitNote\\.vatPercent").val();
            if(amount===""){
               $("#customerDebitNote\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#btnUnConfirmCustomerDebitNote").css("display", "none");
        $('#customerDebitNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmCustomerDebitNote").click(function(ev) {
            handlers_input_customer_debit_note();
            customerDebitNoteTransactionDateOnChange();
            if(txtCustomerDebitNoteBranchCode.val()===''){
                alertMessage("Branch Cant be Empty");
                return;
            }
            if(txtCustomerDebitNoteCurrencyCode.val()===''){
                alertMessage("Currency Cant be Empty");
                return;
            }
            if(txtCustomerDebitNoteCustomerCode.val()===''){
                alertMessage("Customer Cant be Empty");
                return;
            }
            if(txtCustomerDebitNotePaymentTermCode.val()===''){
                alertMessage("Payment Term Cant be Empty");
                return;
            }
            
             if(parseFloat(txtCustomerDebitNoteExchangeRate.val())<=1 && txtCustomerDebitNoteCurrencyCode.val()!=="IDR"){
           
                txtCustomerDebitNoteExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtCustomerDebitNoteCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtCustomerDebitNoteExchangeRate.attr("style","color:black");
            }
            var date1 = dtpCustomerDebitNoteTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#customerDebitNoteTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#customerDebitNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#customerDebitNoteTransactionDate").val(),dtpCustomerDebitNoteTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCustomerDebitNoteTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#customerDebitNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#customerDebitNoteTransactionDate").val(),dtpCustomerDebitNoteTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCustomerDebitNoteTransactionDate);
                }
                return;
            }

            if($("#customerDebitNoteUpdateMode").val()==="true"){
                customerDebitNoteLoadDataDetail();
            }
            
            flagIsConfirmedCDN=true;
            $("#btnUnConfirmCustomerDebitNote").css("display", "block");
            $("#btnConfirmCustomerDebitNote").css("display", "none");   
            $('#headerCustomerDebitNoteInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#customerDebitNoteDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmCustomerDebitNote").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#customerDebitNoteDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    $("#btnUnConfirmCustomerDebitNote").css("display", "none");
                    $("#btnConfirmCustomerDebitNote").css("display", "block");
                    $('#headerCustomerDebitNoteInput').unblock();
                    $('#customerDebitNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    flagIsConfirmedCDN=false;
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
                                flagIsConfirmedCDN=false;
                                $("#customerDebitNoteDetailInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmCustomerDebitNote").css("display", "none");
                                $("#btnConfirmCustomerDebitNote").css("display", "block");
                                $('#headerCustomerDebitNoteInput').unblock();
                                $('#customerDebitNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $.subscribe("customerDebitNoteDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerDebitNoteDetail_lastSel) {

                $('#customerDebitNoteDetailInput_grid').jqGrid("saveRow",customerDebitNoteDetail_lastSel); 
                $('#customerDebitNoteDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerDebitNoteDetail_lastSel=selectedRowID;

            }
            else{
                $('#customerDebitNoteDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });


        $('#btnCustomerDebitNoteAddDetail').click(function(ev) {
            
            if(!flagIsConfirmedCDN){
                alertMessage("Please Confirm!",$("#btnConfirmCustomerDebitNote"));
                return;
            }
            
            var AddRowCount =parseFloat(removeCommas($("#customerDebitNoteDetailAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerDebitNoteDetailBranchCode : txtCustomerDebitNoteBranchCode.val()
                };
                customerDebitNoteDetaillastRowId++;
                $("#customerDebitNoteDetailInput_grid").jqGrid("addRowData", customerDebitNoteDetaillastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerDebitNoteDetailInput_grid").jqGrid('setRowData',customerDebitNoteDetaillastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerDebitNoteSave').click(function(ev) {
            
            if(!flagIsConfirmedCDN){
                alertMessage("Please Confirm!",$("#btnConfirmCustomerDebitNote"));
                return;
            }
            
            if(customerDebitNoteDetail_lastSel !== -1) {
                $('#customerDebitNoteDetailInput_grid').jqGrid("saveRow",customerDebitNoteDetail_lastSel); 
            }
                       
            var listCustomerDebitNoteDetail = new Array(); 
            var ids = jQuery("#customerDebitNoteDetailInput_grid").jqGrid('getDataIDs'); 

            if(ids.length===0){
                alertMessage("Grid Detail Can't Empty!");
                return;
            }


            for(var i=0;i < ids.length;i++){ 
                var data = $("#customerDebitNoteDetailInput_grid").jqGrid('getRowData',ids[i]); 

                if(data.customerDebitNoteDetailChartOfAccountCode===""){
                    alertMessage("Chart Of Account Can't Empty!");
                    return;
                }
                
                if(data.customerDebitNoteDetailUnitOfMeasureCode===""){
                    alertMessage("Unit Of Measure Can't Empty!");
                    return;
                }
                
                var customerDebitNoteDetail = { 
                    remark              : data.customerDebitNoteDetailRemark,
                    chartOfAccount      : {code:data.customerDebitNoteDetailChartOfAccountCode},
                    unitOfMeasure       : {code:data.customerDebitNoteDetailUnitOfMeasureCode},
                    branch              : {code:data.customerDebitNoteDetailBranchCode},
                    quantity            : data.customerDebitNoteDetailQuantity,
                    price               : data.customerDebitNoteDetailPrice,
                    totalAmount         : data.customerDebitNoteDetailTotal
                };
                listCustomerDebitNoteDetail[i] = customerDebitNoteDetail;
            }
            
            if(parseFloat(txtCustomerDebitNoteTotalTransactionAmount.val())===0.00){
                alertMessage("Can't be 0 value for Total Transaction!");
                return;
            }
            
            if(txtCustomerDebitNoteDiscountPercent.val()!=0 && txtCustomerDebitNoteDiscountAccountCode.val()===""){
                alertMessage("Discount Account Cant be Empty");
                return;
            }
            
            
            unHandlersInput(txtCustomerDebitNoteDiscountPercent);
            
            formatDateCDN();
            unFormatNumericCDN();
                        
            var url = "sales/customer-debit-note-save";
            var params = $("#frmCustomerDebitNoteInput").serialize();
                params += "&listCustomerDebitNoteDetailJSON=" + $.toJSON(listCustomerDebitNoteDetail);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateCDN();
                    formatNumericCDN();
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
                    closeText: "hide",
                    buttons : 
                        [{
                            text : "Yes",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "sales/customer-debit-note-input";
                                pageLoad(url, params, "#tabmnuCUSTOMER_DEBIT_NOTE");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "sales/customer-debit-note";
                                pageLoad(url, params, "#tabmnuCUSTOMER_DEBIT_NOTE");
                            }
                        }]
                    });
            });
            
        });
  
        $('#btnCustomerDebitNoteCancel').click(function(ev) {
            var url = "sales/customer-debit-note";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_DEBIT_NOTE"); 
        });
        
        $('#customerDebitNote_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=customerDebitNote&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerDebitNote_btnChartOfAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerDebitNote&idsubdoc=discountAccount","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerDebitNote_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerDebitNote&idsubdoc=customer","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#customerDebitNote_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=customerDebitNote&idsubdoc=paymentTerm","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#customerDebitNote_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=customerDebitNote&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
    }); //EOF Ready
    
    function customerDebitNoteTransactionDateOnChange(){
        if($("#customerDebitNoteUpdateMode").val()!=="true"){
            $("#customerDebitNoteTransactionDate").val(dtpCustomerDebitNoteTransactionDate.val());
        }
         var contraBon = formatDate($("#customerDebitNote\\.transactionDate").val(),false);
        var paymentTermDays = $("#customerDebitNote\\.paymentTerm\\.days").val();
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
        
        $("#customerDebitNote\\.dueDate").val(someFormattedDate);
    }
    
    function formatDateCDN(){
        var transactionDate=dtpCustomerDebitNoteTransactionDate.val();
        var transactionDateValuesTemp= transactionDate.split(' ');
        var transactionDateValues= transactionDateValuesTemp[0].split('/');
        var transactionDateValue =transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2]+" "+transactionDateValuesTemp[1];
        dtpCustomerDebitNoteTransactionDate.val(transactionDateValue);
        $("#customerDebitNoteTemp\\.transactionDateTemp").val(dtpCustomerDebitNoteTransactionDate.val());
        
//        var taxInvoiceDate=dtpCustomerDebitNoteTaxInvoiceDate.val();
//        var taxInvoiceDateTemp= taxInvoiceDate.split(' ');
//        var taxInvoiceDateValues= taxInvoiceDateTemp[0].split('/');
//        var taxInvoiceDateValue =taxInvoiceDateValues[1]+"/"+taxInvoiceDateValues[0]+"/"+taxInvoiceDateValues[2]+" "+taxInvoiceDateTemp[1];
//        dtpCustomerDebitNoteTaxInvoiceDate.val(taxInvoiceDateValue);   
//        $("#customerDebitNoteTemp\\.taxInvoiceDateTemp").val(taxInvoiceDateValue);

        var createdDate=$("#customerDebitNote\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpCustomerDebitNoteCreatedDate.val(createdDateValue);
        $("#customerDebitNoteTemp\\.createdDateTemp").val(createdDateValue);
        
        var dueDate=dtpCustomerDebitNoteDueDate.val();
        var dueDateValuesTemp= dueDate.split(' ');
        var dueDateValues= dueDateValuesTemp[0].split('/');
        var dueDateValue =dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2]+" "+dueDateValuesTemp[1];
        dtpCustomerDebitNoteDueDate.val(dueDateValue);
  //      $("#customerDebitNoteTemp\\.transactionDateTemp").val(dtpCustomerDebitNoteTransactionDate.val());
 
    }

    function unFormatNumericCDN(){
        var exchangeRate =removeCommas(txtCustomerDebitNoteExchangeRate.val());
        txtCustomerDebitNoteExchangeRate.val(exchangeRate);
        var totalTransactionAmount =removeCommas(txtCustomerDebitNoteTotalTransactionAmount.val());
        txtCustomerDebitNoteTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtCustomerDebitNoteDiscountAmount.val());
        txtCustomerDebitNoteDiscountAmount.val(discountAmount);
        var vatPercent =removeCommas(txtCustomerDebitNoteVATPercent.val());
        txtCustomerDebitNoteVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtCustomerDebitNoteVATAmount.val());
        txtCustomerDebitNoteVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtCustomerDebitNoteGrandTotalAmount.val());
        txtCustomerDebitNoteGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericCDN(){
        var exchangeRate =parseFloat(txtCustomerDebitNoteExchangeRate.val());
        txtCustomerDebitNoteExchangeRate.val(formatNumber(exchangeRate,2));
        var totalTransactionAmount =parseFloat(txtCustomerDebitNoteTotalTransactionAmount.val());
        txtCustomerDebitNoteTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtCustomerDebitNoteDiscountPercent.val());
        txtCustomerDebitNoteDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtCustomerDebitNoteDiscountAmount.val());
        txtCustomerDebitNoteDiscountAmount.val(formatNumber(discountAmount,2));
        var vatPercent =parseFloat(txtCustomerDebitNoteVATPercent.val());
        txtCustomerDebitNoteVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtCustomerDebitNoteVATAmount.val());
        txtCustomerDebitNoteVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtCustomerDebitNoteGrandTotalAmount.val());
        txtCustomerDebitNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    
    function calculateCustomerDebitNoteDetail() {
        var selectedRowID = $("#customerDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerDebitNoteDetaillastRowId;
        }
        var qty = $("#" + selectedRowID + "_customerDebitNoteDetailQuantity").val();
        var amount = $("#" + selectedRowID + "_customerDebitNoteDetailPrice").val();
        
        var subAmount = (parseFloat(qty) * parseFloat(amount));

        var subTotalAmount=parseFloat(subAmount);

        $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID, "customerDebitNoteDetailTotal", subTotalAmount);

        calculateCustomerDebitNoteHeader();
    }
        
    function calculateCustomerDebitNoteHeader() {
        var totalTransaction =0;
        var discPercent=0;
        var discAmount=0;
        var subTotal=0;
        var vatPercent=0;
        var vatAmount=0;
        var grandTotal=0;

        var ids = jQuery("#customerDebitNoteDetailInput_grid").jqGrid('getDataIDs');
            
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerDebitNoteDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.customerDebitNoteDetailTotal);
        }
        
        if(txtCustomerDebitNoteDiscountPercent.val()===""){
            discPercent=0;
        }
        if(txtCustomerDebitNoteVATPercent.val()===""){
            vatPercent=0;
        }

        txtCustomerDebitNoteTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        var totalTransactionAmount =parseFloat(removeCommas(txtCustomerDebitNoteTotalTransactionAmount.val()));
        
        discPercent=parseFloat(removeCommas(txtCustomerDebitNoteDiscountPercent.val()));
        
        discAmount= (totalTransactionAmount * discPercent)/100; 
        
        if(txtCustomerDebitNoteDiscountAmount.val()===""){
            discAmount=0;
        }
        
        subTotal = (totalTransaction-discAmount);
        
        if(txtCustomerDebitNoteVATPercent.val()===""){            
            vatPercent=0;
        }
        
        vatPercent=parseFloat(removeCommas(txtCustomerDebitNoteVATPercent.val()));
        
        vatAmount = (subTotal * vatPercent)/100;
        
        grandTotal =(subTotal + vatAmount);
        
        txtCustomerDebitNoteDiscountAmount.val(formatNumber(discAmount,2));
        txtCustomerDebitNoteSubTotalAmount.val(formatNumber(subTotal,2));
        txtCustomerDebitNoteVATAmount.val(formatNumber(vatAmount,2));        
        txtCustomerDebitNoteGrandTotalAmount.val(formatNumber(grandTotal,2));

    }
    
    function onChangeChartOfAccountCDN(){
        var selectedRowID = $("#customerDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var chartOfAccountCode = $("#" + selectedRowID + "_customerDebitNoteDetailChartOfAccountCode").val();

        var url = "master/chart-of-account-get";
        var params = "chartOfAccount.code=" + chartOfAccountCode;
            params+= "&chartOfAccount.activeStatus=TRUE";

        if(chartOfAccountCode.trim()===""){
            $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"_customerDebitNoteDetailChartOfAccountName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_customerDebitNoteDetailChartOfAccountCode").val(data.chartOfAccountTemp.code);
                $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerDebitNoteDetailChartOfAccountName",data.chartOfAccountTemp.name);
            }
            else{
                alertMessage("Chart Of Account Not Found!",$("#" + selectedRowID + "_customerDebitNoteDetailChartOfAccountSearch"));
                 $("#" + selectedRowID + "_customerDebitNoteDetailChartOfAccountCode").val("");
                $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerDebitNoteDetailChartOfAccountName"," ");
            }
        });
    }
    
    function onChangeUnitOfMeasureCDN(){
        var selectedRowID = $("#customerDebitNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var unitOfMeasureCode = $("#" + selectedRowID + "_customerDebitNoteDetailUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + unitOfMeasureCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";

        if(unitOfMeasureCode.trim()===""){
            $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"_customerDebitNoteDetailUnitOfMeasureName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_customerDebitNoteDetailUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
                $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerDebitNoteDetailUnitOfMeasureName",data.unitOfMeasureTemp.name);
            }
            else{
                alertMessage("Unit Of Measure Not Found!",$("#" + selectedRowID + "_customerDebitNoteDetailUnitOfMeasureSearch"));
                 $("#" + selectedRowID + "_customerDebitNoteDetailUnitOfMeasureCode").val("");
                $("#customerDebitNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerDebitNoteDetailUnitOfMeasureName"," ");
            }
        });
    }
    
    function customerDebitNoteDetailInputGrid_SearchChartOfAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerDebitNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function customerDebitNoteDetailInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=customerDebitNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }

    function customerDebitNoteDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerDebitNoteDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerDebitNoteDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        calculateCustomerDebitNoteHeader();
        
    }
    
    function customerDebitNoteLoadDataDetail() {
        var url = "sales/customer-debit-note-detail-data";
        var params = "customerDebitNote.code=" + txtCustomerDebitNoteCode.val();
            $.getJSON(url, params, function(data) {
                customerDebitNoteDetaillastRowId = 0;
                for (var i=0; i<data.listCustomerDebitNoteDetailTemp.length; i++) {
                    customerDebitNoteDetaillastRowId++;
                    $("#customerDebitNoteDetailInput_grid").jqGrid("addRowData", customerDebitNoteDetaillastRowId, data.listCustomerDebitNoteDetailTemp[i]);
                    $("#customerDebitNoteDetailInput_grid").jqGrid('setRowData',customerDebitNoteDetaillastRowId,{
                        customerDebitNoteDetailDelete              : "delete",
                        customerDebitNoteDetailChartOfAccountSearch    : "...",
                        customerDebitNoteDetailUnitOfMeasureSearch    : "...",
                        customerDebitNoteDetailQuantity            : data.listCustomerDebitNoteDetailTemp[i].quantity,
                        customerDebitNoteDetailChartOfAccountCode  : data.listCustomerDebitNoteDetailTemp[i].chartOfAccountCode,
                        customerDebitNoteDetailChartOfAccountName  : data.listCustomerDebitNoteDetailTemp[i].chartOfAccountName,
                        customerDebitNoteDetailUnitOfMeasureCode   : data.listCustomerDebitNoteDetailTemp[i].unitOfMeasureCode,
                        customerDebitNoteDetailBranchCode          : data.listCustomerDebitNoteDetailTemp[i].branchCode,
                        customerDebitNoteDetailPrice               : data.listCustomerDebitNoteDetailTemp[i].price,
                        customerDebitNoteDetailRemark              : data.listCustomerDebitNoteDetailTemp[i].remark,
                        customerDebitNoteDetailTotal               : ((data.listCustomerDebitNoteDetailTemp[i].quantity * data.listCustomerDebitNoteDetailTemp[i].price))
                    });
                }
                calculateCustomerDebitNoteHeader();
            });
    }
    
       
    function customerDebitNoteLoadExchangeRate(){
        if($("#customerDebitNoteUpdateMode").val()==="false"){
            if(txtCustomerDebitNoteCurrencyCode.val()==="IDR"){
                txtCustomerDebitNoteExchangeRate.val("1.00");
                txtCustomerDebitNoteExchangeRate.attr('readonly',true);
            }else{
                txtCustomerDebitNoteExchangeRate.val("0.00");
                txtCustomerDebitNoteExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtCustomerDebitNoteCurrencyCode.val()==="IDR"){
                txtCustomerDebitNoteExchangeRate.val("1.00");
                txtCustomerDebitNoteExchangeRate.attr('readonly',true);
            }else{
                txtCustomerDebitNoteExchangeRate.attr('readonly',false);
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
                    txtCustomerDebitNoteCurrencyCode.val(data.currencyTemp.code);
                    txtCustomerDebitNoteCurrencyName.val(data.currencyTemp.name);
                    customerDebitNoteLoadExchangeRate();
                }
                else{
                    alertMessage("Currency Not Found!",txtCustomerDebitNoteCurrencyCode);
                    txtCustomerDebitNoteCurrencyCode.val("");
                    txtCustomerDebitNoteCurrencyName.val("");
                    txtCustomerDebitNoteExchangeRate.val("0.00");
                    txtCustomerDebitNoteExchangeRate.attr("readonly",true);
                }
            });
    }
    function handlers_input_customer_debit_note(){
                        
        if(txtCustomerDebitNoteBranchCode.val()===""){
            handlersInput(txtCustomerDebitNoteBranchCode);
        }else{
            unHandlersInput(txtCustomerDebitNoteBranchCode);
        }
        
        if(dtpCustomerDebitNoteTransactionDate.val()===""){
            handlersInput(dtpCustomerDebitNoteTransactionDate);
        }else{
            unHandlersInput(dtpCustomerDebitNoteTransactionDate);
        }
        
        if(txtCustomerDebitNoteCurrencyCode.val()===""){
            handlersInput(txtCustomerDebitNoteCurrencyCode);
        }else{
            unHandlersInput(txtCustomerDebitNoteCurrencyCode);
        }
        
//        if(txtCustomerDebitNoteDiscountAccountCode.val()===""){
//            handlersInput(txtCustomerDebitNoteDiscountAccountCode);
//        }else{
//            unHandlersInput(txtCustomerDebitNoteDiscountAccountCode);
//        }
        
        if(parseFloat(removeCommas(txtCustomerDebitNoteExchangeRate.val()))>0){
            unHandlersInput(txtCustomerDebitNoteExchangeRate);
        }else{
            handlersInput(txtCustomerDebitNoteExchangeRate);
        }
        
        if(txtCustomerDebitNoteCustomerCode.val()===""){
            handlersInput(txtCustomerDebitNoteCustomerCode);
        }else{
            unHandlersInput(txtCustomerDebitNoteCustomerCode);
        }
         if(txtCustomerDebitNotePaymentTermCode.val()===""){
            handlersInput(txtCustomerDebitNotePaymentTermCode);
        }else{
            unHandlersInput(txtCustomerDebitNotePaymentTermCode);
        }               
    }
               
</script>

<s:url id="remoteurlCustomerDebitNoteDetailInput" action="" />
<b>CUSTOMER DEBIT NOTE</b>
<hr>
<br class="spacer" />

<div id="customerDebitNoteInput" class="content ui-widget">
    <s:form id="frmCustomerDebitNoteInput">
        <table cellpadding="2" cellspacing="2" id="headerCustomerDebitNoteInput">
            <tr>
                <td align="right"><B>CDN No *</B></td>
                <td>
                    <s:textfield id="customerDebitNote.code" name="customerDebitNote.code" key="customerDebitNote.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="customerDebitNoteUpdateMode" name="customerDebitNoteUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="customerDebitNote.transactionDate" name="customerDebitNote.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" onchange="customerDebitNoteTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="customerDebitNoteTransactionDate" name="customerDebitNoteTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="customerDebitNoteTemp.transactionDateTemp" name="customerDebitNoteTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
           
                </td>
            </tr>
            <tr>
                <td align="right"><B>Payment Term *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtCustomerDebitNotePaymentTermCode.change(function(ev) {
                            if(txtCustomerDebitNotePaymentTermCode.val()===""){
                                txtCustomerDebitNotePaymentTermName.val("");
                                txtCustomerDebitNotePaymentTermDays.val("0");
                                return;
                            }
                            var url = "master/payment-term-get";
                            var params = "paymentTerm.code=" + txtCustomerDebitNotePaymentTermCode.val();
                                params+= "&paymentTerm.activeStatus=TRUE";
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.paymentTermTemp){
                                    txtCustomerDebitNotePaymentTermCode.val(data.paymentTermTemp.code);
                                    txtCustomerDebitNotePaymentTermName.val(data.paymentTermTemp.name);
                                    txtCustomerDebitNotePaymentTermDays.val(data.paymentTermTemp.days);
                                }
                                else{
                                    alertMessage("Payment Term Not Found!",txtCustomerDebitNotePaymentTermCode);
                                    txtCustomerDebitNotePaymentTermCode.val("");
                                    txtCustomerDebitNotePaymentTermName.val("");
                                    txtCustomerDebitNotePaymentTermDays.val("0");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="customerDebitNote.paymentTerm.code" name="customerDebitNote.paymentTerm.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="customerDebitNote_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="customerDebitNote.paymentTerm.name" name="customerDebitNote.paymentTerm.name" size="40" readonly="true"></s:textfield>
                    <s:textfield id="customerDebitNote.paymentTerm.days" name="customerDebitNote.paymentTerm.days" size="20" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Due Date</B></td>
                <td><sj:datepicker id="customerDebitNote.dueDate" name="customerDebitNote.dueDate" readonly="true" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="false" timepickerFormat="hh:mm:ss"></sj:datepicker></td>
            </tr>
            <tr>
                <td align="right" style="width:120px"><B>Branch *</B></td>
                <td colspan="2">
                <script type = "text/javascript">

                    txtCustomerDebitNoteBranchCode.change(function(ev) {

                        if(txtCustomerDebitNoteBranchCode.val()===""){
                            txtCustomerDebitNoteBranchName.val("");
                            return;
                        }
                        var url = "master/branch-get";
                        var params = "branch.code=" + txtCustomerDebitNoteBranchCode.val();
                            params += "&branch.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.branchTemp){
                                txtCustomerDebitNoteBranchCode.val(data.branchTemp.code);
                                txtCustomerDebitNoteBranchName.val(data.branchTemp.name);
                            }
                            else{
                                alertMessage("Branch Not Found!",txtCustomerDebitNoteBranchCode);
                                txtCustomerDebitNoteBranchCode.val("");
                                txtCustomerDebitNoteBranchName.val("");
                            }
                        });
                    });
                    if($("#customerDebitNoteUpdateMode").val()==="true"){
                        txtCustomerDebitNoteBranchCode.attr("readonly",true);
                        $("#customerDebitNote_btnBranch").hide();
                        $("#ui-icon-search-branch-sales-order").hide();
                    }else{
                        txtCustomerDebitNoteBranchCode.attr("readonly",false);
                        $("#customerDebitNote_btnBranch").show();
                        $("#ui-icon-search-branch-sales-order").show();
                    }
                </script>
                <div class="searchbox ui-widget-header" hidden="true">
                    <s:textfield id="customerDebitNote.branch.code" name="customerDebitNote.branch.code" size="22"></s:textfield>
                    <sj:a id="customerDebitNote_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                </div>
                    <s:textfield id="customerDebitNote.branch.name" name="customerDebitNote.branch.name" size="40" readonly="true" required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            
            
            <tr>
                <td align="right"><B>Currency *</B></td>
                <td colspan="3">
                    <script type = "text/javascript">

                        txtCustomerDebitNoteCurrencyCode.change(function(ev) {

                            if(txtCustomerDebitNoteCurrencyCode.val()===""){
                                txtCustomerDebitNoteCurrencyName.val("");
                                txtCustomerDebitNoteExchangeRate.val("0.00");
                                txtCustomerDebitNoteExchangeRate.attr('readonly',true);
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtCustomerDebitNoteCurrencyCode.val();
                                params+= "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtCustomerDebitNoteCurrencyCode.val(data.currencyTemp.code);
                                    txtCustomerDebitNoteCurrencyName.val(data.currencyTemp.name);
                                    customerDebitNoteLoadExchangeRate();
                                }
                                else{
                                    alertMessage("Currency Not Found",txtCustomerDebitNoteCurrencyCode);
                                    txtCustomerDebitNoteCurrencyCode.val("");
                                    txtCustomerDebitNoteCurrencyName.val("");
                                    txtCustomerDebitNoteExchangeRate.val("0.00");
                                    txtCustomerDebitNoteExchangeRate.attr("readonly",true);
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="customerDebitNote.currency.code" name="customerDebitNote.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="customerDebitNote_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="customerDebitNote.currency.name" name="customerDebitNote.currency.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Exchange Rate *</B></td>
                <td>
                    <s:textfield id="customerDebitNote.exchangeRate" name="customerDebitNote.exchangeRate" size="22" cssStyle="text-align:right"></s:textfield>&nbsp;<span id="errmsgExchangeRate"></span>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Customer *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtCustomerDebitNoteCustomerCode.change(function(ev) {
                            if(txtCustomerDebitNoteCustomerCode.val()===""){
                                txtCustomerDebitNoteCustomerName.val("");
                                return;
                            }
                            var url = "master/customer-get";
                            var params = "customer.code=" + txtCustomerDebitNoteCustomerCode.val();
                                params+= "&customer.activeStatus=TRUE";
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.customerTemp){
                                    txtCustomerDebitNoteCustomerCode.val(data.customerTemp.code);
                                    txtCustomerDebitNoteCustomerName.val(data.customerTemp.name);
                                }
                                else{
                                    alertMessage("Customer Not Found!",txtCustomerDebitNoteCustomerCode);
                                    txtCustomerDebitNoteCustomerCode.val("");
                                    txtCustomerDebitNoteCustomerName.val("");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="customerDebitNote.customer.code" name="customerDebitNote.customer.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="customerDebitNote_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="customerDebitNote.customer.name" name="customerDebitNote.customer.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            
<!--            <tr>
                <td align="right">Tax Invoice No</td>
                <td><s:textfield id="customerDebitNote.taxInvoiceNo" name="customerDebitNote.taxInvoiceNo" size="25"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Tax Invoice Date</td>
                <td>
                    <sj:datepicker id="customerDebitNote.taxInvoiceDate" name="customerDebitNote.taxInvoiceDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                </td>
            </tr>-->
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="customerDebitNote.refNo" name="customerDebitNote.refNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Description</td>
                <td colspan="3"><s:textarea id="customerDebitNote.remark" name="customerDebitNote.remark"  cols="70" rows="2" height="20"></s:textarea></td>
            </tr> 
            <tr hidden="true">
                <td>
                    <s:textfield id="customerDebitNote.createdBy" name="customerDebitNote.createdBy" key="customerDebitNote.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="customerDebitNote.createdDate" name="customerDebitNote.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="customerDebitNoteTemp.createdDateTemp" name="customerDebitNoteTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmCustomerDebitNote" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerDebitNote" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="customerDebitNoteDetailInputGrid">
            <sjg:grid
                id="customerDebitNoteDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerDebitNoteTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuCustomerDebitNoteDetail').width()"
                editurl="%{remoteurlCustomerDebitNoteDetailInput}"
                onSelectRowTopics="customerDebitNoteDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="customerDebitNoteDetail" index="customerDebitNoteDetail" key="customerDebitNoteDetail" 
                    title="" width="150" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailDelete" index="customerDebitNoteDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'customerDebitNoteDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                
                <sjg:gridColumn
                    name="customerDebitNoteDetailBranchCode" index="customerDebitNoteDetailBranchCode" key="customerDebitNoteDetailBranchCode" 
                    title="Branch" width="80" sortable="true"
                />
                
                <sjg:gridColumn
                    name="customerDebitNoteDetailChartOfAccountSearch" index="customerDebitNoteDetailChartOfAccountSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'customerDebitNoteDetailInputGrid_SearchChartOfAccount_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailChartOfAccountCode" index="customerDebitNoteDetailChartOfAccountCode" 
                    title="Chart Of Account No" width="200" sortable="true" editable="true" edittype="text" 
                    editoptions="{onChange:'onChangeChartOfAccountCDN()'}"
                />     
                <sjg:gridColumn
                    name="customerDebitNoteDetailChartOfAccountName" index="customerDebitNoteDetailChartOfAccountName" title="Chart Of Account Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailRemark" index="customerDebitNoteDetailRemark" key="customerDebitNoteDetailRemark" 
                    title="Remark" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailQuantity" index="customerDebitNoteDetailQuantity" key="customerDebitNoteDetailQuantity" title="Quantity" 
                    width="80" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }"
                    editoptions="{onKeyUp:'calculateCustomerDebitNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailUnitOfMeasureSearch" index="customerDebitNoteDetailUnitOfMeasureSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'customerDebitNoteDetailInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailUnitOfMeasureCode" index="customerDebitNoteDetailUnitOfMeasureCode" 
                    title="Unit" width="80" sortable="true" editable="true" edittype="text" 
                    editoptions="{onChange:'onChangeUnitOfMeasureCDN()'}"
                />     
                <sjg:gridColumn
                    name="customerDebitNoteDetailPrice" index="customerDebitNoteDetailPrice" key="customerDebitNoteDetailPrice" title="Price" 
                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                    formatter="number" editrules="{ double: true }"
                    editoptions="{onKeyUp:'calculateCustomerDebitNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="customerDebitNoteDetailTotal" index="customerDebitNoteDetailTotal" key="customerDebitNoteDetailTotal" title="Total" 
                    width="150" align="right" editable="false" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
            </sjg:grid >
        </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                        <tr>
                            <td>
                                <s:textfield id="customerDebitNoteDetailAddRow" name="customerDebitNoteDetailAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                <sj:a href="#" id="btnCustomerDebitNoteAddDetail" button="true"  style="width: 60px">Add</sj:a>&nbsp;<span id="errmsgAddRow"></span>
                            </td>
                        </tr>
                        <tr height="10px"/>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnCustomerDebitNoteSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnCustomerDebitNoteCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td width="150px" align="right"><B>Total Transaction</B></td>
                            <td width="150px">
                                <s:textfield id="customerDebitNote.totalTransactionAmount" name="customerDebitNote.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                            <td/><td/>
                        </tr>
                        <tr>
                            <td align="right"><B>Disc</B>
                                <s:textfield id="customerDebitNote.discountPercent" name="customerDebitNote.discountPercent" onkeyup="calculateCustomerDebitNoteHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                            <td>
                                <s:textfield id="customerDebitNote.discountAmount" name="customerDebitNote.discountAmount" readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right" style="width:120px">Discount Account </td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtCustomerDebitNoteDiscountAccountCode.change(function(ev) {

                                    if(txtCustomerDebitNoteDiscountAccountCode.val()===""){
                                        txtCustomerDebitNoteDiscountAccountName.val("");
                                        return;
                                    }
                                    var url = "master/chart-of-account-get";
                                    var params = "chartOfAccount.code=" + txtCustomerDebitNoteDiscountAccountCode.val();
                                        params += "&chartOfAccount.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.chartOfAccountTemp){
                                            txtCustomerDebitNoteDiscountAccountCode.val(data.chartOfAccountTemp.code);
                                            txtCustomerDebitNoteDiscountAccountName.val(data.chartOfAccountTemp.name);
                                        }
                                        else{
                                            alertMessage("Chart Of Account Not Found!",txtCustomerDebitNoteDiscountAccountCode);
                                            txtCustomerDebitNoteDiscountAccountCode.val("");
                                            txtCustomerDebitNoteDiscountAccountName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerDebitNote.discountAccount.code" name="customerDebitNote.discountAccount.code" size="22"></s:textfield>
                                <sj:a id="customerDebitNote_btnChartOfAccount" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerDebitNote.discountAccount.name" name="customerDebitNote.discountAccount.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right">Sub Total (Tax Base)</td>
                            <td>
                                <s:textfield id="customerDebitNoteSubTotalAmount" name="customerDebitNoteSubTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                            <td/><td/>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                                <s:textfield id="customerDebitNote.vatPercent" name="customerDebitNote.vatPercent" onkeyup="calculateCustomerDebitNoteHeader()" size="5" cssStyle="text-align:right"></s:textfield>%
                            </td>
                            <td>
                                <s:textfield id="customerDebitNote.vatAmount" name="customerDebitNote.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                            <td/><td/>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="customerDebitNote.grandTotalAmount" name="customerDebitNote.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                            <td/><td/>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    