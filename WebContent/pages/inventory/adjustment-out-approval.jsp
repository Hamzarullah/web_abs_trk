<%-- 
    Document   : adjustment-out-approval
    Created on : Jul 6, 2020, 11:58:34 AM
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
    #adjustmentOutApprovalItemDetail_grid_pager_center,#adjustmentOutApprovalSerialNoDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
                
    $(document).ready(function(){
        hoverButton();
         
        $('#adjustmentOutApprovalApprovalStatusRadPENDING').prop('checked',true);
        $("#adjustmentOutApproval\\.approvalStatus").val("PENDING");
            
        $('input[name="adjustmentOutApprovalApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            var value="APPROVED";
            $("#adjustmentOutApproval\\.approvalStatus").val(value);
            $('#btnAdjustmentOutApproval_search').trigger('click');
        });
        $('input[name="adjustmentOutApprovalApprovalStatusRad"][value="PENDING"]').change(function(ev){
            var value="PENDING";
            $("#adjustmentOutApproval\\.approvalStatus").val(value);
            $('#btnAdjustmentOutApproval_search').trigger('click');
        });
        $('input[name="adjustmentOutApprovalApprovalStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#adjustmentOutApproval\\.approvalStatus").val(value);
            $('#btnAdjustmentOutApproval_search').trigger('click');
        });
        
        $.subscribe("adjustmentOutApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#adjustmentOutApproval_grid").jqGrid("getGridParam", "selrow"); 
            var adjustmentOut = $("#adjustmentOutApproval_grid").jqGrid("getRowData", selectedRowID);

            $("#adjustmentOutApprovalItemDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-out-item-detail-data?adjustmentOut.code=" + adjustmentOut.code});
            $("#adjustmentOutApprovalItemDetail_grid").jqGrid("setCaption", "ADJUSTMENT OUT ITEM DETAIL : " + adjustmentOut.code);
            $("#adjustmentOutApprovalItemDetail_grid").trigger("reloadGrid");  
             $("#adjustmentOutApprovalSerialNoDetail_grid").jqGrid("setGridParam",{url:"inventory/adjustment-out-serial-no-detail-data?adjustmentOut.code=" + adjustmentOut.code});
            $("#adjustmentOutApprovalSerialNoDetail_grid").jqGrid("setCaption", "ADJUSTMENT OUT SERIAL NO DETAIL : " + adjustmentOut.code);
            $("#adjustmentOutApprovalSerialNoDetail_grid").trigger("reloadGrid");
        });
        
       
       
         $("#btnAdjustmentOutApproval_approve").click(function(ev) {
            
            var selectedRowID =$("#adjustmentOutApproval_grid").jqGrid("getGridParam", "selrow");
            var adjustmentOutApproval = $("#adjustmentOutApproval_grid").jqGrid("getRowData", selectedRowID);
            
            if (selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            
            if(adjustmentOutApproval.approvalStatus==='Approved'){
                alertMessage("IOT No :"+adjustmentOutApproval.code+" Can't processed!<br/><br/> This Transaction Has Been Approved!");
                return;
            }
            
            var adjustmentOrderApproval = $("#adjustmentOutApproval_grid").jqGrid("getRowData", selectedRowID);
            var url = "inventory/adjustment-out-approval-input";
            var params = "adjustmentOutApproval.code="+adjustmentOrderApproval.code;
            pageLoad(url, params, "#tabmnuADJUSTMENT_OUT_APPROVAL");
            
        });
                        
        $('#btnAdjustmentOutApprovalRefresh').click(function(ev) {
            var url = "inventory/adjustment-out-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuADJUSTMENT_OUT_APPROVAL");
        });
        
        
        $('#btnAdjustmentOutApproval_search').click(function(ev) {
            formatDateAdjustmentOutApproval();
            $("#adjustmentOutApproval_grid").jqGrid("clearGridData");
            $("#adjustmentOutApprovalItemDetail_grid").jqGrid("clearGridData");
            $("#adjustmentOutApprovalSerialNoDetail_grid").jqGrid("clearGridData");
            $("#adjustmentOutApproval_grid").jqGrid("setGridParam",{url:"inventory/adjustment-out-approval-data?" + $("#frmAdjustmentOutApprovalSearchInput").serialize()});
            $("#adjustmentOutApproval_grid").trigger("reloadGrid");
            formatDateAdjustmentOutApproval();
            ev.preventDefault();
           
        });
    });
        
    function formatDateAdjustmentOutApproval(){
        var firstDate=$("#adjustmentOutApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#adjustmentOutApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#adjustmentOutApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#adjustmentOutApproval\\.transactionLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlAdjustmentOutApproval" action="adjustment-out-approval-data" />
<b> ADJUSTMENT OUT APPROVAL</b>
<hr>
    <br class="spacer" />
    <sj:div id="adjustmentOutApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnAdjustmentOutApprovalRefresh" class="ikb-button ui-state-default ui-corner-all"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="AdjustmentOutInputSearch" class="content ui-widget">
        <s:form id="frmAdjustmentOutApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="adjustmentOutApproval.transactionFirstDate" name="adjustmentOutApproval.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="adjustmentOutApproval.transactionLastDate" name="adjustmentOutApproval.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="adjustmentOutApproval.code" name="adjustmentOutApproval.code" size="25" placeHolder=" Iot No"></s:textfield>
                    </td>
          
                    <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="adjustmentOutApprovalApprovalStatusRad" name="adjustmentOutApprovalApprovalStatusRad" label="adjustmentOutApprovalApprovalStatusRad" list="{'APPROVED','PENDING','ALL'}"></s:radio>
                        <s:textfield id="adjustmentOutApproval.approvalStatus" name="adjustmentOutApproval.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
                <sj:a href="#" id="btnAdjustmentOutApproval_search" button="true" style="width: 60px">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />      
    <!-- GRID HEADER -->    
   <div id="adjustmentOutApprovalGrid">
        <sjg:grid
            id="adjustmentOutApproval_grid"
            caption="ADJUSTMENT OUT"
            dataType="json"
            href="%{remoteurlAdjustmentOutApproval}"
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
            onSelectRowTopics="adjustmentOutApproval_grid_onSelect"
            width="$('#tabmnuadjustmentoutApproval').width()"
            >
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Status" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="150" sortable="true"
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
                name="approvalBy" index="approvalBy" key="approvalBy" title="Approval By" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="approvalDate" index="approvalDate" key="approvalDate" 
                title="Approval Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
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
    <sj:a href="#" id="btnAdjustmentOutApproval_approve" button="true" style="width: 80px">Approval</sj:a>
    <br class="spacer" />
    <br class="spacer" />

    <div id="adjustmentOutApprovalItemDetailGrid">
        <sjg:grid
            id="adjustmentOutApprovalItemDetail_grid"
            caption="ADJUSTMENT OUT ITEM DETAIL"
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
            width="$('#tabmnuadjustmentoutApproval').width()"
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
                name="quantity" index="quantity" key="quantity" title="Qty" width="80" sortable="true" 
                align="right" formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="80" sortable="true" 
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true" 
            />
        </sjg:grid >
    </div>
    
    <br class="spacer" />
    
    <div id="adjustmentOutApprovalSerialNoDetailGrid">
        <sjg:grid
            id="adjustmentOutApprovalSerialNoDetail_grid"
            caption="ADJUSTMENT OUT SERIAL NO DETAIL"
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
            width="$('#tabmnuadjustmentoutApproval').width()"
        >
            <sjg:gridColumn
                name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Name" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="serialNo" index="serialNo" key="serialNo" title="SerialNo" width="300" sortable="true" 
            />
            <sjg:gridColumn
                name="capacity" index="capacity" key="capacity" title="Capacity" width="80" sortable="true" 
                formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="300" sortable="true" 
            />
        </sjg:grid >
    </div>

