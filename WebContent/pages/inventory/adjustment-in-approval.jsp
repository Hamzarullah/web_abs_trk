<%-- 
    Document   : adjustment-in-approval
    Created on : Jul 6, 2020, 11:57:03 AM
    Author     : Sukha
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
    #adjustmentInApprovalItemDetail_grid_pager_center,#adjustmentInApprovalSerialNoDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
                
    $(document).ready(function(){
        hoverButton();
         
        $('#adjustmentInApprovalStatusRadPENDING').prop('checked',true);
        $("#adjustmentInApprovalSearchApprovalStatus").val("PENDING");
            
        $('input[name="adjustmentInApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#adjustmentInApprovalSearchApprovalStatus").val(value);
        });
        $('input[name="adjustmentInApprovalStatusRad"][value="PENDING"]').change(function(ev){
            var value="PENDING";
            $("#adjustmentInApprovalSearchApprovalStatus").val(value);
        });
        $('input[name="adjustmentInApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            var value="REJECTED";
            $("#adjustmentInApprovalSearchApprovalStatus").val(value);
        });
        $('input[name="adjustmentInApprovalStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#adjustmentInApprovalSearchApprovalStatus").val(value);
        });
        
        $.subscribe("adjustmentInApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInApproval_grid").jqGrid("getGridParam", "selrow"); 
            var adjustmentIn = $("#adjustmentInApproval_grid").jqGrid("getRowData", selectedRowID);

            $("#adjustmentInApprovalItemDetail_grid").jqGrid("setGridParam",{url:"adjustment/adjustment-in-item-detail-data?adjustmentIn.code=" + adjustmentIn.code});
            $("#adjustmentInApprovalItemDetail_grid").jqGrid("setCaption", "NON SERIAL NO : " + adjustmentIn.code);
            $("#adjustmentInApprovalItemDetail_grid").trigger("reloadGrid");
            $("#adjustmentInApprovalSerialNoDetail_grid").jqGrid("clearGridData");
            $("#adjustmentInApprovalSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
        });
        
        $.subscribe("adjustmentInApprovalItemDetail_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentInApprovalItemDetail_grid").jqGrid("getGridParam", "selrow"); 
            var adjustmentInItemDetail = $("#adjustmentInApprovalItemDetail_grid").jqGrid("getRowData", selectedRowID);
            
            $("#adjustmentInApprovalSerialNoDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-in-serial-no-detail-data?adjustmentInItemDetail.code=" + adjustmentInItemDetail.code});
            $("#adjustmentInApprovalSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL : " + adjustmentInItemDetail.code);
            $("#adjustmentInApprovalSerialNoDetail_grid").trigger("reloadGrid");
        });
        
         $("#btnAdjustmentInApproval_approve").click(function(ev) {
            
            var rowId =$("#adjustmentInApproval_grid").jqGrid("getGridParam", "selrow");
            var adjustmentInApproval = $("#adjustmentInApproval_grid").jqGrid("getRowData", rowId);
            
            if (rowId===null){
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="inventory/adjustment-in-confirmation";
            var params="adjustmentIn.code="+adjustmentInApproval.code;

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage("Cannot Proses this Transaction!<br/>"+data.errorMessage);
                    return;
                }

                var url = "adjustment/adjustment-in-approval-input";
                var params = "adjustmentInApproval.code="+adjustmentInApproval.code;
                pageLoad(url, params, "#tabmnuADJUSTMENT_IN_APPROVAL"); 

            });
        });
                        
        $('#btnAdjustmentInApprovalRefresh').click(function(ev) {
            var url = "adjustment/adjustment-in-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuADJUSTMENT_IN_APPROVAL");
        });
        
        
        $('#btnAdjustmentInApproval_search').click(function(ev) {
            formatDateAdjustmentInApproval();
            $("#adjustmentInApproval_grid").jqGrid("clearGridData");
            $("#adjustmentInApprovalItemDetail_grid").jqGrid("clearGridData");
            $("#adjustmentInApprovalItemDetail_grid").jqGrid("setCaption", "ITEM DETAIL");
            $("#adjustmentInApprovalSerialNoDetail_grid").jqGrid("clearGridData");
            $("#adjustmentInApprovalSerialNoDetail_grid").jqGrid("setCaption", "SERIAL NO DETAIL");
            $("#adjustmentInApproval_grid").jqGrid("setGridParam",{url:"adjustment/adjustment-in-approval-data?" + $("#frmAdjustmentInApprovalSearchInput").serialize()});
            $("#adjustmentInApproval_grid").trigger("reloadGrid");
            formatDateAdjustmentInApproval();
            ev.preventDefault();
           
        });
        
    });
        
    function formatDateAdjustmentInApproval(){
        var firstDate=$("#adjustmentInApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#adjustmentInApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#adjustmentInApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#adjustmentInApproval\\.transactionLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlAdjustmentInApproval" action="adjustment-in-approval-data" />
<b> ADJUSTMENT IN APPROVAL</b>
<hr>
    <br class="spacer" />
    <sj:div id="adjustmentInApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnAdjustmentInApprovalRefresh" class="ikb-button ui-state-default ui-corner-all"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="AdjustmentInInputSearch" class="content ui-widget">
        <s:form id="frmAdjustmentInApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="adjustmentInApproval.transactionFirstDate" name="adjustmentInApproval.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="adjustmentInApproval.transactionLastDate" name="adjustmentInApproval.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">ADJ-IN NO</td>
                    <td>
                        <s:textfield id="adjustmentInApprovalSearchCode" name="adjustmentInApprovalSearchCode" size="25"></s:textfield>
                    </td>
          
                    <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="adjustmentInApprovalStatusRad" name="adjustmentInApprovalStatusRad" label="adjustmentInApprovalStatusRad" list="{'APPROVED','PENDING','REJECTED','ALL'}"></s:radio>
                        <s:textfield id="adjustmentInApprovalSearchApprovalStatus" name="adjustmentInApprovalSearchApprovalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
                <sj:a href="#" id="btnAdjustmentInApproval_search" button="true" style="width: 60px">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />      
    <!-- GRID HEADER -->    
   <div id="adjustmentInGrid">
        <sjg:grid
            id="adjustmentInApproval_grid"
            caption="ADJUSTMENT IN APPROVAL"
            dataType="json"
            href="%{remoteurlAdjustmentInApproval}"
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
            onSelectRowTopics="adjustmentInApproval_grid_onSelect"
            width="$('#tabmnuadjustmentinApproval').width()"
            >
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Status" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="code" index="code" key="code" title="ADJ-IN No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="warehouseName" index="warehouseName" key="warehouseName" title="Warehouse Name" width="150" sortable="true" 
            />            
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
            />    
        </sjg:grid>
    </div>
       
    <br class="spacer" />
    <sj:a href="#" id="btnAdjustmentInApproval_approve" button="true" style="width: 80px">Approval</sj:a>
    <br class="spacer" />
    <br class="spacer" />

    <div id="adjustmentInApprovalItemDetailGrid">
        <sjg:grid
            id="adjustmentInApprovalItemDetail_grid"
            caption="NON SERIAL NO"
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
            onSelectRowTopics="adjustmentInApprovalItemDetail_grid_onSelect"
            width="$('#tabmnuadjustmentinApproval').width()"
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
                name="reasonName" index="reasonName" key="reasonName" title="Reason Name" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Qty" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="price" index="price" key="price" title="Price" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="totalAmount" index="totalAmount" key="totalAmount" title="Total" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="rackName" index="rackName" key="rackName" title="Rack Name" width="200" sortable="true" 
            />
        </sjg:grid >
    </div>
    
    <br class="spacer" />
    
    <div id="adjustmentInApprovalSerialNoDetailGrid">
        <sjg:grid
            id="adjustmentInApprovalSerialNoDetail_grid"
            caption="SERIAL NO"
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
            width="$('#tabmnuadjustmentinApproval').width()"
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
                formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:4}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="price" index="price" key="price" title="Price" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
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
        </sjg:grid >
    </div>
