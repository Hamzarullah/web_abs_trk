
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #customerCreditNoteDetailInput_grid_pager_center,.ui-dialog-titlebar-close{
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
    
    var customerCreditNoteDetaillastRowId=0,customerCreditNoteDetail_lastSel = -1;
    var 
        txtCustomerCreditNoteCode = $("#customerCreditNote\\.code"),
        txtCustomerCreditNoteBranchCode = $("#customerCreditNote\\.branch\\.code"),
        txtCustomerCreditNoteBranchName = $("#customerCreditNote\\.branch\\.name"),
        dtpCustomerCreditNoteTransactionDate = $("#customerCreditNote\\.transactionDate"),
        dtpCustomerCreditNoteDueDate = $("#customerCreditNote\\.dueDate"),
        txtCustomerCreditNoteCurrencyCode= $("#customerCreditNote\\.currency\\.code"),
        txtCustomerCreditNoteCurrencyName= $("#customerCreditNote\\.currency\\.name"),
        txtCustomerCreditNoteDiscountAccountCode= $("#customerCreditNote\\.discountAccount\\.code"),
        txtCustomerCreditNoteDiscountAccountName= $("#customerCreditNote\\.discountAccount\\.name"),
        txtCustomerCreditNoteExchangeRate = $("#customerCreditNote\\.exchangeRate"),
        txtCustomerCreditNoteCustomerCode= $("#customerCreditNote\\.customer\\.code"),
        txtCustomerCreditNoteCustomerName= $("#customerCreditNote\\.customer\\.name"),
    
        txtCustomerCreditNoteRefNo = $("#customerCreditNote\\.refNo"),
        txtCustomerCreditNoteRemark = $("#customerCreditNote\\.remark"),
        txtCustomerCreditNoteCreatedBy = $("#customerCreditNote\\.createdBy"),
        dtpCustomerCreditNoteCreatedDate = $("#customerCreditNote\\.createdDate"),
        
        txtCustomerCreditNoteTotalTransactionAmount = $("#customerCreditNote\\.totalTransactionAmount"),
        txtCustomerCreditNoteDiscountPercent = $("#customerCreditNote\\.discountPercent"),
        txtCustomerCreditNoteDiscountAmount = $("#customerCreditNote\\.discountAmount"),
        txtCustomerCreditNoteSubTotalAmount= $("#customerCreditNoteSubTotalAmount"),
        txtCustomerCreditNoteVATPercent = $("#customerCreditNote\\.vatPercent"),
        txtCustomerCreditNoteVATAmount = $("#customerCreditNote\\.vatAmount"),
        txtCustomerCreditNoteGrandTotalAmount = $("#customerCreditNote\\.grandTotalAmount"),
        txtCustomerCreditNotePaymentTermCode = $("#customerCreditNote\\.paymentTerm\\.code"),
        txtCustomerCreditNotePaymentTermName = $("#customerCreditNote\\.paymentTerm\\.name"),
        txtCustomerCreditNotePaymentTermDays = $("#customerCreditNote\\.paymentTerm\\.days"),
                
        allFieldsCustomerCreditNote = $([])
            .add(txtCustomerCreditNotePaymentTermCode)
            .add(txtCustomerCreditNotePaymentTermName)
            .add(txtCustomerCreditNotePaymentTermDays)
            .add(txtCustomerCreditNoteCode)
            .add(txtCustomerCreditNoteCustomerCode)
            .add(txtCustomerCreditNoteCustomerName)
        //    .add(txtCustomerCreditNoteTaxInvoiceNo)
            .add(txtCustomerCreditNoteRefNo)
            .add(txtCustomerCreditNoteRemark)
            .add(txtCustomerCreditNoteTotalTransactionAmount)
            .add(txtCustomerCreditNoteVATPercent)
            .add(txtCustomerCreditNoteVATAmount)
            .add(txtCustomerCreditNoteGrandTotalAmount);


    $(document).ready(function() {
        
        flagIsConfirmedCCN=false;
        customerCreditNoteLoadExchangeRate();
        formatNumericCCN();
        if($("#customerCreditNoteUpdateMode").val()==="false"){
            setCurrency();
        }
        $("#customerCreditNoteDetailAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerCreditNoteDetailAddRow").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
           
        });
        
        $("#customerCreditNote\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerCreditNote\\.exchangeRate").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
           
        });
        
        $("#customerCreditNote\\.exchangeRate").change(function(e){
            var exrate=$("#customerCreditNote\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#customerCreditNote\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerCreditNote\\.discountPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });
        
        $("#customerCreditNote\\.discountPercent").change(function(e){
            var amount=$("#customerCreditNote\\.discountPercent").val();
            if(amount===""){
               $("#customerCreditNote\\.discountPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $("#customerCreditNote\\.discountAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               return false;
           }
        });

        $("#customerCreditNote\\.discountAmount").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
        });
        
        $("#customerCreditNote\\.discountAmount").change(function(e){
            var amount=$("#customerCreditNote\\.discountAmount").val();
            if(amount===""){
               $("#customerCreditNote\\.discountAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#customerCreditNote\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#customerCreditNote\\.vatPercent").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
        });
        
        $("#customerCreditNote\\.vatPercent").change(function(e){
            var amount=$("#customerCreditNote\\.vatPercent").val();
            if(amount===""){
               $("#customerCreditNote\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#btnUnConfirmCustomerCreditNote").css("display", "none");
        $('#customerCreditNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmCustomerCreditNote").click(function(ev) {
            handlers_input_customer_credit_note();
            customerCreditNoteTransactionDateOnChange();
            if(txtCustomerCreditNoteBranchCode.val()===''){
                alertMessage("Branch Cant be Empty");
                return;
            }
            if(txtCustomerCreditNoteCurrencyCode.val()===''){
                alertMessage("Currency Cant be Empty");
                return;
            }
            if(txtCustomerCreditNoteCustomerCode.val()===''){
                alertMessage("Customer Cant be Empty");
                return;
            }
            if(txtCustomerCreditNotePaymentTermCode.val()===''){
                alertMessage("Payment Term Cant be Empty");
                return;
            }
             if(parseFloat(txtCustomerCreditNoteExchangeRate.val())<=1 && txtCustomerCreditNoteCurrencyCode.val()!=="IDR"){
           
                txtCustomerCreditNoteExchangeRate.attr("style","color:red");
                alertMessageNotif("Exchange Rate : "+txtCustomerCreditNoteCurrencyCode.val()+" must greater than 1.00");
                return;
            }
            else{
                 txtCustomerCreditNoteExchangeRate.attr("style","color:black");
            }
            var date1 = dtpCustomerCreditNoteTransactionDate.val().split("/");
            var month1 = date1[1];
            var year1 = date1[2].split(" ");
            var date2 = $("#customerCreditNoteTransactionDate").val().split("/");
            var month2 = date2[1];
            var year2 = date2[2].split(" ");
            
            
            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
                if($("#customerCreditNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#customerCreditNoteTransactionDate").val(),dtpCustomerCreditNoteTransactionDate);
                }else{
                    alertMessage("Transaction Month Must Between Session Period Month!",dtpCustomerCreditNoteTransactionDate);
                }
                return;
            }

            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
                if($("#customerCreditNoteUpdateMode").val()==="true"){
                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#customerCreditNoteTransactionDate").val(),dtpCustomerCreditNoteTransactionDate);
                }else{
                    alertMessage("Transaction Year Must Between Session Period Year!",dtpCustomerCreditNoteTransactionDate);
                }
                return;
            }

            if($("#customerCreditNoteUpdateMode").val()==="true"){
                customerCreditNoteLoadDataDetail();
            }
            
            flagIsConfirmedCCN=true;
            $("#btnUnConfirmCustomerCreditNote").css("display", "block");
            $("#btnConfirmCustomerCreditNote").css("display", "none");   
            $('#headerCustomerCreditNoteInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#customerCreditNoteDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmCustomerCreditNote").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#customerCreditNoteDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    $("#btnUnConfirmCustomerCreditNote").css("display", "none");
                    $("#btnConfirmCustomerCreditNote").css("display", "block");
                    $('#headerCustomerCreditNoteInput').unblock();
                    $('#customerCreditNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                                $("#customerCreditNoteDetailInput_grid").jqGrid('clearGridData');
                                $("#btnUnConfirmCustomerCreditNote").css("display", "none");
                                $("#btnConfirmCustomerCreditNote").css("display", "block");
                                $('#headerCustomerCreditNoteInput').unblock();
                                $('#customerCreditNoteDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $.subscribe("customerCreditNoteDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==customerCreditNoteDetail_lastSel) {

                $('#customerCreditNoteDetailInput_grid').jqGrid("saveRow",customerCreditNoteDetail_lastSel); 
                $('#customerCreditNoteDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerCreditNoteDetail_lastSel=selectedRowID;

            }
            else{
                $('#customerCreditNoteDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });


        $('#btnCustomerCreditNoteAddDetail').click(function(ev) {
            
            if(!flagIsConfirmedCCN){
                alertMessage("Please Confirm!",$("#btnConfirmCustomerCreditNote"));
                return;
            }
            
            var AddRowCount =parseFloat(removeCommas($("#customerCreditNoteDetailAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {
                    customerCreditNoteDetailBranchCode : txtCustomerCreditNoteBranchCode.val()
                };
                customerCreditNoteDetaillastRowId++;
                $("#customerCreditNoteDetailInput_grid").jqGrid("addRowData", customerCreditNoteDetaillastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#customerCreditNoteDetailInput_grid").jqGrid('setRowData',customerCreditNoteDetaillastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnCustomerCreditNoteSave').click(function(ev) {
            
            if(!flagIsConfirmedCCN){
                alertMessage("Please Confirm!",$("#btnConfirmCustomerCreditNote"));
                return;
            }
            
            if(customerCreditNoteDetail_lastSel !== -1) {
                $('#customerCreditNoteDetailInput_grid').jqGrid("saveRow",customerCreditNoteDetail_lastSel); 
            }

           
            var listCustomerCreditNoteDetail = new Array(); 
            var ids = jQuery("#customerCreditNoteDetailInput_grid").jqGrid('getDataIDs'); 

            if(ids.length===0){
                alertMessage("Grid Detail Can't Empty!");
                return;
            }


            for(var i=0;i < ids.length;i++){ 
                var data = $("#customerCreditNoteDetailInput_grid").jqGrid('getRowData',ids[i]); 

                if(data.customerCreditNoteDetailChartOfAccountCode===""){
                    alertMessage("Chart Of Account Can't Empty!");
                    return;
                }
                
                if(data.customerCreditNoteDetailUnitOfMeasureCode===""){
                    alertMessage("Unit Of Measure Can't Empty!");
                    return;
                }
                
                var customerCreditNoteDetail = { 
                    remark              : data.customerCreditNoteDetailRemark,
                    chartOfAccount      : {code:data.customerCreditNoteDetailChartOfAccountCode},
                    unitOfMeasure       : {code:data.customerCreditNoteDetailUnitOfMeasureCode},
                    branch              : {code:data.customerCreditNoteDetailBranchCode},
                    quantity            : data.customerCreditNoteDetailQuantity,
                    price               : data.customerCreditNoteDetailPrice,
                    totalAmount         : data.customerCreditNoteDetailTotal
                };
                listCustomerCreditNoteDetail[i] = customerCreditNoteDetail;
            }
            
            if(parseFloat(txtCustomerCreditNoteTotalTransactionAmount.val())===0.00){
                alertMessage("Can't be 0 value for Total Transaction!");
                return;
            }
            
            if(txtCustomerCreditNoteDiscountPercent.val()!=0 && txtCustomerCreditNoteDiscountAccountCode.val()===""){
                alertMessage("Discount Account Cant be Empty");
                return;
            }
            
            unHandlersInput(txtCustomerCreditNoteDiscountPercent);
            
            formatDateCCN();
            unFormatNumericCCN();
                        
            var url = "sales/customer-credit-note-save";
            var params = $("#frmCustomerCreditNoteInput").serialize();
                params += "&listCustomerCreditNoteDetailJSON=" + $.toJSON(listCustomerCreditNoteDetail);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateCCN();
                    formatNumericCCN();
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
                                var url = "sales/customer-credit-note-input";
                                pageLoad(url, params, "#tabmnuCUSTOMER_CREDIT_NOTE");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "sales/customer-credit-note";
                                pageLoad(url, params, "#tabmnuCUSTOMER_CREDIT_NOTE");
                            }
                        }]
                    });
            });
            
        });
  
        $('#btnCustomerCreditNoteCancel').click(function(ev) {
            var url = "sales/customer-credit-note";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_CREDIT_NOTE"); 
        });
        
        $('#customerCreditNote_btnBranch').click(function(ev) {
            window.open("./pages/search/search-branch.jsp?iddoc=customerCreditNote&idsubdoc=branch","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerCreditNote_btnChartOfAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerCreditNote&idsubdoc=discountAccount","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#customerCreditNote_btnCustomer').click(function(ev) {
            window.open("./pages/search/search-customer.jsp?iddoc=customerCreditNote&idsubdoc=customer","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#customerCreditNote_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=customerCreditNote&idsubdoc=paymentTerm","Search", "scrollbars=1, width=600, height=500");
        });
        
        $('#customerCreditNote_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=customerCreditNote&idsubdoc=currency","Search", "scrollbars=1, width=600, height=500");
        });
    }); //EOF Ready
    
    function customerCreditNoteTransactionDateOnChange(){
        if($("#customerCreditNoteUpdateMode").val()!=="true"){
            $("#customerCreditNoteTransactionDate").val(dtpCustomerCreditNoteTransactionDate.val());
        }
        
        var contraBon = formatDate($("#customerCreditNote\\.transactionDate").val(),false);
        var paymentTermDays = $("#customerCreditNote\\.paymentTerm\\.days").val();
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
        
        $("#customerCreditNote\\.dueDate").val(someFormattedDate);
    }
        
  
    
    function formatDateCCN(){
        var transactionDate=dtpCustomerCreditNoteTransactionDate.val();
        var transactionDateValuesTemp= transactionDate.split(' ');
        var transactionDateValues= transactionDateValuesTemp[0].split('/');
        var transactionDateValue =transactionDateValues[1]+"/"+transactionDateValues[0]+"/"+transactionDateValues[2]+" "+transactionDateValuesTemp[1];
        dtpCustomerCreditNoteTransactionDate.val(transactionDateValue);
        $("#customerCreditNoteTemp\\.transactionDateTemp").val(dtpCustomerCreditNoteTransactionDate.val());
        
//        var taxInvoiceDate=dtpCustomerCreditNoteTaxInvoiceDate.val();
//        var taxInvoiceDateTemp= taxInvoiceDate.split(' ');
//        var taxInvoiceDateValues= taxInvoiceDateTemp[0].split('/');
//        var taxInvoiceDateValue =taxInvoiceDateValues[1]+"/"+taxInvoiceDateValues[0]+"/"+taxInvoiceDateValues[2]+" "+taxInvoiceDateTemp[1];
//        dtpCustomerCreditNoteTaxInvoiceDate.val(taxInvoiceDateValue);   
//        $("#customerCreditNoteTemp\\.taxInvoiceDateTemp").val(taxInvoiceDateValue);

        var createdDate=$("#customerCreditNote\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var dateValues= createdDateTemp[0].split('/');
        var createdDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+createdDateTemp[1];
        dtpCustomerCreditNoteCreatedDate.val(createdDateValue);
        $("#customerCreditNoteTemp\\.createdDateTemp").val(createdDateValue);
        
        var dueDate=dtpCustomerCreditNoteDueDate.val();
        var dueDateValuesTemp= dueDate.split(' ');
        var dueDateValues= dueDateValuesTemp[0].split('/');
        var dueDateValue =dueDateValues[1]+"/"+dueDateValues[0]+"/"+dueDateValues[2]+" "+dueDateValuesTemp[1];
        dtpCustomerCreditNoteDueDate.val(dueDateValue);
  //      $("#customerCreditNoteTemp\\.transactionDateTemp").val(dtpCustomerCreditNoteTransactionDate.val());
 
    }

    function unFormatNumericCCN(){
        var exchangeRate =removeCommas(txtCustomerCreditNoteExchangeRate.val());
        txtCustomerCreditNoteExchangeRate.val(exchangeRate);
        var totalTransactionAmount =removeCommas(txtCustomerCreditNoteTotalTransactionAmount.val());
        txtCustomerCreditNoteTotalTransactionAmount.val(totalTransactionAmount);
        var discountAmount =removeCommas(txtCustomerCreditNoteDiscountAmount.val());
        txtCustomerCreditNoteDiscountAmount.val(discountAmount);
        var vatPercent =removeCommas(txtCustomerCreditNoteVATPercent.val());
        txtCustomerCreditNoteVATPercent.val(vatPercent);
        var vatAmount =removeCommas(txtCustomerCreditNoteVATAmount.val());
        txtCustomerCreditNoteVATAmount.val(vatAmount);
        var grandTotalAmount =removeCommas(txtCustomerCreditNoteGrandTotalAmount.val());
        txtCustomerCreditNoteGrandTotalAmount.val(grandTotalAmount);
    }
    
    function formatNumericCCN(){
        var exchangeRate =parseFloat(txtCustomerCreditNoteExchangeRate.val());
        txtCustomerCreditNoteExchangeRate.val(formatNumber(exchangeRate,2));
        var totalTransactionAmount =parseFloat(txtCustomerCreditNoteTotalTransactionAmount.val());
        txtCustomerCreditNoteTotalTransactionAmount.val(formatNumber(totalTransactionAmount,2));
        var discountPercent =parseFloat(txtCustomerCreditNoteDiscountPercent.val());
        txtCustomerCreditNoteDiscountPercent.val(formatNumber(discountPercent,2));
        var discountAmount =parseFloat(txtCustomerCreditNoteDiscountAmount.val());
        txtCustomerCreditNoteDiscountAmount.val(formatNumber(discountAmount,2));
        var vatPercent =parseFloat(txtCustomerCreditNoteVATPercent.val());
        txtCustomerCreditNoteVATPercent.val(formatNumber(vatPercent,2));
        var vatAmount =parseFloat(txtCustomerCreditNoteVATAmount.val());
        txtCustomerCreditNoteVATAmount.val(formatNumber(vatAmount,2));
        var grandTotalAmount =parseFloat(txtCustomerCreditNoteGrandTotalAmount.val());
        txtCustomerCreditNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));
    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    
    function calculateCustomerCreditNoteDetail() {
        var selectedRowID = $("#customerCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");

        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = $("#customerCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        }
        if(selectedRowID === "" || selectedRowID === null){
            selectedRowID = customerCreditNoteDetaillastRowId;
        }
        var qty = $("#" + selectedRowID + "_customerCreditNoteDetailQuantity").val();
        var amount = $("#" + selectedRowID + "_customerCreditNoteDetailPrice").val();
       
        var subAmount = (parseFloat(removeCommas(qty)) * parseFloat(removeCommas(amount)));

        var subTotalAmount=parseFloat(subAmount);
        
        $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID, "customerCreditNoteDetailTotal", subTotalAmount);

        calculateCustomerCreditNoteHeader();
    }
        
    function calculateCustomerCreditNoteHeader() {
        
        var totalTransaction = 0;
        var discPercent=removeCommas(txtCustomerCreditNoteDiscountPercent.val());
        var vatPercent=removeCommas(txtCustomerCreditNoteVATPercent.val());
        var ids = jQuery("#customerCreditNoteDetailInput_grid").jqGrid('getDataIDs');
        
        for(var i=0;i < ids.length;i++) {
            var data = $("#customerCreditNoteDetailInput_grid").jqGrid('getRowData',ids[i]);
            totalTransaction += parseFloat(data.customerCreditNoteDetailTotal);
        }
        
        if(txtCustomerCreditNoteDiscountPercent.val()===""){
            discPercent=0;
        }
        if(txtCustomerCreditNoteVATPercent.val()===""){
            vatPercent=0;
        }
        
        var discAmount = (totalTransaction *  parseFloat(discPercent))/100;
        var subTotalAmount = (totalTransaction - parseFloat(discAmount.toFixed(2)));
        var vatAmount = (subTotalAmount * parseFloat(vatPercent))/100;
        var grandTotalAmount =(parseFloat(subTotalAmount) + parseFloat(vatAmount.toFixed(2)));
        
        txtCustomerCreditNoteTotalTransactionAmount.val(formatNumber(totalTransaction, 2));
        txtCustomerCreditNoteDiscountAmount.val(formatNumber(parseFloat(discAmount.toFixed(2)),2));
        
        $("#customerCreditNoteSubTotal").val(formatNumber(subTotalAmount,2));
        txtCustomerCreditNoteVATAmount.val(formatNumber(parseFloat(vatAmount.toFixed(2)),2));        
        txtCustomerCreditNoteGrandTotalAmount.val(formatNumber(grandTotalAmount,2));

    }
    
    function onChangeChartOfAccountCCN(){
        var selectedRowID = $("#customerCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var chartOfAccountCode = $("#" + selectedRowID + "_customerCreditNoteDetailChartOfAccountCode").val();

        var url = "master/chart-of-account-get";
        var params = "chartOfAccount.code=" + chartOfAccountCode;
            params+= "&chartOfAccount.activeStatus=TRUE";

        if(chartOfAccountCode.trim()===""){
            $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"_customerCreditNoteDetailChartOfAccountName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.chartOfAccountTemp){
                $("#" + selectedRowID + "_customerCreditNoteDetailChartOfAccountCode").val(data.chartOfAccountTemp.code);
                $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerCreditNoteDetailChartOfAccountName",data.chartOfAccountTemp.name);
            }
            else{
                alertMessage("Chart Of Account Not Found!",$("#" + selectedRowID + "_customerCreditNoteDetailChartOfAccountSearch"));
                 $("#" + selectedRowID + "_customerCreditNoteDetailChartOfAccountCode").val("");
                $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerCreditNoteDetailChartOfAccountName"," ");
            }
        });
    }
    
    function onChangeUnitOfMeasureCCN(){
        var selectedRowID = $("#customerCreditNoteDetailInput_grid").jqGrid("getGridParam", "selrow");
        var unitOfMeasureCode = $("#" + selectedRowID + "_customerCreditNoteDetailUnitOfMeasureCode").val();

        var url = "master/unit-of-measure-get";
        var params = "unitOfMeasure.code=" + unitOfMeasureCode;
            params+= "&unitOfMeasure.activeStatus=TRUE";

        if(unitOfMeasureCode.trim()===""){
            $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"_customerCreditNoteDetailUnitOfMeasureName"," ");
            return;
        }

        $.post(url, params, function(result) {
            var data = (result);
            if (data.unitOfMeasureTemp){
                $("#" + selectedRowID + "_customerCreditNoteDetailUnitOfMeasureCode").val(data.unitOfMeasureTemp.code);
                $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerCreditNoteDetailUnitOfMeasureName",data.unitOfMeasureTemp.name);
            }
            else{
                alertMessage("Unit Of Measure Not Found!",$("#" + selectedRowID + "_customerCreditNoteDetailUnitOfMeasureSearch"));
                 $("#" + selectedRowID + "_customerCreditNoteDetailUnitOfMeasureCode").val("");
                $("#customerCreditNoteDetailInput_grid").jqGrid("setCell", selectedRowID,"customerCreditNoteDetailUnitOfMeasureName"," ");
            }
        });
    }
    
    function customerCreditNoteDetailInputGrid_SearchChartOfAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerCreditNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }
    
    function customerCreditNoteDetailInputGrid_SearchUnitOfMeasure_OnClick(){
        window.open("./pages/search/search-unit-of-measure.jsp?iddoc=customerCreditNoteDetail&type=grid","Search", "scrollbars=1, width=600, height=500");
    }

    function customerCreditNoteDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#customerCreditNoteDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#customerCreditNoteDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        calculateCustomerCreditNoteHeader();
        
    }
    
    function customerCreditNoteLoadDataDetail() {
        var url = "sales/customer-credit-note-detail-data";
        var params = "customerCreditNote.code=" + txtCustomerCreditNoteCode.val();
            $.getJSON(url, params, function(data) {
                customerCreditNoteDetaillastRowId = 0;
                for (var i=0; i<data.listCustomerCreditNoteDetailTemp.length; i++) {
                    customerCreditNoteDetaillastRowId++;
                    $("#customerCreditNoteDetailInput_grid").jqGrid("addRowData", customerCreditNoteDetaillastRowId, data.listCustomerCreditNoteDetailTemp[i]);
                    $("#customerCreditNoteDetailInput_grid").jqGrid('setRowData',customerCreditNoteDetaillastRowId,{
                        customerCreditNoteDetailDelete              : "delete",
                        customerCreditNoteDetailChartOfAccountSearch    : "...",
                        customerCreditNoteDetailUnitOfMeasureSearch    : "...",
                        customerCreditNoteDetailQuantity            : data.listCustomerCreditNoteDetailTemp[i].quantity,
                        customerCreditNoteDetailChartOfAccountCode  : data.listCustomerCreditNoteDetailTemp[i].chartOfAccountCode,
                        customerCreditNoteDetailChartOfAccountName  : data.listCustomerCreditNoteDetailTemp[i].chartOfAccountName,
                        customerCreditNoteDetailUnitOfMeasureCode   : data.listCustomerCreditNoteDetailTemp[i].unitOfMeasureCode,
                        customerCreditNoteDetailBranchCode          : data.listCustomerCreditNoteDetailTemp[i].branchCode,
                        customerCreditNoteDetailPrice               : data.listCustomerCreditNoteDetailTemp[i].price,
                        customerCreditNoteDetailRemark              : data.listCustomerCreditNoteDetailTemp[i].remark,
                        customerCreditNoteDetailTotal               : ((data.listCustomerCreditNoteDetailTemp[i].quantity * data.listCustomerCreditNoteDetailTemp[i].price))
                    });
                }
                calculateCustomerCreditNoteHeader();
            });
    }
    
       
    function customerCreditNoteLoadExchangeRate(){
        if($("#customerCreditNoteUpdateMode").val()==="false"){
            if(txtCustomerCreditNoteCurrencyCode.val()==="IDR"){
                txtCustomerCreditNoteExchangeRate.val("1.00");
                txtCustomerCreditNoteExchangeRate.attr('readonly',true);
            }else{
                txtCustomerCreditNoteExchangeRate.val("0.00");
                txtCustomerCreditNoteExchangeRate.attr('readonly',false);
            }
        }else{
            if(txtCustomerCreditNoteCurrencyCode.val()==="IDR"){
                txtCustomerCreditNoteExchangeRate.val("1.00");
                txtCustomerCreditNoteExchangeRate.attr('readonly',true);
            }else{
                txtCustomerCreditNoteExchangeRate.attr('readonly',false);
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
                    txtCustomerCreditNoteCurrencyCode.val(data.currencyTemp.code);
                    txtCustomerCreditNoteCurrencyName.val(data.currencyTemp.name);
                    customerCreditNoteLoadExchangeRate();
                }
                else{
                    alertMessage("Currency Not Found!",txtCustomerCreditNoteCurrencyCode);
                    txtCustomerCreditNoteCurrencyCode.val("");
                    txtCustomerCreditNoteCurrencyName.val("");
                    txtCustomerCreditNoteExchangeRate.val("0.00");
                    txtCustomerCreditNoteExchangeRate.attr("readonly",true);
                }
            });
    }
    function handlers_input_customer_credit_note(){
                        
        if(txtCustomerCreditNoteBranchCode.val()===""){
            handlersInput(txtCustomerCreditNoteBranchCode);
        }else{
            unHandlersInput(txtCustomerCreditNoteBranchCode);
        }
        
        if(dtpCustomerCreditNoteTransactionDate.val()===""){
            handlersInput(dtpCustomerCreditNoteTransactionDate);
        }else{
            unHandlersInput(dtpCustomerCreditNoteTransactionDate);
        }
        
        if(txtCustomerCreditNoteCurrencyCode.val()===""){
            handlersInput(txtCustomerCreditNoteCurrencyCode);
        }else{
            unHandlersInput(txtCustomerCreditNoteCurrencyCode);
        }
        
//        if(txtCustomerCreditNoteDiscountAccountCode.val()===""){
//            handlersInput(txtCustomerCreditNoteDiscountAccountCode);
//        }else{
//            unHandlersInput(txtCustomerCreditNoteDiscountAccountCode);
//        }
        
        if(parseFloat(removeCommas(txtCustomerCreditNoteExchangeRate.val()))>0){
            unHandlersInput(txtCustomerCreditNoteExchangeRate);
        }else{
            handlersInput(txtCustomerCreditNoteExchangeRate);
        }
        
        if(txtCustomerCreditNoteCustomerCode.val()===""){
            handlersInput(txtCustomerCreditNoteCustomerCode);
        }else{
            unHandlersInput(txtCustomerCreditNoteCustomerCode);
        }
        if(txtCustomerCreditNotePaymentTermCode.val()===""){
            handlersInput(txtCustomerCreditNotePaymentTermCode);
        }else{
            unHandlersInput(txtCustomerCreditNotePaymentTermCode);
        }        
    }
               
</script>

<s:url id="remoteurlCustomerCreditNoteDetailInput" action="" />
<b>CUSTOMER CREDIT NOTE</b>
<hr>
<br class="spacer" />

<div id="customerCreditNoteInput" class="content ui-widget">
    <s:form id="frmCustomerCreditNoteInput">
        <table cellpadding="2" cellspacing="2" id="headerCustomerCreditNoteInput">
            <tr>
                <td align="right"><B>CCN No *</B></td>
                <td>
                    <s:textfield id="customerCreditNote.code" name="customerCreditNote.code" key="customerCreditNote.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="customerCreditNoteUpdateMode" name="customerCreditNoteUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="customerCreditNote.transactionDate" name="customerCreditNote.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="false" timepickerFormat="hh:mm:ss" onchange="customerCreditNoteTransactionDateOnChange()"></sj:datepicker>
                    <sj:datepicker id="customerCreditNoteTransactionDate" name="customerCreditNoteTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="customerCreditNoteTemp.transactionDateTemp" name="customerCreditNoteTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
            
                </td>
            </tr>
            <tr>
                <td align="right"><B>Payment Term *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtCustomerCreditNotePaymentTermCode.change(function(ev) {
                            if(txtCustomerCreditNotePaymentTermCode.val()===""){
                                txtCustomerCreditNotePaymentTermName.val("");
                                txtCustomerCreditNotePaymentTermDays.val("0");
                                return;
                            }
                            var url = "master/payment-term-get";
                            var params = "paymentTerm.code=" + txtCustomerCreditNotePaymentTermCode.val();
                                params+= "&paymentTerm.activeStatus=TRUE";
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.paymentTermTemp){
                                    txtCustomerCreditNotePaymentTermCode.val(data.paymentTermTemp.code);
                                    txtCustomerCreditNotePaymentTermName.val(data.paymentTermTemp.name);
                                    txtCustomerCreditNotePaymentTermDays.val(data.paymentTermTemp.days);
                                }
                                else{
                                    alertMessage("Payment Term Not Found!",txtCustomerCreditNotePaymentTermCode);
                                    txtCustomerCreditNotePaymentTermCode.val("");
                                    txtCustomerCreditNotePaymentTermName.val("");
                                    txtCustomerCreditNotePaymentTermDays.val("0");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="customerCreditNote.paymentTerm.code" name="customerCreditNote.paymentTerm.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="customerCreditNote_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="customerCreditNote.paymentTerm.name" name="customerCreditNote.paymentTerm.name" size="40" readonly="true"></s:textfield>
                        <s:textfield id="customerCreditNote.paymentTerm.days" name="customerCreditNote.paymentTerm.days" size="20" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Due Date</B></td>
                <td><sj:datepicker id="customerCreditNote.dueDate" name="customerCreditNote.dueDate" readonly="true" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="false" timepickerFormat="hh:mm:ss"></sj:datepicker></td>
            </tr>
            <tr>
                <td align="right" style="width:120px"><B>Branch *</B></td>
                <td colspan="2">
                <script type = "text/javascript">

                    txtCustomerCreditNoteBranchCode.change(function(ev) {

                        if(txtCustomerCreditNoteBranchCode.val()===""){
                            txtCustomerCreditNoteBranchName.val("");
                            return;
                        }
                        var url = "master/branch-get";
                        var params = "branch.code=" + txtCustomerCreditNoteBranchCode.val();
                            params += "&branch.activeStatus=TRUE";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.branchTemp){
                                txtCustomerCreditNoteBranchCode.val(data.branchTemp.code);
                                txtCustomerCreditNoteBranchName.val(data.branchTemp.name);
                            }
                            else{
                                alertMessage("Branch Not Found!",txtCustomerCreditNoteBranchCode);
                                txtCustomerCreditNoteBranchCode.val("");
                                txtCustomerCreditNoteBranchName.val("");
                            }
                        });
                    });
                    if($("#customerCreditNoteUpdateMode").val()==="true"){
                        txtCustomerCreditNoteBranchCode.attr("readonly",true);
                        $("#customerCreditNote_btnBranch").hide();
                        $("#ui-icon-search-branch-sales-order").hide();
                    }else{
                        txtCustomerCreditNoteBranchCode.attr("readonly",false);
                        $("#customerCreditNote_btnBranch").show();
                        $("#ui-icon-search-branch-sales-order").show();
                    }
                </script>
                <div class="searchbox ui-widget-header" hidden="true">
                    <s:textfield id="customerCreditNote.branch.code" name="customerCreditNote.branch.code" size="22"></s:textfield>
                    <sj:a id="customerCreditNote_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                </div>
                    <s:textfield id="customerCreditNote.branch.name" name="customerCreditNote.branch.name" size="40" readonly="true" required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            
            
            <tr>
                <td align="right"><B>Currency *</B></td>
                <td colspan="3">
                    <script type = "text/javascript">

                        txtCustomerCreditNoteCurrencyCode.change(function(ev) {

                            if(txtCustomerCreditNoteCurrencyCode.val()===""){
                                txtCustomerCreditNoteCurrencyName.val("");
                                txtCustomerCreditNoteExchangeRate.val("0.00");
                                txtCustomerCreditNoteExchangeRate.attr('readonly',true);
                                return;
                            }

                            var url = "master/currency-get";
                            var params = "currency.code=" + txtCustomerCreditNoteCurrencyCode.val();
                                params+= "&currency.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.currencyTemp){
                                    txtCustomerCreditNoteCurrencyCode.val(data.currencyTemp.code);
                                    txtCustomerCreditNoteCurrencyName.val(data.currencyTemp.name);
                                    customerCreditNoteLoadExchangeRate();
                                }
                                else{
                                    alertMessage("Currency Not Found",txtCustomerCreditNoteCurrencyCode);
                                    txtCustomerCreditNoteCurrencyCode.val("");
                                    txtCustomerCreditNoteCurrencyName.val("");
                                    txtCustomerCreditNoteExchangeRate.val("0.00");
                                    txtCustomerCreditNoteExchangeRate.attr("readonly",true);
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="customerCreditNote.currency.code" name="customerCreditNote.currency.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                    <sj:a id="customerCreditNote_btnCurrency" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="customerCreditNote.currency.name" name="customerCreditNote.currency.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Exchange Rate *</B></td>
                <td>
                    <s:textfield id="customerCreditNote.exchangeRate" name="customerCreditNote.exchangeRate" size="22" cssStyle="text-align:right"></s:textfield>&nbsp;<span id="errmsgExchangeRate"></span>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Customer *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtCustomerCreditNoteCustomerCode.change(function(ev) {
                            if(txtCustomerCreditNoteCustomerCode.val()===""){
                                txtCustomerCreditNoteCustomerName.val("");
                                return;
                            }
                            var url = "master/customer-get";
                            var params = "customer.code=" + txtCustomerCreditNoteCustomerCode.val();
                                params+= "&customer.activeStatus=TRUE";
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.customerTemp){
                                    txtCustomerCreditNoteCustomerCode.val(data.customerTemp.code);
                                    txtCustomerCreditNoteCustomerName.val(data.customerTemp.name);
                                }
                                else{
                                    alertMessage("Customer Not Found!",txtCustomerCreditNoteCustomerCode);
                                    txtCustomerCreditNoteCustomerCode.val("");
                                    txtCustomerCreditNoteCustomerName.val("");
                                }
                            });
                        });
                    </script>
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="customerCreditNote.customer.code" name="customerCreditNote.customer.code" title=" " required="true" cssClass="required" size="22"></s:textfield>
                        <sj:a id="customerCreditNote_btnCustomer" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="customerCreditNote.customer.name" name="customerCreditNote.customer.name" size="40" readonly="true"></s:textfield>
                </td>
            </tr>
            
<!--            <tr>
                <td align="right">Tax Invoice No</td>
                <td><s:textfield id="customerCreditNote.taxInvoiceNo" name="customerCreditNote.taxInvoiceNo" size="25"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Tax Invoice Date</td>
                <td>
                    <sj:datepicker id="customerCreditNote.taxInvoiceDate" name="customerCreditNote.taxInvoiceDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                </td>
            </tr>-->
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="customerCreditNote.refNo" name="customerCreditNote.refNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Description</td>
                <td colspan="3"><s:textarea id="customerCreditNote.remark" name="customerCreditNote.remark"  cols="70" rows="2" height="20"></s:textarea></td>
            </tr> 
            <tr hidden="true">
                <td>
                    <s:textfield id="customerCreditNote.createdBy" name="customerCreditNote.createdBy" key="customerCreditNote.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="customerCreditNote.createdDate" name="customerCreditNote.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <s:textfield id="customerCreditNoteTemp.createdDateTemp" name="customerCreditNoteTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmCustomerCreditNote" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmCustomerCreditNote" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="customerCreditNoteDetailInputGrid">
            <sjg:grid
                id="customerCreditNoteDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listCustomerCreditNoteTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuCustomerCreditNoteDetail').width()"
                editurl="%{remoteurlCustomerCreditNoteDetailInput}"
                onSelectRowTopics="customerCreditNoteDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="customerCreditNoteDetail" index="customerCreditNoteDetail" key="customerCreditNoteDetail" 
                    title="Branch" width="80" sortable="true" editable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailDelete" index="customerCreditNoteDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'customerCreditNoteDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                
                <sjg:gridColumn
                    name="customerCreditNoteDetailBranchCode" index="customerCreditNoteDetailBranchCode" key="customerCreditNoteDetailBranchCode" 
                    title="Branch" width="80" sortable="true"
                />
                
                <sjg:gridColumn
                    name="customerCreditNoteDetailChartOfAccountSearch" index="customerCreditNoteDetailChartOfAccountSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'customerCreditNoteDetailInputGrid_SearchChartOfAccount_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailChartOfAccountCode" index="customerCreditNoteDetailChartOfAccountCode" 
                    title="Chart Of Account No" width="200" sortable="true" editable="true" edittype="text" 
                    editoptions="{onChange:'onChangeChartOfAccountCCN()'}"
                />     
                <sjg:gridColumn
                    name="customerCreditNoteDetailChartOfAccountName" index="customerCreditNoteDetailChartOfAccountName" title="Chart Of Account Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailRemark" index="customerCreditNoteDetailRemark" key="customerCreditNoteDetailRemark" 
                    title="Remark" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailQuantity" index="customerCreditNoteDetailQuantity" key="customerCreditNoteDetailQuantity" title="Quantity" 
                    width="80" align="right" editable="true" edittype="text" 
                    formatter="number" editrules="{ double: true }"
                    editoptions="{onKeyUp:'calculateCustomerCreditNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailUnitOfMeasureSearch" index="customerCreditNoteDetailUnitOfMeasureSearch" title="" width="25" align="centre"
                    editable="true" 
                    dataType="html"
                    edittype="button"
                    editoptions="{onClick:'customerCreditNoteDetailInputGrid_SearchUnitOfMeasure_OnClick()', value:'...'}"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailUnitOfMeasureCode" index="customerCreditNoteDetailUnitOfMeasureCode" 
                    title="Unit" width="80" sortable="true" editable="true" edittype="text" 
                    editoptions="{onChange:'onChangeUnitOfMeasureCCN()'}"
                />     
                <sjg:gridColumn
                    name="customerCreditNoteDetailPrice" index="customerCreditNoteDetailPrice" key="customerCreditNoteDetailPrice" title="Price" 
                    width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                    formatter="number" editrules="{ double: true }"
                    editoptions="{onKeyUp:'calculateCustomerCreditNoteDetail()'}"
                />
                <sjg:gridColumn
                    name="customerCreditNoteDetailTotal" index="customerCreditNoteDetailTotal" key="customerCreditNoteDetailTotal" title="Total" 
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
                                <s:textfield id="customerCreditNoteDetailAddRow" name="customerCreditNoteDetailAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                <sj:a href="#" id="btnCustomerCreditNoteAddDetail" button="true"  style="width: 60px">Add</sj:a>&nbsp;<span id="errmsgAddRow"></span>
                            </td>
                        </tr>
                        <tr height="10px"/>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnCustomerCreditNoteSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnCustomerCreditNoteCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="right"><B>Total Transaction</B></td>
                            <td width="100px">
                                <s:textfield id="customerCreditNote.totalTransactionAmount" name="customerCreditNote.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Discount
                                <s:textfield id="customerCreditNote.discountPercent" onkeyup="calculateCustomerCreditNoteHeader()" name="customerCreditNote.discountPercent" size="5" cssStyle="text-align:right"></s:textfield>
                                %
                            </td>
                            <td><s:textfield id="customerCreditNote.discountAmount" onchange="calculateCustomerCreditNoteHeader()" name="customerCreditNote.discountAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                        </tr>
                        
                        <tr>
                            <td align="right" style="width:120px"><B>Discount Account *</B></td>
                            <td colspan="2">
                            <script type = "text/javascript">

                                txtCustomerCreditNoteDiscountAccountCode.change(function(ev) {

                                    if(txtCustomerCreditNoteDiscountAccountCode.val()===""){
                                        txtCustomerCreditNoteDiscountAccountName.val("");
                                        return;
                                    }
                                    var url = "master/chart-of-account-get";
                                    var params = "chartOfAccount.code=" + txtCustomerCreditNoteDiscountAccountCode.val();
                                        params += "&chartOfAccount.activeStatus=TRUE";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.chartOfAccountTemp){
                                            txtCustomerCreditNoteDiscountAccountCode.val(data.chartOfAccountTemp.code);
                                            txtCustomerCreditNoteDiscountAccountName.val(data.chartOfAccountTemp.name);
                                        }
                                        else{
                                            alertMessage("Chart Of Account Not Found!",txtCustomerCreditNoteDiscountAccountCode);
                                            txtCustomerCreditNoteDiscountAccountCode.val("");
                                            txtCustomerCreditNoteDiscountAccountName.val("");
                                        }
                                    });
                                });
                            </script>
                            <div class="searchbox ui-widget-header" hidden="true">
                                <s:textfield id="customerCreditNote.discountAccount.code" name="customerCreditNote.discountAccount.code" size="22"></s:textfield>
                                <sj:a id="customerCreditNote_btnChartOfAccount" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                                <s:textfield id="customerCreditNote.discountAccount.name" name="customerCreditNote.discountAccount.name" size="40" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right"><B>Sub Total(Tax Base)</B></td>
                            <td>
                                <s:textfield id="customerCreditNoteSubTotal" name="customerCreditNoteSubTotal"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">VAT                                   
                            <s:textfield id="customerCreditNote.vatPercent" onkeyup="calculateCustomerCreditNoteHeader()" name="customerCreditNote.vatPercent" size="5" cssStyle="text-align:right"></s:textfield>
                                %
                            </td>
                            <td><s:textfield id="customerCreditNote.vatAmount" name="customerCreditNote.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="customerCreditNote.grandTotalAmount" name="customerCreditNote.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
                            
        
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    