<%-- 
    Document   : search-poItemDelivery
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
       
    var search_poItemDelivery= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>'; 
    jQuery(document).ready(function(){  
        
        $("#dlgPoItemDelivery_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_poItemDelivery_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }

            var data_search_poItemDelivery = $("#dlgSearch_poItemDelivery_grid").jqGrid('getRowData', selectedRowId);

            if (search_poItemDelivery === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
//                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
//                
//                for(var j=0;j<idsOpener.length;j++){
//                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
//                    
//                    if(data_search_poItemDelivery.code === dataOpener.customerPurchaseOrderPoItemDeliveryCode){
//                        alertMsg("Sales Quotation "+data_search_poItemDelivery.code+" Has Been Existing In Grid!");
//                        return;
//                    }
//                }
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialCode", data_search_poItemDelivery.itemMaterialCode);         
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialName", data_search_poItemDelivery.itemMaterialName); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Quantity", data_search_poItemDelivery.quantity); 
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_poItemDelivery.code);
            }
//            if(id_document==="customerPurchaseOrderItemDelivery"){
//                window.opener.sortNoDelivery(data_search_poItemDelivery.itemDetail);
//            }
            window.close();
        });

        $("#dlgPoItemDelivery_cancelButton").click(function(ev) { 
            data_search_poItemDelivery = null;
            window.close();
        });
        
    
        $("#btn_dlg_PoItemDeliverySearch").click(function(ev) {
            $("#dlgSearch_poItemDelivery_grid").jqGrid("clearGridData");
            if(id_document==="purchaseOrderItemDelivery"){
                var ids = jQuery("#purchaseOrderDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idt = jQuery("#dlgSearch_poItemDelivery_grid").jqGrid('getDataIDs'); 
                var purchaseOrderItemDetailLastRowId = idt.length;

                for(var i=0; i<ids.length; i++){
                    var data = $("#purchaseOrderDetailInput_grid",opener.document).jqGrid('getRowData',ids[i]);
                    var defRow = {
                        itemMaterialCode              : data.purchaseOrderDetailItemMaterialCode,
                        itemMaterialName              : data.purchaseOrderDetailItemMaterialName,
                        quantity                      : data.purchaseOrderDetailQuantity
                    };
                    purchaseOrderItemDetailLastRowId++;
                    $("#dlgSearch_poItemDelivery_grid").jqGrid("addRowData", purchaseOrderItemDetailLastRowId, defRow);
                    ev.preventDefault();
                }
            }else if(id_document==="purchaseOrderUpdateInformationItemDelivery"){
                var idl = jQuery("#purchaseOrderUpdateInformationDetailViewInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idp = jQuery("#purchaseOrderUpdateInformationDetailInput_grid",opener.document).jqGrid('getDataIDs'); 
                var idj = jQuery("#dlgSearch_poItemDelivery_grid").jqGrid('getDataIDs');
                var purchaseOrderUpdateInformationItemDetailLastRowId = idj.length;
//                alert(customerPurchaseOrderToBlanketOrderItemDeliveryLastRowId);
//                alert(customerPurchaseOrderToBlanketOrderLastRowId);
//                return;
    
                for(var j=0; j<idl.length; j++){
                    var data = $("#purchaseOrderUpdateInformationDetailViewInput_grid",opener.document).jqGrid('getRowData',idl[j]);
                    var defRow = {
                        itemMaterialCode              : data.purchaseOrderUpdateInformationDetailViewItemMaterialCode,
                        itemMaterialName              : data.purchaseOrderUpdateInformationDetailViewItemMaterialName,
                        quantity                      : data.purchaseOrderUpdateInformationDetailViewQuantity
                    };
                    
                    purchaseOrderUpdateInformationItemDetailLastRowId++;
                    $("#dlgSearch_poItemDelivery_grid").jqGrid("addRowData", purchaseOrderUpdateInformationItemDetailLastRowId, defRow);
                    ev.preventDefault();
                }
                
                for(var k=0; k<idp.length; k++){
                    var data = $("#purchaseOrderUpdateInformationDetailInput_grid",opener.document).jqGrid('getRowData',idp[k]);
                    var defRow1 = {
                        itemMaterialCode              : data.purchaseOrderUpdateInformationDetailInputItemMaterialCode,
                        itemMaterialName              : data.purchaseOrderUpdateInformationDetailInputItemMaterialName,
                        quantity                      : data.purchaseOrderUpdateInformationDetailInputQuantity
                    };
                    
                    purchaseOrderUpdateInformationItemDetailLastRowId++;
                    $("#dlgSearch_poItemDelivery_grid").jqGrid("addRowData", purchaseOrderUpdateInformationItemDetailLastRowId, defRow1);
                    ev.preventDefault();
                }
            }
            $("#dlgSearch_poItemDelivery_grid").trigger("reloadGrid");
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
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmPoItemDeliverySearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="poItemDeliveryTemp.code" name="poItemDeliveryTemp.code" label="Code "></s:textfield>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_PoItemDeliverySearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_poItemDelivery_grid"
            dataType="json"
            href="%{remoteurlPoItemDeliverySearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listPoItemDeliveryTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuPoItemDelivery').width()"
        >
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Material Code" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Material Name" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" 
                width="150" align="right" editable="true" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgPoItemDelivery_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgPoItemDelivery_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


