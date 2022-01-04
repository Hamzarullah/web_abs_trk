
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #salesOrderClosingSalesQuotation_grid_pager_center,#salesOrderClosingItemDetail_grid_pager_center,
    #salesOrderClosingAdditionalFee_grid_pager_center,#salesOrderClosingPaymentTerm_grid_pager_center,#salesOrderClosingItemDeliveryDate_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
    function loadGridItemDetail(){
        //function groupingHeader
           $("#salesOrderClosingItemDetail_grid").jqGrid('setGroupHeaders', {
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
               
        $('#salesOrderClosingSearchClosingStatusRadOPEN').prop('checked',true);
            $("#salesOrderClosing\\.closingStatus").val("OPEN");
        $('input[name="salesOrderClosingSearchClosingStatusRad"][value="OPEN"]').change(function(ev){
            $("#salesOrderClosing\\.closingStatus").val("OPEN");
        });
        $('input[name="salesOrderClosingSearchClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#salesOrderClosing\\.closingStatus").val("CLOSED");
        });
        $('input[name="salesOrderClosingSearchClosingStatusRad"][value="ALL"]').change(function(ev){
            $("#salesOrderClosing\\.closingStatus").val("");
        });       
               
        $.subscribe("salesOrderClosing_grid_onSelect", function(event, data){
            var selectedRowID = $("#salesOrderClosing_grid").jqGrid("getGridParam", "selrow"); 
            var salesOrderClosing = $("#salesOrderClosing_grid").jqGrid("getRowData", selectedRowID);
            
            $("#salesOrderClosingItemDetail_grid").jqGrid('destroyGroupHeader');
            $("#salesOrderClosingSalesQuotation_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-sales-quotation-data?salesOrder.code="+ salesOrderClosing.code});
            $("#salesOrderClosingSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
            $("#salesOrderClosingSalesQuotation_grid").trigger("reloadGrid");
            
            $("#salesOrderClosingItemDetail_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-item-detail-data?salesOrder.code="+ salesOrderClosing.code});
            $("#salesOrderClosingItemDetail_grid").jqGrid("setCaption", "Item");
            $("#salesOrderClosingItemDetail_grid").trigger("reloadGrid");
            loadGridItemDetail();
            
            $("#salesOrderClosingAdditionalFee_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-additional-fee-data?salesOrder.code="+ salesOrderClosing.code});
            $("#salesOrderClosingAdditionalFee_grid").jqGrid("setCaption", "Additional");
            $("#salesOrderClosingAdditionalFee_grid").trigger("reloadGrid");
            
            $("#salesOrderClosingPaymentTerm_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-payment-term-data?salesOrder.code="+ salesOrderClosing.code});
            $("#salesOrderClosingPaymentTerm_grid").jqGrid("setCaption", "Payment Term");
            $("#salesOrderClosingPaymentTerm_grid").trigger("reloadGrid");
            
            $("#salesOrderClosingItemDeliveryDate_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-item-delivery-data?salesOrder.code="+ salesOrderClosing.code});
            $("#salesOrderClosingItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#salesOrderClosingItemDeliveryDate_grid").trigger("reloadGrid");
            
            
            $("#salesOrderClosingTotalTransactionAmount").val(formatNumber(parseFloat(salesOrderClosing.totalTransactionAmount),2));
            $("#salesOrderClosingDiscountPercent").val(formatNumber(parseFloat(salesOrderClosing.discountPercent),2));
            $("#salesOrderClosingDiscountAmount").val(formatNumber(parseFloat(salesOrderClosing.discountAmount),2));
            $("#salesOrderClosingTotalAdditionalFeeAmount").val(formatNumber(parseFloat(salesOrderClosing.totalAdditionalFeeAmount),2));
            $("#salesOrderClosingSubTotalAmount").val(formatNumber(parseFloat(salesOrderClosing.taxBaseAmount),2));
            $("#salesOrderClosingVatPercent").val(formatNumber(parseFloat(salesOrderClosing.vatPercent),2));
            $("#salesOrderClosingVatAmount").val(formatNumber(parseFloat(salesOrderClosing.vatAmount),2));
            $("#salesOrderClosingGrandTotalAmount").val(formatNumber(parseFloat(salesOrderClosing.grandTotalAmount),2));
            
        });
        
        $('#btnSalesOrderClosing').click(function(ev) {
            var selectedRowId = $("#salesOrderClosing_grid").jqGrid('getGridParam','selrow');
            var salesOrderClosing = $("#salesOrderClosing_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            if(salesOrderClosing.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            var url = "sales/customer-sales-order-closing-input";
            let params = "salesOrderClosing.code=" + salesOrderClosing.code;
                pageLoad(url, params, "#tabmnuSALES_ORDER_CLOSING");
        });

        $('#btnSalesOrderClosingRefresh').click(function(ev) {
            var url = "sales/customer-sales-order-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_ORDER_CLOSING");
            ev.preventDefault();   
        });
        
        
        $('#btnSalesOrderClosing_search').click(function(ev) {
            formatDateSOClosing();
            reloadTotalSOClosing();
            $("#salesOrderClosing_grid").jqGrid("clearGridData");
            $("#salesOrderClosing_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-closing-data?" + $("#frmSalesOrderClosingSearchInput").serialize()});
            $("#salesOrderClosing_grid").trigger("reloadGrid");
            
            $("#salesOrderClosingSalesQuotation_grid").jqGrid("clearGridData");
            $("#salesOrderClosingSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
            
            $("#salesOrderClosingItemDetail_grid").jqGrid("clearGridData");
            $("#salesOrderClosingItemDetail_grid").jqGrid("setCaption", "Item");
            
            $("#salesOrderClosingAdditionalFee_grid").jqGrid("clearGridData");
            $("#salesOrderClosingAdditionalFee_grid").jqGrid("setCaption", "Additional");
            
            $("#salesOrderClosingPaymentTerm_grid").jqGrid("clearGridData");
            $("#salesOrderClosingPaymentTerm_grid").jqGrid("setCaption", "Payment Term");
            
            $("#salesOrderClosingItemDeliveryDate_grid").jqGrid("clearGridData");
            $("#salesOrderClosingItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDateSOClosing();
            ev.preventDefault();
           
        });
        
        $("#btnSalesOrderClosingPrint").click(function(ev) {
            var selectRowId = $("#salesOrderClosing_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            else{
            var salesOrderClosing = $("#salesOrderClosing_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/sales/sales-order-print-out-pdf?";
            var params ="code=" + salesOrderClosing.code;
        
            window.open(url+params,'salesOrderClosing','width=500,height=500');}
            ev.preventDefault();
        });
    });//EOF Ready
    
    function formatDateSOClosing(){
        var firstDate=$("#salesOrderClosing\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#salesOrderClosing\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#salesOrderClosing\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#salesOrderClosing\\.transactionLastDate").val(lastDateValue);
        
    }
    
    function reloadGridSOClosing() {
        $("#salesOrderClosing_grid").trigger("reloadGrid");
    };
    
    function reloadDetailGridSOClosing() {
        $("#salesOrderClosingSalesQuotation_grid").trigger("reloadGrid");  
        $("#salesOrderClosingSalesQuotation_grid").jqGrid("clearGridData");
        $("#salesOrderClosingSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
        
        $("#salesOrderClosingItemDetail_grid").trigger("reloadGrid");  
        $("#salesOrderClosingItemDetail_grid").jqGrid("clearGridData");
        $("#salesOrderClosingItemDetail_grid").jqGrid("setCaption", "Item");
        
        $("#salesOrderClosingAdditionalFee_grid").trigger("reloadGrid");  
        $("#salesOrderClosingAdditionalFee_grid").jqGrid("clearGridData");
        $("#salesOrderClosingAdditionalFee_grid").jqGrid("setCaption", "Additional");
        
        $("#salesOrderClosingPaymentTerm_grid").trigger("reloadGrid");  
        $("#salesOrderClosingPaymentTerm_grid").jqGrid("clearGridData");
        $("#salesOrderClosingPaymentTerm_grid").jqGrid("setCaption", "Payment Term");
        
        $("#salesOrderClosingItemDeliveryDate_grid").trigger("reloadGrid");  
        $("#salesOrderClosingItemDeliveryDate_grid").jqGrid("clearGridData");
        $("#salesOrderClosingItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
    };
    
    function reloadTotalSOClosing(){
        $("#salesOrderClosingTotalTransactionAmount").val("0.00");
        $("#salesOrderClosingDiscountPercent").val("0.00");
        $("#salesOrderClosingDiscountAmount").val("0.00");
        $("#salesOrderClosingTotalAdditionalFeeAmount").val("0.00");
        $("#salesOrderClosingSubTotalAmount").val("0.00");
        $("#salesOrderClosingVatPercent").val("0.00");
        $("#salesOrderClosingVatAmount").val("0.00");
        $("#salesOrderClosingGrandTotalAmount").val("0.00");
    }
</script>
<s:url id="remoteurlSalesOrderClosing" action="customer-sales-order-closing-data" />    
    <b>SALES ORDER CLOSING</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="salesOrderClosingButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnSalesOrderClosing" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Revise"/><br/>Closing</a>
        <a href="#" id="btnSalesOrderClosingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>        
        <a href="#" id="btnSalesOrderClosingPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="SalesOrderClosingInputSearch" class="content ui-widget">
        <s:form id="frmSalesOrderClosingSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="salesOrderClosing.transactionFirstDate" name="salesOrderClosing.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="salesOrderClosing.transactionLastDate" name="salesOrderClosing.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">SOD-Closing No</td>
                    <td>
                        <s:textfield id="salesOrderClosing.code" name="salesOrderClosing.code" size="25"></s:textfield>
                    </td>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="salesOrderClosing.customerCode" name="salesOrderClosing.customerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="salesOrderClosing.customerName" name="salesOrderClosing.customerName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="salesOrderClosing.refNo" name="salesOrderClosing.refNo" size="25"></s:textfield>
                    </td>
                    <td align="right">Sales Person</td>
                    <td>    
                        <s:textfield id="salesOrderClosing.salesPersonCode" name="salesOrderClosing.salesPersonCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="salesOrderClosing.salesPersonName" name="salesOrderClosing.salesPersonName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="salesOrderClosing.remark" name="salesOrderClosing.remark" size="25"></s:textfield>
                    </td>
                    <td align="right">Closing Status</td>
                    <td>
                        <s:radio id="salesOrderClosingSearchClosingStatusRad" name="salesOrderClosingSearchClosingStatusRad" label="salesOrderClosingSearchClosingStatusRad" list="{'ALL','OPEN','CLOSED'}"></s:radio>
                        <s:textfield id="salesOrderClosing.closingStatus" name="salesOrderClosing.closingStatus" size="20" style="display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnSalesOrderClosing_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
    <div>
        <sjg:grid
            id="salesOrderClosing_grid"
            caption="Customer Purchase Order"
            dataType="json"   
            href="%{remoteurlSalesOrderClosing}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerSalesOrder"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuSALES_ORDER_CLOSING').width()"
            onSelectRowTopics="salesOrderClosing_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="SOD-CPO No" width="160" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="revision" index="revision" 
                title="Revision" width="120" sortable="true" edittype="text" 
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
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="custSONo" index="custSONo" 
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
            id="salesOrderClosingSalesQuotation_grid"
            caption="Sales Quotation"
            dataType="json"   
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerSalesOrderSalesQuotation"
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
            id="salesOrderClosingItemDetail_grid"
            caption="Item"
            dataType="json"     
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerSalesOrderItemDetail"
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
                                    id="salesOrderClosingAdditionalFee_grid"
                                    caption="Additional"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listCustomerSalesOrderAdditionalFee"
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
                                <s:textfield id="salesOrderClosingTotalTransactionAmount" name="salesOrderClosingTotalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Disc</B>
                                <s:textfield id="salesOrderClosingDiscountPercent" name="salesOrderClosingDiscountPercent" size="5" readonly="true" cssStyle="text-align:right" placeHolder="0.00"></s:textfield>%
                            </td>
                            <td>
                            <s:textfield id="salesOrderClosingDiscountAmount" name="salesOrderClosingDiscountAmount" readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Total Additional</B></td>
                            <td>
                            <s:textfield id="salesOrderClosingTotalAdditionalFeeAmount" name="salesOrderClosingTotalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Sub Total (Tax Base)</td>
                            <td>
                                <s:textfield id="salesOrderClosingSubTotalAmount" name="salesOrderClosingSubTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                            <s:textfield id="salesOrderClosingVatPercent" name="salesOrderClosingVatPercent" readonly="true" size="5" cssStyle="text-align:right" placeHolder="0.00"></s:textfield>%
                            </td>
                            <td>
                                <s:textfield id="salesOrderClosingVatAmount" name="salesOrderClosingVatAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="salesOrderClosingGrandTotalAmount" name="salesOrderClosingGrandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
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
                        id="salesOrderClosingPaymentTerm_grid"
                        caption="Payment Term"
                        dataType="json"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listCustomerSalesOrderPaymentTerm"
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
                                    id="salesOrderClosingItemDeliveryDate_grid"
                                    caption="Item Delivery Date"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listCustomerSalesOrderItemDeliveryDate"
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
    

