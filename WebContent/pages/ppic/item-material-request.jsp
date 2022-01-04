
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #itemMaterialRequestBillOfMaterial_grid_pager_center,#itemMaterialRequestPpoDetail_grid_pager_center,
    #itemMaterialRequestProcessedPart_grid_pager_center,#itemMaterialRequestItemMaterialBooking_grid_pager_center,
    #itemMaterialRequestBookingPartDetail_grid_pager_center,#itemMaterialRequesttRequestDetail_grid_pager_center,
    #itemMaterialRequestPartDetail_grid_pager_center{
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
        
        $.subscribe("itemMaterialRequest_grid_onSelect", function(event, data){
            var selectedRowID = $("#itemMaterialRequest_grid").jqGrid("getGridParam", "selrow"); 
            var imrProductionPlanning = $("#itemMaterialRequest_grid").jqGrid("getRowData", selectedRowID);
            
            $("#itemMaterialRequestPpoDetail_grid").jqGrid("setGridParam",{url:"ppic/production-planning-order-detail-data-imr?productionPlanningOrder.code="+imrProductionPlanning.productionPlanningOrderCode+"&productionPlanningOrder.documentType="+imrProductionPlanning.documentType});
            $("#itemMaterialRequestPpoDetail_grid").jqGrid("setCaption", "PRODUCTION PLANNING ORDER DETAIL");
            $("#itemMaterialRequestPpoDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestBillOfMaterial_grid").jqGrid("setGridParam",{url:"engineering/bill-of-material-for-imr?docDetailCode="+imrProductionPlanning.productionPlanningOrderCode});
            $("#itemMaterialRequestBillOfMaterial_grid").jqGrid("setCaption", "PRODUCTION PLANNING ORDER DETAIL");
            $("#itemMaterialRequestBillOfMaterial_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestProcessedPart_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-processed-part-data?itemMaterialRequest.code="+imrProductionPlanning.code});
            $("#itemMaterialRequestProcessedPart_grid").jqGrid("setCaption", "PROCESSED PART");
            $("#itemMaterialRequestProcessedPart_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestItemMaterialBooking_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-booking-detail?itemMaterialRequest.code="+imrProductionPlanning.code});
            $("#itemMaterialRequestItemMaterialBooking_grid").jqGrid("setCaption", "ITEM MATERIAL BOOKING");
            $("#itemMaterialRequestItemMaterialBooking_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestBookingPartDetail_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-booking-part-detail?itemMaterialRequest.code="+imrProductionPlanning.code});
            $("#itemMaterialRequestBookingPartDetail_grid").jqGrid("setCaption", "");
            $("#itemMaterialRequestBookingPartDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequesttRequestDetail_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-request-detail?itemMaterialRequest.code="+imrProductionPlanning.code});
            $("#itemMaterialRequesttRequestDetail_grid").jqGrid("setCaption", "ITEM MATERIAL REQUEST DETAIL");
            $("#itemMaterialRequesttRequestDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestPartDetail_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-request-part-detail?itemMaterialRequest.code="+imrProductionPlanning.code});
            $("#itemMaterialRequestPartDetail_grid").jqGrid("setCaption", "");
            $("#itemMaterialRequestPartDetail_grid").trigger("reloadGrid");
            
        });
        
       $('#btnItemMaterialRequestNew').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "ppic/item-material-request-input";
                var params = "enumItemMaterialRequestActivity=NEW";

                pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST");

            });
                    
        }); 
        
        $("#btnItemMaterialRequestRefresh").click(function (ev) {
            var url = "ppic/item-material-request";
            var params = "";
            pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST");
            ev.preventDefault();
        });
        
        $("#btnItemMaterialRequestDelete").click(function(){
            var deleteRowId = $("#itemMaterialRequest_grid").jqGrid('getGridParam','selrow');
            var itemMaterialRequest = $("#itemMaterialRequest_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>PCO No: '+itemMaterialRequest.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title : "Message",
                closeOnEscape: false,
                modal : true,
                width: 300,
                resizable: false,
                buttons : 
                    [{
                        text : "Yes",
                        click : function() {
                            var url = "ppic/item-material-request-delete";
                            var params = "itemMaterialRequest.code=" + itemMaterialRequest.code;
                            $.post(url, params, function(data) {
                                if (data.error) {
                                    alertMessage(data.errorMessage);
                                    return;
                                }
                                $("#itemMaterialRequestPpoDetail_grid").trigger("reloadGrid");
                                $("#itemMaterialRequestBillOfMaterial_grid").trigger("reloadGrid");
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
        
        $('#btnItemMaterialRequest_search').click(function(ev) {
            formatDateIMR();
            $("#itemMaterialRequest_grid").jqGrid("clearGridData");
            $("#itemMaterialRequest_grid").jqGrid("setGridParam",{url:"item-material-request-data?" + $("#frmItemMaterialRequestSearchInput").serialize()});
            $("#itemMaterialRequest_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestPpoDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestPpoDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestBillOfMaterial_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestBillOfMaterial_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestProcessedPart_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestProcessedPart_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestItemMaterialBooking_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestItemMaterialBooking_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestBookingPartDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestBookingPartDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequesttRequestDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequesttRequestDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestPartDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestPartDetail_grid").trigger("reloadGrid");
            formatDateIMR();
            ev.preventDefault();
        });
    });
    
    function formatDateIMR(){
        var firstDate=$("#itemMaterialRequest\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#itemMaterialRequest\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#itemMaterialRequest\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#itemMaterialRequest\\.transactionLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlItemMaterialRequest" action="item-material-request-data" />    
    <b>ITEM MATERIAL REQUEST</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="ItemMaterialRequestButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnItemMaterialRequestNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
        <a href="#" id="btnItemMaterialRequestUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
        <a href="#" id="btnItemMaterialRequestDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
        <a href="#" id="btnItemMaterialRequestRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>        
        <a href="#" id="btnItemMaterialRequestPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="ItemMaterialRequestInputSearch" class="content ui-widget">
        <s:form id="frmItemMaterialRequestSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="itemMaterialRequest.transactionFirstDate" name="itemMaterialRequest.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="itemMaterialRequest.transactionLastDate" name="itemMaterialRequest.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">IMR No</td>
                    <td>
                        <s:textfield id="itemMaterialRequest.code" name="itemMaterialRequest.code" size="25"></s:textfield>
                    </td>
                    <td align="right">PPO No</td>
                    <td>
                        <s:textfield id="itemMaterialRequest.productionPlanningOrder.code" name="itemMaterialRequest.productionPlanningOrder.code" size="25"></s:textfield>
                    </td>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="itemMaterialRequest.customerCode" name="itemMaterialRequest.customerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="itemMaterialRequest.customerName" name="itemMaterialRequest.customerName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="itemMaterialRequest.remark" name="itemMaterialRequest.remark" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="itemMaterialRequest.refNo" name="itemMaterialRequest.refNo" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnItemMaterialRequest_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
    <div>
        <sjg:grid
            id="itemMaterialRequest_grid"
            caption="Item Material Request"
            dataType="json"   
            href="%{remoteurlItemMaterialRequest}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listItemMaterialRequest"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuItemMaterialRequest').width()"
            onSelectRowTopics="itemMaterialRequest_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" 
                title="IMR No" width="160" sortable="true" 
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="productionPlanningOrderCode" index="productionPlanningOrderCode" 
                title="PPO No" width="160" sortable="true"
            />
            <sjg:gridColumn
                name="documentType" index="documentType" 
                title="Doc Type" width="80" sortable="true"
            />
            <sjg:gridColumn
                name="documentNo" index="documentNo" 
                title="Doc No" width="160" sortable="true"
            />
            <sjg:gridColumn
                name="ppoDate" index="ppoDate" key="ppoDate" 
                title="PPO Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" 
                title="Customer Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" 
                title="Customer Name" width="280" sortable="true"
            />
            <sjg:gridColumn
                name="targetDate" index="targetDate" key="targetDate" 
                title="Target Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" 
                title="Ref No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" 
                title="Remark" width="150" sortable="true"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
                  
    <div>
        <sjg:grid
            id="itemMaterialRequestPpoDetail_grid"
            caption="PPO Detail"
            dataType="json"   
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listProductionPlanningOrderItemDetail"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucustomerpurchaseOrder').width()"
        >
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" 
                title="Document Detail Code" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" 
                title="IFG Code" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name = "itemFinishGoodsRemark" id="itemFinishGoodsRemark" index = "itemFinishGoodsRemark" key = "itemFinishGoodsRemark" title = "IFG REMARK" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "valveTag" index = "valveTag" 
                title = "Valve Tag" width = "135" sortable="true" 
            />
            <sjg:gridColumn
                name="itemBodyConstructionCode" index="itemBodyConstructionCode" key="itemBodyConstructionCode" title="Body Construction Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyConstructionName" index="itemBodyConstructionName" key="itemBodyConstructionName" title="Body Construction Name" width="150" sortable = "true"
            />
            <!--02-->
            <sjg:gridColumn
                name="itemTypeDesignCode" index="itemTypeDesignCode" key="itemTypeDesignCode" title="Type Design Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemTypeDesignName" index="itemTypeDesignName" key="itemTypeDesignName" title="Type Design" width="150" sortable = "true"
            />
            <!--03-->
            <sjg:gridColumn
                name="itemSeatDesignCode" index="itemSeatDesignCode" key="itemSeatDesignCode" title="Seat Design Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatDesignName" index="itemSeatDesignName" key="itemSeatDesignName" title="Seat Design" width="150" sortable = "true"
            />
            <!--04-->
            <sjg:gridColumn
                name="itemSizeCode" index="itemSizeCode" key="itemSizeCode" title="Size Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSizeName" index="itemSizeName" key="itemSizeName" title="Size" width="150" sortable = "true"
            />
            <!--05-->
            <sjg:gridColumn
                name="itemRatingCode" index="itemRatingCode" key="itemRatingCode" title="Rating Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemRatingName" index="itemRatingName" key="itemRatingName" title="Rating" width="150" sortable = "true"
            />
            <!--06-->
            <sjg:gridColumn
                name="itemBoreCode" index="itemBoreCode" key="itemBoreCode" title="Bore Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoreName" index="itemBoreName" key="itemBoreName" title="Bore" width="150" sortable = "true"
            />
            <!--07-->
            <sjg:gridColumn
                name="itemEndConCode" index="itemEndConCode" key="itemEndConCode" title="End Con Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemEndConName" index="itemEndConName" key="itemEndConName" title="End Con" width="150" sortable = "true"
            />
            <!--08-->
            <sjg:gridColumn
                name="itemBodyCode" index="itemBodyCode" key="itemBodyCode" title="Body Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyName" index="itemBodyName" key="itemBodyName" title="Body" width="150" sortable = "true"
            />
            <!--09-->
            <sjg:gridColumn
                name="itemBallCode" index="itemBallCode" key="itemBallCode" title="Ball Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBallName" index="itemBallName" key="itemBallName" title="Ball" width="150" sortable = "true"
            />
            <!--10-->
            <sjg:gridColumn
                name="itemSeatCode" index="itemSeatCode" key="itemSeatCode" title="Seat Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatName" index="itemSeatName" key="itemSeatName" title="Seat" width="150" sortable = "true"
            />
            <!--11-->
            <sjg:gridColumn
                name="itemSeatInsertCode" index="itemSeatInsertCode" key="itemSeatInsertCode" title="Seat Insert Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatInsertName" index="itemSeatInsertName" key="itemSeatInsertName" title="Seat Insert" width="150" sortable = "true"
            />
            <!--12-->
            <sjg:gridColumn
                name="itemStemCode" index="itemStemCode" key="itemStemCode" title="Stem" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemStemName" index="itemStemName" key="itemStemName" title="Stem" width="150" sortable = "true"
            />
            <!--13-->
            <sjg:gridColumn
                name="itemSealCode" index="itemSealCode" key="itemSealCode" title="Seal" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSealName" index="itemSealName" key="itemSealName" title="Seal" width="150" sortable = "true"
            />
            <!--14-->
            <sjg:gridColumn
                name="itemBoltCode" index="itemBoltCode" key="itemBoltCode" title="Bolt" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoltName" index="itemBoltName" key="itemBoltName" title="Bolt" width="150" sortable = "true"
            />
            <!--15-->
            <sjg:gridColumn
                name="itemDiscCode" index="itemDiscCode" key="itemDiscCode" title="Disc" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemDiscName" index="itemDiscName" key="itemDiscName" title="Disc" width="150" sortable = "true"
            />
            <!--16-->
            <sjg:gridColumn
                name="itemPlatesCode" index="itemPlatesCode" key="itemPlatesCode" title="Plates" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemPlatesName" index="itemPlatesName" key="itemPlatesName" title="Plates" width="150" sortable = "true"
            />
            <!--17-->
            <sjg:gridColumn
                name="itemShaftCode" index="itemShaftCode" key="itemShaftCode" title="Shaft" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemShaftName" index="itemShaftName" key="itemShaftName" title="Shaft" width="150" sortable = "true"
            />
            <!--18-->
            <sjg:gridColumn
                name="itemSpringCode" index="itemSpringCode" key="itemSpringCode" title="Spring" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSpringName" index="itemSpringName" key="itemSpringName" title="Spring" width="150" sortable = "true"
            />
            <!--19-->
            <sjg:gridColumn
                name="itemArmPinCode" index="itemArmPinCode" key="itemArmPinCode" title="Arm Pin" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmPinName" index="itemArmPinName" key="itemArmPinName" title="Arm Pin" width="150" sortable = "true"
            />
            <!--20-->
            <sjg:gridColumn
                name="itemBackSeatCode" index="itemBackSeatCode" key="itemBackSeatCode" title="Back Seat" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBackSeatName" index="itemBackSeatName" key="itemBackSeatName" title="Back Seat" width="150" sortable = "true"
            />
            <!--21-->
            <sjg:gridColumn
                name="itemArmCode" index="itemArmCode" key="itemArmCode" title="Arm" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmName" index="itemArmName" key="itemArmName" title="Arm" width="150" sortable = "true"
            />
            <!--22-->
            <sjg:gridColumn
                name="itemHingePinCode" index="itemHingePinCode" key="itemHingePinCode" title="Hinge Pin" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemHingePinName" index="itemHingePinName" key="itemHingePinName" title="Hinge Pin" width="150" sortable = "true"
            />
            <!--23-->
            <sjg:gridColumn
                name="itemStopPinCode" index="itemStopPinCode" key="itemStopPinCode" title="Stop Pin" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemStopPinName" index="itemStopPinName" key="itemStopPinName" title="Stop Pin" width="150" sortable = "true"
            />
            <!--24-->
            <sjg:gridColumn
                name="itemOperatorCode" index="itemOperatorCode" key="itemOperatorCode" title="Operator" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemOperatorName" index="itemOperatorName" key="itemOperatorName" title="Operator" width="150" sortable = "true"
            />
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" 
                title="PPO Quantity" width="150" sortable="true" formatter="number"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
        <sjg:grid
            id="itemMaterialRequestBillOfMaterial_grid"
            caption="Bill Of Material"
            dataType="json"     
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialPartDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#id-tbl-additional-payment-item-delivery').width()"
        >
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" 
                title="Document Detail Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" 
                title="IFG Code" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name = "itemFinishGoodsRemark" id="itemFinishGoodsRemark" index = "itemFinishGoodsRemark" key = "itemFinishGoodsRemark" title = "IFG REMARK" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "itemPPONo" id="itemPPONo" index ="itemPPONo" key = "itemPPONo" title = "Item Ppo No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "imrNo" id="imrNo" index = "imrNo" key = "imrNo" title = "IMR No" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name="imrDate" index="imrDate" key="imrDate" 
                title="IMR Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  sortable="true" 
            />
            <sjg:gridColumn
                name = "partNo" id="partNo" index = "partNo" key = "partNo" title = "Part No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partCode" id="partCode" index = "partCode" key = "partCode" title = "Part Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "partName" id="partName" index = "partName" key = "partName" title = "Part Name" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "drawingCode" id="drawingCode" index = "drawingCode" key = "drawingCode" title = "Drawing Code/Standard" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "dimension" id="dimension" index = "dimension" key = "dimension" title = "Dimension" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "requiredLength" id="requiredLength" index = "requiredLength" key = "requiredLength" title = "Required Length" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "material" id="material" index = "material" key = "material" title = "Material" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "quantity" id="quantity" index = "quantity" key = "quantity" title = "Quantity/BOM" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "requirement" id="requirement" index = "requirement" key = "requirement" title = "Requirement" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "processedStatus" id="processedStatus" index = "processedStatus" key = "processedStatus" title = "Process Status" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "x" id="x" index = "x" key = "x" title = "X" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "revNo" id="revNo" index = "revNo" key = "revNo" title = "revNo" width = "150" sortable = "true"
                formatter="number"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
        <div>
        <sjg:grid
            id="itemMaterialRequestProcessedPart_grid"
            caption="Processed Part"
            dataType="json"     
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listItemMaterialRequestItemProcessedPartDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#id-tbl-additional-payment-item-delivery').width()"
        >
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" 
                title="Document Detail Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" 
                title="IFG Code" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name = "itemFinishGoodsRemark" id="itemFinishGoodsRemark" index = "itemFinishGoodsRemark" key = "itemFinishGoodsRemark" title = "IFG REMARK" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "itemProductionPlanningOrderNo" id="itemProductionPlanningOrderNo" index ="itemProductionPlanningOrderNo" key = "itemProductionPlanningOrderNo" title = "Item Ppo No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partNo" id="partNo" index = "partNo" key = "partNo" title = "Part No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partCode" id="partCode" index = "partCode" key = "partCode" title = "Part Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "partName" id="partName" index = "partName" key = "partName" title = "Part Name" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "drawingCode" id="drawingCode" index = "drawingCode" key = "drawingCode" title = "Drawing Code/Standard" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "dimension" id="dimension" index = "dimension" key = "dimension" title = "Dimension" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "requiredLength" id="requiredLength" index = "requiredLength" key = "requiredLength" title = "Required Length" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "material" id="material" index = "material" key = "material" title = "Material" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "quantityBom" id="quantityBom" index = "quantityBom" key = "quantityBom" title = "Quantity/BOM" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "requirement" id="requirement" index = "requirement" key = "requirement" title = "Requirement" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "processedStatus" id="processedStatus" index = "processedStatus" key = "processedStatus" title = "Process Status" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "x" id="x" index = "x" key = "x" title = "X" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "revNo" id="revNo" index = "revNo" key = "revNo" title = "revNo" width = "150" sortable = "true"
                formatter="number"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <div>
        <table width="100%">
            <tr>
                <td width="200px">
                    <table>
                        <tr height="10px"><td></td></tr>
                        <tr>
                            <td colspan="2">
                                <sjg:grid
                                    id="itemMaterialRequestItemMaterialBooking_grid"
                                    caption="Item Material Booking"
                                    dataType="json"                    
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
                                    navigatorRefresh="false"
                                    navigatorDelete="false"
                                    navigatorAdd="false"
                                    navigatorEdit="false"
                                    gridModel="listItemMaterialRequestItemBookingDetail"
                                    viewrecords="true"
                                    rownumbers="true"
                                    shrinkToFit="false"
                                    width="800"
                                >
                                    <sjg:gridColumn
                                        name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" 
                                        title="Item Material Code" width="150" sortable="true" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" 
                                        title="Item Material Name" width="150" sortable="true" editable="true"
                                    />
                                    <sjg:gridColumn
                                        name = "remark" index = "remark" key = "remark" 
                                        title = "Remark" width = "280" edittype="text" 
                                    />
                                    <sjg:gridColumn
                                        name = "bookingQuantity" index = "bookingQuantity" key = "bookingQuantity" 
                                        title = "Book Quantity" width = "80" edittype="text" formatter="number"
                                    />
                                    <sjg:gridColumn
                                        name = "uomCode" index = "uomCode" key = "uomCode" 
                                        title = "UOM" width = "80" edittype="text" 
                                    />
                                </sjg:grid >
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <sjg:grid
            id="itemMaterialRequestBookingPartDetail_grid"
            dataType="json"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listItemMaterialRequestItemBookingPartDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#id-tbl-additional-payment-item-delivery').width()"
        >
            <sjg:gridColumn
                name="itemMaterialRequestBookingDetailCode" index="itemMaterialRequestBookingDetailCode" key="itemMaterialRequestBookingDetailCode" 
                title="Item Material Code" width="150" sortable="true" editable="true"
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" 
                title="Item Material Name" width="150" sortable="true" editable="true"
            />
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" 
                title="Document Detail Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" 
                title="IFG Code" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name = "itemFinishGoodsRemark" id="itemFinishGoodsRemark" index = "itemFinishGoodsRemark" key = "itemFinishGoodsRemark" title = "IFG REMARK" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "itemProductionPlanningOrderNo" id="itemProductionPlanningOrderNo" index = "itemProductionPlanningOrderNo" key = "itemProductionPlanningOrderNo" title = "Item Ppo No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partNo" id="partNo" index = "partNo" key = "partNo" title = "Part No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partCode" id="partCode" index = "partCode" key = "partCode" title = "Part Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "partName" id="partName" index = "partName" key = "partName" title = "Part Name" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "drawingCode" id="drawingCode" index = "drawingCode" key = "drawingCode" title = "Drawing Code/Standard" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "dimension" id="dimension" index = "dimension" key = "dimension" title = "Dimension" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "requiredLength" id="requiredLength" index = "requiredLength" key = "requiredLength" title = "Required Length" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "material" id="material" index = "material" key = "material" title = "Material" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "quantityBom" id="quantityBom" index = "quantityBom" key = "quantityBom" title = "Quantity/BOM" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "requirement" id="requirement" index = "requirement" key = "requirement" title = "Requirement" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "processStatus" id="processStatus" index = "processStatus" key = "processStatus" title = "Process Status" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "x" id="" index = "x" key = "x" title = "X" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "revNo" id="revNo" index = "revNo" key = "revNo" title = "revNo" width = "150" sortable = "true"
            />
        </sjg:grid >
    </div>
    
    <br class="spacer" />
    <div>
        <table>
            <tr>
                <td width="200px" valign="top">
                    <sjg:grid
                        id="itemMaterialRequesttRequestDetail_grid"
                        caption="Item Material Request"
                        dataType="json"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listItemMaterialRequestItemRequestDetail"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        width="800"
                    >
                        <sjg:gridColumn
                            name="itemMaterialCode" index="itemMaterialCode" key="itemMaterialCode" 
                            title="Item Material Code" width="150" sortable="true" editable="true"
                        />
                        <sjg:gridColumn
                            name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" 
                            title="Item Material Name" width="150" sortable="true" editable="true"
                        />
                        <sjg:gridColumn
                            name = "remark" index = "remark" key = "remark" 
                            title = "Remark" width = "280" edittype="text" 
                        />
                        <sjg:gridColumn
                            name = "quantity" index = "quantity" key = "quantity" 
                            title = "PRQ Quantity" width = "80" edittype="text" formatter ="number"
                        />
                        <sjg:gridColumn
                            name = "uomCode" index = "uomCode" key = "uomCode" 
                            title = "Unit" width = "80" edittype="text" 
                        />
                    </sjg:grid >
                </td>       
           </tr>
        </table>
    </div>
    <div>
        <sjg:grid
            id="itemMaterialRequestPartDetail_grid"
            dataType="json"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listItemMaterialRequestItemRequestPartDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#id-tbl-additional-payment-item-delivery').width()"
        >
            <sjg:gridColumn
                name="itemMaterialRequestPurchaseRequestDetailCode" index="itemMaterialRequestPurchaseRequestDetailCode" key="itemMaterialRequestPurchaseRequestDetailCode" 
                title="Item Material Code" width="150" sortable="true" editable="true"
            />
            <sjg:gridColumn
                name="itemMaterialName" index="itemMaterialName" key="itemMaterialName" 
                title="Item Material Name" width="150" sortable="true" editable="true"
            />
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" 
                title="Document Detail Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" 
                title="IFG Code" width="160" sortable="true" edittype="text" 
            />
            <sjg:gridColumn
                name = "itemFinishGoodsRemark" id="itemFinishGoodsRemark" index = "itemFinishGoodsRemark" key = "itemFinishGoodsRemark" title = "IFG REMARK" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "itemProductionPlanningOrderNo" id="itemProductionPlanningOrderNo" index = "itemProductionPlanningOrderNo" key = "itemProductionPlanningOrderNo" title = "Item Ppo No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partNo" id="partNo" index = "partNo" key = "partNo" title = "Part No" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "partCode" id="partCode" index = "partCode" key = "partCode" title = "Part Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "partName" id="partName" index = "partName" key = "partName" title = "Part Name" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "drawingCode" id="drawingCode" index = "drawingCode" key = "drawingCode" title = "Drawing Code/Standard" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "dimension" id="dimension" index = "dimension" key = "dimension" title = "Dimension" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "requiredLength" id="requiredLength" index = "requiredLength" key = "requiredLength" title = "Required Length" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "material" id="material" index = "material" key = "material" title = "Material" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "quantityBom" id="quantityBom" index = "quantityBom" key = "quantityBom" title = "Quantity/BOM" width = "150" sortable = "true"
                formatter="number"
            />
            <sjg:gridColumn
                name = "requirement" id="requirement" index = "requirement" key = "requirement" title = "Requirement" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "processStatus" id="processStatus" index = "processStatus" key = "processStatus" title = "Process Status" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "x" id="" index = "x" key = "x" title = "X" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "revNo" id="revNo" index = "revNo" key = "revNo" title = "revNo" width = "150" sortable = "true"
            />
        </sjg:grid >
    </div>
                            
    
    <br class="spacer" />
    <br class="spacer" />
    

