
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%> 
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
    #internalMemoProductionClosingDetailInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var internalMemoProductionClosingDetailLastSel = -1, internalMemoProductionClosingDetailLastRowId = 0,internalMemoProductionClosingDetail_lastSel=-1;
    var internalMemoProductionClosingDetailStatuSel=0;
    var                                    
        txtInternalMemoProductionClosingCode = $("#internalMemoProductionClosing\\.code"),
        txtInternalMemoProductionClosingCustomerCode = $("#internalMemoProductionClosing\\.customer\\.code"),
        dtpInternalMemoProductionClosingTransactionDate = $("#internalMemoProductionClosing\\.transactionDate");
       
    $(document).ready(function() {
        
        hoverButton();
        loadDataInternalMemoProductionClosingDetail();
        
        $.subscribe("internalMemoProductionClosingDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#internalMemoProductionClosingDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==internalMemoProductionClosingDetailLastSel) {
                $('#internalMemoProductionClosingDetailInput_grid').jqGrid("saveRow",internalMemoProductionClosingDetailLastSel); 
                $('#internalMemoProductionClosingDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                internalMemoProductionClosingDetailLastSel=selectedRowID;
            }
            else{
                $('#internalMemoProductionClosingDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnInternalMemoProductionClosingSave').click(function(ev) {
            
            formatDateIMClosing();
            var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Update Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>IMP No: '+$("#internalMemoProductionClosing\\.code").val()+'<br/><br/>' +    
                    '</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation:",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 400,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "YES",
                                        click : function() {
                                            var url="engineering/internal-memo-production-closing-save";
                                            var params = $("#frmInternalMemoProductionClosingInput").serialize();
                                            $.post(url, params, function(data) {
                                                $("#dlgLoading").dialog("close");
                                                if (data.error) {
                                                    formatDateIMClosing(); 
                                                    alert(data.errorMessage);
                                                    return;
                                                }
                                                alertMessage(data.message);
                                                closeLoading();
                                                var url = "engineering/internal-memo-production-closing";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION_CLOSING");
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
        
        $('#btnInternalMemoProductionClosingCancel').click(function(ev) {
            var url = "engineering/internal-memo-production-closing";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION_CLOSING"); 
        });
        
    });
    
    function loadDataInternalMemoProductionClosingDetail() {
       
        var url = "engineering/internal-memo-production-closing-detail-data";
        var params = "internalMemoProduction.code=" + txtInternalMemoProductionClosingCode.val();
       
            $.getJSON(url, params, function(data) {
                internalMemoProductionClosingDetailLastRowId = 0;
                
                    for (var i=0; i<data.listInternalMemoProductionClosingDetailTemp.length; i++) {
                    internalMemoProductionClosingDetailLastRowId++;
                    $("#internalMemoProductionClosingDetailInput_grid").jqGrid("addRowData", internalMemoProductionClosingDetailLastRowId, data.listInternalMemoProductionClosingDetailTemp[i]);
                    $("#internalMemoProductionClosingDetailInput_grid").jqGrid('setRowData',internalMemoProductionClosingDetailLastRowId,{
                        internalMemoProductionClosingDetailDelete                            : "delete",
                        internalMemoProductionClosingDetailDataSheet                         : data.listInternalMemoProductionClosingDetailTemp[i].dataSheet,
                        internalMemoProductionClosingDetailDescription                       : data.listInternalMemoProductionClosingDetailTemp[i].description,
                        internalMemoProductionClosingDetailItemFinishGoodsCode               : data.listInternalMemoProductionClosingDetailTemp[i].itemFinishGoodsCode,
                        internalMemoProductionClosingDetailSortNo                            : data.listInternalMemoProductionClosingDetailTemp[i].internalMemoSortNo,
                        internalMemoProductionClosingDetailItemFinishGoodsRemark             : data.listInternalMemoProductionClosingDetailTemp[i].itemFinishGoodsRemark,
                        internalMemoProductionClosingDetailValveTag                          : data.listInternalMemoProductionClosingDetailTemp[i].valveTag,
                        internalMemoProductionClosingDetailBodyConstruction                  : data.listInternalMemoProductionClosingDetailTemp[i].itemBodyConstructionName,
                        internalMemoProductionClosingDetailTypeDesign                        : data.listInternalMemoProductionClosingDetailTemp[i].itemTypeDesignName,
                        internalMemoProductionClosingDetailSeatDesign                        : data.listInternalMemoProductionClosingDetailTemp[i].itemSeatDesignName,
                        internalMemoProductionClosingDetailSize                              : data.listInternalMemoProductionClosingDetailTemp[i].itemSizeName,
                        internalMemoProductionClosingDetailRating                            : data.listInternalMemoProductionClosingDetailTemp[i].itemRatingName,
                        internalMemoProductionClosingDetailBore                              : data.listInternalMemoProductionClosingDetailTemp[i].itemBoreName,
                        internalMemoProductionClosingDetailEndCon                            : data.listInternalMemoProductionClosingDetailTemp[i].itemEndConName,
                        internalMemoProductionClosingDetailBody                              : data.listInternalMemoProductionClosingDetailTemp[i].itemBodyName,
                        internalMemoProductionClosingDetailBall                              : data.listInternalMemoProductionClosingDetailTemp[i].itemBallName,
                        internalMemoProductionClosingDetailSeat                              : data.listInternalMemoProductionClosingDetailTemp[i].itemSeatName,
                        internalMemoProductionClosingDetailSeatInsert                        : data.listInternalMemoProductionClosingDetailTemp[i].itemSeatInsertName,
                        internalMemoProductionClosingDetailStem                              : data.listInternalMemoProductionClosingDetailTemp[i].itemStemName,
                        internalMemoProductionClosingDetailSeal                              : data.listInternalMemoProductionClosingDetailTemp[i].itemSealName,
                        internalMemoProductionClosingDetailBolting                           : data.listInternalMemoProductionClosingDetailTemp[i].itemBoltName,
                        internalMemoProductionClosingDetailDisc                              : data.listInternalMemoProductionClosingDetailTemp[i].itemDiscName,
                        internalMemoProductionClosingDetailPlates                            : data.listInternalMemoProductionClosingDetailTemp[i].itemPlatesName,
                        internalMemoProductionClosingDetailShaft                             : data.listInternalMemoProductionClosingDetailTemp[i].itemShaftName,
                        internalMemoProductionClosingDetailSpring                            : data.listInternalMemoProductionClosingDetailTemp[i].itemSpringName,
                        internalMemoProductionClosingDetailArmPin                            : data.listInternalMemoProductionClosingDetailTemp[i].itemArmPinName,
                        internalMemoProductionClosingDetailBackseat                          : data.listInternalMemoProductionClosingDetailTemp[i].itemBackseatName,
                        internalMemoProductionClosingDetailArm                               : data.listInternalMemoProductionClosingDetailTemp[i].itemArmName,
                        internalMemoProductionClosingDetailHingePin                          : data.listInternalMemoProductionClosingDetailTemp[i].itemHingePinName,
                        internalMemoProductionClosingDetailStopPin                           : data.listInternalMemoProductionClosingDetailTemp[i].itemStopPinName,
                        internalMemoProductionClosingDetailOperator                          : data.listInternalMemoProductionClosingDetailTemp[i].itemOperatorName,
                        internalMemoProductionClosingDetailQuantity                          : data.listInternalMemoProductionClosingDetailTemp[i].quantity
                    });
                }
                
//                setHeightGridPR();
            }); 
    }
    
    function internalMemoProductionClosingTransactionDateOnChange(){
        if($("#internalMemoProductionClosingUpdateMode").val()==="false"){
            var internalMemoProductionClosingTransactionDateSplit=$("#internalMemoProductionClosing\\.transactionDate").val().split('/');
            var internalMemoProductionClosingTransactionDate=internalMemoProductionClosingTransactionDateSplit[1]+"/"+internalMemoProductionClosingTransactionDateSplit[0]+"/"+internalMemoProductionClosingTransactionDateSplit[2];
            $("#internalMemoProductionClosingTransactionDate").val(internalMemoProductionClosingTransactionDate);
        }
    }
    
    function setHeightGridInternalMemoProductionClosingDetail(){
        var ids = jQuery("#internalMemoProductionClosingDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#internalMemoProductionClosingDetailInput_grid"+" tr").eq(1).height();
            $("#internalMemoProductionClosingDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#internalMemoProductionClosingDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
     function formatDateIMClosing(){
        var date = dtpInternalMemoProductionClosingTransactionDate.val(); 
        var dateTemp = date.toString().split(" ");
        var splitDate = dateTemp[0].toString().split("/");
        var transDate = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2]+" "+dateTemp[1];
        dtpInternalMemoProductionClosingTransactionDate.val(transDate);        
        $("#internalMemoProductionClosingTemp\\.transactionDateTemp").val(dtpInternalMemoProductionClosingTransactionDate.val());
    }

</script>
<s:url id="remoteurlInternalMemoProductionClosingDetailInput" action="" />
<b>INTERNAL MEMO PRODUCTION</b>
<hr>
<br class="spacer" />
<div id="internalMemoProductionClosingInput" class="content ui-widget">
        <s:form id="frmInternalMemoProductionClosingInput">
            <table cellpadding="2" cellspacing="2" id="internalMemoProductionClosing_Input">
                <tr valign="top">
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>IM No *</B></td>
                                <td><s:textfield id="internalMemoProductionClosing.code" name="internalMemoProductionClosing.code" key="internalMemoProductionClosing.code" readonly="true" size="25"></s:textfield></td>
                                <td><s:textfield id="internalMemoProductionClosingUpdateMode" name="internalMemoProductionClosingUpdateMode" size="20" cssStyle="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Branch *</B></td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionClosing.branch.code" name="internalMemoProductionClosing.branch.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionClosing.branch.name" name="internalMemoProductionClosing.branch.name" size="40" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="internalMemoProductionClosing.transactionDate" name="internalMemoProductionClosing.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange="internalMemoProductionClosingTransactionDateOnChange()" disabled="true" readonly="true"></sj:datepicker>
                                    <sj:datepicker id="internalMemoProductionClosingTransactionDate" name="internalMemoProductionClosingTransactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px">Project </td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionClosing.project.code" name="internalMemoProductionClosing.project.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionClosing.project.name" name="internalMemoProductionClosing.project.name" size="40" readonly="true"></s:textfield>
                                </td>    
                            </tr>
                            <tr>
                                <td align="right">Subject </td>
                                <td><s:textfield id="internalMemoProductionClosing.subject" name="internalMemoProductionClosing.subject" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">To </td>
                                <td><s:textfield id="internalMemoProductionClosing.im_To" name="internalMemoProductionClosing.im_To" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Attn </td>
                                <td><s:textfield id="internalMemoProductionClosing.attention" name="internalMemoProductionClosing.attention" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Valve Type * </B> </td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionClosing.valveType.code" name="internalMemoProductionClosing.valveType.code" title=" " size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionClosing.valveType.name" name="internalMemoProductionClosing.valveType.name" size="30" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                      </table>
                    </td>
                     <td>
                        <table>
                            <tr>
                                <td align="right"><B>Customer *</B></td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionClosing.customer.code" name="internalMemoProductionClosing.customer.code" size="22" readonly="true" ></s:textfield>
                                    <s:textfield id="internalMemoProductionClosing.customer.name" name="internalMemoProductionClosing.customer.name" size="40" readonly="true" ></s:textfield> 
                                </td>
                            </tr>   
                            <tr>
                                <td align="right" style="width:120px"><B>Sales Person *</B></td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionClosing.salesPerson.code" name="internalMemoProductionClosing.salesPerson.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionClosing.salesPerson.name" name="internalMemoProductionClosing.salesPerson.name" size="40" readonly="true"></s:textfield>
                                </td>    
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="internalMemoProductionClosing.refNo" name="internalMemoProductionClosing.refNo" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="internalMemoProductionClosing.remark" name="internalMemoProductionClosing.remark" cols="50" rows="2" height="20" readonly="true"></s:textarea></td>                  
                            </tr>
                            <tr hidden="true">
                                <td/>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionClosing.createdBy"  name="internalMemoProductionClosing.createdBy" size="20"></s:textfield>
                                    <sj:datepicker id="internalMemoProductionClosing.createdDate" name="internalMemoProductionClosing.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr hidden="true">
                                <td>
                                    <s:textfield id="internalMemoProductionClosingTemp.createdDateTemp" name="internalMemoProductionClosing.createdDateTemp" size="22"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </s:form>
   
    <div id="internalMemoProductionClosingDetailInputGrid">
            <sjg:grid
                id="internalMemoProductionClosingDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listInternalMemoProductionClosingDetailTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuInternalMemoProductionClosingDetail').width()"
                editurl="%{remoteurlInternalMemoProductionClosingDetailInput}"
                onSelectRowTopics="internalMemoProductionClosingDetailInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetail" index="internalMemoProductionClosingDetail" key="internalMemoProductionClosingDetail" title=""
                    width="200" sortable="true" editable="true" edittype="text" hidden="true"
                />    
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailItemFinishGoodsCode" index="internalMemoProductionClosingDetailItemFinishGoodsCode" key="internalMemoProductionClosingDetailItemFinishGoodsCode" 
                    title="IFG Code" width="200" sortable="true" editable="false"
                />     
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailSortNo" index="internalMemoProductionClosingDetailSortNo" 
                    title="Sort No" width="80" sortable="true" editable="false" edittype="text" formatter="integer"
                    editoptions="{onKeyUp:'avoidSpcCharIMP()'}"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailItemFinishGoodsRemark" index="internalMemoProductionClosingDetailItemFinishGoodsRemark" key="internalMemoProductionClosingDetailItemFinishGoodsRemark" 
                    title="IFG Remark" width="200" sortable="true" editable="false"
                />     
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailValveTag" index="internalMemoProductionClosingDetailValveTag" key="internalMemoProductionClosingDetailValveTag" 
                    title="Valve Tag" width="150" sortable="true" editable="false" edittype="text"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailDataSheet" index="internalMemoProductionClosingDetailDataSheet" key="internalMemoProductionClosingDetailDataSheet" 
                    title="Data Sheet" width="150" sortable="true" editable="false" edittype="text"
                /> 
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailDescription" index="internalMemoProductionClosingDetailDescription" key="internalMemoProductionClosingDetailDescription" 
                    title="Description" width="150" sortable="true" editable="false" edittype="text"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailTypeDesign" index="internalMemoProductionClosingDetailTypeDesign" key="internalMemoProductionClosingDetailTypeDesign" 
                    title="Type Design" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailSize" index="internalMemoProductionClosingDetailSize" key="internalMemoProductionClosingDetailSize" 
                    title="Size" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailRating" index="internalMemoProductionClosingDetailRating" key="internalMemoProductionClosingDetailRating" 
                    title="Rating" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailBore" index="internalMemoProductionClosingDetailBore" key="internalMemoProductionClosingDetailBore" 
                    title="Bore" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailEndCon" index="internalMemoProductionClosingDetailEndCon" key="internalMemoProductionClosingDetailEndCon" 
                    title="End Con" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailBody" index="internalMemoProductionClosingDetailBody" key="internalMemoProductionClosingDetailBody" 
                    title="Body" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailStem" index="internalMemoProductionClosingDetailStem" key="internalMemoProductionClosingDetailStem" 
                    title="Stem" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailSeal" index="internalMemoProductionClosingDetailSeal" key="internalMemoProductionClosingDetailSeal" 
                    title="Seal" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailSeat" index="internalMemoProductionClosingDetailSeat" key="internalMemoProductionClosingDetailSeat" 
                    title="Seat" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailSeatInsert" index="internalMemoProductionClosingDetailSeatInsert" key="internalMemoProductionClosingDetailSeatInsert" 
                    title="Seat Insert" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailBolting" index="internalMemoProductionClosingDetailBolting" key="internalMemoProductionClosingDetailBolting" 
                    title="Bolt" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailSeatDesign" index="internalMemoProductionClosingDetailSeatDesign" key="internalMemoProductionClosingDetailSeatDesign" 
                    title="Seat Design" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailOperator" index="internalMemoProductionClosingDetailOperator" key="internalMemoProductionClosingDetailOperator" 
                    title="Operator" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailNote" index="internalMemoProductionClosingDetailNote" key="internalMemoProductionClosingDetailNote" 
                    title="Note" width="150" sortable="true" editable="false" hidden="true"
                />
                <sjg:gridColumn
                    name="internalMemoProductionClosingDetailQuantity" index="internalMemoProductionClosingDetailQuantity" key="internalMemoProductionClosingDetailQuantity" title="Quantity" 
                    width="100" align="right" editable="false" edittype="text" 
                    formatter="number" editrules="{ double: true }"
                />
            </sjg:grid >
        </div>

    </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                        <tr>
                            <td>
                                <sj:a href="#" id="btnInternalMemoProductionClosingSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnInternalMemoProductionClosingCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
        </table>