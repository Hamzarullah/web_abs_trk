
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
    #productionPlanningOrderApprovalDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        //RDB Approval Status
        $('#productionPlanningOrderApprovalSearchApprovalStatusRadPENDING').prop('checked',true);
            $("#productionPlanningOrderApprovalSearchApprovalStatus").val("PENDING");

        $('input[name="productionPlanningOrderApprovalSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#productionPlanningOrderApprovalSearchApprovalStatus").val("PENDING");
        });

        $('input[name="productionPlanningOrderApprovalSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#productionPlanningOrderApprovalSearchApprovalStatus").val("APPROVED");
        });

        $('input[name="productionPlanningOrderApprovalSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#productionPlanningOrderApprovalSearchApprovalStatus").val("REJECTED");
        });

        $('input[name="productionPlanningOrderApprovalSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#productionPlanningOrderApprovalSearchApprovalStatus").val("");
        });
        
        $.subscribe("productionPlanningOrderApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#productionPlanningOrderApproval_grid").jqGrid("getGridParam", "selrow"); 
            var productionPlanningOrderApproval = $("#productionPlanningOrderApproval_grid").jqGrid("getRowData", selectedRowID);
            
            $("#productionPlanningOrderApprovalDetail_grid").jqGrid("setGridParam",{url:"ppic/production-planning-order-approval-detail-data?productionPlanningOrderApproval.code="+productionPlanningOrderApproval.code+"&productionPlanningOrderApproval.documentType="+productionPlanningOrderApproval.documentType});
            $("#productionPlanningOrderApprovalDetail_grid").jqGrid("setCaption", "PRODUCTION PLANNING ORDER APPROVAL DETAIL");
            $("#productionPlanningOrderApprovalDetail_grid").trigger("reloadGrid");
            
        });
        
        $("#btnProductionPlanningOrderApprovalApproved").click(function (ev) {
            
            var selectedRowID = $("#productionPlanningOrderApproval_grid").jqGrid("getGridParam", "selrow");
            var productionPlanningOrderApproval = $("#productionPlanningOrderApproval_grid").jqGrid('getRowData', selectedRowID);

            if(selectedRowID===null){
                alertMessage("Please Select Row!");
                return;
            }
            
            if(productionPlanningOrderApproval.approvalStatus === 'APPROVED'){
                alertMessage("It's already approved");
                return;
            }
            var url = "ppic/production-planning-order-approval-input";
            var params = "productionPlanningOrderApprovalUpdateMode=true" + "&productionPlanningOrderApproval.code=" + productionPlanningOrderApproval.code;
            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER_APPROVAL"); 
                    
            ev.preventDefault();    
        });
        
        $("#btnProductionPlanningOrderApprovalApprovalRefresh").click(function (ev) {
            var url = "ppic/production-planning-order-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuPRODUCTION_PLANNING_ORDER_APPROVAL");
            ev.preventDefault();
        });
        
        $('#btnProductionPlanningOrderApprovalApproval_search').click(function(ev) {
            formatDateApprovalPPO();
            $("#productionPlanningOrderApprovalDetail_grid").jqGrid("clearGridData");
            $("#productionPlanningOrderApproval_grid").jqGrid("clearGridData");
            $("#productionPlanningOrderApproval_grid").jqGrid("setGridParam",{url:"production-planning-order-approval-data?" + $("#frmProductionPlanningOrderApprovalApprovalSearchInput").serialize()});
            $("#productionPlanningOrderApproval_grid").trigger("reloadGrid");
            formatDateApprovalPPO();
            ev.preventDefault();
        });
    
    }); //EOF READY
    
    function formatDateApprovalPPO(){
        var firstDate=$("#productionPlanningOrderApprovalSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#productionPlanningOrderApprovalSearchFirstDate").val(firstDateValue);

        var lastDate=$("#productionPlanningOrderApprovalSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#productionPlanningOrderApprovalSearchLastDate").val(lastDateValue);
    }
    
</script>

<s:url id="remoteurlProductionPlanningOrderApprovalApproval" action="production-planning-order-approval-data" />
    <b>PRODUCTION PLANNING ORDER APPROVAL</b>
    <hr>
    <br class="spacer" />
    <sj:div id="productionPlanningOrderApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td> <a href="#" id="btnProductionPlanningOrderApprovalApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
            </tr>     
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="productionPlanningOrderApprovalInputSearch" class="content ui-widget">
        <s:form id="frmProductionPlanningOrderApprovalApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td  align="right">PPO No</td>
                    <td>
                        <s:textfield id="productionPlanningOrderApprovalSearchCode" name="productionPlanningOrderApprovalSearchCode" size="25" placeholder=" PPO No"></s:textfield>
                    </td>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="productionPlanningOrderApprovalSearchRemark" name="productionPlanningOrderApprovalSearchRemark" size="25" placeholder=" Remark"></s:textfield>
                    </td>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="productionPlanningOrderApprovalSearchRefNo" name="productionPlanningOrderApprovalSearchRefNo" size="25" placeholder=" Ref No"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Period</td>
                    <td>
                        <sj:datepicker id="productionPlanningOrderApprovalSearchFirstDate" name="productionPlanningOrderApprovalSearchFirstDate" size="11" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To *</B>
                        <sj:datepicker id="productionPlanningOrderApprovalSearchLastDate" name="productionPlanningOrderApprovalSearchLastDate" size="11" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                    <!--<td width="10"/>-->
                    <td align="right">Customer Code</td>
                    <td>
                        <s:textfield id="productionPlanningOrderApprovalSearchCustomerCode" name="productionPlanningOrderApprovalSearchCustomerCode" size="25" placeholder=" Code"></s:textfield>
                    </td>
                    <td align="right">Customer Name</td>
                    <td>
                        <s:textfield id="productionPlanningOrderApprovalSearchCustomerName" name="productionPlanningOrderApprovalSearchCustomerName" size="25" placeholder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="productionPlanningOrderApprovalSearchApprovalStatusRad" name="productionPlanningOrderApprovalSearchApprovalStatusRad" label="productionPlanningOrderApprovalSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="productionPlanningOrderApprovalSearchApprovalStatus" name="productionPlanningOrderApprovalSearchApprovalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnProductionPlanningOrderApprovalApproval_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
    <br />
                  
    <!-- GRID HEADER -->    
    <div id="productionPlanningOrderApprovalGrid">
        <sjg:grid
            id="productionPlanningOrderApproval_grid"
            caption="PRODUCTION PLANNING ORDER"
            dataType="json"
            href="%{remoteurlProductionPlanningOrderApprovalApproval}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listProductionPlanningOrderApproval"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupporder').width()"
            onSelectRowTopics="productionPlanningOrderApproval_grid_onSelect"
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
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="approvalStatus" width="150"
            />
        </sjg:grid >
    </div>
    
    <br class="spacer" />
    <div>
        <sj:a href="#" id="btnProductionPlanningOrderApprovalApproved" button="true" style="width: 90px">Approval</sj:a>
    </div>
    <br class="spacer" />
    
    <div id="productionPlanningOrderApprovalDetailGrid">
        <sjg:grid
            id="productionPlanningOrderApprovalDetail_grid"
            caption="PRODUCTION PLANNING ORDER APPROVAL DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listProductionPlanningOrderApprovalItemDetail"
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
    
    

