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
    #purchaseOrderPurchaseRequestItemDetail_grid_pager_center,
    #purchaseOrderPurchaseRequestDetail_grid_pager_center,
    #purchaseOrderAdditional_grid_pager_center,#purchaseOrderDetail_grid_pager_center,
    #purchaseOrderItemDelivery_grid_pager_center{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
    
    var purchaseOrderViewPRNonIMRRowId = 0;
    
    $(document).ready(function(){
        hoverButton();
        var arrPurchaseOrderNo=new Array();
        
        $.subscribe("purchaseOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseOrderHeader_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseOrder = $("#purchaseOrderHeader_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseOrderPurchaseRequestDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-purchase-request-data?purchaseOrder.code="+ purchaseOrder.code});
            $("#purchaseOrderPurchaseRequestDetail_grid").jqGrid("setCaption", "PRQ");
            $("#purchaseOrderPurchaseRequestDetail_grid").trigger("reloadGrid");
            
            jQuery("#purchaseOrderPurchaseRequestDetail_grid").jqGrid('setGridParam', { gridComplete: function(){    
                var idss = jQuery("#purchaseOrderPurchaseRequestDetail_grid").jqGrid('getDataIDs');
                if(idss.length === 0){
                    $("#purchaseOrderPurchaseRequestItemDetail_grid").jqGrid("clearGridData");
                    $("#purchaseOrderPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
                }else{
                    for(var i=0; i<idss.length; i++){
                        var data = $("#purchaseOrderPurchaseRequestDetail_grid").jqGrid('getRowData',idss[i]);
                        arrPurchaseOrderNo.push(data.purchaseRequestCode);
                    }
                    $("#purchaseOrderPurchaseRequestItemDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-item-material-request-detail-data?arrPurchaseOrderNo="+ arrPurchaseOrderNo});
                    $("#purchaseOrderPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");
                    $("#purchaseOrderPurchaseRequestItemDetail_grid").trigger("reloadGrid");
                }
                
            }});
        
            $("#purchaseOrderDetail_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-detail-data?purchaseOrder.code="+ purchaseOrder.code});
            $("#purchaseOrderDetail_grid").jqGrid("setCaption", "Purchase Order Detail");
            $("#purchaseOrderDetail_grid").trigger("reloadGrid");
            
            $("#purchaseOrderAdditional_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-additional-fee-data?purchaseOrder.code="+ purchaseOrder.code});
            $("#purchaseOrderAdditional_grid").jqGrid("setCaption", "Additional");
            $("#purchaseOrderAdditional_grid").trigger("reloadGrid");
            
            $("#purchaseOrderItemDelivery_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-item-delivery-date-data?purchaseOrder.code="+ purchaseOrder.code});
            $("#purchaseOrderItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            $("#purchaseOrderItemDelivery_grid").trigger("reloadGrid");
            
            $("#purchaseOrderTotalTransactionAmount").val(formatNumber(parseFloat(purchaseOrder.totalTransactionAmount),2));
            $("#purchaseOrderDiscountPercent").val(formatNumber(parseFloat(purchaseOrder.discountPercent),2));
            $("#purchaseOrderDiscountAmount").val(formatNumber(parseFloat(purchaseOrder.discountAmount),2));
            $("#purchaseOrderOtherFeeAmount").val(formatNumber(parseFloat(purchaseOrder.otherFeeAmount),2));
            $("#purchaseOrderTaxBaseSubTotalAmount").val(formatNumber(parseFloat(purchaseOrder.taxBaseSubTotalAmount),2));
            $("#purchaseOrderVATPercent").val(formatNumber(parseFloat(purchaseOrder.vatPercent),2));
            $("#purchaseOrderVATAmount").val(formatNumber(parseFloat(purchaseOrder.vatAmount),2));
            $("#purchaseOrderGrandTotalAmount").val(formatNumber(parseFloat(purchaseOrder.grandTotalAmount),2));
            
            $("#purchaseOrderDiscountChartOfAccountCode").val(purchaseOrder.discountChartOfAccountCode);
            $("#purchaseOrderDiscountChartOfAccountName").val(purchaseOrder.discountChartOfAccountName);
            $("#purchaseOrderDiscountDescription").val(purchaseOrder.discountDescription);
            
            $("#purchaseOrderOtherFeeChartOfAccountCode").val(purchaseOrder.otherFeeChartOfAccountCode);
            $("#purchaseOrderOtherFeeChartOfAccountName").val(purchaseOrder.otherFeeChartOfAccountName);
            $("#purchaseOrderOtherFeeDescription").val(purchaseOrder.otherFeeDescription);
            
        });
          
        $("#btnPurchaseOrderNew").click(function(ev) {
            var url = "purchasing/purchase-order-input";
            var params = "enumPurchaseOrderActivity=NEW";

            pageLoad(url, params, "#tabmnuPURCHASE_ORDER");

        }); 
          
        $("#btnPurchaseOrderUpdate").click(function(ev) {
            var selectedRowId = $("#purchaseOrderHeader_grid").jqGrid('getGridParam','selrow');
            var purchaseOrder = $("#purchaseOrderHeader_grid").jqGrid('getRowData', selectedRowId);
            
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(purchaseOrder.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            
            if(purchaseOrder.approvalStatus==="APPROVED"){
                alertMessage("It Has Been Approved");
                return;
            }
            
            var url = "purchase/purchase-order-input";
            var params = "enumPurchaseOrderActivity=UPDATE";
                params+="&purchaseOrder.code=" + purchaseOrder.code;
                pageLoad(url, params, "#tabmnuPURCHASE_ORDER");

        }); 
        
        $("#btnPurchaseOrderRefresh").click(function (ev) {
            var url = "purchasing/purchase-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_ORDER");
            ev.preventDefault();
        });
        
        $("#btnPurchaseOrderDelete").click(function (ev) {
            
            var deleteRowId = $("#purchaseOrderHeader_grid").jqGrid('getGridParam','selrow');
            var purchaseOrder = $("#purchaseOrderHeader_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(purchaseOrder.closingStatus==="CLOSED"){
                alertMessage("It Has Been Closed");
                return;
            }
            
            if(purchaseOrder.approvalStatus==="APPROVED"){
                alertMessage("It Has Been Approved");
                return;
            }
            
            var url = "purchasing/purchase-order-delete";
            var params = "purchaseOrder.code=" + purchaseOrder.code;
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PRQ No: '+purchaseOrder.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title           : "Message",
                closeOnEscape   : false,
                modal           : true,
                width           : 300,
                resizable       : false,
                buttons         : [{
                                    text : "Yes",
                                    click : function() {
                                        $.post(url, params, function(data) {
                                            if (data.error) {
                                                alertMessage(data.errorMessage,400,"");
                                                return;
                                            }
                                          $("#purchaseOrderHeader_grid").trigger("reloadGrid");
                                          $("#purchaseOrderPurchaseRequestDetail_grid").trigger("reloadGrid");
                                          $("#purchaseOrderPurchaseRequestItemDetail_grid").trigger("reloadGrid");
                                          $("#purchaseOrderDetail_grid").trigger("reloadGrid");
                                          $("#purchaseOrderAdditional_grid").trigger("reloadGrid");
                                          $("#purchaseOrderItemDelivery_grid").trigger("reloadGrid");
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
        
        $('#btnPurchaseOrder_search').click(function(ev) {
            formatDatePO();
            reloadTotalPO();
            $("#purchaseOrderHeader_grid").jqGrid("clearGridData");
            $("#purchaseOrderHeader_grid").jqGrid("setGridParam",{url:"purchase/purchase-order-data?" + $("#frmPurchaseOrderSearchInput").serialize()});
            $("#purchaseOrderHeader_grid").trigger("reloadGrid");
            
            $("#purchaseOrderPurchaseRequestDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderPurchaseRequestDetail_grid").jqGrid("setCaption", "PRQ");
            
            $("#purchaseOrderPurchaseRequestItemDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderPurchaseRequestItemDetail_grid").jqGrid("setCaption", "PRQ Item Detail");         
            
            $("#purchaseOrderDetail_grid").jqGrid("clearGridData");
            $("#purchaseOrderDetail_grid").jqGrid("setCaption", "PO Detail");
            
            $("#purchaseOrderAdditional_grid").jqGrid("clearGridData");
            $("#purchaseOrderAdditional_grid").jqGrid("setCaption", "Additional Fee");
            
            $("#purchaseOrderItemDelivery_grid").jqGrid("clearGridData");
            $("#purchaseOrderItemDelivery_grid").jqGrid("setCaption", "Item Delivery Date");
            formatDatePO();
            ev.preventDefault();
           
        });
    });
        
    function formatDatePO(){
        var firstDate=$("#purchaseOrder\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseOrder\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseOrder\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseOrder\\.transactionLastDate").val(lastDateValue); 
    }
     
    function reloadTotalPO(){
        $("#purchaseOrderTotalTransactionAmount").val("0.00");
        $("#purchaseOrderDiscountPercent").val("0.00");
        $("#purchaseOrderDiscountAmount").val("0.00");
        $("#purchaseOrderTaxBaseSubTotalAmount").val("0.00");
        $("#purchaseOrderVATPercent").val("0.00");
        $("#purchaseOrderVATAmount").val("0.00");
        $("#purchaseOrderOtherFeeAmount").val("0.00");
        $("#purchaseOrderGrandTotalAmount").val("0.00");
    }
</script>

<s:url id="remoteurlPurchaseOrder" action="purchase-order-data" />
    <b>PURCHASE ORDER</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseOrderButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnPurchaseOrderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnPurchaseOrderUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnPurchaseOrderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnPurchaseOrderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnPurchaseOrderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="purchaseOrderInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseOrderSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseOrder.transactionFirstDate" name="purchaseOrder.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseOrder.transactionLastDate" name="purchaseOrder.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">POD No</td>
                    <td>
                        <s:textfield id="purchaseOrder.code" name="purchaseOrder.code" size="27" placeholder=" PO"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="purchaseOrder.vendorCode" name="purchaseOrder.vendorCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrder.vendorName" name="purchaseOrder.vendorName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="purchaseOrder.refNo" name="purchaseOrder.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Currency</td>
                    <td>
                        <s:textfield id="purchaseOrder.currencyCode" name="purchaseOrder.currencyCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseOrder.currencyName" name="purchaseOrder.currencyName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="purchaseOrder.remark" name="purchaseOrder.remark" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseOrder_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
    
    <div>
        <sjg:grid
            id="purchaseOrderHeader_grid"
            caption="Purchase Order"
            dataType="json"   
            href="%{remoteurlPurchaseOrder}"
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
            onSelectRowTopics="purchaseOrder_grid_onSelect"
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
                name="approvalStatus" index="approvalStatus" 
                title="Approval Status" width="200" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="closingStatus" index="closingStatus" 
                title="Closing Status" width="200" sortable="true" hidden="true"
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
        <sjg:grid
            id="purchaseOrderPurchaseRequestDetail_grid"
            caption=""
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
            onSelectRowTopics="purchaseOrderPurchaseRequestDetail_grid_onSelect"
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
            id="purchaseOrderPurchaseRequestItemDetail_grid"
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
            id="purchaseOrderDetail_grid"
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
            width="$('#tabmnupurchaseOrderDetail').width()"
            onSelectRowTopics="purchaseOrderDetailInput_grid_onSelect"
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
                id="purchaseOrderAdditional_grid"
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
                width="$('#tabmnupurchaseOrderAdditional').width()"
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
                                id="purchaseOrderItemDelivery_grid"
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
                                width="500"
                            >
                                <sjg:gridColumn
                                    name="purchaseOrderItemDelivery" index="purchaseOrderItemDelivery" key="purchaseOrderItemDelivery" 
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
                    <s:textfield id="purchaseOrderTotalTransactionAmount" name="purchaseOrderTotalTransactionAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="left"><B>Discount</B>
                <s:textfield id="purchaseOrderDiscountPercent" name="purchaseOrderDiscountPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderDiscountAmount" name="purchaseOrderDiscountAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td></td>
                <td align="left"> Descriptions</td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderDiscountChartOfAccountCode" name="purchaseOrderDiscountChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderDiscountChartOfAccountName" name="purchaseOrderDiscountChartOfAccountName" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderDiscountDescription" name="purchaseOrderDiscountDescription" title=" " PlaceHolder=" Description Discount" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Sub Total (Tax Base)</B>
                    <s:textfield id="purchaseOrderTaxBaseSubTotalAmount" name="purchaseOrderTaxBaseSubTotalAmount" readonly="true" cssStyle="text-align:right;" size="20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>VAT</B>
                    <s:textfield id="purchaseOrderVATPercent" name="purchaseOrderVATPercent" cssStyle="text-align:right;" size="8" readonly = "true"></s:textfield>
                    %
                <s:textfield id="purchaseOrderVATAmount" name="purchaseOrderVATAmount" readonly="true" cssStyle="text-align:right;" size = "20"></s:textfield>
                </td>
                <td/>
            </tr>
            <tr>
                <td align="right"><B>Other Fee</B>
                    <s:textfield id="purchaseOrderOtherFeeAmount" name="purchaseOrderOtherFeeAmount" cssStyle="text-align:right;%" readonly = "true"></s:textfield>
                </td>
                <td/>
                 <td align="left"> Descriptions </td>
            </tr>
            <tr>
                <td align="right"><B>Account</B>
                    <s:textfield id="purchaseOrderOtherFeeChartOfAccountCode" name="purchaseOrderOtherFeeChartOfAccountCode" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderOtherFeeChartOfAccountName" name="purchaseOrderOtherFeeChartOfAccountName" title=" " readonly="true"></s:textfield>
                </td>
                <td align="right">
                <s:textfield id="purchaseOrderOtherFeeDescription" name="purchaseOrderOtherFeeDescription" title=" " PlaceHolder=" Description Other" size ="20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Grand Total</B>
                    <s:textfield id="purchaseOrderGrandTotalAmount" name="purchaseOrderGrandTotalAmount" readonly="true" cssStyle="text-align:right;%" size ="20"></s:textfield>
                </td>
                <td/>
            </tr>
        </table>
    </fieldset>            
    </td>
</tr>       
</table>    