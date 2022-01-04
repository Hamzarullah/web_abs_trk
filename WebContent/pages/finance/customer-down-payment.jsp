
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<style>
    input{border-radius: 3px;}
</style>

<script type="text/javascript">
                
    function reloadGrid() {
        $("#customerDownPayment_grid").trigger("reloadGrid");
      
    };
    function alertMessageCDP(alert_message){
        var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                            '</span>'+alert_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>' +
                    '</div>');
            
            dynamicDialog.dialog({
                title : "Attention!",
                closeOnEscape: false,
                modal : true,
                width: 400,
                resizable: false,
                closeText: "hide",
                buttons : 
                    [{
                        text : "OK",
                        click : function() {
                            $(this).dialog("close");                            
                        }
                    }]
            });
    }    
    $(document).ready(function(){
        
        hoverButton();
              
        
        $('#btnCustomerDownPaymentNew').click(function(ev) {
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

                var url = "finance/customer-down-payment-input";
                var params = "";

                pageLoad(url, params, "#tabmnuCUSTOMER_DOWN_PAYMENT");    

            });      
                
        });
        
        $('#btnCustomerDownPaymentUpdate').click(function(ev) {
            var selectedRowId = $("#customerDownPayment_grid").jqGrid('getGridParam','selrow');
            if (selectedRowId === null) {
                alertMessageCDP("Please Select Row!");
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

                var customerDownPayment = $("#customerDownPayment_grid").jqGrid('getRowData', selectedRowId);
                var cdpNo=customerDownPayment.code;

                var url = "finance/customer-down-payment-existing";
                var params = "customerDownPayment.code=" + cdpNo;
                params+="&actionAuthority=UPDATE";

                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        var dynamicDialog= $(
                                '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                '</span>Cannot Update this Transaction.</B><br/><br/>' +
                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                '</span>CDP No : '+cdpNo+'<br/><br/>' +
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
                                    '</span>CDP No : '+cdpNo+'<br/><br/>' +
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
                            var url = "finance/customer-down-payment-input";
                            var params = "customerDownPaymentUpdateMode=true" + "&customerDownPayment.code=" + cdpNo;
                            pageLoad(url, params, "#tabmnuCUSTOMER_DOWN_PAYMENT");
                            break;
                    }
                });

            });      
        });
        
        $('#btnCustomerDownPaymentDelete').click(function(ev) {
            var selectedRowId = $("#customerDownPayment_grid").jqGrid('getGridParam','selrow');
            if (selectedRowId === null) {
                alertMessageCDP("Please Select Row!");
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

                var customerDownPayment = $("#customerDownPayment_grid").jqGrid('getRowData', selectedRowId);
                var cdpNo=customerDownPayment.code;

                var url = "finance/customer-down-payment-existing";
                var parame = "customerDownPayment.code=" + cdpNo;
                parame+="&actionAuthority=DELETE";

                $.post(url, parame, function(data) {
                    if (data.error) {
                        var dynamicDialog= $(
                                '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                '</span>Cannot Delete this Transaction.</B><br/><br/>' +
                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                '</span>CDP No : '+cdpNo+'<br/><br/>' +
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
                                    '</span>CDP No : '+cdpNo+'<br/><br/>' +
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
                            var url = "finance/customer-down-payment-delete";
                            var params = "customerDownPayment.code=" + cdpNo;

                            var dynamicDialog= $(
                                                '<div id="conformBoxError">'+
                                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                                '</span>Are You Sure To Delete?<br/><br/>' +
                                                '<span style="float:left; margin:0 7px 20px 0;">'+
                                                '</span>CDP No: '+cdpNo+'<br/><br/>' +    
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
                                                    alertMessageCDP(data.errorMessage);
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

        $('#btnCustomerDownPaymentRefresh').click(function(ev) {
            var url = "finance/customer-down-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_DOWN_PAYMENT");  
//            $("#customerDownPayment_grid").jqGrid("clearGridData");
//            $("#customerDownPayment_grid").jqGrid("setGridParam",{url:"finance/customer-down-payment-search-data?"});
//            $("#customerDownPayment_grid").trigger("reloadGrid");
//            
//            ev.preventDefault();   
        });
        
        
        $('#btnCustomerDownPayment_search').click(function(ev) {
            formatDateCDP();
            $("#customerDownPayment_grid").jqGrid("clearGridData");
            $("#customerDownPayment_grid").jqGrid("setGridParam",{url:"finance/customer-down-payment-data?" + $("#frmCustomerDownPaymentSearchInput").serialize()});
            $("#customerDownPayment_grid").trigger("reloadGrid");
            formatDateCDP();
        });
        
        $('#btnCustomerDownPaymentPrint').click(function(ev) {
             var selectRowId = $("#customerDownPayment_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessageCDP("Please Select Row!");
                return;
            }
            
            var customerDownPayment = $("#customerDownPayment_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/finance/customer-down-payment-print-out-pdf?";
            var params ="cdpNo=" + customerDownPayment.code;
            
            window.open(url+params,'customerDownPayment','width=500,height=500');
            
        });
        
    });
    
    function formatDateCDP(){
        var firstDate=$("#customerDownPaymentSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#customerDownPaymentSearchFirstDate").val(firstDateValue);

        var lastDate=$("#customerDownPaymentSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#customerDownPaymentSearchLastDate").val(lastDateValue);
    }
    
</script>
<s:url id="remoteurlCustomerDownPayment" action="customer-down-payment-json" />
    <b>CUSTOMER DOWN PAYMENT</b>
    <hr>
    <br class="spacer" />
    <sj:div id="customerDownPaymentButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnCustomerDownPaymentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnCustomerDownPaymentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnCustomerDownPaymentDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnCustomerDownPaymentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnCustomerDownPaymentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="customerDownPaymentInputSearch" class="content ui-widget">
        <s:form id="frmCustomerDownPaymentSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>CDP No</b></td>
                    <td>
                        <s:textfield id="customerDownPaymentSearchCode" name="customerDownPaymentSearchCode" size="25" placeHolder=" CDP No"></s:textfield>
                    </td>
                    <td width="10px"/>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="customerDownPaymentCustomerSearchCode" name="customerDownPaymentCustomerSearchCode" size="10" placeHolder=" Code"></s:textfield>
                        <s:textfield id="customerDownPaymentCustomerSearchName" name="customerDownPaymentCustomerSearchName" size="25" placeHolder=" Name"></s:textfield>
                    </td>
                    <td width="10px"/>
                    <td align="right"><b>Currency</b></td>
                    <td>
                        <s:textfield id="customerDownPaymentCurrencySearchCode" name="customerDownPaymentCurrencySearchCode" size="10" placeHolder=" Code"></s:textfield>
                    </td>
                    <td width="5%"/>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="customerDownPaymentSearchFirstDate" name="customerDownPaymentSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="customerDownPaymentSearchLastDate" name="customerDownPaymentSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnCustomerDownPayment_search" button="true">Search</sj:a>
            <br />
            <br />
             
        </s:form>
    </div>
    <br />
                  
    <div id="customerDownPaymentGrid">
        <sjg:grid
            id="customerDownPayment_grid"
            caption="CUSTOMER DOWN PAYMENT"
            dataType="json"
            href="%{remoteurlCustomerDownPayment}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerDownPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucustomerDownPayment').width()"
        >
            
        <sjg:gridColumn
            name="code" index="code" key="code" title="CDPNo" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="130" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
        />
         <sjg:gridColumn
            name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="customerName" index="customerName" key="customerName" title="Customer Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="tinNo" index="tinNo" key="tinNo" title="TINNo" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true"
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
            name = "grandTotalAmount" index = "grandTotalAmount" key = "grandTotalAmount" title = "Grand Total Amount" width = "130" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="paymentTermCode" index="paymentTermCode" key="paymentTermCode" title="Payment Term Code" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="paymentTermName" index="paymentTermName" key="paymentTermName" title="Payment Term Name" width="130" sortable="true"
        />
        <sjg:gridColumn
            name="bankAccountCode" index="bankAccountCode" key="bankAccountCode" title="Bank Account Code" width="130" sortable="true"
        />
        <sjg:gridColumn
            name="bankAccountName" index="bankAccountName" key="bankAccountName" title="Bank Account Name" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="cdpNote" index="cdpNote" key="cdpNote" title="CDP Note" width="130" sortable="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="150" sortable="true"
        />
        </sjg:grid >
    </div>
    

