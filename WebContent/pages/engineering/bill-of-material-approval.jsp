
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
    #billOfMaterialApprovalDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $('#billOfMaterialApprovalSearchDocumentTypeRadALL').prop('checked',true);
        $("#billOfMaterialApproval\\.documentType").val("");
            
        $('input[name="billOfMaterialApprovalSearchDocumentTypeRad"][value="IM"]').change(function(ev){
            $("#billOfMaterialApproval\\.documentType").val("IM");
        });
        
        $('input[name="billOfMaterialApprovalSearchDocumentTypeRad"][value="SO"]').change(function(ev){
            $("#billOfMaterialApproval\\.documentType").val("SO");
        });
        
        $('input[name="billOfMaterialApprovalSearchDocumentTypeRad"][value="BO"]').change(function(ev){
            $("#billOfMaterialApproval\\.documentType").val("BO");
        });
        
        $('input[name="billOfMaterialApprovalSearchDocumentTypeRad"][value="ALL"]').change(function(ev){
            $("#billOfMaterialApproval\\.documentType").val("");
        });
        
        $('#billOfMaterialApprovalSearchApprovalStatusRadALL').prop('checked',true);
        $("#billOfMaterialApproval\\.approvalStatus").val("");
            
        $('input[name="billOfMaterialApprovalSearchApprovalStatusRad"][value="PENDING"]').change(function(ev){
            $("#billOfMaterialApproval\\.approvalStatus").val("PENDING");
        });
        
        $('input[name="billOfMaterialApprovalSearchApprovalStatusRad"][value="APPROVED"]').change(function(ev){
            $("#billOfMaterialApproval\\.approvalStatus").val("APPROVED");
        });
        
        $('input[name="billOfMaterialApprovalSearchApprovalStatusRad"][value="REJECTED"]').change(function(ev){
            $("#billOfMaterialApproval\\.approvalStatus").val("REJECTED");
        });
        
        $('input[name="billOfMaterialApprovalSearchApprovalStatusRad"][value="ALL"]').change(function(ev){
            $("#billOfMaterialApproval\\.approvalStatus").val("");
        });
        
        $.subscribe("billOfMaterialApproval_grid_onSelect", function(event, data){
            loadItemFinishGoodsDetail();
            var selectedRowID = $("#billOfMaterialApproval_grid").jqGrid("getGridParam", "selrow"); 
            var billOfMaterialApproval = $("#billOfMaterialApproval_grid").jqGrid("getRowData", selectedRowID);
            
            $("#billOfMaterialApprovalDetailPart_grid").jqGrid("setGridParam",{url:"engineering/bill-of-material-part-detail-approval-data?billOfMaterialCode="+billOfMaterialApproval.code});
            $("#billOfMaterialApprovalDetailPart_grid").jqGrid("setCaption", "DOCUMENT ITEM DETAIL");
            $("#billOfMaterialApprovalDetailPart_grid").trigger("reloadGrid");
            
        });
        
        $('#btnBillOfMaterialApproval').click(function(ev) {

            var selectRowId = $("#billOfMaterialApproval_grid").jqGrid('getGridParam','selrow');
            var billOfMaterialApproval = $("#billOfMaterialApproval_grid").jqGrid("getRowData", selectRowId);           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url = "engineering/bill-of-material-approval-input";

            var params ="billOfMaterialApproval.code=" +billOfMaterialApproval.code;
                params +="&documentOrderCode="+billOfMaterialApproval.documentOrderCode;
                params +="&documentDetailCode="+billOfMaterialApproval.documentDetailCode;

            pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL_APPROVAL");
        });
        
        $('#btnBillOfMaterialApproval_search').click(function(ev) {
            formatDatePPOBomApproval();
            $("#billOfMaterialApproval_grid").jqGrid("clearGridData");
            $("#billOfMaterialApprovalDetailPart_grid").jqGrid("clearGridData");
            $("#billOfMaterialApproval_grid").jqGrid("setGridParam",{url:"bill-of-material-approval-data?" + $("#frmBillOfMaterialApprovalSearchInput").serialize()});
            $("#billOfMaterialApproval_grid").trigger("reloadGrid");
            formatDatePPOBomApproval();
            
        });
    
    }); //EOF READY
    
    function formatDatePPOBomApproval(){
        var firstDate=$("#billOfMaterialApproval\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#billOfMaterialApproval\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#billOfMaterialApproval\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#billOfMaterialApproval\\.transactionLastDate").val(lastDateValue);
    }
    
    function loadItemFinishGoodsDetail(){
        var selectedRowId = $("#billOfMaterialApproval_grid").jqGrid('getGridParam','selrow');
        var billOfMaterialApproval = $("#billOfMaterialApproval_grid").jqGrid('getRowData', selectedRowId);    
        
        var code = billOfMaterialApproval.itemFinishGoodsCode;
        var url = "master/item-finish-goods-get-data";
        var params = "itemFinishGoods.code=" + code;

        $.post(url, params, function(result) {
            var data = (result);
            if (data.itemFinishGoodsTemp){
               
                $("#billOfMaterialApproval\\.valveTypeCode").val(data.itemFinishGoodsTemp.valveTypeCode);
                $("#billOfMaterialApproval\\.valveTypeName").val(data.itemFinishGoodsTemp.valveTypeName);
                //finishGoods
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyConstructionCode").val(data.itemFinishGoodsTemp.itemBodyConstructionCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyConstructionName").val(data.itemFinishGoodsTemp.itemBodyConstructionName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemTypeDesignCode").val(data.itemFinishGoodsTemp.itemTypeDesignCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemTypeDesignName").val(data.itemFinishGoodsTemp.itemTypeDesignName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatDesignCode").val(data.itemFinishGoodsTemp.itemSeatDesignCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatDesignName").val(data.itemFinishGoodsTemp.itemSeatDesignName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSizeCode").val(data.itemFinishGoodsTemp.itemSizeCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSizeName").val(data.itemFinishGoodsTemp.itemSizeName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemRatingCode").val(data.itemFinishGoodsTemp.itemRatingCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemRatingName").val(data.itemFinishGoodsTemp.itemRatingName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoreCode").val(data.itemFinishGoodsTemp.itemBoreCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoreName").val(data.itemFinishGoodsTemp.itemBoreName);
                
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemEndConCode").val(data.itemFinishGoodsTemp.itemEndConCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemEndConName").val(data.itemFinishGoodsTemp.itemEndConName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyCode").val(data.itemFinishGoodsTemp.itemBodyCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBodyName").val(data.itemFinishGoodsTemp.itemBodyName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBallCode").val(data.itemFinishGoodsTemp.itemBallCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBallName").val(data.itemFinishGoodsTemp.itemBallName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatCode").val(data.itemFinishGoodsTemp.itemSeatCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatName").val(data.itemFinishGoodsTemp.itemSeatName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatInsertCode").val(data.itemFinishGoodsTemp.itemSeatInsertCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSeatInsertName").val(data.itemFinishGoodsTemp.itemSeatInsertName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStemCode").val(data.itemFinishGoodsTemp.itemStemCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStemName").val(data.itemFinishGoodsTemp.itemStemName);
                
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSealCode").val(data.itemFinishGoodsTemp.itemSealCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSealName").val(data.itemFinishGoodsTemp.itemSealName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoltCode").val(data.itemFinishGoodsTemp.itemBoltCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBoltName").val(data.itemFinishGoodsTemp.itemBoltName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemDiscCode").val(data.itemFinishGoodsTemp.itemDiscCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemDiscName").val(data.itemFinishGoodsTemp.itemDiscName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemPlatesCode").val(data.itemFinishGoodsTemp.itemPlatesCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemPlatesName").val(data.itemFinishGoodsTemp.itemPlatesName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemShaftCode").val(data.itemFinishGoodsTemp.itemShaftCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemShaftName").val(data.itemFinishGoodsTemp.itemShaftName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSpringCode").val(data.itemFinishGoodsTemp.itemSpringCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemSpringName").val(data.itemFinishGoodsTemp.itemSpringName);
                
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmPinCode").val(data.itemFinishGoodsTemp.itemSpringName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmPinName").val(data.itemFinishGoodsTemp.itemSpringName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBackseatCode").val(data.itemFinishGoodsTemp.itemBackseatCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemBackseatName").val(data.itemFinishGoodsTemp.itemBackseatName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmCode").val(data.itemFinishGoodsTemp.itemArmCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemArmName").val(data.itemFinishGoodsTemp.itemArmName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemHingePinCode").val(data.itemFinishGoodsTemp.itemHingePinCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemHingePinName").val(data.itemFinishGoodsTemp.itemHingePinName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStopPinCode").val(data.itemFinishGoodsTemp.itemStopPinCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemStopPinName").val(data.itemFinishGoodsTemp.itemStopPinName);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemOperatorCode").val(data.itemFinishGoodsTemp.itemOperatorCode);
                $("#billOfMaterialApproval\\.itemFinishGoods\\.itemOperatorName").val(data.itemFinishGoodsTemp.itemOperatorName);

            }
        });
    }
    
</script>

<s:url id="remoteurlBillOfMaterialApproval" action="bill-of-material-approval-data" />
<s:url id="remoteurlBillOfMaterialApprovalDetail" action="" />
    <b>BILL OF MATERIAL (ENGINEERING)</b>
    <hr>
    <br class="spacer" />
   
    <div id="billOfMaterialApprovalInputSearch" class="content ui-widget">
        <s:form id="frmBillOfMaterialApprovalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period </td>
                    <td>
                        <sj:datepicker id="billOfMaterialApproval.transactionFirstDate" name="billOfMaterialApproval.transactionFirstDate" size="12" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="billOfMaterialApproval.transactionLastDate" name="billOfMaterialApproval.transactionLastDate" size="12" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr> 
                <tr>
                    <td align="right">BOM No</td>
                    <td>
                        <s:textfield id="billOfMaterialApproval.code" name="billOfMaterialApproval.code" size="27" placeholder=" Code"></s:textfield>
                    </td>
                    <td align="right">Doc No</td>
                    <td>
                        <s:textfield id="billOfMaterialApproval.documentOrderCode" name="billOfMaterialApproval.documentOrderCode" size="27" placeholder=" Doc No"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="billOfMaterialApproval.remarkDoc" name="billOfMaterialApproval.remarkDoc" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                    <td align="right">Customer Code</td>
                    <td>
                        <s:textfield id="billOfMaterialApproval.customerCode" name="billOfMaterialApproval.customerCode" size="27" placeholder=" Customer Code"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="billOfMaterialApproval.refNo" name="billOfMaterialApproval.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                    <td align="right">Customer Name</td>
                    <td>
                        <s:textfield id="billOfMaterialApproval.customerName" name="billOfMaterialApproval.customerName" size="27" placeholder=" Customer Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Document Type</td>
                    <td>
                        <s:radio id="billOfMaterialApprovalSearchDocumentTypeRad" name="billOfMaterialApprovalSearchDocumentTypeRad" label="billOfMaterialApprovalSearchDocumentTypeRad" list="{'ALL','SO','BO','IM'}"></s:radio>
                        <s:textfield id="billOfMaterialApproval.documentType" name="billOfMaterialApproval.documentType" size="20" style="Display:none" ></s:textfield>
                    </td>
                    <td align="right">Approval Status</td>
                    <td>
                        <s:radio id="billOfMaterialApprovalSearchApprovalStatusRad" name="billOfMaterialApprovalSearchApprovalStatusRad" label="billOfMaterialApprovalSearchApprovalStatusRad" list="{'ALL','PENDING','APPROVED','REJECTED'}"></s:radio>
                        <s:textfield id="billOfMaterialApproval.approvalStatus" name="billOfMaterialApproval.approvalStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnBillOfMaterialApproval_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
                  
    <!-- GRID HEADER -->    
    <div id="billOfMaterialApprovalGrid">
        <sjg:grid
            id="billOfMaterialApproval_grid"
            dataType="json"
            href="%{remoteurlBillOfMaterialApproval}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialApproval"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubillOfMaterialApproval').width()"
            onSelectRowTopics="billOfMaterialApproval_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="BOM No" width="150"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval Status" width="150"
            />
            <sjg:gridColumn
                name="approvalDate" index="approvalDate" key="approvalDate" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Approval Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="approvalBy" index="approvalBy" key="approvalBy" title="Approval By" width="150"
            />
            <sjg:gridColumn
                name="documentType" index="documentType" key="documentType" title="Doc Type" width="120"
            />
            <sjg:gridColumn
                name="documentOrderCode" index="documentOrderCode" key="documentOrderCode" title="Doc No" width="150"
            />
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" title="Doc Detail No" width="180"
            />
            <sjg:gridColumn
                name="transactionDateDoc" index="transactionDateDoc" key="transactionDateDoc" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Document Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="100"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" key="customerName" title="Customer Name" width="100"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100"
            />
            <sjg:gridColumn
                name="remarkDoc" index="remarkDoc" key="remarkDoc" title="Remark" width="100"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" key="itemFinishGoodsCode" title="Item Finish Goods" width="100" hidden="true"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
    
    <br class="spacer" />
        <div>
            <sj:a href="#" id="btnBillOfMaterialApproval" button="true" style="width: 90px">Approval</sj:a>
        </div>
    <br class="spacer" />
    
    <table>
            <tr>
                <td align="right">Body Construction</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionCode" name="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionName" name="billOfMaterialApproval.itemFinishGoods.itemBodyConstructionName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Type Design</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemTypeDesignCode" name="billOfMaterialApproval.itemFinishGoods.itemTypeDesignCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemTypeDesignName" name="billOfMaterialApproval.itemFinishGoods.itemTypeDesignName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Seat Design</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatDesignCode" name="billOfMaterialApproval.itemFinishGoods.itemSeatDesignCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatDesignName" name="billOfMaterialApproval.itemFinishGoods.itemSeatDesignName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Size</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSizeCode" name="billOfMaterialApproval.itemFinishGoods.itemSizeCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSizeName" name="billOfMaterialApproval.itemFinishGoods.itemSizeName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Rating</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemRatingCode" name="billOfMaterialApproval.itemFinishGoods.itemRatingCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemRatingName" name="billOfMaterialApproval.itemFinishGoods.itemRatingName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Bore</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoreCode" name="billOfMaterialApproval.itemFinishGoods.itemBoreCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoreName" name="billOfMaterialApproval.itemFinishGoods.itemBoreName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">End Con</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemEndConCode" name="billOfMaterialApproval.itemFinishGoods.itemEndConCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemEndConName" name="billOfMaterialApproval.itemFinishGoods.itemEndConName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Body</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyCode" name="billOfMaterialApproval.itemFinishGoods.itemBodyCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBodyName" name="billOfMaterialApproval.itemFinishGoods.itemBodyName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ball</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBallCode" name="billOfMaterialApproval.itemFinishGoods.itemBallCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBallName" name="billOfMaterialApproval.itemFinishGoods.itemBallName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Seat</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatCode" name="billOfMaterialApproval.itemFinishGoods.itemSeatCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatName" name="billOfMaterialApproval.itemFinishGoods.itemSeatName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Seat Insert</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatInsertCode" name="billOfMaterialApproval.itemFinishGoods.itemSeatInsertCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSeatInsertName" name="billOfMaterialApproval.itemFinishGoods.itemSeatInsertName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Stem</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStemCode" name="billOfMaterialApproval.itemFinishGoods.itemStemCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStemName" name="billOfMaterialApproval.itemFinishGoods.itemStemName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Seal</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSealCode" name="billOfMaterialApproval.itemFinishGoods.itemSealCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSealName" name="billOfMaterialApproval.itemFinishGoods.itemSealName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Bolt</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoltCode" name="billOfMaterialApproval.itemFinishGoods.itemBoltCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBoltName" name="billOfMaterialApproval.itemFinishGoods.itemBoltName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Disc</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemDiscCode" name="billOfMaterialApproval.itemFinishGoods.itemDiscCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemDiscName" name="billOfMaterialApproval.itemFinishGoods.itemDiscName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Plates</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemPlatesCode" name="billOfMaterialApproval.itemFinishGoods.itemPlatesCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemPlatesName" name="billOfMaterialApproval.itemFinishGoods.itemPlatesName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Shaft</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemShaftCode" name="billOfMaterialApproval.itemFinishGoods.itemShaftCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemShaftName" name="billOfMaterialApproval.itemFinishGoods.itemShaftName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Spring</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSpringCode" name="billOfMaterialApproval.itemFinishGoods.itemSpringCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemSpringName" name="billOfMaterialApproval.itemFinishGoods.itemSpringName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Arm Pin</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmPinCode" name="billOfMaterialApproval.itemFinishGoods.itemArmPinCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmPinName" name="billOfMaterialApproval.itemFinishGoods.itemArmPinName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Back Seat</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBackseatCode" name="billOfMaterialApproval.itemFinishGoods.itemBackseatCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemBackseatName" name="billOfMaterialApproval.itemFinishGoods.itemBackseatName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Arm</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmCode" name="billOfMaterialApproval.itemFinishGoods.itemArmCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemArmName" name="billOfMaterialApproval.itemFinishGoods.itemArmName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Hinge Pin</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemHingePinCode" name="billOfMaterialApproval.itemFinishGoods.itemHingePinCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemHingePinName" name="billOfMaterialApproval.itemFinishGoods.itemHingePinName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Stop Pin</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStopPinCode" name="billOfMaterialApproval.itemFinishGoods.itemStopPinCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemStopPinName" name="billOfMaterialApproval.itemFinishGoods.itemStopPinName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Operator</td>
                <td colspan="3">
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemOperatorCode" name="billOfMaterialApproval.itemFinishGoods.itemOperatorCode" size="27" title=" " readonly="true"></s:textfield>
                    <s:textfield id="billOfMaterialApproval.itemFinishGoods.itemOperatorName" name="billOfMaterialApproval.itemFinishGoods.itemOperatorName" size="27" title=" " readonly="true"></s:textfield>
                </td>
            </tr>
        </table>
    
<br class="spacer" />
    <sjg:grid
        id="billOfMaterialApprovalDetailPart_grid"
        caption="BILL OF MATERIAL DETAIL PART"
        dataType="json"
        pager="true"
        navigator="false"
        navigatorSearch="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listBillOfMaterialApprovalPartDetail"
        viewrecords="true"
        rownumbers="true"
        rowNum="10000"
        shrinkToFit="false"
        width="$('#billOfMaterialApprovalDetailParts').width()"
    > 
        <sjg:gridColumn
            name = "partNo" id="partNo" index = "partNo" key = "partNo" title = "Part No" width = "100"
        />
        <sjg:gridColumn
            name = "partCode" id="partCode" index = "partCode" key = "partCode" title = "Part Code" width = "100"
        />
        <sjg:gridColumn
            name = "partName" id="partName" index = "partName" key = "partName" title = "Part Name" width = "150"
        />
        <sjg:gridColumn
            name = "drawingCode" id="drawingCode" index = "drawingCode" key = "drawingCode" title = "Drawing Code" width = "150"
        />
        <sjg:gridColumn
            name = "dimension" id="dimension" index = "dimension" key = "dimension" title = "Dimension" width = "150"
        />
        <sjg:gridColumn
            name = "material" id="material" index = "material" key = "material" title = "Material" width = "120"
        />
        <sjg:gridColumn
            name = "quantity" index = "quantity" key = "quantity" title = "Quantity" formatter="number" width = "150" sortable = "false" align="right"
        />
        <sjg:gridColumn
            name = "requirement" id="requirement" index = "requirement" key = "requirement" title = "Requirement" width = "120"
        />
        <sjg:gridColumn
            name = "processedStatus" id="processedStatus" index = "processedStatus" key = "processedStatus" title = "Processed Status" width = "120"
        />
        <sjg:gridColumn
            name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150"
        />
        <sjg:gridColumn
            name = "x" id="x" index = "x" key = "x" title = "X" width = "150"
        />
        <sjg:gridColumn
            name = "revNo" id="revNo" index = "revNo" key = "revNo" title = "Rev No" width = "150"
        />
    </sjg:grid >