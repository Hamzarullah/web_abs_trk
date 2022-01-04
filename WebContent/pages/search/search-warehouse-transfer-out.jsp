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
      
    var search_warehouseTransferOut_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc='<%= request.getParameter("idsubdoc") %>';
    var firstDate='<%= request.getParameter("firstDate") %>';
    var lastDate='<%= request.getParameter("lastDate") %>';
    
    function formatDateSearch(date, useTime) {
        var dateValuesTemps;

        if (useTime) {
            var dateValues = date.split(' ');
            var dateValuesTemp = dateValues[0].split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            var dateValuesTemp = date.split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    jQuery(document).ready(function(){  
        
        $("#warehouseTransferOutSearchFirstDate").val(firstDate);
        $("#warehouseTransferOutSearchLastDate").val(lastDate);
        
        $("#dlgWarehouseTransferOut_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_warehouseTransferOut_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row WarehouseTransferOut!");
                return;
            }

            var data_search_warehouseTransferOut = $("#dlgSearch_warehouseTransferOut_grid").jqGrid('getRowData', selectedRowId);

            if (search_warehouseTransferOut_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"WarehouseTransferOutCode",opener.document).val(data_search_warehouseTransferOut.code);        
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchCode", data_search_warehouseTransferOut.branchCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchName", data_search_warehouseTransferOut.branchName);           
                
                $("#"+selectedRowID+"_"+id_document+id_subdoc+"WarehouseTransferOutCode",opener.document).val(data_search_warehouseTransferOut.code);        
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"BranchCode", data_search_warehouseTransferOut.branchCode);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"BranchName", data_search_warehouseTransferOut.branchName);           
            }else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_warehouseTransferOut.code);;
                $("#"+id_document+"\\."+id_subdoc+"\\.transactionDate",opener.document).val(data_search_warehouseTransferOut.transactionDate);
                $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.code",opener.document).val(data_search_warehouseTransferOut.branchCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.name",opener.document).val(data_search_warehouseTransferOut.branchName);
                $("#"+id_document+"\\.sourceWarehouse\\.code",opener.document).val(data_search_warehouseTransferOut.sourceWarehouseCode);
                $("#"+id_document+"\\.sourceWarehouse\\.name",opener.document).val(data_search_warehouseTransferOut.sourceWarehouseName);
                $("#"+id_document+"\\.destinationWarehouse\\.code",opener.document).val(data_search_warehouseTransferOut.destinationWarehouseCode);
                $("#"+id_document+"\\.destinationWarehouse\\.name",opener.document).val(data_search_warehouseTransferOut.destinationWarehouseName);
            }

            window.close();
        });

        $("#dlgWarehouseTransferOut_cancelButton").click(function(ev) { 
            data_search_warehouseTransferOut = null;
            window.close();
        });
    
        $("#btn_dlg_WarehouseTransferOutSearch").click(function(ev) {
            formatDate();
            
            $("#dlgSearch_warehouseTransferOut_grid").jqGrid("setGridParam",{url:"master/warehouse-transfer-out-data-for-search?" + $("#frmWarehouseTransferOutSearch").serialize(), page:1});
            $("#dlgSearch_warehouseTransferOut_grid").trigger("reloadGrid");
            
            formatDate();
            ev.preventDefault();
        });
        
        $("#warehouseTransferOutSearchFirstDate").val(formatDateSearch(firstDate,false));
        $("#warehouseTransferOutSearchLastDate").val(formatDateSearch(lastDate,false));
     });
    
    function formatDate(){
        $("#warehouseTransferOutSearchFirstDate").val(formatDateSearch($("#warehouseTransferOutSearchFirstDate").val(),false));
        $("#warehouseTransferOutSearchLastDate").val(formatDateSearch($("#warehouseTransferOutSearchLastDate").val(),false));    
    }
    
</script>
<body>
<s:url id="remoteurlWarehouseTransferOutSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmWarehouseTransferOutSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period * </B></td>
                <td>
                    <sj:datepicker id="warehouseTransferOutSearchFirstDate" name="warehouseTransferOutSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="warehouseTransferOutSearchLastDate" name="warehouseTransferOutSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="warehouseTransferOutSearchCode" name="warehouseTransferOutSearchCode" placeHolder=" Code"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_WarehouseTransferOutSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_warehouseTransferOut_grid"
            dataType="json"
            href="%{remoteurlWarehouseTransferOutSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listWarehouseTransferOutTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuwarehouseTransferOut').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="135" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  title="Transaction Date" width="150" search="false" sortable="true" align="center"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" title="branchCode" width="400" sortable="true" 
            />
            <sjg:gridColumn
                name="branchName" index="branchName" title="branchName" width="400" sortable="true"
            />
            <sjg:gridColumn
                name="sourceWarehouseCode" index="sourceWarehouseCode" title="Source Warehouse Code" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="sourceWarehouseName" index="sourceWarehouseName" title="Source Warehouse Name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="destinationWarehouseCode" index="destinationWarehouseCode" title="destinationWarehouseCode" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="destinationWarehouseName" index="destinationWarehouseName" title="destinationWarehouseName" width="200" sortable="true"
            />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgWarehouseTransferOut_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgWarehouseTransferOut_cancelButton" button="true">Cancel</sj:a>
</body>
</html>