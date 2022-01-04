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
    
    var search_productionPlanningOrder_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgProductionPlanningOrder_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_productionPlanningOrder_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ProductionPlanningOrder!");
                return;
            }

            var data_search_productionPlanningOrder = $("#dlgSearch_productionPlanningOrder_grid").jqGrid('getRowData', selectedRowId);

            if (search_productionPlanningOrder_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ProductionPlanningOrderCode",opener.document).val(data_search_productionPlanningOrder.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ProductionPlanningOrderName", data_search_productionPlanningOrder.name);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_productionPlanningOrder.code);
               $("#"+id_document+"\\.branch\\.code",opener.document).val(data_search_productionPlanningOrder.branchCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.transactionDate",opener.document).val(data_search_productionPlanningOrder.transactionDate);
               $("#"+id_document+"\\."+id_subdoc+"\\.documentType",opener.document).val(data_search_productionPlanningOrder.documentType);
               $("#"+id_document+"\\."+id_subdoc+"\\.documentCode",opener.document).val(data_search_productionPlanningOrder.documentCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.targetDate",opener.document).val(data_search_productionPlanningOrder.targetDate);
               $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.code",opener.document).val(data_search_productionPlanningOrder.customerCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.name",opener.document).val(data_search_productionPlanningOrder.customerName);
              if(id_document == "itemMaterialRequest"){
                  window.opener.itemMaterialRequestDocumentType(data_search_productionPlanningOrder.documentType);
              }
            }

            window.close();
        });


        $("#dlgProductionPlanningOrder_cancelButton").click(function(ev) { 
            data_search_productionPlanningOrder = null;
            window.close();
        });
    
        $("#btn_dlg_ProductionPlanningOrderSearch").click(function(ev) {
            $("#dlgSearch_productionPlanningOrder_grid").jqGrid("setGridParam",{url:"ppic/product-planning-order-search-data?" + $("#frmProductionPlanningOrderSearch").serialize(), page:1});
            $("#dlgSearch_productionPlanningOrder_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlProductionPlanningOrderSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmProductionPlanningOrderSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="productionPlanningOrderSearchCode" name="productionPlanningOrderSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="productionPlanningOrderSearchName" name="productionPlanningOrderSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ProductionPlanningOrderSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="productionPlanningOrderSearchActiveStatus" name="productionPlanningOrderSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_productionPlanningOrder_grid"
                dataType="json"
                href="%{remoteurlProductionPlanningOrderSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listProductionPlanningOrder"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuproductionPlanningOrder').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="branchCode" index="branchCode" title="Branch Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="branchName" index="branchName" title="Branch Name" width="165" sortable="true"
                />
                <sjg:gridColumn
                    name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="150" search="false" align="center"
                />
                <sjg:gridColumn
                    name="documentType" index="documentType" title="Document Type" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="documentCode" index="documentCode" title="Document Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="targetDate" index="targetDate" key="targetDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Target Date" width="150" search="false" align="center"
                />
                <sjg:gridColumn
                    name="customerCode" index="customerCode" title="Customer Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="customerName" index="customerName" title="Customer Name" width="165" sortable="true"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgProductionPlanningOrder_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgProductionPlanningOrder_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>