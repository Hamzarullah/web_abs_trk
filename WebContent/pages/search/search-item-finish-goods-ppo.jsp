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
      
    var search_productionPlanningOrder= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>'; 
    var id_documenttype='<%= request.getParameter("iddocumenttype") %>'; 
    var id_documentcode='<%= request.getParameter("iddoccode") %>'; 
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgProductionPlanningOrder_okButton").click(function(ev) { 
            
            productionPlanningOrderItemDetailLastRowId=rowLast;
            
            if (search_productionPlanningOrder === "grid" ) {
                    var ids = jQuery("#dlgSearch_productionPlanningOrder_grid").jqGrid('getDataIDs');
                    var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                    for(var i=0;i<ids.length;i++){
                        var exist = false;
                        var data = $("#dlgSearch_productionPlanningOrder_grid").jqGrid('getRowData',ids[i]);
                        if($("input:checkbox[id='jqg_dlgSearch_productionPlanningOrder_grid_"+ids[i]+"']").is(":checked")){
                            for(var j=0; j<idsOpener.length; j++){
                                var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                                if(data.code === dataExist.productionPlanningOrderItemDetailDocumentDetailCode){
                                        exist = true;
                                }
                            }if(exist){
                                alert('Code Has been existing in Grid');
                                return;
                            }else{
                                if(id_document === 'productionPlanningOrderItemDetail'){
                                    var defRow = {
                                        productionPlanningOrderItemDetailItemDelete                     : "delete",
                    
                                        productionPlanningOrderItemDetailDocumentDetailCode             : data.code,
                                        productionPlanningOrderItemDetailSortNo                         : data.customerPurchaseOrderSortNo,
                                        productionPlanningOrderItemDetailItemFinishGoodsCode            : data.itemFinishGoodsCode,
                                        productionPlanningOrderItemDetailBillOfMaterialCode             : data.billOfMaterialCode,
                                        productionPlanningOrderItemDetailValveTag                       : data.valveTag,
                                        productionPlanningOrderItemDetailDataSheet                      : data.dataSheet,
                                        productionPlanningOrderItemDetailDescription                    : data.description,

                                        productionPlanningOrderItemDetailItemFinishGoodsBodyConstCode   : data.itemBodyConstructionCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsBodyConstName   : data.itemBodyConstructionName,
                                        productionPlanningOrderItemDetailItemFinishGoodsTypeDesignCode  : data.itemTypeDesignCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsTypeDesignName  : data.itemTypeDesignName,
                                        productionPlanningOrderItemDetailItemFinishGoodsSeatDesignCode  : data.itemSeatDesignCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsSeatDesignName  : data.itemSeatDesignName,
                                        productionPlanningOrderItemDetailItemFinishGoodsSizeCode        : data.itemSizeCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsSizeName        : data.itemSizeName,
                                        productionPlanningOrderItemDetailItemFinishGoodsRatingCode      : data.itemRatingCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsRatingName      : data.itemRatingName,
                                        productionPlanningOrderItemDetailItemFinishGoodsBoreCode        : data.itemBoreCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsBoreName        : data.itemBoreName,

                                        productionPlanningOrderItemDetailItemFinishGoodsEndConCode      : data.itemEndConCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsEndConName      : data.itemEndConName,
                                        productionPlanningOrderItemDetailItemFinishGoodsBodyCode        : data.itemBodyCode,   
                                        productionPlanningOrderItemDetailItemFinishGoodsBodyName        : data.itemBodyName,   
                                        productionPlanningOrderItemDetailItemFinishGoodsBallCode        : data.itemBallCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsBallName        : data.itemBallName,
                                        productionPlanningOrderItemDetailItemFinishGoodsSeatCode        : data.itemSeatCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsSeatName        : data.itemSeatName,
                                        productionPlanningOrderItemDetailItemFinishGoodsSeatInsertCode  : data.itemSeatInsertCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsSeatInsertName  : data.itemSeatInsertName,
                                        productionPlanningOrderItemDetailItemFinishGoodsStemCode        : data.itemStemCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsStemName        : data.itemStemName,

                                        productionPlanningOrderItemDetailItemFinishGoodsSealCode        : data.itemSealCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsSealName        : data.itemSealName,
                                        productionPlanningOrderItemDetailItemFinishGoodsBoltCode        : data.itemBoltCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsBoltName        : data.itemBoltName,
                                        productionPlanningOrderItemDetailItemFinishGoodsDiscCode        : data.itemDiscCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsDiscName        : data.itemDiscName,
                                        productionPlanningOrderItemDetailItemFinishGoodsPlatesCode      : data.itemPlatesCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsPlatesName      : data.itemPlatesName,
                                        productionPlanningOrderItemDetailItemFinishGoodsShaftCode       : data.itemShaftCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsShaftName       : data.itemShaftName,
                                        productionPlanningOrderItemDetailItemFinishGoodsSpringCode      : data.itemSpringCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsSpringName      : data.itemSpringName,

                                        productionPlanningOrderItemDetailItemFinishGoodsArmPinCode      : data.itemArmPinCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsArmPinName      : data.itemArmPinName,
                                        productionPlanningOrderItemDetailItemFinishGoodsBackSeatCode    : data.itemBackSeatCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsBackSeatName    : data.itemBackSeatName,
                                        productionPlanningOrderItemDetailItemFinishGoodsArmCode         : data.itemArmCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsArmName         : data.itemArmName,
                                        productionPlanningOrderItemDetailItemFinishGoodsHingePinCode    : data.itemHingePinCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsHingePinName    : data.itemHingePinName,
                                        productionPlanningOrderItemDetailItemFinishGoodsStopPinCode     : data.itemStopPinCode,
                                        productionPlanningOrderItemDetailItemFinishGoodsStopPinName     : data.itemStopPinName,
                                        productionPlanningOrderItemDetailItemFinishGoodsOperatorCode    : data.itemOperatorCode, 
                                        productionPlanningOrderItemDetailItemFinishGoodsOperatorName    : data.itemOperatorName, 

                                        productionPlanningOrderItemDetailOrderQuantity                  : data.quantity,
                                        productionPlanningOrderItemDetailProcessedQuantity              : data.processedQty,
                                        productionPlanningOrderItemDetailBalanceQuantity                : data.balancedQty
                                    };

                                    window.opener.addRowDataMultiSelectedPPO(productionPlanningOrderItemDetailLastRowId,defRow);
                                    productionPlanningOrderItemDetailLastRowId++;
                                }
                            }
                        }
                    }
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_branch.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_branch.name);
                
            }

            window.close();
        });

       $("#dlgProductionPlanningOrder_cancelButton").click(function(ev) { 
            data_search_productionPlanningOrder = null;
            window.close();
        });
    
        $("#btn_dlg_ProductionPlanningOrderSearch").click(function(ev) {
            $("#dlgSearch_productionPlanningOrder_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-search-item-for-production-planning-order?" + $("#frmProductionPlanningOrderSearch").serialize(), page:1});
            $("#dlgSearch_productionPlanningOrder_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#documentType").val(id_documenttype);
        $("#headerCode").val(id_documentcode);
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
        <s:form id="frmProductionPlanningOrderSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="code" name="code" label="Code "></s:textfield></td>
                <td><s:textfield id="headerCode" name="headerCode" label="Code " hidden="true"></s:textfield></td>
            </tr>
            <tr>
                <td>
                    <s:textfield id="documentType" name="documentType" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ProductionPlanningOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
   <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_productionPlanningOrder_grid"
            dataType="json"
            href="%{remoteurlProductionPlanningOrderSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerSalesOrderItemDetail"
            multiselect = "true"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuProductionPlanningOrder').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="120" sortable="true"
            />
            <sjg:gridColumn
                name = "customerPurchaseOrderSortNo" id="customerPurchaseOrderSortNo" index = "customerPurchaseOrderSortNo" key = "customerPurchaseOrderSortNo" title = "Sort No" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "itemFinishGoodsCode" id="itemFinishGoodsCode" index = "itemFinishGoodsCode" key = "itemFinishGoodsCode" title = "Item Finish Goods Code" width = "150" sortable = "false"
            />
            <sjg:gridColumn
                name = "billOfMaterialCode" id="billOfMaterialCode" index = "billOfMaterialCode" key = "billOfMaterialCode" title = "Bom Code" width = "150" sortable = "false"
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
    <br></br>
    <sj:a href="#" id="dlgProductionPlanningOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgProductionPlanningOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>