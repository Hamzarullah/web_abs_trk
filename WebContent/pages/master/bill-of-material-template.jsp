

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("billOfMaterialTemplate_grid_onSelect", function(event, data){
            var selectedRowID = $("#billOfMaterialTemplate_grid").jqGrid("getGridParam", "selrow"); 
            var billOfMaterialTemplate = $("#billOfMaterialTemplate_grid").jqGrid("getRowData", selectedRowID);
            
            $("#billOfMaterialTemplateDetail_grid").jqGrid("setGridParam",{url:"master/bill-of-material-template-get-detail?headerCode="+billOfMaterialTemplate.code});
            $("#billOfMaterialTemplateDetail_grid").jqGrid("setCaption", "BILL OF MATERIAL DETAIL");
            $("#billOfMaterialTemplateDetail_grid").trigger("reloadGrid");
        });
        
        $("#btnBillOfMaterialTemplateNew").click(function (ev) {
           
            var url = "master/bill-of-material-template-input";
            var param = "";

            pageLoad(url, param, "#tabmnuBILL_OF_MATERIAL_TEMPLATE");
            ev.preventDefault();    
        });
        
        $("#btnBillOfMaterialTemplateUpdate").click(function (ev) {
            
            var deleteRowId = $("#billOfMaterialTemplate_grid").jqGrid('getGridParam','selrow');
            var billOfMaterialTemplate = $("#billOfMaterialTemplate_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
//            alert(billOfMaterialTemplate.code);
            var params = "billOfMaterialTemplateUpdateMode=true" + "&billOfMaterialTemplate.code=" + billOfMaterialTemplate.code;
            pageLoad("master/bill-of-material-template-input", params, "#tabmnuBILL_OF_MATERIAL_TEMPLATE"); 

            ev.preventDefault();
            
        });
        
        $("#btnBillOfMaterialTemplateDelete").click(function (ev) {
            
            var deleteRowId = $("#billOfMaterialTemplate_grid").jqGrid('getGridParam','selrow');
            var billOfMaterialTemplate = $("#billOfMaterialTemplate_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "master/bill-of-material-template-delete";
            var params = "billOfMaterialTemplate.code=" + billOfMaterialTemplate.code;
            
            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>BOM No: '+billOfMaterialTemplate.code+'<br/><br/>' +    
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
                                          $("#billOfMaterialTemplate_grid").trigger("reloadGrid");
                                          $("#billOfMaterialTemplateDetail_grid").trigger("reloadGrid");
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
        
       
       $("#btnBillOfMaterialTemplateCancel").click(function(ev) {
            hideInput("billOfMaterialTemplate");
            showInput("billOfMaterialTemplateSearch");
            allFieldsBillOfMaterialTemplate.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        $('#btnBillOfMaterialTemplateRefresh').click(function(ev) {
            $('#billOfMaterialTemplateSearchActiveStatusRadActive').prop('checked',true);
            $("#billOfMaterialTemplateSearchActiveStatus").val("true");
            $("#billOfMaterialTemplate_grid").jqGrid("clearGridData");
            $("#billOfMaterialTemplate_grid").jqGrid("setGridParam",{url:"master/bill-of-material-template-data?"});
            $("#billOfMaterialTemplate_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnBillOfMaterialTemplate_search').click(function(ev) {
            $("#billOfMaterialTemplate_grid").jqGrid("clearGridData");
            $("#billOfMaterialTemplate_grid").jqGrid("setGridParam",{url:"master/bill-of-material-template-data?" + $("#frmBillOfMaterialTemplateSearchInput").serialize()});
            $("#billOfMaterialTemplate_grid").trigger("reloadGrid");
            
            $("#billOfMaterialTemplateDetail_grid").jqGrid("clearGridData");
            ev.preventDefault();
        });
        
    });
    
    function reloadGridBillOfMaterialTemplate(){
        $("#billOfMaterialTemplate_grid").trigger("reloadGrid");
    };
    
    
</script>

<s:url id="remoteurlBillOfMaterialTemplate" action="bill-of-material-template-data" />
<b>BILL OF MATERIAL TEMPLATE</b>
<hr>
<br class="spacer" />
    <sj:div id="billOfMaterialTemplateButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
        <tr>
            <td><a href="#" id="btnBillOfMaterialTemplateNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnBillOfMaterialTemplateUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnBillOfMaterialTemplateDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td><a href="#" id="btnBillOfMaterialTemplateRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnBillOfMaterialTemplatePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print Out</a>
            </td>
        </tr>
        </table>
    </sj:div>
    <div id="billOfMaterialTemplateSearchInput" class="content ui-widget">
        <br class="spacer" />
        <br class="spacer" />
        <s:form id="frmBillOfMaterialTemplateSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" valign="centre"><b>Code</b></td>
                    <td>
                        <s:textfield id="billOfMaterialTemplate.code" name="billOfMaterialTemplate.code" size="20"></s:textfield>
                    </td>
                </tr>  
            </table>
            <br />
            <sj:a href="#" id="btnBillOfMaterialTemplate_search" button="true">Search</sj:a>
        </s:form>
    </div>
    <br class="spacer" />  
    
    <div id="billOfMaterialTemplateGrid">
        <sjg:grid
            id="billOfMaterialTemplate_grid"
            dataType="json"
            href="%{remoteurlBillOfMaterialTemplate}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialTemplate"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubillOfMaterialTemplate').width()"
            onSelectRowTopics="billOfMaterialTemplate_grid_onSelect"
        >
        <sjg:gridColumn
            name="code" index="code" title="code" width="150" sortable="true"
        />    
        <sjg:gridColumn
            name="itemFinishGoodsCode" index="itemFinishGoodsCode" title="Item FinishGoods Code" width="150" sortable="true"
        />    
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="100" sortable="true"
        />    
        <sjg:gridColumn
            name="valveTypeCode" index="valveTypeCode" title="ValveType Code" width="100" sortable="true"
        />   
        <sjg:gridColumn
            name="valveTypeName" index="valveTypeName" title="ValveTyp Name" width="100" sortable="true"
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
        </sjg:grid >
    </div>
    
    <br class="spacer" />  
    
    <div id="billOfMaterialTemplateDetailGrid">
        <sjg:grid
            id="billOfMaterialTemplateDetail_grid"
            dataType="json"
            href="%{remoteurlBillOfMaterialTemplateDetail}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialTemplateDetail"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubillOfMaterialTemplateDetail').width()"
        >
        <sjg:gridColumn
            name="code" index="code" title="code" width="150" sortable="true"
        />    
        <sjg:gridColumn
            name="sortNo" index="sortNo" title="Sort No" width="100" sortable="true"
        />    
        <sjg:gridColumn
            name="partNo" index="partNo" title="Part No" width="100" sortable="true"
        />    
        <sjg:gridColumn
            name="partCode" index="partCode" title="Part Code" width="100" sortable="true"
        />   
        <sjg:gridColumn
            name="partName" index="partName" title="Part Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="drawingCode" index="drawingCode" title="Drawing Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="dimension" index="dimension" title="Dimension" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="requiredLength" index="requiredLength" title="Required Length" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="material" index="material" title="Material" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="quantity" index="quantity" title="Quantity" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="requirement" index="requirement" title="Requirement" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="processedStatus" index="processedStatus" title="ProcessedStatus" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatusDetail" index="activeStatusDetail" title="Active Status" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="x" index="x" title="X" width="100" sortable="true"
        />
        </sjg:grid >
    </div>
  