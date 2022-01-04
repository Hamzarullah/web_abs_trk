
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
    #purchaseRequestNonItemMaterialRequestClosingDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $('#purchaseRequestNonItemMaterialRequestClosingSearchClosingStatusRadOPEN').prop('checked',true);
        $("#purchaseRequestNonItemMaterialRequestClosing\\.closingStatus").val("OPEN");
            
        $('input[name="purchaseRequestNonItemMaterialRequestClosingSearchClosingStatusRad"][value="OPEN"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestClosing\\.closingStatus").val("OPEN");
        });
        
        $('input[name="purchaseRequestNonItemMaterialRequestClosingSearchClosingStatusRad"][value="CLOSED"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestClosing\\.closingStatus").val("CLOSED");
        });
        
        $('input[name="purchaseRequestNonItemMaterialRequestClosingSearchClosingStatusRad"][value="ALL"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestClosing\\.closingStatus").val("");
        });
        
        $.subscribe("purchaseRequestNonItemMaterialRequestClosing_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequestClosing_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseRequestNonItemMaterialRequestClosing = $("#purchaseRequestNonItemMaterialRequestClosing_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseRequestNonItemMaterialRequestClosingDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-non-item-material-request-detail-data?purchaseRequestNonItemMaterialRequest.code="+ purchaseRequestNonItemMaterialRequestClosing.code});
            $("#purchaseRequestNonItemMaterialRequestClosingDetail_grid").jqGrid("setCaption", "PURCHASE REQUEST NON SALES ORDER DETAIL");
            $("#purchaseRequestNonItemMaterialRequestClosingDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestClosing").click(function (ev) {
            
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequestClosing_grid").jqGrid("getGridParam", "selrow");
            var purchaseRequestNonItemMaterialRequestClosing = $("#purchaseRequestNonItemMaterialRequestClosing_grid").jqGrid('getRowData', selectedRowID);

            if(selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            var url = "purchasing/purchase-request-non-item-material-request-closing-input";
            var param = "purchaseRequestNonItemMaterialRequestClosing.code=" + purchaseRequestNonItemMaterialRequestClosing.code;
            pageLoad(url, param, "#tabmnuPURCHASE_REQUEST_NON_IMR_CLOSING");
                    
            ev.preventDefault();    
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestClosingRefresh").click(function (ev) {
            var url = "purchasing/purchase-request-non-item-material-request-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR_CLOSING");
            ev.preventDefault();
        });
        
        $('#btnPurchaseRequestNonItemMaterialRequestClosing_search').click(function(ev) {
            formatDatePurchaseRequestNonItemMaterialRequestClosing();
            $("#purchaseRequestNonItemMaterialRequestClosing_grid").jqGrid("clearGridData");
            $("#purchaseRequestNonItemMaterialRequestClosing_grid").jqGrid("setGridParam",{url:"purchase-request-non-item-material-request-closing-data?" + $("#frmPurchaseRequestNonItemMaterialRequestClosingSearchInput").serialize()});
            $("#purchaseRequestNonItemMaterialRequestClosing_grid").trigger("reloadGrid");
            $("#purchaseRequestNonItemMaterialRequestClosingDetail_grid").jqGrid("clearGridData");
            formatDatePurchaseRequestNonItemMaterialRequestClosing();
            ev.preventDefault();
        });
        
    }); //EOF READY
    
    function formatDatePurchaseRequestNonItemMaterialRequestClosing(){
        var firstDate=$("#purchaseRequestNonItemMaterialRequestClosing\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseRequestNonItemMaterialRequestClosing\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseRequestNonItemMaterialRequestClosing\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseRequestNonItemMaterialRequestClosing\\.transactionLastDate").val(lastDateValue);
    }
</script>

<s:url id="remoteurlPurchaseRequestNonItemMaterialRequestClosing" action="purchase-request-non-item-material-request-closing-data" />
    <b>PURCHASE REQUEST NON ITEM MATERIAL REQUEST CLOSING</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseRequestNonItemMaterialRequestClosingButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnPurchaseRequestNonItemMaterialRequestClosingRefresh" class="ikb-button ui-state-default ui-corner-all"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    
    <div id="purchaseRequestNonItemMaterialRequestClosingInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseRequestNonItemMaterialRequestClosingSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseRequestNonItemMaterialRequestClosing.transactionFirstDate" name="purchaseRequestNonItemMaterialRequestClosing.transactionFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>Up to *</B>
                        <sj:datepicker id="purchaseRequestNonItemMaterialRequestClosing.transactionLastDate" name="purchaseRequestNonItemMaterialRequestClosing.transactionLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <b>Remark</b>
                        <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.remark" name="purchaseRequestNonItemMaterialRequestClosing.remark" placeHolder=" Remark" size="20"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td align="right">PRQ-Non IMR No</td>
                    <td>
                        <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.code" name="purchaseRequestNonItemMaterialRequestClosing.code" placeHolder=" PR Non IMR" size="20"></s:textfield>
                        Ref No
                        <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.refNo" name="purchaseRequestNonItemMaterialRequestClosing.refNo" placeHolder=" Ref No" size="20"></s:textfield>
                    </td>
                </tr>                
                <tr>
                <td align="right"><B>Closing Status</B></td>
                    <td>
                        <s:radio id="purchaseRequestNonItemMaterialRequestClosingSearchClosingStatusRad" name="purchaseRequestNonItemMaterialRequestClosingSearchClosingStatusRad" label="" list="{'ALL','OPEN','CLOSED'}"></s:radio>
                        <s:textfield id="purchaseRequestNonItemMaterialRequestClosing.closingStatus" name="purchaseRequestNonItemMaterialRequestClosing.closingStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestClosing_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    
    <br class="spacer" />
                  
    <!-- GRID HEADER -->    
    <div id="purchaseRequestNonItemMaterialRequestClosingGrid">
        <sjg:grid
            id="purchaseRequestNonItemMaterialRequestClosing_grid"
            caption="PURCHASE REQUEST NON SALES ORDER CLOSING"
            dataType="json"
            href="%{remoteurlPurchaseRequestNonItemMaterialRequestClosing}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestNonItemMaterialRequestClosing"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupurchaserequestnonsalesorderclosing').width()"
            onSelectRowTopics="purchaseRequestNonItemMaterialRequestClosing_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="PRQ-Non IMR No" width="130"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="150" search="false" align="center"
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
                name="remark" index="remark" key="remark" title="Remark" width="150"
            />
        </sjg:grid >
    </div>
    
    <br class="spacer" />
        <div>
            <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestClosing" button="true" style="width: 90px">Closing</sj:a>
        </div>
    <br class="spacer" />
    
    <div id="purchaseRequestNonItemMaterialRequestClosingDetailGrid">
        <sjg:grid
            id="purchaseRequestNonItemMaterialRequestClosingDetail_grid"
            caption="PURCHASE REQUEST NON SALES ORDER DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestNonItemMaterialRequestDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnupurchaserequestnonsalesorderclosing').width()"
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
    
    

