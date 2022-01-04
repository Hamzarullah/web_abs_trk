
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("salesOrderUnprice_grid_onSelect", function(event, data){
            var selectedRowID = $("#salesOrderUnprice_grid").jqGrid("getGridParam", "selrow"); 
            var salesOrderUnprice = $("#salesOrderUnprice_grid").jqGrid("getRowData", selectedRowID);
            
            $("#salesOrderUnpriceSalesQuotation_grid").jqGrid("setGridParam",{url:"sales/sales-order-by-customer-purchase-order-sales-quotation-data?salesOrderUnprice.code="+ salesOrderUnprice.code});
            $("#salesOrderUnpriceSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
            $("#salesOrderUnpriceSalesQuotation_grid").trigger("reloadGrid");
            
            $("#salesOrderUnpriceItemDetail_grid").jqGrid("setGridParam",{url:"sales/sales-order-by-customer-purchase-order-item-detail-data?salesOrderUnprice.code="+ salesOrderUnprice.code});
            $("#salesOrderUnpriceItemDetail_grid").jqGrid("setCaption", "Item");
            $("#salesOrderUnpriceItemDetail_grid").trigger("reloadGrid");
            
            $("#salesOrderUnpriceAdditionalFee_grid").jqGrid("setGridParam",{url:"sales/sales-order-by-customer-purchase-order-additional-fee-data?salesOrderUnprice.code="+ salesOrderUnprice.code});
            $("#salesOrderUnpriceAdditionalFee_grid").jqGrid("setCaption", "Additional");
            $("#salesOrderUnpriceAdditionalFee_grid").trigger("reloadGrid");
            
            $("#salesOrderUnpricePaymentTerm_grid").jqGrid("setGridParam",{url:"sales/sales-order-by-customer-purchase-order-payment-term-data?salesOrderUnprice.code="+ salesOrderUnprice.code});
            $("#salesOrderUnpricePaymentTerm_grid").jqGrid("setCaption", "Payment Term");
            $("#salesOrderUnpricePaymentTerm_grid").trigger("reloadGrid");
            
            $("#salesOrderUnpriceItemDeliveryDate_grid").jqGrid("setGridParam",{url:"sales/sales-order-by-customer-purchase-order-item-delivery-data?salesOrderUnprice.code="+ salesOrderUnprice.code});
            $("#salesOrderUnpriceItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#salesOrderUnpriceItemDeliveryDate_grid").trigger("reloadGrid");
            
            
            $("#salesOrderUnpriceTotalTransactionAmount").val(formatNumber(parseFloat(salesOrderUnprice.totalTransactionAmount),2));
            $("#salesOrderUnpriceDiscountPercent").val(formatNumber(parseFloat(salesOrderUnprice.discountPercent),2));
            $("#salesOrderUnpriceDiscountAmount").val(formatNumber(parseFloat(salesOrderUnprice.discountAmount),2));
            $("#salesOrderUnpriceTotalAdditionalFeeAmount").val(formatNumber(parseFloat(salesOrderUnprice.totalAdditionalFeeAmount),2));
            $("#salesOrderUnpriceSubTotalAmount").val(formatNumber(parseFloat(salesOrderUnprice.taxBaseAmount),2));
            $("#salesOrderUnpriceVatPercent").val(formatNumber(parseFloat(salesOrderUnprice.vatPercent),2));
            $("#salesOrderUnpriceVatAmount").val(formatNumber(parseFloat(salesOrderUnprice.vatAmount),2));
            $("#salesOrderUnpriceGrandTotalAmount").val(formatNumber(parseFloat(salesOrderUnprice.grandTotalAmount),2));
            
        });
        
        $('#btnSalesOrderUnpriceUpdate').click(function(ev) {
            var selectedRowId = $("#salesOrderUnprice_grid").jqGrid('getGridParam','selrow');
            var salesOrderUnprice = $("#salesOrderUnprice_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/sales-order-input";
            var params = "enumSalesOrderUnpriceActivity=UPDATE";
                params+="&salesOrderUnprice.code=" + salesOrderUnprice.code;
                pageLoad(url, params, "#tabmnuSALES_ORDER_UNPRICE");
        });
        
        $('#btnSalesOrderUnpriceClone').click(function(ev) {
            var selectedRowId = $("#salesOrderUnprice_grid").jqGrid('getGridParam','selrow');
            var salesOrderUnprice = $("#salesOrderUnprice_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/sales/sales-order-input";
            var params = "enumSalesOrderUnpriceActivity=CLONE";
                params+="&salesOrderUnprice.code=" + salesOrderUnprice.code;
                pageLoad(url, params, "#tabmnuSALES_ORDER_UNPRICE");
        });
        
        $('#btnSalesOrderUnpriceDelete').click(function(ev) {
            
            var deleteRowId = $("#salesOrderUnprice_grid").jqGrid('getGridParam','selrow');
            var salesOrderUnprice = $("#salesOrderUnprice_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>SOD-BOD No: '+salesOrderUnprice.custBONo+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title        : "Confirmation!",
                closeOnEscape: false,
                modal        : true,
                width        : 300,
                resizable    : false,
                buttons      : 
                            [{
                                text : "Yes",
                                click : function() {
                                    var url = "sales/sales-order-delete";
                                    var params = "salesOrderUnprice.code=" + salesOrderUnprice.code;
                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridSOUnprice();
                                        reloadDetailGridSOUnprice();
                                        reloadTotalSOUnprice();
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

        $('#btnSalesOrderUnpriceRefresh').click(function(ev) {
            var url = "sales/sales-order-unprice";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_ORDER_UNPRICE");
            ev.preventDefault();   
        });
        
        
        $('#btnSalesOrderUnprice_search').click(function(ev) {
            formatDateSOUnprice();
            reloadTotalSOUnprice();
            $("#salesOrderUnprice_grid").jqGrid("clearGridData");
            $("#salesOrderUnprice_grid").jqGrid("setGridParam",{url:"sales/sales-order-unprice-data?" + $("#frmSalesOrderUnpriceSearchInput").serialize()});
            $("#salesOrderUnprice_grid").trigger("reloadGrid");
            
            $("#salesOrderUnpriceSalesQuotation_grid").jqGrid("clearGridData");
            $("#salesOrderUnpriceSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
            
            $("#salesOrderUnpriceItemDetail_grid").jqGrid("clearGridData");
            $("#salesOrderUnpriceItemDetail_grid").jqGrid("setCaption", "Item");
            
            $("#salesOrderUnpriceAdditionalFee_grid").jqGrid("clearGridData");
            $("#salesOrderUnpriceAdditionalFee_grid").jqGrid("setCaption", "Additional");
            
            $("#salesOrderUnpricePaymentTerm_grid").jqGrid("clearGridData");
            $("#salesOrderUnpricePaymentTerm_grid").jqGrid("setCaption", "Payment Term");
            
            $("#salesOrderUnpriceItemDeliveryDate_grid").jqGrid("clearGridData");
            $("#salesOrderUnpriceItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDateSOUnprice();
            ev.preventDefault();
           
        });
        $("#btnSalesOrderUnpricePrint").click(function(ev) {
            var selectRowId = $("#salesOrderUnprice_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            else{
            var salesOrderUnprice = $("#salesOrderUnprice_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/sales/sales-order-print-out-pdf?";
            var params ="code=" + salesOrderUnprice.code;
        
            window.open(url+params,'salesOrderUnprice','width=500,height=500');}
            ev.preventDefault();
        });
    });//EOF Ready
    
    function formatDateSOUnprice(){
        var firstDate=$("#salesOrderUnprice\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#salesOrderUnprice\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#salesOrderUnprice\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#salesOrderUnprice\\.transactionLastDate").val(lastDateValue);
        
    }
    
    function reloadGridSOUnprice() {
        $("#salesOrderUnprice_grid").trigger("reloadGrid");
    };
    
    function reloadDetailGridSOUnprice() {
        $("#salesOrderUnpriceSalesQuotation_grid").trigger("reloadGrid");  
        $("#salesOrderUnpriceSalesQuotation_grid").jqGrid("clearGridData");
        $("#salesOrderUnpriceSalesQuotation_grid").jqGrid("setCaption", "Sales Quotation");
        
        $("#salesOrderUnpriceItemDetail_grid").trigger("reloadGrid");  
        $("#salesOrderUnpriceItemDetail_grid").jqGrid("clearGridData");
        $("#salesOrderUnpriceItemDetail_grid").jqGrid("setCaption", "Item");
        
        $("#salesOrderUnpriceAdditionalFee_grid").trigger("reloadGrid");  
        $("#salesOrderUnpriceAdditionalFee_grid").jqGrid("clearGridData");
        $("#salesOrderUnpriceAdditionalFee_grid").jqGrid("setCaption", "Additional");
        
        $("#salesOrderUnpricePaymentTerm_grid").trigger("reloadGrid");  
        $("#salesOrderUnpricePaymentTerm_grid").jqGrid("clearGridData");
        $("#salesOrderUnpricePaymentTerm_grid").jqGrid("setCaption", "Payment Term");
        
        $("#salesOrderUnpriceItemDeliveryDate_grid").trigger("reloadGrid");  
        $("#salesOrderUnpriceItemDeliveryDate_grid").jqGrid("clearGridData");
        $("#salesOrderUnpriceItemDeliveryDate_grid").jqGrid("setCaption", "Item Delivery Date");
    };
    
    function reloadTotalSOUnprice(){
        $("#salesOrderUnpriceTotalTransactionAmount").val("0.00");
        $("#salesOrderUnpriceDiscountPercent").val("0.00");
        $("#salesOrderUnpriceDiscountAmount").val("0.00");
        $("#salesOrderUnpriceTotalAdditionalFeeAmount").val("0.00");
        $("#salesOrderUnpriceSubTotalAmount").val("0.00");
        $("#salesOrderUnpriceVatPercent").val("0.00");
        $("#salesOrderUnpriceVatAmount").val("0.00");
        $("#salesOrderUnpriceGrandTotalAmount").val("0.00");
    }
</script>
<s:url id="remoteurlSalesOrderUnprice" action="sales-order-unprice-data" />    
    <b>Sales Order UnPrice</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="salesOrderUnpriceButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnSalesOrderUnpriceRefresh" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>        
        <a href="#" id="btnSalesOrderUnpricePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="SalesOrderUnpriceInputSearch" class="content ui-widget">
        <s:form id="frmSalesOrderUnpriceSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="salesOrderUnprice.transactionFirstDate" name="salesOrderUnprice.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="salesOrderUnprice.transactionLastDate" name="salesOrderUnprice.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="salesOrderUnprice.code" name="salesOrderUnprice.code" size="25"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="salesOrderUnprice.refNo" name="salesOrderUnprice.refNo" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="salesOrderUnprice.customerCode" name="salesOrderUnprice.customerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="salesOrderUnprice.customerName" name="salesOrderUnprice.customerName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="salesOrderUnprice.remark" name="salesOrderUnprice.remark" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnSalesOrderUnprice_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
    <div>
        <sjg:grid
            id="salesOrderUnprice_grid"
            caption="Sales Order UnPrice"
            dataType="json"   
            href="%{remoteurlSalesOrderUnprice}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesOrderUnprice"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnusalesorderunprice').width()"
            onSelectRowTopics="salesOrderUnprice_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="Code" sortable="true" edittype="text" width="220"
            />     
            <sjg:gridColumn
                name="custSONo" index="custSONo" 
                title="BOD No" width="120" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" 
                title="Branch Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" 
                title="Branch Name" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" 
                title="Customer Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" 
                title="Customer Name" width="200" sortable="true"
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
                title="Project" width="100" sortable="true"
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
                name="vatAmount" index="vatAmount" key="vatPercent" 
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
            id="salesOrderUnpriceSalesQuotation_grid"
            caption="Sales Quotation"
            dataType="json"   
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesOrderUnpriceSalesQuotation"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnusalesorderbycustomerpurchaseorder').width()"
        >
            <sjg:gridColumn
                name="salesQuotationCode" index="salesQuotationCode" 
                title="SLS-QUO No" width="200" sortable="true" edittype="text" 
            />     
            <sjg:gridColumn
                name="salesQuotationTransactionDate" index="salesQuotationTransactionDate" key="salesQuotationTransactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="salesQuotationCustomerCode" index="salesQuotationCustomerCode" 
                title="Customer Code" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="salesQuotationCustomerName" index="salesQuotationCustomerName" 
                title="Customer Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name = "salesQuotationRfqNo" index = "salesQuotationRfqNo" key = "salesQuotationRfqNo" 
                title = "RFQ No" width = "80" edittype="text" 
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
            id="salesOrderUnpriceItemDetail_grid"
            caption="Item"
            dataType="json"     
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesOrderUnpriceItemDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#id-tbl-sod-poc-additional-payment-item-delivery').width()"
        >
            <sjg:gridColumn
                name="salesQuotationCode" index="salesQuotationCode" key="salesQuotationCode" 
                title="Quotation No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="customerPurchaseOrderSortNo" index="customerPurchaseOrderSortNo" 
                title="Sort No" width="80" sortable="true" edittype="text"
            />
            <sjg:gridColumn
                name="itemCode" index="itemCode" 
                title="Item" width="100" sortable="true" edittype="text" 
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
            <sjg:gridColumn
                name="type" index="type" title="Type" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="size" index="size" key="size" title="Size" 
                width="80" edittype="text" 
            />
            <sjg:gridColumn
                name="rating" index="rating" key="rating" title="Rating" 
                width="80" edittype="text" 
            />
            <sjg:gridColumn
                name="endCon" index="endCon" title="End Con" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="body" index="body" title="Body" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="ball" index="ball" title="Ball" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="seat" index="seat" title="Seat" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="stem" index="stem" title="Steam" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="seatInsert" index="seatInsert" title="Seat Insert" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="seal" index="seal" title="Seal" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="bolting" index="bolting" title="Bolting" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="seatDesign" index="seatDesign" title="Seat Design" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="oper" index="oper" title="Operator" width="100" sortable="true"
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
                                    id="salesOrderUnpriceAdditionalFee_grid"
                                    caption="Additional"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listSalesOrderUnpriceAdditionalFee"
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
                                        name="price" index="price" key="price" title="Amount" 
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
                        <tr height="10px"><td></td></tr>
                        <tr>
                            <td width="200px" valign="top">
                                <sjg:grid
                                    id="salesOrderUnpricePaymentTerm_grid"
                                    caption="Payment Term"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listSalesOrderUnpricePaymentTerm"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="540"
                                >
                                    <sjg:gridColumn
                                        name="sortNo" index="sortNo" key="sortNo" title="Term No" 
                                        width="80" align="right" edittype="text" 
                                        formatter="number" editrules="{ double: true }"
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
                            <td valign="top">
                                <sjg:grid
                                    id="salesOrderUnpriceItemDeliveryDate_grid"
                                    caption="Item Delivery Date"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listSalesOrderUnpriceItemDeliveryDate"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="540"
                                >
                                    <sjg:gridColumn
                                        name="itemCode" index="itemCode" key="itemCode" 
                                        title="ItemCode" width="150" sortable="true" editable="true"
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
                </td>
                <td align="right" valign="top">
                    <table width="100%">
                        <tr>
                            <td width="145px" align="right"><B>Total Transaction</B></td>
                            <td width="100px">
                                <s:textfield id="salesOrderUnpriceTotalTransactionAmount" name="salesOrderUnpriceTotalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Disc</B>
                                <s:textfield id="salesOrderUnpriceDiscountPercent" name="salesOrderUnpriceDiscountPercent" size="5" readonly="true" cssStyle="text-align:right" placeHolder="0.00"></s:textfield>%
                            </td>
                            <td>
                            <s:textfield id="salesOrderUnpriceDiscountAmount" name="salesOrderUnpriceDiscountAmount" readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Total Additional</B></td>
                            <td>
                            <s:textfield id="salesOrderUnpriceTotalAdditionalFeeAmount" name="salesOrderUnpriceTotalAdditionalFeeAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Sub Total (Tax Base)</td>
                            <td>
                                <s:textfield id="salesOrderUnpriceSubTotalAmount" name="salesOrderUnpriceSubTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>VAT</B>
                            <s:textfield id="salesOrderUnpriceVatPercent" name="salesOrderUnpriceVatPercent" readonly="true" size="5" cssStyle="text-align:right" placeHolder="0.00"></s:textfield>%
                            </td>
                            <td>
                                <s:textfield id="salesOrderUnpriceVatAmount" name="salesOrderUnpriceVatAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Grand Total</B></td>
                            <td>
                                <s:textfield id="salesOrderUnpriceGrandTotalAmount" name="salesOrderUnpriceGrandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25" placeHolder="0.00"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    
    <br class="spacer" />
    <br class="spacer" />
    

