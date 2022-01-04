<%-- 
    Document   : vendor-down-payment
    Created on : Sep 18, 2019, 3:58:27 PM
    Author     : Rayis
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<style>
    input{border-radius: 3px;}
</style>
<s:url id="remoteurlVendorDownPayment" action="vendor-down-payment-json" />

<script type="text/javascript">
                
    function reloadGrid() {
        $("#vendorDownPayment_grid").trigger("reloadGrid");
      
    };
    
    function reloadGridDetailAfterDelete() {
        $("#vendorDownPaymentDetail_grid").jqGrid("clearGridData");
        $("#vendorDownPaymentDetail_grid").jqGrid("setCaption", "VENDOR DOWN PAYMENT");
    };

    
    
    $(document).ready(function(){
        
        hoverButton();
                      
        
        $('#btnVendorDownPaymentNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    var dynamicDialogUpdate= $(
                        '<div id="conformBoxError">'+
                        '<span>'+
                        '</span>'+data.errorMessage+'<br/><br/>' +
                        '</div>');
                    dynamicDialogUpdate.dialog({
                        title : "Attention!",
                        closeOnEscape: false,
                        modal : true,
                        width: 300,
                        resizable: false,
                        buttons : 
                                [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("close");
                                        }
                                }]
                    }); 
                    return;
                }

                var url = "finance/vendor-down-payment-input";
                var params = "";

                pageLoad(url, params, "#tabmnuVENDOR_DOWN_PAYMENT");  

            });      
                      
        });
        
        $('#btnVendorDownPaymentUpdate').click(function(ev) {
            var selectedRowId = $("#vendorDownPayment_grid").jqGrid('getGridParam','selrow');
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    var dynamicDialogUpdate= $(
                                            '<div id="conformBoxError">'+
                                            '<span>'+
                                            '</span>'+data.errorMessage+'<br/><br/>' +
                                            '</div>');
                    dynamicDialogUpdate.dialog({
                            title : "Attention!",
                            closeOnEscape: false,
                            modal : true,
                            width: 300,
                            resizable: false,
                            buttons : 
                                    [{
                                        text : "OK",
                                        click : function() {
                                                $(this).dialog("close");
                                        }
                                    }]
                    }); 
                    return;
                }

                var vendorDownPayment = $("#vendorDownPayment_grid").jqGrid('getRowData', selectedRowId);
                
                var url = "finance/vendor-down-payment-existing";
                var params = "vendorDownPayment.code=" + vendorDownPayment.code;
                params+="&actionAuthority=UPDATE";
               
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        var dynamicDialog= $(
                                '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                '</span>Cannot Update this Transaction.</B><br/><br/>' +
                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                '</span>SDP No : '+vendorDownPayment.code+'<br/><br/>' +
                                '<span>'+
                                '</span>'+data.errorMessage+'<br/><br/>' +
                                '</div>');
                        dynamicDialog.dialog({
                            title : "Attention!",
                            closeOnEscape: false,
                            modal : true,
                            width: 350,
                            resizable: false,
                            buttons : 
                                [{
                                    text : "OK",
                                    click : function() {
                                        $(this).dialog("close");
                                    }
                                }]
                        }); 
                        return;
                    }

                    switch(data.isExisting){
                        case true:
                            var dynamicDialog= $(
                                    '<div id="conformBoxError">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>Cannot Update this Transaction since has been Used/Paid!</B><br/><br/>' +
                                    '<span style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>CDP No : '+vendorDownPayment.code+'<br/><br/>' +
                                    '<span>'+
                                    '</div>');
                            dynamicDialog.dialog({
                                title : "Attention!",
                                closeOnEscape: false,
                                modal : true,
                                width: 400,
                                resizable: false,
                                buttons : 
                                    [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("close");
                                        }
                                    }]
                            }); 
                            break;
                        case false:
                            var url = "finance/vendor-down-payment-input";
                            var params = "vendorDownPaymentUpdateMode=true" + "&vendorDownPayment.code=" + vendorDownPayment.code;
                            pageLoad(url, params, "#tabmnuVENDOR_DOWN_PAYMENT");
                            break;
                    }
                });

            });      
        });
        
        $('#btnVendorDownPaymentDelete').click(function(ev) {
            var selectedRowId = $("#vendorDownPayment_grid").jqGrid('getGridParam','selrow');
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    var dynamicDialogUpdate= $(
                                            '<div id="conformBoxError">'+
                                            '<span>'+
                                            '</span>'+data.errorMessage+'<br/><br/>' +
                                            '</div>');
                    dynamicDialogUpdate.dialog({
                            title : "Attention!",
                            closeOnEscape: false,
                            modal : true,
                            width: 300,
                            resizable: false,
                            buttons : 
                                    [{
                                            text : "OK",
                                            click : function() {
                                                    $(this).dialog("close");
                                            }
                                    }]
                    }); 
                    return;
                }

                var vendorDownPayment = $("#vendorDownPayment_grid").jqGrid('getRowData', selectedRowId);
                
                var url = "finance/vendor-down-payment-existing";
                var parame = "vendorDownPayment.code=" + vendorDownPayment.code;
                parame+="&actionAuthority=DELETE";

                $.post(url, parame, function(data) {
                    if (data.error) {
                        var dynamicDialog= $(
                                '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                '</span>Cannot Delete this Transaction.</B><br/><br/>' +
                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                '</span>SDP No : '+vendorDownPayment.code+'<br/><br/>' +
                                '<span>'+
                                '</span>'+data.errorMessage+'<br/><br/>' +
                                '</div>');
                        dynamicDialog.dialog({
                            title : "Attention!",
                            closeOnEscape: false,
                            modal : true,
                            width: 350,
                            resizable: false,
                            buttons : 
                                [{
                                    text : "OK",
                                    click : function() {
                                        $(this).dialog("close");
                                    }
                                }]
                        }); 
                        return;
                    }

                    switch(data.isExisting){
                        case true:
                            var dynamicDialog= $(
                                    '<div id="conformBoxError">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>Cannot Delete this Transaction since has been Used/Paid!</B><br/><br/>' +
                                    '<span style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>SDP No : '+vendorDownPayment.code+'<br/><br/>' +
                                    '<span>'+
                                    '</div>');
                            dynamicDialog.dialog({
                                title : "Attention!",
                                closeOnEscape: false,
                                modal : true,
                                width: 400,
                                resizable: false,
                                buttons : 
                                    [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("close");
                                        }
                                    }]
                            }); 
                            break;
                        case false:
                            var url = "finance/vendor-down-payment-delete";
                            var params = "vendorDownPayment.code=" + vendorDownPayment.code;

                            var dynamicDialog= $(
                                                '<div id="conformBoxError">'+
                                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                                '</span>Are You Sure To Delete?<br/><br/>' +
                                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                                '</span>SDP No: '+vendorDownPayment.code+'<br/><br/>' +    
                                                '</div>');
                            dynamicDialog.dialog({
                                title : "Confirmation",
                                closeOnEscape: false,
                                modal : true,
                                width: 300,
                                resizable: false,
                                buttons : 
                                    [{
                                        text : "Yes",
                                        click : function() {
                                            $.post(url, params, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                reloadGrid();
                                            });  
                                            $(this).dialog("close");
                                        }
                                    },
                                    {
                                        text : "No",
                                        click : function() {
                                            $(this).dialog("close");                                       
                                        }
                                    }]
                            });
                            break;
                    }
                });

            });      
        });
        
        $('#btnVendorDownPaymentRefresh').click(function(ev) {
            var url = "finance/vendor-down-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuVENDOR_DOWN_PAYMENT");  
        });
        
        
        $('#btnVendorDownPayment_search').click(function(ev) {
            formatDateSDP();
            $("#vendorDownPayment_grid").jqGrid("clearGridData");
            $("#vendorDownPayment_grid").jqGrid("setGridParam",{url:"finance/vendor-down-payment-data?" + $("#frmVendorDownPaymentSearchInput").serialize()});
            $("#vendorDownPayment_grid").trigger("reloadGrid");
            formatDateSDP();
        });
        
        
        $("#btnVendorDownPaymentPrint").click(function(ev) {
            var selectRowId = $("#vendorDownPayment_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alert("Please Select Row!");
                return;
            }
            
            var vendorDownPayment = $("#vendorDownPayment_grid").jqGrid('getRowData', selectRowId);             
            var url = "finance/vendor-down-payment-print-out-pdf?";
            var params = "code=" + vendorDownPayment.sdpNo;
             
            window.open(url+params,'vendorDownPayment','width=500,height=500');
        });

    });
        
    function formatDateSDP(){
        var firstDate=$("#vendorDownPaymentSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#vendorDownPaymentSearchFirstDate").val(firstDateValue);

        var lastDate=$("#vendorDownPaymentSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#vendorDownPaymentSearchLastDate").val(lastDateValue);
    }
    
</script>
    
    <b>VENDOR DOWN PAYMENT</b>
    <hr>
    <br class="spacer" />
    <sj:div id="vendorDownPaymentButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnVendorDownPaymentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" /></a>
        <a href="#" id="btnVendorDownPaymentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/></a>
        <a href="#" id="btnVendorDownPaymentDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/></a>
        <a href="#" id="btnVendorDownPaymentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" /></a>
        <a href="#" id="btnVendorDownPaymentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" /></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="vendorDownPaymentInputSearch" class="content ui-widget">
        <s:form id="frmVendorDownPaymentSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="vendorDownPaymentSearchFirstDate" name="vendorDownPaymentSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="vendorDownPaymentSearchLastDate" name="vendorDownPaymentSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="vendorDownPaymentSearchCode" name="vendorDownPaymentSearchCode" size="25" placeholder=" VDP No"></s:textfield>
                    </td>
                    <td width="10px"/>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="vendorDownPaymentVendorSearchCode" name="vendorDownPaymentVendorSearchCode" size="10" placeHolder=" Code"></s:textfield>
                        <s:textfield id="vendorDownPaymentVendorSearchName" name="vendorDownPaymentVendorSearchName" size="25" placeHolder=" Name"></s:textfield>
                    </td>
                    <td width="10px"/>
                    <td align="right">Currency</td>
                    <td>
                        <s:textfield id="vendorDownPaymentCurrencySearchCode" name="vendorDownPaymentCurrencySearchCode" size="10" placeHolder=" Code"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnVendorDownPayment_search" button="true">Search</sj:a>
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="vendorDownPaymentGrid">
        <sjg:grid
            id="vendorDownPayment_grid"
            caption="VENDOR DOWN PAYMENT"
            dataType="json"
            href="%{remoteurlVendorDownPayment}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listVendorDownPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuvendorDownPayment').width()"
            onSelectRowTopics="vendorDownPayment_grid_onSelect"
        >   
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="90" sortable="true" align="center"
            />
            <sjg:gridColumn
                name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="taxInvoiceNo" index="taxInvoiceNo" key="taxInvoiceNo" title="Tax Invoice No" width="130" sortable="true" align="center"
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" key="currencyCode" title="Currency Code" width="100" sortable="true" align="center"
            />
            <sjg:gridColumn
                name = "exchangeRate" index = "exchangeRate" key = "exchangeRate" title = "Rate" width = "80" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" title = "Total Transaction" width = "130" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "vatAmount" index = "vatAmount" key = "vatAmount" title = "VAT Amount" width = "100" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "grandTotalAmount" index = "grandTotalAmount" key = "grandTotalAmount" title = "Grand Total" width = "100" sortable = "false" 
                formatter="number"
                align="right"
                formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="150" sortable="true"
            />
        </sjg:grid >
    </div>
    

