
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
       
    var search_item_division= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';  
    var id_ivt='<%= request.getParameter("idivt") %>';  
    var id_item_division='<%= request.getParameter("idtype") %>';  
    
    jQuery(document).ready(function(){  
        $("#dlgItem_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_item_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Item!");
                return;
            }

            var data_search_item = $("#dlgSearch_item_grid").jqGrid('getRowData', selectedRowId);

            if (search_item_division === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                    switch(id_document){
//                        case "billOfMaterialComponent":
//                            if(data_search_item.code === dataOpener.purchaseRequestDetailItemStockCode){
//                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
//                                return;
//                            }
//                            break;
                        case "purchaseRequestDetail":
                            if(data_search_item.code === dataOpener.purchaseRequestDetailItemStockCode){
                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "adjustmentInItemDetail":
                            if(data_search_item.code === dataOpener.adjustmentInItemDetailItemCode){
                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "inventoryOutItemDetail":
                            if(data_search_item.code === dataOpener.inventoryOutItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
//                        case "invoicePostingDetail":
//                            if(data_search_item.code === dataOpener.invoicePostingDetailItemSalesCode){
//                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
//                                return;
//                            }
//                            break;
                        case "warehouseMutationItemDetail":
                            if(data_search_item.code === dataOpener.warehouseMutationItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "popInstallationItemDetail":
                            if(data_search_item.code === dataOpener.popInstallationItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "customerInstallationItemDetail":
                            if(data_search_item.code === dataOpener.customerInstallationItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_item.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                    }
                }
                
                
                var item_coa_code="";
                var item_coa_name="";
//                switch(id_subdoc){
//                    case "ItemSales":
//                        item_coa_code=data_search_item.salesChartOfAccountCode;
//                        item_coa_name=data_search_item.salesChartOfAccountName;
//                        break;
//                    case "ItemStock":
//                        item_coa_code=data_search_item.stockChartOfAccountCode;
//                        item_coa_name=data_search_item.stockChartOfAccountName;
//                        break;
//                }
                
                
                $("#"+selectedRowID+"_"+id_document+id_subdoc+"Code",opener.document).val(data_search_item.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"CodeTemp", data_search_item.code);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Name", data_search_item.name); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"MinStock", data_search_item.minStock);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"MaxStock", data_search_item.maxStock);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"OnHandStock", data_search_item.onHandStock);
//                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"ChartOfAccountCode", item_coa_code);           
//                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"ChartOfAccountName", item_coa_name);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"UnitOfMeasureCode", data_search_item.unitOfMeasureCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"UOM", data_search_item.unitOfMeasureCode);   
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"UnitOfMeasureName", data_search_item.unitOfMeasureName);           
//                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"SerialNoStatus", data_search_item.serialNoStatus);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"InventoryType", data_search_item.inventoryType);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"ProductSubCategoryCode", data_search_item.itemProductSubCategoryCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"ProductSubCategoryName", data_search_item.itemProductSubCategoryName);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"ProductCategoryCode", data_search_item.itemProductCategoryCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"ProductCategoryName", data_search_item.itemProductCategoryName);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"DivisionCode", data_search_item.itemDivisionCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"DivisionName", data_search_item.itemDivisionName);           

            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_item.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_item.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemProductSubCategory\\.code",opener.document).val(data_search_item.itemProductSubCategoryCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemProductSubCategory\\.name",opener.document).val(data_search_item.itemProductSubCategoryName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemProductSubCategory\\.itemProductCategory\\.code",opener.document).val(data_search_item.itemProductCategoryCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemProductSubCategory\\.itemProductCategory\\.name",opener.document).val(data_search_item.itemProductCategoryName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemProductSubCategory\\.itemProductCategory\\.itemDivision\\.code",opener.document).val(data_search_item.itemDivisionCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemProductSubCategory\\.itemProductCategory\\.itemDivision\\.name",opener.document).val(data_search_item.itemDivisionName);
            }
            
            window.close();
        });

        $("#dlgItem_cancelButton").click(function(ev) { 
            data_search_item = null;
            window.close();
        });
    
        $("#btn_dlg_ItemSearch").click(function(ev) {
            $("#dlgSearch_item_grid").jqGrid("setGridParam",{url:"master/item-data-search?" + $("#frmItemSearch").serialize(), page:1});
            $("#dlgSearch_item_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#itemSearchInventoryType").val(id_ivt);
        $("#itemSearchItemDivision").val(id_item_division);
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
        <s:form id="frmItemSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="itemSearchCode" name="itemSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="itemSearchName" name="itemSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ItemSearch" button="true">Search</sj:a></td>
            </tr>
            <td align="right">
                <s:textfield id="itemSearchActiveStatus" name="itemSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                <s:textfield id="itemSearchInventoryType" name="itemSearchInventoryType" readonly="false" size="5" style="display:none"></s:textfield>
                <s:textfield id="itemSearchItemDivision" name="itemSearchItemDivision" readonly="false" size="5" style="display:none"></s:textfield>
            </td>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_item_grid"
            dataType="json"
            href="%{remoteurlItemSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listItemTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuitem').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="350" sortable="true"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" title="Unit" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="unitOfMeasureName" index="unitOfMeasureName" title="Unit" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="inventoryType" index="inventoryType" title="InventoryType" width="100" sortable="true"
            />
             <sjg:gridColumn
                name="minStock" index="minStock" title="Min Stock" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="maxStock" index="maxStock" title="Max Stock" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="onHandStock" index="onHandStock" title="On Hand Stock" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="itemProductSubCategoryCode" index="itemProductSubCategoryCode" title="itemProductSubCategoryCode" width="330" sortable="true"
            />
            <sjg:gridColumn
                name="itemProductSubCategoryName" index="itemProductSubCategoryName" title="itemProductCategoryName" width="330" sortable="true"
            />
            <sjg:gridColumn
                name="itemProductCategoryCode" index="itemProductCategoryCode" title="Item Product Category Code" width="330" sortable="true"
            />
            <sjg:gridColumn
                name="itemProductCategoryName" index="itemProductCategoryName" title="Item Product Category Name" width="330" sortable="true"
            />
            <sjg:gridColumn
                name="itemDivisionCode" index="itemDivisionCode" title="Item Division Code" width="330" sortable="true"
            />
            <sjg:gridColumn
                name="itemDivisionName" index="itemDivisionName" title="Item Division Name" width="330" sortable="true"
            />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgItem_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgItem_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


