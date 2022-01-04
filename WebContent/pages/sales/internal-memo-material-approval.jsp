
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
    #internalMemoMaterialApprovalDetail_grid_pager_center{
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
        
        $('#internalMemoMaterialApprovalSearchApprovalStatusRadPENDING').prop('checked',true);
        $("#internalMemoMaterialApproval\\.approvalStatus").val("PENDING");
            
        $('input[name="internalMemoMaterialApprovalSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#internalMemoMaterialApproval\\.approvalStatus").val("PENDING");
        });
        
        $('input[name="internalMemoMaterialApprovalSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#internalMemoMaterialApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="internalMemoMaterialApprovalSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#internalMemoMaterialApproval\\.approvalStatus").val("REJECTED ");
        });
        
        $('input[name="internalMemoMaterialApprovalSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#internalMemoMaterialApproval\\.approvalStatus").val("");
        });
        
        $.subscribe("internalMemoMaterialApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#internalMemoMaterialApproval_grid").jqGrid("getGridParam", "selrow"); 
            var internalMemoMaterialApproval = $("#internalMemoMaterialApproval_grid").jqGrid("getRowData", selectedRowID);
            
            $("#internalMemoMaterialApprovalDetail_grid").jqGrid("setGridParam",{url:"sales/internal-memo-material-detail-approval-data?internalMemoMaterialApproval.code="+ internalMemoMaterialApproval.code});
            $("#internalMemoMaterialApprovalDetail_grid").jqGrid("setCaption", "INTERNAL MEMO MATERIAL DETAIL");
            $("#internalMemoMaterialApprovalDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnInternalMemoMaterialApproval").click(function (ev) {
            
            var deleteRowId = $("#internalMemoMaterialApproval_grid").jqGrid('getGridParam','selrow');
            var internalMemoMaterialApproval = $("#internalMemoMaterialApproval_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/internal-memo-material-approval-input";
            var params = "internalMemoMaterialApproval.code=" + internalMemoMaterialApproval.code;
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_APPROVAL"); 

            ev.preventDefault();
            
        });
        
        $("#btnInternalMemoMaterialApprovalRefresh").click(function (ev) {
            var url = "sales/internal-memo-material-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_APPROVAL");
            ev.preventDefault();
        });
        
        $('#btnInternalMemoMaterialApproval_search').click(function(ev) {
            formatDateIMMApproval();
            $("#internalMemoMaterialApproval_grid").jqGrid("clearGridData");
            $("#internalMemoMaterialApproval_grid").jqGrid("setGridParam",{url:"internal-memo-material-approval-data?" + $("#frmInternalMemoMaterialApprovalSearchInput").serialize()});
            $("#internalMemoMaterialApproval_grid").trigger("reloadGrid");
            $("#internalMemoMaterialApprovalDetail_grid").jqGrid("clearGridData");
            $("#internalMemoMaterialApprovalDetail_grid").jqGrid("setCaption", "INTERNAL MEMO MATERIAL DETAIL");
            formatDateIMMApproval();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDateIMMApproval(){
        var firstDate=$("#internalMemoMaterialApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#internalMemoMaterialApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#internalMemoMaterialApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#internalMemoMaterialApproval\\.transactionLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlInternalMemoMaterialApproval" action="internal-memo-material-approval-data" />
    <b>INTERNAL MEMO MATERIAL APPROVAL</b>
    <hr>
    <br class="spacer" />
    <sj:div id="internalMemoMaterialApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnInternalMemoMaterialApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="internalMemoMaterialApprovalInputSearch" class="content ui-widget">
        <s:form id="frmInternalMemoMaterialApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="internalMemoMaterialApproval.transactionFirstDate" name="internalMemoMaterialApproval.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="internalMemoMaterialApproval.transactionLastDate" name="internalMemoMaterialApproval.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">IMM No</td>
                    <td>
                        <s:textfield id="internalMemoMaterialApproval.code" name="internalMemoMaterialApproval.code" size="27" placeholder=" IMM Code"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Branch</td>
                    <td>
                        <s:textfield id="internalMemoMaterialApproval.branchCode" name="internalMemoMaterialApproval.branchCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="internalMemoMaterialApproval.branchName" name="internalMemoMaterialApproval.branchName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="internalMemoMaterialApprovalSearchApprovalStatusRad" name="internalMemoMaterialApprovalSearchApprovalStatusRad" label="internalMemoMaterialApprovalSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="internalMemoMaterialApproval.approvalStatus" name="internalMemoMaterialApproval.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnInternalMemoMaterialApproval_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="internalMemoMaterialApprovalGrid">
        <sjg:grid
            id="internalMemoMaterialApproval_grid"
            caption="INTERNAL MEMO MATERIAL"
            dataType="json"
            href="%{remoteurlInternalMemoMaterialApproval}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoMaterialApproval"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuinternalmemomaterial').width()"
            onSelectRowTopics="internalMemoMaterialApproval_grid_onSelect"
        >
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Status" width="120" align="center"
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
                name="branchName" index="branchName" key="branchName" title="Branch Name" width="165"
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
    
    <br class="spacer" />
        <div>
            <sj:a href="#" id="btnInternalMemoMaterialApproval" button="true" style="width: 90px">Approval</sj:a>
        </div>
    <br class="spacer" />
    
    <div id="internalMemoMaterialApprovalDetailGrid">
        <sjg:grid
            id="internalMemoMaterialApprovalDetail_grid"
            caption="INTERNAL MEMO MATERIAL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoMaterialApprovalDetail"
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
                name="unitOfMeasureName" index="unitOfMeasureName" key="unitOfMeasureName" title="UOM" width="150" sortable="true" 
            />
        </sjg:grid >
    </div>