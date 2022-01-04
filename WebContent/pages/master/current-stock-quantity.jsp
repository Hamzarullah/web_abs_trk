<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<script type="text/javascript">

    function reloadGridCurrentStockQuantity() {
        //$("#currentStockQuantity_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#currentStockQuantity_grid").trigger("reloadGrid");
    };

    $(document).ready(function () {
        hoverButton();
        
        $("#btnCurrentStockQuantity_search").click(function(ev) {
            $("#currentStockQuantity_grid").jqGrid("setGridParam",{url:"master/current-stock-quantity-search?" + $("#frmCurrentStockQuantitySearchInput").serialize(), page:1});
            $("#currentStockQuantity_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
        $("#btnCurrentPrint").click(function(ev) {
            var selectRowId = $("#currentStockQuantity_grid").jqGrid('getGridParam','selrow');
            var csQuantity = $("#currentStockQuantity_grid").jqGrid("getRowData", selectRowId);
           
           if(csQuantity.releasedStatus==='false'){
                alertMessage("SO No :"+csQuantity.code+" Can't Print..!<br/><br/> This Transaction Not Released..!");
                return;
            }
            
//            if (selectRowId === null) {
//                alertMessage("Please Select Row!");
//                return;
//            }            
            var csQuantity = $("#currentStockQuantity_grid").jqGrid('getRowData', selectRowId);         
            var url = "master/current-stock-quantity-print-out-xls?";
            var params ="code=" + csQuantity.code;    
            window.open(url+params,'csQuantity','width=500,height=500');
        });
        
    });
</script>
<s:url id="remoteurlCurrentStockQuantity" action="current-stock-csQuantity-search" />
<b>CURRENT STOCK QUANTITY</b>
<hr>
<br class="spacer"/>  
 <div id="currentStockQuantitySearchInput" class="content ui-widget">
        <br class="spacer" />
        <sj:div id="currentButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCurrentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_excel.PNG" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>  
        <br class="spacer" />
        <s:form id="frmCurrentStockQuantitySearchInput">
            <table cellpadding="2" cellspacing="2">
 
                <tr>
                    <td align="right" valign="centre"><b>Warehouse Code</b></td>
                    <td>
                        <s:textfield id="currentStockQuantitySearchWarehouseCode" name="currentStockQuantitySearchWarehouseCode" size="20"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right" valign="centre"><b>Warehouse Name</b></td>
                    <td>
                        <s:textfield id="currentStockQuantitySearchWarehouseName" name="currentStockQuantitySearchWarehouseName" size="20"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="centre"><b>Item Code</b></td>
                    <td>
                        <s:textfield id="currentStockQuantitySearchItemCode" name="currentStockQuantitySearchItemCode" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right" valign="centre"><b>Item Name</b></td>
                    <td>
                        <s:textfield id="currentStockQuantitySearchItemName" name="currentStockQuantitySearchItemName" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="centre"><b>Rack Code</b></td>
                    <td>
                        <s:textfield id="currentStockQuantitySearchRackCode" name="currentStockQuantitySearchRackCode" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right" valign="centre"><b>Rack Name</b></td>
                    <td>
                        <s:textfield id="currentStockQuantitySearchRackName" name="currentStockQuantitySearchRackName" size="50"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnCurrentStockQuantity_search" button="true">Search</sj:a>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
        </s:form>
</div>   

<br class="spacer" />

<div id="currentStockQuantityGrid">
    <sjg:grid
        id="currentStockQuantity_grid"
        dataType="json"
        href="%{remoteurlCurrentStockQuantity}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCurrentStockQuantityTemp"
        rowList="10,20,30"
        rowNum="10"
        sortname="warehouseCode"
        sortorder="asc"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuCurrentStockQuantity').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="warehouseCode" index="warehouseCode" title="Warehouse Code" width="100" sortable="true"
        />  
        <sjg:gridColumn
            name="warehouseName" index="warehouseName" title="Warehouse Name" width="100" sortable="false"
        />  
        <sjg:gridColumn
            name="itemCode" index="itemCode" title="Item Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemName" index="itemName" title="Item Name" width="100" sortable="false"
        /> 
        <sjg:gridColumn
            name="rackCode" index="rackCode" title="Rack Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="rackName" index="rackName" title="Rack Name" width="100" sortable="false"
        /> 
       <sjg:gridColumn
            name = "actualStock" index = "actualStock" key = "actualStock" title = "Quantity" width = "100" sortable = "false" 
            formatter="number" align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />  
         <sjg:gridColumn
            name="uom" index="uom" title="UOM" width="50" sortable="false"
        /> 
    </sjg:grid >
</div>