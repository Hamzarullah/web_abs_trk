
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #internalMemoProductionDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
    $(document).ready(function(){
        
        $.subscribe("internalMemoProduction_grid_onSelect", function(event, data){
            var selectedRowID = $("#internalMemoProduction_grid").jqGrid("getGridParam", "selrow"); 
            var internalMemoProduction = $("#internalMemoProduction_grid").jqGrid("getRowData", selectedRowID);
            
            $("#internalMemoProductionDetail_grid").jqGrid("setGridParam",{url:"sales/internal-memo-production-detail-data?internalMemoProduction.code=" + internalMemoProduction.code});
            $("#internalMemoProductionDetail_grid").jqGrid("setCaption", "INTERNAL MEMO DETAIL : " + internalMemoProduction.code);
            $("#internalMemoProductionDetail_grid").trigger("reloadGrid");
        });
        
        
        $("#btnInternalMemoProductionNew").click(function (ev) {
           
            var url = "sales/internal-memo-production-input";
            var param = "";

            pageLoad(url, param, "#tabmnuINTERNAL_MEMO_PRODUCTION");
            ev.preventDefault();    
        });
        
        $('#btnInternalMemoProductionUpdate').click(function(ev) {

            var selectRowId = $("#internalMemoProduction_grid").jqGrid('getGridParam','selrow');
            var internalMemoProduction = $("#internalMemoProduction_grid").jqGrid("getRowData", selectRowId);           

            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "sales/internal-memo-production-input";

            var params = "internalMemoProductionUpdateMode=true"; 
                params+="&internalMemoProduction.code=" + internalMemoProduction.code;

            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION");
        });
        
        $('#btnInternalMemoProductionDelete').click(function(ev) {
            
            var deleteRowId = $("#internalMemoProduction_grid").jqGrid('getGridParam','selrow');
            var internalMemoProduction = $("#internalMemoProduction_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }

                var url = "sales/internal-memo-production-delete";
                var params = "internalMemoProduction.code=" + internalMemoProduction.code;

                var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Delete?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>SO No: '+salesOrder.code+'<br/><br/>' +    
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
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                searchAndRefreshSalesOrder(false);
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
        
         $('#btnInternalMemoProductionRefresh').click(function(ev) {
            $("#internalMemoProduction_grid").jqGrid("clearGridData");
            $("#internalMemoProduction_grid").jqGrid("setGridParam",{url:"sales/internal-memo-production-data?"});
            $("#internalMemoProduction_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnInternalMemoProduction_search').click(function(ev) {
             formatDateIM();
            $("#internalMemoProduction_grid").jqGrid("clearGridData");
            $("#internalMemoProduction_grid").jqGrid("setGridParam",{url:"sales/internal-memo-production-data?" + $("#frmInternalMemoProductionSearchInput").serialize()});
            $("#internalMemoProduction_grid").trigger("reloadGrid");
             formatDateIM();
        });
        
    });
    
    function formatDateIM(){
        var firstDate=$("#internalMemoProductionSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#internalMemoProductionSearchFirstDate").val(firstDateValue);

        var lastDate=$("#internalMemoProductionSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#internalMemoProductionSearchLastDate").val(lastDateValue);
    };
</script>
<s:url id="remoteurlInternalMemoProduction" action="internal-memo-production-json" />    
    <b>INTERNAL MEMO PRODUCTION</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="internalMemoProductionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnInternalMemoProductionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnInternalMemoProductionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnInternalMemoProductionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnInternalMemoProductionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnInternalMemoProductionPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="InternalMemoProductionInputSearch" class="content ui-widget">
        <s:form id="frmInternalMemoProductionSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="internalMemoProductionSearchFirstDate" name="internalMemoProductionSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="internalMemoProductionSearchLastDate" name="internalMemoProductionSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="internalMemoProductionSearchCode" name="internalMemoProductionSearchCode" size="25" placeHolder=" IM Code"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="internalMemoProductionCustomerSearchCode" name="internalMemoProductionCustomerSearchCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="internalMemoProductionCustomerSearchName" name="internalMemoProductionCustomerSearchName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnInternalMemoProduction_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="InternalMemoProductionGrid">
        <sjg:grid
            id="internalMemoProduction_grid"
            caption="INTERNAL MEMO PRODUCTION"
            dataType="json"
            href="%{remoteurlInternalMemoProduction}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listInternalMemoProductionTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuINTERNAL_MEMO_PRODUCTION').width()"
            onSelectRowTopics="internalMemoProduction_grid_onSelect"
        >
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
    <br class="spacer" />
    
    <div id="InternalMemoProductionDetailGrid">
        <sjg:grid
            id="internalMemoProductionDetail_grid"
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
            width="$('#tabmnuINTERNAL_MEMO_PRODUCTION').width()"
            
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
