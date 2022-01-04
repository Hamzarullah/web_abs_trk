<%-- 
    Document   : assembly-job-order
    Created on : Dec 10, 2019, 2:18:14 PM
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
        
        $.subscribe("assemblyJobOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#assemblyJobOrder_grid").jqGrid("getGridParam", "selrow"); 
            var assemblyJobOrder = $("#assemblyJobOrder_grid").jqGrid("getRowData", selectedRowID);
        //    alert(assemblyJobOrder.billOfMaterialCode);
            $("#assemblyJobOrderBomItemDetail_grid").jqGrid("setGridParam",{url:"master/bill-of-material-component-data?searchBillOfMaterial.code=" + assemblyJobOrder.billOfMaterialCode});
            $("#assemblyJobOrderBomItemDetail_grid").jqGrid("setCaption", "BOM DETAIL : " + assemblyJobOrder.code);
            $("#assemblyJobOrderBomItemDetail_grid").trigger("reloadGrid");
            
            $("#assemblyJobOrderItemDetail_grid").jqGrid("setGridParam",{url:"inventory/assembly-job-order-item-detail-data?assemblyJobOrder.code=" + assemblyJobOrder.code});
            $("#assemblyJobOrderItemDetail_grid").jqGrid("setCaption", "ASSEMBLY JOB ORDER ITEM DETAIL : " + assemblyJobOrder.code);
            $("#assemblyJobOrderItemDetail_grid").trigger("reloadGrid");
       //     calculateQuantity();
        });
        
        $('#btnAssemblyJobOrderNew').click(function(ev) {
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
                    var urlAuthority="inventory/assembly-job-order-authority";
                    var paramAuthority = "actionAuthority=INSERT";

                    $.post(urlAuthority, paramAuthority, function(data) {
                        if (data.error) {
                            alertMessage(data.errorMessage);
                            return;
                        }else{
                            var url = "inventory/assembly-job-order-input";
                            var params = "";
                            pageLoad(url, params, "#tabmnuASSEMBLY_JOB_ORDER");   
                        }
                    });
            });          
        });
        
        $('#btnAssemblyJobOrderUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";
            
            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#assemblyJobOrder_grid").jqGrid('getGridParam','selrow');
                var assemblyJobOrder = $("#assemblyJobOrder_grid").jqGrid("getRowData", selectRowId);
                 if(assemblyJobOrder.approvalStatus==="APPROVED" ){
                    alertMessage("Can't Update!<br/><br/> This Transaction Has Been APPROVED");
                    return;
                }

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="inventory/assembly-job-order-authority";
                var params="actionAuthority=UPDATE&assemblyJobOrder.code="+assemblyJobOrder.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "inventory/assembly-job-order-input";
                    var params = "assemblyJobOrderUpdateMode=true" + "&assemblyJobOrder.code=" + assemblyJobOrder.code;
                    pageLoad(url, params, "#tabmnuASSEMBLY_JOB_ORDER");
                    
                });

                

            });
 
            ev.preventDefault();
        });
        
        $("#btnAssemblyJobOrderDelete").click(function(ev){
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#assemblyJobOrder_grid").jqGrid('getGridParam','selrow');
                var assemblyJobOrder = $("#assemblyJobOrder_grid").jqGrid('getRowData', selectRowId);
                if(assemblyJobOrder.approvalStatus==="APPROVED" ){
                    alertMessage("Can't Delete!<br/><br/> This Transaction Has Been APPROVED");
                    return;
                }
                
                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="inventory/assembly-job-order-authority";
                var params="actionAuthority=DELETE&assemblyJobOrder.code="+assemblyJobOrder.code;
                
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
                        '</span>ADJ-IN No: '+assemblyJobOrder.code+'<br/><br/>' +    
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
                                    var url = "inventory/assembly-job-order-delete";
                                    var params = "assemblyJobOrder.code=" + assemblyJobOrder.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridAssemblyJobOrder();
                                        reloadGridAssemblyJobOrderItemDetail();
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
        
        $('#btnAssemblyJobOrderRefresh').click(function(ev) {
            var url = "inventory/assembly-job-order";
            var params = "";
            pageLoad(url, params, "#tabmnuASSEMBLY_JOB_ORDER");   
        });
        
        $('#btnAssemblyJobOrder_search').click(function(ev) {
            formatDateASMJobOrder();
            $("#assemblyJobOrder_grid").jqGrid("clearGridData");
            $("#assemblyJobOrder_grid").jqGrid("setGridParam",{url:"inventory/assembly-job-order-data?" + $("#frmAssemblyJobOrderSearchInput").serialize()});
            $("#assemblyJobOrder_grid").trigger("reloadGrid");
            $("#assemblyJobOrderBomItemDetail_grid").jqGrid("clearGridData");
            $("#assemblyJobOrderBomItemDetail_grid").jqGrid("setCaption", "ASSEMBLY JOB ORDER BOM ITEM DETAIL");
            $("#assemblyJobOrderItemDetail_grid").jqGrid("clearGridData");
            $("#assemblyJobOrderItemDetail_grid").jqGrid("setCaption", "ASSEMBLY JOB ORDER ITEM DETAIL");
            formatDateASMJobOrder();
        });
        
        $("#btnAssemblyJobOrderPrint").click(function(ev) {
            var selectRowId = $("#assemblyJobOrder_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var assemblyJobOrder = $("#assemblyJobOrder_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/inventory/assembly-job-order-print-out-pdf?";
            var params = "asJNo=" + assemblyJobOrder.code;
              
            window.open(url+params,'assemblyJobOrder','width=500,height=500');
        });
    });
    
    function reloadGridAssemblyJobOrder() {
        $("#assemblyJobOrder_grid").trigger("reloadGrid");
    };
    
    function reloadGridAssemblyJobOrderItemDetail() {
        $("#assemblyJobOrderBomItemDetail_grid").jqGrid("clearGridData");
        $("#assemblyJobOrderBomItemDetail_grid").jqGrid("setCaption", "ASSEMBLY JOB ORDER ITEM DETAIL");
        
        $("#assemblyJobOrderItemDetail_grid").jqGrid("clearGridData");
        $("#assemblyJobOrderItemDetail_grid").jqGrid("setCaption", "ASSEMBLY JOB ORDER ITEM DETAIL");
    };
    
    function reloadGridAssemblyJobOrderSerialDetail() {
        $("#assemblyJobOrderSerialNoDetail_grid").jqGrid("clearGridData");
        $("#assemblyJobOrderSerialNoDetail_grid").jqGrid("setCaption", "INVENTORY IN SERIAL NO DETAIL");
    };
    
    function formatDateASMJobOrder(){
        var firstDate=$("#assemblyJobOrderSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#assemblyJobOrderSearchFirstDate").val(firstDateValue);

        var lastDate=$("#assemblyJobOrderSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#assemblyJobOrderSearchLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlAssemblyJobOrder" action="assembly-job-order-json" />
<b>ASSEMBLY JOB ORDER</b>
<hr>
<br class="spacer" />
    <sj:div id="assemblyJobOrderButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnAssemblyJobOrderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnAssemblyJobOrderUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnAssemblyJobOrderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnAssemblyJobOrderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnAssemblyJobOrderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
    </sj:div>
    <br class="spacer" />
    <div id="assemblyJobOrderInputSearch" class="content ui-widget">
        <s:form id="frmAssemblyJobOrderSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period * </td>
                    <td>
                        <sj:datepicker id="assemblyJobOrderSearchFirstDate" name="assemblyJobOrderSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="assemblyJobOrderSearchLastDate" name="assemblyJobOrderSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">ASM-JOB No</td>
                    <td>
                        <s:textfield id="assemblyJobOrderSearchCode" name="assemblyJobOrderSearchCode" placeHolder=" Assembly Job Order No" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Finish Goods</td>
                    <td>
                        <s:textfield id="assemblyJobOrderSearchFinishGoodsCode" name="assemblyJobOrderSearchFinishGoodsCode" placeHolder=" Code" size="15"></s:textfield>
                        <s:textfield id="assemblyJobOrderSearchFinishGoodsName" name="assemblyJobOrderSearchFinishGoodsName" placeHolder=" Name" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">RefNo</td>
                    <td>
                        <s:textfield id="assemblyJobOrderSearchRefNo" name="assemblyJobOrderSearchRefNo" placeHolder=" RefNo" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="assemblyJobOrderSearchRemark" name="assemblyJobOrderSearchRemark" placeHolder=" Remark" size="30"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnAssemblyJobOrder_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br /><br />
                     
    <!-- GRID HEADER -->    
   <div id="assemblyJobOrderGrid">
        <sjg:grid
            id="assemblyJobOrder_grid"
            caption="ASSEMBLY JOB ORDER"
            dataType="json"
            href="%{remoteurlAssemblyJobOrder}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAssemblyJobOrder"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="assemblyJobOrder_grid_onSelect"
            width="$('#tabmnuinventoryin').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="ASM-JOB No" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch" width="50" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch Name" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsCode" index="finishGoodsCode" key="finishGoodsCode" title="Finish Goods Code" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsName" index="finishGoodsName" key="finishGoodsName" title="Finish Goods Name" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="billOfMaterialCode" index="billOfMaterialCode" key="billOfMaterialCode" title="BOM Code" width="70" sortable="true" 
            />
            <sjg:gridColumn
                name="billOfMaterialName" index="billOfMaterialName" key="billOfMaterialName" title="BOM Name" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="finishGoodsQuantity" index="finishGoodsQuantity" key="finishGoodsQuantity" title="Quantity" width="100" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="Unit Code" width="100" sortable="true" 
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
    
    <div id="assemblyJobOrderBomItemDetailGrid">
        <sjg:grid
            id="assemblyJobOrderBomItemDetail_grid"
            caption="BOM DETAIL"
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
            width="725"
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
                name="quantity" index="quantity" key="quantity" title="BOM Quantity" width="100" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="Unit" width="150" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />

    <div id="assemblyJobOrderItemDetailGrid">
        <sjg:grid
            id="assemblyJobOrderItemDetail_grid"
            caption="ASSEMBLY JOB ORDER ITEM DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listAssemblyJobOrderItemDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            width="725"
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
                name="quantity" index="quantity" key="quantity" title="ASM-JOB Quantity" width="110" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="Unit" width="150" sortable="true" 
            />
        </sjg:grid >
    </div>
    <br class="spacer" />