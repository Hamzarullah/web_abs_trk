
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
       
    var search_itemFinishGoods= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';   
    var id_itemFinishGoods='<%= request.getParameter("idtype") %>'; 
    var iscustomer= '<%= request.getParameter("iscustomer") %>';
    var id_customerEndUser= '<%= request.getParameter("idcustomer") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgItemFinishGoods_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_itemFinishGoods_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row ItemFinishGoods!");
                return;
            }

            var data_search_itemFinishGoods = $("#dlgSearch_itemFinishGoods_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemFinishGoods=== "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                    switch(id_document){
                        case "internalMemoProductionDetail":
                            if(data_search_itemFinishGoods.code === dataOpener.internalMemoProductionDetailItemFinishGoodsCode){
                                alertMsg("ItemFinishGoods Code "+data_search_itemFinishGoods.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break; 
                    }
                }
                $("#"+selectedRowID+"_"+id_document+"ItemFinishGoodsCode",opener.document).val(data_search_itemFinishGoods.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsCode", data_search_itemFinishGoods.code);  
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsRemark", data_search_itemFinishGoods.remark);
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBodyConstCode", data_search_itemFinishGoods.itemBodyConstructionCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBodyConstName", data_search_itemFinishGoods.itemBodyConstructionName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsTypeDesignCode", data_search_itemFinishGoods.itemTypeDesignCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsTypeDesignName", data_search_itemFinishGoods.itemTypeDesignName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSeatDesignCode", data_search_itemFinishGoods.itemSeatDesignCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSeatDesignName", data_search_itemFinishGoods.itemSeatDesignName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSizeCode", data_search_itemFinishGoods.itemSizeCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSizeName", data_search_itemFinishGoods.itemSizeName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsRatingCode", data_search_itemFinishGoods.itemRatingCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsRatingName", data_search_itemFinishGoods.itemRatingName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBoreCode", data_search_itemFinishGoods.itemBoreCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBoreName", data_search_itemFinishGoods.itemBoreName);
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsEndConCode", data_search_itemFinishGoods.itemEndConCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsEndConName", data_search_itemFinishGoods.itemEndConName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBodyCode", data_search_itemFinishGoods.itemBodyCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBodyName", data_search_itemFinishGoods.itemBodyName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBallCode", data_search_itemFinishGoods.itemBallCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBallName", data_search_itemFinishGoods.itemBallName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSeatCode", data_search_itemFinishGoods.itemSeatCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSeatName", data_search_itemFinishGoods.itemSeatName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSeatInsertCode", data_search_itemFinishGoods.itemSeatInsertCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSeatInsertName", data_search_itemFinishGoods.itemSeatInsertName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsStemCode", data_search_itemFinishGoods.itemStemCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsStemName", data_search_itemFinishGoods.itemStemName);
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSealCode", data_search_itemFinishGoods.itemSealCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSealName", data_search_itemFinishGoods.itemSealName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBoltCode", data_search_itemFinishGoods.itemBoltCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBoltName", data_search_itemFinishGoods.itemBoltName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsDiscCode", data_search_itemFinishGoods.itemDiscCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsDiscName", data_search_itemFinishGoods.itemDiscName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsPlatesCode", data_search_itemFinishGoods.itemPlatesCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsPlatesName", data_search_itemFinishGoods.itemPlatesName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsShaftCode", data_search_itemFinishGoods.itemShaftCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsShaftName", data_search_itemFinishGoods.itemShaftName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSpringCode", data_search_itemFinishGoods.itemSpringCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsSpringName", data_search_itemFinishGoods.itemSpringName);
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsArmPinCode", data_search_itemFinishGoods.itemArmPinCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsArmPinName", data_search_itemFinishGoods.itemArmPinName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBackSeatCode", data_search_itemFinishGoods.itemBackseatCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsBackSeatName", data_search_itemFinishGoods.itemBackseatName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsArmCode", data_search_itemFinishGoods.itemArmCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsArmName", data_search_itemFinishGoods.itemArmName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsHingePinCode", data_search_itemFinishGoods.itemHingePinCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsHingePinName", data_search_itemFinishGoods.itemHingePinName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsStopPinCode", data_search_itemFinishGoods.itemStopPinCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsStopPinName", data_search_itemFinishGoods.itemStopPinName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsOperatorCode", data_search_itemFinishGoods.itemOperatorCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemFinishGoodsOperatorName", data_search_itemFinishGoods.itemOperatorName);
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemFinishGoods.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemFinishGoods.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.endUserCode",opener.document).val(data_search_itemFinishGoods.endUserCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.endUserName",opener.document).val(data_search_itemFinishGoods.endUserName);
                $("#"+id_document+"\\."+id_subdoc+"\\.valveTypeCode",opener.document).val(data_search_itemFinishGoods.valveTypeCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.valveTypeName",opener.document).val(data_search_itemFinishGoods.valveTypeName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBodyConstructionCode",opener.document).val(data_search_itemFinishGoods.itemBodyConstructionCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBodyConstructionName",opener.document).val(data_search_itemFinishGoods.itemBodyConstructionName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemTypeDesignCode",opener.document).val(data_search_itemFinishGoods.itemTypeDesignCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemTypeDesignName",opener.document).val(data_search_itemFinishGoods.itemTypeDesignName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSeatDesignCode",opener.document).val(data_search_itemFinishGoods.itemSeatDesignCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSeatDesignName",opener.document).val(data_search_itemFinishGoods.itemSeatDesignName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSizeCode",opener.document).val(data_search_itemFinishGoods.itemSizeCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSizeName",opener.document).val(data_search_itemFinishGoods.itemSizeName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemRatingCode",opener.document).val(data_search_itemFinishGoods.itemRatingCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemRatingName",opener.document).val(data_search_itemFinishGoods.itemRatingName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBoreCode",opener.document).val(data_search_itemFinishGoods.itemBoreCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBoreName",opener.document).val(data_search_itemFinishGoods.itemBoreName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemEndConCode",opener.document).val(data_search_itemFinishGoods.itemEndConCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemEndConName",opener.document).val(data_search_itemFinishGoods.itemEndConName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBodyCode",opener.document).val(data_search_itemFinishGoods.itemBodyCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBodyName",opener.document).val(data_search_itemFinishGoods.itemBodyName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBallCode",opener.document).val(data_search_itemFinishGoods.itemBallCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBallName",opener.document).val(data_search_itemFinishGoods.itemBallName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSeatCode",opener.document).val(data_search_itemFinishGoods.itemSeatCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSeatName",opener.document).val(data_search_itemFinishGoods.itemSeatName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSeatInsertCode",opener.document).val(data_search_itemFinishGoods.itemSeatInsertCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSeatInsertName",opener.document).val(data_search_itemFinishGoods.itemSeatInsertName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemStemCode",opener.document).val(data_search_itemFinishGoods.itemStemCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemStemName",opener.document).val(data_search_itemFinishGoods.itemStemName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSealCode",opener.document).val(data_search_itemFinishGoods.itemSealCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSealName",opener.document).val(data_search_itemFinishGoods.itemSealName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBoltCode",opener.document).val(data_search_itemFinishGoods.itemBoltCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBoltName",opener.document).val(data_search_itemFinishGoods.itemBoltName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemDiscCode",opener.document).val(data_search_itemFinishGoods.itemDiscCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemDiscName",opener.document).val(data_search_itemFinishGoods.itemDiscName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemPlatesCode",opener.document).val(data_search_itemFinishGoods.itemPlatesCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemPlatesName",opener.document).val(data_search_itemFinishGoods.itemPlatesName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemShaftCode",opener.document).val(data_search_itemFinishGoods.itemShaftCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemShaftName",opener.document).val(data_search_itemFinishGoods.itemShaftName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSpringCode",opener.document).val(data_search_itemFinishGoods.itemSpringCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemSpringName",opener.document).val(data_search_itemFinishGoods.itemSpringName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemArmPinCode",opener.document).val(data_search_itemFinishGoods.itemArmPinCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemArmPinName",opener.document).val(data_search_itemFinishGoods.itemArmPinName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBackseatCode",opener.document).val(data_search_itemFinishGoods.itemBackseatCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemBackseatName",opener.document).val(data_search_itemFinishGoods.itemBackseatName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemArmCode",opener.document).val(data_search_itemFinishGoods.itemArmCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemArmName",opener.document).val(data_search_itemFinishGoods.itemArmName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemHingePinCode",opener.document).val(data_search_itemFinishGoods.itemHingePinCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemHingePinName",opener.document).val(data_search_itemFinishGoods.itemHingePinName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemStopPinCode",opener.document).val(data_search_itemFinishGoods.itemStopPinCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemStopPinName",opener.document).val(data_search_itemFinishGoods.itemStopPinName);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemOperatorCode",opener.document).val(data_search_itemFinishGoods.itemOperatorCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemOperatorName",opener.document).val(data_search_itemFinishGoods.itemOperatorName);
                $("#"+id_document+"\\."+id_subdoc+"\\.remark",opener.document).val(data_search_itemFinishGoods.remark);
            }
            
            window.close();
        });

        $("#dlgItemFinishGoods_cancelButton").click(function(ev) { 
            data_search_itemFinishGoods = null;
            window.close();
        });
    
        $("#btn_dlg_ItemFinishGoodsSearch").click(function(ev) {
            $("#dlgSearch_itemFinishGoods_grid").jqGrid("setGridParam",{url:"master/item-finish-goods-data-search?" + $("#frmItemFinishGoodsSearch").serialize(), page:1});
            $("#dlgSearch_itemFinishGoods_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#isItemFinishGoodsByCustomer").val(iscustomer);
        $("#itemFinishGoodsSearchCustomerCode").val(id_customerEndUser);
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
        <s:form id="frmItemFinishGoodsSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="itemFinishGoodsSearchCode" name="itemFinishGoodsSearchCode" label="Code "></s:textfield></td>
                <td hidden="true"><s:textfield id="itemFinishGoodsSearchCustomerCode" name="itemFinishGoodsSearchCustomerCode" size="50" cssStyle="display:nones"></s:textfield></td>
                <td hidden="true"><s:textfield id="isitemFinishGoodsByCustomer" name="isitemFinishGoodsByCustomer" size="50" cssStyle="display:nones"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="itemFinishGoodssSearchName" name="itemFinishGoodssSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ItemFinishGoodsSearch" button="true">Search</sj:a></td>
            </tr>
            <td align="right">
                <s:textfield id="itemFinishGoodssSearchActiveStatus" name="itemFinishGoodssSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
            </td>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_itemFinishGoods_grid"
            dataType="json"
            href="%{remoteurlItemFinishGoodsSearch}"
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
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuitemFinishGoods').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" title="Remark" width="350" sortable="true"
            />
            <sjg:gridColumn
                name="endUserCode" index="endUserCode" title="End User Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="endUserName" index="endUserName" title="End User Name" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="valveTypeCode" index="valveTypeCode" title="Valve Type Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="valveTypeName" index="valveTypeName" title="Valve Type Name" width="100" sortable="true"
            />
            <!--Body Construction 01-->
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
    <sj:a href="#" id="dlgItemFinishGoods_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgItemFinishGoods_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


