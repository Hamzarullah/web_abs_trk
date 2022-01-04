<%-- 
    Document   : search-purchase-order-by-grn
    Created on : Jul 21, 2020, 10:56:46 AM
    Author     : Rayis
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
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
        
        .ui-dialog-titlebar-close {
            visibility: hidden;
        }
    </style>
    
<script type = "text/javascript">
    
    var search_purchaseOrder_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    var id_transaction_status = '<%= request.getParameter("idTranStatus") %>';
    var id_item_division = '<%= request.getParameter("idItemDivision") %>';
    var id_inv_type = '<%= request.getParameter("idInvType") %>';
    
    jQuery(document).ready(function(){
        
        $.subscribe("dlgSearchPurchaseOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#dlgSearch_purchaseOrder_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseOrder = $("#dlgSearch_purchaseOrder_grid").jqGrid("getRowData", selectedRowID);
            $("#dlgSearch_purchaseOrderDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-order-detail-data?purchaseOrder.code=" + purchaseOrder.code});
            $("#dlgSearch_purchaseOrderDetail_grid").jqGrid("setCaption", "PURCHASE ORDER DETAIL : " + purchaseOrder.code);
            $("#dlgSearch_purchaseOrderDetail_grid").trigger("reloadGrid");
        });
        
        $("#dlgPurchaseOrder_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_purchaseOrder_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alertMsg("Please Select Row Purchase!");
                return;
            }

            var data_search_purchaseOrder = $("#dlgSearch_purchaseOrder_grid").jqGrid('getRowData', selectedRowId);
                        
            if (search_purchaseOrder_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"PurchaseOrderPODNo",opener.document).val(data_search_purchaseOrder.PODNo);
           
            }else{
                $("#"+id_document+"\\.purchaseOrder\\.code",opener.document).val(data_search_purchaseOrder.code);
                $("#"+id_document+"\\.branch\\.code",opener.document).val(data_search_purchaseOrder.branchCode);
                $("#"+id_document+"\\.branch\\.name",opener.document).val(data_search_purchaseOrder.branchName);
                $("#"+id_document+"\\.purchaseOrder\\.transactionDate",opener.document).val(data_search_purchaseOrder.transactionDate);
                $("#"+id_document+"\\.vendor\\.code",opener.document).val(data_search_purchaseOrder.vendorCode);
                $("#"+id_document+"\\.vendor\\.name",opener.document).val(data_search_purchaseOrder.vendorName);
                $("#"+id_document+"\\.vendor\\.defaultContactPerson\\.name",opener.document).val(data_search_purchaseOrder.vendorDefaultContactPersonName);
                $("#"+id_document+"\\.vendor\\.address",opener.document).val(data_search_purchaseOrder.vendorAddress);
                $("#"+id_document+"\\.vendor\\.phone1",opener.document).val(data_search_purchaseOrder.vendorPhone1);
                $("#"+id_document+"\\.vendor\\.phone2",opener.document).val(data_search_purchaseOrder.vendorPhone2);
                $("#"+id_document+"\\.currency\\.code",opener.document).val(data_search_purchaseOrder.currencyCode);
                $("#"+id_document+"\\.currency\\.name",opener.document).val(data_search_purchaseOrder.currencyName);
//                 $("#"+id_document+"\\.expedition\\.code",opener.document).val(data_search_purchaseOrder.expeditionCode);
//                $("#"+id_document+"\\.expedition\\.name",opener.document).val(data_search_purchaseOrder.expeditionName);
                $("#"+id_document+"\\.discountPercent",opener.document).val(data_search_purchaseOrder.discountPercent);                
                $("#"+id_document+"\\.vatPercent",opener.document).val(data_search_purchaseOrder.vatPercent);
//                $("#"+id_document+"\\.remark",opener.document).val(data_search_purchaseOrder.remark);
                window.opener.goodsReceivedNoteValidateExchangeRate(data_search_purchaseOrder.currencyCode);
            }   
            window.close();
        });

        $("#dlgPurchaseOrder_cancelButton").click(function(ev) { 
            data_search_purchaseOrder = null;
            window.close();
        });
    
        $("#btn_dlg_PurchaseOrderSearch").click(function(ev) {
            formatDateSeachPOByGrn();
            $("#dlgSearch_purchaseOrderDetail_grid").jqGrid("clearGridData");
            $("#dlgSearch_purchaseOrderDetail_grid").jqGrid("setCaption", "PURCHASE ORDER DETAIL");
            $("#dlgSearch_purchaseOrder_grid").jqGrid("setGridParam",{url:"purchasing/purchase-order-search-data?" + $("#frmPurchaseOrderSearch").serialize(), page:1});
            $("#dlgSearch_purchaseOrder_grid").trigger("reloadGrid");
            formatDateSeachPOByGrn();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#purchaseOrderSearchFirstDate").val(firstDateFormat);
        $("#purchaseOrderSearchLastDate").val(lastDateFormat);
        
        $("#purchaseOrderSearchTransactionStatus").val(id_transaction_status);
        $("#purchaseOrderSearchInventoryType").val(id_inv_type);
    });
    
    function formatDateSeachPOByGrn(){
         var firstDate=$("#purchaseOrderSearchFirstDate").val().split("/");
         var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
         var lastDate=$("#purchaseOrderSearchLastDate").val().split("/");
         var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];

         $("#purchaseOrderSearchFirstDate").val(firstDateFormat);
         $("#purchaseOrderSearchLastDate").val(lastDateFormat);
    }
    
    function alertMsg(alert_message){
        var dynamicDialog= $(
            '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+alert_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>' +
            '</div>');

        dynamicDialog.dialog({
            title           : "Attention!",
            closeOnEscape   : false,
            modal           : true,
            width           : 400,
            resizable       : false,
            closeText       : "hide",
            buttons         : 
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
    <s:url id="remoteurlPurchaseOrderSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmPurchaseOrderSearch">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td align="right" width="80px"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="purchaseOrderSearchFirstDate" name="purchaseOrderSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseOrderSearchLastDate" name="purchaseOrderSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>    
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="purchaseOrderSearchCode" name="purchaseOrderSearchCode" label="PODNo" placeHolder=" POD No"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Vendor</td>
                    <td>
                        <s:textfield id="purchaseOrderVendorSearchCode" name="purchaseOrderVendorSearchCode" placeHolder=" code" size="15"></s:textfield>
                        <s:textfield id="purchaseOrderVendorSearchName" name="purchaseOrderVendorSearchName" placeHolder=" name" size="25"></s:textfield>
                    </td>        
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
            caption="PURCHASE ORDER"
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
            width="$('#tabmnupurchaseorder').width()"
            onSelectRowTopics="dlgSearchPurchaseOrder_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="120" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="300" sortable="true"
            />
            <sjg:gridColumn
                name="vendorAddress" index="vendorAddress" key="vendorAddress" title="Vendor Address" width="300" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="vendorPhone1" index="vendorPhone1" key="vendorPhone1" title="Vendor Phone1" width="300" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="vendorPhone2" index="vendorPhone2" key="vendorPhone2" title="Vendor Phone2" width="300" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="vendorDefaultContactPersonName" index="vendorDefaultContactPersonName" key="vendorDefaultContactPersonName" title="Contact Person" width="200" sortable="true" hidden="true"
            />
              <sjg:gridColumn
                name="expeditionCode" index="expeditionCode" key="expeditionCode" title="Expedition Code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="expeditionName" index="expeditionName" key="expeditionName" title="Expedition Name" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="50" sortable="true" align="center" hidden="true"
            />
            <sjg:gridColumn
                name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="50" sortable="true" align="center" hidden="true"
            />
            <sjg:gridColumn
                name="totalTransactionAmount" index="totalTransactionAmount" key="totalTransactionAmount" title="TotalTransactionAmount" width="100" sortable="true" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="discountAmount" index="discountAmount" key="discountAmount" title="DiscountAmount" width="100" sortable="true" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="discountPercent" index="discountPercent" key="discountPercent" title="DiscountPercent" width="100" sortable="true" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="vatAmount" index="vatAmount" key="vatAmount" title="VAt Amount" width="100" sortable="true" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="vatPercent" index="vatPercent" key="vatPercent" title="VAT Percent" width="100" sortable="true" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" title="GrandTotalAmount" width="100" sortable="true" align="right" hidden="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    <div id="dlgSearchPurchaseOrderDetailGrid">
        <sjg:grid
            id="dlgSearch_purchaseOrderDetail_grid"
            caption="PURCHASE ORDER DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseOrderDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupurchaseorder').width()"
        > 
          
            <sjg:gridColumn
                name = "itemMaterialCode" id="itemMaterialCode" index = "itemMaterialCode" key = "itemMaterialCode" title = "Item Material Code" width = "130" sortable = "false"
            />
            <sjg:gridColumn
                name = "itemMaterialName" index = "itemMaterialName" key = "itemMaterialName" title = "Item Material Name" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "itemAlias" index = "itemAlias" key = "itemAlias" title = "Item Alias" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "quantity" index = "quantity" key = "quantity" title = "Quantity" formatter="number" width = "100" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name = "unitOfMeasureCode" index = "unitOfMeasureCode" key = "unitOfMeasureCode" title = "Unit" width = "80" sortable = "false" align="center"
            />
            <sjg:gridColumn
                name = "remark" index = "remark" key = "remark" title = "Remark" width = "180" sortable = "false" align="center"
            />
             <sjg:gridColumn
                name = "purchaseRequestCode" index = "purchaseRequestCode" key = "purchaseRequestCode" title = "Purchase Request Code" width = "150" sortable = "false" align="center"
            />
             
        </sjg:grid >
    </div>
    <br class="spacer" />
    <sj:a href="#" id="dlgPurchaseOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgPurchaseOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>