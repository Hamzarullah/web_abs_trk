
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #vendorDepositTypeItemDetailInput_grid_pager_center,#vendorDepositTypeItemBonusDetailInput_grid_pager_center {
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgAddRow{
        color: red;
    }
</style>

<script type="text/javascript">
    
    var vendorDepositTypeChartOfAccount_lastSel = -1, vendorDepositTypeChartOfAccount_lastRowId=0;
    
    var txtVendorDepositTypeCode = $("#vendorDepositType\\.code"),
    txtVendorDepositTypeName = $("#vendorDepositType\\.name");
    
    $(document).ready(function(){       
  
        $.subscribe("vendorDepositTypeChartOfAccountInput_grid_onSelect", function() {
            
            var selectedRowID = $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==vendorDepositTypeChartOfAccount_lastSel) {

                $('#vendorDepositTypeChartOfAccountInput_grid').jqGrid("saveRow",vendorDepositTypeChartOfAccount_lastSel); 
                $('#vendorDepositTypeChartOfAccountInput_grid').jqGrid("editRow",selectedRowID,true);            

                vendorDepositTypeChartOfAccount_lastSel = selectedRowID;
            }
            else{
                $('#vendorDepositTypeChartOfAccountInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
  
        if($("#vendorDepositTypeCreateStatus").val() > 0){
            vendorDepositTypeUpdateDetail();
        }else{
            vendorDepositTypeNewDetail();
        }
    
        $("#btnVendorDepositTypeSave").click(function(ev) {
            
         
            if(vendorDepositTypeChartOfAccount_lastSel !== -1) {
                $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid('saveRow',vendorDepositTypeChartOfAccount_lastSel); 
            }

            var listVendorDepositTypeChartOfAccount = new Array(); 
            var ids = jQuery("#vendorDepositTypeChartOfAccountInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){ 
                var data = $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid('getRowData',ids[i]); 
                
                var vendorDepositTypeChartOfAccount = {
                    chartOfAccount                  : { code : data.vendorDepositTypeChartOfAccountChartOfAccountCode},
                    branch                          : { code : data.vendorDepositTypeChartOfAccountBranchCode}
                };
                listVendorDepositTypeChartOfAccount[i] = vendorDepositTypeChartOfAccount;
            }
            
            
            var url = "master/vendor-deposit-type-save";
            var params = $("#frmVendorDepositTypeInput").serialize();
                params+= "&listVendorDepositTypeChartOfAccountJSON=" + $.toJSON(listVendorDepositTypeChartOfAccount);
          
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var dynamicDialog= $('<div id="conformBox">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>'+data.message+'</div>');

                dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 500,
                    resizable: false,
                    buttons : 
                        [{
                            text : "Ok",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "master/vendor-deposit-type";
                                pageLoad(url, params, "#tabmnuVENDOR_DEPOSIT_TYPE");
                            }
                        }]
                });
            });
        });
        
        $("#btnVendorDepositTypeCancel").click(function(ev){
            var params = "";
            var url = "master/vendor-deposit-type";
            pageLoad(url, params, "#tabmnuVENDOR_DEPOSIT_TYPE");
        });
        
    });//EOF Ready

    
    function handlers_input_picking_list_sales_order(){
        if(dtpVendorDepositTypeTransactionDate.val()===""){
            handlersInput(dtpVendorDepositTypeTransactionDate);
        }else{
            unHandlersInput(dtpVendorDepositTypeTransactionDate);
        }
    }
   
    
    function vendorDepositTypeDetailInputGrid_SearchItem_OnClick(){
        var headerCode = $("#vendorDepositType\\.pickingListSalesOrder\\.code").val();

        window.open("./pages/search/search-item-return-by-picking-list-sales-order.jsp?iddoc=vendorDepositTypeItemDetail&headerCode="+headerCode+"&type=grid","Search", "scrollbars=1,width=1100, height=500");
    }
    
    function vendorDepositTypeNewDetail(){

        var url = "master/branch-get-all";
        var params = "";
        
        $.post(url, params, function (data) {
            var vendorDepositTypeChartOfAccount_lastRowId = 0;

            for (var i = 0; i < data.listBranchCustomerDepositTypeTemp.length; i++) {

                $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid("addRowData", vendorDepositTypeChartOfAccount_lastRowId, data.listBranchCustomerDepositTypeTemp[i]);
                $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid('setRowData', vendorDepositTypeChartOfAccount_lastRowId, {
                    vendorDepositTypeChartOfAccountBranchCode           : data.listBranchCustomerDepositTypeTemp[i].code,
                    vendorDepositTypeChartOfAccountBranchName           : data.listBranchCustomerDepositTypeTemp[i].name,
                    vendorDepositTypeChartOfAccountSearchChartOfAccount : "...",
                    vendorDepositTypeChartOfAccountChartOfAccountCode   : data.listBranchCustomerDepositTypeTemp[i].chartOfAccountCode,
                    vendorDepositTypeChartOfAccountChartOfAccountName   : data.listBranchCustomerDepositTypeTemp[i].chartOfAccountName
                });

                vendorDepositTypeChartOfAccount_lastRowId++;
            }

        });
    }
    
    function vendorDepositTypeUpdateDetail(){
        var url = "master/vendor-deposit-type-chart-of-account";
        var params = "code="+txtVendorDepositTypeCode.val();
        console.log("ok masuk"); 
        console.log(txtVendorDepositTypeCode.val()); 
        
        $.post(url, params, function (data) {
            var vendorDepositTypeChartOfAccount_lastRowId = 0;

            for (var i = 0; i < data.listVendorDepositTypeChartOfAccount.length; i++) {

                $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid("addRowData", vendorDepositTypeChartOfAccount_lastRowId, data.listVendorDepositTypeChartOfAccount[i]);
                $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid('setRowData', vendorDepositTypeChartOfAccount_lastRowId, {
                    vendorDepositTypeChartOfAccountBranchCode           : data.listVendorDepositTypeChartOfAccount[i].branchCode,
                    vendorDepositTypeChartOfAccountBranchName           : data.listVendorDepositTypeChartOfAccount[i].branchName,
                    vendorDepositTypeChartOfAccountSearchChartOfAccount : "...",
                    vendorDepositTypeChartOfAccountChartOfAccountCode   : data.listVendorDepositTypeChartOfAccount[i].chartOfAccountCode,
                    vendorDepositTypeChartOfAccountChartOfAccountName   : data.listVendorDepositTypeChartOfAccount[i].chartOfAccountName
                });

                vendorDepositTypeChartOfAccount_lastRowId++;
            }

        });
    }
    
</script>
<b>VENDOR DEPOSIT TYPE</b>
<hr>
<s:url id="remotedetailurlVendorDepositTypeChartOfAccountInput" action="" />

<div id="vendorDepositTypeInput" class="content ui-widget">
    <s:form id="frmVendorDepositTypeInput">
        <div id="div-header-retur-by-dln">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Deposit Type</td>
                    <td>
                        <s:textfield id="vendorDepositType.code" name="vendorDepositType.code" size="20" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Deposit Name</td>
                    <td>
                        <s:textfield id="vendorDepositType.name" name="vendorDepositType.name" size="20" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td align="right">status</td>
                    <td>
                        <s:textfield id="vendorDepositTypeCreateStatus" name="vendorDepositTypeCreateStatus" size="20" readonly="true" ></s:textfield>
                    </td>
                </tr>
            </table>
        </div>

            <div id="vendorDepositTypeChartOfAccountInputGrid">
                <sjg:grid
                    id="vendorDepositTypeChartOfAccountInput_grid"
                    caption="VENDOR DEPOSIT TYPE COA"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listVendorDepositTypeChartOfAccountTemp"
                    rowList="10,20,30"
                    rowNum="10000"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="800"
                    editinline="true"
                    editurl="%{remotedetailurlVendorDepositTypeChartOfAccountInput}"
                    onSelectRowTopics="vendorDepositTypeChartOfAccountInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "vendorDepositTypeChartOfAccount" index = "vendorDepositTypeChartOfAccount" key = "vendorDepositTypeChartOfAccount" 
                        title = "" width = "150" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "vendorDepositTypeChartOfAccountBranchCode" index="vendorDepositTypeChartOfAccountBranchCode" key="vendorDepositTypeChartOfAccountBranchCode" 
                        title="Branch Code" width="100" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "vendorDepositTypeChartOfAccountBranchName" index="vendorDepositTypeChartOfAccountBranchName" key="vendorDepositTypeChartOfAccountBranchName" 
                        title="Branch Code" width="150" edittype="text"
                    />
                    <sjg:gridColumn
                        name="vendorDepositTypeChartOfAccountSearchChartOfAccount" index="vendorDepositTypeChartOfAccountSearchChartOfAccount" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"  
                        editoptions="{onClick:'vendorDepositTypeChartOfAccountInputGrid_SearchCoa_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name = "vendorDepositTypeChartOfAccountChartOfAccountCode" index="vendorDepositTypeChartOfAccountChartOfAccountCode" key="vendorDepositTypeChartOfAccountChartOfAccountCode" 
                        title="Chart Of Account Code" width="200" edittype="text" editable="true" editoptions="{onChange:'vendorDepositTypeChartOfAccountInput()'}"
                    />
                    <sjg:gridColumn
                        name = "vendorDepositTypeChartOfAccountChartOfAccountName" index="vendorDepositTypeChartOfAccountChartOfAccountName" key="vendorDepositTypeChartOfAccountChartOfAccountName" 
                        title="Chart Of Account Name" width="250" edittype="text"
                    />
                </sjg:grid >
            </div>
    </s:form>
          
        <table width="100%">
            <tr>
                <td align="left">      
                    <sj:a href="#" id="btnVendorDepositTypeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnVendorDepositTypeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        <script>
            
            function vendorDepositTypeChartOfAccountInput(){
                var selectedRowID = $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid("getGridParam", "selrow");
                var coaCode = $("#" + selectedRowID + "_vendorDepositTypeChartOfAccountChartOfAccountCode").val();

                var url = "master/chart-of-account-get-data";
                var params = "chartOfAccount.code=" + coaCode;

                if(coaCode===""){
                    clearRowSelectedItem(selectedRowID);
                    return;
                }

                $.post(url, params, function(result) {
                    var data = (result);
                    if (data.chartOfAccountTemp){
                        $("#" + selectedRowID + "_vendorDepositTypeChartOfAccountChartOfAccountCode").val(data.chartOfAccountTemp.code);
                        $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid("setCell", selectedRowID,"vendorDepositTypeChartOfAccountChartOfAccountName",data.chartOfAccountTemp.name);
                    }
                    else{
                        alertMessage("COA Not Found!",$("#" + selectedRowID + "_vendorDepositTypeChartOfAccountChartOfAccountCode"));
                        clearRowSelectedItem(selectedRowID);
                    }
                });
            }
            
            function clearRowSelectedItem(selectedRowID){
                $("#" + selectedRowID + "_vendorDepositTypeChartOfAccountChartOfAccountCode").val("");
                $("#vendorDepositTypeChartOfAccountInput_grid").jqGrid("setCell", selectedRowID,"vendorDepositTypeChartOfAccountChartOfAccountName"," ");
            }
            
            function vendorDepositTypeChartOfAccountInputGrid_SearchCoa_OnClick() {
                window.open("./pages/search/search-chart-of-account.jsp?iddoc=vendorDepositTypeChartOfAccount&idsubdoc=ChartOfAccount&type=grid","Search", "width=600, height=500");
            }
        </script>
