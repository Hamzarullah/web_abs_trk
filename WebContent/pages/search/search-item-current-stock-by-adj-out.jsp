
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
    
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
    </style>
    
<script type = "text/javascript">
    
    var search_itemLocation_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_warehouse= '<%= request.getParameter("idwarehouse") %>';
    
    jQuery(document).ready(function(){  
        
        $("#itemCurrentStockSearchWarehouseCode").val(id_warehouse);
        
        $("#dlgItemCurrentStock_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_itemLocation_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ItemCurrentStock!");
                return;
            }

            var data_search_itemLocation = $("#dlgSearch_itemLocation_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemLocation_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemMaterialCode",opener.document).val(data_search_itemLocation.itemMaterialCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialName", data_search_itemLocation.itemMaterialName);              
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialInventoryType", data_search_itemLocation.itemMaterialInventoryType);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RackCode", data_search_itemLocation.rackCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RackName", data_search_itemLocation.rackName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialCogsIdr", data_search_itemLocation.itemCogsIdr);
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemLocation.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemLocation.name);
                $("#"+id_document+"\\.code",opener.document).val(data_search_itemLocation.code);
                $("#"+id_document+"\\.name",opener.document).val(data_search_itemLocation.name);
            }

            window.close();
        });


        $("#dlgItemCurrentStock_cancelButton").click(function(ev) { 
            data_search_itemLocation = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemCurrentStockSearch").click(function(ev) {
            $("#dlgSearch_itemLocation_grid").jqGrid("setGridParam",{url:"master/item-current-stock-by-adj-out-search-data?" + $("#frmItemCurrentStockSearch").serialize(), page:1});
            $("#dlgSearch_itemLocation_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlItemCurrentStockSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemCurrentStockSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Warehouse</td>
                    <td>
                        <s:textfield id="itemCurrentStockSearchWarehouseCode" name="itemCurrentStockSearchWarehouseCode" label=" Code" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Item</td>
                    <td>
                        <s:textfield id="itemCurrentStockSearchItemCode" name="itemCurrentStockSearchItemCode" label=" Code"></s:textfield>
                        <s:textfield id="itemCurrentStockSearchItemName" name="itemCurrentStockSearchItemName" label=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Rack</td>
                    <td>
                        <s:textfield id="itemCurrentStockSearchRackCode" name="itemCurrentStockSearchRackCode" label=" Code"></s:textfield>
                        <s:textfield id="itemCurrentStockSearchRackName" name="itemCurrentStockSearchRackName" label=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemCurrentStockSearch" button="true">Search</sj:a></td>
                </tr>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_itemLocation_grid"
                dataType="json"
                href="%{remoteurlItemCurrentStockSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemCurrentStockTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuItemCurrentStock').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="itemMaterialCode" index="itemMaterialCode" title="Item Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialName" index="itemMaterialName" title="Item Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialInventoryType" index="itemMaterialInventoryType" title="Inventory Type" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="rackCode" index="rackCode" title="Rack Code" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="rackName" index="rackName" title="Rack Name" width="200" sortable="true"
                />
                <sjg:gridColumn
                    name="itemMaterialCogsIdr" index="itemMaterialCogsIdr" title="Item Material CogsIdr" width="200" sortable="true" hidden="true"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemCurrentStock_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemCurrentStock_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>
