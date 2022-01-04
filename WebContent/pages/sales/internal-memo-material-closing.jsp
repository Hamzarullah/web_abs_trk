
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
    #internalMemoMaterialClosingDetail_grid_pager_center{
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
        
        $('#internalMemoMaterialClosingSearchClosingStatusRadOPEN').prop('checked',true);
        $("#internalMemoMaterialClosing\\.closingStatus").val("OPEN");
            
        $('input[name="internalMemoMaterialClosingSearchClosingStatusRad"][value="OPEN"]').change(function(ev){
            $("#internalMemoMaterialClosing\\.closingStatus").val("OPEN");
        });
        
        $('input[name="internalMemoMaterialClosingSearchClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#internalMemoMaterialClosing\\.closingStatus").val("CLOSED");
        });
        
        $('input[name="internalMemoMaterialClosingSearchClosingStatusRad"][value="ALL"]').change(function(ev){
            $("#internalMemoMaterialClosing\\.closingStatus").val("");
        });
        
        $.subscribe("internalMemoMaterialClosing_grid_onSelect", function(event, data){
            var selectedRowID = $("#internalMemoMaterialClosing_grid").jqGrid("getGridParam", "selrow"); 
            var internalMemoMaterialClosing = $("#internalMemoMaterialClosing_grid").jqGrid("getRowData", selectedRowID);
            
            $("#internalMemoMaterialClosingDetail_grid").jqGrid("setGridParam",{url:"sales/internal-memo-material-detail-closing-data?internalMemoMaterialClosing.code="+ internalMemoMaterialClosing.code});
            $("#internalMemoMaterialClosingDetail_grid").jqGrid("setCaption", "INTERNAL MEMO MATERIAL DETAIL");
            $("#internalMemoMaterialClosingDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnInternalMemoMaterialClosing").click(function (ev) {
            
            var deleteRowId = $("#internalMemoMaterialClosing_grid").jqGrid('getGridParam','selrow');
            var internalMemoMaterialClosing = $("#internalMemoMaterialClosing_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/internal-memo-material-closing-input";
            var params = "internalMemoMaterialClosing.code=" + internalMemoMaterialClosing.code;
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_CLOSING"); 

            ev.preventDefault();
            
        });
        
        $("#btnInternalMemoMaterialClosingRefresh").click(function (ev) {
            var url = "sales/internal-memo-material-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL_CLOSING");
            ev.preventDefault();
        });
        
        $('#btnInternalMemoMaterialClosing_search').click(function(ev) {
            formatDateIMMClosing();
            $("#internalMemoMaterialClosing_grid").jqGrid("clearGridData");
            $("#internalMemoMaterialClosing_grid").jqGrid("setGridParam",{url:"internal-memo-material-closing-data?" + $("#frmInternalMemoMaterialClosingSearchInput").serialize()});
            $("#internalMemoMaterialClosing_grid").trigger("reloadGrid");
            $("#internalMemoMaterialClosingDetail_grid").jqGrid("clearGridData");
            $("#internalMemoMaterialClosingDetail_grid").jqGrid("setCaption", "INTERNAL MEMO MATERIAL DETAIL");
            formatDateIMMClosing();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDateIMMClosing(){
        var firstDate=$("#internalMemoMaterialClosing\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#internalMemoMaterialClosing\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#internalMemoMaterialClosing\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#internalMemoMaterialClosing\\.transactionLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlInternalMemoMaterialClosing" action="internal-memo-material-closing-data" />
    <b>INTERNAL MEMO MATERIAL CLOSING</b>
    <hr>
    <br class="spacer" />
    <sj:div id="internalMemoMaterialClosingButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnInternalMemoMaterialClosingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="internalMemoMaterialClosingInputSearch" class="content ui-widget">
        <s:form id="frmInternalMemoMaterialClosingSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="internalMemoMaterialClosing.transactionFirstDate" name="internalMemoMaterialClosing.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="internalMemoMaterialClosing.transactionLastDate" name="internalMemoMaterialClosing.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">IMM No</td>
                    <td>
                        <s:textfield id="internalMemoMaterialClosing.code" name="internalMemoMaterialClosing.code" size="27" placeholder=" IMM Code"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Branch</td>
                    <td>
                        <s:textfield id="internalMemoMaterialClosing.branchCode" name="internalMemoMaterialClosing.branchCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="internalMemoMaterialClosing.branchName" name="internalMemoMaterialClosing.branchName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                <td align="right"><B>Closing Status</B></td>
                    <td>
                        <s:radio id="internalMemoMaterialClosingSearchClosingStatusRad" name="internalMemoMaterialClosingSearchClosingStatusRad" label="" list="{'ALL','OPEN','CLOSED'}"></s:radio>
                        <s:textfield id="internalMemoMaterialClosing.closingStatus" name="internalMemoMaterialClosing.closingStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnInternalMemoMaterialClosing_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="internalMemoMaterialClosingGrid">
        <sjg:grid
            id="internalMemoMaterialClosing_grid"
            caption="INTERNAL MEMO MATERIAL"
            dataType="json"
            href="%{remoteurlInternalMemoMaterialClosing}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoMaterialClosing"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuinternalmemomaterial').width()"
            onSelectRowTopics="internalMemoMaterialClosing_grid_onSelect"
        >
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
            <sj:a href="#" id="btnInternalMemoMaterialClosing" button="true" style="width: 90px">Closing</sj:a>
        </div>
    <br class="spacer" />
    
    <div id="internalMemoMaterialClosingDetailGrid">
        <sjg:grid
            id="internalMemoMaterialClosingDetail_grid"
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
            gridModel="listInternalMemoMaterialClosingDetail"
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