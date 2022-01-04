
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #customerPurchaseOrderSalesQuotation_grid_pager_center,#customerPurchaseOrderItemDetail_grid_pager_center,
    #customerPurchaseOrderAdditionalFee_grid_pager_center,#customerPurchaseOrderPaymentTerm_grid_pager_center,#customerPurchaseOrderItemDeliveryDate_grid_pager_center{
        display: none;
    }    
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
    function loadGridItemDetailCPOSO(){
        //function groupingHeader
           $("#customerPurchaseOrderItemDetail_grid").jqGrid('setGroupHeaders', {
               useColSpanStyle: true, 
               groupHeaders:[
                     {startColumnName: 'bodyConstruction', numberOfColumns: 3, titleText: 'Body Const'},
                     {startColumnName: 'typeDesign', numberOfColumns: 3, titleText: 'Type Design'},
                     {startColumnName: 'seatDesign', numberOfColumns: 3, titleText: 'Seat Design'},
                     {startColumnName: 'size', numberOfColumns: 3, titleText: 'Size'},
                     {startColumnName: 'rating', numberOfColumns: 3, titleText: 'Rating'},
                     {startColumnName: 'bore', numberOfColumns: 3, titleText: 'Bore'},

                     {startColumnName: 'endCon', numberOfColumns: 3, titleText: 'End Con'},
                     {startColumnName: 'body', numberOfColumns: 3, titleText: 'Body'},
                     {startColumnName: 'ball', numberOfColumns: 3, titleText: 'Ball'},
                     {startColumnName: 'seat', numberOfColumns: 3, titleText: 'Seat'},
                     {startColumnName: 'seatInsert', numberOfColumns: 3, titleText: 'Seat Insert'},
                     {startColumnName: 'stem', numberOfColumns: 3, titleText: 'Stem'},

                     {startColumnName: 'seal', numberOfColumns: 3, titleText: 'Seal'},
                     {startColumnName: 'bolting', numberOfColumns: 3, titleText: 'Bolt'},
                     {startColumnName: 'disc', numberOfColumns: 3, titleText: 'Disc'},
                     {startColumnName: 'plates', numberOfColumns: 3, titleText: 'Plates'},
                     {startColumnName: 'shaft', numberOfColumns: 3, titleText: 'Shaft'},
                     {startColumnName: 'spring', numberOfColumns: 3, titleText: 'Spring'},

                     {startColumnName: 'armPin', numberOfColumns: 3, titleText: 'Arm Pin'},
                     {startColumnName: 'backSeat', numberOfColumns: 3, titleText: 'Back Seat'},
                     {startColumnName: 'arm', numberOfColumns: 3, titleText: 'Arm'},
                     {startColumnName: 'hingePin', numberOfColumns: 3, titleText: 'Hinge Pin'},
                     {startColumnName: 'stopPin', numberOfColumns: 3, titleText: 'Stop Pin'},
                     {startColumnName: 'operator', numberOfColumns: 3, titleText: 'Operator'}
               ]
           });
    }
        
    $(document).ready(function(){
        
        hoverButton();
        
        $('#customerPurchaseOrderSearchValidStatusRadYES').prop('checked',true);
            $("#customerPurchaseOrderSearchValidStatus").val("true");
        
        $('input[name="customerPurchaseOrderSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#customerPurchaseOrderSearchValidStatus").val(value);
        });
        
        $('input[name="customerPurchaseOrderSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="TRUE";
            $("#customerPurchaseOrderSearchValidStatus").val(value);
        });
                
        $('input[name="customerPurchaseOrderSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="FALSE";
            $("#customerPurchaseOrderSearchValidStatus").val(value);
        });
        
        $('#customerPurchaseOrderSearchClosingStatusRadOPEN').prop('checked',true);
            $("#customerPurchaseOrder\\.closingStatus").val("OPEN");
        $('input[name="customerPurchaseOrderSearchClosingStatusRad"][value="OPEN"]').change(function(ev){
            $("#customerPurchaseOrder\\.closingStatus").val("OPEN");
        });
        $('input[name="customerPurchaseOrderSearchClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#customerPurchaseOrder\\.closingStatus").val("CLOSED");
        });
        $('input[name="customerPurchaseOrderSearchClosingStatusRad"][value="ALL"]').change(function(ev){
            $("#customerPurchaseOrder\\.closingStatus").val("");
        });    
               
        $.subscribe("customerPurchaseOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#customerPurchaseOrder_grid").jqGrid("getGridParam", "selrow"); 
            var customerPurchaseOrder = $("#customerPurchaseOrder_grid").jqGrid("getRowData", selectedRowID);
            
            $("#customerPurchaseOrderItemDetail_grid").jqGrid('destroyGroupHeader');
            $("#customerPurchaseOrderSalesQuotation_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-sales-quotation-data?customerPurchaseOrder.code="+ customerPurchaseOrder.code});
            $("#customerPurchaseOrderSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
            $("#customerPurchaseOrderSalesQuotation_grid").trigger("reloadGrid");
            
            $("#customerPurchaseOrderItemDetail_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-item-detail-data?customerPurchaseOrder.code="+ customerPurchaseOrder.code});
            $("#customerPurchaseOrderItemDetail_grid").jqGrid("setCaption", "Item");
            $("#customerPurchaseOrderItemDetail_grid").trigger("reloadGrid");
            loadGridItemDetailCPOSO();
            
            $("#customerPurchaseOrderAdditionalFee_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-additional-fee-data?customerPurchaseOrder.code="+ customerPurchaseOrder.code});
            $("#customerPurchaseOrderAdditionalFee_grid").jqGrid("setCaption", "Additional");
            $("#customerPurchaseOrderAdditionalFee_grid").trigger("reloadGrid");
            
            $("#customerPurchaseOrderPaymentTerm_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-payment-term-data?customerPurchaseOrder.code="+ customerPurchaseOrder.code});
            $("#customerPurchaseOrderPaymentTerm_grid").jqGrid("setCaption", "Payment Term");
            $("#customerPurchaseOrderPaymentTerm_grid").trigger("reloadGrid");

            $("#customerPurchaseOrderItemDeliveryDate_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-item-delivery-data?customerPurchaseOrder.code="+ customerPurchaseOrder.code});
            $("#customerPurchaseOrderItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#customerPurchaseOrderItemDeliveryDate_grid").trigger("reloadGrid");
            
            
            $("#customerPurchaseOrderTotalTransactionAmount").val(formatNumber(parseFloat(customerPurchaseOrder.totalTransactionAmount),2));
            $("#customerPurchaseOrderDiscountPercent").val(formatNumber(parseFloat(customerPurchaseOrder.discountPercent),2));
            $("#customerPurchaseOrderDiscountAmount").val(formatNumber(parseFloat(customerPurchaseOrder.discountAmount),2));
            $("#customerPurchaseOrderTotalAdditionalFeeAmount").val(formatNumber(parseFloat(customerPurchaseOrder.totalAdditionalFeeAmount),2));
            $("#customerPurchaseOrderSubTotalAmount").val(formatNumber(parseFloat(customerPurchaseOrder.taxBaseAmount),2));
            $("#customerPurchaseOrderVatPercent").val(formatNumber(parseFloat(customerPurchaseOrder.vatPercent),2));
            $("#customerPurchaseOrderVatAmount").val(formatNumber(parseFloat(customerPurchaseOrder.vatAmount),2));
            $("#customerPurchaseOrderGrandTotalAmount").val(formatNumber(parseFloat(customerPurchaseOrder.grandTotalAmount),2));
            
        });
        
        $('#btnCustomerPurchaseOrderNew').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "sales/customer-purchase-order-to-sales-order-input";
                var params = "enumCustomerPurchaseOrderActivity=NEW";

                pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");

            });
                    
        });
        
        $('#btnCustomerPurchaseOrderUpdate').click(function(ev) {
            var selectedRowId = $("#customerPurchaseOrder_grid").jqGrid('getGridParam','selrow');
            var customerPurchaseOrder = $("#customerPurchaseOrder_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(customerPurchaseOrder.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            var url = "sales/customer-purchase-order-to-sales-order-input";
            var params = "enumCustomerPurchaseOrderActivity=UPDATE";
                params+="&customerPurchaseOrder.code=" + customerPurchaseOrder.code;
                pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");
        });
        
        $('#btnCustomerPurchaseOrderRevise').click(function(ev) {
            var selectedRowId = $("#customerPurchaseOrder_grid").jqGrid('getGridParam','selrow');
            var customerPurchaseOrder = $("#customerPurchaseOrder_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(customerPurchaseOrder.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            var url = "sales/customer-purchase-order-to-sales-order-input";
            var params = "enumCustomerPurchaseOrderActivity=REVISE";
                params+="&customerPurchaseOrder.code=" + customerPurchaseOrder.code;
                pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");
        });
        
        $('#btnCustomerPurchaseOrderClone').click(function(ev) {
            var selectedRowId = $("#customerPurchaseOrder_grid").jqGrid('getGridParam','selrow');
            var customerPurchaseOrder = $("#customerPurchaseOrder_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(customerPurchaseOrder.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            var url = "sales/customer-purchase-order-to-sales-order-input";
            var params = "enumCustomerPurchaseOrderActivity=CLONE";
                params+="&customerPurchaseOrder.code=" + customerPurchaseOrder.code;
                params+="&customerPurchaseOrderCloneModeCode=" + customerPurchaseOrder.code;
                pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");
        });

        $('#btnCustomerPurchaseOrderDelete').click(function(ev) {
            
            var deleteRowId = $("#customerPurchaseOrder_grid").jqGrid('getGridParam','selrow');
            var customerPurchaseOrder = $("#customerPurchaseOrder_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(customerPurchaseOrder.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PCO No: '+customerPurchaseOrder.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title : "Confirmation!",
                closeOnEscape: false,
                modal : true,
                width: 300,
                resizable: false,
                buttons : 
                    [{
                        text : "Yes",
                        click : function() {
                            var url = "sales/customer-purchase-order-delete";
                            var params = "customerPurchaseOrder.code=" + customerPurchaseOrder.code;
                            $.post(url, params, function(data) {
                                if (data.error) {
                                    alertMessage(data.errorMessage);
                                    return;
                                }
                                reloadGridCPOSO();
                                reloadDetailGridCPOSO();
                                reloadTotalCPOSO();
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
            ev.preventDefault();
        });

        $('#btnCustomerPurchaseOrderRefresh').click(function(ev) {
            var url = "sales/customer-purchase-order-to-sales-order";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_PURCHASE_ORDER_TO_SALES_ORDER");
            ev.preventDefault();   
        });
        
        
        $('#btnCustomerPurchaseOrder_search').click(function(ev) {
            formatDateCPOSO();
            reloadTotalCPOSO();
            $("#customerPurchaseOrder_grid").jqGrid("clearGridData");
            $("#customerPurchaseOrder_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-data?" + $("#frmCustomerPurchaseOrderSearchInput").serialize()});
            $("#customerPurchaseOrder_grid").trigger("reloadGrid");
            
            $("#customerPurchaseOrderSalesQuotation_grid").jqGrid("clearGridData");
            $("#customerPurchaseOrderSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
            
            $("#customerPurchaseOrderItemDetail_grid").jqGrid("clearGridData");
            $("#customerPurchaseOrderItemDetail_grid").jqGrid("setCaption", "Item");
            
            $("#customerPurchaseOrderAdditionalFee_grid").jqGrid("clearGridData");
            $("#customerPurchaseOrderAdditionalFee_grid").jqGrid("setCaption", "Additional");
            
            $("#customerPurchaseOrderPaymentTerm_grid").jqGrid("clearGridData");
            $("#customerPurchaseOrderPaymentTerm_grid").jqGrid("setCaption", "Payment Term");
            
            $("#customerPurchaseOrderItemDeliveryDate_grid").jqGrid("clearGridData");
            $("#customerPurchaseOrderItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDateCPOSO();
            ev.preventDefault();
           
        });
        $("#btnCustomerPurchaseOrderPrint").click(function(ev) {
            var selectRowId = $("#customerPurchaseOrder_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            else{
            var customerPurchaseOrder = $("#customerPurchaseOrder_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/sales/customer-purchase-order-print-out-pdf?";
            var params ="code=" + customerPurchaseOrder.code;
        
            window.open(url+params,'customerPurchaseOrder','width=500,height=500');}
            ev.preventDefault();
        });
    });//EOF Ready
    
    function formatDateCPOSO(){
        var firstDate=$("#customerPurchaseOrder\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#customerPurchaseOrder\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#customerPurchaseOrder\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#customerPurchaseOrder\\.transactionLastDate").val(lastDateValue);
        
    }
    
    function reloadGridCPOSO() {
        $("#customerPurchaseOrder_grid").trigger("reloadGrid");
    };
    
    function reloadDetailGridCPOSO() {
        $("#customerPurchaseOrderSalesQuotation_grid").trigger("reloadGrid");  
        $("#customerPurchaseOrderSalesQuotation_grid").jqGrid("clearGridData");
        $("#customerPurchaseOrderSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
        
        $("#customerPurchaseOrderItemDetail_grid").trigger("reloadGrid");  
        $("#customerPurchaseOrderItemDetail_grid").jqGrid("clearGridData");
        $("#customerPurchaseOrderItemDetail_grid").jqGrid("setCaption", "Item");
        
        $("#customerPurchaseOrderAdditionalFee_grid").trigger("reloadGrid");  
        $("#customerPurchaseOrderAdditionalFee_grid").jqGrid("clearGridData");
        $("#customerPurchaseOrderAdditionalFee_grid").jqGrid("setCaption", "Additional");
        
        $("#customerPurchaseOrderPaymentTerm_grid").trigger("reloadGrid");  
        $("#customerPurchaseOrderPaymentTerm_grid").jqGrid("clearGridData");
        $("#customerPurchaseOrderPaymentTerm_grid").jqGrid("setCaption", "Payment Term");
        
        $("#customerPurchaseOrderItemDeliveryDate_grid").trigger("reloadGrid");  
        $("#customerPurchaseOrderItemDeliveryDate_grid").jqGrid("clearGridData");
        $("#customerPurchaseOrderItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
    };
    
    function reloadTotalCPOSO(){
        $("#customerPurchaseOrderTotalTransactionAmount").val("0.00");
        $("#customerPurchaseOrderDiscountPercent").val("0.00");
        $("#customerPurchaseOrderDiscountAmount").val("0.00");
        $("#customerPurchaseOrderTotalAdditionalFeeAmount").val("0.00");
        $("#customerPurchaseOrderSubTotalAmount").val("0.00");
        $("#customerPurchaseOrderVatPercent").val("0.00");
        $("#customerPurchaseOrderVatAmount").val("0.00");
        $("#customerPurchaseOrderGrandTotalAmount").val("0.00");
    }
</script>
<s:url id="remoteurlCustomerPurchaseOrder" action="customer-purchase-order-data" />    
    <b>CUSTOMER PURCHASE ORDER TO SALES ORDER</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="customerPurchaseOrderButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnCustomerPurchaseOrderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
        <a href="#" id="btnCustomerPurchaseOrderUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
        <a href="#" id="btnCustomerPurchaseOrderRevise" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Revise"/><br/>Revise</a>
        <a href="#" id="btnCustomerPurchaseOrderClone" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Clone"/><br/>Clone</a>
        <a href="#" id="btnCustomerPurchaseOrderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
        <a href="#" id="btnCustomerPurchaseOrderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>        
        <a href="#" id="btnCustomerPurchaseOrderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="CustomerPurchaseOrderInputSearch" class="content ui-widget">
        <s:form id="frmCustomerPurchaseOrderSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="customerPurchaseOrder.transactionFirstDate" name="customerPurchaseOrder.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="customerPurchaseOrder.transactionLastDate" name="customerPurchaseOrder.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">CPO-SO No</td>
                    <td>
                        <s:textfield id="customerPurchaseOrder.code" name="customerPurchaseOrder.code" size="25"></s:textfield>
                    </td>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="customerPurchaseOrder.customerCode" name="customerPurchaseOrder.customerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="customerPurchaseOrder.customerName" name="customerPurchaseOrder.customerName" size="25" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="customerPurchaseOrder.remark" name="customerPurchaseOrder.remark" size="25"></s:textfield>
                    </td>
                    <td align="right">Sales Person</td>
                    <td>
                        <s:textfield id="customerPurchaseOrder.salesPersonCode" name="customerPurchaseOrder.salesPersonCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="customerPurchaseOrder.salesPersonName" name="customerPurchaseOrder.salesPersonName" size="25" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="customerPurchaseOrder.refNo" name="customerPurchaseOrder.refNo" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Valid Status</td>
                    <td>
                        <s:radio id="customerPurchaseOrderSearchValidStatusRad" name="customerPurchaseOrderSearchValidStatusRad" label="customerPurchaseOrderSearchValidStatusRad" list="{'ALL','YES','NO'}"></s:radio>
                        <s:textfield id="customerPurchaseOrderSearchValidStatus" name="customerPurchaseOrderSearchValidStatus" size="20" style="display:none" ></s:textfield>
                    </td>
                    <td align="right">Closing Status</td>
                    <td>
                        <s:radio id="customerPurchaseOrderSearchClosingStatusRad" name="customerPurchaseOrderSearchClosingStatusRad" label="customerPurchaseOrderSearchClosingStatusRad" list="{'ALL','OPEN','CLOSED'}"></s:radio>
                        <s:textfield id="customerPurchaseOrder.closingStatus" name="customerPurchaseOrder.closingStatus" size="20" style="display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnCustomerPurchaseOrder_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
    <div>
        <sjg:grid
            id="customerPurchaseOrder_grid"
            caption="Customer Purchase Order"
            dataType="json"   
            href="%{remoteurlCustomerPurchaseOrder}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerPurchaseOrder"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuCustomerPurchaseOrder').width()"
            onSelectRowTopics="customerPurchaseOrder_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="Code" width="200" sortable="true" edittype="text" hidden="true"
            />     
            <sjg:gridColumn
                name="code" index="code" 
                title="CPO-SO No" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name="revision" index="revision" 
                title="Revision" width="80" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" 
                title="Branch Code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" 
                title="Branch Name" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="custPONo" index="custPONo" 
                title="Customer PO No" width="120" sortable="true"
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" 
                title="Customer Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" 
                title="Customer Name" width="280" sortable="true"
            />
            <sjg:gridColumn
                name="salesPersonCode" index="salesPersonCode" 
                title="SalesPerson Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesPersonName" index="salesPersonName" 
                title="SalesPerson Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="projectCode" index="projectCode" 
                title="Project" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" 
                title="Ref No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" 
                title="Remark" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="closingStatus" index="closingStatus" key="closingStatus" 
                title="Closing Status" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="totalTransactionAmount" index="totalTransactionAmount" key="totalTransactionAmount" 
                title="totalTransactionAmount" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="discountPercent" index="discountPercent" key="discountPercent" 
                title="discountPercent" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="discountAmount" index="discountAmount" key="discountAmount" 
                title="discountAmount" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="totalAdditionalFeeAmount" index="totalAdditionalFeeAmount" key="totalAdditionalFeeAmount" 
                title="totalAdditionalFeeAmount" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="taxBaseAmount" index="taxBaseAmount" key="taxBaseAmount" 
                title="taxBaseAmount" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="vatPercent" index="vatPercent" key="vatPercent" 
                title="vatPercent" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="vatAmount" index="vatAmount" key="vatAmount" 
                title="vatAmount" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" 
                title="grandTotalAmount" width="150" sortable="true" hidden="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
                  
    <div>
        <sjg:grid
            id="customerPurchaseOrderSalesQuotation_grid"
            caption="Sales Quotation"
            dataType="json"   
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerPurchaseOrderSalesQuotation"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnucustomerpurchaseOrder').width()"
        >
            <sjg:gridColumn
                name="salesQuotationCode" index="salesQuotationCode" 
                title="SLS-QUO No" width="160" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="salesQuotationTransactionDate" index="salesQuotationTransactionDate" key="salesQuotationTransactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="salesQuotationCustomerCode" index="salesQuotationCustomerCode" 
                title="Customer Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationCustomerName" index="salesQuotationCustomerName" 
                title="Customer Name" width="280" sortable="true"
            />
            <sjg:gridColumn
                name = "salesQuotationRfqCode" index = "salesQuotationRfqCode" key = "salesQuotationRfqCode" 
                title = "RFQ No" width = "135" edittype="text" 
            />
            <sjg:gridColumn
                name="salesQuotationProject" index="salesQuotationProject" 
                title="Project" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationSubject" index="salesQuotationSubject" 
                title="Subject" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationAttn" index="salesQuotationAttn" 
                title="Attn" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationRefNo" index="salesQuotationRefNo" key="salesQuotationRefNo" 
                title="Ref No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationRemark" index="salesQuotationRemark" key="salesQuotationRemark" 
                title="Remark" width="150" sortable="true"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
        <sjg:grid
            id="customerPurchaseOrderItemDetail_grid"
            caption="Item"
            dataType="json"     
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerPurchaseOrderItemDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#id-tbl-additional-payment-item-delivery').width()"
        >
            <sjg:gridColumn
                name="salesQuotationCode" index="salesQuotationCode" key="salesQuotationCode" 
                title="Quotation No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationDetailCode" index="salesQuotationDetailCode" key="salesQuotationDetailCode" 
                title="Quotation No" width="250" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="customerPurchaseOrderSortNo" index="customerPurchaseOrderSortNo" 
                title="Sort No" width="80" sortable="true" editable="true" edittype="text"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" key ="itemFinishGoodsCode"
                title="Item Finish Goods Code" width="300" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="itemFinishGoodsRemark" index="itemFinishGoodsRemark"  key ="itemFinishGoodsRemark"
                title="Remark" width="100" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="valveTypeCode" index="valveTypeCode" key ="valveTypeCode"
                title="Valve Type Code" width="100" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="valveTypeName" index="valveTypeName"  key ="valveTypeName"
                title="Valve Type Name" width="100" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="itemAlias" index="itemAlias" 
                title="Item Alias" width="100" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="valveTag" index="valveTag" title="Valve Tag" width="100" sortable="true"
            />  
            <sjg:gridColumn
                name="dataSheet" index="dataSheet" title="Data Sheet" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="description" index="description" title="Description" width="100" sortable="true"
            />
            
            <!--Body Const 01-->
            <sjg:gridColumn
                name="bodyConstruction" index="bodyConstruction" 
                title="QUO (01)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemBodyConstructionCode" index="itemBodyConstructionCode" 
                title="IFG (01)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyConstructionName" index="itemBodyConstructionName" 
                title="IFG (01)" width="100" sortable="true"
            />
            <!--Type Design 02-->
            <sjg:gridColumn
                name="typeDesign" index="typeDesign" 
                title="QUO (02)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemTypeDesignCode" index="itemTypeDesignCode" 
                title="IFG (02)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemTypeDesignName" index="itemTypeDesignName" 
                title="IFG (02)" width="100" sortable="true"
            />
            <!--Seat Design 03-->
            <sjg:gridColumn
                name="seatDesign" index="seatDesign" 
                title="QUO (03)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemSeatDesignCode" index="itemSeatDesignCode" 
                title="IFG (03)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatDesignName" index="itemSeatDesignName" 
                title="IFG (03)" width="100" sortable="true"
            />
            <!--Size 04-->
            <sjg:gridColumn
                name="size" index="size" 
                title="QUO (04)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemSizeCode" index="itemSizeCode" 
                title="IFG (04)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSizeName" index="itemSizeName" 
                title="IFG (04)" width="100" sortable="true"
            />
            <!--Rating 05-->
            <sjg:gridColumn
                name="rating" index="rating" 
                title="QUO (05)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemRatingCode" index="itemRatingCode" 
                title="IFG (05)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemRatingName" index="itemRatingName" 
                title="IFG (05)" width="100" sortable="true"
            />
            <!--Bore 06-->
            <sjg:gridColumn
                name="bore" index="bore" 
                title="QUO (06)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemBoreCode" index="itemBoreCode" 
                title="IFG (06)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoreName" index="itemBoreName" 
                title="IFG (06)" width="100" sortable="true"
            />
            <!--EndCon 07-->
            <sjg:gridColumn
                name="endCon" index="endCon" 
                title="QUO (07)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemEndConCode" index="itemEndConCode" 
                title="IFG (07)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemEndConName" index="itemEndConName" 
                title="IFG (07)" width="100" sortable="true"
            />
            <!--Body 08-->
            <sjg:gridColumn
                name="body" index="body" 
                title="QUO (08)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemBodyCode" index="itemBodyCode" 
                title="IFG (08)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyName" index="itemBodyName" 
                title="IFG (08)" width="100" sortable="true"
            />
            <!--Ball 09-->
            <sjg:gridColumn
                name="ball" index="ball" 
                title="QUO (09)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemBallCode" index="itemBallCode" 
                title="IFG (09)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBallName" index="itemBallName" 
                title="IFG (09)" width="100" sortable="true"
            />
            <!--Seat 10-->
            <sjg:gridColumn
                name="seat" index="seat" 
                title="QUO (10)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemSeatCode" index="itemSeatCode" 
                title="IFG (10)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatName" index="itemSeatName" 
                title="IFG (10)" width="100" sortable="true"
            />
            <!--SeatInsert 11-->
            <sjg:gridColumn
                name="seatInsert" index="seatInsert" 
                title="QUO (11)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemSeatInsertCode" index="itemSeatInsertCode" 
                title="IFG (11)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatInsertName" index="itemSeatInsertName" 
                title="IFG (11)" width="100" sortable="true"
            />
            <!--Stem 12-->
            <sjg:gridColumn
                name="stem" index="stem" 
                title="QUO (12)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemStemCode" index="itemStemCode" 
                title="IFG (12)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemStemName" index="itemStemName" 
                title="IFG (12)" width="100" sortable="true"
            />
            <!--Seal 13-->
            <sjg:gridColumn
                name="seal" index="seal" 
                title="QUO (13)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemSealCode" index="itemSealCode" 
                title="IFG (13)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSealName" index="itemSealName" 
                title="IFG (13)" width="100" sortable="true"
            />
            <!--Bolt 14-->
            <sjg:gridColumn
                name="bolting" index="bolting" 
                title="QUO (14)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemBoltCode" index="itemBoltCode" 
                title="IFG (14)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoltName" index="itemBoltName" 
                title="IFG (14)" width="100" sortable="true"
            />
            <!--Disc 15-->
            <sjg:gridColumn
                name="disc" index="disc" 
                title="QUO (15)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemDiscCode" index="itemDiscCode" 
                title="IFG (15)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemDiscName" index="itemDiscName" 
                title="IFG (15)" width="100" sortable="true"
            />
            <!--Plates 16-->
            <sjg:gridColumn
                name="plates" index="plates" 
                title="QUO (15)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemPlatesCode" index="itemPlatesCode" 
                title="IFG (15)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemPlatesName" index="itemPlatesName" 
                title="IFG (15)" width="100" sortable="true"
            />
            <!--Shaft 17-->
            <sjg:gridColumn
                name="shaft" index="shaft" 
                title="QUO (17)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemShaftCode" index="itemShaftCode" 
                title="IFG (17)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemShaftName" index="itemShaftName" 
                title="IFG (17)" width="100" sortable="true"
            />
            <!--Spring 18-->
            <sjg:gridColumn
                name="spring" index="spring" 
                title="QUO (18)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemSpringCode" index="itemSpringCode" 
                title="IFG (18)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSpringName" index="itemSpringName" 
                title="IFG (18)" width="100" sortable="true"
            />
            <!--ArmPin 19-->
            <sjg:gridColumn
                name="armPin" index="armPin" 
                title="QUO (19)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemArmPinCode" index="itemArmPinCode" 
                title="IFG (19)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmPinName" index="itemArmPinName" 
                title="IFG (19)" width="100" sortable="true"
            />
            <!--BackSeat 20-->
            <sjg:gridColumn
                name="backSeat" index="backSeat" 
                title="QUO (20)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemBackSeatCode" index="itemBackSeatCode" 
                title="IFG (20)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBackSeatName" index="itemBackSeatName" 
                title="IFG (20)" width="100" sortable="true"
            />
            <!--Arm 21-->
            <sjg:gridColumn
                name="arm" index="arm" 
                title="QUO (21)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemArmCode" index="itemArmCode" 
                title="IFG (21)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmName" index="itemArmName" 
                title="IFG (21)" width="100" sortable="true"
            />
            <!--HingePin 22-->
            <sjg:gridColumn
                name="hingePin" index="hingePin" 
                title="QUO (22)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemHingePinCode" index="itemHingePinCode" 
                title="IFG (22)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemHingePinName" index="itemHingePinName" 
                title="IFG (22)" width="100" sortable="true"
            />
            <!--StopPin 23-->
            <sjg:gridColumn
                name="stopPin" index="stopPin" 
                title="QUO (23)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemStopPinCode" index="itemStopPinCode" 
                title="IFG (23)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemStopPinName" index="itemStopPinName" 
                title="IFG (23)" width="100" sortable="true"
            />
            <!--Operator 99-->
            <sjg:gridColumn
                name="operator" index="operator" 
                title="QUO (99)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemOperatorCode" index="itemOperatorCode" 
                title="IFG (99)" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemOperatorName" index="itemOperatorName" 
                title="IFG (99)" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="note" index="note" title="Note" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" 
                width="150" align="right" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="unitPrice" index="unitPrice" key="unitPrice" title="Unit Price" 
                width="150" align="right" editable="false" edittype="text"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name="totalAmount" index="totalAmount" key="totalAmount" title="Total" 
                width="150" align="right" editable="false" edittype="text"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
        <table width="100%">
            <tr>
                <td width="200px">
                    <table>
                        <tr height="10px"><td></td></tr>
                        <tr>
                            <td colspan="2">
                                <sjg:grid
                                    id="customerPurchaseOrderAdditionalFee_grid"
                                    caption="Additional"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listCustomerPurchaseOrderAdditionalFee"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="800"
                                >
                                    <sjg:gridColumn
                                        name="remark" index="remark" key="remark" 
                                        title="Remark" width="150" sortable="true" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name="quantity" index="quantity" key="quantity" title="Quantity" 
                                        width="80" align="right" edittype="text" 
                                        formatter="number" editrules="{ double: true }"
                                    />
                                    <sjg:gridColumn
                                        name = "unitOfMeasureCode" index = "unitOfMeasureCode" key = "unitOfMeasureCode" 
                                        title = "Unit" width = "80" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "additionalFeeCode" index = "additionalFeeCode" key = "additionalFeeCode" 
                                        title = "Additional Fee" width = "80" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "additionalFeeName" index = "additionalFeeName" key = "additionalFeeName" 
                                        title = "Additional Fee Name" width = "80" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "coaCode" index = "coaCode" key = "coaCode" 
                                        title = "Chart Of Account" width = "80" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "coaName" index = "coaName" key = "coaName" 
                                        title = "Chart Of Account Name" width = "80" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name="price" index="price" key="price" title="Price" 
                                        width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                                        formatter="number" editrules="{ double: true }"
                                    />
                                    <sjg:gridColumn
                                        name="total" index="total" key="total" title="Total" 
                                        width="150" align="right" editable="false" edittype="text"
                                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                                    />
                                </sjg:grid >
                            </td>
                        </tr>
                    </table>
                </td>
                <td align="right" valign="top">
                    <table width="100%">
                        <tr>
                            <td width="145px" align="right"><B>Total Transaction</B></td>
                            <td width="100px">
                                <s:textfield id="customerPurchaseOrderTotalTransactionAmount" name="customerPurchaseOrderTotalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Disc</B>
                                <s:textfield id="customerPurchaseOrderDiscountPercent" name="customerPurchaseOrderDiscountPercent" size="5" readonly="true" cssStyle="text-align:right" placeHolder="0.00"></s:textfield>%
                            </td>
                            <td>
                            <s:textfield id="customerPurchaseOrderDiscountAmount" name="customerPurchaseOrderDiscountAmount" readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Total Additional</B></td>
                            <td>
                            <s:textfield id="customerPurchaseOrderTotalAdditionalFeeAmount" name="customerPurchaseOrderTotalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Sub Total (Tax Base)</td>
                            <td>
                                <s:textfield id="customerPurchaseOrderSubTotalAmount" name="customerPurchaseOrderSubTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                            <s:textfield id="customerPurchaseOrderVatPercent" name="customerPurchaseOrderVatPercent" readonly="true" size="5" cssStyle="text-align:right" placeHolder="0.00"></s:textfield>%
                            </td>
                            <td>
                                <s:textfield id="customerPurchaseOrderVatAmount" name="customerPurchaseOrderVatAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="customerPurchaseOrderGrandTotalAmount" name="customerPurchaseOrderGrandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                    </table>         
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table>
            <tr>
                <td width="200px" valign="top">
                    <sjg:grid
                        id="customerPurchaseOrderPaymentTerm_grid"
                        caption="Payment Term"
                        dataType="json"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listCustomerPurchaseOrderPaymentTerm" 
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        width="800"
                    >
                        <sjg:gridColumn
                            name="sortNo" index="sortNo" key="sortNo" title="Term No" 
                            width="80" align="right" edittype="text" 
                            formatter="number" editrules="{ double: true }" hidden="true"
                        />
                        <sjg:gridColumn
                            name="customerSortNo" index="customerSortNo" key="customerSortNo" title="Term No" 
                            width="80" align="right" edittype="text" 
                            formatter="number" editrules="{ double: true }" hidden="true"
                        />
                        <sjg:gridColumn
                            name="paymentTermCode" index="paymentTermCode" 
                            title="Payment Term" width="200" sortable="true" edittype="text" 
                        />
                        <sjg:gridColumn
                            name="percentage" index="percentage" key="percentage" title="Percent" 
                            width="80" align="right" edittype="text" 
                            formatter="number" editrules="{ double: true }"
                        />
                        <sjg:gridColumn
                            name="remark" index="remark"
                            title="Note" width="150" sortable="true" editable="true"
                        />
                    </sjg:grid >
                </td>       
           </tr>
        </table>
    </div>
    <div>
        <table>
            <tr>
                <td valign="top">
                                <sjg:grid
                                    id="customerPurchaseOrderItemDeliveryDate_grid"
                                    caption="Item Delivery Date"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listCustomerPurchaseOrderItemDeliveryDate" 
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="800"
                                >
                                    <sjg:gridColumn
                                        name="itemFinishGoodsCode" index="itemFinishGoodsCode" key="itemFinishGoodsCode" 
                                        title="Item Code" width="150" sortable="true" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name="quantity" index="quantity" key="quantity" title="Quantity" 
                                        width="80" align="right" editable="true" edittype="text" 
                                        formatter="number" editrules="{ double: true }"
                                    />
                                    <sjg:gridColumn
                                        name="deliveryDate" index="deliveryDate" key="deliveryDate" 
                                        title="Delivery Date" width="130" formatter="date"  
                                        formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
                                    />
                                    <sjg:gridColumn
                                        name="salesQuotationCode" index="salesQuotationCode" key="salesQuotationCode" 
                                        title="Quatation No" width="150" sortable="true" editable="true"
                                    />
                                </sjg:grid >
                            </td>
            </tr>
        </table>
    </div>
                            
    
    <br class="spacer" />
    <br class="spacer" />
    

