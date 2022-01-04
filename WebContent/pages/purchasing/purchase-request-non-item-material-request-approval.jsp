
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
    #purchaseRequestNonItemMaterialRequestApprovalDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $('#purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRadPENDING').prop('checked',true);
        $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("PENDING");
            
        $('input[name="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("PENDING");
        });
        
        $('input[name="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("REJECTED ");
        });
        
        $('input[name="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#purchaseRequestNonItemMaterialRequestApproval\\.approvalStatus").val("");
        });
        
        $.subscribe("purchaseRequestNonItemMaterialRequestApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequestApproval_grid").jqGrid("getGridParam", "selrow"); 
            var purchaseRequestNonItemMaterialRequestApproval = $("#purchaseRequestNonItemMaterialRequestApproval_grid").jqGrid("getRowData", selectedRowID);
            
            $("#purchaseRequestNonItemMaterialRequestApprovalDetail_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-non-item-material-request-detail-data?purchaseRequestNonItemMaterialRequest.code="+ purchaseRequestNonItemMaterialRequestApproval.code});
            $("#purchaseRequestNonItemMaterialRequestApprovalDetail_grid").jqGrid("setCaption", "PURCHASE REQUEST NON SALES ORDER DETAIL");
            $("#purchaseRequestNonItemMaterialRequestApprovalDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestApproval").click(function (ev) {
            
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequestApproval_grid").jqGrid("getGridParam", "selrow");
            var purchaseRequestNonItemMaterialRequestApproval = $("#purchaseRequestNonItemMaterialRequestApproval_grid").jqGrid('getRowData', selectedRowID);

            if(selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            var url = "purchasing/purchase-request-non-item-material-request-approval-input";
            var param = "purchaseRequestNonItemMaterialRequestApproval.code=" + purchaseRequestNonItemMaterialRequestApproval.code;
            pageLoad(url, param, "#tabmnuPURCHASE_REQUEST_NON_IMR_APPROVAL");
                    
            ev.preventDefault();    
        });
        
        $("#btnPurchaseRequestNonItemMaterialRequestApprovalRefresh").click(function (ev) {
            var url = "purchasing/purchase-request-non-item-material-request-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR_APPROVAL");
            ev.preventDefault();
        });
        
        $('#btnPurchaseRequestNonItemMaterialRequestApproval_search').click(function(ev) {
            formatDatePurchaseRequestNonItemMaterialRequestApproval();
            $("#purchaseRequestNonItemMaterialRequestApproval_grid").jqGrid("clearGridData");
            $("#purchaseRequestNonItemMaterialRequestApproval_grid").jqGrid("setGridParam",{url:"purchase-request-non-item-material-request-approval-data?" + $("#frmPurchaseRequestNonItemMaterialRequestApprovalSearchInput").serialize()});
            $("#purchaseRequestNonItemMaterialRequestApproval_grid").trigger("reloadGrid");
            $("#purchaseRequestNonItemMaterialRequestApprovalDetail_grid").jqGrid("clearGridData");
            formatDatePurchaseRequestNonItemMaterialRequestApproval();
            ev.preventDefault();
        });
        
    }); //EOF READY
    
    function formatDatePurchaseRequestNonItemMaterialRequestApproval(){
        var firstDate=$("#purchaseRequestNonItemMaterialRequestApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#purchaseRequestNonItemMaterialRequestApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#purchaseRequestNonItemMaterialRequestApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#purchaseRequestNonItemMaterialRequestApproval\\.transactionLastDate").val(lastDateValue);
    }
</script>

<s:url id="remoteurlPurchaseRequestNonItemMaterialRequestApproval" action="purchase-request-non-item-material-request-approval-data" />
    <b>PURCHASE REQUEST NON ITEM MATERIAL REQUEST APPROVAL</b>
    <hr>
    <br class="spacer" />
    <sj:div id="purchaseRequestNonItemMaterialRequestApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnPurchaseRequestNonItemMaterialRequestApprovalRefresh" class="ikb-button ui-state-default ui-corner-all"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    
    <div id="purchaseRequestNonItemMaterialRequestApprovalInputSearch" class="content ui-widget">
        <s:form id="frmPurchaseRequestNonItemMaterialRequestApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="purchaseRequestNonItemMaterialRequestApproval.transactionFirstDate" name="purchaseRequestNonItemMaterialRequestApproval.transactionFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth = "true" changeYear="true"></sj:datepicker>
                        <B>Up to *</B>
                        <sj:datepicker id="purchaseRequestNonItemMaterialRequestApproval.transactionLastDate" name="purchaseRequestNonItemMaterialRequestApproval.transactionLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth = "true" changeYear="true"></sj:datepicker>
                        <b>Remark</b>
                        <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.remark" name="purchaseRequestNonItemMaterialRequestApproval.remark" placeHolder=" Remark" size="20"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td align="right">PRQ-Non IMR No</td>
                    <td>
                        <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.code" name="purchaseRequestNonItemMaterialRequestApproval.code" placeHolder=" PR Non IMR" size="20"></s:textfield>
                        Ref No
                        <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.refNo" name="purchaseRequestNonItemMaterialRequestApproval.refNo" placeHolder=" Ref No" size="20"></s:textfield>
                    </td>
                </tr>                
                <tr>
                <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad" name="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad" label="purchaseRequestNonItemMaterialRequestApprovalSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="purchaseRequestNonItemMaterialRequestApproval.approvalStatus" name="purchaseRequestNonItemMaterialRequestApproval.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestApproval_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    
    <br class="spacer" />
                  
    <!-- GRID HEADER -->    
    <div id="purchaseRequestNonItemMaterialRequestApprovalGrid">
        <sjg:grid
            id="purchaseRequestNonItemMaterialRequestApproval_grid"
            caption="PURCHASE REQUEST NON SALES ORDER APPROVAL"
            dataType="json"
            href="%{remoteurlPurchaseRequestNonItemMaterialRequestApproval}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listPurchaseRequestNonItemMaterialRequestApproval"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupurchaserequestnonsalesorder').width()"
            onSelectRowTopics="purchaseRequestNonItemMaterialRequestApproval_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130"
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
            <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestApproval" button="true" style="width: 90px">Approval</sj:a>
        </div>
    <br class="spacer" />
    
    <div id="purchaseRequestNonItemMaterialRequestApprovalDetailGrid">
        <sjg:grid
            id="purchaseRequestNonItemMaterialRequestApprovalDetail_grid"
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
    
    

