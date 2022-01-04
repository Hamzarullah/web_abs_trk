
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
    #adjustmentOutItemDetail_grid_pager_center,#adjustmentOutSerialNoDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
    
    
            
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("adjustmentOut_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentOut_grid").jqGrid("getGridParam", "selrow"); 
            var adjustmentOut = $("#adjustmentOut_grid").jqGrid("getRowData", selectedRowID);
            
            $("#adjustmentOutItemDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-out-item-detail-data?adjustmentOut.code=" + adjustmentOut.code});
            $("#adjustmentOutItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL : " + adjustmentOut.code);
            $("#adjustmentOutItemDetail_grid").trigger("reloadGrid");
            
            $("#adjustmentOutSerialNoDetail_grid").jqGrid("clearGridData");            
            $("#adjustmentOutSerialNoDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-out-serial-no-detail-data?adjustmentOut.code=" + adjustmentOut.code});
            $("#adjustmentOutSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
            $("#adjustmentOutSerialNoDetail_grid").trigger("reloadGrid");
        });
      
        $('#btnAdjustmentOutNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    var dynamicDialogUpdate= $(
                        '<div id="conformBoxError">'+
                        '<span>'+
                        '</span>'+data.errorMessage+'<br/><br/>' +
                        '</div>');
                    dynamicDialogUpdate.dialog({
                            title : "Attention!",
                            closeOnEscape: false,
                            modal : true,
                            width: 300,
                            resizable: false,
                            buttons : 
                                    [{
                                            text : "OK",
                                            click : function() {
                                                    $(this).dialog("close");
                                            }
                                    }]
                    }); 
                    return;
                }

                var url = "inventory/adjustment-out-input";
                var params = "";
                pageLoad(url, params, "#tabmnuADJUSTMENT_OUT");   

            });          
        });
        
        $('#btnAdjustmentOutUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#adjustmentOut_grid").jqGrid('getGridParam','selrow');
                var adjustmentOut = $("#adjustmentOut_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="inventory/adjustment-out-confirmation";
                var params="adjustmentOut.code="+adjustmentOut.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "inventory/adjustment-out-input";
                    var params = "adjustmentOutUpdateMode=true" + "&adjustmentOut.code=" + adjustmentOut.code;
                    pageLoad(url, params, "#tabmnuADJUSTMENT_OUT");
                    
                });

                

            });
 
            ev.preventDefault();
        });
        
        $("#btnAdjustmentOutDelete").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#adjustmentOut_grid").jqGrid('getGridParam','selrow');
                var adjustmentOut = $("#adjustmentOut_grid").jqGrid('getRowData', selectRowId);
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="inventory/adjustment-out-confirmation";
                var params="adjustmentOut.code="+adjustmentOut.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>IIN No: '+adjustmentOut.code+'<br/><br/>' +    
                        '</div>');
                    dynamicDialog.dialog({
                        title : "Confirmation",
                        closeOnEscape: false,
                        modal : true,
                        width: 300,
                        resizable: false,
                        buttons : 
                            [{
                                text : "Yes",
                                click : function() {
                                    var url = "inventory/adjustment-out-delete";
                                    var params = "adjustmentOut.code=" + adjustmentOut.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridAdjustmentOut();
                                        reloadGridAdjustmentOutItemDetail();
                                        reloadGridAdjustmentOutSerialDetail();
                                    });  
                                    $(this).dialog("close");
                                }
                            },
                            {
                                text : "No",
                                click : function() {
                                    $(this).dialog("close");                                       
                                }
                            }]
                    }); 
                    
                });
            });
        });
        
        $('#btnAdjustmentOutRefresh').click(function(ev) {
            var url = "inventory/adjustment-out";
            var params = "";
            pageLoad(url, params, "#tabmnuADJUSTMENT_OUT");   
        });
        
        $('#btnAdjustmentOut_search').click(function(ev) {
            formatDateADJIN();
            $("#adjustmentOut_grid").jqGrid("clearGridData");
            $("#adjustmentOut_grid").jqGrid("setGridParam",{url:"inventory/adjustment-out-data?" + $("#frmAdjustmentOutSearchInput").serialize()});
            $("#adjustmentOut_grid").trigger("reloadGrid");
            $("#adjustmentOutItemDetail_grid").jqGrid("clearGridData");
            $("#adjustmentOutItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");
            $("#adjustmentOutSerialNoDetail_grid").jqGrid("clearGridData");
            $("#adjustmentOutSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
            formatDateADJIN();
        });
        
        $("#btnAdjustmentOutPrint").click(function(ev) {
            var selectRowId = $("#adjustmentOut_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
             
            var adjustmentOut = $("#adjustmentOut_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/inventory/adjustment-out-print-out-pdf?";
            var params = "adjustmentOut.code=" + adjustmentOut.code;
              
            window.open(url+params,'adjustmentOut','width=500,height=500');
        });
    });
    
    function reloadGridAdjustmentOut() {
        $("#adjustmentOut_grid").trigger("reloadGrid");
    };
    
    function reloadGridAdjustmentOutItemDetail() {
        $("#adjustmentOutItemDetail_grid").jqGrid("clearGridData");
        $("#adjustmentOutItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");
    };
    
    function reloadGridAdjustmentOutSerialDetail() {
        $("#adjustmentOutSerialNoDetail_grid").jqGrid("clearGridData");
        $("#adjustmentOutSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
    };
    
    function formatDateADJIN(){
        var firstDate=$("#adjustmentOut\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#adjustmentOut\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#adjustmentOut\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#adjustmentOut\\.transactionLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlAdjustmentOut" action="adjustment-out-json" />
<b> ADJUSTMENT OUT (DRAFT)</b>
<hr>
<br class="spacer" />
    <sj:div id="adjustmentOutButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnAdjustmentOutNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/></a>
        <a href="#" id="btnAdjustmentOutUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/></a>
        <a href="#" id="btnAdjustmentOutDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/></a>
        <a href="#" id="btnAdjustmentOutRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
        <a href="#" id="btnAdjustmentOutPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="adjustmentOutInputSearch" class="content ui-widget">
        <s:form id="frmAdjustmentOutSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="adjustmentOut.transactionFirstDate" name="adjustmentOut.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="adjustmentOut.transactionLastDate" name="adjustmentOut.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td> 
                <tr>
                    <td align="right">ADJ-OUT NO</td>
                    <td>
                        <s:textfield id="adjustmentOut.code" name="adjustmentOut.code" size="30"></s:textfield>
                    </td>
                    <td align="right">Warehouse</td>
                    <td>
                        <s:textfield id="adjustmentOut.warehouseCode" name="adjustmentOut.warehouseCode" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="adjustmentOut.warehouseName" name="adjustmentOut.warehouseName" placeHolder=" Name" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="adjustmentOut.remark" name="adjustmentOut.remark" size="30"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="adjustmentOut.refNo" name="adjustmentOut.refNo" size="30"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnAdjustmentOut_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="adjustmentOutGrid">
        <sjg:grid
            id="adjustmentOut_grid"
            caption="ADJUSTMENT OUT"
            dataType="json"
            href="%{remoteurlAdjustmentOut}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAdjustmentOut"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="adjustmentOut_grid_onSelect"
            width="$('#tabmnuadjustmentout').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch" width="50" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="warehouseCode" index="warehouseCode" key="warehouseCode" title="Warehouse Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="warehouseName" index="warehouseName" key="warehouseName" title="Warehouse Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="exchangeRate" index="exchangeRate" key="exchangeRate" 
                title="ExchangeRate" width="100" align="right" edittype="text" hidden="true"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval" width="120" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="approvalBy" index="approvalBy" key="approvalBy" title="Approval By" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="approvalDate" index="approvalDate" key="approvalDate" 
                title="Approval Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
            />
        </sjg:grid>
    </div>
    
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="adjustmentOutItemDetailGrid">
        <sjg:grid
            id="adjustmentOutItemDetail_grid"
            caption="ITEM DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAdjustmentOutItemDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnuadjustmentout').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Name" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialSerialNoStatus" index="itemMaterialSerialNoStatus" key="itemMaterialSerialNoStatus" title="SerialNo Satus" width="90" sortable="true" 
            />
            <sjg:gridColumn
                name="reasonCode" index="reasonCode" key="reasonCode" title="Reason Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="reasonName" index="reasonName" key="reasonName" title="Reason Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="UOM" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="Rack Name" width="80" sortable="true" 
            />
             <sjg:gridColumn
                 name="itemMaterialSerialNoStatus" index="itemMaterialSerialNoStatus" key="itemMaterialSerialNoStatus" title="SerialNo" width="100" sortable="true" hidden="true"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />

    <div id="adjustmentOutSerialNoDetailGrid">
        <sjg:grid
            id="adjustmentOutSerialNoDetail_grid"
            caption="SERIAL NO DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAdjustmentOutSerialNoDetail"
            viewrecords="true"
            rowNum="10000"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuadjustmentout').width()"
        >
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Name" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="serialNo" index="serialNo" key="serialNo" title="SerialNo" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="capacity" index="capacity" key="capacity" title="Capacity" width="110" sortable="true" 
                formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="UOM" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="Rack Name" width="80" sortable="true" 
            />
        </sjg:grid >
    </div>

