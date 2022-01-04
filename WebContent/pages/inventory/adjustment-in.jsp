
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
    #adjustmentInItemDetail_grid_pager_center,#adjustmentInSerialNoDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
    
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("adjustmentIn_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentIn_grid").jqGrid("getGridParam", "selrow"); 
            var adjustmentIn = $("#adjustmentIn_grid").jqGrid("getRowData", selectedRowID);

            $("#adjustmentInItemDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-in-item-detail-data?adjustmentIn.code=" + adjustmentIn.code});
            $("#adjustmentInItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL : " + adjustmentIn.code);
            $("#adjustmentInItemDetail_grid").trigger("reloadGrid");
            $("#adjustmentInSerialNoDetail_grid").jqGrid("clearGridData");
            $("#adjustmentInSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
        });
        
        $.subscribe("adjustmentInItemDetail_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInItemDetail_grid").jqGrid("getGridParam", "selrow"); 
            var adjustmentInItemDetail = $("#adjustmentInItemDetail_grid").jqGrid("getRowData", selectedRowID);
            
            $("#adjustmentInSerialNoDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-in-serial-no-detail-data?adjustmentInItemDetail.code=" + adjustmentInItemDetail.code});
            $("#adjustmentInSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL : " + adjustmentInItemDetail.code);
            $("#adjustmentInSerialNoDetail_grid").trigger("reloadGrid");
        });
      
        $('#btnAdjustmentInNew').click(function(ev) {
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

                var url = "inventory/adjustment-in-input";
                var params = "";
                pageLoad(url, params, "#tabmnuADJUSTMENT_IN");   

            });          
        });
        
        $('#btnAdjustmentInUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#adjustmentIn_grid").jqGrid('getGridParam','selrow');
                var adjustmentIn = $("#adjustmentIn_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="inventory/adjustment-in-confirmation";
                var params="adjustmentIn.code="+adjustmentIn.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "inventory/adjustment-in-input";
                    var params = "adjustmentInUpdateMode=true" + "&adjustmentIn.code=" + adjustmentIn.code;
                    pageLoad(url, params, "#tabmnuADJUSTMENT_IN");
                    
                });

                

            });
 
            ev.preventDefault();
        });
        
        $("#btnAdjustmentInDelete").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#adjustmentIn_grid").jqGrid('getGridParam','selrow');
                var adjustmentIn = $("#adjustmentIn_grid").jqGrid('getRowData', selectRowId);
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="inventory/adjustment-in-confirmation";
                var params="adjustmentIn.code="+adjustmentIn.code;
                
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
                        '</span>IIN No: '+adjustmentIn.code+'<br/><br/>' +    
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
                                    var url = "inventory/adjustment-in-delete";
                                    var params = "adjustmentIn.code=" + adjustmentIn.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridAdjustmentIn();
                                        reloadGridAdjustmentInItemDetail();
                                        reloadGridAdjustmentInSerialDetail();
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
        
        $('#btnAdjustmentInRefresh').click(function(ev) {
            var url = "inventory/adjustment-in";
            var params = "";
            pageLoad(url, params, "#tabmnuADJUSTMENT_IN");   
        });
        
        $('#btnAdjustmentIn_search').click(function(ev) {
            formatDateADJIN();
            $("#adjustmentIn_grid").jqGrid("clearGridData");
            $("#adjustmentIn_grid").jqGrid("setGridParam",{url:"inventory/adjustment-in-data?" + $("#frmAdjustmentInSearchInput").serialize()});
            $("#adjustmentIn_grid").trigger("reloadGrid");
            $("#adjustmentInItemDetail_grid").jqGrid("clearGridData");
            $("#adjustmentInItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");
            $("#adjustmentInSerialNoDetail_grid").jqGrid("clearGridData");
            $("#adjustmentInSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
            formatDateADJIN();
        });
        
        $("#btnAdjustmentInPrint").click(function(ev) {
            var selectRowId = $("#adjustmentIn_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
             
            var adjustmentIn = $("#adjustmentIn_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/inventory/adjustment-in-print-out-pdf?";
            var params = "adjustmentIn.code=" + adjustmentIn.code;
              
            window.open(url+params,'adjustmentIn','width=500,height=500');
        });
    });
    
    function reloadGridAdjustmentIn() {
        $("#adjustmentIn_grid").trigger("reloadGrid");
    };
    
    function reloadGridAdjustmentInItemDetail() {
        $("#adjustmentInItemDetail_grid").jqGrid("clearGridData");
        $("#adjustmentInItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");
    };
    
    function reloadGridAdjustmentInSerialDetail() {
        $("#adjustmentInSerialNoDetail_grid").jqGrid("clearGridData");
        $("#adjustmentInSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
    };
    
    function formatDateADJIN(){
        var firstDate=$("#adjustmentIn\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#adjustmentIn\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#adjustmentIn\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#adjustmentIn\\.transactionLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlAdjustmentIn" action="adjustment-in-json" />
<b> ADJUSTMENT IN (DRAFT)</b>
<hr>
<br class="spacer" />
    <sj:div id="adjustmentInButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnAdjustmentInNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnAdjustmentInUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnAdjustmentInDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnAdjustmentInRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnAdjustmentInPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="adjustmentInInputSearch" class="content ui-widget">
        <s:form id="frmAdjustmentInSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="adjustmentIn.transactionFirstDate" name="adjustmentIn.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="adjustmentIn.transactionLastDate" name="adjustmentIn.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td> 
                <tr>
                    <td align="right">ADJ-IN NO</td>
                    <td>
                        <s:textfield id="adjustmentIn.code" name="adjustmentIn.code" size="30"></s:textfield>
                    </td>
                    <td align="right">Warehouse</td>
                    <td>
                        <s:textfield id="adjustmentIn.warehouseCode" name="adjustmentIn.warehouseCode" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="adjustmentIn.warehouseName" name="adjustmentIn.warehouseName" placeHolder=" Name" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="adjustmentIn.remark" name="adjustmentIn.remark" size="40"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="adjustmentIn.refNo" name="adjustmentIn.refNo" size="40"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnAdjustmentIn_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="adjustmentInGrid">
        <sjg:grid
            id="adjustmentIn_grid"
            caption="ADJUSTMENT IN"
            dataType="json"
            href="%{remoteurlAdjustmentIn}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAdjustmentInTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="adjustmentIn_grid_onSelect"
            width="$('#tabmnuadjustmentin').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="ADJ-IN NO" width="130" sortable="true"
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

    <div id="adjustmentInItemDetailGrid">
        <sjg:grid
            id="adjustmentInItemDetail_grid"
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
            gridModel="listAdjustmentInItemDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            onSelectRowTopics="adjustmentInItemDetail_grid_onSelect"
            width="$('#tabmnuadjustmentin').width()"
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

    <div id="adjustmentInSerialNoDetailGrid">
        <sjg:grid
            id="adjustmentInSerialNoDetail_grid"
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
            gridModel="listAdjustmentInSerialNoDetail"
            viewrecords="true"
            rowNum="10000"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuadjustmentin').width()"
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

