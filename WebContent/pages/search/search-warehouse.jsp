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
      
    var search_warehouse_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc='<%= request.getParameter("idsubdoc") %>';
    var id_whm_type='<%= request.getParameter("idtype") %>';
    var id_user= '<%= request.getParameter("iduser") %>';   
    jQuery(document).ready(function(){  
        
        $("#dlgWarehouse_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_warehouse_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Warehouse!");
                return;
            }

            var data_search_warehouse = $("#dlgSearch_warehouse_grid").jqGrid('getRowData', selectedRowId);
//            window.opener.loadpurchaseOrder_selectedChangeWarehouse(data_search_warehouse.code);
            if (search_warehouse_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"WarehouseCode",opener.document).val(data_search_warehouse.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"WarehouseName", data_search_warehouse.name);           
//                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"WarehousePostingGroupCode", data_search_warehouse.warehousePostingGroupCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchCode", data_search_warehouse.branchCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchName", data_search_warehouse.branchName);           
                
                $("#"+selectedRowID+"_"+id_document+id_subdoc+"WarehouseCode",opener.document).val(data_search_warehouse.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"WarehouseName", data_search_warehouse.name);           
//                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"WarehousePostingGroupCode", data_search_warehouse.warehousePostingGroupCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"BranchCode", data_search_warehouse.branchCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"BranchName", data_search_warehouse.branchName);           
            }else {
//                $("#"+id_document+"\\.code",opener.document).val(data_search_warehouse.code);
                if (id_document==="rack"){
                    $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_warehouse.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_warehouse.name);
                }
                else{
                    $("#"+id_document+"\\.name",opener.document).val(data_search_warehouse.name);
//                    $("#"+id_document+"\\.warehousePostingGroup\\.code",opener.document).val(data_search_warehouse.warehousePostingGroupCode);
//                    $("#"+id_document+"\\.warehousePostingGroup\\.name",opener.document).val(data_search_warehouse.warehousePostingGroupName);

                    $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_warehouse.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_warehouse.name);
                    $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_warehouse.address);
                    $("#"+id_document+"\\."+id_subdoc+"\\.rack\\.code",opener.document).val(data_search_warehouse.defaultRackCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.rack\\.name",opener.document).val(data_search_warehouse.defaultRackName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.dockDlnCode",opener.document).val(data_search_warehouse.dockDlnCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.dockDlnName",opener.document).val(data_search_warehouse.dockDlnName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.dockInCode",opener.document).val(data_search_warehouse.dockInCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.dockInName",opener.document).val(data_search_warehouse.dockInName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.warehouse\\.code",opener.document).val(data_search_warehouse.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.warehouse\\.name",opener.document).val(data_search_warehouse.name);
//                    $("#"+id_document+"\\."+id_subdoc+"\\.warehousePostingGroup\\.code",opener.document).val(data_search_warehouse.warehousePostingGroupCode);
//                    $("#"+id_document+"\\."+id_subdoc+"\\.warehousePostingGroup\\.name",opener.document).val(data_search_warehouse.warehousePostingGroupName);

//                if (id_document === "goodsReceivedNotePoCash") {
//                    window.opener.callCheckValid();
//                }
                }
            }

            window.close();
        });

        $("#dlgWarehouse_cancelButton").click(function(ev) { 
            data_search_warehouse = null;
            window.close();
        });
    
        $("#btn_dlg_WarehouseSearch").click(function(ev) {
                $("#dlgSearch_warehouse_grid").jqGrid("setGridParam",{url:"master/warehouse-data?" + $("#frmWarehouseSearch").serialize(), page:1});
            
            $("#dlgSearch_warehouse_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#warehouseSearchWarehouseType").val(id_whm_type);
     });
    
</script>
<body>
<s:url id="remoteurlWarehouseSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmWarehouseSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="warehouseSearchCode" name="warehouseSearchCode" placeHolder=" Code"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td>
                    <s:textfield id="warehouseSearchName" name="warehouseSearchName" size="50" placeHolder=" Name"></s:textfield>
                </td>
                <td align="right">
                    <s:textfield id="warehouseSearchWarehouseType" name="warehouseSearchWarehouseType" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:textfield id="warehouseMutationSearchActiveStatus" name="warehouseMutationSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_WarehouseSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_warehouse_grid"
            dataType="json"
            href="%{remoteurlWarehouseSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listWarehouseTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuwarehouse').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="135" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="400" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" title="branchCode" width="400" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" title="branchName" width="400" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="dockInCode" index="dockInCode" title="Dock In Code" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="dockInName" index="dockInName" title="Dock In Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="dockDlnCode" index="dockDlnCode" title="Dock DLN Code" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="dockDlnName" index="dockDlnName" title="Dock DLN Name" width="200" sortable="true"
            />
             <sjg:gridColumn
                name="address" index="address" key="address" title="Address" width="135" sortable="true"
            />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgWarehouse_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgWarehouse_cancelButton" button="true">Cancel</sj:a>
</body>
</html>