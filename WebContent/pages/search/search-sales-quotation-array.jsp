<%-- 
    Document   : search-salesQuotation
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
    </style>
    
    
<script type = "text/javascript">
       
    var search_salesQuotation= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>'; 
    jQuery(document).ready(function(){  
        
        $("#dlgSalesQuotation_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_salesQuotation_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }

            var data_search_salesQuotation = $("#dlgSearch_salesQuotation_grid").jqGrid('getRowData', selectedRowId);

            if (search_salesQuotation === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
//                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
//                
//                for(var j=0;j<idsOpener.length;j++){
//                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
//                    
//                    if(data_search_salesQuotation.code === dataOpener.customerPurchaseOrderSalesQuotationCode){
//                        alertMsg("Sales Quotation "+data_search_salesQuotation.code+" Has Been Existing In Grid!");
//                        return;
//                    }
//                }
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SalesQuotationCode", data_search_salesQuotation.salesQuotationCode);         
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsCode", data_search_salesQuotation.itemFinishGoodsCode); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsRemark", data_search_salesQuotation.itemFinishGoodsRemark); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SortNo", data_search_salesQuotation.sortNo); 
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_salesQuotation.code);
            }
//            if(id_document==="customerPurchaseOrderItemDelivery"){
//                window.opener.sortNoDelivery(data_search_salesQuotation.itemDetail);
//            }
            window.close();
        });

        $("#dlgSalesQuotation_cancelButton").click(function(ev) { 
            data_search_salesQuotation = null;
            window.close();
        });
        
        /**
 * Comment
 */
//        function listData(data) {
//            list_arr = data;
//        }
    
        $("#btn_dlg_SalesQuotationSearch").click(function(ev) {
//            formatDate();
//            var arr = window.opener.reqstSQArry();
//            for(var o in arr){
//                alert(arr[o].name);
//            }
            
//            var selectedRowID = $("#customerPurchaseOrderItemDetailInput_grid",opener.document).jqGrid("getGridParam", "selrow");
//            var idsOpener = $("#customerPurchaseOrderItemDetailInput_grid",opener.document).jqGrid('getDataIDs');
//            var data = $("#customerPurchaseOrderItemDetailInput_grid",opener.document).jqGrid('getRowData',idsOpener[1]); 
//            alert(data.customerPurchaseOrderItemDetailQuotationNo+" "+data.customerPurchaseOrderItemDetailSortNo);
//            return;
            
            //test ulla
            $("#dlgSearch_salesQuotation_grid").jqGrid("clearGridData");
            if(id_document==="customerPurchaseOrderItemDelivery"){
                var ids = jQuery("#customerPurchaseOrderItemDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idt = jQuery("#dlgSearch_salesQuotation_grid").jqGrid('getDataIDs'); 
                var customerPurchaseOrderItemDeliveryLastRowId = ids.length;
                var customerPurchaseOrderItemDetailLastRowId = idt.length;
    //            alert(customerPurchaseOrderItemDeliveryLastRowId);
    //            alert(customerPurchaseOrderItemDetailLastRowId);
    //            return;

                for(var i=0; i<ids.length; i++){
                    var data = $("#customerPurchaseOrderItemDetailInput_grid",opener.document).jqGrid('getRowData',ids[i]);
                    var defRow = {
                        salesQuotationCode              : data.customerPurchaseOrderItemDetailQuotationNo,
                        refNo                           : data.customerPurchaseOrderItemDetailQuotationRefNo,
                        itemFinishGoodsCode             : data.customerPurchaseOrderItemDetailItemFinishGoodsCode,
                        itemFinishGoodsRemark           : data.customerPurchaseOrderItemDetailItemFinishGoodsRemark,
                        sortNo                          : data.customerPurchaseOrderItemDetailSortNo,
                        quantity                        : data.customerPurchaseOrderItemDetailQuantity
                    };
                    customerPurchaseOrderItemDetailLastRowId++;
                    $("#dlgSearch_salesQuotation_grid").jqGrid("addRowData", customerPurchaseOrderItemDetailLastRowId, defRow);
                    ev.preventDefault();
                }
            }else if(id_document==="customerPurchaseOrderToBlanketOrderItemDelivery"){
                var idl = jQuery("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idj = jQuery("#dlgSearch_salesQuotation_grid").jqGrid('getDataIDs');
                var customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId = idl.length;
                var customerPurchaseOrderToBlanketOrderLastRowId = idj.length;
//                alert(customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId);
//                alert(customerPurchaseOrderToBlanketOrderLastRowId);
//                return;
    
                for(var j=0; j<idl.length; j++){
                    var data = $("#customerPurchaseOrderToBlanketOrderItemDetailInput_grid",opener.document).jqGrid('getRowData',idl[j]);
                    var defRow = {
                        salesQuotationCode              : data.customerPurchaseOrderToBlanketOrderItemDetailQuotationNo,
                        refNo                           : data.customerPurchaseOrderToBlanketOrderItemDetailQuotationRefNo,
                        itemFinishGoodsCode             : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsCode,
                        itemFinishGoodsRemark           : data.customerPurchaseOrderToBlanketOrderItemDetailItemFinishGoodsRemark,
                        sortNo                          : data.customerPurchaseOrderToBlanketOrderItemDetailSortNo,
                        quantity                        : data.customerPurchaseOrderToBlanketOrderItemDetailQuantity
                    };
                    customerPurchaseOrderToBlanketOrderLastRowId++;
                    $("#dlgSearch_salesQuotation_grid").jqGrid("addRowData", customerPurchaseOrderToBlanketOrderLastRowId, defRow);
                    ev.preventDefault();
                }
            }else if(id_document==="customerPurchaseOrderReleaseItemDelivery"){
                var ids = jQuery("#customerPurchaseOrderReleaseItemDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idt = jQuery("#dlgSearch_salesQuotation_grid").jqGrid('getDataIDs'); 
                var customerPurchaseOrderReleaseItemDeliveryLastRowId = ids.length;
                var customerPurchaseOrderReleaseLastRowId = idt.length;
//                alert(customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId);
//                alert(customerPurchaseOrderToBlanketOrderLastRowId);
//                return;
    
                for(var k=0; k<ids.length; k++){
                    var data = $("#customerPurchaseOrderReleaseItemDetailInput_grid",opener.document).jqGrid('getRowData',ids[k]);
                    var defRow = {
                        salesQuotationCode              : data.customerPurchaseOrderReleaseItemDetailQuotationNo,
                        refNo                           : data.customerPurchaseOrderReleaseItemDetailQuotationRefNo,
                        itemFinishGoodsCode             : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsCode,
                        itemFinishGoodsRemark           : data.customerPurchaseOrderReleaseItemDetailItemFinishGoodsRemark,
                        sortNo                          : data.customerPurchaseOrderReleaseItemDetailSortNo,
                        quantity                        : data.customerPurchaseOrderReleaseItemDetailQuantity
                    };
                    customerPurchaseOrderReleaseLastRowId++;
                    $("#dlgSearch_salesQuotation_grid").jqGrid("addRowData", customerPurchaseOrderReleaseLastRowId, defRow);
                    ev.preventDefault();
                }
            }else if(id_document==="blanketOrderItemDelivery"){
                var idq = jQuery("#blanketOrderItemDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idr = jQuery("#dlgSearch_salesQuotation_grid").jqGrid('getDataIDs'); 
                var blanketOrderItemDeliveryLastRowId = idq.length;
                var blanketOrderLastRowId = idr.length;
//                alert(customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId);
//                alert(customerPurchaseOrderToBlanketOrderLastRowId);
//                return;
    
                for(var l=0; l<idq.length; l++){
                    var data = $("#blanketOrderItemDetailInput_grid",opener.document).jqGrid('getRowData',idq[l]);
                    var defRow = {
                        salesQuotationCode              : data.blanketOrderItemDetailQuotationNo,
                        refNo                           : data.blanketOrderItemDetailQuotationRefNo,
                        itemFinishGoodsCode             : data.blanketOrderItemDetailItemFinishGoodsCode,
                        itemFinishGoodsRemark           : data.blanketOrderItemDetailItemFinishGoodsRemark,
                        sortNo                          : data.blanketOrderItemDetailSortNo,
                        quantity                        : data.blanketOrderItemDetailQuantity
                    };
                    blanketOrderLastRowId++;
                    $("#dlgSearch_salesQuotation_grid").jqGrid("addRowData", blanketOrderLastRowId, defRow);
                    ev.preventDefault();
                }
            }else if(id_document==="salesOrderItemDelivery"){
                var idj = jQuery("#salesOrderItemDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idk = jQuery("#dlgSearch_salesQuotation_grid").jqGrid('getDataIDs'); 
                var salesOrderItemDeliveryLastRowId = idj.length;
                var salesOrderLastRowId = idk.length;
//                alert(customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId);
//                alert(customerPurchaseOrderToBlanketOrderLastRowId);
//                return;
    
                for(var i=0; i<idj.length; i++){
                    var data = $("#salesOrderItemDetailInput_grid",opener.document).jqGrid('getRowData',idj[i]);
                    var defRow = {
                        salesQuotationCode              : data.salesOrderItemDetailQuotationNo,
                        refNo                           : data.salesOrderItemDetailQuotationRefNo,
                        itemFinishGoodsCode             : data.salesOrderItemDetailItemFinishGoodsCode,
                        itemFinishGoodsRemark           : data.salesOrderItemDetailItemFinishGoodsRemark,
                        sortNo                          : data.salesOrderItemDetailSortNo,
                        quantity                        : data.salesOrderItemDetailQuantity
                    };
                    salesOrderLastRowId++;
                    $("#dlgSearch_salesQuotation_grid").jqGrid("addRowData", salesOrderLastRowId, defRow);
                    ev.preventDefault();
                }
            }
            $("#dlgSearch_salesQuotation_grid").trigger("reloadGrid");
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
        var firstDate=$("#salesQuotationTemp\\.firstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#salesQuotationTemp\\.firstDate").val(firstDateFormat);

        var lastDate=$("#salesQuotationTemp\\.lastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#salesQuotationTemp\\.lastDate").val(lastDateFormat);
    }
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmSalesQuotationSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="salesQuotationTemp.code" name="salesQuotationTemp.code" label="Code "></s:textfield>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_SalesQuotationSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_salesQuotation_grid"
            dataType="json"
            href="%{remoteurlSalesQuotationSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listSalesQuotationTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuSalesQuotation').width()"
        >
            <sjg:gridColumn
                name="salesQuotationCode" index="salesQuotationCode" key="salesQuotationCode" title="Quotation No" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="sortNo" index="sortNo" key="sortNo" title="Sort No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" key="itemFinishGoodsCode" title="ItemFinishGoodsCode" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsRemark" index="itemFinishGoodsRemark" key="itemFinishGoodsRemark" title="ItemFinishGoodsRemark" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgSalesQuotation_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgSalesQuotation_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


