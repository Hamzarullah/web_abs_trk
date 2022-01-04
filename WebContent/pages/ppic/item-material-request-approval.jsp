
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #itemMaterialRequestApprovalBillOfMaterialApproval_grid_pager_center,#itemMaterialRequestApprovalPpoDetailApproval_grid_pager_center,
    #itemMaterialRequestApprovalProcessedPartApproval_grid_pager_center,#itemMaterialRequestApprovalItemMaterialBookingApproval_grid_pager_center,
    #itemMaterialRequestApprovalBookingPartApprovalDetail_grid_pager_center,#itemMaterialRequestApprovalRequestApprovalDetail_grid_pager_center,
    #itemMaterialRequestApprovalPartApprovalDetail_grid_pager_center{
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
        
        $('#itemMaterialRequestSearchApprovalStatusRadPENDING').prop('checked',true);
            $("#itemMaterialRequestApproval\\.approvalStatus").val("PENDING");

        $('input[name="itemMaterialRequestSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#itemMaterialRequestApproval\\.approvalStatus").val("PENDING");
        });

        $('input[name="itemMaterialRequestSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#itemMaterialRequestApproval\\.approvalStatus").val("APPROVED");
        });

        $('input[name="itemMaterialRequestSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#itemMaterialRequestApproval\\.approvalStatus").val("REJECTED");
        });

        $('input[name="itemMaterialRequestSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#itemMaterialRequestApproval\\.approvalStatus").val("");
        });
        
        $.subscribe("itemMaterialRequestApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#itemMaterialRequestApproval_grid").jqGrid("getGridParam", "selrow"); 
            var imrApproval = $("#itemMaterialRequestApproval_grid").jqGrid("getRowData", selectedRowID);
           
            $("#itemMaterialRequestApprovalPpoDetailApproval_grid").jqGrid("setGridParam",{url:"ppic/production-planning-order-detail-data-imr?productionPlanningOrder.code="+imrApproval.productionPlanningOrderCode+"&productionPlanningOrder.documentType="+imrApproval.documentType});
            $("#itemMaterialRequestApprovalPpoDetailApproval_grid").jqGrid("setCaption", "PRODUCTION PLANNING ORDER DETAIL");
            $("#itemMaterialRequestApprovalPpoDetailApproval_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestApprovalBillOfMaterialApproval_grid").jqGrid("setGridParam",{url:"engineering/bill-of-material-for-imr?docDetailCode="+imrApproval.productionPlanningOrderCode});
            $("#itemMaterialRequestApprovalBillOfMaterialApproval_grid").jqGrid("setCaption", "PRODUCTION PLANNING ORDER DETAIL");
            $("#itemMaterialRequestApprovalBillOfMaterialApproval_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestApprovalProcessedPartApproval_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-processed-part-data?itemMaterialRequest.code="+imrApproval.code});
            $("#itemMaterialRequestApprovalProcessedPartApproval_grid").jqGrid("setCaption", "PROCESSED PART");
            $("#itemMaterialRequestApprovalProcessedPartApproval_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestApprovalItemMaterialBookingApproval_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-booking-detail?itemMaterialRequest.code="+imrApproval.code});
            $("#itemMaterialRequestApprovalItemMaterialBookingApproval_grid").jqGrid("setCaption", "ITEM MATERIAL BOOKING");
            $("#itemMaterialRequestApprovalItemMaterialBookingApproval_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestApprovalBookingPartApprovalDetail_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-booking-part-detail?itemMaterialRequest.code="+imrApproval.code});
            $("#itemMaterialRequestApprovalBookingPartApprovalDetail_grid").jqGrid("setCaption", "");
            $("#itemMaterialRequestApprovalBookingPartApprovalDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestApprovalRequestApprovalDetail_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-request-detail?itemMaterialRequest.code="+imrApproval.code});
            $("#itemMaterialRequestApprovalRequestApprovalDetail_grid").jqGrid("setCaption", "ITEM MATERIAL REQUEST DETAIL");
            $("#itemMaterialRequestApprovalRequestApprovalDetail_grid").trigger("reloadGrid");
            
            $("#itemMaterialRequestApprovalPartApprovalDetail_grid").jqGrid("setGridParam",{url:"ppic/item-material-request-request-part-detail?itemMaterialRequest.code="+imrApproval.code});
            $("#itemMaterialRequestApprovalPartApprovalDetail_grid").jqGrid("setCaption", "");
            $("#itemMaterialRequestApprovalPartApprovalDetail_grid").trigger("reloadGrid");
            
        });
        
       $('#btnItemMaterialRequestApproval').click(function(ev) {
            
            var selectedRowID = $("#itemMaterialRequestApproval_grid").jqGrid("getGridParam", "selrow");
            var itemMaterialRequestApproval = $("#itemMaterialRequestApproval_grid").jqGrid('getRowData', selectedRowID);

            if(selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            
            if(itemMaterialRequestApproval.approvalStatus === 'APPROVED'){
                alertMessage("It's already approved");
                return;
            }
            
            var url = "ppic/item-material-request-approval-input";
            var params = "itemMaterialRequestApproval.code=" + itemMaterialRequestApproval.code;
            pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST_APPROVAL"); 
        });
        
        $("#btnItemMaterialRequestApprovalRefresh").click(function (ev) {
            var url = "ppic/item-material-request-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuITEM_MATERIAL_REQUEST_APPROVAL");
            ev.preventDefault();
        });
        
        $('#btnItemMaterialRequestApproval_search').click(function(ev) {
            formatDateIMRApproval();
            $("#itemMaterialRequestApprovalPpoDetailApproval_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApprovalBillOfMaterialApproval_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApprovalProcessedPartApproval_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApprovalItemMaterialBookingApproval_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApprovalBookingPartApprovalDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApprovalRequestApprovalDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApprovalPartApprovalDetail_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApproval_grid").jqGrid("clearGridData");
            $("#itemMaterialRequestApproval_grid").jqGrid("setGridParam",{url:"item-material-request-approval-data?" + $("#frmItemMaterialRequestApprovalSearchInput").serialize()});
            $("#itemMaterialRequestApproval_grid").trigger("reloadGrid");
            formatDateIMRApproval();
            ev.preventDefault();
        });
    });
    
    function formatDateIMRApproval(){
        var firstDate=$("#itemMaterialRequestApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#itemMaterialRequestApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#itemMaterialRequestApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#itemMaterialRequestApproval\\.transactionLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlItemMaterialRequestApproval" action="item-material-request-approval-data" />    
    <b>ITEM MATERIAL REQUEST</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="ItemMaterialRequestButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnItemMaterialRequestApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>  
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="ItemMaterialRequestApprovalInputSearch" class="content ui-widget">
        <s:form id="frmItemMaterialRequestApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="itemMaterialRequestApproval.transactionFirstDate" name="itemMaterialRequestApproval.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="itemMaterialRequestApproval.transactionLastDate" name="itemMaterialRequestApproval.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">IMR No</td>
                    <td>
                        <s:textfield id="itemMaterialRequestApproval.code" name="itemMaterialRequestApproval.code" size="25"></s:textfield>
                    </td>
                    <td align="right">PPO No</td>
                    <td>
                        <s:textfield id="itemMaterialRequestApproval.productionPlanningOrder.code" name="itemMaterialRequestApproval.productionPlanningOrder.code" size="25"></s:textfield>
                    </td>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="itemMaterialRequestApproval.customerCode" name="itemMaterialRequestApproval.customerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="itemMaterialRequestApproval.customerName" name="itemMaterialRequestApproval.customerName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="itemMaterialRequestApproval.remark" name="itemMaterialRequestApproval.remark" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="itemMaterialRequestApproval.refNo" name="itemMaterialRequestApproval.refNo" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="itemMaterialRequestSearchApprovalStatusRad" name="itemMaterialRequestSearchApprovalStatusRad" label="itemMaterialRequestSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="itemMaterialRequestApproval.approvalStatus" name="itemMaterialRequestApproval.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnItemMaterialRequestApproval_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
    <div>
        <sjg:grid
            id="itemMaterialRequestApproval_grid"
            caption="Item Material Request"
            dataType="json"   
            href="%{remoteurlItemMaterialRequestApproval}"
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
            width="$('#tabmnuItemMaterialRequestApproval').width()"
            onSelectRowTopics="itemMaterialRequestApproval_grid_onSelect"
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
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" 
                title="Approval Status" width="150" sortable="true"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    <div>
        <sj:a href="#" id="btnItemMaterialRequestApproval" button="true" style="width: 90px">Approval</sj:a>
    </div>
    <br class="spacer" />
                  
    <div>
        <sjg:grid
            id="itemMaterialRequestApprovalPpoDetailApproval_grid"
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
            id="itemMaterialRequestApprovalBillOfMaterialApproval_grid"
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
            id="itemMaterialRequestApprovalProcessedPartApproval_grid"
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
                                    id="itemMaterialRequestApprovalItemMaterialBookingApproval_grid"
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
            id="itemMaterialRequestApprovalBookingPartApprovalDetail_grid"
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
                        id="itemMaterialRequestApprovalRequestApprovalDetail_grid"
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
            id="itemMaterialRequestApprovalPartApprovalDetail_grid"
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
    

