
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
    #billOfMaterialDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
         
    $(document).ready(function(){
        hoverButton();
        
        $('#billOfMaterialSearchDocumentTypeRadALL').prop('checked',true);
        $("#billOfMaterial\\.documentOrderType").val("");
            
        $('input[name="billOfMaterialSearchDocumentTypeRad"][value="IM"]').change(function(ev){
            $("#billOfMaterial\\.documentOrderType").val("IM");
        });
        
        $('input[name="billOfMaterialSearchDocumentTypeRad"][value="SO"]').change(function(ev){
            $("#billOfMaterial\\.documentOrderType").val("SO");
        });
        
        $('input[name="billOfMaterialSearchDocumentTypeRad"][value="BO"]').change(function(ev){
            $("#billOfMaterial\\.documentOrderType").val("BO");
        });
        
        $('input[name="billOfMaterialSearchDocumentTypeRad"][value="ALL"]').change(function(ev){
            $("#billOfMaterial\\.documentOrderType").val("");
        });
        
        $.subscribe("billOfMaterial_grid_onSelect", function(event, data){
            var selectedRowID = $("#billOfMaterial_grid").jqGrid("getGridParam", "selrow"); 
            var billOfMaterial = $("#billOfMaterial_grid").jqGrid("getRowData", selectedRowID);
            
            $("#billOfMaterialDetail_grid").jqGrid("setGridParam",{url:"engineering/bill-of-material-detail-data?documentOrderCode="+billOfMaterial.documentOrderCode});
            $("#billOfMaterialDetail_grid").jqGrid("setCaption", "DOCUMENT ITEM DETAIL");
            $("#billOfMaterialDetail_grid").trigger("reloadGrid");
            
        });
        
        $.subscribe("billOfMaterialDetail_grid_onSelect", function(event, data){
            var selectedRowID = $("#billOfMaterialDetail_grid").jqGrid("getGridParam", "selrow"); 
            var billOfMaterialPart = $("#billOfMaterialDetail_grid").jqGrid("getRowData", selectedRowID);
            
            $("#billOfMaterialDetailPart_grid").jqGrid("setGridParam",{url:"engineering/bill-of-material-part-detail-data?billOfMaterialCode="+billOfMaterialPart.bomCode});
            $("#billOfMaterialDetailPart_grid").jqGrid("setCaption", "BILL OF MATERIAL");
            $("#billOfMaterialDetailPart_grid").trigger("reloadGrid");
            
        });
        
        $("#btnBillOfMaterialNew").click(function (ev) {
           
            var url = "engineering/bill-of-material-input";
            var param = "";

            pageLoad(url, param, "#tabmnuBILL_OF_MATERIAL");
            ev.preventDefault();    
        });
        
        $("#btnBillOfMaterialUpdate").click(function (ev) {
            
            var deleteRowId = $("#billOfMaterial_grid").jqGrid('getGridParam','selrow');
            var billOfMaterial = $("#billOfMaterial_grid").jqGrid('getRowData', deleteRowId);

            if (deleteRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var params = "billOfMaterialUpdateMode=true" + "&billOfMaterial.code=" + billOfMaterial.code;
            pageLoad("engineering/bill-of-material-input", params, "#tabmnuBILL_OF_MATERIAL"); 

            ev.preventDefault();
            
        });
        
        $("#btnBillOfMaterialRefresh").click(function (ev) {
            var url = "engineering/bill-of-material";
            var params = "";
            pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL");
            ev.preventDefault();
        });
        
        $('#btnBillOfMaterial_search').click(function(ev) {
            formatDatePPOBom();
            $("#billOfMaterial_grid").jqGrid("clearGridData");
            $("#billOfMaterialDetail_grid").jqGrid("clearGridData");
            $("#billOfMaterial_grid").jqGrid("setGridParam",{url:"bill-of-material-data?" + $("#frmBillOfMaterialSearchInput").serialize()});
            $("#billOfMaterial_grid").trigger("reloadGrid");
            formatDatePPOBom();
            
        });
    
    }); //EOF READY
    
    function formatDatePPOBom(){
        var firstDate=$("#billOfMaterial\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#billOfMaterial\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#billOfMaterial\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#billOfMaterial\\.transactionLastDate").val(lastDateValue);
    }
    
    function bomDetail_OnClick(){
        
        //header
        var selectedRowId = $("#billOfMaterial_grid").jqGrid('getGridParam','selrow');
        var billOfMaterial = $("#billOfMaterial_grid").jqGrid('getRowData', selectedRowId);

        if (selectedRowId === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        //detail
        var selectedRowIdDetail = $("#billOfMaterialDetail_grid").jqGrid('getGridParam','selrow');
        var billOfMaterialDetail = $("#billOfMaterialDetail_grid").jqGrid('getRowData', selectedRowIdDetail);

        if (selectedRowIdDetail === null) {
            alertMessage("Please Select Row!");
            return;
        }
        
        var bomStatus = billOfMaterialDetail.bomStatusNew;  
        var approvalStatus = billOfMaterialDetail.approvalStatus;    
        
        var url = "engineering/bill-of-material-input";
        var params;
        
        if (bomStatus === "NO"){
            params ="enumBillOfMaterialActivity=NEW";
            params +="&itemFinishGoodsCode="+billOfMaterialDetail.itemFinishGoodsCode;
            params +="&documentOrderDetail="+billOfMaterialDetail.documentOrderDetailCode;
            params +="&documentOrderType="+billOfMaterial.documentOrderType;
        }else{
            if(approvalStatus === "PENDING"){
                params ="documentOrderCode="+billOfMaterial.documentOrderCode;
                params +="&transactionDateDoc="+billOfMaterial.transactionDateDoc;
                params +="&billOfMaterial.code="+billOfMaterialDetail.bomCode;
                params +="&enumBillOfMaterialActivity=UPDATE";
            }else if(approvalStatus === "APPROVED"){
                params ="documentOrderCode="+billOfMaterial.documentOrderCode;
                params +="&transactionDateDoc="+billOfMaterial.transactionDateDoc;
                params +="&billOfMaterial.code="+billOfMaterialDetail.bomCode;
                params +="&enumBillOfMaterialActivity=REVISE";
            }else if(approvalStatus === "REJECTED"){
                params +="&enumBillOfMaterialActivity=REVISE";
            }
        }
        
        pageLoad(url, params, "#tabmnuBILL_OF_MATERIAL");
    
    }
    
</script>

<s:url id="remoteurlBillOfMaterial" action="bill-of-material-data" />
<s:url id="remoteurlBillOfMaterialDetail" action="" />
    <b>BILL OF MATERIAL (ENGINEERING)</b>
    <hr>
    <br class="spacer" />
   
    <div id="billOfMaterialInputSearch" class="content ui-widget">
        <s:form id="frmBillOfMaterialSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Period </td>
                    <td>
                        <sj:datepicker id="billOfMaterial.transactionFirstDate" name="billOfMaterial.transactionFirstDate" size="12" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="billOfMaterial.transactionLastDate" name="billOfMaterial.transactionLastDate" size="12" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr> 
                <tr>
                    <td  align="right">Code</td>
                    <td>
                        <s:textfield id="billOfMaterial.code" name="billOfMaterial.code" size="27" placeholder=" Code"></s:textfield>
                    </td>
                    <td  align="right">Customer Code</td>
                    <td>
                        <s:textfield id="billOfMaterial.customerCode" name="billOfMaterial.customerCode" size="27" placeholder=" Customer Code"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Remark</td>
                    <td>
                        <s:textfield id="billOfMaterial.remarkDoc" name="billOfMaterial.remarkDoc" size="27" placeholder=" Remark"></s:textfield>
                    </td>
                    <td  align="right">Customer Name</td>
                    <td>
                        <s:textfield id="billOfMaterial.customerName" name="billOfMaterial.customerName" size="27" placeholder=" Customer Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td  align="right">Ref No</td>
                    <td>
                        <s:textfield id="billOfMaterial.refNo" name="billOfMaterial.refNo" size="27" placeholder=" Ref No"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Document Type</td>
                    <td>
                        <s:radio id="billOfMaterialSearchDocumentTypeRad" name="billOfMaterialSearchDocumentTypeRad" label="billOfMaterialSearchDocumentTypeRad" list="{'ALL','SO','BO','IM'}"></s:radio>
                        <s:textfield id="billOfMaterial.documentOrderType" name="billOfMaterial.documentOrderType" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnBillOfMaterial_search" button="true">Search</sj:a>
            <br />
            <br />
        </s:form>
    </div>
                  
    <!-- GRID HEADER -->    
    <div id="billOfMaterialGrid">
        <sjg:grid
            id="billOfMaterial_grid"
            dataType="json"
            href="%{remoteurlBillOfMaterial}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterial"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubillOfMaterial').width()"
            onSelectRowTopics="billOfMaterial_grid_onSelect"
        >
            <sjg:gridColumn
                name="documentOrderCode" index="documentOrderCode" key="documentOrderCode" title="Doc No" width="150"
            />
            <sjg:gridColumn
                name="documentOrderType" index="documentOrderType" key="documentOrderType" title="Doc Type" width="120"
            />
            <sjg:gridColumn
                name="transactionDateDoc" index="transactionDateDoc" key="transactionDateDoc" formatter="date"  formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}"  title="Transaction Date" width="150" search="false" align="center"
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
                name="bomStatusNew" index="bomStatusNew" key="bomStatusNew" title="Bom Status" width="100"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
     <!-- GRID Detail -->    
    <div id="billOfMaterialDetailGrid">
        <sjg:grid
            id="billOfMaterialDetail_grid"
            caption="DOCUMENT ITEM DETAIL"
            dataType="json"                    
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialDetail"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            editinline="true"
            width="$('#tabmnubillOfMaterialDetail').width()"
            editurl="%{remoteurlBillOfMaterialDetail}"
            onSelectRowTopics="billOfMaterialDetail_grid_onSelect"
        >
            <sjg:gridColumn
                name="billOfMaterialDetail" index="billOfMaterialDetail" key="billOfMaterialDetail" title=""
                width="200" sortable="true" editable="true" edittype="text" hidden="true"
            />
            <sjg:gridColumn
                name = "bomCode" id="bomCode" index = "bomCode" key = "bomCode" title = "BOM Code" width = "150" sortable="true"
            />
            <sjg:gridColumn
                name = "documentOrderDetailCode" id="documentOrderDetailCode" index = "documentOrderDetailCode" key = "documentOrderDetailCode" title = "Document Detail" width = "150" sortable = "true" 
            />
            <sjg:gridColumn
                name = "itemFinishGoodsCode" id="itemFinishGoodsCode" index = "itemFinishGoodsCode" key = "itemFinishGoodsCode" title = "IFG CODE" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "itemFinishGoodsRemark" id="itemFinishGoodsRemark" index = "itemFinishGoodsRemark" key = "itemFinishGoodsRemark" title = "IFG REMARK" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name="valveTag" index="valveTag" key="valveTag" title="Valve Tag" width="100" sortable = "true"
            />
            <sjg:gridColumn
                name="dataSheet" index="dataSheet" key="dataSheet" title="Data Sheet" width="100" sortable = "true"
            />
            <sjg:gridColumn
                name="description" index="description" key="description" title="Description" width="150" sortable = "true"
            />
            <!--01-->
            <sjg:gridColumn
                name="itemBodyConstructionCode" index="itemBodyConstructionCode" key="itemBodyConstructionCode" title="Body Construction Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyConstructionName" index="itemBodyConstructionName" key="itemBodyConstructionName" title="Body Construction Name" width="150" sortable = "true"
            />
            <!--02-->
            <sjg:gridColumn
                name="itemTypeDesignCode" index="itemTypeDesignCode" key="itemTypeDesignCode" title="Type Design Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemTypeDesignName" index="itemTypeDesignName" key="itemTypeDesignName" title="Type Design" width="150" sortable = "true"
            />
            <!--03-->
            <sjg:gridColumn
                name="itemSeatDesignCode" index="itemSeatDesignCode" key="itemSeatDesignCode" title="Seat Design Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatDesignName" index="itemSeatDesignName" key="itemSeatDesignName" title="Seat Design" width="150" sortable = "true"
            />
            <!--04-->
            <sjg:gridColumn
                name="itemSizeCode" index="itemSizeCode" key="itemSizeCode" title="Size Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSizeName" index="itemSizeName" key="itemSizeName" title="Size" width="150" sortable = "true"
            />
            <!--05-->
            <sjg:gridColumn
                name="itemRatingCode" index="itemRatingCode" key="itemRatingCode" title="Rating Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemRatingName" index="itemRatingName" key="itemRatingName" title="Rating" width="150" sortable = "true"
            />
            <!--06-->
            <sjg:gridColumn
                name="itemBoreCode" index="itemBoreCode" key="itemBoreCode" title="Bore Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoreName" index="itemBoreName" key="itemBoreName" title="Bore" width="150" sortable = "true"
            />
            <!--07-->
            <sjg:gridColumn
                name="itemEndConCode" index="itemEndConCode" key="itemEndConCode" title="End Con Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemEndConName" index="itemEndConName" key="itemEndConName" title="End Con" width="150" sortable = "true"
            />
            <!--08-->
            <sjg:gridColumn
                name="itemBodyCode" index="itemBodyCode" key="itemBodyCode" title="Body Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBodyName" index="itemBodyName" key="itemBodyName" title="Body" width="150" sortable = "true"
            />
            <!--09-->
            <sjg:gridColumn
                name="itemBallCode" index="itemBallCode" key="itemBallCode" title="Ball Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBallName" index="itemBallName" key="itemBallName" title="Ball" width="150" sortable = "true"
            />
            <!--10-->
            <sjg:gridColumn
                name="itemSeatCode" index="itemSeatCode" key="itemSeatCode" title="Seat Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatName" index="itemSeatName" key="itemSeatName" title="Seat" width="150" sortable = "true"
            />
            <!--11-->
            <sjg:gridColumn
                name="itemSeatInsertCode" index="itemSeatInsertCode" key="itemSeatInsertCode" title="Seat Insert Code" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSeatInsertName" index="itemSeatInsertName" key="itemSeatInsertName" title="Seat Insert" width="150" sortable = "true"
            />
            <!--12-->
            <sjg:gridColumn
                name="itemStemCode" index="itemStemCode" key="itemStemCode" title="Stem" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemStemName" index="itemStemName" key="itemStemName" title="Stem" width="150" sortable = "true"
            />
            <!--13-->
            <sjg:gridColumn
                name="itemSealCode" index="itemSealCode" key="itemSealCode" title="Seal" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSealName" index="itemSealName" key="itemSealName" title="Seal" width="150" sortable = "true"
            />
            <!--14-->
            <sjg:gridColumn
                name="itemBoltCode" index="itemBoltCode" key="itemBoltCode" title="Bolt" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBoltName" index="itemBoltName" key="itemBoltName" title="Bolt" width="150" sortable = "true"
            />
            <!--15-->
            <sjg:gridColumn
                name="itemDiscCode" index="itemDiscCode" key="itemDiscCode" title="Disc" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemDiscName" index="itemDiscName" key="itemDiscName" title="Disc" width="150" sortable = "true"
            />
            <!--16-->
            <sjg:gridColumn
                name="itemPlatesCode" index="itemPlatesCode" key="itemPlatesCode" title="Plates" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemPlatesName" index="itemPlatesName" key="itemPlatesName" title="Plates" width="150" sortable = "true"
            />
            <!--17-->
            <sjg:gridColumn
                name="itemShaftCode" index="itemShaftCode" key="itemShaftCode" title="Shaft" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemShaftName" index="itemShaftName" key="itemShaftName" title="Shaft" width="150" sortable = "true"
            />
            <!--18-->
            <sjg:gridColumn
                name="itemSpringCode" index="itemSpringCode" key="itemSpringCode" title="Spring" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemSpringName" index="itemSpringName" key="itemSpringName" title="Spring" width="150" sortable = "true"
            />
            <!--19-->
            <sjg:gridColumn
                name="itemArmPinCode" index="itemArmPinCode" key="itemArmPinCode" title="Arm Pin" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmPinName" index="itemArmPinName" key="itemArmPinName" title="Arm Pin" width="150" sortable = "true"
            />
            <!--20-->
            <sjg:gridColumn
                name="itemBackSeatCode" index="itemBackSeatCode" key="itemBackSeatCode" title="Back Seat" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemBackSeatName" index="itemBackSeatName" key="itemBackSeatName" title="Back Seat" width="150" sortable = "true"
            />
            <!--21-->
            <sjg:gridColumn
                name="itemArmCode" index="itemArmCode" key="itemArmCode" title="Arm" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemArmName" index="itemArmName" key="itemArmName" title="Arm" width="150" sortable = "true"
            />
            <!--22-->
            <sjg:gridColumn
                name="itemHingePinCode" index="itemHingePinCode" key="itemHingePinCode" title="Hinge Pin" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemHingePinName" index="itemHingePinName" key="itemHingePinName" title="Hinge Pin" width="150" sortable = "true"
            />
            <!--23-->
            <sjg:gridColumn
                name="itemStopPinCode" index="itemStopPinCode" key="itemStopPinCode" title="Stop Pin" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemStopPinName" index="itemStopPinName" key="itemStopPinName" title="Stop Pin" width="150" sortable = "true"
            />
            <!--24-->
            <sjg:gridColumn
                name="itemOperatorCode" index="itemOperatorCode" key="itemOperatorCode" title="Operator" width="150" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name="itemOperatorName" index="itemOperatorName" key="itemOperatorName" title="Operator" width="150" sortable = "true"
            />
            <sjg:gridColumn
                name = "quantityIfg" index = "quantityIfg" key = "quantityIfg" title = "Quantity" formatter="number" width = "150" sortable = "true" align="right"
            />
            <sjg:gridColumn
                name="bomStatusNew" index="bomStatusNew" key="bomStatusNew" title="Bom Status" width="100" sortable = "true"
            />
            <sjg:gridColumn
                name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Approval Status" width="100" sortable = "true"
            />
            <sjg:gridColumn
                name="bomDetail" index="bomDetail" title="" width="70" align="centre" sortable = "true"
                editable="true"
                edittype="button"
                editoptions="{onClick:'bomDetail_OnClick()', value:'BOMDetail'}"
            />
            <sjg:gridColumn
                name="print" index="print" title="" width="70" align="centre" sortable = "true"
                editable="true"
                edittype="button"
                editoptions="{onClick:'print_OnClick()', value:'Print'}"
            />
        </sjg:grid >
    </div>
    <br class="spacer" />
        <sjg:grid
            id="billOfMaterialDetailPart_grid"
            caption="BILL OF MATERIAL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listBillOfMaterialPartDetail"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
            width="$('#billOfMaterialDetailParts').width()"
        > 
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
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150"
            />
        </sjg:grid >
    
    

