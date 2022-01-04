<%-- 
    Document   : vendor-down-payment-input
    Created on : Sep 18, 2019, 3:58:57 PM
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
    #errmsgExchangeRate,#errmsgTotalTransaction,#errmsgVatPercent{
        color: red;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
            
    var 
        txtVendorDownPaymentCode = $("#vendorDownPayment\\.code"),
        dtpVendorDownPaymentTransactionDate = $("#vendorDownPayment\\.transactionDate"),
        txtVendorDownPaymentBranchCode = $("#vendorDownPayment\\.branch\\.code"),
        txtVendorDownPaymentBranchName = $("#vendorDownPayment\\.branch\\.name"),
        txtVendorDownPaymentVendorCode = $("#vendorDownPayment\\.vendor\\.code"),
        txtVendorDownPaymentVendorName = $("#vendorDownPayment\\.vendor\\.name"),
        txtVendorDownPaymentVendorContactPerson = $("#vendorDownPayment\\.vendor\\.defaultContactPerson\\.code"),
        txtVendorDownPaymentVendorAddress = $("#vendorDownPayment\\.vendor\\.address"),
        txtVendorDownPaymentVendorPhone1 = $("#vendorDownPayment\\.vendor\\.phone1"),
        txtVendorDownPaymentVendorPhone2 = $("#vendorDownPayment\\.vendor\\.phone2"),
        txtVendorDownItemDivisionCode = $("#vendorDownPayment\\.itemDivision\\.code"),
        txtVendorDownItemDivisionName = $("#vendorDownPayment\\.itemDivision\\.name"),
        txtVendorDownPaymentTaxInvoiceNo = $("#vendorDownPayment\\.taxInvoiceNo"),
        txtVendorDownPaymentCurrencyCode = $("#vendorDownPayment\\.currency\\.code"),
        txtVendorDownPaymentCurrencyName = $("#vendorDownPayment\\.currency\\.name"),
        txtVendorDownPaymentPaymentTermCode = $("#vendorDownPayment\\.paymentTerm\\.code"),
        txtVendorDownPaymentPaymentTermName = $("#vendorDownPayment\\.paymentTerm\\.name"),
        txtVendorDownPaymentExchangeRate = $("#vendorDownPayment\\.exchangeRate"),
        txtVendorDownPaymentTotalTransactionAmount = $("#vendorDownPayment\\.totalTransactionAmount"),
        txtVendorDownPaymentVATPercent = $("#vendorDownPayment\\.vatPercent"),
        txtVendorDownPaymentVATAmount = $("#vendorDownPayment\\.vatAmount"),
        txtVendorDownPaymentGrandTotalAmount = $("#vendorDownPayment\\.grandTotalAmount"),
        txtVendorDownPaymentRefno = $("#vendorDownPayment\\.refno"),
        txtVendorDownPaymentRemark = $("#vendorDownPayment\\.remark"),
        txtVendorDownPaymentCreatedDate = $("#vendorDownPayment\\.createdDate");

    $(document).ready(function() {
        vendorDownPaymentLoadExchangeRate();
        vendordownPaymentFormatNumeric();
        $("#vendorDownPayment\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        
        $("#vendorDownPayment\\.exchangeRate").change(function(e){
            var exrate=$("#vendorDownPayment\\.exchangeRate").val();
            
            if(exrate==="" || parseFloat(exrate)===0){
               $("#vendorDownPayment\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#vendorDownPayment\\.totalTransactionAmount").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransactionAmount").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#vendorDownPayment\\.totalTransactionAmount").change(function(e){
            var amount=$("#vendorDownPayment\\.totalTransactionAmount").val();
            if(amount===""){
               $("#vendorDownPayment\\.totalTransactionAmount").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#vendorDownPayment\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgVatPercent").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorDownPayment\\.vatPercent").change(function(e){
            var vatPercent=$("#vendorDownPayment\\.vatPercent").val();
            if(vatPercent===""){
               $("#vendorDownPayment\\.vatPercent").val("0.00");
            }
            $(this).val(function(index, value) {
                value = value.replace(/,/g,''); 
                return formatNumber(parseFloat(value),2); 
            });
           
        });
        
        $("#vendorDownPayment\\.exchangeRate").keypress(function(e){
           if(e.which!==8 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgExchangeRate").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorDownPayment\\.totalTransactionAmount").keypress(function(e){
           if(e.which!==8 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgTotalTransaction").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $("#vendorDownPayment\\.vatPercent").keypress(function(e){
           if(e.which!==8 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgVatPercent").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });
        
        $('#btnVendorDownPaymentSave').click(function(ev) {
            
            var date = $("#vendorDownPayment\\.transactionDate").val().split("/");
            var month = date[1];
            var year = date[2].split(" ");
            if(parseFloat(month) !== parseFloat($("#panel_periodMonth").val()) ){
                alertMessage("Transaction Month Must Between Session Period Month!",dtpVendorDownPaymentTransactionDate);
                return;
            }

            if(parseFloat(year) !== parseFloat($("#panel_periodYear").val()) ){
                alertMessage("Transaction Year Must Between Session Period Year!",dtpVendorDownPaymentTransactionDate);
                return;
            }
            
            if(txtVendorDownPaymentVendorName.val()===""){
                alertMessage("Vendor Cannot Empty!",txtVendorDownPaymentVendorCode);
                return;
            }
            if(txtVendorDownPaymentCurrencyName.val()===""){
                alertMessage("Currency Cannot Empty!",txtVendorDownPaymentCurrencyCode);
                return;
            }
            
            if(txtVendorDownPaymentBranchCode.val()===""){
                alertMessage("Branch Cant Be Null",txtVendorDownPaymentBranchCode);
                return;
            }

            if(parseFloat(txtVendorDownPaymentTotalTransactionAmount.val())<0){
                alertMessage("Total Transaction Amount Is Invalid!",txtVendorDownPaymentTotalTransactionAmount);
                return;
            }
           
            vendorDownPaymentFormatDate();
            vendordownPaymentUnFormatNumeric();
            
            var url="finance/vendor-down-payment-save";
            var params = $("#frmVendorDownPaymentInput").serialize();
            showLoading();
            
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    vendorDownPaymentFormatDate();
                    vendordownPaymentFormatNumeric();
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
                                var url = "finance/vendor-down-payment-input";
                                var params = "";            
                                pageLoad(url, params, "#tabmnuVENDOR_DOWN_PAYMENT"); 
                            }
                        },
                        {
                            text : "No",
                            click : function() {

                                $(this).dialog("close");
                                var url = "finance/vendor-down-payment";
                                var params = "";            
                                pageLoad(url, params, "#tabmnuVENDOR_DOWN_PAYMENT");
                            }
                        }]
                });
            });
        });

      $('#vendorDownPayment_btnBranch').click(function(ev) {
        window.open("./pages/search/search-branch.jsp?iddoc=vendorDownPayment&idsubdoc=branch","Search", "scrollbars=1, width=550, height=450").focus();
        });
        
      $('#vendorDownPayment_btnPaymentTerm').click(function(ev) {
        window.open("./pages/search/search-payment-term.jsp?iddoc=vendorDownPayment&idsubdoc=paymentTerm","Search", "width=600, height=500");
        });

        $('#btnVendorDownPaymentCancel').click(function(ev) {
            var url = "finance/vendor-down-payment";
            var params = "";            
            pageLoad(url, params, "#tabmnuVENDOR_DOWN_PAYMENT"); 
        });

        $('#vendorDownPayment_btnCompany').click(function(ev) {
            window.open("./pages/search/search-company.jsp?iddoc=vendorDownPayment&idsubdoc=company","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#vendorDownPayment_btnVendor').click(function(ev) {
            window.open("./pages/search/search-vendor.jsp?iddoc=vendorDownPayment&idsubdoc=vendor","Search", "width=600, height=500");
        });
        
        $('#vendorDownPayment_btnItemDivision').click(function(ev) {
            window.open("./pages/search/search-item-division.jsp?iddoc=vendorDownPayment&idsubdoc=itemDivision","Search", "width=600, height=500");
        });
         
        $('#vendorDownPayment_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=vendorDownPayment&idsubdoc=currency","Search", "width=600, height=500");
        });
                 
    });
    
    function vendorDownPaymentLoadExchangeRate(){
        var vendorDownPaymentUpdateMode=$("#vendorDownPaymentUpdateMode").val();
        if(vendorDownPaymentUpdateMode==="false"){
            if(txtVendorDownPaymentCurrencyCode.val()==="IDR"){
                txtVendorDownPaymentExchangeRate.val("1.00");
                txtVendorDownPaymentExchangeRate.attr('readonly',true);
            }else{
                txtVendorDownPaymentExchangeRate.val("1.00");
                txtVendorDownPaymentExchangeRate.attr('readonly',false);
            }
         }else{
            if(txtVendorDownPaymentCurrencyCode.val()==="IDR"){
                txtVendorDownPaymentExchangeRate.attr('readonly',true);
            }else{
                txtVendorDownPaymentExchangeRate.attr('readonly',false);
            } 
         }
    }
    
    function vendorDownPaymentSetDefault(){
        if(txtVendorDownPaymentCurrencyCode.val()==="IDR"){
            txtVendorDownPaymentExchangeRate.val("1.00");
            txtVendorDownPaymentExchangeRate.attr('readonly',true);
        }else{
            txtVendorDownPaymentExchangeRate.val("1.00");
            txtVendorDownPaymentExchangeRate.attr('readonly',false);
        }
    }
    
    function vendorDownPaymentFormatDate(){
        var transactionDate=$("#vendorDownPayment\\.transactionDate").val();
        var dateValuesTemp= transactionDate.split(' ');
        var dateValues= dateValuesTemp[0].split('/');
        var transactionDateValue = dateValues[1]+"/"+dateValues[0]+"/"+dateValues[2]+" "+dateValuesTemp[1];
        dtpVendorDownPaymentTransactionDate.val(transactionDateValue);
        $("#vendorDownPaymentTemp\\.transactionDateTemp").val(dtpVendorDownPaymentTransactionDate.val());
        
        var createdDate=$("#vendorDownPayment\\.createdDate").val();
        var createdDateTemp= createdDate.split(' ');
        var createdDateValues= createdDateTemp[0].split('/');
        var createdDateValue = createdDateValues[1]+"/"+createdDateValues[0]+"/"+createdDateValues[2]+" "+createdDateTemp[1];
        $("#vendorDownPayment\\.createdDate").val(createdDateValue);
        $("#vendorDownPaymentTemp\\.createdDateTemp").val(createdDateValue);
    }

    function vendordownPaymentFormatNumeric(){
        var exchangeRate =parseFloat(txtVendorDownPaymentExchangeRate.val());
        var totalTransaction =parseFloat(txtVendorDownPaymentTotalTransactionAmount.val());
        var vatPercent =parseFloat(txtVendorDownPaymentVATPercent.val());
        var vatAmount =parseFloat(txtVendorDownPaymentVATAmount.val());
        var grandTotal =parseFloat(txtVendorDownPaymentGrandTotalAmount.val());
        txtVendorDownPaymentExchangeRate.val(formatNumber(exchangeRate,2));
        txtVendorDownPaymentTotalTransactionAmount.val(formatNumber(totalTransaction,2));
        txtVendorDownPaymentVATPercent.val(formatNumber(vatPercent,2));
        txtVendorDownPaymentVATAmount.val(formatNumber(vatAmount,2));
        txtVendorDownPaymentGrandTotalAmount.val(formatNumber(grandTotal,2));
    }
    
    function vendordownPaymentUnFormatNumeric(){
        var exchangeRate =removeCommas(txtVendorDownPaymentExchangeRate.val());
        var totalTransaction =removeCommas(txtVendorDownPaymentTotalTransactionAmount.val());
        var vatAmount =removeCommas(txtVendorDownPaymentVATAmount.val());
        var grandTotal =removeCommas(txtVendorDownPaymentGrandTotalAmount.val());
        txtVendorDownPaymentExchangeRate.val(exchangeRate);
        txtVendorDownPaymentTotalTransactionAmount.val(totalTransaction);
        txtVendorDownPaymentVATAmount.val(vatAmount);
        txtVendorDownPaymentGrandTotalAmount.val(grandTotal);
    }

    function vendorDownPaymentCalculateGrandTotalAmount(){
        var totalTransaction=$("#vendorDownPayment\\.totalTransactionAmount").val().replace(/,/g,"");
        var exchangeRate=$("#vendorDownPayment\\.exchangeRate").val().replace(/,/g,"");
        var varPercent=$("#vendorDownPayment\\.vatPercent").val().replace(/,/g,"");
        var vatAmount;
        
        if(totalTransaction===""){
            totalTransaction=0;
            $("#vendorDownPayment\\.vatAmount").val("0.00");
            txtVendorDownPaymentGrandTotalAmount.val("0.00");
        }
        
        if(exchangeRate===""){
            $("#vendorDownPayment\\.vatAmount").val("0.00");
            txtVendorDownPaymentGrandTotalAmount.val("0.00");
            exchangeRate=0;
        }
        
        if(varPercent===""){
            $("#vendorDownPayment\\.vatAmount").val("0.00");
            varPercent=0;
        }
        
        vatAmount=parseFloat(varPercent) /100 * parseFloat(totalTransaction);
        
        $("#vendorDownPayment\\.vatAmount").val(formatNumber(vatAmount,2));
        
        var grandTotalAmount=parseFloat(totalTransaction) + vatAmount;
        $("#vendorDownPayment\\.grandTotalAmount").val(formatNumber(grandTotalAmount,2));
        
    }
    
</script>
<b>VENDOR DOWN PAYMENT</b>
<hr>
<br class="spacer" />
    
<div id="vendorDownPaymentInput" class="content ui-widget">
        <s:form id="frmVendorDownPaymentInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" style="width:120px"><B>VDP No *</B></td>
                    <td colspan="2">
                        <s:textfield id="vendorDownPayment.code" name="vendorDownPayment.code" size="25" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Branch *</B></td>
                      <td>
                          <script type = "text/javascript">

                          txtVendorDownPaymentBranchCode.change(function(ev) {

                                  if(txtVendorDownPaymentBranchCode.val()===""){
                                      txtVendorDownPaymentBranchCode.val("");
                                      txtVendorDownPaymentBranchName.val("");
                                      return;
                                  }
                                  var url = "master/branch-get";
                                  var params = "branch.code=" + txtVendorDownPaymentBranchCode.val();
                                      params += "&branch.activeStatus="+true;
                                  $.post(url, params, function(result) {
                                      var data = (result);
                                      if (data.branchTemp){
                                          txtVendorDownPaymentBranchCode.val(data.branchTemp.code);
                                          txtVendorDownPaymentBranchName.val(data.branchTemp.name);
                                      }
                                      else{
                                          alertMessage("Branch Not Found!",txtVendorDownPaymentBranchCode);
                                          txtVendorDownPaymentBranchCode.val("");
                                          txtVendorDownPaymentBranchName.val("");
                                      }
                                  });
                              });

                          </script>
                          <div class="searchbox ui-widget-header">
                              <s:textfield id="vendorDownPayment.branch.code" name="vendorDownPayment.branch.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                              <sj:a id="vendorDownPayment_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                          </div>&nbsp;
                          <s:textfield id="vendorDownPayment.branch.name" name="vendorDownPayment.branch.name" size="38" readonly="true"></s:textfield> 
                      </td>
                  </tr>
                <tr>
                    <td align="right"><B>Transaction Date *</B></td>
                    <td colspan="3">
                        <sj:datepicker id="vendorDownPayment.transactionDate" name="vendorDownPayment.transactionDate" required="true" cssClass="required" displayFormat="dd/mm/yy" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" size="20" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Vendor *</B></td>
                    <td>
                        <script type = "text/javascript">
                            txtVendorDownPaymentVendorCode.change(function(ev) {
                                if(txtVendorDownPaymentVendorCode.val()===""){
                                    txtVendorDownPaymentVendorName.val("");
                                    txtVendorDownPaymentVendorContactPerson.val("");
                                    txtVendorDownPaymentVendorAddress.val("");
                                    txtVendorDownPaymentVendorPhone1.val("");
                                    txtVendorDownPaymentVendorPhone2.val("");
                                    return;
                                }
                                
                                var url = "master/vendor-get";
                                var params = "vendor.code=" + txtVendorDownPaymentVendorCode.val();
                                    params += "&vendor.activeStatus=TRUE";
                                
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.vendorTemp){
                                        txtVendorDownPaymentVendorCode.val(data.vendorTemp.code);
                                        txtVendorDownPaymentVendorName.val(data.vendorTemp.name);
                                        txtVendorDownPaymentVendorContactPerson.val(data.vendorTemp.defaultContactPersonCode);
                                        txtVendorDownPaymentVendorAddress.val(data.vendorTemp.address);
                                        txtVendorDownPaymentVendorPhone1.val(data.vendorTemp.phone1);
                                        txtVendorDownPaymentVendorPhone2.val(data.vendorTemp.phone2);
                                    }
                                    else{
                                        alertMessage("Vendor Not Found!",txtVendorDownPaymentVendorCode);
                                        txtVendorDownPaymentVendorCode.val("");
                                        txtVendorDownPaymentVendorName.val("");
                                        txtVendorDownPaymentVendorContactPerson.val("");
                                        txtVendorDownPaymentVendorAddress.val("");
                                        txtVendorDownPaymentVendorPhone1.val("");
                                        txtVendorDownPaymentVendorPhone2.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="vendorDownPayment.vendor.code" name="vendorDownPayment.vendor.code" size="15"></s:textfield>
                            <sj:a id="vendorDownPayment_btnVendor" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        <s:textfield id="vendorDownPayment.vendor.name" name="vendorDownPayment.vendor.name" size="40" readonly="true"></s:textfield>
                    
                    </td>
                </tr>
                <tr>
                    <td align="right">Contact Person</td>
                    <td colspan="3"><s:textfield id="vendorDownPayment.vendor.defaultContactPerson.code" name="vendorDownPayment.vendor.defaultContactPerson.code" size="50" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Address</td>
                    <td colspan="3">
                        <s:textarea id="vendorDownPayment.vendor.address" name="vendorDownPayment.vendor.address"  cols="70" rows="3" height="20" readonly="true"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right">Phone 1</td>
                    <td colspan="3">
                        <s:textfield id="vendorDownPayment.vendor.phone1" name="vendorDownPayment.vendor.phone1" size="20" readonly="true"></s:textfield>
                        &nbsp;Phone 2
                        <s:textfield id="vendorDownPayment.vendor.phone2" name="vendorDownPayment.vendor.phone2" size="20" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Tax Invoice No</td>
                    <td><s:textfield id="vendorDownPayment.taxInvoiceNo" name="vendorDownPayment.taxInvoiceNo" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Currency *</B></td>
                    <td>
                        <script type = "text/javascript"> 
                            txtVendorDownPaymentCurrencyCode.change(function(ev) {
                                if(txtVendorDownPaymentCurrencyCode.val()===""){
                                    txtVendorDownPaymentCurrencyCode.val("");
                                    txtVendorDownPaymentCurrencyName.val("");
                                    txtVendorDownPaymentExchangeRate.val("0.00");
                                    txtVendorDownPaymentExchangeRate.attr("readonly",true);
                                    return;
                                }
                                var url = "master/currency-get";
                                var params = "currency.code=" + txtVendorDownPaymentCurrencyCode.val();
                                    params += "&currency.activeStatus=TRUE";
                                
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.currencyTemp){
                                        txtVendorDownPaymentCurrencyCode.val(data.currencyTemp.code);
                                        txtVendorDownPaymentCurrencyName.val(data.currencyTemp.name);
                                        vendorDownPaymentSetDefault();
                                    }else{
                                        alertMessage("Currency Not Found!",txtVendorDownPaymentCurrencyCode);
                                        txtVendorDownPaymentCurrencyCode.val("");
                                        txtVendorDownPaymentCurrencyName.val("");
                                        txtVendorDownPaymentExchangeRate.val("0.00");
                                        txtVendorDownPaymentExchangeRate.attr("readonly",true);
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="vendorDownPayment.currency.code" name="vendorDownPayment.currency.code" size="15"></s:textfield>
                            <sj:a id="vendorDownPayment_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="vendorDownPayment.currency.name" name="vendorDownPayment.currency.name" size="40" readonly="true" ></s:textfield> 
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top"><B>Item Division *</B></td>
                    <td colspan="3">
                    <script type = "text/javascript">

                        txtVendorDownItemDivisionCode.change(function(ev) {

                            if(txtVendorDownItemDivisionCode.val()===""){
                                txtVendorDownItemDivisionName.val("");
                                return;
                            }
                            var url = "master/item-division-get";
                            var params = "itemDivision.code=" + txtVendorDownItemDivisionCode.val();
                                params += "&itemDivision.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.itemDivisionTemp){
                                    txtVendorDownItemDivisionCode.val(data.itemDivisionTemp.code);
                                    txtVendorDownItemDivisionName.val(data.itemDivisionTemp.name);
                                }else{
                                    alertMessage("Item Division Not Found!",txtVendorDownItemDivisionCode);
                                    txtVendorDownItemDivisionCode.val("");
                                    txtVendorDownItemDivisionName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="vendorDownPayment.itemDivision.code" name="vendorDownPayment.itemDivision.code" required="true" cssClass="required" title=" " size="20"></s:textfield>
                        <sj:a id="vendorDownPayment_btnItemDivision" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendorDownPayment.itemDivision.name" name="vendorDownPayment.itemDivision.name" size="34" readonly="true"></s:textfield>
                </tr>
                <tr>
                    <td align="right"><B>Payment Term *</B></td>
                    <td >
                        <script type = "text/javascript">

                            txtVendorDownPaymentPaymentTermCode.change(function(ev) {

                                if(txtVendorDownPaymentPaymentTermCode.val()===""){
                                    txtVendorDownPaymentPaymentTermName.val("");
                                    txtVendorDownPaymentPaymentTermDays.val("");
                                    return;
                                }
                                var url = "master/payment-term-get";
                                var params = "paymentTerm.code=" + txtVendorDownPaymentPaymentTermCode.val();
                                    params+="&paymentTerm.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.paymentTermTemp){
                                        txtVendorDownPaymentPaymentTermCode.val(data.paymentTermTemp.code);
                                        txtVendorDownPaymentPaymentTermName.val(data.paymentTermTemp.name);
                                        txtVendorDownPaymentPaymentTermDays.val(data.paymentTermTemp.days);
                                    }
                                    else{
                                        alertMessage("Payment Term Not Found!",txtVendorDownPaymentPaymentTermCode);
                                        txtVendorDownPaymentPaymentTermCode.val("");
                                        txtVendorDownPaymentPaymentTermName.val("");
                                        txtVendorDownPaymentPaymentTermDays.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="vendorDownPayment.paymentTerm.code" name="vendorDownPayment.paymentTerm.code" cssClass="required" required="true" title="*" size="15"></s:textfield>
                            <sj:a id="vendorDownPayment_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                            <s:textfield id="vendorDownPayment.paymentTerm.name" name="vendorDownPayment.paymentTerm.name" readonly="true" cssStyle="width:32%"></s:textfield>
                            <s:textfield id="vendorDownPayment.paymentTerm.days" name="vendorDownPayment.paymentTerm.days" readonly="true" cssStyle="width:5%"></s:textfield>
                    </td>
<!--                    <td align="right"><B>Address *</B></td>
                    <td>
                        <s:textfield id="vendorDownPayment.shipTo.address" name="vendorDownPayment.shipTo.address" required="true" cssClass="required" size="27" readonly="true"></s:textfield>
                    </td>-->
                </tr>
                <tr>
                    <td align="right"><B>Exchange Rate *</B></td>
                    <td><s:textfield id="vendorDownPayment.exchangeRate" name="vendorDownPayment.exchangeRate" size="25" cssStyle="text-align:right" readonly="true"/>&nbsp;<span id="errmsgExchangeRate"></span></td>
                </tr>
                <tr>
                    <td align="right"><B>Total Transaction *</B></td>
                        <td><s:textfield id="vendorDownPayment.totalTransactionAmount" name="vendorDownPayment.totalTransactionAmount" size="25" cssStyle="text-align:right" onkeyup="vendorDownPaymentCalculateGrandTotalAmount()"/>&nbsp;<span id="errmsgTotalTransaction"></span></td>
                </tr>
                <tr>
                    <td align="right">VAT</td>
                    <td>
                        <s:textfield id="vendorDownPayment.vatPercent" name="vendorDownPayment.vatPercent" size="5" cssStyle="text-align:right" onkeyup="vendorDownPaymentCalculateGrandTotalAmount()"/>
                        %&nbsp;
                        <s:textfield id="vendorDownPayment.vatAmount" name="vendorDownPayment.vatAmount" size="17" cssStyle="text-align:right" readonly="true"></s:textfield>&nbsp;<span id="errmsgVatPercent"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">Grand Total</td>
                    <td><s:textfield id="vendorDownPayment.grandTotalAmount" name="vendorDownPayment.grandTotalAmount" size="25" cssStyle="text-align:right" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td colspan="3"><s:textfield id="vendorDownPayment.refNo" name="vendorDownPayment.refNo" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td colspan="3"><s:textarea id="vendorDownPayment.remark" name="vendorDownPayment.remark"  cols="70" rows="3" height="20"></s:textarea></td>
                </tr> 
                <tr>
                    <td>
                        <s:textfield  id="vendorDownPaymentTemp.transactionDateTemp" name="vendorDownPaymentTemp.transactionDateTemp" cssStyle="display:none" ></s:textfield>
                        <s:textfield id="vendorDownPaymentUpdateMode" name="vendorDownPaymentUpdateMode" size="20" cssStyle="display:none" ></s:textfield>
                        <sj:datepicker id="vendorDownPaymentTransactionDateFirstSession" name="vendorDownPaymentTransactionDateFirstSession" size="20" showOn="focus" hidden="true"></sj:datepicker>
                        <sj:datepicker id="vendorDownPaymentTransactionDateLastSession" name="vendorDownPaymentTransactionDateLastSession" size="20" showOn="focus" hidden="true"></sj:datepicker>
                        <s:textfield id="vendorDownPaymentTemp.createdDateTemp" name="vendorDownPaymentTemp.createdDateTemp" cssStyle="display:none"></s:textfield>
                        <sj:datepicker id="vendorDownPayment.createdDate" name="vendorDownPayment.createdDate" required="true" cssClass="required" size="25" displayFormat="dd/mm/yy"  timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    </td>
                </tr>
            </table>     
        </s:form>     
        <div>
            <table>
                <tr>
                    <td width="50%"></td>
                    <td>
                        <sj:a href="#" id="btnVendorDownPaymentSave" button="true">Save</sj:a>
                    </td>
                    <td>
                        <sj:a href="#" id="btnVendorDownPaymentCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </div>
    </div> 
    
   