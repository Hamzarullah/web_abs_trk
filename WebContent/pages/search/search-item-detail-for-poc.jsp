
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
    </style>
    
    
<script type = "text/javascript">
       
    var search_itemDetail_division= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_quotation='<%= request.getParameter("idquotation") %>';  
    
    jQuery(document).ready(function(){  
        
        $("#dlgItemDetail_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_itemDetail_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row ItemDetail!");
                return;
            }

            var data_search_itemDetail = $("#dlgSearch_itemDetail_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemDetail_division === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"QuotationNo", data_search_itemDetail.salesQuotationCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SortNo", data_search_itemDetail.customerPurchaseOrderSortNo); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemCode", data_search_itemDetail.itemCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ValveTag", data_search_itemDetail.valveTag);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"DataSheet", data_search_itemDetail.dataSheet);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Description", data_search_itemDetail.description);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Type", data_search_itemDetail.type);   
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Size", data_search_itemDetail.size);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Rating", data_search_itemDetail.rating);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EndCon", data_search_itemDetail.endCon);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Body", data_search_itemDetail.body);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Ball", data_search_itemDetail.ball);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Seat", data_search_itemDetail.seat);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Stem", data_search_itemDetail.stem);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SeatInsert", data_search_itemDetail.seatInsert);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Seal", data_search_itemDetail.seal);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Bolting", data_search_itemDetail.bolting);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"SeatDesign", data_search_itemDetail.seatDesign);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Oper", data_search_itemDetail.oper);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Note", data_search_itemDetail.note);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Quantity", data_search_itemDetail.quantity);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"UnitPrice", data_search_itemDetail.unitPrice);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"TotalAmount", data_search_itemDetail.totalAmount);

            }
            window.opener.calculateBlanketOrderHeader();
            window.close();
        });

        $("#dlgItemDetail_cancelButton").click(function(ev) { 
            data_search_itemDetail = null;
            window.close();
        });
    
        $("#btn_dlg_ItemDetailSearch").click(function(ev) {
            $("#dlgSearch_itemDetail_grid").jqGrid("setGridParam",{url:"master/customer-purchase-order-item-detail-getgroupby-sales-quotation-data?" + $("#frmItemDetailSearch").serialize(), page:1});
            $("#dlgSearch_itemDetail_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#arrSalesQuotationNo").val(id_quotation);
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
        <s:form id="frmItemDetailSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Quotation No</td>
                <td>
                    <s:textfield id="arrSalesQuotationNo" name="arrSalesQuotationNo" cssStyle="display:none"></s:textfield>
                    <s:textfield id="customerPurchaseOrderItemDetail.salesQuotationCode" name="customerPurchaseOrderItemDetail.salesQuotationCode" label="Quotation No "></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Item</td>
                <td><s:textfield id="customerPurchaseOrderItemDetail.itemCode" name="customerPurchaseOrderItemDetail.itemCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ItemDetailSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_itemDetail_grid"
            dataType="json"
            href="%{remoteurlItemDetailSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerPurchaseOrderItemDetail"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuitemDetail').width()"
        >
            <sjg:gridColumn
                name="salesQuotationCode" index="salesQuotationCode" key="salesQuotationCode" 
                title="Quotation No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="customerPurchaseOrderSortNo" index="customerPurchaseOrderSortNo" 
                title="Sort No" width="80" sortable="true" editable="true" edittype="text"
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
                width="80" align="right" edittype="text" 
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="rating" index="rating" key="rating" title="Rating" 
                width="80" align="right" edittype="text" 
                formatter="number" editrules="{ double: true }"
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
<br></br>
    <sj:a href="#" id="dlgItemDetail_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgItemDetail_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


