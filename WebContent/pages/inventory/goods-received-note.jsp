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
    #goodsReceivedNoteItemDetail_grid_pager_center{
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

        $.subscribe("goodsReceivedNote_onSelect", function(event, data){
            var selectedRowID = $("#goodsReceivedNote_grid").jqGrid("getGridParam", "selrow"); 
            var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectedRowID);

            var params="goodsReceivedNote.code=" + goodsReceivedNote.code;
            
            $("#goodsReceivedNoteItemDetail_grid").jqGrid("setGridParam",{url:"inventory/goods-received-note-detail-item-detail-data?"+params});
            $("#goodsReceivedNoteItemDetail_grid").jqGrid("setCaption", "GRN ITEM DETAIL : " + goodsReceivedNote.code);
            $("#goodsReceivedNoteItemDetail_grid").trigger("reloadGrid");
        });
         
        $('#btnGoodsReceivedNoteNew').click(function(ev) {
            
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=INSERT";
            
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
                
                var url = "inventory/goods-received-note-input";
                var params = "enumGoodsReceivedNoteActivity=NEW";            
                pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE");
            });
        });
        
        $('#btnGoodsReceivedNoteUpdate').click(function(ev) {
           var selectedRowID = $("#goodsReceivedNote_grid").jqGrid("getGridParam", "selrow");
           var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectedRowID);
           if (selectedRowID === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectedRowID);
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=UPDATE";
            
            if(goodsReceivedNote.confirmationStatus === "CONFIRMED"){
                alertMessage("GRN HAS ALREADY CONFIRMED!");
                return;
            }
            
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
                
                var url = "inventory/goods-received-note-input";
                var params = "enumGoodsReceivedNoteActivity=UPDATE" + "&goodsReceivedNote.code=" + goodsReceivedNote.code;
                pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE"); 
            });
        });
        
        $("#btnGoodsReceivedNoteDelete").click(function(ev) {
            
            var selectRowId = $("#goodsReceivedNote_grid").jqGrid('getGridParam','selrow');
            var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectRowId);
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(goodsReceivedNote.confirmationStatus === "CONFIRMED"){
                alertMessage("GRN HAS ALREADY CONFIRMED!");
                return;
            }
            
            var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectRowId);
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=DELETE";
            showLoading();
            $.post(url,params,function(result){
                closeLoading();
                var data=(result);
                if (data.error) {
                   
                    var dynamicDialogUpdate= $(
                        '<div id="conformBoxError">'+
                        '<span>'+
                        '</span>'+data.errorMessage+'<br/><br/>' +
                        '</div>');
                    dynamicDialogUpdate.dialog({
                        title         : "Attention!",
                        closeOnEscape : false,
                        modal         : true,
                        width         : 300,
                        resizable     : false,
                        buttons       : 
                                      [{
                                        text : "OK",
                                        click : function() {
                                            $(this).dialog("close");
                                        }
                                      }]
                    }); 
                    return;
                }
                
                var url="inventory/goods-received-note-confirmation-status";
                var params="&goodsReceivedNote.code="+goodsReceivedNote.code;
                showLoading();
                $.post(url,params,function(result){
                    closeLoading();
                    var data=(result);
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    
                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>GRN No: '+goodsReceivedNote.code+'<br/><br/>' +    
                        '</div>');
                    dynamicDialog.dialog({
                        title           : "Confirmation",
                        closeOnEscape   : false,
                        modal           : true,
                        width           : 300,
                        resizable       : false,
                        buttons         : 
                                        [{
                                            text : "Yes",
                                            click : function() {
                                                var url = "inventory/goods-received-note-delete";
                                                var params = "goodsReceivedNote.code=" + goodsReceivedNote.code;
                                                showLoading();
                                                $.post(url, params, function(data) {
                                                    closeLoading();
                                                    if (data.error) {
                                                        alertMessage(data.errorMessage);
                                                        return;
                                                    }
                                                    reloadGridGoodsReceivedNote();
                                                    reloadGridDetailGoodsReceivedNote();
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
            ev.preventDefault();
        });
        
        $('#btnGoodsReceivedNoteRefresh').click(function(ev) {
            var url = "inventory/goods-received-note";
            var params = "";
            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE");
        });
        
        $('#btnGoodsReceivedNote_search').click(function(ev) {
            formatDateGRN();
            $("#goodsReceivedNoteItemDetail_grid").jqGrid("clearGridData");
            $("#goodsReceivedNoteItemDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE ITEM DETAIL");
            $("#goodsReceivedNote_grid").jqGrid("clearGridData");
            $("#goodsReceivedNote_grid").jqGrid("setGridParam",{url:"goods-received-note-data?" + $("#frmGoodsReceivedNoteSearchInput").serialize()});
            $("#goodsReceivedNote_grid").trigger("reloadGrid");
            formatDateGRN();
        });
        
        $("#btnGoodsReceivedNotePrint").click(function(ev) {
            var selectRowId = $("#goodsReceivedNote_grid").jqGrid('getGridParam','selrow');
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
                
                var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectRowId);
                var url = "reports/inventory/goods-received-note-print-out-pdf?";
                var params = "goodsReceivedNoteCode=" + goodsReceivedNote.code;
                window.open(url+params,'goodsReceivedNote','width=500,height=500');
            });
        });
         $("#btnGoodsReceivedNotePrintHalfLetter").click(function(ev) {
            var selectRowId = $("#goodsReceivedNote_grid").jqGrid('getGridParam','selrow');
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
                
                var goodsReceivedNote = $("#goodsReceivedNote_grid").jqGrid("getRowData", selectRowId);
                var url = "reports/inventory/goods-received-note-print-out-half-letter-pdf?";
                var params = "goodsReceivedNoteCode=" + goodsReceivedNote.code;
                window.open(url+params,'goodsReceivedNote','width=500,height=500');
            });
        });
    });
    
    function reloadGridGoodsReceivedNote() {
        $("#goodsReceivedNote_grid").trigger("reloadGrid");
    };
    
    function reloadGridDetailGoodsReceivedNote() {
        $("#goodsReceivedNoteItemDetail_grid").jqGrid("clearGridData");
        $("#goodsReceivedNoteItemDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE BY PURCHASE ORDER DETAIL");
    };
           
    function formatDateGRN(){
        var firstDate=$("#goodsReceivedNote\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#goodsReceivedNote\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#goodsReceivedNote\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#goodsReceivedNote\\.transactionLastDate").val(lastDateValue);
    }
        
       
</script>

<s:url id="remoteurlGoodsReceivedNote" action="goods-received-note-json" />

<b>GOODS RECEIVED NOTE</b>
<hr>
<br class="spacer" />
<sj:div id="goodsReceivedNoteButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnGoodsReceivedNoteNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnGoodsReceivedNoteUpdate" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnGoodsReceivedNoteDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnGoodsReceivedNoteRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnGoodsReceivedNotePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>       

<br class="spacer" />
<br class="spacer" />

<div id="goodsReceivedNoteInputSearch" class="content ui-widget">
    <s:form id="frmGoodsReceivedNoteSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="goodsReceivedNote.transactionFirstDate" name="goodsReceivedNote.transactionFirstDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="goodsReceivedNote.transactionLastDate" name="goodsReceivedNote.transactionLastDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right" valign="middle">GRN No</td>
                <td>
                    <s:textfield id="goodsReceivedNote.code" placeHolder="GRN No" name="goodsReceivedNote.code" size="25"></s:textfield>
                </td>
                <td align="right">Vendor</td>
                <td>
                    <s:textfield id="goodsReceivedNote.vendorCode" placeHolder=" Code" name="goodsReceivedNote.vendorCode" size="15"></s:textfield>
                    <s:textfield id="goodsReceivedNote.vendorName" placeHolder=" Name" name="goodsReceivedNote.vendorName" size="25"></s:textfield>
                </td>
                <td align="right" valign="middle">Ref No</td>
                <td>
                    <s:textfield id="goodsReceivedNote.refNo" placeHolder="Ref No" name="goodsReceivedNote.refNo" size="25"></s:textfield>
                </td> 
            </tr>
            <tr>
                <td align="right" valign="middle">POD No</td>
                <td>
                    <s:textfield id="goodsReceivedNote.purchaseOrderCode" placeHolder="PO No" name="goodsReceivedNote.purchaseOrderCode" size="25"></s:textfield>
                </td> 
                <td align="right" valign="middle">Warehouse</td>
                <td>
                    <s:textfield id="goodsReceivedNote.warehouseCode" placeHolder=" Code" name="goodsReceivedNote.warehouseCode" size="15"></s:textfield>
                    <s:textfield id="goodsReceivedNote.warehouseName" placeHolder=" Name" name="goodsReceivedNote.warehouseName" size="25"></s:textfield>
                </td> 
                <td align="right" valign="middle">Remark</td>
                <td>
                    <s:textfield id="goodsReceivedNote.remark" placeHolder="Remark" name="goodsReceivedNote.remark" size="25"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGoodsReceivedNote_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
                     
    <!-- GRID HEADER -->    
<div id="goodsReceivedNoteGrid">
    <sjg:grid
        id="goodsReceivedNote_grid"
        caption="GOODS RECEIVED NOTE"
        dataType="json"
        href="%{remoteurlGoodsReceivedNote}"
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
        onSelectRowTopics="goodsReceivedNote_onSelect"
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

<div id="goodsReceivedNoteItemDetailGrid">
    <sjg:grid
        id="goodsReceivedNoteItemDetail_grid"
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
        width="965"
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
        <sjg:gridColumn
            name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="rackName" index="rackName" key="rackName" title="Rack Name" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true"
        />
    </sjg:grid >
</div>