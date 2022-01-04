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
    #purchaseOrderUpdateInformationDetail_grid_pager_center{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
    
    var purchaseOrderUpdateInformationViewPRNonIMRRowId = 0;
    
    $(document).ready(function(){
        hoverButton();
        var arrPurchaseOrderNo=new Array();
        
        $.subscribe("purchaseOrderUpdateInformation_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseOrderUpdateInformationHeader_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseOrderUpdateInformation = $("#purchaseOrderUpdateInformationHeader_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-purchase-request-data?purchaseOrder.code="+ purchaseOrderUpdateInformation.code});
            $("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid("setCaption", "Document Detail");
            $("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").trigger("reloadGrid");
            
            jQuery("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid('setGridParam', { gridComplete: function(){    
                var idss = jQuery("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid('getDataIDs');
                for(var i=0; i<idss.length; i++){
                    var data = $("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid('getRowData',idss[i]);
                    arrPurchaseOrderNo.push(data.purchaseRequestCode);
                }
                $("#purchaseOrderUpdateInformationPurchaseRequestItemDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-item-material-request-detail-data?arrPurchaseOrderNo="+ arrPurchaseOrderNo});
                $("#purchaseOrderUpdateInformationPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
                $("#purchaseOrderUpdateInformationPurchaseRequestItemDetail_grid").trigger("reloadGrid");
            }});    
            
            $("#purchaseOrderUpdateInformationDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-detail-data?purchaseOrder.code="+ purchaseOrderUpdateInformation.code});
            $("#purchaseOrderUpdateInformationDetail_grid").jqGrid("setCaption", "Purchase Order Detail");
            $("#purchaseOrderUpdateInformationDetail_grid").trigger("reloadGrid");
            
            $("#purchaseOrderUpdateInformationAdditional_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-additional-fee-data?purchaseOrder.code="+ purchaseOrderUpdateInformation.code});
            $("#purchaseOrderUpdateInformationAdditional_grid").jqGrid("setCaption", "Additional");
            $("#purchaseOrderUpdateInformationAdditional_grid").trigger("reloadGrid");
            
            $("#purchaseOrderUpdateInformationItemDelivery_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-item-delivery-date-data?purchaseOrder.code="+ purchaseOrderUpdateInformation.code});
            $("#purchaseOrderUpdateInformationItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#purchaseOrderUpdateInformationItemDelivery_grid").trigger("reloadGrid");
            
            $("#purchaseOrderUpdateInformationTotalTransactionAmount").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.totalTransactionAmount),2));
            $("#purchaseOrderUpdateInformationDiscountPercent").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.discountPercent),2));
            $("#purchaseOrderUpdateInformationDiscountAmount").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.discountAmount),2));
            $("#purchaseOrderUpdateInformationOtherFeeAmount").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.otherFeeAmount),2));
            $("#purchaseOrderUpdateInformationTaxBaseSubTotalAmount").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.taxBaseSubTotalAmount),2));
            $("#purchaseOrderUpdateInformationVATPercent").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.vatPercent),2));
            $("#purchaseOrderUpdateInformationVATAmount").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.vatAmount),2));
            $("#purchaseOrderUpdateInformationGrandTotalAmount").val(formatNumber(parseFloat(purchaseOrderUpdateInformation.grandTotalAmount),2));
            
            $("#purchaseOrderUpdateInformationDiscountChartOfAccountCode").val(purchaseOrderUpdateInformation.discountChartOfAccountCode);
            $("#purchaseOrderUpdateInformationDiscountChartOfAccountName").val(purchaseOrderUpdateInformation.discountChartOfAccountName);
            $("#purchaseOrderUpdateInformationDiscountDescription").val(purchaseOrderUpdateInformation.discountDescription);
            
            $("#purchaseOrderUpdateInformationOtherFeeChartOfAccountCode").val(purchaseOrderUpdateInformation.otherFeeChartOfAccountCode);
            $("#purchaseOrderUpdateInformationOtherFeeChartOfAccountName").val(purchaseOrderUpdateInformation.otherFeeChartOfAccountName);
            $("#purchaseOrderUpdateInformationOtherFeeDescription").val(purchaseOrderUpdateInformation.otherFeeDescription);
            
        });
        
        $("#btnPurchaseOrderUpdateInformation").click(function(ev) {
            var selectedRowId = $("#purchaseOrderUpdateInformationHeader_grid").jqGrid('getGridParam','selrow');
            var purchaseOrderUpdateInformation = $("#purchaseOrderUpdateInformationHeader_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(purchaseOrderUpdateInformation.grnConfirmation==="CONFIRMED"){
                alertMessage("GRN has been Confirmed, PO unable to edit");
                return;
            }
            
            var url = "purchase/purchase-order-update-information-input";
            var params = "purchaseOrderUpdateInformation.code=" + purchaseOrderUpdateInformation.code;
                pageLoad(url, params, "#tabmnuPURCHASE_ORDER_UPDATE_INFORMATION");

        });
        
        $("#btnPurchaseOrderUpdateInformationRefresh").click(function (ev) {
            var url = "purchasing/purchase-order-update-information";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER_UPDATE_INFORMATION");
            ev.preventDefault();
        });
        
        $('#btnPurchaseOrderUpdateInformation_search').click(function(ev) {
            formatDatePOUpdateInformation();
            reloadTotalPOUpdateInformation();
            $("#purchaseOrderUpdateInformationHeader_grid").jqGrid("clearGridData");
            $("#purchaseOrderUpdateInformationHeader_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-update-information-data?" + $("#frmPurchaseOrderUpdateInformationSearchInput").serialize()});
            $("#purchaseOrderUpdateInformationHeader_grid").trigger("reloadGrid");
            
            $("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderUpdateInformationPurchaseRequestDetail_grid").jqGrid("setCaption", "Purchase Request Detail");
            
            $("# purchaseOrderUpdateInformationPurchaseRequestItemDetail_grid").jqGrid("clearGridData");
            $("# purchaseOrderUpdateInformationPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail (IMR)");
            
            $("#purchaseOrderUpdateInformationDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderUpdateInformationDetail_grid").jqGrid("setCaption", "PO Detail");
            
            $("#purchaseOrderUpdateInformationAdditional_grid").jqGrid("clearGridData");
            $("#purchaseOrderUpdateInformationAdditional_grid").jqGrid("setCaption", "Additional Fee");
            
            $("#purchaseOrderUpdateInformationItemDelivery_grid").jqGrid("clearGridData");
            $("#purchaseOrderUpdateInformationItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDatePOUpdateInformation();
            ev.preventDefault();
           
        });
    });
        
    function formatDatePOUpdateInformation(){
        var firstDate=$("#purchaseOrderUpdateInformation\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseOrderUpdateInformation\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseOrderUpdateInformation\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseOrderUpdateInformation\\.transactionLastDate").val(lastDateValue); 
    }
     
    function reloadTotalPOUpdateInformation(){
        $("#purchaseOrderUpdateInformationTotalTransactionAmount").val("0.00");
        $("#purchaseOrderUpdateInformationDiscountPercent").val("0.00");
        $("#purchaseOrderUpdateInformationDiscountAmount").val("0.00");
        $("#purchaseOrderUpdateInformationTaxBaseSubTotalAmount").val("0.00");
        $("#purchaseOrderUpdateInformationVATPercent").val("0.00");
        $("#purchaseOrderUpdateInformationVATAmount").val("0.00");
        $("#purchaseOrderUpdateInformationOtherFeeAmount").val("0.00");
        $("#purchaseOrderUpdateInformationGrandTotalAmount").val("0.00");
    }
</script>

<s:url id="remoteurlPurchaseOrderUpdateInformation" action="purchase-order-update-information-data" />
    <b>PURCHASE ORDER UPDATE INFORMATION</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseOrderUpdateInformationButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnPurchaseOrderUpdateInformationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="purchaseOrderUpdateInformationInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseOrderUpdateInformationSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseOrderUpdateInformation.transactionFirstDate" name="purchaseOrderUpdateInformation.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseOrderUpdateInformation.transactionLastDate" name="purchaseOrderUpdateInformation.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">POD No</td>
                    <td>
                        <s:textfield id="purchaseOrderUpdateInformation.code" name="purchaseOrderUpdateInformation.code" size="27" placeholder=" PO"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="purchaseOrderUpdateInformation.vendorCode" name="purchaseOrderUpdateInformation.vendorCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrderUpdateInformation.vendorName" name="purchaseOrderUpdateInformation.vendorName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="purchaseOrderUpdateInformation.refNo" name="purchaseOrderUpdateInformation.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Currency</td>
                    <td>
                        <s:textfield id="purchaseOrderUpdateInformation.currencyCode" name="purchaseOrderUpdateInformation.currencyCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrderUpdateInformation.currencyName" name="purchaseOrderUpdateInformation.currencyName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="purchaseOrderUpdateInformation.remark" name="purchaseOrderUpdateInformation.remark" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseOrderUpdateInformation_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
    
    <div>
        <sjg:grid
            id="purchaseOrderUpdateInformationHeader_grid"
            caption="Purchase Order"
            dataType="json"   
            href="%{remoteurlPurchaseOrderUpdateInformation}"
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
            onSelectRowTopics="purchaseOrderUpdateInformation_grid_onSelect"
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
                name="grnConfirmation" index="grnConfirmation" 
                title="GRN Confirmation" width="200" sortable="true" hidden="true"
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
    <sj:a href="#" id="btnPurchaseOrderUpdateInformation" button="true" style="width: 90px">Update</sj:a>
    </div>
    
    <br class="spacer" />
    <div>
        <sjg:grid
            id="purchaseOrderUpdateInformationPurchaseRequestDetail_grid"
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
            onSelectRowTopics="purchaseOrderUpdateInformationPurchaseRequestDetail_grid_onSelect"
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
            id="purchaseOrderUpdateInformationPurchaseRequestItemDetail_grid"
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
            id="purchaseOrderUpdateInformationDetail_grid"
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
            width="$('#tabmnupurchaseOrderUpdateInformationDetail').width()"
            editurl="%{remoteurlPurchaseOrderUpdateInformationDetailInput}"
            onSelectRowTopics="purchaseOrderUpdateInformationDetailInput_grid_onSelect"
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
                id="purchaseOrderUpdateInformationAdditional_grid"
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
                width="$('#tabmnupurchaseOrderUpdateInformationAdditional').width()"
                editurl="%{remoteurlPurchaseOrderUpdateInformationAdditionalInput}"
                onSelectRowTopics="purchaseOrderUpdateInformationDetailInput_grid_onSelect"
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
                                id="purchaseOrderUpdateInformationItemDelivery_grid"
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
                                editurl="%{remoteurlPurchaseOrderUpdateInformationItemDeliveryInput}"
                                onSelectRowTopics="purchaseOrderUpdateInformationItemDeliveryInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="purchaseOrderUpdateInformationItemDelivery" index="purchaseOrderUpdateInformationItemDelivery" key="purchaseOrderUpdateInformationItemDelivery" 
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
                    <s:textfield id="purchaseOrderUpdateInformationTotalTransactionAmount" name="purchaseOrderUpdateInformationTotalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="left"><B>Discount</B>
                <s:textfield id="purchaseOrderUpdateInformationDiscountPercent" name="purchaseOrderUpdateInformationDiscountPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderUpdateInformationDiscountAmount" name="purchaseOrderUpdateInformationDiscountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td></td>
                <td align="left"> Descriptions</td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderUpdateInformationDiscountChartOfAccountCode" name="purchaseOrderUpdateInformationDiscountChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderUpdateInformationDiscountChartOfAccountName" name="purchaseOrderUpdateInformationDiscountChartOfAccountName" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderUpdateInformationDiscountDescription" name="purchaseOrderUpdateInformationDiscountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Sub Total (Tax Base)</B>
                    <s:textfield id="purchaseOrderUpdateInformationTaxBaseSubTotalAmount" name="purchaseOrderUpdateInformationTaxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>VAT</B>
                    <s:textfield id="purchaseOrderUpdateInformationVATPercent" name="purchaseOrderUpdateInformationVATPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderUpdateInformationVATAmount" name="purchaseOrderUpdateInformationVATAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td/>
            </tr>
            <tr>
                <td align="right"><B>Other Fee</B>
                    <s:textfield id="purchaseOrderUpdateInformationOtherFeeAmount" name="purchaseOrderUpdateInformationOtherFeeAmount" cssStyle="text-align:right;%" readonly = "true"></s:textfield>
                </td>
                <td/>
                 <td align="left"> Descriptions </td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderUpdateInformationOtherFeeChartOfAccountCode" name="purchaseOrderUpdateInformationOtherFeeChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderUpdateInformationOtherFeeChartOfAccountName" name="purchaseOrderUpdateInformationOtherFeeChartOfAccountName" title=" " readonly="true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderUpdateInformationOtherFeeDescription" name="purchaseOrderUpdateInformationOtherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Grand Total</B>
                    <s:textfield id="purchaseOrderUpdateInformationGrandTotalAmount" name="purchaseOrderUpdateInformationGrandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                </td>
                <td/>
            </tr>
        </table>
    </fieldset>            
    </td>
</tr>       
</table>    