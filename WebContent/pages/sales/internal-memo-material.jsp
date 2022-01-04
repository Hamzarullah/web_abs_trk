
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
    #internalMemoMaterialDetail_grid_pager_center{
        display: none;
    }
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("internalMemoMaterial_grid_onSelect", function(event, data){
            var selectedRowID = $("#internalMemoMaterial_grid").jqGrid("getGridParam", "selrow"); 
            var internalMemoMaterial = $("#internalMemoMaterial_grid").jqGrid("getRowData", selectedRowID);
            
            $("#internalMemoMaterialDetail_grid").jqGrid("setGridParam",{url:"sales/internal-memo-material-detail-data?internalMemoMaterial.code="+ internalMemoMaterial.code});
            $("#internalMemoMaterialDetail_grid").jqGrid("setCaption", "INTERNAL MEMO MATERIAL DETAIL");
            $("#internalMemoMaterialDetail_grid").trigger("reloadGrid");
            
        });
        
        //RDN Approval
        $('#internalMemoMaterialSearchApprovalStatusRadPENDING').prop('checked',true);
        $("#internalMemoMaterial\\.approvalStatus").val("PENDING");
            
        $('input[name="internalMemoMaterialSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#internalMemoMaterial\\.approvalStatus").val("PENDING");
        });
        
        $('input[name="internalMemoMaterialSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#internalMemoMaterial\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="internalMemoMaterialSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#internalMemoMaterial\\.approvalStatus").val("REJECTED ");
        });
        
        $('input[name="internalMemoMaterialSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#internalMemoMaterial\\.approvalStatus").val("");
        });
        //END RDN Approval
        
        //RDN Closing
        $('#internalMemoMaterialSearchClosingStatusRadOPEN').prop('checked',true);
        $("#internalMemoMaterial\\.closingStatus").val("OPEN");
            
        $('input[name="internalMemoMaterialSearchClosingStatusRad"][value="OPEN"]').change(function(ev){
            $("#internalMemoMaterial\\.closingStatus").val("OPEN");
        });
            
        $('input[name="internalMemoMaterialSearchClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#internalMemoMaterial\\.closingStatus").val("CLOSED");
        });
        
        $('input[name="internalMemoMaterialSearchClosingStatusRad"][value="ALL"]').change(function(ev){
            $("#internalMemoMaterial\\.closingStatus").val("");
        });
        //END RDN Closing
        
        $("#btnInternalMemoMaterialNew").click(function (ev) {
           
            var url = "sales/internal-memo-material-input";
            var param = "enumInternalMemoMaterialActivity=NEW";

            pageLoad(url, param, "#tabmnuINTERNAL_MEMO_MATERIAL");
            ev.preventDefault();    
        });
        
        $("#btnInternalMemoMaterialUpdate").click(function (ev) {
            
            var deleteRowId = $("#internalMemoMaterial_grid").jqGrid('getGridParam','selrow');
            var internalMemoMaterial = $("#internalMemoMaterial_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var params = "enumInternalMemoMaterialActivity=UPDATE" + "&internalMemoMaterial.code=" + internalMemoMaterial.code;
            pageLoad("sales/internal-memo-material-input", params, "#tabmnuINTERNAL_MEMO_MATERIAL"); 

            ev.preventDefault();
            
        });
        
        $("#btnInternalMemoMaterialDelete").click(function (ev) {
            
            var deleteRowId = $("#internalMemoMaterial_grid").jqGrid('getGridParam','selrow');
            var internalMemoMaterial = $("#internalMemoMaterial_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/internal-memo-material-delete";
            var params = "internalMemoMaterial.code=" + internalMemoMaterial.code;
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PRQ No: '+internalMemoMaterial.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title           : "Message",
                closeOnEscape   : false,
                modal           : true,
                width           : 300,
                resizable       : false,
                buttons         : [{
                                    text : "Yes",
                                    click : function() {
                                        $.post(url, params, function(data) {
                                            if (data.error) {
                                                alertMessage(data.errorMessage,400,"");
                                                return;
                                            }
                                          $("#internalMemoMaterial_grid").trigger("reloadGrid");
                                          $("#internalMemoMaterialDetail_grid").trigger("reloadGrid");
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
            ev.preventDefault();
            
        });
        
        $("#btnInternalMemoMaterialRefresh").click(function (ev) {
            var url = "sales/internal-memo-material";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL");
            ev.preventDefault();
        });
        
        $('#btnInternalMemoMaterial_search').click(function(ev) {
            formatDateIMM();
            $("#internalMemoMaterial_grid").jqGrid("clearGridData");
            $("#internalMemoMaterial_grid").jqGrid("setGridParam",{url:"internal-memo-material-data?" + $("#frmInternalMemoMaterialSearchInput").serialize()});
            $("#internalMemoMaterial_grid").trigger("reloadGrid");
            $("#internalMemoMaterialDetail_grid").jqGrid("clearGridData");
            $("#internalMemoMaterialDetail_grid").jqGrid("setCaption", "INTERNAL MEMO MATERIAL DETAIL");
            formatDateIMM();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDateIMM(){
        var firstDate=$("#internalMemoMaterial\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#internalMemoMaterial\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#internalMemoMaterial\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#internalMemoMaterial\\.transactionLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlInternalMemoMaterial" action="internal-memo-material-data" />
    <b>INTERNAL MEMO MATERIAL</b>
    <hr>
    <br class="spacer" />
    <sj:div id="internalMemoMaterialButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnInternalMemoMaterialNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnInternalMemoMaterialUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnInternalMemoMaterialDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnInternalMemoMaterialRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnInternalMemoMaterialPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="internalMemoMaterialInputSearch" class="content ui-widget">
        <s:form id="frmInternalMemoMaterialSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="internalMemoMaterial.transactionFirstDate" name="internalMemoMaterial.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="internalMemoMaterial.transactionLastDate" name="internalMemoMaterial.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">IMM No</td>
                    <td>
                        <s:textfield id="internalMemoMaterial.code" name="internalMemoMaterial.code" size="27" placeholder=" IMM Code"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Branch</td>
                    <td>
                        <s:textfield id="internalMemoMaterial.branchCode" name="internalMemoMaterial.branchCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="internalMemoMaterial.branchName" name="internalMemoMaterial.branchName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="internalMemoMaterialSearchApprovalStatusRad" name="internalMemoMaterialSearchApprovalStatusRad" label="internalMemoMaterialSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="internalMemoMaterial.approvalStatus" name="internalMemoMaterial.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Closing Status</B></td>
                    <td>
                        <s:radio id="internalMemoMaterialSearchClosingStatusRad" name="internalMemoMaterialSearchClosingStatusRad" label="internalMemoMaterialSearchClosingStatusRad" list="{'ALL','OPEN','CLOSED'}"></s:radio>
                        <s:textfield id="internalMemoMaterial.closingStatus" name="internalMemoMaterial.closingStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnInternalMemoMaterial_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="internalMemoMaterialGrid">
        <sjg:grid
            id="internalMemoMaterial_grid"
            caption="INTERNAL MEMO MATERIAL"
            dataType="json"
            href="%{remoteurlInternalMemoMaterial}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoMaterial"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuinternalmemomaterial').width()"
            onSelectRowTopics="internalMemoMaterial_grid_onSelect"
        >
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval Status" width="120" align="center"
            />
            <sjg:gridColumn
                name="code" index="code" key="code" title="IMM No" width="150"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="100" search="false" align="center"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch Code" width="150"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch Name" width="150"
            />
            <sjg:gridColumn
                name="divisionName" index="divisionName" key="divisionName" title="Division Name" width="150"
            />
            <sjg:gridColumn
                name="departmentName" index="departmentName" key="departmentName" title="Department Name" width="150"
            />
            <sjg:gridColumn
                name="requestBy" index="requestBy" key="requestBy" title="Request By" width="150"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="150"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div id="internalMemoMaterialDetailGrid">
        <sjg:grid
            id="internalMemoMaterialDetail_grid"
            caption="ITEM MATERIAL MATERIAL DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoMaterialDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnuinternalmemomaterial').width()"
        > 
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="140" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name = "itemMaterialCode" id="itemMaterialCode" index = "itemMaterialCode" key = "itemMaterialCode" title = "Item Code" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "itemMaterialName" index = "itemMaterialName" key = "itemMaterialName" title = "Item Name" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "onHandStock" index = "onHandStock" key = "onHandStock" title = "On Hand Stock" formatter="number" width = "150" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name = "quantity" index = "quantity" key = "quantity" title = "Quantity" formatter="number" width = "150" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="UOM" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="unitOfMeasureName" index="unitOfMeasureName" key="unitOfMeasureName" title="UOM" width="150" sortable="true" 
                hidden="true"
            />
        </sjg:grid >
    </div>