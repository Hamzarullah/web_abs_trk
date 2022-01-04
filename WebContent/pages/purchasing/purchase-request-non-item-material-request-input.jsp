
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
    var purchaseRequestNonItemMaterialRequestDetailLastRowId = 0, purchaseRequestNonItemMaterialRequestDetailLastSel = -1;
    var                                    
        txtPurchaseRequestNonItemMaterialRequestCode = $("#purchaseRequestNonItemMaterialRequest\\.code"),
        dtpPurchaseRequestNonItemMaterialRequestTransactionDate = $("#purchaseRequestNonItemMaterialRequest\\.transactionDate"),
        txtPurchaseRequestNonItemMaterialRequestBranchCode = $("#purchaseRequestNonItemMaterialRequest\\.branch\\.code"),
        txtPurchaseRequestNonItemMaterialRequestBranchName = $("#purchaseRequestNonItemMaterialRequest\\.branch\\.name"),
        txtPurchaseRequestNonItemMaterialRequestDivisionCode = $("#purchaseRequestNonItemMaterialRequest\\.division\\.code"),
        txtPurchaseRequestNonItemMaterialRequestDivisionName = $("#purchaseRequestNonItemMaterialRequest\\.division\\.name"),
        txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentCode = $("#purchaseRequestNonItemMaterialRequest\\.division\\.department\\.code"),
        txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentName = $("#purchaseRequestNonItemMaterialRequest\\.division\\.department\\.name");
        
    $(document).ready(function(){
        flagIsConfirmedPRQNonSo=false;
        hoverButton();
        
    //Set Default View
        $("#btnUnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "none");
        $("#btnPRQNIMRSearchItemMaterial").css("display", "none");
        $('#purchaseRequestNonItemMaterialRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmPurchaseRequestNonItemMaterialRequest").click(function(ev) {
            handlers_input_purchase_request_non_so();
            
            if(txtPurchaseRequestNonItemMaterialRequestBranchCode.val()===''){
                alertMessage("Branch Can't be Empty");
                return;
            }  
            
            if(txtPurchaseRequestNonItemMaterialRequestDivisionCode.val()===''){
                alertMessage("Division Can't be Empty");
                return;
            }  
         
            flagIsConfirmedPRQNonSo=true;
            if($("#purchaseRequestNonItemMaterialRequestUpdateMode").val()==="true"){ 
                loadDataPurchaseRequestNonItemMaterialRequestDetail();
            }
           
            $("#btnUnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "block");
            $("#btnPRQNIMRSearchItemMaterial").css("display", "block");
            $("#btnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "none");   
            $('#headerPurchaseRequestNonItemMaterialRequestInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#purchaseRequestNonItemMaterialRequestDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmPurchaseRequestNonItemMaterialRequest").click(function(ev) {
            var dynamicDialog= $('<div id="conformBox">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure to UnConfirm this Detail?</div>');

            var rows = jQuery("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getGridParam', 'records');
            if(rows<1){
                $("#btnUnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "none");
                $("#btnPRQNIMRSearchItemMaterial").css("display", "none");
                $("#btnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "block");
                $('#headerPurchaseRequestNonItemMaterialRequestInput').unblock();
                $('#purchaseRequestNonItemMaterialRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                flagIsConfirmedPRQNonSo=false;
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
                            flagIsConfirmedPRQNonSo=false;
                            $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('clearGridData');
                            $("#btnUnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "none");
                            $("#btnPRQNIMRSearchItemMaterial").css("display", "none");
                            $("#btnConfirmPurchaseRequestNonItemMaterialRequest").css("display", "block");
                            $('#headerPurchaseRequestNonItemMaterialRequestInput').unblock();
                            $('#purchaseRequestNonItemMaterialRequestDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $('#btnPurchaseRequestNonItemMaterialRequestSave').click(function(ev) {
                        
            if(!flagIsConfirmedPRQNonSo){
                alertMessage("Please Confirm!",$("#btnConfirmPurchaseRequestNonItemMaterialRequest"),200);
                return;
            }
            
            //Prepare Save Detail Grid
            if(purchaseRequestNonItemMaterialRequestDetailLastSel !== -1) {
                $('#purchaseRequestNonItemMaterialRequestDetailInput_grid').jqGrid("saveRow",purchaseRequestNonItemMaterialRequestDetailLastSel);
            }
            
            var listPurchaseRequestNonItemMaterialRequestDetail = new Array();
            var ids = jQuery("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getRowData',ids[i]);

                var purchaseRequestNonItemMaterialRequestDetail = {
                    itemMaterial       : { code : data.purchaseRequestNonItemMaterialRequestDetailItemMaterialCode },
                    quantity           : data.purchaseRequestNonItemMaterialRequestDetailQuantity,
                    remark             : data.purchaseRequestNonItemMaterialRequestDetailRemark
                };
                
                listPurchaseRequestNonItemMaterialRequestDetail[i] = purchaseRequestNonItemMaterialRequestDetail;
            }
            //END Prepare Save Detail Grid

            formatDatePurchaseRequestNonItemMaterialRequest();
            var url="purchasing/purchase-request-non-item-material-request-save";
            var params = $("#frmPurchaseRequestNonItemMaterialRequestInput ").serialize();
                params += "&listPurchaseRequestNonItemMaterialRequestDetailJSON=" + $.toJSON(listPurchaseRequestNonItemMaterialRequestDetail); 
            showLoading();
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDatePurchaseRequestNonItemMaterialRequest(); 
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
                                var url = "purchasing/purchase-request-non-item-material-request";
                                var param = "";
                                pageLoad(url, param, "#tabmnuPURCHASE_REQUEST_NON_IMR");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                var url = "purchasing/purchase-request-non-item-material-request";
                                var params = "";
                                pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR");
                            }
                        }]
                });
            });
            
        });
               
        $('#btnPurchaseRequestNonItemMaterialRequestCancel').click(function(ev) {
            var url = "purchasing/purchase-request-non-item-material-request";
            var params = "";
            pageLoad(url, params, "#tabmnuPURCHASE_REQUEST_NON_IMR"); 
        });
        
    // Grid Detail button Function
    
        $.subscribe("PurchaseRequestNonItemMaterialRequestDetailInput_grid_onSelect", function() {
            var selectedRowID = $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==purchaseRequestNonItemMaterialRequestDetailLastSel) {
                $('#purchaseRequestNonItemMaterialRequestDetailInput_grid').jqGrid("saveRow",purchaseRequestNonItemMaterialRequestDetailLastSel); 
                $('#purchaseRequestNonItemMaterialRequestDetailInput_grid').jqGrid("editRow",selectedRowID,true);            
                purchaseRequestNonItemMaterialRequestDetailLastSel=selectedRowID;
            }
            else{
                $('#purchaseRequestNonItemMaterialRequestDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
//        $('#btnPurchaseRequestNonItemMaterialRequestAddDetail').click(function(ev) {
//            var totalCount = parseFloat(removeCommas($("#txtPurchaseRequestNonItemMaterialRequestAddDetail").val()));
//            for(var i=0; i<totalCount; i++){
//                var defRow = {
//                    purchaseRequestNonItemMaterialRequestDetailItemDelete   :"delete",
//                    purchaseRequestNonItemMaterialRequestDetailItemMaterialSearch   :"..."
//                };
//                purchaseRequestNonItemMaterialRequestDetailLastRowId++;
//                $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid("addRowData", purchaseRequestNonItemMaterialRequestDetailLastRowId, defRow);
//                ev.preventDefault();
//            }
//            $("#txtPurchaseRequestNonItemMaterialRequestAddDetail").val("1");
//            setHeightGridPurchaseOrderNonSoDetail();
//        });   
        
        $('#btnPRQNIMRSearchItemMaterial').click(function(ev) {
            var ids = jQuery("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs');
            window.open("./pages/search/search-item-material-multiple.jsp?iddoc=purchaseRequestNonItemMaterialRequestDetail&type=grid&rowLast="+ids.length,"Search", "scrollbars=1,width=600, height=500");
        });
        
    }); //EOF Ready
    
    function loadDataPurchaseRequestNonItemMaterialRequestDetail() {
        
        var url = "purchasing/purchase-request-non-item-material-request-detail-data";
        var params = "purchaseRequestNonItemMaterialRequest.code=" + txtPurchaseRequestNonItemMaterialRequestCode.val();
        
        $.getJSON(url, params, function(data) {
            purchaseRequestNonItemMaterialRequestDetailLastRowId = 0;

            for (var i=0; i<data.listPurchaseRequestNonItemMaterialRequestDetail.length; i++) {
                purchaseRequestNonItemMaterialRequestDetailLastRowId++;
                $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid("addRowData", purchaseRequestNonItemMaterialRequestDetailLastRowId, data.listPurchaseRequestNonItemMaterialRequestDetail[i]);
                $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('setRowData',purchaseRequestNonItemMaterialRequestDetailLastRowId,{
                    purchaseRequestNonItemMaterialRequestDetailItemDelete                   : "delete",
                    purchaseRequestNonItemMaterialRequestDetailItemMaterialSearch            : "...",
                    purchaseRequestNonItemMaterialRequestDetailItemMaterialCode              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialCode,
                    purchaseRequestNonItemMaterialRequestDetailItemMaterialName              : data.listPurchaseRequestNonItemMaterialRequestDetail[i].itemMaterialName,
                    purchaseRequestNonItemMaterialRequestDetailQuantity                      : data.listPurchaseRequestNonItemMaterialRequestDetail[i].quantity,
                    purchaseRequestNonItemMaterialRequestDetailOnHandStock                   : data.listPurchaseRequestNonItemMaterialRequestDetail[i].onHandStock,
                    purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureCode             : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureCode,
                    purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureName             : data.listPurchaseRequestNonItemMaterialRequestDetail[i].unitOfMeasureName,
                    purchaseRequestNonItemMaterialRequestDetailRemark                        : data.listPurchaseRequestNonItemMaterialRequestDetail[i].remark
                });
            }
        });
    }
    
    function addRowDataMultiSelected(lastRowId,defRow){
        
        var ids = jQuery("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs');
        var lastRow=[0];
        
        for(var i=0;i<ids.length;i++){
          var comp=(ids[i]-lastRow[0])>0;
             if(comp){
                    lastRow =[];
                    lastRow.push(ids[i]);
                 }
        }
        
            $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid("addRowData", lastRowId, defRow);
            $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('setRowData',lastRowId,{
                    purchaseRequestNonItemMaterialRequestDetailItemDelete                      : defRow.purchaseRequestNonItemMaterialRequestDetailItemDelete,
                    purchaseRequestNonItemMaterialRequestDetailItemMaterialCode                : defRow.purchaseRequestNonItemMaterialRequestDetailItemMaterialCode,
                    purchaseRequestNonItemMaterialRequestDetailItemMaterialName                : defRow.purchaseRequestNonItemMaterialRequestDetailItemMaterialName,
                    purchaseRequestNonItemMaterialRequestDetailOnHandStock                     : defRow.purchaseRequestNonItemMaterialRequestDetailOnHandStock,
                    purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureName               : defRow.purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureName
            });
            
        setHeightGridPurchaseOrderNonSoDetail();
 }
    
    // function Grid Detail
    function setHeightGridPurchaseOrderNonSoDetail(){
        var ids = jQuery("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#purchaseRequestNonItemMaterialRequestDetailInput_grid"+" tr").eq(1).height();
            $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('setGridHeight', "100%", true);
        }
    }
    
    function purchaseRequestNonItemMaterialRequestDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('getGridParam','selrow');
            if (selectDetailRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
        $("#purchaseRequestNonItemMaterialRequestDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        setHeightGridPurchaseOrderNonSoDetail();
    }
    
    // END function Grid Detail
    
    function purchaseRequestNonItemMaterialRequestTransactionDateOnChange(){
        
        var purchaseRequestNonItemMaterialRequestTransactionDateSplit=$("#purchaseRequestNonItemMaterialRequest\\.transactionDate").val().split('/');
        var purchaseRequestNonItemMaterialRequestTransactionDate=purchaseRequestNonItemMaterialRequestTransactionDateSplit[1]+"/"+purchaseRequestNonItemMaterialRequestTransactionDateSplit[0]+"/"+purchaseRequestNonItemMaterialRequestTransactionDateSplit[2];
        $("#purchaseRequestNonItemMaterialRequest\\.purchaseRequestNonItemMaterialRequestTransactionDate").val(purchaseRequestNonItemMaterialRequestTransactionDate);
        
    }
    
    function formatDatePurchaseRequestNonItemMaterialRequest(){
        var transactionDate=formatDate(dtpPurchaseRequestNonItemMaterialRequestTransactionDate.val());
        dtpPurchaseRequestNonItemMaterialRequestTransactionDate.val(transactionDate);  
    }
    
    function handlers_input_purchase_request_non_so(){
        
        if(txtPurchaseRequestNonItemMaterialRequestBranchCode.val()===""){
            handlersInput(txtPurchaseRequestNonItemMaterialRequestBranchCode);
        }else{
            unHandlersInput(txtPurchaseRequestNonItemMaterialRequestBranchCode);
        }
        
        if(txtPurchaseRequestNonItemMaterialRequestDivisionCode.val()===""){
            handlersInput(txtPurchaseRequestNonItemMaterialRequestDivisionCode);
        }else{
            unHandlersInput(txtPurchaseRequestNonItemMaterialRequestDivisionCode);
        }
     
    }
    
</script>
<s:url id="remotedetailurlPurchaseRequestNonItemMaterialRequestDetailInput" action="" />

<b>PURCHASE REQUEST NON ITEM MATERIAL REQUEST</b>
<hr>
<br class="spacer" />

<div id="purchaseRequestNonItemMaterialRequestInput" class="content ui-widget">
    <s:form id="frmPurchaseRequestNonItemMaterialRequestInput">
        <table cellpadding="2" cellspacing="2" width="100%" id="headerPurchaseRequestNonItemMaterialRequestInput">
            <tr>
                <td align="right" width="100px"><b>PRQ-Non IMR No *</b></td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequest.code" name="purchaseRequestNonItemMaterialRequest.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td></td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequest.documentType" name="purchaseRequestNonItemMaterialRequest.documentType" title="" maxLength="45" value="NON_IMR" hidden="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" width="110px"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="purchaseRequestNonItemMaterialRequest.transactionDate" name="purchaseRequestNonItemMaterialRequest.transactionDate" displayFormat="dd/mm/yy" required="true" cssClass="required" title=" " showOn="focus" size="15" onchange="purchaseRequestNonItemMaterialRequestTransactionDateOnChange()" changeMonth="true" changeYear="true"></sj:datepicker>
                    <sj:datepicker id="purchaseRequestNonItemMaterialRequest.purchaseRequestNonItemMaterialRequestTransactionDate" name="purchaseRequestNonItemMaterialRequest.purchaseRequestNonItemMaterialRequestTransactionDate" displayFormat="mm/dd/yy" required="true" cssClass="required" title=" " showOn="focus" disabled="true" size="20" cssStyle="display:none"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Branch *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#purchaseRequestNonItemMaterialRequest_btnBranch').click(function(ev) {
                            window.open("./pages/search/search-branch.jsp?iddoc=purchaseRequestNonItemMaterialRequest&idsubdoc=branch","Search", "width=600, height=500");
                        });
                    
                        txtPurchaseRequestNonItemMaterialRequestBranchCode.change(function(ev) {

                            if(txtPurchaseRequestNonItemMaterialRequestBranchCode.val()===""){
                                txtPurchaseRequestNonItemMaterialRequestBranchName.val("");
                                return;
                            }
                            var url = "master/branch-get";
                            var params = "branch.code=" + txtPurchaseRequestNonItemMaterialRequestBranchCode.val();
                                params += "&branch.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.branchTemp){
                                    txtPurchaseRequestNonItemMaterialRequestBranchCode.val(data.branchTemp.code);
                                    txtPurchaseRequestNonItemMaterialRequestBranchName.val(data.branchTemp.name);
                                }
                                else{
                                    alertMessage("Branch Not Found!",txtPurchaseRequestNonItemMaterialRequestBranchCode);
                                    txtPurchaseRequestNonItemMaterialRequestBranchCode.val("");
                                    txtPurchaseRequestNonItemMaterialRequestBranchName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.branch.code" name="purchaseRequestNonItemMaterialRequest.branch.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="purchaseRequestNonItemMaterialRequest_btnBranch" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.branch.name" name="purchaseRequestNonItemMaterialRequest.branch.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Division *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                    
                        $('#purchaseRequestNonItemMaterialRequest_btnDivision').click(function(ev) {
                            window.open("./pages/search/search-division.jsp?iddoc=purchaseRequestNonItemMaterialRequest&idsubdoc=division","Search", "width=600, height=500");
                        });
                        
                        txtPurchaseRequestNonItemMaterialRequestDivisionCode.change(function(ev) {

                            if(txtPurchaseRequestNonItemMaterialRequestDivisionCode.val()===""){
                                txtPurchaseRequestNonItemMaterialRequestDivisionName.val("");
                                txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentCode.val("");
                                txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentName.val("");
                                return;
                            }
                            var url = "master/division-get";
                            var params = "division.code=" + txtPurchaseRequestNonItemMaterialRequestDivisionCode.val();
                                params += "&division.activeStatus=TRUE";

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.divisionTemp){
                                    txtPurchaseRequestNonItemMaterialRequestDivisionCode.val(data.divisionTemp.code);
                                    txtPurchaseRequestNonItemMaterialRequestDivisionName.val(data.divisionTemp.name);
                                    txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentCode.val(data.divisionTemp.departmentCode);
                                    txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentName.val(data.divisionTemp.departmentName);
                                }
                                else{
                                    alertMessage("Division Not Found!",txtPurchaseRequestNonItemMaterialRequestDivisionCode);
                                    txtPurchaseRequestNonItemMaterialRequestDivisionCode.val("");
                                    txtPurchaseRequestNonItemMaterialRequestDivisionName.val("");
                                    txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentCode.val("");
                                    txtPurchaseRequestNonItemMaterialRequestDivisionDepartmentName.val("");
                                }
                            });
                        });
                    
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.division.code" name="purchaseRequestNonItemMaterialRequest.division.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                        <sj:a id="purchaseRequestNonItemMaterialRequest_btnDivision" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="purchaseRequestNonItemMaterialRequest.division.name" name="purchaseRequestNonItemMaterialRequest.division.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Department</td>
                <td colspan="2">
                    <s:textfield id="purchaseRequestNonItemMaterialRequest.division.department.code" name="purchaseRequestNonItemMaterialRequest.division.department.code" size="15" readonly="true"></s:textfield>
                    <s:textfield id="purchaseRequestNonItemMaterialRequest.division.department.name" name="purchaseRequestNonItemMaterialRequest.division.department.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Request By</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequest.requestBy" name="purchaseRequestNonItemMaterialRequest.requestBy" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td><s:textfield id="purchaseRequestNonItemMaterialRequest.refNo" name="purchaseRequestNonItemMaterialRequest.refNo" title="*" required="true" cssClass="required" size="20"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td><s:textarea id="purchaseRequestNonItemMaterialRequest.remark" name="purchaseRequestNonItemMaterialRequest.remark" cols="53" rows="3" ></s:textarea></td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="purchaseRequestNonItemMaterialRequest.createdBy" name="purchaseRequestNonItemMaterialRequest.createdBy"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <br class="spacer" />        
        <table>
            <tr>
                <td></td>
                <td>
                    <sj:a href="#" id="btnConfirmPurchaseRequestNonItemMaterialRequest" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmPurchaseRequestNonItemMaterialRequest" button="true">UnConfirm</sj:a>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnPRQNIMRSearchItemMaterial" button="true" style="width: 200px">Search Item Material</sj:a>
                </td>
            </tr>
    </table>      
                
        <div id="id-purchase-request-non-item-material-request-detail">
            <div id="purchaseRequestNonItemMaterialRequestDetailInputGrid">
                <sjg:grid
                    id="purchaseRequestNonItemMaterialRequestDetailInput_grid"
                    caption="PURCHASE REQUEST NON IMR DETAIL"
                    dataType="local"
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listPurchaseRequestNonItemMaterialRequestDetail"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="$('#tabmnuPurchaseRequestNonItemMaterialRequestDetail').width()"
                    editinline="true"
                    editurl="%{remotedetailurlPurchaseRequestNonItemMaterialRequestDetailInput}"
                    onSelectRowTopics="PurchaseRequestNonItemMaterialRequestDetailInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestDetail" index="purchaseRequestNonItemMaterialRequestDetail" key="purchaseRequestNonItemMaterialRequestDetail" title="" editable="true" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestDetailItemDelete" index="purchaseRequestNonItemMaterialRequestDetailItemDelete" title="" width="50" align="center"
                        editable="true"
                        edittype="button"
                        editoptions="{onClick:'purchaseRequestNonItemMaterialRequestDetailInputGrid_Delete_OnClick()', value:'delete'}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestDetailItemMaterialCode" index = "purchaseRequestNonItemMaterialRequestDetailItemMaterialCode" key = "purchaseRequestNonItemMaterialRequestDetailItemMaterialCode" title = "Item Code" width = "120" editable="false"
                        editoptions="{onchange:'purchaseRequestNonItemMaterialRequestDetailInputGrid_SearchItem_OnChange()'}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestDetailItemMaterialName" index = "purchaseRequestNonItemMaterialRequestDetailItemMaterialName" key = "purchaseRequestNonItemMaterialRequestDetailItemMaterialName" title = "Item Name" width = "150"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestDetailRemark" index="purchaseRequestNonItemMaterialRequestDetailRemark" key="purchaseRequestNonItemMaterialRequestDetailRemark" title="Remark" width="150"  editable="true" edittype="text"
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestDetailOnHandStock" index="purchaseRequestNonItemMaterialRequestDetailOnHandStock" key="purchaseRequestNonItemMaterialRequestDetailOnHandStock" title="On Hand Stock" 
                        width="150" align="right" editable="false" edittype="text"
                        formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                    />
                    <sjg:gridColumn
                        name="purchaseRequestNonItemMaterialRequestDetailQuantity" index="purchaseRequestNonItemMaterialRequestDetailQuantity" key="purchaseRequestNonItemMaterialRequestDetailQuantity" title="PR Quantity" 
                        width="150" align="right" editable="true" edittype="text" 
                        formatter="number" formatoptions="{thousandsSeparator:',',decimalPlaces:2}"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureCode" index = "purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureCode" key = "purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureCode" title = "UOM" width = "100"
                        hidden="true"
                    />
                    <sjg:gridColumn
                        name = "purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureName" index = "purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureName" key = "purchaseRequestNonItemMaterialRequestDetailUnitOfMeasureName" title = "UOM" width = "100"
                    />
                </sjg:grid >      
            
                <br class="spacer" />
<!--                <table>
                    <tr>
                        <td align="right">
                            <%--<s:textfield id="txtPurchaseRequestNonItemMaterialRequestAddDetail"  name="txtPurchaseRequestNonItemMaterialRequestAddDetail" style="text-align: right;width: 40px;" value="1"></s:textfield>--%>
                        </td>
                        <td>
                            <%--<sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestAddDetail" button="true" style="width: 50px">Add</sj:a>--%>
                        </td>
                    </tr> 
                </table>-->
                <br class="spacer" />
            </div>
        </div>
                
        <table>
            <tr>
                <td colspan="2">
                    <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestSave" button="true" style="width: 60px">Save</sj:a>
                    <sj:a href="#" id="btnPurchaseRequestNonItemMaterialRequestCancel" button="true" style="width: 60px">Cancel</sj:a>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="purchaseRequestNonItemMaterialRequestUpdateMode" name="purchaseRequestNonItemMaterialRequestUpdateMode"></s:textfield>
                </td>
            </tr>
        </table>      
                
                
                
                
                
    </s:form>
</div>
    

