
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
    #productionPlanningOrderDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        //RDB Search Document Type
         //RDB Approval Status
        $('#productionPlanningOrderSearchDocumentTypeRadALL').prop('checked',true);
            $("#productionPlanningOrder\\.documentType").val("");

        $('input[name="productionPlanningOrderSearchDocumentTypeRad"][value="SALES ORDER"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("SO");
        });

        $('input[name="productionPlanningOrderSearchDocumentTypeRad"][value="BLANKET ORDER"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("BO");
        });

        $('input[name="productionPlanningOrderSearchDocumentTypeRad"][value="INTERNAL MEMO"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("IM");
        });

        $('input[name="productionPlanningOrderSearchDocumentTypeRad"][value="ALL"]').change(function(ev){
            $("#productionPlanningOrder\\.documentType").val("");
        });
        
        $.subscribe("productionPlanningOrder_grid_onSelect", function(event, data){
            var selectedRowID = $("#productionPlanningOrder_grid").jqGrid("getGridParam", "selrow"); 
            var productionPlanningOrder = $("#productionPlanningOrder_grid").jqGrid("getRowData", selectedRowID);
            
            $("#productionPlanningOrderDetail_grid").jqGrid("setGridParam",{url:"ppic/production-planning-order-detail-data?productionPlanningOrder.code="+productionPlanningOrder.code+"&productionPlanningOrder.documentType="+productionPlanningOrder.documentType});
            $("#productionPlanningOrderDetail_grid").jqGrid("setCaption", "PRODUCTION PLANNING ORDER DETAIL");
            $("#productionPlanningOrderDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnProductionPlanningOrderNew").click(function (ev) {
           
            var url = "ppic/production-planning-order-input";
            var param = "";

            pageLoad(url, param, "#tabmnuPRODUCTION_PLANNING_ORDER");
            ev.preventDefault();    
        });
        
        $("#btnProductionPlanningOrderUpdate").click(function (ev) {
            
            var deleteRowId = $("#productionPlanningOrder_grid").jqGrid('getGridParam','selrow');
            var productionPlanningOrder = $("#productionPlanningOrder_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var params = "productionPlanningOrderUpdateMode=true" + "&productionPlanningOrder.code=" + productionPlanningOrder.code;
            pageLoad("ppic/production-planning-order-input", params, "#tabmnuPRODUCTION_PLANNING_ORDER"); 

            ev.preventDefault();
            
        });
        
        $("#btnProductionPlanningOrderDelete").click(function (ev) {
            
            var deleteRowId = $("#productionPlanningOrder_grid").jqGrid('getGridParam','selrow');
            var productionPlanningOrder = $("#productionPlanningOrder_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "ppic/production-planning-order-delete";
            var params = "productionPlanningOrder.code=" + productionPlanningOrder.code;
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PPO No: '+productionPlanningOrder.code+'<br/><br/>' +    
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
                                          $("#productionPlanningOrder_grid").trigger("reloadGrid");
                                          $("#productionPlanningOrderDetail_grid").trigger("reloadGrid");
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
        
        $("#btnProductionPlanningOrderRefresh").click(function (ev) {
            var url = "ppic/production-planning-order";
            var params = "";
            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER");
            ev.preventDefault();
        });
        
        $('#btnProductionPlanningOrder_search').click(function(ev) {
            formatDatePPO();
            $("#productionPlanningOrder_grid").jqGrid("clearGridData");
            $("#productionPlanningOrderDetail_grid").jqGrid("clearGridData");
            $("#productionPlanningOrder_grid").jqGrid("setGridParam",{url:"production-planning-order-data?" + $("#frmProductionPlanningOrderSearchInput").serialize()});
            $("#productionPlanningOrder_grid").trigger("reloadGrid");
            formatDatePPO();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDatePPO(){
        var firstDate=$("#productionPlanningOrder\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#productionPlanningOrder\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#productionPlanningOrder\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#productionPlanningOrder\\.transactionLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlProductionPlanningOrder" action="production-planning-order-data" />
    <b>PRODUCTION PLANNING ORDER</b>
    <hr>
    <br class="spacer" />
    <sj:div id="productionPlanningOrderButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnProductionPlanningOrderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnProductionPlanningOrderUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnProductionPlanningOrderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnProductionPlanningOrderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnProductionPlanningOrderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="productionPlanningOrderInputSearch" class="content ui-widget">
        <s:form id="frmProductionPlanningOrderSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td  align="right">PPO No</td>
                    <td>
                        <s:textfield id="productionPlanningOrder.code" name="productionPlanningOrder.code" size="27" placeholder=" PPO No"></s:textfield>
                    </td>
                    <td align="right">Customer Code</td>
                    <td>
                        <s:textfield id="productionPlanningOrder.customerCode" name="productionPlanningOrder.customerCode" size="25" placeholder=" Code"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="productionPlanningOrder.transactionFirstDate" name="productionPlanningOrder.transactionFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="productionPlanningOrder.transactionLastDate" name="productionPlanningOrder.transactionLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                    <td align="right">Customer Name</td>
                    <td>
                        <s:textfield id="productionPlanningOrder.customerName" name="productionPlanningOrder.customerName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="productionPlanningOrder.remark" name="productionPlanningOrder.remark" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="productionPlanningOrder.refNo" name="productionPlanningOrder.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Document Type</B></td>
                    <td>
                        <s:radio id="productionPlanningOrderSearchDocumentTypeRad" name="productionPlanningOrderSearchDocumentTypeRad" label="productionPlanningOrderSearchDocumentTypeRad" list="{'ALL','SALES ORDER','BLANKET ORDER','INTERNAL MEMO'}"></s:radio>
                        <s:textfield id="productionPlanningOrder.documentType" name="productionPlanningOrder.documentType" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnProductionPlanningOrder_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="productionPlanningOrderGrid">
        <sjg:grid
            id="productionPlanningOrder_grid"
            caption="PRODUCTION PLANNING ORDER"
            dataType="json"
            href="%{remoteurlProductionPlanningOrder}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listProductionPlanningOrder"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupporder').width()"
            onSelectRowTopics="productionPlanningOrder_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="PPO No" width="130"
            />
            <sjg:gridColumn
                name="documentType" index="documentType" key="documentType" title="Doc Type" width="80"
            />
            <sjg:gridColumn
                name="documentCode" index="documentCode" key="documentCode" title="Doc No" width="200"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="150"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" key="customerName" title="Customer Name" width="150"
            />
            <sjg:gridColumn
                name="targetDate" index="targetDate" key="targetDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Target Date" width="150" search="false" align="center"
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
    
    <div id="productionPlanningOrderDetailGrid">
        <sjg:grid
            id="productionPlanningOrderDetail_grid"
            caption="PRODUCTION PLANNING ORDER DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listProductionPlanningOrderItemDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#tabmnupporder').width()"
        > 
            <sjg:gridColumn
                name = "documentSortNo" index = "documentSortNo" key = "documentSortNo" title = "Sort No" formatter="number" width = "100" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name = "billOfMaterialCode" id="billOfMaterialCode" index = "billOfMaterialCode" key = "billOfMaterialCode" title = "Bom Code" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "itemFinishGoodsCode" id="itemFinishGoodsCode" index = "itemFinishGoodsCode" key = "itemFinishGoodsCode" title = "Item Finish Goods Code" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name="valveTag" index="valveTag" key="valveTag" title="Valve Tag" width="100"
            />
            <sjg:gridColumn
                name="dataSheet" index="dataSheet" key="dataSheet" title="Data Sheet" width="100"
            />
            <sjg:gridColumn
                name="description" index="description" key="description" title="Description" width="150"
            />
            <!--01-->
            <sjg:gridColumn
                name="itemBodyConstructionCode" index="itemBodyConstructionCode" key="itemBodyConstructionCode" title="Body Construction Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyConstructionName" index="itemBodyConstructionName" key="itemBodyConstructionName" title="Body Construction" width="150"
            />
            <!--02-->
            <sjg:gridColumn
                name="itemTypeDesignCode" index="itemTypeDesignCode" key="itemTypeDesignCode" title="Type Design Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemTypeDesignName" index="itemTypeDesignName" key="itemTypeDesignName" title="Type Design" width="150"
            />
            <!--03-->
            <sjg:gridColumn
                name="itemSeatDesignCode" index="itemSeatDesignCode" key="itemSeatDesignCode" title="Seat Design Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatDesignName" index="itemSeatDesignName" key="itemSeatDesignName" title="Seat Design" width="150"
            />
            <!--04-->
            <sjg:gridColumn
                name="itemSizeCode" index="itemSizeCode" key="itemSizeCode" title="Size Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemSizeName" index="itemSizeName" key="itemSizeName" title="Size" width="150"
            />
            <!--05-->
            <sjg:gridColumn
                name="itemRatingCode" index="itemRatingCode" key="itemRatingCode" title="Rating Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemRatingName" index="itemRatingName" key="itemRatingName" title="Rating" width="150"
            />
            <!--06-->
            <sjg:gridColumn
                name="itemBoreCode" index="itemBoreCode" key="itemBoreCode" title="Bore Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoreName" index="itemBoreName" key="itemBoreName" title="Bore" width="150"
            />
            <!--07-->
            <sjg:gridColumn
                name="itemEndConCode" index="itemEndConCode" key="itemEndConCode" title="End Con Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemEndConName" index="itemEndConName" key="itemEndConName" title="End Con" width="150"
            />
            <!--08-->
            <sjg:gridColumn
                name="itemBodyCode" index="itemBodyCode" key="itemBodyCode" title="Body Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyName" index="itemBodyName" key="itemBodyName" title="Body" width="150"
            />
            <!--09-->
            <sjg:gridColumn
                name="itemBallCode" index="itemBallCode" key="itemBallCode" title="Ball Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemBallName" index="itemBallName" key="itemBallName" title="Ball" width="150"
            />
            <!--10-->
            <sjg:gridColumn
                name="itemSeatCode" index="itemSeatCode" key="itemSeatCode" title="Seat Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatName" index="itemSeatName" key="itemSeatName" title="Seat" width="150"
            />
            <!--11-->
            <sjg:gridColumn
                name="itemSeatInsertCode" index="itemSeatInsertCode" key="itemSeatInsertCode" title="Seat Insert Code" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatInsertName" index="itemSeatInsertName" key="itemSeatInsertName" title="Seat Insert" width="150"
            />
            <!--12-->
            <sjg:gridColumn
                name="itemStemCode" index="itemStemCode" key="itemStemCode" title="Stem" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemStemName" index="itemStemName" key="itemStemName" title="Stem" width="150"
            />
            <!--13-->
            <sjg:gridColumn
                name="itemSealCode" index="itemSealCode" key="itemSealCode" title="Seal" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemSealName" index="itemSealName" key="itemSealName" title="Seal" width="150"
            />
            <!--14-->
            <sjg:gridColumn
                name="itemBoltCode" index="itemBoltCode" key="itemBoltCode" title="Bolt" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoltName" index="itemBoltName" key="itemBoltName" title="Bolt" width="150"
            />
            <!--15-->
            <sjg:gridColumn
                name="itemDiscCode" index="itemDiscCode" key="itemDiscCode" title="Disc" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemDiscName" index="itemDiscName" key="itemDiscName" title="Disc" width="150"
            />
            <!--16-->
            <sjg:gridColumn
                name="itemPlatesCode" index="itemPlatesCode" key="itemPlatesCode" title="Plates" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemPlatesName" index="itemPlatesName" key="itemPlatesName" title="Plates" width="150"
            />
            <!--17-->
            <sjg:gridColumn
                name="itemShaftCode" index="itemShaftCode" key="itemShaftCode" title="Shaft" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemShaftName" index="itemShaftName" key="itemShaftName" title="Shaft" width="150"
            />
            <!--18-->
            <sjg:gridColumn
                name="itemSpringCode" index="itemSpringCode" key="itemSpringCode" title="Spring" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemSpringName" index="itemSpringName" key="itemSpringName" title="Spring" width="150"
            />
            <!--19-->
            <sjg:gridColumn
                name="itemArmPinCode" index="itemArmPinCode" key="itemArmPinCode" title="Arm Pin" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmPinName" index="itemArmPinName" key="itemArmPinName" title="Arm Pin" width="150"
            />
            <!--20-->
            <sjg:gridColumn
                name="itemBackSeatCode" index="itemBackSeatCode" key="itemBackSeatCode" title="Back Seat" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemBackSeatName" index="itemBackSeatName" key="itemBackSeatName" title="Back Seat" width="150"
            />
            <!--21-->
            <sjg:gridColumn
                name="itemArmCode" index="itemArmCode" key="itemArmCode" title="Arm" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmName" index="itemArmName" key="itemArmName" title="Arm" width="150"
            />
            <!--22-->
            <sjg:gridColumn
                name="itemHingePinCode" index="itemHingePinCode" key="itemHingePinCode" title="Hinge Pin" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemHingePinName" index="itemHingePinName" key="itemHingePinName" title="Hinge Pin" width="150"
            />
            <!--23-->
            <sjg:gridColumn
                name="itemStopPinCode" index="itemStopPinCode" key="itemStopPinCode" title="Stop Pin" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemStopPinName" index="itemStopPinName" key="itemStopPinName" title="Stop Pin" width="150"
            />
            <!--24-->
            <sjg:gridColumn
                name="itemOperatorCode" index="itemOperatorCode" key="itemOperatorCode" title="Operator" width="150" hidden="true"
            />
            <sjg:gridColumn
                name="itemOperatorName" index="itemOperatorName" key="itemOperatorName" title="Operator" width="150"
            />
            
            <sjg:gridColumn
                name = "orderQuantity" index = "orderQuantity" key = "orderQuantity" title = "Order Quantity" formatter="number" width = "150" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name = "processedQty" index = "processedQty" key = "processedQty" title = "Processed Quantity" formatter="number" width = "150" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name = "balancedQty" index = "balancedQty" key = "balancedQty" title = "Balance Quantity" formatter="number" width = "150" sortable = "false" align="right"
            />
            <sjg:gridColumn
                name = "quantity" index = "quantity" key = "quantity" title = "PPO Quantity" formatter="number" width = "150" sortable = "false" align="right"
            />
        </sjg:grid >
    </div>
    
    

