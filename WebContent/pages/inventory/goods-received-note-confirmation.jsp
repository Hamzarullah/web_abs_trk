<%-- 
    Document   : goods-received-note
    Created on : Jun 28, 2020, 11:31:56 PM
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
    #goodsReceivedNoteConfirmationItemDetail_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
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
        
        $('#goodsReceivedNoteConfirmationConfirmationStatusRadPENDING').prop('checked',true);
        $("#goodsReceivedNoteConfirmation\\.confirmationStatus").val("PENDING");
            
        $('input[name="goodsReceivedNoteConfirmationConfirmationStatusRad"][value="PENDING"]').change(function(ev){
            $("#goodsReceivedNoteConfirmation\\.confirmationStatus").val("PENDING");
        });
        
        $('input[name="goodsReceivedNoteConfirmationConfirmationStatusRad"][value="CONFIRMED"]').change(function(ev){
            $("#goodsReceivedNoteConfirmation\\.confirmationStatus").val("CONFIRMED");
        });
        
        $('input[name="goodsReceivedNoteConfirmationConfirmationStatusRad"][value="ALL"]').change(function(ev){
            $("#goodsReceivedNoteConfirmation\\.confirmationStatus").val("");
        });

        $.subscribe("goodsReceivedNoteConfirmation_onSelect", function(event, data){
            var selectedRowID = $("#goodsReceivedNoteConfirmation_grid").jqGrid("getGridParam", "selrow"); 
            var goodsReceivedNoteConfirmation = $("#goodsReceivedNoteConfirmation_grid").jqGrid("getRowData", selectedRowID);

            var params="goodsReceivedNote.code=" + goodsReceivedNoteConfirmation.code;
            
            $("#goodsReceivedNoteConfirmationItemDetail_grid").jqGrid("setGridParam",{url:"inventory/goods-received-note-detail-item-detail-data?"+params});
            $("#goodsReceivedNoteConfirmationItemDetail_grid").jqGrid("setCaption", "GRN ITEM DETAIL : " + goodsReceivedNoteConfirmation.code);
            $("#goodsReceivedNoteConfirmationItemDetail_grid").trigger("reloadGrid");
            
        });
        
        $('#btnGoodsReceivedNoteConfirmationUpdate').click(function (ev) {
            var selectedRowID = $("#goodsReceivedNoteConfirmation_grid").jqGrid("getGridParam", "selrow"); 
            if (selectedRowID === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var goodsReceivedNoteConfirmation = $("#goodsReceivedNoteConfirmation_grid").jqGrid("getRowData", selectedRowID);
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=CONFIRMATION";
            
            $.post(url,params,function(result){
                var data=(result);
                
                if (data.error) {
                    var dynamicDialogUpdate= $(
                        '<div id="conformBoxError">'+
                        '<span>'+
                        '</span>'+data.errorMessage+'<br/><br/>' +
                        '</div>');
                    dynamicDialogUpdate.dialog({
                        title        : "Attention!",
                        closeOnEscape: false,
                        modal        : true,
                        width        : 300,
                        resizable    : false,
                        buttons      : 
                                     [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("close");
                                        }
                                    }]
                    }); 
                    return;
                }
                
                if(goodsReceivedNoteConfirmation.confirmationStatus==="CONFIRMED"){
                    alertMessage("Unable to Process this Transaction, this Transaction has been Confirmed!");
                    return;
                }
                var url = "inventory/goods-received-note-confirmation-input";
                var params = "goodsReceivedNoteConfirmation.code=" + goodsReceivedNoteConfirmation.code;
                pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_CONFIRMATION");
            });
            
            ev.preventDefault();
        });
        
        $('#btnGoodsReceivedNoteConfirmationRefresh').click(function(ev) {
            var url = "inventory/goods-received-note";
            var params = "";
            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_CONFIRMATION");
        });
        
        $('#btnGoodsReceivedNoteConfirmation_search').click(function(ev) {
            formatDateGRNConfirmation();
            $("#goodsReceivedNoteConfirmationItemDetail_grid").jqGrid("clearGridData");
            $("#goodsReceivedNoteConfirmationItemDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE ITEM DETAIL");
            $("#goodsReceivedNoteConfirmation_grid").jqGrid("clearGridData");
            $("#goodsReceivedNoteConfirmation_grid").jqGrid("setGridParam",{url:"goods-received-note-confirmation-data?" + $("#frmGoodsReceivedNoteConfirmationSearchInput").serialize()});
            $("#goodsReceivedNoteConfirmation_grid").trigger("reloadGrid");
            formatDateGRNConfirmation();
        });
        
        $("#btnGoodsReceivedNoteConfirmationPrint").click(function(ev) {
            var selectRowId = $("#goodsReceivedNoteConfirmation_grid").jqGrid('getGridParam','selrow');
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=PRINT";
            
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
                
                var goodsReceivedNoteConfirmation = $("#goodsReceivedNoteConfirmation_grid").jqGrid("getRowData", selectRowId);
                var url = "reports/inventory/goods-received-note-print-out-pdf?";
                var params = "goodsReceivedNoteConfirmationCode=" + goodsReceivedNoteConfirmation.code;
                window.open(url+params,'goodsReceivedNoteConfirmation','width=500,height=500');
            });
        });
        
        $("#btnGoodsReceivedNoteConfirmationPrintHalfLetter").click(function(ev) {
            var selectRowId = $("#goodsReceivedNoteConfirmation_grid").jqGrid('getGridParam','selrow');
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=PRINT";
            
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
                
                var goodsReceivedNoteConfirmation = $("#goodsReceivedNoteConfirmation_grid").jqGrid("getRowData", selectRowId);
                var url = "reports/inventory/goods-received-note-print-out-half-letter-pdf?";
                var params = "goodsReceivedNoteConfirmationCode=" + goodsReceivedNoteConfirmation.code;
                window.open(url+params,'goodsReceivedNoteConfirmation','width=500,height=500');
            });
        });
        
    });
    
    function reloadGridGoodsReceivedNoteConfirmation() {
        $("#goodsReceivedNoteConfirmation_grid").trigger("reloadGrid");
    };
    
    function reloadGridDetailGoodsReceivedNoteConfirmation() {
        $("#goodsReceivedNoteConfirmationItemDetail_grid").jqGrid("clearGridData");
        $("#goodsReceivedNoteConfirmationItemDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE BY PURCHASE ORDER DETAIL");
    };
           
    function formatDateGRNConfirmation(){
        var firstDate=$("#goodsReceivedNoteConfirmation\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#goodsReceivedNoteConfirmation\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#goodsReceivedNoteConfirmation\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#goodsReceivedNoteConfirmation\\.transactionLastDate").val(lastDateValue);
    }
        
       
</script>

<s:url id="remoteurlGoodsReceivedNoteConfirmation" action="goods-received-note-confirmation-data" />

<b>GOODS RECEIVED NOTE</b>
<hr>
<br class="spacer" />
<sj:div id="goodsReceivedNoteConfirmationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td> <a href="#" id="btnGoodsReceivedNoteConfirmationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td> 
        </tr>
       
    </table>
</sj:div>       

<br class="spacer" />
<br class="spacer" />

<div id="goodsReceivedNoteConfirmationInputSearch" class="content ui-widget">
    <s:form id="frmGoodsReceivedNoteConfirmationSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="goodsReceivedNoteConfirmation.transactionFirstDate" name="goodsReceivedNoteConfirmation.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="goodsReceivedNoteConfirmation.transactionLastDate" name="goodsReceivedNoteConfirmation.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right" valign="middle">GRN No</td>
                <td>
                    <s:textfield id="goodsReceivedNoteConfirmation.code" placeHolder="GRN No" name="goodsReceivedNoteConfirmation.code" size="25"></s:textfield>
                </td>
                <td align="right">Vendor</td>
                <td>
                    <s:textfield id="goodsReceivedNoteConfirmation.vendorCode" placeHolder=" Code" name="goodsReceivedNoteConfirmation.vendorCode" size="15"></s:textfield>
                    <s:textfield id="goodsReceivedNoteConfirmation.vendorName" placeHolder=" Name" name="goodsReceivedNoteConfirmation.vendorName" size="25"></s:textfield>
                </td>
                <td align="right" valign="middle">Ref No</td>
                <td>
                    <s:textfield id="goodsReceivedNoteConfirmation.refNo" placeHolder="Ref No" name="goodsReceivedNoteConfirmation.refNo" size="25"></s:textfield>
                </td> 
            </tr>
            <tr>
                <td align="right" valign="middle">POD No</td>
                <td>
                    <s:textfield id="goodsReceivedNoteConfirmation.purchaseOrderCode" placeHolder="PO No" name="goodsReceivedNoteConfirmation.purchaseOrderCode" size="25"></s:textfield>
                </td> 
                <td align="right" valign="middle">Warehouse</td>
                <td>
                    <s:textfield id="goodsReceivedNoteConfirmation.warehouseCode" placeHolder=" Code" name="goodsReceivedNoteConfirmation.warehouseCode" size="15"></s:textfield>
                    <s:textfield id="goodsReceivedNoteConfirmation.warehouseName" placeHolder=" Name" name="goodsReceivedNoteConfirmation.warehouseName" size="25"></s:textfield>
                </td> 
                <td align="right" valign="middle">Remark</td>
                <td>
                    <s:textfield id="goodsReceivedNoteConfirmation.remark" placeHolder="Remark" name="goodsReceivedNoteConfirmation.remark" size="25"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Confirmed Status</B></td>
                <td>
                    <s:radio id="goodsReceivedNoteConfirmationConfirmationStatusRad" name="goodsReceivedNoteConfirmationConfirmationStatusRad" label="goodsReceivedNoteConfirmationConfirmationStatusRad" list="{'ALL','PENDING','CONFIRMED'}"></s:radio>
                    <s:textfield id="goodsReceivedNoteConfirmation.confirmationStatus" name="goodsReceivedNoteConfirmation.confirmationStatus" size="20" style="Display:none" ></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGoodsReceivedNoteConfirmation_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
                     
    <!-- GRID HEADER -->    
<div id="goodsReceivedNoteConfirmationGrid">
    <sjg:grid
        id="goodsReceivedNoteConfirmation_grid"
        caption="GOODS RECEIVED NOTE"
        dataType="json"
        href="%{remoteurlGoodsReceivedNoteConfirmation}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGoodsReceivedNote"
        rowList="10,20,50"
        rowNum="10"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="goodsReceivedNoteConfirmation_onSelect"
        width="$('#tabmnugoodsreceivednote').width()"
    >
        <sjg:gridColumn
            name="confirmationStatus" index="confirmationStatus" key="confirmationStatus"  title="Status" width="80" search="false" sortable="true"
        />
        <sjg:gridColumn
            name="code" index="code" key="code"  title="GRN No" width="150" search="false" sortable="true"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="130" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
        />
        <sjg:gridColumn
            name="purchaseOrderCode" index="purchaseOrderCode" key="purchaseOrderCode"  title="POD No" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="vendorCode" index="vendorCode" key="vendorCode"  title="Vendor Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="vendorName" index="vendorName" key="vendorName"  title="Vendor Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="warehouseCode" index="warehouseCode" key="warehouseCode"  title="Warehouse Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="warehouseName" index="warehouseName" key="warehouseName"  title="Warehouse Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo"  title="Ref No" width="100" search="false" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="200" sortable="false" 
        />
    </sjg:grid>
</div>
    
<!-- GRID DETAIL -->    
<br class="spacer" />
<div>
    <table>                    
        <tr>
            <td>
            <sj:a href="#" id="btnGoodsReceivedNoteConfirmationUpdate" button="true">Process</sj:a></td>
        <td/>                            
        </tr>
    </table>
</div>
<br class="spacer" />

<div id="goodsReceivedNoteConfirmationItemDetailGrid">
    <sjg:grid
        id="goodsReceivedNoteConfirmationItemDetail_grid"
        caption="GRN ITEM DETAIL"
        dataType="json"
        pager="true"
        navigator="false"
        navigatorSearch="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGoodsReceivedNoteItemDetail"
        viewrecords="true"
        rowNum="10000"
        rownumbers="true"
        shrinkToFit="false"
        width="900"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" title="Item Material Code" width="100" sortable="true" 
        />
        <sjg:gridColumn
            name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" title="Item Material Name" width="200" sortable="true" 
        />
         <sjg:gridColumn
            name="itemAlias" index="itemAlias" key="itemAlias" title="Item Alias" width="200" sortable="true" 
        />
          <sjg:gridColumn
            name="quantity" index="quantity" key="quantity" title="POD Quantity" width="100" sortable="true" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}"
        /> 
        <sjg:gridColumn
            name="grnQuantity" index="grnQuantity" key="grnQuantity" title="GRN Quantity" width="100" sortable="true" 
            formatter="number" align="right" formatoptions= "{ thousandsSeparator:',',decimalPlaces:2}" hidden="true"
        /> 
        <sjg:gridColumn
            name="itemMaterialUnitOfMeasureCode" index="itemMaterialUnitOfMeasureCode" key="itemMaterialUnitOfMeasureCode" title="Unit" width="100" sortable="true" 
        />
    </sjg:grid >
</div>