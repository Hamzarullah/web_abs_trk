<%-- 
    Document   : search-purchaseOrder
    Created on : Aug 23, 2019, 9:59:08 AM
    Author     : jsone
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow: scroll;
        }
        th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
        }
    </style>
    
    
<script type = "text/javascript">
       
    var search_purchaseOrder= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>'; 
    jQuery(document).ready(function(){  
        
        $("#dlgPurchaseOrder_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_purchaseOrder_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }

            var data_search_purchaseOrder = $("#dlgSearch_purchaseOrder_grid").jqGrid('getRowData', selectedRowId);

            if (search_purchaseOrder === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
//                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
//                
//                for(var j=0;j<idsOpener.length;j++){
//                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
//                    
//                    if(data_search_purchaseOrder.code === dataOpener.customerPurchaseOrderPurchaseOrderCode){
//                        alertMsg("Purchase Order "+data_search_purchaseOrder.code+" Has Been Existing In Grid!");
//                        return;
//                    }
//                }
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"PurchaseOrderDetailCode", data_search_purchaseOrder.purchaseOrderDetailCode);         
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemAlias", data_search_purchaseOrder.itemAlias); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SerialStatus", data_search_purchaseOrder.itemMaterialSerialStatus); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"PODQuantity", data_search_purchaseOrder.purchaseOrderQuantity); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ReceivedQuantity", data_search_purchaseOrder.receivedQuantity); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"UnitOfMeasureCode", data_search_purchaseOrder.unitOfMeasureCode); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Remark", data_search_purchaseOrder.remark); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RackCode", data_search_purchaseOrder.rackCode); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RackName", data_search_purchaseOrder.rackName); 
                    
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_purchaseOrder.code);
            }
            window.close();
        });

        $("#dlgPurchaseOrder_cancelButton").click(function(ev) { 
            data_search_purchaseOrder = null;
            window.close();
        });
        
    
        $("#btn_dlg_PurchaseOrderSearch").click(function(ev) {
            $("#dlgSearch_purchaseOrder_grid").jqGrid("clearGridData");
            if(id_document==="goodsReceivedNoteItemDetail"){
                var ids = jQuery("#goodsReceivedNotePurchaseOrderDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idt = jQuery("#dlgSearch_purchaseOrder_grid").jqGrid('getDataIDs'); 
                var purchaseOrderItemDeliveryLastRowId = ids.length;
                var purchaseOrderItemDetailLastRowId = idt.length;

                for(var i=0; i<ids.length; i++){
                    var data = $("#goodsReceivedNotePurchaseOrderDetailInput_grid",opener.document).jqGrid('getRowData',ids[i]);
                    var defRow = {
                        purchaseOrderDetailCode               : data.goodsReceivedNotePurchaseOrderDetailPurchaseOrderDetailCode,
                        itemAlias                             : data.goodsReceivedNotePurchaseOrderDetailItemAlias,
                        itemMaterialSerialStatus              : data.goodsReceivedNotePurchaseOrderDetailSerialStatus,
                        purchaseOrderQuantity                 : data.goodsReceivedNotePurchaseOrderDetailQuantity,
                        receivedQuantity                      : data.goodsReceivedNotePurchaseOrderDetailReceivedQuantity,
                        unitOfMeasureCode                     : data.goodsReceivedNotePurchaseOrderDetailUnitOfMeasureCode,
                        remark                                : data.goodsReceivedNotePurchaseOrderDetailRemark,
                        rackCode                              : data.goodsReceivedNotePurchaseOrderDetailRackCode,
                        rackName                              : data.goodsReceivedNotePurchaseOrderDetailRackName,
                        discPercent                           : data.goodsReceivedNotePurchaseOrderDetailDiscountPercent,
                        discAmount                            : data.goodsReceivedNotePurchaseOrderDetailDiscountAmount,
                        nettPrice                             : data.goodsReceivedNotePurchaseOrderDetailNettPrice,
                        totalAmount                           : data.goodsReceivedNotePurchaseOrderDetailTotalAmount
                    };
                    purchaseOrderItemDetailLastRowId++;
                    $("#dlgSearch_purchaseOrder_grid").jqGrid("addRowData", purchaseOrderItemDetailLastRowId, defRow);
                    ev.preventDefault();
                }
            }else if(id_document === "goodsReceivedNoteUpdatePoItemDetail"){
                var ids = jQuery("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idt = jQuery("#dlgSearch_purchaseOrder_grid").jqGrid('getDataIDs'); 
                var purchaseOrderItemDeliveryLastRowId = ids.length;
                var purchaseOrderItemDetailLastRowId = idt.length;

                for(var i=0; i<ids.length; i++){
                    var data = $("#goodsReceivedNoteUpdatePoPurchaseOrderDetailInput_grid",opener.document).jqGrid('getRowData',ids[i]);
                    var defRow = {
                        purchaseOrderDetailCode               : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailPurchaseOrderDetailCode,
                        itemAlias                             : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailItemAlias,
                        itemMaterialSerialStatus              : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailSerialStatus,
                        purchaseOrderQuantity                 : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailQuantity,
                        receivedQuantity                      : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailReceivedQuantity,
                        unitOfMeasureCode                     : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailUnitOfMeasureCode,
                        remark                                : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailRemark,
                        rackCode                              : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailRackCode,
                        rackName                              : data.goodsReceivedNoteUpdatePoPurchaseOrderDetailRackName
                    };
                    purchaseOrderItemDetailLastRowId++;
                    $("#dlgSearch_purchaseOrder_grid").jqGrid("addRowData", purchaseOrderItemDetailLastRowId, defRow);
                }       ev.preventDefault();
            }
            $("#dlgSearch_purchaseOrder_grid").trigger("reloadGrid");
        });
  
    });
    
    function alertMsg(txt_message){
        var dynamicDialog= $(
        '<div id="conformBoxError">'+
            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
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
     function formatDate(){
        var firstDate=$("#purchaseOrderTemp\\.firstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#purchaseOrderTemp\\.firstDate").val(firstDateFormat);

        var lastDate=$("#purchaseOrderTemp\\.lastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#purchaseOrderTemp\\.lastDate").val(lastDateFormat);
    }
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmPurchaseOrderSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="purchaseOrderTemp.code" name="purchaseOrderTemp.code" label="Code "></s:textfield>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_PurchaseOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_purchaseOrder_grid"
            dataType="json"
            href="%{remoteurlPurchaseOrderSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listPurchaseOrder"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuPurchaseOrder').width()"
        >
            <sjg:gridColumn
                name="purchaseOrderDetailCode" index="purchaseOrderDetailCode" key="purchaseOrderDetailCode" title="Purchase Order Material Code" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemAlias" index="itemAlias" key="itemAlias" title="Item Alias" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="purchaseOrderQuantity" index="purchaseOrderQuantity" key="purchaseOrderQuantity" title="Purchase Order Quantity" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="receivedQuantity" index="receivedQuantity" key="receivedQuantity" title="Purchase Order Received Quantity" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="Unit Of Measure Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="Rack Name" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="discPercent" index="discPercent" key="discPercent" title="Discount Percent" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="discAmount" index="discAmount" key="discAmount" title="Disc Amount" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="nettPrice" index="nettPrice" key="nettPrice" title="Nett Price" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="totalAmount" index="totalAmount" key="totalAmount" title="Total Amount" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgPurchaseOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgPurchaseOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


