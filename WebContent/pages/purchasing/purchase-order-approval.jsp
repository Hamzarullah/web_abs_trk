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
    #purchaseOrderApprovalDetail_grid_pager_center{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
    
    var purchaseOrderApprovalViewPRNonIMRRowId = 0;
    
    $(document).ready(function(){
        hoverButton();
        var arrPurchaseOrderNo=new Array();
        
        $('#purchaseOrderApprovalSearchApprovalStatusRadPENDING').prop('checked',true);
        $("#purchaseOrderApproval\\.approvalStatus").val("PENDING");
            
        $('input[name="purchaseOrderApprovalSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#purchaseOrderApproval\\.approvalStatus").val("PENDING");
        });
        
        $('input[name="purchaseOrderApprovalSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#purchaseOrderApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="purchaseOrderApprovalSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#purchaseOrderApproval\\.approvalStatus").val("REJECTED");
        });
        
        $('input[name="purchaseOrderApprovalSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#purchaseOrderApproval\\.approvalStatus").val("");
        });
        
        $.subscribe("purchaseOrderApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseOrderApprovalHeader_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseOrderApproval = $("#purchaseOrderApprovalHeader_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-purchase-request-data?purchaseOrder.code="+ purchaseOrderApproval.code});
            $("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid("setCaption", "PRQ");
            $("#purchaseOrderApprovalPurchaseRequestDetail_grid").trigger("reloadGrid");
            
            jQuery("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid('setGridParam', { gridComplete: function(){    
                var idss = jQuery("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid('getDataIDs');
                if(idss.length === 0){
                    $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").jqGrid("clearGridData");
                    $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
                }else{
                    
                for(var i=0; i<idss.length; i++){
                        var data = $("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid('getRowData',idss[i]);
                        arrPurchaseOrderNo.push(data.purchaseRequestCode);
                    }
                    
                    $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-item-material-request-detail-data?arrPurchaseOrderNo="+ arrPurchaseOrderNo});
                    $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
                    $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").trigger("reloadGrid"); 
                }
                
            }});    
        
            // PO Detail
            $("#purchaseOrderApprovalDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-detail-data?purchaseOrder.code="+ purchaseOrderApproval.code});
            $("#purchaseOrderApprovalDetail_grid").jqGrid("setCaption", "Purchase Order Detail");
            $("#purchaseOrderApprovalDetail_grid").trigger("reloadGrid");
            
            // Additional
            $("#purchaseOrderApprovalAdditional_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-additional-fee-data?purchaseOrder.code="+ purchaseOrderApproval.code});
            $("#purchaseOrderApprovalAdditional_grid").jqGrid("setCaption", "Additional");
            $("#purchaseOrderApprovalAdditional_grid").trigger("reloadGrid");
            
            // Item Delivery
            $("#purchaseOrderApprovalItemDelivery_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-item-delivery-date-data?purchaseOrder.code="+ purchaseOrderApproval.code});
            $("#purchaseOrderApprovalItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#purchaseOrderApprovalItemDelivery_grid").trigger("reloadGrid");
            
            $("#purchaseOrderApprovalTotalTransactionAmount").val(formatNumber(parseFloat(purchaseOrderApproval.totalTransactionAmount),2));
            $("#purchaseOrderApprovalDiscountPercent").val(formatNumber(parseFloat(purchaseOrderApproval.discountPercent),2));
            $("#purchaseOrderApprovalDiscountAmount").val(formatNumber(parseFloat(purchaseOrderApproval.discountAmount),2));
            $("#purchaseOrderApprovalOtherFeeAmount").val(formatNumber(parseFloat(purchaseOrderApproval.otherFeeAmount),2));
            $("#purchaseOrderApprovalTaxBaseSubTotalAmount").val(formatNumber(parseFloat(purchaseOrderApproval.taxBaseSubTotalAmount),2));
            $("#purchaseOrderApprovalVATPercent").val(formatNumber(parseFloat(purchaseOrderApproval.vatPercent),2));
            $("#purchaseOrderApprovalVATAmount").val(formatNumber(parseFloat(purchaseOrderApproval.vatAmount),2));
            $("#purchaseOrderApprovalGrandTotalAmount").val(formatNumber(parseFloat(purchaseOrderApproval.grandTotalAmount),2));
            
            $("#purchaseOrderApprovalDiscountChartOfAccountCode").val(purchaseOrderApproval.discountChartOfAccountCode);
            $("#purchaseOrderApprovalDiscountChartOfAccountName").val(purchaseOrderApproval.discountChartOfAccountName);
            $("#purchaseOrderApprovalDiscountDescription").val(purchaseOrderApproval.discountDescription);
            
            $("#purchaseOrderApprovalOtherFeeChartOfAccountCode").val(purchaseOrderApproval.otherFeeChartOfAccountCode);
            $("#purchaseOrderApprovalOtherFeeChartOfAccountName").val(purchaseOrderApproval.otherFeeChartOfAccountName);
            $("#purchaseOrderApprovalOtherFeeDescription").val(purchaseOrderApproval.otherFeeDescription);
            
        });
        
        $("#btnPurchaseOrderApproved").click(function(ev) {
            var selectedRowId = $("#purchaseOrderApprovalHeader_grid").jqGrid('getGridParam','selrow');
            var purchaseOrderApproval = $("#purchaseOrderApprovalHeader_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
//            if(customerPurchaseOrderApprovalRelease.closingStatus==="CLOSED"){
//                alertMessage("It Has Been Closed");
//                return;
//            }
            var url = "purchase/purchase-order-approval-input";
            var params = "enumPurchaseOrderApprovalActivity=UPDATE";
                params+="&purchaseOrderApproval.code=" + purchaseOrderApproval.code;
                pageLoad(url, params, "#tabmnuPURCHASE_ORDER_APPROVAL");

        });
        
        $("#btnPurchaseOrderApprovalRefresh").click(function (ev) {
            var url = "purchasing/purchase-order-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER_APPROVAL");
            ev.preventDefault();
        });
        
        $('#btnPurchaseOrderApproval_search').click(function(ev) {
            formatDatePOApproval();
            reloadTotalPOApproval();
            $("#purchaseOrderApprovalHeader_grid").jqGrid("clearGridData");
            $("#purchaseOrderApprovalHeader_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-approval-data?" + $("#frmPurchaseOrderApprovalSearchInput").serialize()});
            $("#purchaseOrderApprovalHeader_grid").trigger("reloadGrid");
            
            $("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderApprovalPurchaseRequestDetail_grid").jqGrid("setCaption", "Purchase Request Detail");
            
            $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderApprovalPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
            
            $("#purchaseOrderApprovalDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderApprovalDetail_grid").jqGrid("setCaption", "PO Detail");
            
            $("#purchaseOrderApprovalAdditional_grid").jqGrid("clearGridData");
            $("#purchaseOrderApprovalAdditional_grid").jqGrid("setCaption", "Additional Fee");
            
            $("#purchaseOrderApprovalItemDelivery_grid").jqGrid("clearGridData");
            $("#purchaseOrderApprovalItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDatePOApproval();
            ev.preventDefault();
           
        });
    });
        
    function formatDatePOApproval(){
        var firstDate=$("#purchaseOrderApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseOrderApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseOrderApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseOrderApproval\\.transactionLastDate").val(lastDateValue); 
    }
     
    function reloadTotalPOApproval(){
        $("#purchaseOrderApprovalTotalTransactionAmount").val("0.00");
        $("#purchaseOrderApprovalDiscountPercent").val("0.00");
        $("#purchaseOrderApprovalDiscountAmount").val("0.00");
        $("#purchaseOrderApprovalTaxBaseSubTotalAmount").val("0.00");
        $("#purchaseOrderApprovalVATPercent").val("0.00");
        $("#purchaseOrderApprovalVATAmount").val("0.00");
        $("#purchaseOrderApprovalOtherFeeAmount").val("0.00");
        $("#purchaseOrderApprovalGrandTotalAmount").val("0.00");
    }
</script>

<s:url id="remoteurlPurchaseOrderApproval" action="purchase-order-approval-data" />
    <b>PURCHASE ORDER APPROVAL</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseOrderApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnPurchaseOrderApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="purchaseOrderApprovalInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseOrderApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseOrderApproval.transactionFirstDate" name="purchaseOrderApproval.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseOrderApproval.transactionLastDate" name="purchaseOrderApproval.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">POD No</td>
                    <td>
                        <s:textfield id="purchaseOrderApproval.code" name="purchaseOrderApproval.code" size="27" placeholder=" PO"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="purchaseOrderApproval.vendorCode" name="purchaseOrderApproval.vendorCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrderApproval.vendorName" name="purchaseOrderApproval.vendorName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="purchaseOrderApproval.refNo" name="purchaseOrderApproval.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Currency</td>
                    <td>
                        <s:textfield id="purchaseOrderApproval.currencyCode" name="purchaseOrderApproval.currencyCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrderApproval.currencyName" name="purchaseOrderApproval.currencyName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="purchaseOrderApproval.remark" name="purchaseOrderApproval.remark" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="purchaseOrderApprovalSearchApprovalStatusRad" name="purchaseOrderApprovalSearchApprovalStatusRad" label="purchaseOrderApprovalSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="purchaseOrderApproval.approvalStatus" name="purchaseOrderApproval.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseOrderApproval_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
    
    <div>
        <sjg:grid
            id="purchaseOrderApprovalHeader_grid"
            caption="Purchase Order"
            dataType="json"   
            href="%{remoteurlPurchaseOrderApproval}"
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
            onSelectRowTopics="purchaseOrderApproval_grid_onSelect"
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
    <sj:a href="#" id="btnPurchaseOrderApproved" button="true" style="width: 90px">Status</sj:a>
    </div>
    
    <br class="spacer" />
    <div>
        <sjg:grid
            id="purchaseOrderApprovalPurchaseRequestDetail_grid"
            caption="PRQ"
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
            onSelectRowTopics="purchaseOrderApprovalPurchaseRequestDetail_grid_onSelect"
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
            id="purchaseOrderApprovalPurchaseRequestItemDetail_grid"
            caption="PRQ Item Detail"
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
            id="purchaseOrderApprovalDetail_grid"
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
            width="$('#tabmnupurchaseOrderApprovalDetail').width()"
            editurl="%{remoteurlPurchaseOrderApprovalDetailInput}"
            onSelectRowTopics="purchaseOrderApprovalDetailInput_grid_onSelect"
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
                id="purchaseOrderApprovalAdditional_grid"
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
                width="$('#tabmnupurchaseOrderApprovalAdditional').width()"
                editurl="%{remoteurlPurchaseOrderApprovalAdditionalInput}"
                onSelectRowTopics="purchaseOrderApprovalDetailInput_grid_onSelect"
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
                                id="purchaseOrderApprovalItemDelivery_grid"
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
                                editurl="%{remoteurlPurchaseOrderApprovalItemDeliveryInput}"
                                onSelectRowTopics="purchaseOrderApprovalItemDeliveryInput_grid_onSelect"
                            >
                                <sjg:gridColumn
                                    name="purchaseOrderApprovalItemDelivery" index="purchaseOrderApprovalItemDelivery" key="purchaseOrderApprovalItemDelivery" 
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
                    <s:textfield id="purchaseOrderApprovalTotalTransactionAmount" name="purchaseOrderApprovalTotalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="left"><B>Discount</B>
                <s:textfield id="purchaseOrderApprovalDiscountPercent" name="purchaseOrderApprovalDiscountPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderApprovalDiscountAmount" name="purchaseOrderApprovalDiscountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td></td>
                <td align="left"> Descriptions</td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderApprovalDiscountChartOfAccountCode" name="purchaseOrderApprovalDiscountChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderApprovalDiscountChartOfAccountName" name="purchaseOrderApprovalDiscountChartOfAccountName" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderApprovalDiscountDescription" name="purchaseOrderApprovalDiscountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Sub Total (Tax Base)</B>
                    <s:textfield id="purchaseOrderApprovalTaxBaseSubTotalAmount" name="purchaseOrderApprovalTaxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>VAT</B>
                    <s:textfield id="purchaseOrderApprovalVATPercent" name="purchaseOrderApprovalVATPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderApprovalVATAmount" name="purchaseOrderApprovalVATAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td/>
            </tr>
            <tr>
                <td align="right"><B>Other Fee</B>
                    <s:textfield id="purchaseOrderApprovalOtherFeeAmount" name="purchaseOrderApprovalOtherFeeAmount" cssStyle="text-align:right;%" readonly = "true"></s:textfield>
                </td>
                <td/>
                 <td align="left"> Descriptions </td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderApprovalOtherFeeChartOfAccountCode" name="purchaseOrderApprovalOtherFeeChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderApprovalOtherFeeChartOfAccountName" name="purchaseOrderApprovalOtherFeeChartOfAccountName" title=" " readonly="true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderApprovalOtherFeeDescription" name="purchaseOrderApprovalOtherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Grand Total</B>
                    <s:textfield id="purchaseOrderApprovalGrandTotalAmount" name="purchaseOrderApprovalGrandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                </td>
                <td/>
            </tr>
        </table>
    </fieldset>            
    </td>
</tr>       
</table>    