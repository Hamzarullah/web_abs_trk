<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<s:url id="remoteurlCurrentStockCogsIdr" action="current-stock-cogs-idr-json" />

<script type="text/javascript">

    function reloadGridCurrentStockCogsIdr() {
        //$("#currentStockCogsIdr_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#currentStockCogsIdr_grid").trigger("reloadGrid");
    };

    $(document).ready(function () {
        hoverButton();
        
        $("#btnCurrentStockCogsIdr_search").click(function(ev) {
            $("#currentStockCogsIdr_grid").jqGrid("setGridParam",{url:"master/current-stock-cogs-idr-search?" + $("#frmCurrentStockCogsIdrSearchInput").serialize(), page:1});
            $("#currentStockCogsIdr_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCurrentPrint").click(function(ev) {
            var selectRowId = $("#currentStockCogsIdr_grid").jqGrid('getGridParam','selrow');
            var cogsidr = $("#currentStockCogsIdr_grid").jqGrid("getRowData", selectRowId);
           
           if(cogsidr.releasedStatus==='false'){
                alertMessage("SO No :"+cogsidr.code+" Can't Print..!<br/><br/> This Transaction Not Released..!");
                return;
            }
            
//            if (selectRowId === null) {
//                alertMessage("Please Select Row!");
//                return;
//            }           
            
            var cogsidr = $("#currentStockCogsIdr_grid").jqGrid('getRowData', selectRowId);         
            var url = "reports/master/current-stock-cogsidr-print-out-xls?";
            var params ="code=" + cogsidr.code;    
            window.open(url+params,'cogsidr','width=500,height=500');
        });
        
    });
</script>

<b>CURRENT STOCK COGS IDR</b>
<hr>
<br class="spacer"/>  
<div id="countrySearchInput" class="content ui-widget">
    <br class="spacer"/>
<sj:div id="currentButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCurrentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_excel.PNG" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>    
    <br class="spacer"/>
    <s:form id="frmCurrentStockCogsIdrSearchInput">
        <table>
            <tr>
                    <td align="right" valign="centre"><b>Warehouse Code</b></td>
                    <td>
                        <s:textfield id="currentStockCogsIdrSearchWarehouseCode" name="currentStockCogsIdrSearchWarehouseCode" size="20"></s:textfield>
                    </td>
                    <td align="right" valign="centre"><b>Item Code</b></td>
                    <td>
                        <s:textfield id="currentStockCogsIdrSearchItemCode" name="currentStockCogsIdrSearchItemCode" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="centre"><b>Warehouse Name</b></td>
                    <td>
                        <s:textfield id="currentStockCogsIdrSearchWarehouseName" name="currentStockCogsIdrSearchWarehouseName" size="20"></s:textfield>
                    </td>
                    <td align="right" valign="centre"><b>Item Name</b></td>
                    <td>
                        <s:textfield id="currentStockCogsIdrSearchItemName" name="currentStockCogsIdrSearchItemName" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                   
                </tr>  
        </table>
        <br/>
        <sj:a href="#" id="btnCurrentStockCogsIdr_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   

<br class="spacer" />

<div id="currentStockCogsIdrGrid">
    <sjg:grid
        id="currentStockCogsIdr_grid"
        dataType="json"
        href="%{remoteurlCurrentStockCogsIdr}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCurrentStockCogsIdrTemp"
        rowList="10,20,30"
        rowNum="10"
        sortname="warehouseCode"
        sortorder="asc"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuCURRENTSTOCKQUANTITY').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="warehouseCode" index="warehouseCode" title="Warehouse Code" width="200" sortable="true"
        />  
        <sjg:gridColumn
            name="warehouseName" index="warehouseName" title="Warehouse Name" width="200" sortable="false"
        />  
        <sjg:gridColumn
            name="itemCode" index="itemCode" title="Item Code" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="itemName" index="itemName" title="Item Name" width="200" sortable="false"
        />  
       
        <sjg:gridColumn
            name="currentStock" index="currentStock" title="Quantity" width="100" sortable="false"
        />  
         <sjg:gridColumn
            name="uom" index="uom" title="UOM" width="100" sortable="false"
        />
        
        <sjg:gridColumn
            name = "cogsIdr" index = "cogsIdr" key = "cogsIdr" title = "COGS IDR" width = "125" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "total" index = "total" key = "total" title = "Total COGS IDR" width = "125" sortable = "false" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}"
        />
    </sjg:grid >
</div>