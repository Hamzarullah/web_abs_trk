
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #internalMemoProductionApprovalDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
    $(document).ready(function(){
        
        $('#internalMemoProductionApprovalSearchlStatusRadPENDING').prop('checked',true);
            $("#internalMemoProductionApprovalStatus").val("PENDING");
            
        $('input[name="internalMemoProductionApprovalSearchlStatusRad"][value="PENDING"]').change(function(ev){
            $("#internalMemoProductionApprovalStatus").val("PENDING");
        });
        
        $('input[name="internalMemoProductionApprovalSearchlStatusRad"][value="APPROVED"]').change(function(ev){
            $("#internalMemoProductionApprovalStatus").val("APPROVED");
        });
        
        $('input[name="internalMemoProductionApprovalSearchlStatusRad"][value="REJECTED"]').change(function(ev){
            $("#internalMemoProductionApprovalStatus").val("REJECTED");
        });
        
        $('input[name="internalMemoProductionApprovalSearchlStatusRad"][value="ALL"]').change(function(ev){
            $("#internalMemoProductionApprovalStatus").val("");
        });
        
        $.subscribe("internalMemoProductionApproval_grid_onSelect", function(event, data){
            var selectedRowID = $("#internalMemoProductionApproval_grid").jqGrid("getGridParam", "selrow"); 
            var internalMemoProductionApproval = $("#internalMemoProductionApproval_grid").jqGrid("getRowData", selectedRowID);
            
            $("#internalMemoProductionApprovalDetail_grid").jqGrid("setGridParam",{url:"engineering/internal-memo-production-detail-data?internalMemoProduction.code=" + internalMemoProductionApproval.code});
            $("#internalMemoProductionApprovalDetail_grid").jqGrid("setCaption", "INTERNAL MEMO DETAIL : " + internalMemoProductionApproval.code);
            $("#internalMemoProductionApprovalDetail_grid").trigger("reloadGrid");
        });
        
        
        $('#btnInternalMemoProductionApproval').click(function(ev) {

            var selectRowId = $("#internalMemoProductionApproval_grid").jqGrid('getGridParam','selrow');
            var internalMemoProductionApproval = $("#internalMemoProductionApproval_grid").jqGrid("getRowData", selectRowId);           

            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if (internalMemoProductionApproval.approvalStatus !== "PENDING"){
                alertMessage("Internal Memo Has been " +internalMemoProductionApproval.approvalStatus );
                return;
            }
            
            var url = "engineering/internal-memo-production-approval-input";

            var params ="internalMemoProductionApproval.code=" + internalMemoProductionApproval.code;

            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION_APPROVAL");
        });
        
         $('#btnInternalMemoProductionApprovalRefresh').click(function(ev) {
            $("#internalMemoProductionApproval_grid").jqGrid("clearGridData");
            $("#internalMemoProductionApproval_grid").jqGrid("setGridParam",{url:"engineering/internal-memo-production-approval-data?"});
            $("#internalMemoProductionApproval_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnInternalMemoProductionApproval_search').click(function(ev) {
             formatDateIMApproval();
            $("#internalMemoProductionApproval_grid").jqGrid("clearGridData");
            $("#internalMemoProductionApproval_grid").jqGrid("setGridParam",{url:"engineering/internal-memo-production-approval-data?" + $("#frmInternalMemoProductionApprovalSearchInput").serialize()});
            $("#internalMemoProductionApproval_grid").trigger("reloadGrid");
             formatDateIMApproval();
        });
        
    });
    
    function formatDateIMApproval(){
        var firstDate=$("#internalMemoProductionApprovalSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#internalMemoProductionApprovalSearchFirstDate").val(firstDateValue);

        var lastDate=$("#internalMemoProductionApprovalSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#internalMemoProductionApprovalSearchLastDate").val(lastDateValue);
    };
</script>
<s:url id="remoteurlInternalMemoProductionApproval" action="internal-memo-production-approval-data" />    
    <b>INTERNAL MEMO PRODUCTION APPROVAL</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="internalMemoProductionApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td> <a href="#" id="btnInternalMemoProductionApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnInternalMemoProductionApprovalPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="InternalMemoProductionApprovalInputSearch" class="content ui-widget">
        <s:form id="frmInternalMemoProductionApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period </b></td>
                    <td>
                        <sj:datepicker id="internalMemoProductionApprovalSearchFirstDate" name="internalMemoProductionApprovalSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="internalMemoProductionApprovalSearchLastDate" name="internalMemoProductionApprovalSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="internalMemoProductionApprovalSearchCode" name="internalMemoProductionApprovalSearchCode" size="25" placeHolder=" IM Code"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="internalMemoProductionApprovalCustomerSearchCode" name="internalMemoProductionApprovalCustomerSearchCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="internalMemoProductionApprovalCustomerSearchName" name="internalMemoProductionApprovalCustomerSearchName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                     <td align="right"><B>Approval Status</B></td>
                    <td>
                        <s:radio id="internalMemoProductionApprovalSearchlStatusRad" name="internalMemoProductionApprovalSearchlStatusRad" label="internalMemoProductionApprovalSearchlStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="internalMemoProductionApprovalStatus" name="internalMemoProductionApprovalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnInternalMemoProductionApproval_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="InternalMemoProductionApprovalGrid">
        <sjg:grid
            id="internalMemoProductionApproval_grid"
            caption="INTERNAL MEMO PRODUCTION APPROVAL"
            dataType="json"
            href="%{remoteurlInternalMemoProductionApproval}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoProductionApprovalTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuinternalmemoproductionapproval').width()"
            onSelectRowTopics="internalMemoProductionApproval_grid_onSelect"
        >
       <sjg:gridColumn
            name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval Status" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="code" index="code" key="code" title="IM- No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="130" formatter="date"  
            formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s' }"  sortable="true" 
        />
       <sjg:gridColumn
            name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="customerName" index="customerName" key="customerName" title="Customer Name" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="salesPersonCode" index="salesPersonCode" key="salesPersonCode" title="Sales Person Code" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="salesPersonName" index="salesPersonName" key="salesPersonName" title="Sales Person Name" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true" 
        />
       
        </sjg:grid >
    </div>
    
    <br class="spacer" />
        <div>
            <sj:a href="#" id="btnInternalMemoProductionApproval" button="true" style="width: 90px">Approval</sj:a>
        </div>
    <br class="spacer" />
    
    <div id="InternalMemoProductionApprovalDetailGrid">
        <sjg:grid
            id="internalMemoProductionApprovalDetail_grid"
            caption="INTERNAL MEMO PRODUCTION DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoProductionDetailTemp"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuINTERNAL_MEMO_PRODUCTION_APPROVAL').width()"
            
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="120" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="itemFinishGoodsCode" index="itemFinishGoodsCode" key="itemFinishGoodsCode" title="Item Finsih Goods Code" width="120" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="itemFinishGoodsRemark" index="itemFinishGoodsRemark" key="itemFinishGoodsRemark" title="Item Finsih Goods Remark" width="100" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="valveTag" index="valveTag" key="valveTag" title="Valve Tag" width="85" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="dataSheet" index="dataSheet" key="dataSheet" title="Data Sheet" width="85" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="description" index="description" key="description" title="Description" width="85" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="itemBodyConstructionCode" index="itemBodyConstructionCode" title="Body Construction" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemBodyConstructionName" index="itemBodyConstructionName" title="Body Construction" width="100" sortable="true"
        />
        <!--Type Design 02-->
        <sjg:gridColumn
            name="itemTypeDesignCode" index="itemTypeDesignCode" title="Type Design" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemTypeDesignName" index="itemTypeDesignName" title="Type Design" width="100" sortable="true"
        />
        <!--Seat Design 03-->
        <sjg:gridColumn
            name="itemSeatDesignCode" index="itemSeatDesignCode" title="Seat Design" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemSeatDesignName" index="itemSeatDesignName" title="Seat Design" width="100" sortable="true"
        />
        <!--Size 04-->
        <sjg:gridColumn
            name="itemSizeCode" index="itemSizeCode" title="Size" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemSizeName" index="itemSizeName" title="Size" width="100" sortable="true"
        />
        <!--Rating 05-->
        <sjg:gridColumn
            name="itemRatingCode" index="itemRatingCode" title="Rating Code" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemRatingName" index="itemRatingName" title="Rating" width="100" sortable="true"
        />
        <!--Bore 06-->
        <sjg:gridColumn
            name="itemBoreCode" index="itemBoreCode" title="Bore Code" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemBoreName" index="itemBoreName" title="Bore" width="100" sortable="true"
        />
        <!--Endcon 07-->
        <sjg:gridColumn
            name="itemEndConCode" index="itemEndConCode" title="END Code" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemEndConName" index="itemEndConName" title="Endcon" width="100" sortable="true"
        />
        <!--Body 08-->
        <sjg:gridColumn
            name="itemBodyCode" index="itemBodyCode" title="Body" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemBodyName" index="itemBodyName" title="Body" width="100" sortable="true"
        />
        <!--Ball 09-->
        <sjg:gridColumn
            name="itemBallCode" index="itemBallCode" title="Ball" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemBallName" index="itemBallName" title="Ball" width="100" sortable="true"
        />
        <!--Seat 10-->
        <sjg:gridColumn
            name="itemSeatCode" index="itemSeatCode" title="Seat" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemSeatName" index="itemSeatName" title="Seat" width="100" sortable="true"
        />
        <!--SeatInsert 11-->
        <sjg:gridColumn
            name="itemSeatInsertCode" index="itemSeatInsertCode" title="SeatInsert" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemSeatInsertName" index="itemSeatInsertName" title="Seat Insert" width="100" sortable="true"
        />
        <!--Stem 12-->
        <sjg:gridColumn
            name="itemStemCode" index="itemStemCode" title="Stem" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemStemName" index="itemStemName" title="Stem" width="100" sortable="true"
        />
        <!--Seal 13-->
        <sjg:gridColumn
            name="itemSealCode" index="itemSealCode" title="Seal" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemSealName" index="itemSealName" title="Seal" width="100" sortable="true"
        />
        <!--Bolt 14-->
        <sjg:gridColumn
            name="itemBoltCode" index="itemBoltCode" title="Bolt" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemBoltName" index="itemBoltName" title="Bolt" width="100" sortable="true"
        />
        <!--Disc 15-->
        <sjg:gridColumn
            name="itemDiscCode" index="itemDiscCode" title="Disc" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemDiscName" index="itemDiscName" title="Disc" width="100" sortable="true"
        />
        <!--Plates 16-->
        <sjg:gridColumn
            name="itemPlatesCode" index="itemPlatesCode" title="Plates" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemPlatesName" index="itemPlatesName" title="Plates" width="100" sortable="true"
        />
        <!--Shaft 17-->
        <sjg:gridColumn
            name="itemShaftCode" index="itemShaftCode" title="Shaft" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemShaftName" index="itemShaftName" title="Shaft" width="100" sortable="true"
        />
        <!--Spring 18-->
        <sjg:gridColumn
            name="itemSpringCode" index="itemSpringCode" title="Spring" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemSpringName" index="itemSpringName" title="Spring" width="100" sortable="true"
        />
        <!--Arm Pin 19-->
        <sjg:gridColumn
            name="itemArmPinCode" index="itemArmPinCode" title="ArmPin" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemArmPinName" index="itemArmPinName" title="ArmPin" width="100" sortable="true"
        />
        <!--Back Seat 20-->
        <sjg:gridColumn
            name="itemBackseatCode" index="itemBackseatCode" title="BackSeat" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemBackseatName" index="itemBackseatName" title="BackSeat" width="100" sortable="true"
        />
        <!--Arm 21-->
        <sjg:gridColumn
            name="itemArmCode" index="itemArmCode" title="Arm" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemArmName" index="itemArmName" title="Arm" width="100" sortable="true"
        />
        <!--Hinge Pin 22-->
        <sjg:gridColumn
            name="itemHingePinCode" index="itemHingePinCode" title="HingePin" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemHingePinName" index="itemHingePinName" title="HingePin" width="100" sortable="true"
        />
        <!--Stop Pin 23-->
        <sjg:gridColumn
            name="itemStopPinCode" index="itemStopPinCode" title="StopPin" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemStopPinName" index="itemStopPinName" title="StopPin" width="100" sortable="true"
        />
        <!--Operator 99-->
        <sjg:gridColumn
            name="itemOperatorCode" index="itemOperatorCode" title="Operator" width="100" sortable="true"
            hidden="true"
        />
        <sjg:gridColumn
            name="itemOperatorName" index="itemOperatorName" title="Operator" width="100" sortable="true"
        />
        <sjg:gridColumn
            name = "quantity" index = "quantity" key = "quantity" title = " Quantity" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        </sjg:grid >
    </div>
    <br class="spacer" />
