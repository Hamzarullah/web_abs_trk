
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow: scroll;
        }
    </style>
    
    
<script type = "text/javascript">
       
    var search_itemFinishGood= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';   
    var id_itemFinishGood='<%= request.getParameter("idtype") %>'; 
    var iscustomer= '<%= request.getParameter("iscustomer") %>';
    var id_customer= '<%= request.getParameter("idcustomer") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgItemFinishGood_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_itemFinishGood_grid").jqGrid("getGridParam","selrow");
            
            internalMemoProductionDetailLastRowId=rowLast;
            
            if(selectedRowId === null){
                alertMsg("Please Select Row ItemFinishGood!");
                return;
            }

            var data_search_itemFinishGood = $("#dlgSearch_itemFinishGood_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemFinishGood=== "grid" ) {
                var ids = jQuery("#dlgSearch_itemFinishGood_grid").jqGrid('getDataIDs');
                    var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                    for(var i=0;i<ids.length;i++){
                        var exist = false;
                        var data = $("#dlgSearch_itemFinishGood_grid").jqGrid('getRowData',ids[i]);
                        if($("input:checkbox[id='jqg_dlgSearch_itemFinishGood_grid_"+ids[i]+"']").is(":checked")){
                            for(var j=0; j<idsOpener.length; j++){
                                var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
//                                if(data.code === dataExist.userBranchBranchCode){
//                                    exist = true;
//                                }
                            }
                                var defRow = {
                                    internalMemoProductionDetailDelete                            :"delete",
                                    internalMemoProductionDetailItemFinishGoodsCode               : data.code,
                                    internalMemoProductionDetailItemFinishGoodsRemark             : data.remark,
                                    internalMemoProductionDetailDataSheet                         : data.itemDataSheet,
                                    internalMemoProductionDetailTypeDesign                        : data.itemTypeDesignName,
                                    internalMemoProductionDetailSeatDesign                        : data.itemSeatDesignName,
                                    internalMemoProductionDetailSize                              : data.itemSizeName,
                                    internalMemoProductionDetailRating                            : data.itemRatingName,
                                    internalMemoProductionDetailBore                              : data.itemBoreName,
                                    internalMemoProductionDetailEndCon                            : data.itemEndConName,
                                    internalMemoProductionDetailBody                              : data.itemBodyName,
                                    internalMemoProductionDetailBall                              : data.itemBallName,
                                    internalMemoProductionDetailSeat                              : data.itemSeatName,
                                    internalMemoProductionDetailSeatInsert                        : data.itemSeatInsertName,
                                    internalMemoProductionDetailStem                              : data.itemStemName,
                                    internalMemoProductionDetailSeal                              : data.itemSealName,
                                    internalMemoProductionDetailBolting                           : data.itemBoltName,
                                    internalMemoProductionDetailDisc                              : data.itemDiscName,
                                    internalMemoProductionDetailPlates                            : data.itemPlatesName,
                                    internalMemoProductionDetailShaft                             : data.itemShaftName,
                                    internalMemoProductionDetailSpring                            : data.itemSpringName,
                                    internalMemoProductionDetailArmPin                            : data.itemArmPinName,
                                    internalMemoProductionDetailBackseat                          : data.itemBackseatName,
                                    internalMemoProductionDetailArm                               : data.itemArmName,
                                    internalMemoProductionDetailHingePin                          : data.itemHingePinName,
                                    internalMemoProductionDetailStopPin                           : data.itemStopPinName,
                                    internalMemoProductionDetailOperator                          : data.itemOperatorName
                                };

                                window.opener.addRowDataMultiSelected(internalMemoProductionDetailLastRowId,defRow);
                                internalMemoProductionDetailLastRowId++;
                                }
                            }
                        }else {
                            $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemFinishGood.code);
                            $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemFinishGood.name);
                        }
            window.close();
        });

        $("#dlgItemFinishGood_cancelButton").click(function(ev) { 
            data_search_itemFinishGood = null;
            window.close();
        });
    
        $("#btn_dlg_ItemFinishGoodSearch").click(function(ev) {
            $("#dlgSearch_itemFinishGood_grid").jqGrid("setGridParam",{url:"master/item-finish-goods-data-search?" + $("#frmItemFinishGoodSearch").serialize(), page:1});
            $("#dlgSearch_itemFinishGood_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#isItemFinishGoodsByCustomer").val(iscustomer);
        $("#itemFinishGoodsSearchCustomerCode").val(id_customer);
    });
    
    
    
    function alertMsg(txt_message){
        var dynamicDialog= $(
        '<div id="conformBoxError">'+
            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
            '</span>' +
        '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            resizable: false,
            closeText: "hide",
            buttons : 
            [{
                text : "OK",
                click : function() {
                    $(this).dialog("close");
                }
            }]
        });
    }
        
</script>
<body>


    <div class="ui-widget">
        <s:form id="frmItemFinishGoodSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="itemFinishGoodsSearchCode" name="itemFinishGoodsSearchCode" label="Code "></s:textfield>
                    <s:textfield id="itemFinishGoodsSearchCustomerCode" name="itemFinishGoodsSearchCustomerCode" size="50" cssStyle="display:none"></s:textfield>
                    <s:textfield id="" name="isItemFinishGoodsByCustomer" size="50" cssStyle="display:none"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="itemFinishGoodsSearchName" name="itemFinishGoodsSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ItemFinishGoodSearch" button="true">Search</sj:a></td>
            </tr>
            <td align="right">
                <s:textfield id="itemFinishGoodsSearchActiveStatus" name="itemFinishGoodsSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
            </td>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_itemFinishGood_grid"
            dataType="json"
            href="%{remoteurlItemFinishGoodSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listItemFinishGoodsTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            multiselect = "true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuitemFinishGood').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" title="Remark" width="350" sortable="true"
            />
            <sjg:gridColumn
                name="valveTypeCode" index="valveTypeCode" title="Valve Type Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="valveTypeName" index="valveTypeName" title="Valve Type Name" width="100" sortable="true"
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
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgItemFinishGood_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgItemFinishGood_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


