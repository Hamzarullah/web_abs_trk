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
    
    var search_itemMaterial_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_ivt='<%= request.getParameter("idivt") %>';
    var id_item_division='<%= request.getParameter("idtype") %>';   
        
    jQuery(document).ready(function(){  
        
        $("#dlgItemMaterial_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_itemMaterial_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ItemMaterial!");
                return;
            }

            var data_search_itemMaterial = $("#dlgSearch_itemMaterial_grid").jqGrid('getRowData', selectedRowId);
            
            if (search_itemMaterial_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                    switch(id_document){
                        case "purchaseRequestDetail":
                            if(data_search_itemMaterial.code === dataOpener.purchaseRequestDetailItemStockCode){
                                alertMsg("Item Code "+data_search_itemMaterial.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "adjustmentInItemDetail":
                            if(data_search_itemMaterial.code === dataOpener.adjustmentInItemDetailItemCode){
                                alertMsg("Item Code "+data_search_itemMaterial.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "inventoryOutItemDetail":
                            if(data_search_itemMaterial.code === dataOpener.inventoryOutItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_itemMaterial.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "warehouseMutationItemDetail":
                            if(data_search_itemMaterial.code === dataOpener.warehouseMutationItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_itemMaterial.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "popInstallationItemDetail":
                            if(data_search_itemMaterial.code === dataOpener.popInstallationItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_itemMaterial.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                        case "customerInstallationItemDetail":
                            if(data_search_itemMaterial.code === dataOpener.customerInstallationItemDetailItemStockCode){
                                alertMsg("Item Code "+data_search_itemMaterial.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break;
                    }
                }
       
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemMaterialCode",opener.document).val(data_search_itemMaterial.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialCode", data_search_itemMaterial.code);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemMaterialName", data_search_itemMaterial.name);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"UnitOfMeasureCode", data_search_itemMaterial.unitOfMeasureCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"UnitOfMeasureName", data_search_itemMaterial.unitOfMeasureName);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemMaterial.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemMaterial.name);
            }

            window.close();
        });


        $("#dlgItemMaterial_cancelButton").click(function(ev) { 
            data_search_itemMaterial = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemMaterialSearch").click(function(ev) {
            $("#dlgSearch_itemMaterial_grid").jqGrid("setGridParam",{url:"master/item-material-search?" + $("#frmItemMaterialSearch").serialize(), page:1});
            $("#dlgSearch_itemMaterial_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlItemMaterialSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemMaterialSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="itemMaterial.code" name="itemMaterial.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="itemMaterial.name" name="itemMaterial.name" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemMaterialSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="itemMaterialSearchActiveStatus" name="itemMaterialSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_itemMaterial_grid"
                dataType="json"
                href="%{remoteurlItemMaterialSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemMaterialTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuitemMaterial').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="unitOfMeasureCode" index="unitOfMeasureCode" title="Unit Of Measure Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="unitOfMeasureName" index="unitOfMeasureName" title="Unit Of Measure Name" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemMaterial_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemMaterial_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>