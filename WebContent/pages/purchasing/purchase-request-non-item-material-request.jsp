
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
    #purchaseRequestNonItemMaterialRequestDetail_grid_pager_center{
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
        
        $.subscribe("purchaseRequestNonItemMaterialRequest_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseRequestNonItemMaterialRequest = $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseRequestNonItemMaterialRequestDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-non-item-material-request-detail-data?purchaseRequestNonItemMaterialRequest.code="+ purchaseRequestNonItemMaterialRequest.code});
            $("#purchaseRequestNonItemMaterialRequestDetail_grid").jqGrid("setCaption", "PURCHASE REQUEST NON SALES ORDER DETAIL");
            $("#purchaseRequestNonItemMaterialRequestDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestNew").click(function (ev) {
           
            var url = "purchasing/purchase-request-non-item-material-request-input";
            var param = "";

            pageLoad(url, param, "#tabmnuPURCHASE_REQUEST_NON_IMR");
            ev.preventDefault();    
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestUpdate").click(function (ev) {
            
            var deleteRowId = $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid('getGridParam','selrow');
            var purchaseRequestNonItemMaterialRequest = $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var params = "purchaseRequestNonItemMaterialRequestUpdateMode=true" + "&purchaseRequestNonItemMaterialRequest.code=" + purchaseRequestNonItemMaterialRequest.code;
            pageLoad("purchasing/purchase-request-non-item-material-request-input", params, "#tabmnuPURCHASE_REQUEST_NON_IMR"); 

            ev.preventDefault();
            
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestDelete").click(function (ev) {
            
            var deleteRowId = $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid('getGridParam','selrow');
            var purchaseRequestNonItemMaterialRequest = $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "purchasing/purchase-request-non-item-material-request-delete";
            var params = "purchaseRequestNonItemMaterialRequest.code=" + purchaseRequestNonItemMaterialRequest.code;
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PRQ No: '+purchaseRequestNonItemMaterialRequest.code+'<br/><br/>' +    
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
                                          $("#purchaseRequestNonItemMaterialRequest_grid").trigger("reloadGrid");
                                          $("#purchaseRequestNonItemMaterialRequestDetail_grid").trigger("reloadGrid");
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
        
        $("#btnPurchaseRequestNonItemMaterialRequestRefresh").click(function (ev) {
            var url = "purchasing/purchase-request-non-item-material-request";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR");
            ev.preventDefault();
        });
        
        $('#btnPurchaseRequestNonItemMaterialRequest_search').click(function(ev) {
            formatDatePRQNonSo();
            $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid("clearGridData");
            $("#purchaseRequestNonItemMaterialRequest_grid").jqGrid("setGridParam",{url:"purchase-request-non-item-material-request-data?" + $("#frmPurchaseRequestNonItemMaterialRequestSearchInput").serialize()});
            $("#purchaseRequestNonItemMaterialRequest_grid").trigger("reloadGrid");
            formatDatePRQNonSo();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDatePRQNonSo(){
        var firstDate=$("#purchaseRequestNonItemMaterialRequest\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseRequestNonItemMaterialRequest\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseRequestNonItemMaterialRequest\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseRequestNonItemMaterialRequest\\.transactionLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlPurchaseRequestNonItemMaterialRequest" action="purchase-request-non-item-material-request-data" />
    <b>PURCHASE REQUEST NON ITEM MATERIAL REQUEST</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseRequestNonItemMaterialRequestButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnPurchaseRequestNonItemMaterialRequestNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnPurchaseRequestNonItemMaterialRequestUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnPurchaseRequestNonItemMaterialRequestDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnPurchaseRequestNonItemMaterialRequestRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnPurchaseRequestNonItemMaterialRequestPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="purchaseRequestNonItemMaterialRequestInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseRequestNonItemMaterialRequestSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseRequestNonItemMaterialRequest.transactionFirstDate" name="purchaseRequestNonItemMaterialRequest.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="purchaseRequestNonItemMaterialRequest.transactionLastDate" name="purchaseRequestNonItemMaterialRequest.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td  align="right">PRQ-Non IMR No</td>
                    <td>
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.code" name="purchaseRequestNonItemMaterialRequest.code" size="27" placeholder=" PRQ Non IMR"></s:textfield>
                    </td>
                    <td width="10"/>
                    <td align="right">Branch</td>
                    <td>
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.branchCode" name="purchaseRequestNonItemMaterialRequest.branchCode" size="10" placeholder=" Code"></s:textfield>
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.branchName" name="purchaseRequestNonItemMaterialRequest.branchName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequest_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="purchaseRequestNonItemMaterialRequestGrid">
        <sjg:grid
            id="purchaseRequestNonItemMaterialRequest_grid"
            caption="PURCHASE REQUEST NON ITEM MATERIAL REQUEST"
            dataType="json"
            href="%{remoteurlPurchaseRequestNonItemMaterialRequest}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestNonItemMaterialRequest"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupurchaserequestnonsalesorder').width()"
            onSelectRowTopics="purchaseRequestNonItemMaterialRequest_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="PRQ-Non IMR No" width="150"
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
    
    <div id="purchaseRequestNonItemMaterialRequestDetailGrid">
        <sjg:grid
            id="purchaseRequestNonItemMaterialRequestDetail_grid"
            caption="PURCHASE REQUEST NON ITEM MATERIAL REQUEST DETAIL"
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
            width="$('#tabmnupurchaserequestnonsalesorder').width()"
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
    
    

