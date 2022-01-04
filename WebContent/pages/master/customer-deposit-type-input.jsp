
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
    #customerDepositTypeItemDetailInput_grid_pager_center,#customerDepositTypeItemBonusDetailInput_grid_pager_center {
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
    
    var customerDepositTypeChartOfAccount_lastSel = -1, customerDepositTypeChartOfAccount_lastRowId=0;
    
    var txtCustomerDepositTypeCode = $("#customerDepositType\\.code"),
    txtCustomerDepositTypeName = $("#customerDepositType\\.name");
    
    $(document).ready(function(){       
  
        $.subscribe("customerDepositTypeChartOfAccountInput_grid_onSelect", function() {
            
            var selectedRowID = $("#customerDepositTypeChartOfAccountInput_grid").jqGrid("getGridParam", "selrow");
            if(selectedRowID!==customerDepositTypeChartOfAccount_lastSel) {

                $('#customerDepositTypeChartOfAccountInput_grid').jqGrid("saveRow",customerDepositTypeChartOfAccount_lastSel); 
                $('#customerDepositTypeChartOfAccountInput_grid').jqGrid("editRow",selectedRowID,true);            

                customerDepositTypeChartOfAccount_lastSel = selectedRowID;
            }
            else{
                $('#customerDepositTypeChartOfAccountInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
  
        if($("#customerDepositTypeCreateStatus").val() > 0){
            customerDepositTypeUpdateDetail();
        }else{
            customerDepositTypeNewDetail();
        }
    
        $("#btnCustomerDepositTypeSave").click(function(ev) {
            
         
            if(customerDepositTypeChartOfAccount_lastSel !== -1) {
                $("#customerDepositTypeChartOfAccountInput_grid").jqGrid('saveRow',customerDepositTypeChartOfAccount_lastSel); 
            }

            var listCustomerDepositTypeChartOfAccount = new Array(); 
            var ids = jQuery("#customerDepositTypeChartOfAccountInput_grid").jqGrid('getDataIDs');
            
            for(var i=0;i < ids.length;i++){
                var data = $("#customerDepositTypeChartOfAccountInput_grid").jqGrid('getRowData',ids[i]); 
                
                var customerDepositTypeChartOfAccount = {
                    chartOfAccount                  : { code : data.customerDepositTypeChartOfAccountChartOfAccountCode},
                    branch                          : { code : data.customerDepositTypeChartOfAccountBranchCode}
                };
                listCustomerDepositTypeChartOfAccount[i] = customerDepositTypeChartOfAccount;
            }
            
            
            var url = "master/customer-deposit-type-save";
            var params = $("#frmCustomerDepositTypeInput").serialize();
                params+= "&listCustomerDepositTypeChartOfAccountJSON=" + $.toJSON(listCustomerDepositTypeChartOfAccount);
          
            showLoading();

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var dynamicDialog= $('<div id="conformBox">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');

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
                                var url = "master/customer-deposit-type";
                                pageLoad(url, params, "#tabmnuCUSTOMER_DEPOSIT_TYPE");
                            }
                        }]
                });
            });
        });
        
        $("#btnCustomerDepositTypeCancel").click(function(ev){
            var params = "";
            var url = "master/customer-deposit-type";
            pageLoad(url, params, "#tabmnuCUSTOMER_DEPOSIT_TYPE");
        });
        
    });//EOF Ready

    
    function handlers_input_picking_list_sales_order(){
        if(dtpCustomerDepositTypeTransactionDate.val()===""){
            handlersInput(dtpCustomerDepositTypeTransactionDate);
        }else{
            unHandlersInput(dtpCustomerDepositTypeTransactionDate);
        }
    }
   
    
    function customerDepositTypeDetailInputGrid_SearchItem_OnClick(){
        var headerCode = $("#customerDepositType\\.pickingListSalesOrder\\.code").val();

        window.open("./pages/search/search-item-return-by-picking-list-sales-order.jsp?iddoc=customerDepositTypeItemDetail&headerCode="+headerCode+"&type=grid","Search", "scrollbars=1,width=1100, height=500");
    }
    
    function customerDepositTypeNewDetail(){

        var url = "master/branch-get-all";
        var params = "";
        
        $.post(url, params, function (data) {
            var customerDepositTypeChartOfAccount_lastRowId = 0;

            for (var i = 0; i < data.listBranchCustomerDepositTypeTemp.length; i++) {

                $("#customerDepositTypeChartOfAccountInput_grid").jqGrid("addRowData", customerDepositTypeChartOfAccount_lastRowId, data.listBranchCustomerDepositTypeTemp[i]);
                $("#customerDepositTypeChartOfAccountInput_grid").jqGrid('setRowData', customerDepositTypeChartOfAccount_lastRowId, {
                    customerDepositTypeChartOfAccountBranchCode           : data.listBranchCustomerDepositTypeTemp[i].code,
                    customerDepositTypeChartOfAccountBranchName           : data.listBranchCustomerDepositTypeTemp[i].name,
                    customerDepositTypeChartOfAccountSearchChartOfAccount : "...",
                    customerDepositTypeChartOfAccountChartOfAccountCode   : data.listBranchCustomerDepositTypeTemp[i].chartOfAccountCode,
                    customerDepositTypeChartOfAccountChartOfAccountName   : data.listBranchCustomerDepositTypeTemp[i].chartOfAccountName
                });

                customerDepositTypeChartOfAccount_lastRowId++;
            }

        });
    }
    
    function customerDepositTypeUpdateDetail(){
        var url = "master/customer-deposit-type-chart-of-account";
        var params = "code="+txtCustomerDepositTypeCode.val();
        console.log("ok masuk"); 
        console.log(txtCustomerDepositTypeCode.val()); 
        
        $.post(url, params, function (data) {
            var customerDepositTypeChartOfAccount_lastRowId = 0;

            for (var i = 0; i < data.listCustomerDepositTypeChartOfAccount.length; i++) {

                $("#customerDepositTypeChartOfAccountInput_grid").jqGrid("addRowData", customerDepositTypeChartOfAccount_lastRowId, data.listCustomerDepositTypeChartOfAccount[i]);
                $("#customerDepositTypeChartOfAccountInput_grid").jqGrid('setRowData', customerDepositTypeChartOfAccount_lastRowId, {
                    customerDepositTypeChartOfAccountBranchCode           : data.listCustomerDepositTypeChartOfAccount[i].branchCode,
                    customerDepositTypeChartOfAccountBranchName           : data.listCustomerDepositTypeChartOfAccount[i].branchName,
                    customerDepositTypeChartOfAccountSearchChartOfAccount : "...",
                    customerDepositTypeChartOfAccountChartOfAccountCode   : data.listCustomerDepositTypeChartOfAccount[i].chartOfAccountCode,
                    customerDepositTypeChartOfAccountChartOfAccountName   : data.listCustomerDepositTypeChartOfAccount[i].chartOfAccountName
                });

                customerDepositTypeChartOfAccount_lastRowId++;
            }

        });
    }
    
</script>
<b>CUSTOMER DEPOSIT TYPE</b>
<hr>
<s:url id="remotedetailurlCustomerDepositTypeChartOfAccountInput" action="" />

<div id="customerDepositTypeInput" class="content ui-widget">
    <s:form id="frmCustomerDepositTypeInput">
        <div id="div-header-retur-by-dln">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Deposit Type</td>
                    <td>
                        <s:textfield id="customerDepositType.code" name="customerDepositType.code" size="20" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Deposit Name</td>
                    <td>
                        <s:textfield id="customerDepositType.name" name="customerDepositType.name" size="20" readonly="true" ></s:textfield>
                    </td>
                </tr>
                <tr hidden="true">
                    <td align="right">status</td>
                    <td>
                        <s:textfield id="customerDepositTypeCreateStatus" name="customerDepositTypeCreateStatus" size="20" readonly="true" ></s:textfield>
                    </td>
                </tr>
            </table>
        </div>

            <div id="customerDepositTypeChartOfAccountInputGrid">
                <sjg:grid
                    id="customerDepositTypeChartOfAccountInput_grid"
                    caption="CUSTOMER DEPOSIT TYPE COA"
                    dataType="local"                    
                    pager="true"
                    navigator="false"
                    navigatorView="false"
                    navigatorRefresh="false"
                    navigatorDelete="false"
                    navigatorAdd="false"
                    navigatorEdit="false"
                    gridModel="listCustomerDepositTypeChartOfAccountTemp"
                    rowList="10,20,30"
                    rowNum="10000"
                    viewrecords="true"
                    rownumbers="true"
                    shrinkToFit="false"
                    width="800"
                    editinline="true"
                    editurl="%{remotedetailurlCustomerDepositTypeChartOfAccountInput}"
                    onSelectRowTopics="customerDepositTypeChartOfAccountInput_grid_onSelect"
                >
                    <sjg:gridColumn
                        name = "customerDepositTypeChartOfAccount" index = "customerDepositTypeChartOfAccount" key = "customerDepositTypeChartOfAccount" 
                        title = "" width = "150" edittype="text" hidden="true"
                    />
                    <sjg:gridColumn
                        name = "customerDepositTypeChartOfAccountBranchCode" index="customerDepositTypeChartOfAccountBranchCode" key="customerDepositTypeChartOfAccountBranchCode" 
                        title="Branch Code" width="100" edittype="text"
                    />
                    <sjg:gridColumn
                        name = "customerDepositTypeChartOfAccountBranchName" index="customerDepositTypeChartOfAccountBranchName" key="customerDepositTypeChartOfAccountBranchName" 
                        title="Branch Code" width="150" edittype="text"
                    />
                    <sjg:gridColumn
                        name="customerDepositTypeChartOfAccountSearchChartOfAccount" index="customerDepositTypeChartOfAccountSearchChartOfAccount" title="" width="25" align="centre"
                        editable="true" dataType="html" edittype="button"  
                        editoptions="{onClick:'customerDepositTypeChartOfAccountInputGrid_SearchCoa_OnClick()', value:'...'}"
                    />
                    <sjg:gridColumn
                        name = "customerDepositTypeChartOfAccountChartOfAccountCode" index="customerDepositTypeChartOfAccountChartOfAccountCode" key="customerDepositTypeChartOfAccountChartOfAccountCode" 
                        title="Chart Of Account Code" width="200" edittype="text" editable="true" editoptions="{onChange:'customerDepositTypeChartOfAccountInput()'}"
                    />
                    <sjg:gridColumn
                        name = "customerDepositTypeChartOfAccountChartOfAccountName" index="customerDepositTypeChartOfAccountChartOfAccountName" key="customerDepositTypeChartOfAccountChartOfAccountName" 
                        title="Chart Of Account Name" width="250" edittype="text"
                    />
                </sjg:grid >
            </div>
    </s:form>
          
        <table width="100%">
            <tr>
                <td align="left">      
                    <sj:a href="#" id="btnCustomerDepositTypeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCustomerDepositTypeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
        <script>
            
            function customerDepositTypeChartOfAccountInput(){
                var selectedRowID = $("#customerDepositTypeChartOfAccountInput_grid").jqGrid("getGridParam", "selrow");
                var coaCode = $("#" + selectedRowID + "_customerDepositTypeChartOfAccountChartOfAccountCode").val();

                var url = "master/chart-of-account-get-data";
                var params = "chartOfAccount.code=" + coaCode;

                if(coaCode===""){
                    clearRowSelectedItem(selectedRowID);
                    return;
                }

                $.post(url, params, function(result) {
                    var data = (result);
                    if (data.chartOfAccountTemp){
                        $("#" + selectedRowID + "_customerDepositTypeChartOfAccountChartOfAccountCode").val(data.chartOfAccountTemp.code);
                        $("#customerDepositTypeChartOfAccountInput_grid").jqGrid("setCell", selectedRowID,"customerDepositTypeChartOfAccountChartOfAccountName",data.chartOfAccountTemp.name);
                    }
                    else{
                        alertMessage("COA Not Found!",$("#" + selectedRowID + "_customerDepositTypeChartOfAccountChartOfAccountCode"));
                        clearRowSelectedItem(selectedRowID);
                    }
                });
            }
            
            function clearRowSelectedItem(selectedRowID){
                $("#" + selectedRowID + "_customerDepositTypeChartOfAccountChartOfAccountCode").val("");
                $("#customerDepositTypeChartOfAccountInput_grid").jqGrid("setCell", selectedRowID,"customerDepositTypeChartOfAccountChartOfAccountName"," ");
            }
            
            function customerDepositTypeChartOfAccountInputGrid_SearchCoa_OnClick() {
                window.open("./pages/search/search-chart-of-account.jsp?iddoc=customerDepositTypeChartOfAccount&idsubdoc=ChartOfAccount&type=grid","Search", "width=600, height=500");
            }
        </script>
