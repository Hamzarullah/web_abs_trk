
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
    #internalMemoProductionApprovalDetailInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var internalMemoProductionApprovalDetailLastSel = -1, internalMemoProductionApprovalDetailLastRowId = 0,internalMemoProductionApprovalDetail_lastSel=-1;
    var internalMemoProductionApprovalDetailStatuSel=0;
    var                                    
        txtInternalMemoProductionApprovalCode = $("#internalMemoProductionApproval\\.code"),
        txtInternalMemoProductionApprovalCustomerCode = $("#internalMemoProductionApproval\\.customer\\.code"),
        txtInternalMemoProductionApprovalReasonCode = $("#internalMemoProductionApproval\\.reason\\.code"),
        txtInternalMemoProductionApprovalReasonName = $("#internalMemoProductionApproval\\.reason\\.name"),
        dtpInternalMemoProductionApprovalTransactionDate = $("#internalMemoProductionApproval\\.transactionDate");
       
    $(document).ready(function() {
        
        hoverButton();
        loadDataInternalMemoProductionApprovalDetail();
        
        $.subscribe("internalMemoProductionApprovalDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#internalMemoProductionApprovalDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==internalMemoProductionApprovalDetailLastSel) {
                $('#internalMemoProductionApprovalDetailInput_grid').jqGrid("saveRow",internalMemoProductionApprovalDetailLastSel); 
                $('#internalMemoProductionApprovalDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                internalMemoProductionApprovalDetailLastSel=selectedRowID;
            }
            else{
                $('#internalMemoProductionApprovalDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
         $('#internalMemoProductionApprovalStatusRadAPPROVED').change(function(ev){
            $("#internalMemoProductionApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('#internalMemoProductionApprovalStatusRadREJECTED').change(function(ev){
            $("#internalMemoProductionApproval\\.approvalStatus").val("REJECTED");
        });
        
        $('#btnInternalMemoProductionApprovalSave').click(function(ev) {
            
            if($("#internalMemoProductionApproval\\.approvalStatus").val()===""){
                alertMessage("Approval Status Must Be Filled");
                return;
            }
            
            formatDateIMApproval();
            var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Update Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>IMP No: '+$("#internalMemoProductionApproval\\.code").val()+'<br/><br/>' +    
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
                                            var url="engineering/internal-memo-production-approval-save";
                                            var params = $("#frmInternalMemoProductionApprovalInput").serialize();
                                            $.post(url, params, function(data) {
                                                $("#dlgLoading").dialog("close");
                                                if (data.error) {
                                                    formatDateIMApproval(); 
                                                    alert(data.errorMessage);
                                                    return;
                                                }
                                                alertMessage(data.message);
                                                closeLoading();
                                                var url = "engineering/internal-memo-production-approval";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION_APPROVAL");
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
        
        $('#btnInternalMemoProductionApprovalCancel').click(function(ev) {
            var url = "engineering/internal-memo-production-approval";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_PRODUCTION_APPROVAL"); 
        });
        
    });
    
    function loadDataInternalMemoProductionApprovalDetail() {
       
        var url = "engineering/internal-memo-production-approval-detail-data";
        var params = "internalMemoProduction.code=" + txtInternalMemoProductionApprovalCode.val();
       
            $.getJSON(url, params, function(data) {
                internalMemoProductionApprovalDetailLastRowId = 0;
                
                    for (var i=0; i<data.listInternalMemoProductionApprovalDetailTemp.length; i++) {
                    internalMemoProductionApprovalDetailLastRowId++;
                    $("#internalMemoProductionApprovalDetailInput_grid").jqGrid("addRowData", internalMemoProductionApprovalDetailLastRowId, data.listInternalMemoProductionApprovalDetailTemp[i]);
                    $("#internalMemoProductionApprovalDetailInput_grid").jqGrid('setRowData',internalMemoProductionApprovalDetailLastRowId,{
                        internalMemoProductionApprovalDetailDelete                            : "delete",
                        internalMemoProductionApprovalDetailDataSheet                         : data.listInternalMemoProductionApprovalDetailTemp[i].dataSheet,
                        internalMemoProductionApprovalDetailDescription                       : data.listInternalMemoProductionApprovalDetailTemp[i].description,
                        internalMemoProductionApprovalDetailItemFinishGoodsCode               : data.listInternalMemoProductionApprovalDetailTemp[i].itemFinishGoodsCode,
                        internalMemoProductionApprovalDetailSortNo                            : data.listInternalMemoProductionApprovalDetailTemp[i].internalMemoSortNo,
                        internalMemoProductionApprovalDetailItemFinishGoodsRemark             : data.listInternalMemoProductionApprovalDetailTemp[i].itemFinishGoodsRemark,
                        internalMemoProductionApprovalDetailValveTag                          : data.listInternalMemoProductionApprovalDetailTemp[i].valveTag,
                        internalMemoProductionApprovalDetailBodyConstruction                  : data.listInternalMemoProductionApprovalDetailTemp[i].itemBodyConstructionName,
                        internalMemoProductionApprovalDetailTypeDesign                        : data.listInternalMemoProductionApprovalDetailTemp[i].itemTypeDesignName,
                        internalMemoProductionApprovalDetailSeatDesign                        : data.listInternalMemoProductionApprovalDetailTemp[i].itemSeatDesignName,
                        internalMemoProductionApprovalDetailSize                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemSizeName,
                        internalMemoProductionApprovalDetailRating                            : data.listInternalMemoProductionApprovalDetailTemp[i].itemRatingName,
                        internalMemoProductionApprovalDetailBore                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemBoreName,
                        internalMemoProductionApprovalDetailEndCon                            : data.listInternalMemoProductionApprovalDetailTemp[i].itemEndConName,
                        internalMemoProductionApprovalDetailBody                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemBodyName,
                        internalMemoProductionApprovalDetailBall                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemBallName,
                        internalMemoProductionApprovalDetailSeat                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemSeatName,
                        internalMemoProductionApprovalDetailSeatInsert                        : data.listInternalMemoProductionApprovalDetailTemp[i].itemSeatInsertName,
                        internalMemoProductionApprovalDetailStem                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemStemName,
                        internalMemoProductionApprovalDetailSeal                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemSealName,
                        internalMemoProductionApprovalDetailBolting                           : data.listInternalMemoProductionApprovalDetailTemp[i].itemBoltName,
                        internalMemoProductionApprovalDetailDisc                              : data.listInternalMemoProductionApprovalDetailTemp[i].itemDiscName,
                        internalMemoProductionApprovalDetailPlates                            : data.listInternalMemoProductionApprovalDetailTemp[i].itemPlatesName,
                        internalMemoProductionApprovalDetailShaft                             : data.listInternalMemoProductionApprovalDetailTemp[i].itemShaftName,
                        internalMemoProductionApprovalDetailSpring                            : data.listInternalMemoProductionApprovalDetailTemp[i].itemSpringName,
                        internalMemoProductionApprovalDetailArmPin                            : data.listInternalMemoProductionApprovalDetailTemp[i].itemArmPinName,
                        internalMemoProductionApprovalDetailBackseat                          : data.listInternalMemoProductionApprovalDetailTemp[i].itemBackseatName,
                        internalMemoProductionApprovalDetailArm                               : data.listInternalMemoProductionApprovalDetailTemp[i].itemArmName,
                        internalMemoProductionApprovalDetailHingePin                          : data.listInternalMemoProductionApprovalDetailTemp[i].itemHingePinName,
                        internalMemoProductionApprovalDetailStopPin                           : data.listInternalMemoProductionApprovalDetailTemp[i].itemStopPinName,
                        internalMemoProductionApprovalDetailOperator                          : data.listInternalMemoProductionApprovalDetailTemp[i].itemOperatorName,
                        internalMemoProductionApprovalDetailQuantity                          : data.listInternalMemoProductionApprovalDetailTemp[i].quantity
                    });
                }
                
//                setHeightGridPR();
            }); 
    }
    
    function internalMemoProductionApprovalTransactionDateOnChange(){
        if($("#internalMemoProductionApprovalUpdateMode").val()==="false"){
            var internalMemoProductionApprovalTransactionDateSplit=$("#internalMemoProductionApproval\\.transactionDate").val().split('/');
            var internalMemoProductionApprovalTransactionDate=internalMemoProductionApprovalTransactionDateSplit[1]+"/"+internalMemoProductionApprovalTransactionDateSplit[0]+"/"+internalMemoProductionApprovalTransactionDateSplit[2];
            $("#internalMemoProductionApprovalTransactionDate").val(internalMemoProductionApprovalTransactionDate);
        }
    }
    
    function setHeightGridInternalMemoProductionApprovalDetail(){
        var ids = jQuery("#internalMemoProductionApprovalDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#internalMemoProductionApprovalDetailInput_grid"+" tr").eq(1).height();
            $("#internalMemoProductionApprovalDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#internalMemoProductionApprovalDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
     function formatDateIMApproval(){
        var date = dtpInternalMemoProductionApprovalTransactionDate.val(); 
        var dateTemp = date.toString().split(" ");
        var splitDate = dateTemp[0].toString().split("/");
        var transDate = splitDate[1]+"/"+splitDate[0]+"/"+splitDate[2]+" "+dateTemp[1];
        dtpInternalMemoProductionApprovalTransactionDate.val(transDate);        
        $("#internalMemoProductionApprovalTemp\\.transactionDateTemp").val(dtpInternalMemoProductionApprovalTransactionDate.val());
    }

</script>
<s:url id="remoteurlInternalMemoProductionApprovalDetailInput" action="" />
<b>INTERNAL MEMO PRODUCTION</b>
<hr>
<br class="spacer" />
<div id="internalMemoProductionApprovalInput" class="content ui-widget">
        <s:form id="frmInternalMemoProductionApprovalInput">
            <table cellpadding="2" cellspacing="2" id="internalMemoProductionApproval_Input">
                <tr valign="top">
                    <td>
                        <table>
                            <tr>
                                <td align="right"><B>IM No *</B></td>
                                <td><s:textfield id="internalMemoProductionApproval.code" name="internalMemoProductionApproval.code" key="internalMemoProductionApproval.code" readonly="true" size="25"></s:textfield></td>
                                <td><s:textfield id="internalMemoProductionApprovalUpdateMode" name="internalMemoProductionApprovalUpdateMode" size="20" cssStyle="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px"><B>Branch *</B></td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionApproval.branch.code" name="internalMemoProductionApproval.branch.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionApproval.branch.name" name="internalMemoProductionApproval.branch.name" size="40" readonly="true"></s:textfield>
                            </tr>
                            <tr>
                                <td align="right"><B>Transaction Date *</B></td>
                                <td>
                                    <sj:datepicker id="internalMemoProductionApproval.transactionDate" name="internalMemoProductionApproval.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%" onchange="internalMemoProductionApprovalTransactionDateOnChange()" disabled="true" readonly="true"></sj:datepicker>
                                    <sj:datepicker id="internalMemoProductionApprovalTransactionDate" name="internalMemoProductionApprovalTransactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" timepicker="true" timepickerFormat="hh:mm:ss" cssStyle="width:35%;display:none"></sj:datepicker>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width:120px">Project </td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionApproval.project.code" name="internalMemoProductionApproval.project.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionApproval.project.name" name="internalMemoProductionApproval.project.name" size="40" readonly="true"></s:textfield>
                                </td>    
                            </tr>
                            <tr>
                                <td align="right">Subject </td>
                                <td><s:textfield id="internalMemoProductionApproval.subject" name="internalMemoProductionApproval.subject" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">To </td>
                                <td><s:textfield id="internalMemoProductionApproval.im_To" name="internalMemoProductionApproval.im_To" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right">Attn </td>
                                <td><s:textfield id="internalMemoProductionApproval.attention" name="internalMemoProductionApproval.attention" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Valve Type * </B> </td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionApproval.valveType.code" name="internalMemoProductionApproval.valveType.code" title=" " size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionApproval.valveType.name" name="internalMemoProductionApproval.valveType.name" size="30" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                      </table>
                    </td>
                     <td>
                        <table>
                            <tr>
                                <td align="right"><B>Customer *</B></td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionApproval.customer.code" name="internalMemoProductionApproval.customer.code" size="22" readonly="true" ></s:textfield>
                                    <s:textfield id="internalMemoProductionApproval.customer.name" name="internalMemoProductionApproval.customer.name" size="40" readonly="true" ></s:textfield> 
                                </td>
                            </tr>   
                            <tr>
                                <td align="right" style="width:120px"><B>Sales Person *</B></td>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionApproval.salesPerson.code" name="internalMemoProductionApproval.salesPerson.code" size="22" readonly="true"></s:textfield>
                                    <s:textfield id="internalMemoProductionApproval.salesPerson.name" name="internalMemoProductionApproval.salesPerson.name" size="40" readonly="true"></s:textfield>
                                </td>    
                            </tr>
                            <tr>
                                <td align="right">Ref No</td>
                                <td><s:textfield id="internalMemoProductionApproval.refNo" name="internalMemoProductionApproval.refNo" size="27" readonly="true"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td><s:textarea id="internalMemoProductionApproval.remark" name="internalMemoProductionApproval.remark" cols="50" rows="2" height="20" readonly="true"></s:textarea></td>                  
                            </tr>
                            <tr>
                                <td align="right"><B>Approval Status</B></td>
                                <s:textfield id="internalMemoProductionApproval.approvalStatus" name="internalMemoProductionApproval.approvalStatus" readonly="false" size="15" style="display:none"></s:textfield>
                                <td><s:radio id="internalMemoProductionApprovalStatusRad" name="internalMemoProductionApprovalStatusRad" list="{'APPROVED','REJECTED'}"></s:radio></td>
                            </tr>
                            <tr>
                                <td align="right" valign="top">Approval Reason</td>
                                <td colspan="2">
                                    <script type = "text/javascript">
                                    $('#internalMemoProductionApproval_btnReason').click(function(ev) {
                                        window.open("./pages/search/search-reason.jsp?iddoc=internalMemoProductionApproval&idsubdoc=approvalReason","Search", "width=600, height=500");
                                    });

                                    txtInternalMemoProductionApprovalReasonCode.change(function(ev) {

                                        if(txtInternalMemoProductionApprovalReasonCode.val()===""){
                                            txtInternalMemoProductionApprovalReasonCode.val("");
                                            txtInternalMemoProductionApprovalReasonName.val("");
                                                   return;
                                                }
                                        var url = "master/reason-get";
                                        var params = "reason.code=" + txtInternalMemoProductionApprovalReasonCode.val();
                                            params += "&reason.activeStatus=TRUE";
                                            alert(params);
                                            return;
                                                $.post(url, params, function(result) {
                                                    var data = (result);
                                            if (data.reasonTemp){
                                                txtInternalMemoProductionApprovalReasonCode.val(data.reasonTemp.code);
                                                txtInternalMemoProductionApprovalReasonName.val(data.reasonTemp.name);
                                            }
                                            else{
                                                alertMessage("Reason Not Found!",txtInternalMemoProductionApprovalReasonCode);
                                                txtInternalMemoProductionApprovalReasonCode.val("");
                                                txtInternalMemoProductionApprovalReasonName.val("");
                                            }
                                                });
                                            });
                                    </script>
                                    <div class="searchbox ui-widget-header" hidden="true">
                                        <s:textfield id="internalMemoProductionApproval.approvalReason.code" name="internalMemoProductionApproval.approvalReason.code" size="15"></s:textfield>
                                        <sj:a id="internalMemoProductionApproval_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                    <s:textfield id="internalMemoProductionApproval.approvalReason.name" name="internalMemoProductionApproval.approvalReason.name" size="25" readonly="true"></s:textfield>
                                </td>    
                            </tr>
                            <tr>
                                <td align="right" valign="top">Approval Remark</td>
                                <td colspan="3">
                                    <s:textarea id="internalMemoProductionApproval.approvalRemark" name="internalMemoProductionApproval.approvalRemark"  cols="40" rows="2" height="30" readonly="false"></s:textarea>
                                </td>
                            </tr>
                            <tr hidden="true">
                                <td/>
                                <td colspan="2">
                                    <s:textfield id="internalMemoProductionApproval.createdBy"  name="internalMemoProductionApproval.createdBy" size="20"></s:textfield>
                                    <sj:datepicker id="internalMemoProductionApproval.createdDate" name="internalMemoProductionApproval.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                                </td>
                            </tr>
                            <tr hidden="true">
                                <td>
                                    <s:textfield id="internalMemoProductionApprovalTemp.createdDateTemp" name="internalMemoProductionApproval.createdDateTemp" size="22"></s:textfield>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </s:form>
   
    <div id="internalMemoProductionApprovalDetailInputGrid">
            <sjg:grid
                id="internalMemoProductionApprovalDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listInternalMemoProductionApprovalDetailTemp"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuInternalMemoProductionApprovalDetail').width()"
                editurl="%{remoteurlInternalMemoProductionApprovalDetailInput}"
                onSelectRowTopics="internalMemoProductionApprovalDetailInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetail" index="internalMemoProductionApprovalDetail" key="internalMemoProductionApprovalDetail" title=""
                    width="200" sortable="true" editable="true" edittype="text" hidden="true"
                />    
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailItemFinishGoodsCode" index="internalMemoProductionApprovalDetailItemFinishGoodsCode" key="internalMemoProductionApprovalDetailItemFinishGoodsCode" 
                    title="IFG Code" width="200" sortable="true" editable="false"
                />     
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailSortNo" index="internalMemoProductionApprovalDetailSortNo" 
                    title="Sort No" width="80" sortable="true" editable="false" edittype="text" formatter="integer"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailItemFinishGoodsRemark" index="internalMemoProductionApprovalDetailItemFinishGoodsRemark" key="internalMemoProductionApprovalDetailItemFinishGoodsRemark" 
                    title="IFG Remark" width="200" sortable="true" editable="false"
                />     
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailValveTag" index="internalMemoProductionApprovalDetailValveTag" key="internalMemoProductionApprovalDetailValveTag" 
                    title="Valve Tag" width="150" sortable="true" editable="false" edittype="text"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailDataSheet" index="internalMemoProductionApprovalDetailDataSheet" key="internalMemoProductionApprovalDetailDataSheet" 
                    title="Data Sheet" width="150" sortable="true" editable="false" edittype="text"
                /> 
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailDescription" index="internalMemoProductionApprovalDetailDescription" key="internalMemoProductionApprovalDetailDescription" 
                    title="Description" width="150" sortable="true" editable="false" edittype="text"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailTypeDesign" index="internalMemoProductionApprovalDetailTypeDesign" key="internalMemoProductionApprovalDetailTypeDesign" 
                    title="Type Design" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailSize" index="internalMemoProductionApprovalDetailSize" key="internalMemoProductionApprovalDetailSize" 
                    title="Size" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailRating" index="internalMemoProductionApprovalDetailRating" key="internalMemoProductionApprovalDetailRating" 
                    title="Rating" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailBore" index="internalMemoProductionApprovalDetailBore" key="internalMemoProductionApprovalDetailBore" 
                    title="Bore" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailEndCon" index="internalMemoProductionApprovalDetailEndCon" key="internalMemoProductionApprovalDetailEndCon" 
                    title="End Con" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailBody" index="internalMemoProductionApprovalDetailBody" key="internalMemoProductionApprovalDetailBody" 
                    title="Body" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailStem" index="internalMemoProductionApprovalDetailStem" key="internalMemoProductionApprovalDetailStem" 
                    title="Stem" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailSeal" index="internalMemoProductionApprovalDetailSeal" key="internalMemoProductionApprovalDetailSeal" 
                    title="Seal" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailSeat" index="internalMemoProductionApprovalDetailSeat" key="internalMemoProductionApprovalDetailSeat" 
                    title="Seat" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailSeatInsert" index="internalMemoProductionApprovalDetailSeatInsert" key="internalMemoProductionApprovalDetailSeatInsert" 
                    title="Seat Insert" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailBolting" index="internalMemoProductionApprovalDetailBolting" key="internalMemoProductionApprovalDetailBolting" 
                    title="Bolt" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailSeatDesign" index="internalMemoProductionApprovalDetailSeatDesign" key="internalMemoProductionApprovalDetailSeatDesign" 
                    title="Seat Design" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailOperator" index="internalMemoProductionApprovalDetailOperator" key="internalMemoProductionApprovalDetailOperator" 
                    title="Operator" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailNote" index="internalMemoProductionApprovalDetailNote" key="internalMemoProductionApprovalDetailNote" 
                    title="Note" width="150" sortable="true" editable="false" hidden="true"
                />
                <sjg:gridColumn
                    name="internalMemoProductionApprovalDetailQuantity" index="internalMemoProductionApprovalDetailQuantity" key="internalMemoProductionApprovalDetailQuantity" title="Quantity" 
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
                                <sj:a href="#" id="btnInternalMemoProductionApprovalSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnInternalMemoProductionApprovalCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
        </table>