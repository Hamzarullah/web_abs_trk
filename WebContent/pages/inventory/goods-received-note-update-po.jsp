
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    #goodsReceivedNoteUpdatePoItemDetail_grid_pager_center{
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

        $.subscribe("goodsReceivedNoteUpdatePo_onSelect", function(event, data){
            var selectedRowID = $("#goodsReceivedNoteUpdatePo_grid").jqGrid("getGridParam", "selrow"); 
            var goodsReceivedNoteUpdatePo = $("#goodsReceivedNoteUpdatePo_grid").jqGrid("getRowData", selectedRowID);

            var params="goodsReceivedNote.code=" + goodsReceivedNoteUpdatePo.code;
            
            $("#goodsReceivedNoteUpdatePoItemDetail_grid").jqGrid("setGridParam",{url:"inventory/goods-received-note-detail-item-detail-data?"+params});
            $("#goodsReceivedNoteUpdatePoItemDetail_grid").jqGrid("setCaption", "GRN ITEM DETAIL : " + goodsReceivedNoteUpdatePo.code);
            $("#goodsReceivedNoteUpdatePoItemDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnGoodsReceivedNoteUpdatePoUpdate').click(function(ev) {
           var selectedRowID = $("#goodsReceivedNoteUpdatePo_grid").jqGrid("getGridParam", "selrow");
           var goodsReceivedNoteUpdatePo = $("#goodsReceivedNoteUpdatePo_grid").jqGrid("getRowData", selectedRowID);
           if (selectedRowID === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var goodsReceivedNoteUpdatePo = $("#goodsReceivedNoteUpdatePo_grid").jqGrid("getRowData", selectedRowID);
            var url="inventory/goods-received-note-authority";
            var params="&actionAuthority=UPDATE";
            
            if(goodsReceivedNoteUpdatePo.confirmationStatus === "CONFIRMED"){
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
                
                var url = "inventory/goods-received-note-update-po-input";
                var params = "goodsReceivedNoteUpdatePo.code=" + goodsReceivedNoteUpdatePo.code;
                pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_UPDATE_PO"); 
            });
        });
        
        
        $('#btnGoodsReceivedNoteUpdatePoRefresh').click(function(ev) {
            var url = "inventory/goods-received-note";
            var params = "";
            pageLoad(url, params, "#tabmnuGOODS_RECEIVED_NOTE_UPDATE_PO");
        });
        
        $('#btnGoodsReceivedNoteUpdatePo_search').click(function(ev) {
            formatDateGRNUpdatePo();
            $("#goodsReceivedNoteUpdatePoItemDetail_grid").jqGrid("clearGridData");
            $("#goodsReceivedNoteUpdatePoItemDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE ITEM DETAIL");
            $("#goodsReceivedNoteUpdatePo_grid").jqGrid("clearGridData");
            $("#goodsReceivedNoteUpdatePo_grid").jqGrid("setGridParam",{url:"goods-received-note-update-po-data?" + $("#frmGoodsReceivedNoteUpdatePoSearchInput").serialize()});
            $("#goodsReceivedNoteUpdatePo_grid").trigger("reloadGrid");
            formatDateGRNUpdatePo();
        });
    });
        
    function reloadGridGoodsReceivedNoteUpdatePoUpdatePo() {
        $("#goodsReceivedNoteUpdatePo_grid").trigger("reloadGrid");
    };
    
    function reloadGridDetailGoodsReceivedNoteUpdatePoUpdatePo() {
        $("#goodsReceivedNoteUpdatePoItemDetail_grid").jqGrid("clearGridData");
        $("#goodsReceivedNoteUpdatePoItemDetail_grid").jqGrid("setCaption", "GOODS RECEIVED NOTE BY PURCHASE ORDER DETAIL");
    };
           
    function formatDateGRNUpdatePo(){
        var firstDate=$("#goodsReceivedNoteUpdatePo\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#goodsReceivedNoteUpdatePo\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#goodsReceivedNoteUpdatePo\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#goodsReceivedNoteUpdatePo\\.transactionLastDate").val(lastDateValue);
    }
        
       
</script>

<s:url id="remoteurlGoodsReceivedNoteUpdatePo" action="goods-received-note-update-po-data" />

<b>GOODS RECEIVED NOTE UPDATE PO</b>
<hr>   

<br class="spacer" />
<br class="spacer" />

<div id="goodsReceivedNoteUpdatePoInputSearch" class="content ui-widget">
    <s:form id="frmGoodsReceivedNoteUpdatePoSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="goodsReceivedNoteUpdatePo.transactionFirstDate" name="goodsReceivedNoteUpdatePo.transactionFirstDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="goodsReceivedNoteUpdatePo.transactionLastDate" name="goodsReceivedNoteUpdatePo.transactionLastDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right" valign="middle">GRN No</td>
                <td>
                    <s:textfield id="goodsReceivedNoteUpdatePo.code" placeHolder="GRN No" name="goodsReceivedNoteUpdatePo.code" size="25"></s:textfield>
                </td>
                <td align="right">Vendor</td>
                <td>
                    <s:textfield id="goodsReceivedNoteUpdatePo.vendorCode" placeHolder=" Code" name="goodsReceivedNoteUpdatePo.vendorCode" size="15"></s:textfield>
                    <s:textfield id="goodsReceivedNoteUpdatePo.vendorName" placeHolder=" Name" name="goodsReceivedNoteUpdatePo.vendorName" size="25"></s:textfield>
                </td>
                <td align="right" valign="middle">Ref No</td>
                <td>
                    <s:textfield id="goodsReceivedNoteUpdatePo.refNo" placeHolder="Ref No" name="goodsReceivedNoteUpdatePo.refNo" size="25"></s:textfield>
                </td> 
            </tr>
            <tr>
                <td align="right" valign="middle">POD No</td>
                <td>
                    <s:textfield id="goodsReceivedNoteUpdatePo.purchaseOrderCode" placeHolder="PO No" name="goodsReceivedNoteUpdatePo.purchaseOrderCode" size="25"></s:textfield>
                </td> 
                <td align="right" valign="middle">Warehouse</td>
                <td>
                    <s:textfield id="goodsReceivedNoteUpdatePo.warehouseCode" placeHolder=" Code" name="goodsReceivedNoteUpdatePo.warehouseCode" size="15"></s:textfield>
                    <s:textfield id="goodsReceivedNoteUpdatePo.warehouseName" placeHolder=" Name" name="goodsReceivedNoteUpdatePo.warehouseName" size="25"></s:textfield>
                </td> 
                <td align="right" valign="middle">Remark</td>
                <td>
                    <s:textfield id="goodsReceivedNoteUpdatePo.remark" placeHolder="Remark" name="goodsReceivedNoteUpdatePo.remark" size="25"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGoodsReceivedNoteUpdatePo_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
                     
    <!-- GRID HEADER -->    
<div id="goodsReceivedNoteUpdatePoGrid">
    <sjg:grid
        id="goodsReceivedNoteUpdatePo_grid"
        caption="GOODS RECEIVED NOTE"
        dataType="json"
        href="%{remoteurlGoodsReceivedNoteUpdatePo}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGoodsReceivedNoteUpdatePo"
        rowList="10,20,50"
        rowNum="10"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="goodsReceivedNoteUpdatePo_onSelect"
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
            <sj:a href="#" id="btnGoodsReceivedNoteUpdatePoUpdate" button="true">Update</sj:a></td>
        <td/>                            
        </tr>
    </table>
</div>
<br class="spacer" />

<div id="goodsReceivedNoteUpdatePoItemDetailGrid">
    <sjg:grid
        id="goodsReceivedNoteUpdatePoItemDetail_grid"
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
        <sjg:gridColumn
            name="rackCode" index="rackCode" key="rackCode" title="Rack Code" width="150" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="rackName" index="rackName" key="rackName" title="Rack Name" width="200" sortable="true" hidden="true"
        />
    </sjg:grid >
</div>