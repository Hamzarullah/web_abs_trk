<%-- 
    Document   : assembly-realization
    Created on : Dec 10, 2019, 9:04:12 PM
    Author     : Rayis
--%>

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
</style>

<script type="text/javascript">
            
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("assemblyRealization_grid_onSelect", function(event, data){
            var selectedRowID = $("#assemblyRealization_grid").jqGrid("getGridParam", "selrow"); 
            var assemblyRealization = $("#assemblyRealization_grid").jqGrid("getRowData", selectedRowID);

            $("#assemblyRealizationBomItemDetail_grid").jqGrid("setGridParam",{url:"master/bill-of-material-component-data-rlz?searchBillOfMaterial.code=" + assemblyRealization.billOfMaterialCode});
            $("#assemblyRealizationBomItemDetail_grid").jqGrid("setCaption", "ASSEMBLY REALIZATION BOM DETAIL : " + assemblyRealization.code);
            $("#assemblyRealizationBomItemDetail_grid").trigger("reloadGrid");
            
            $("#assemblyRealizationItemDetail_grid").jqGrid("setGridParam",{url:"inventory/assembly-realization-item-detail-data?assemblyRealization.code=" + assemblyRealization.code});
            $("#assemblyRealizationItemDetail_grid").jqGrid("setCaption", "ASSEMBLY REALIZATION DETAIL : " + assemblyRealization.code);
            $("#assemblyRealizationItemDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnAssemblyRealizationNew').click(function(ev) {
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

               
                var urlAuthority="inventory/assembly-realization-authority";
                    var paramAuthority = "actionAuthority=INSERT";

                    $.post(urlAuthority, paramAuthority, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }else{
                            var url = "inventory/assembly-realization-input";
                            var params = "";
                            pageLoad(url, params, "#tabmnuASSEMBLY_REALIZATION");   
                        }
                    });
            });          
        });
        
        $('#btnAssemblyRealizationUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";
            
            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#assemblyRealization_grid").jqGrid('getGridParam','selrow');
                var assemblyRealization = $("#assemblyRealization_grid").jqGrid("getRowData", selectRowId);
                 if(assemblyRealization.approvalStatus==="APPROVED" ){
                    alertMessage("Can't Update!<br/><br/> This Transaction Has Been APPROVED");
                    return;
                }

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var url="inventory/assembly-realization-authority";
                var params="actionAuthority=UPDATE&assemblyRealization.code="+assemblyRealization.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "inventory/assembly-realization-input";
                    var params = "assemblyRealizationUpdateMode=true" + "&assemblyRealization.code=" + assemblyRealization.code;
                    pageLoad(url, params, "#tabmnuASSEMBLY_REALIZATION");
                    
                });

            });
 
            ev.preventDefault();
        });
        
        $("#btnAssemblyRealizationDelete").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#assemblyRealization_grid").jqGrid('getGridParam','selrow');
                var assemblyRealization = $("#assemblyRealization_grid").jqGrid('getRowData', selectRowId);
                if(assemblyRealization.approvalStatus==="APPROVED" ){
                    alertMessage("Can't Delete!<br/><br/> This Transaction Has Been APPROVED");
                    return;
                }
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var url="inventory/assembly-realization-authority";
                var params="actionAuthority=DELETE&assemblyRealization.code="+assemblyRealization.code;
               
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
                        '</span> No: '+assemblyRealization.code+'<br/><br/>' +    
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
                                    var url = "inventory/assembly-realization-delete";
                                    var params = "assemblyRealization.code=" + assemblyRealization.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridAssemblyRealization();
                                        reloadGridAssemblyRealizationItemDetail();
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
        
        $('#btnAssemblyRealizationRefresh').click(function(ev) {
            var url = "inventory/assembly-realization";
            var params = "";
            pageLoad(url, params, "#tabmnuASSEMBLY_REALIZATION");   
        });
        
        $('#btnAssemblyRealization_search').click(function(ev) {
            formatDateASMWO();
            $("#assemblyRealization_grid").jqGrid("clearGridData");
            $("#assemblyRealization_grid").jqGrid("setGridParam",{url:"inventory/assembly-realization-data?" + $("#frmAssemblyRealizationSearchInput").serialize()});
            $("#assemblyRealization_grid").trigger("reloadGrid");
            $("#assemblyRealizationBomItemDetail_grid").jqGrid("clearGridData");
            $("#assemblyRealizationBomItemDetail_grid").jqGrid("setCaption", "ASSEMBLY REALIZATION BOM ITEM DETAIL");
            $("#assemblyRealizationItemDetail_grid").jqGrid("clearGridData");
            $("#assemblyRealizationItemDetail_grid").jqGrid("setCaption", "ASSEMBLY REALIZATION ITEM DETAIL");
            formatDateASMWO();
        });
        
        $("#btnAssemblyRealizationPrint").click(function(ev) {
            var selectRowId = $("#assemblyRealization_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var assemblyRealization = $("#assemblyRealization_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/inventory/assembly-realization-print-out-pdf?";
            var params = "asRNo=" + assemblyRealization.code;
              
            window.open(url+params,'assemblyRealization','width=500,height=500');
        });
    });
    
    function reloadGridAssemblyRealization() {
        $("#assemblyRealization_grid").trigger("reloadGrid");
    };
    
    function reloadGridAssemblyRealizationItemDetail() {
        $("#assemblyRealizationItemDetail_grid").jqGrid("clearGridData");
        $("#assemblyRealizationItemDetail_grid").jqGrid("setCaption", "ASSEMBLY REALIZATION ITEM DETAIL");
    };
    
    function reloadGridAssemblyRealizationSerialDetail() {
        $("#assemblyRealizationSerialNoDetail_grid").jqGrid("clearGridData");
        $("#assemblyRealizationSerialNoDetail_grid").jqGrid("setCaption", "INVENTORY IN SERIAL NO DETAIL");
    };
    
    function formatDateASMWO(){
        var firstDate=$("#assemblyRealizationSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#assemblyRealizationSearchFirstDate").val(firstDateValue);

        var lastDate=$("#assemblyRealizationSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#assemblyRealizationSearchLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlAssemblyRealization" action="assembly-realization-json" />
<b>ASSEMBLY REALIZATION</b>
<hr>
<br class="spacer" />
    <sj:div id="assemblyRealizationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnAssemblyRealizationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnAssemblyRealizationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnAssemblyRealizationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnAssemblyRealizationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnAssemblyRealizationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="assemblyRealizationInputSearch" class="content ui-widget">
        <s:form id="frmAssemblyRealizationSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period * </td>
                    <td>
                        <sj:datepicker id="assemblyRealizationSearchFirstDate" name="assemblyRealizationSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="assemblyRealizationSearchLastDate" name="assemblyRealizationSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">ASM-RLZ No</td>
                    <td>
                        <s:textfield id="assemblyRealizationSearchCode" name="assemblyRealizationSearchCode" placeHolder=" Assembly Realization No" size="30"></s:textfield>
                    </td>
                    <td align="right">ASM-JOB NO</td>
                    <td>
                        <s:textfield id="assemblyRealizationSearchAssemblyJobOrderCode" name="assemblyRealizationSearchAssemblyJobOrderCode" placeHolder=" Assembly Job Order No" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Finish Goods</td>
                    <td>
                        <s:textfield id="assemblyRealizationSearchFinishGoodsCode" name="assemblyRealizationSearchFinishGoodsCode" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="assemblyRealizationSearchFinishGoodsName" name="assemblyRealizationSearchFinishGoodsName" placeHolder=" Name" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">RefNo</td>
                    <td>
                        <s:textfield id="assemblyRealizationSearchFinishGoodsRefno" name="assemblyRealizationSearchFinishGoodsRefno" placeHolder=" Ref No" size="15"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="assemblyRealizationSearchRemark" name="assemblyRealizationSearchRemark" placeHolder=" Remark" size="30"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnAssemblyRealization_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="assemblyRealizationGrid">
        <sjg:grid
            id="assemblyRealization_grid"
            caption="ASSEMBLY REALIZATION"
            dataType="json"
            href="%{remoteurlAssemblyRealization}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAssemblyRealization"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="assemblyRealization_grid_onSelect"
            width="$('#tabmnuinventoryin').width()"
            >
           
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="assemblyJobOrderCode" index="assemblyJobOrderCode" key="assemblyJobOrderCode" title="Assembly Job No" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="assemblyJobOrderDate" index="assemblyJobOrderDate" key="assemblyJobOrderDate" 
                title="Assembly Job Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsCode" index="finishGoodsCode" key="finishGoodsCode" title="Finish Goods Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsName" index="finishGoodsName" key="finishGoodsName" title="Finish Goods Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="billOfMaterialCode" index="billOfMaterialCode" key="billOfMaterialCode" title="BOM Code" width="120" sortable="true" 
            />
            <sjg:gridColumn
                name="billOfMaterialName" index="billOfMaterialName" key="billOfMaterialName" title="BOM Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="realizationQuantity" index="realizationQuantity" key="realizationQuantity" title="Quantity" width="100" sortable="true" 
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
    <div id="assemblyRealizationBomItemDetailGrid">
        <sjg:grid
            id="assemblyRealizationBomItemDetail_grid"
            caption="ASSEMBLY REALIZATION BOM ITEM DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialDetailTemp"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            width="675"
            shrinkToFit="false"
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
                name="quantity" index="quantity" key="quantity" title="Quantity" width="100" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="UOM" width="100" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <div id="assemblyRealizationItemDetailGrid">
        <sjg:grid
            id="assemblyRealizationItemDetail_grid"
            caption="ASSEMBLY REALIZATION ITEM DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAssemblyRealizationItemDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            width="1115"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="itemCode" index="itemCode" key="itemCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemName" index="itemName" key="itemName" title="Item Name" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Quantity" width="100" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="UOM" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="Rack Name" width="150" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />