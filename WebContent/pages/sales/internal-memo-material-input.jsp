
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
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>
<script type="text/javascript">
    var internalMemoMaterialDetailLastRowId = 0, internalMemoMaterialDetailLastSel = -1;
    var                                    
        txtInternalMemoMaterialCode = $("#internalMemoMaterial\\.code"),
        dtpInternalMemoMaterialTransactionDate = $("#internalMemoMaterial\\.transactionDate"),
        txtInternalMemoMaterialBranchCode = $("#internalMemoMaterial\\.branch\\.code"),
        txtInternalMemoMaterialBranchName = $("#internalMemoMaterial\\.branch\\.name"),
        txtInternalMemoMaterialDivisionCode = $("#internalMemoMaterial\\.division\\.code"),
        txtInternalMemoMaterialDivisionName = $("#internalMemoMaterial\\.division\\.name"),
        txtInternalMemoMaterialDivisionDepartmentCode = $("#internalMemoMaterial\\.division\\.department\\.code"),
        txtInternalMemoMaterialDivisionDepartmentName = $("#internalMemoMaterial\\.division\\.department\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedIMM=false;
        hoverButton();
        
    //Set Default View
        $("#btnUnConfirmInternalMemoMaterial").css("display", "none");
        $("#btnIMMSearchItemMaterial").css("display", "none");
        $('#internalMemoMaterialDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmInternalMemoMaterial").click(function(ev) {
            handlers_input_purchase_request_non_so();
            
            if(txtInternalMemoMaterialBranchCode.val()===''){
                alertMessage("Branch Can't be Empty");
                return;
            }  
         
            flagIsConfirmedIMM=true;
            if($("#enumInternalMemoMaterialActivity").val()==="UPDATE"){ 
                loadDataInternalMemoMaterialDetail();
            }
           
            $("#btnUnConfirmInternalMemoMaterial").css("display", "block");
            $("#btnIMMSearchItemMaterial").css("display", "block");
            $("#btnConfirmInternalMemoMaterial").css("display", "none");   
            $('#headerInternalMemoMaterialInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#internalMemoMaterialDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmInternalMemoMaterial").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#internalMemoMaterialDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                $("#btnUnConfirmInternalMemoMaterial").css("display", "none");
                $("#btnIMMSearchItemMaterial").css("display", "none");
                $("#btnConfirmInternalMemoMaterial").css("display", "block");
                $('#headerInternalMemoMaterialInput').unblock();
                $('#internalMemoMaterialDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                flagIsConfirmedIMM=false;
                return;
            }

            dynamicDialog.dialog({
                title : "Confirmation:",
                closeOnEscape: false,
                modal : true,
                width: 500,
                resizable: false,
                buttons : 
                    [{
                        text : "Yes",
                        click : function() {

                            $(this).dialog("close");
                            flagIsConfirmedIMM=false;
                            $("#internalMemoMaterialDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmInternalMemoMaterial").css("display", "none");
                            $("#btnIMMSearchItemMaterial").css("display", "none");
                            $("#btnConfirmInternalMemoMaterial").css("display", "block");
                            $('#headerInternalMemoMaterialInput').unblock();
                            $('#internalMemoMaterialDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                        }
                    },
                    {
                        text : "No",
                        click : function() {

                            $(this).dialog("close");

                        }
                    }]
            });
        });
        
        $('#btnInternalMemoMaterialSave').click(function(ev) {
                        
            if(!flagIsConfirmedIMM){
                alertMessage("Please Confirm!",$("#btnConfirmInternalMemoMaterial"),200);
                return;
            }
            
            //Prepare Save Detail Grid
            if(internalMemoMaterialDetailLastSel !== -1) {
                $('#internalMemoMaterialDetailInput_grid').jqGrid("saveRow",internalMemoMaterialDetailLastSel);
            }
            
            var listInternalMemoMaterialDetail = new Array();
            var ids = jQuery("#internalMemoMaterialDetailInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#internalMemoMaterialDetailInput_grid").jqGrid('getRowData',ids[i]);

                var internalMemoMaterialDetail = {
                    itemMaterial       : { code : data.internalMemoMaterialDetailItemMaterialCode },
                    quantity           : data.internalMemoMaterialDetailQuantity,
                    remark             : data.internalMemoMaterialDetailRemark
                };
                
                listInternalMemoMaterialDetail[i] = internalMemoMaterialDetail;
            }
            //END Prepare Save Detail Grid

            formatDateInternalMemoMaterial();
            var url="sales/internal-memo-material-save";
            var params = $("#frmInternalMemoMaterialInput").serialize();
                params += "&listInternalMemoMaterialDetailJSON=" + $.toJSON(listInternalMemoMaterialDetail); 
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateInternalMemoMaterial(); 
                    alert(data.errorMessage);
                    return;
                }
                
                var dynamicDialog= $('<div id="conformBox">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>'+data.message+'<br/>Do You Want Input Other One?</div>');

                dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 500,
                    resizable: false,

                    buttons : 
                        [{
                            text : "Yes",
                            click : function() {

                                $(this).dialog("close");
                                var url = "sales/internal-memo-material";
                                var param = "";
                                pageLoad(url, param, "#tabmnuINTERNAL_MEMO_MATERIAL");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "sales/internal-memo-material";
                                var params = "";
                                pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL");
                            }
                        }]
                });
            });
            
        });
               
        $('#btnInternalMemoMaterialCancel').click(function(ev) {
            var url = "sales/internal-memo-material";
            var params = "";
            pageLoad(url, params, "#tabmnuINTERNAL_MEMO_MATERIAL"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("InternalMemoMaterialDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#internalMemoMaterialDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==internalMemoMaterialDetailLastSel) {
                $('#internalMemoMaterialDetailInput_grid').jqGrid("saveRow",internalMemoMaterialDetailLastSel); 
                $('#internalMemoMaterialDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                internalMemoMaterialDetailLastSel=selectedRowID;
            }
            else{
                $('#internalMemoMaterialDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnIMMSearchItemMaterial').click(function(ev) {
            var ids = jQuery("#internalMemoMaterialDetailInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-item-material-multiple.jsp?iddoc=internalMemoMaterialDetail&type=grid&rowLast="+ids.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function loadDataInternalMemoMaterialDetail() {
        
        var url = "sales/internal-memo-material-detail-data";
        var params = "internalMemoMaterial.code=" + txtInternalMemoMaterialCode.val();
        
        $.getJSON(url, params, function(data) {
            internalMemoMaterialDetailLastRowId = 0;

            for (var i=0; i<data.listInternalMemoMaterialDetail.length; i++) {
                internalMemoMaterialDetailLastRowId++;
                $("#internalMemoMaterialDetailInput_grid").jqGrid("addRowData", internalMemoMaterialDetailLastRowId, data.listInternalMemoMaterialDetail[i]);
                $("#internalMemoMaterialDetailInput_grid").jqGrid('setRowData',internalMemoMaterialDetailLastRowId,{
                    internalMemoMaterialDetailItemDelete                   : "delete",
                    internalMemoMaterialDetailItemMaterialSearch            : "...",
                    internalMemoMaterialDetailItemMaterialCode              : data.listInternalMemoMaterialDetail[i].itemMaterialCode,
                    internalMemoMaterialDetailItemMaterialName              : data.listInternalMemoMaterialDetail[i].itemMaterialName,
                    internalMemoMaterialDetailQuantity                      : data.listInternalMemoMaterialDetail[i].quantity,
                    internalMemoMaterialDetailOnHandStock                   : data.listInternalMemoMaterialDetail[i].onHandStock,
                    internalMemoMaterialDetailUnitOfMeasureCode             : data.listInternalMemoMaterialDetail[i].unitOfMeasureCode,
                    internalMemoMaterialDetailUnitOfMeasureName             : data.listInternalMemoMaterialDetail[i].unitOfMeasureName,
                    internalMemoMaterialDetailRemark                        : data.listInternalMemoMaterialDetail[i].remark
                });
            }
        });
    }
    
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#internalMemoMaterialDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#internalMemoMaterialDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#internalMemoMaterialDetailInput_grid").jqGrid('setRowData',lastRowId,{
                    internalMemoMaterialDetailItemDelete                      : defRow.internalMemoMaterialDetailItemDelete,
                    internalMemoMaterialDetailItemMaterialCode                : defRow.internalMemoMaterialDetailItemMaterialCode,
                    internalMemoMaterialDetailItemMaterialName                : defRow.internalMemoMaterialDetailItemMaterialName,
                    internalMemoMaterialDetailOnHandStock                     : defRow.internalMemoMaterialDetailOnHandStock,
                    internalMemoMaterialDetailUnitOfMeasureName               : defRow.internalMemoMaterialDetailUnitOfMeasureName
            });
            
        setHeightGridPurchaseOrderNonSoDetail();
 }
    
    // function Grid Detail
    function setHeightGridPurchaseOrderNonSoDetail(){
        var ids = jQuery("#internalMemoMaterialDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#internalMemoMaterialDetailInput_grid"+" tr").eq(1).height();
            $("#internalMemoMaterialDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#internalMemoMaterialDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function internalMemoMaterialDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#internalMemoMaterialDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#internalMemoMaterialDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridPurchaseOrderNonSoDetail();
    }
    
    // END function Grid Detail
    
    function internalMemoMaterialTransactionDateOnChange(){
        
        var internalMemoMaterialTransactionDateSplit=$("#internalMemoMaterial\\.transactionDate").val().split('/');
        var internalMemoMaterialTransactionDate=internalMemoMaterialTransactionDateSplit[1]+"/"+internalMemoMaterialTransactionDateSplit[0]+"/"+internalMemoMaterialTransactionDateSplit[2];
        $("#internalMemoMaterial\\.internalMemoMaterialTransactionDate").val(internalMemoMaterialTransactionDate);
        
    }
    
    function formatDateInternalMemoMaterial(){
        var transactionDate=formatDate(dtpInternalMemoMaterialTransactionDate.val());
        dtpInternalMemoMaterialTransactionDate.val(transactionDate);  
    }
    
    function handlers_input_purchase_request_non_so(){
        
        if(txtInternalMemoMaterialBranchCode.val()===""){
            handlersInput(txtInternalMemoMaterialBranchCode);
        }else{
            unHandlersInput(txtInternalMemoMaterialBranchCode);
        }
     
    }
    
</script>
<s:url id="remotedetailurlInternalMemoMaterialDetailInput" action="" />

<b>INTERNAL MEMO MATERIAL</b>
<hr>
<br class="spacer" />

<div id="internalMemoMaterialInput" class="content ui-widget">
    <s:form id="frmInternalMemoMaterialInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerInternalMemoMaterialInput">
            <tr>
                <td align="right" width="100px"><b>IMM No *</b></td>
                <td><s:textfield id="internalMemoMaterial.code" name="internalMemoMaterial.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="internalMemoMaterial.transactionDate" name="internalMemoMaterial.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" onchange="internalMemoMaterialTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                    <sj:datepicker id="internalMemoMaterial.internalMemoMaterialTransactionDate" name="internalMemoMaterial.internalMemoMaterialTransactionDate" displayFormat="mm/dd/yy" required="true" cssClass="required" title=" " showOn="focus" disabled="true" size="20" cssStyle="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#internalMemoMaterial_btnBranch').click(function(ev) {
                            window.open("./pages/search/search-branch.jsp?iddoc=internalMemoMaterial&idsubdoc=branch","Search", "width=600, height=500");
                        });
                    
                        txtInternalMemoMaterialBranchCode.change(function(ev) {

                            if(txtInternalMemoMaterialBranchCode.val()===""){
                                txtInternalMemoMaterialBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtInternalMemoMaterialBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtInternalMemoMaterialBranchCode.val(data.branchTemp.code);
                                    txtInternalMemoMaterialBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtInternalMemoMaterialBranchCode);
                                    txtInternalMemoMaterialBranchCode.val("");
                                    txtInternalMemoMaterialBranchName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="internalMemoMaterial.branch.code" name="internalMemoMaterial.branch.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="internalMemoMaterial_btnBranch" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="internalMemoMaterial.branch.name" name="internalMemoMaterial.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Division *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#internalMemoMaterial_btnDivision').click(function(ev) {
                            window.open("./pages/search/search-division.jsp?iddoc=internalMemoMaterial&idsubdoc=division","Search", "width=600, height=500");
                        });
                        
                        txtInternalMemoMaterialDivisionCode.change(function(ev) {

                            if(txtInternalMemoMaterialDivisionCode.val()===""){
                                txtInternalMemoMaterialDivisionName.val("");
                                txtInternalMemoMaterialDivisionDepartmentCode.val("");
                                txtInternalMemoMaterialDivisionDepartmentName.val("");
                                return;
                            }
                            var url = "master/division-get-with-user-auth";
                            var params = "division.code=" + txtInternalMemoMaterialDivisionCode.val();
                                params += "&division.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.divisionTemp){
                                    txtInternalMemoMaterialDivisionCode.val(data.divisionTemp.code);
                                    txtInternalMemoMaterialDivisionName.val(data.divisionTemp.name);
                                    txtInternalMemoMaterialDivisionDepartmentCode.val(data.divisionTemp.departmentCode);
                                    txtInternalMemoMaterialDivisionDepartmentName.val(data.divisionTemp.departmentName);
                                }
                                else{
                                    alertMessage("Division Not Found!",txtInternalMemoMaterialDivisionCode);
                                    txtInternalMemoMaterialDivisionCode.val("");
                                    txtInternalMemoMaterialDivisionName.val("");
                                    txtInternalMemoMaterialDivisionDepartmentCode.val("");
                                    txtInternalMemoMaterialDivisionDepartmentName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="internalMemoMaterial.division.code" name="internalMemoMaterial.division.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="internalMemoMaterial_btnDivision" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="internalMemoMaterial.division.name" name="internalMemoMaterial.division.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Department</td>
                <td colspan="2">
                    <s:textfield id="internalMemoMaterial.division.department.code" name="internalMemoMaterial.division.department.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="internalMemoMaterial.division.department.name" name="internalMemoMaterial.division.department.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id=".requestBy" name="internalMemoMaterial.requestBy" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="internalMemoMaterial.refNo" name="internalMemoMaterial.refNo" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="internalMemoMaterial.remark" name="internalMemoMaterial.remark" cols="53" rows="3" ></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="internalMemoMaterial.createdBy" name="internalMemoMaterial.createdBy"></s:textfield>
                    <s:textfield id="enumInternalMemoMaterialActivity" name="enumInternalMemoMaterialActivity"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <br class="spacer" />        
        <table>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnConfirmInternalMemoMaterial" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmInternalMemoMaterial" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnIMMSearchItemMaterial" button="true" style="width: 200px">Search Item Material</sj:a>
                </td>
            </tr>
    </table>      
                
        <div id="id-internal-memo-material-detail">
            <div id="internalMemoMaterialDetailInputGrid">
                <sjg:grid
                    id="internalMemoMaterialDetailInput_grid"
                    caption="INTERNAL MEMO MATERIAL DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listInternalMemoMaterialDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuInternalMemoMaterialDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlInternalMemoMaterialDetailInput}"
                    onSelectRowTopics="InternalMemoMaterialDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="internalMemoMaterialDetail" index="internalMemoMaterialDetail" key="internalMemoMaterialDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialDetailItemDelete" index="internalMemoMaterialDetailItemDelete" title="" width="50" align="center"
                        editable="true"
                        edittype="button"
                        editoptions="{onClick:'internalMemoMaterialDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialDetailItemMaterialCode" index = "internalMemoMaterialDetailItemMaterialCode" key = "internalMemoMaterialDetailItemMaterialCode" title = "Item Code" width = "120" editable="false"
                        editoptions="{onchange:'internalMemoMaterialDetailInputGrid_SearchItem_OnChange()'}"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialDetailItemMaterialName" index = "internalMemoMaterialDetailItemMaterialName" key = "internalMemoMaterialDetailItemMaterialName" title = "Item Name" width = "150"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialDetailRemark" index="internalMemoMaterialDetailRemark" key="internalMemoMaterialDetailRemark" title="Remark" width="150"  editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialDetailOnHandStock" index="internalMemoMaterialDetailOnHandStock" key="internalMemoMaterialDetailOnHandStock" title="On Hand Stock" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="internalMemoMaterialDetailQuantity" index="internalMemoMaterialDetailQuantity" key="internalMemoMaterialDetailQuantity" title="IMM Quantity" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialDetailUnitOfMeasureCode" index = "internalMemoMaterialDetailUnitOfMeasureCode" key = "internalMemoMaterialDetailUnitOfMeasureCode" title = "UOM" width = "100"
                    />
                    <sjg:gridColumn
                        name = "internalMemoMaterialDetailUnitOfMeasureName" index = "internalMemoMaterialDetailUnitOfMeasureName" key = "internalMemoMaterialDetailUnitOfMeasureName" title = "UOM" width = "100"
                        hidden="true"
                    />
                </sjg:grid >      
                <br class="spacer" />
            </div>
        </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnInternalMemoMaterialSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnInternalMemoMaterialCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
        </table>      
    </s:form>
</div>
    

