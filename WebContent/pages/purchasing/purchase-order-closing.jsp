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
    #purchaseOrderClosingDetail_grid_pager_center{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
    
    var purchaseOrderClosingViewPRNonIMRRowId = 0;
    
    $(document).ready(function(){
        hoverButton();
        var arrPurchaseOrderNo=new Array();
        
        $.subscribe("purchaseOrderClosing_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseOrderClosingHeader_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseOrderClosing = $("#purchaseOrderClosingHeader_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-purchase-request-data?purchaseOrder.code="+ purchaseOrderClosing.code});
            $("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid("setCaption", "");
            $("#purchaseOrderClosingPurchaseRequestDetail_grid").trigger("reloadGrid");
            
            jQuery("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid('setGridParam', { gridComplete: function(){    
                var idss = jQuery("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid('getDataIDs');
                for(var i=0; i<idss.length; i++){
                    var data = $("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid('getRowData',idss[i]);
                    arrPurchaseOrderNo.push(data.purchaseRequestCode);
                }
                $("#purchaseOrderClosingPurchaseRequestItemDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-item-material-request-detail-data?arrPurchaseOrderNo="+ arrPurchaseOrderNo});
                $("#purchaseOrderClosingPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
                $("#purchaseOrderClosingPurchaseRequestItemDetail_grid").trigger("reloadGrid");
            }});    
            
            $("#purchaseOrderClosingDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-detail-data?purchaseOrder.code="+ purchaseOrderClosing.code});
            $("#purchaseOrderClosingDetail_grid").jqGrid("setCaption", "Purchase Order Detail");
            $("#purchaseOrderClosingDetail_grid").trigger("reloadGrid");
            
            $("#purchaseOrderClosingAdditional_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-additional-fee-data?purchaseOrder.code="+ purchaseOrderClosing.code});
            $("#purchaseOrderClosingAdditional_grid").jqGrid("setCaption", "Additional");
            $("#purchaseOrderClosingAdditional_grid").trigger("reloadGrid");
            
            $("#purchaseOrderClosingItemDelivery_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-item-delivery-date-data?purchaseOrder.code="+ purchaseOrderClosing.code});
            $("#purchaseOrderClosingItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#purchaseOrderClosingItemDelivery_grid").trigger("reloadGrid");
            
            $("#purchaseOrderClosingTotalTransactionAmount").val(formatNumber(parseFloat(purchaseOrderClosing.totalTransactionAmount),2));
            $("#purchaseOrderClosingDiscountPercent").val(formatNumber(parseFloat(purchaseOrderClosing.discountPercent),2));
            $("#purchaseOrderClosingDiscountAmount").val(formatNumber(parseFloat(purchaseOrderClosing.discountAmount),2));
            $("#purchaseOrderClosingOtherFeeAmount").val(formatNumber(parseFloat(purchaseOrderClosing.otherFeeAmount),2));
            $("#purchaseOrderClosingTaxBaseSubTotalAmount").val(formatNumber(parseFloat(purchaseOrderClosing.taxBaseSubTotalAmount),2));
            $("#purchaseOrderClosingVATPercent").val(formatNumber(parseFloat(purchaseOrderClosing.vatPercent),2));
            $("#purchaseOrderClosingVATAmount").val(formatNumber(parseFloat(purchaseOrderClosing.vatAmount),2));
            $("#purchaseOrderClosingGrandTotalAmount").val(formatNumber(parseFloat(purchaseOrderClosing.grandTotalAmount),2));
            
            $("#purchaseOrderClosingDiscountChartOfAccountCode").val(purchaseOrderClosing.discountChartOfAccountCode);
            $("#purchaseOrderClosingDiscountChartOfAccountName").val(purchaseOrderClosing.discountChartOfAccountName);
            $("#purchaseOrderClosingDiscountDescription").val(purchaseOrderClosing.discountDescription);
            
            $("#purchaseOrderClosingOtherFeeChartOfAccountCode").val(purchaseOrderClosing.otherFeeChartOfAccountCode);
            $("#purchaseOrderClosingOtherFeeChartOfAccountName").val(purchaseOrderClosing.otherFeeChartOfAccountName);
            $("#purchaseOrderClosingOtherFeeDescription").val(purchaseOrderClosing.otherFeeDescription);
            
        });
        
        $("#btnPurchaseOrderClosed").click(function(ev) {
            var selectedRowId = $("#purchaseOrderClosingHeader_grid").jqGrid('getGridParam','selrow');
            var purchaseOrderClosing = $("#purchaseOrderClosingHeader_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
//            if(customerPurchaseOrderClosingRelease.closingStatus==="CLOSED"){
//                alertMessage("It Has Been Closed");
//                return;
//            }
            var url = "purchase/purchase-order-closing-input";
            var params = "enumPurchaseOrderClosingActivity=UPDATE";
                params+="&purchaseOrderClosing.code=" + purchaseOrderClosing.code;
                pageLoad(url, params, "#tabmnuPURCHASE_ORDER_CLOSING");

        }); 
        
        $("#btnPurchaseOrderClosingRefresh").click(function (ev) {
            var url = "purchasing/purchase-order-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER_CLOSING");
            ev.preventDefault();
        });
        
        $('#btnPurchaseOrderClosing_search').click(function(ev) {
            formatDatePOClosing();
            reloadTotalPOClosing();
            $("#purchaseOrderClosingHeader_grid").jqGrid("clearGridData");
            $("#purchaseOrderClosingHeader_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-approval-data?" + $("#frmPurchaseOrderClosingSearchInput").serialize()});
            $("#purchaseOrderClosingHeader_grid").trigger("reloadGrid");
            
            $("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderClosingPurchaseRequestDetail_grid").jqGrid("setCaption", "Purchase Request Detail");
            
            $("# purchaseOrderClosingPurchaseRequestItemDetail_grid").jqGrid("clearGridData");
            $("# purchaseOrderClosingPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail (IMR)");
            
            $("#purchaseOrderClosingDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderClosingDetail_grid").jqGrid("setCaption", "PO Detail");
            
            $("#purchaseOrderClosingAdditional_grid").jqGrid("clearGridData");
            $("#purchaseOrderClosingAdditional_grid").jqGrid("setCaption", "Additional Fee");
            
            $("#purchaseOrderClosingItemDelivery_grid").jqGrid("clearGridData");
            $("#purchaseOrderClosingItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDatePOClosing();
            ev.preventDefault();
           
        });
    });
        
    function formatDatePOClosing(){
        var firstDate=$("#purchaseOrderClosing\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseOrderClosing\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseOrderClosing\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseOrderClosing\\.transactionLastDate").val(lastDateValue); 
    }
     
    function reloadTotalPOClosing(){
        $("#purchaseOrderClosingTotalTransactionAmount").val("0.00");
        $("#purchaseOrderClosingDiscountPercent").val("0.00");
        $("#purchaseOrderClosingDiscountAmount").val("0.00");
        $("#purchaseOrderClosingTaxBaseSubTotalAmount").val("0.00");
        $("#purchaseOrderClosingVATPercent").val("0.00");
        $("#purchaseOrderClosingVATAmount").val("0.00");
        $("#purchaseOrderClosingOtherFeeAmount").val("0.00");
        $("#purchaseOrderClosingGrandTotalAmount").val("0.00");
    }
</script>

<s:url id="remoteurlPurchaseOrderClosing" action="purchase-order-approval-data" />
    <b>PURCHASE ORDER CLOSING</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseOrderClosingButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnPurchaseOrderClosingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="purchaseOrderClosingInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseOrderClosingSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseOrderClosing.transactionFirstDate" name="purchaseOrderClosing.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseOrderClosing.transactionLastDate" name="purchaseOrderClosing.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">POD No</td>
                    <td>
                        <s:textfield id="purchaseOrderClosing.code" name="purchaseOrderClosing.code" size="27" placeholder=" PO"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="purchaseOrderClosing.vendorCode" name="purchaseOrderClosing.vendorCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrderClosing.vendorName" name="purchaseOrderClosing.vendorName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="purchaseOrderClosing.refNo" name="purchaseOrderClosing.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Currency</td>
                    <td>
                        <s:textfield id="purchaseOrderClosing.currencyCode" name="purchaseOrderClosing.currencyCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrderClosing.currencyName" name="purchaseOrderClosing.currencyName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="purchaseOrderClosing.remark" name="purchaseOrderClosing.remark" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseOrderClosing_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
    
    <div>
        <sjg:grid
            id="purchaseOrderClosingHeader_grid"
            caption="Purchase Order"
            dataType="json"   
            href="%{remoteurlPurchaseOrderClosing}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseOrder"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="1000"
            onSelectRowTopics="purchaseOrderClosing_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="POD No" width="120" sortable="true" edittype="text"
            />  
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="deliveryDateStart" index="deliveryDateStart" key="deliveryDateStart" 
                title="Delivery Date Start" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="deliveryDateEnd" index="deliveryDateEnd" key="deliveryDateEnd" 
                title="Delivery Date End" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="vendorCode" index="vendorCode" 
                title="Vendor Code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="vendorName" index="vendorName" 
                title="Vendor Name" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" 
                title="Currency" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="grnNo" index="grnNo" 
                title="GRN No" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="discountChartOfAccountCode" index="discountChartOfAccountCode" key="discountChartOfAccountCode" 
                title="discountChartOfAccountCode" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="discountChartOfAccountName" index="discountChartOfAccountName" key="discountChartOfAccountName" 
                title="discountChartOfAccountName" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="discountDescription" index="discountDescription" key="discountDescription" 
                title="discountDescription" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="otherFeeChartOfAccountCode" index="otherFeeChartOfAccountCode" key="otherFeeChartOfAccountCode" 
                title="otherFeeChartOfAccountCode" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="otherFeeChartOfAccountName" index="otherFeeChartOfAccountName" key="otherFeeChartOfAccountName" 
                title="otherFeeChartOfAccountName" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="otherFeeDescription" index="otherFeeDescription" key="otherFeeDescription" 
                title="otherFeeDescription" width="150" sortable="true" hidden="true"
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
                name="otherFeeAmount" index="otherFeeAmount" key="otherFeeAmount" 
                title="otherFeeAmount" width="150" sortable="true" hidden="true" 
            />
            <sjg:gridColumn
                name="taxBaseSubTotalAmount" index="taxBaseSubTotalAmount" key="taxBaseSubTotalAmount" 
                title="taxBaseSubTotalAmount" width="150" sortable="true" hidden="true" 
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
    <sj:a href="#" id="btnPurchaseOrderClosed" button="true" style="width: 90px">Closing</sj:a>
    </div>
    
    <br class="spacer" />
    <div>
        <sjg:grid
            id="purchaseOrderClosingPurchaseRequestDetail_grid"
            dataType="json"   
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseOrderPurchaseRequestDetail"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="1100"
            onSelectRowTopics="purchaseOrderClosingPurchaseRequestDetail_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="PoJnPr" width="120" sortable="true" hidden="true"
            />  
            <sjg:gridColumn
                name="purchaseRequestCode" index="purchaseRequestCode" 
                title="PRQ No" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="purchaseRequestTransactionDate" index="purchaseRequestTransactionDate" key="purchaseRequestTransactionDate" 
                title="PRQ Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="purchaseRequestType" index="purchaseRequestType" 
                title="Document Type" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="ppoCode" index="ppoCode" 
                title="PPO No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="purchaseRequestRequestBy" index="purchaseRequestRequestBy" 
                title="Request By" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="purchaseRequestRemark" index="purchaseRequestRemark" 
                title="Remark" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="purchaseRequestRefNo" index="purchaseRequestRefNo" 
                title="Ref No" width="100" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
        <sjg:grid
            id="purchaseOrderClosingPurchaseRequestItemDetail_grid"
            caption="PRQ Item Detail (IMR)"
            dataType="json"   
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestNonItemMaterialRequestDetail"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="800"
        >
            <sjg:gridColumn
                name="headerCode" index="headerCode" 
                title="PRQ No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" 
                title="Item Material Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" 
                title="Item Material Name" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="quantity" index="quantity" 
                title="Quantity" width="100" sortable="true" formatter="number"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" 
                title="UOM" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="unitOfMeasureName" index="unitOfMeasureName" 
                title="UOM" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="poCode" index="poCode" 
                title="POD No" width="200" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
        <sjg:grid
            id="purchaseOrderClosingDetail_grid"
            caption="Purchase Order Detail"
            dataType="json"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseOrderDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            editinline="true"
            width="$('#tabmnupurchaseOrderClosingDetail').width()"
            editurl="%{remoteurlPurchaseOrderClosingDetailInput}"
            onSelectRowTopics="purchaseOrderClosingDetailInput_grid_onSelect"
        >                
            <sjg:gridColumn
                name="code" index="code" key="code" 
                title="POD Code " width="150" sortable="true" hidden="true"
            />                   
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" 
                title="Item Material Code " width="150" sortable="true" hidden="false"
            />                   
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" 
                title="Item Material Name" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="itemAlias" index="itemAlias" 
                title="Item Alias" width="100" sortable="true" editable="true" edittype="text"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" 
                title="Remark" width="150" sortable="true" editable="true" edittype="text"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" 
                title="POD Quantity" width="150" sortable="true" editable="true" edittype="text" 
                formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" 
                title="UOM" width="100" sortable="true" editable="true" edittype="text" hidden="true"
            />
            <sjg:gridColumn
                name="unitOfMeasureName" index="unitOfMeasureName" 
                title="UOM" width="100" sortable="true" editable="true" edittype="text"
            />
            <sjg:gridColumn
                name="price" index="price" key="price" 
                title="Price" width="150" sortable="true" editable="true" edittype="text" 
                formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="discountPercent" index="discountPercent" key="discountPercent" 
                title="Discount Percent" width="150" sortable="true" editable="true" edittype="text" 
                formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="discountAmount" index="discountAmount" key="discountAmount" 
                title="Discount Amount" width="150" sortable="true" editable="true" edittype="text" 
                formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="nettPrice" index="nettPrice" key="nettPrice" 
                title="Nett Price" width="150" sortable="true" editable="true" edittype="text" 
                formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="totalAmount" index="totalAmount" key="totalAmount" 
                title="Total" width="150" sortable="true" editable="true" edittype="text" 
                formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
            <sjg:grid
                id="purchaseOrderClosingAdditional_grid"
                dataType="json"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listPurchaseOrderAdditionalFee"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnupurchaseOrderClosingAdditional').width()"
                editurl="%{remoteurlPurchaseOrderClosingAdditionalInput}"
                onSelectRowTopics="purchaseOrderClosingDetailInput_grid_onSelect"
            >                
                <sjg:gridColumn
                    name="code" index="code" key="code" 
                    title="Code" width="150" sortable="true" hidden="true"
                />                   
                <sjg:gridColumn
                    name="additionalFeeCode" index="additionalFeeCode" key="additionalFeeCode" 
                    title="Additional Fee Code" width="150" sortable="true"
                />                   
                <sjg:gridColumn
                    name="additionalFeeName" index="additionalFeeName" key="additionalFeeName" 
                    title="Additional Fee Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseChartOfAccountCode" index="purchaseChartOfAccountCode" 
                    title="Chart Of Account Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="purchaseChartOfAccountName" index="purchaseChartOfAccountName" key="purchaseChartOfAccountName" 
                    title="Chart Of Account Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="remark" index="remark" key="remark" 
                    title="Remark" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="quantity" index="quantity" key="quantity" 
                    title="Quantity" width="150" sortable="true" editable="true" edittype="text" 
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="unitOfMeasureCode" index="unitOfMeasureCode" 
                    title="UOM" width="100" sortable="true" editable="true" edittype="text" hidden="true"
                />
                <sjg:gridColumn
                    name="unitOfMeasureName" index="unitOfMeasureName" 
                    title="UOM" width="100" sortable="true" editable="true" edittype="text"
                />
                <sjg:gridColumn
                    name="price" index="price" key="price" 
                    title="Price" width="150" sortable="true" editable="true" edittype="text" 
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="total" index="total" key="total" 
                    title="Total" width="150" sortable="true" editable="true" edittype="text" 
                    formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
            </sjg:grid >
        </div>
    
    <table>
        <tr>
            <td valign="top">
                <table width="100%">
                    <tr>
                        <td>
                            <sjg:grid
                                id="purchaseOrderClosingItemDelivery_grid"
                                caption="Item Delivery Date"
                                dataType="json"                    
                                pager="true"
                                navigator="false"
                                navigatorView="false"
                                navigatorRefresh="false"
                                navigatorDelete="false"
                                navigatorAdd="false"
                                navigatorEdit="false"
                                gridModel="listPurchaseOrderItemDeliveryDate"
                                viewrecords="true"
                                rownumbers="true"
                                shrinkToFit="false"
                                editinline="true"
                                width="500"
                                editurl="%{remoteurlPurchaseOrderClosingItemDeliveryInput}"
                                onSelectRowTopics="purchaseOrderClosingItemDeliveryInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="purchaseOrderClosingItemDelivery" index="purchaseOrderClosingItemDelivery" key="purchaseOrderClosingItemDelivery" 
                                    title="" width="50" sortable="true" editable="false" hidden="true"
                                />
                                <sjg:gridColumn
                                    name = "itemMaterialCode" index = "itemMaterialCode" key = "itemMaterialCode" 
                                    title = "Item Material Code" width = "100"
                                />
                                <sjg:gridColumn
                                    name = "itemMaterialName" index = "itemMaterialName" key = "itemMaterialName" 
                                    title = "Item Material Name" width = "100"
                                />
                                <sjg:gridColumn
                                    name="quantity" index="quantity" key="quantity" title="Quantity" 
                                    width="100" align="right" formatter="number"
                                />
                                <sjg:gridColumn
                                    name="deliveryDate" index="deliveryDate" title="Delivery Date" 
                                    sortable="false" align="center"
                                    formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"
                                    width="100" editrules="{date: true, required:false}" 
                                /> 
                            </sjg:grid >
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div> 
<br class="spacer" />
<table style="width: 100%;">  
<tr>
    <td valign="top">
    </td>
    <td width="700px" >
    <fieldset> 
        <table align="right">
            <tr>
                <td align="right"><B>Total Transaction</B>
                    <s:textfield id="purchaseOrderClosingTotalTransactionAmount" name="purchaseOrderClosingTotalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="left"><B>Discount</B>
                <s:textfield id="purchaseOrderClosingDiscountPercent" name="purchaseOrderClosingDiscountPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderClosingDiscountAmount" name="purchaseOrderClosingDiscountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td></td>
                <td align="left"> Descriptions</td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderClosingDiscountChartOfAccountCode" name="purchaseOrderClosingDiscountChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderClosingDiscountChartOfAccountName" name="purchaseOrderClosingDiscountChartOfAccountName" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderClosingDiscountDescription" name="purchaseOrderClosingDiscountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Sub Total (Tax Base)</B>
                    <s:textfield id="purchaseOrderClosingTaxBaseSubTotalAmount" name="purchaseOrderClosingTaxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>VAT</B>
                    <s:textfield id="purchaseOrderClosingVATPercent" name="purchaseOrderClosingVATPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderClosingVATAmount" name="purchaseOrderClosingVATAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td/>
            </tr>
            <tr>
                <td align="right"><B>Other Fee</B>
                    <s:textfield id="purchaseOrderClosingOtherFeeAmount" name="purchaseOrderClosingOtherFeeAmount" cssStyle="text-align:right;%" readonly = "true"></s:textfield>
                </td>
                <td/>
                 <td align="left"> Descriptions </td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderClosingOtherFeeChartOfAccountCode" name="purchaseOrderClosingOtherFeeChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderClosingOtherFeeChartOfAccountName" name="purchaseOrderClosingOtherFeeChartOfAccountName" title=" " readonly="true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderClosingOtherFeeDescription" name="purchaseOrderClosingOtherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Grand Total</B>
                    <s:textfield id="purchaseOrderClosingGrandTotalAmount" name="purchaseOrderClosingGrandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                </td>
                <td/>
            </tr>
        </table>
    </fieldset>            
    </td>
</tr>       
</table>    