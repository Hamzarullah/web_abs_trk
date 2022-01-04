<%-- 
    Document   : search-bill-of-material-commponent-item
    Created on : Dec 16, 2019, 3:10:22 PM
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
    
    var search_billOfMaterial_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var header_code= '<%= request.getParameter("headercode") %>';
    var finishGoodsQty= '<%= request.getParameter("finishGoodsQty") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgBillOfMaterial_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_billOfMaterialCommponent_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row BillOfMaterial!");
                return;
            }

            var data_search_billOfMaterial = $("#dlgSearch_billOfMaterialCommponent_grid").jqGrid('getRowData', selectedRowId);

            if (search_billOfMaterial_type === "grid" ) {
                
                var fGQty = finishGoodsQty;
                var jobQty = parseFloat(fGQty)*parseFloat(data_search_billOfMaterial.quantity);
                
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemCode",opener.document).val(data_search_billOfMaterial.code);
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemCode", data_search_billOfMaterial.itemCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemName", data_search_billOfMaterial.itemName);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Quantity", jobQty);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"UnitOfMeasureCode", data_search_billOfMaterial.unitOfMeasureCode);              
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_billOfMaterial.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_billOfMaterial.name);
            }
 
            window.close();
        });

        $("#dlgBillOfMaterial_cancelButton").click(function(ev) { 
            data_search_billOfMaterial = null;
            window.close();
        });
    
        $("#btn_dlg_BillOfMaterialSearch").click(function(ev) {
            $("#dlgSearch_billOfMaterialCommponent_grid").jqGrid("setGridParam",{url:"master/bill-of-material-component-data?" + $("#frmBillOfMaterialCommponentSearch").serialize(), page:1});
            $("#dlgSearch_billOfMaterialCommponent_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#searchBillOfMaterial\\.code").val(header_code);
     });
    
</script>
    
<body>
<s:url id="remoteurlBillOfMaterialCommponentSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmBillOfMaterialCommponentSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="searchBillOfMaterial.code" name="searchBillOfMaterial.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="searchBillOfMaterial.name" name="searchBillOfMaterial.name" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_BillOfMaterialSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="searchBillOfMaterialStatus" name="searchBillOfMaterialStatus" readonly="false" size="5" style="display:none" value="YES"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_billOfMaterialCommponent_grid"
                dataType="json"
                href="%{remoteurlBillOfMaterialSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listBillOfMaterialDetailTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnubillOfMaterial').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                 <sjg:gridColumn
                name="itemCode" index="itemCode" key="itemCode" title="Item Code" width="100" sortable="true" 
                />
                <sjg:gridColumn
                    name="itemName" index="itemName" key="itemName" title="Item Name" width="300" sortable="true" 
                />
                <sjg:gridColumn
                    name="quantity" index="quantity" key="quantity" title="BOM Quantity" width="100" sortable="true" 
                    align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                />
                <sjg:gridColumn
                    name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="UOM Code" width="150" sortable="true" 
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgBillOfMaterial_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgBillOfMaterial_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>