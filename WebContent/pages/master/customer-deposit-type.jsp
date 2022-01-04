
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #customerDepositTypeDetail_grid_pager_center{
        display: none;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("customerDepositType_grid_onSelect", function(event, data){
            var selectedRowID = $("#customerDepositType_grid").jqGrid("getGridParam", "selrow"); 
            var customerDepositType = $("#customerDepositType_grid").jqGrid("getRowData", selectedRowID);
            
            $("#customerDepositTypeChartOfAccount_grid").jqGrid("setGridParam",{url:"master/customer-deposit-type-data-detail-coa?customerDepositType.code=" + customerDepositType.code});
            $("#customerDepositTypeChartOfAccount_grid").jqGrid("setCaption", "CUSTOMER DEPOSIT TYPE COA : " + customerDepositType.code);
            $("#customerDepositTypeChartOfAccount_grid").trigger("reloadGrid");
        });
        
        $("#btnUpdateChartOfAccount").click(function(ev){
            
            var selectRowId = $("#customerDepositType_grid").jqGrid('getGridParam','selrow');
             
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
                       
            var customerDepositType = $("#customerDepositType_grid").jqGrid("getRowData", selectRowId);           

            var url = "master/customer-deposit-type-input";
            var params = "code="+customerDepositType.code;
            
            pageLoad(url, params, "#tabmnuCUSTOMER_DEPOSIT_TYPE");  
        });
    });
    
   
</script>
    <s:url id="remoteurlCustomerDepositType" action="customer-deposit-type-data" />
    
    <b>CUSTOMER DEPOSIT TYPE</b>
    <hr>
    <br class="spacer" />
           
    <div id="CustomerDepositTypeGrid">
        <sjg:grid
            id="customerDepositType_grid"
            caption="CUSTOMER DEPOSIT TYPE"
            dataType="json"
            href="%{remoteurlCustomerDepositType}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerDepositTypeTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="470"
            onSelectRowTopics="customerDepositType_grid_onSelect"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true" 
            />
            <sjg:gridColumn
                name="name" index="name" key="name" title="Name" width="300" sortable="true" 
            />
        </sjg:grid >
    </div>
       
    <br class="spacer" />
    <table>
        <tr>
            <td align="right">
                <sj:a href="#" id="btnUpdateChartOfAccount" button="true">Update Chart Of Account</sj:a>
            </td>
        </tr>
    </table>
    <br class="spacer" />

    <div id="customerDepositTypeChartOfAccountGrid">
        <sjg:grid
            id="customerDepositTypeChartOfAccount_grid"
            caption="CUSTOMER DEPOSIT TYPE COA"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerDepositTypeChartOfAccount"
            width="680"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "true" hidden="true"
            />
            <sjg:gridColumn
                name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" title = "Branch Code" width = "130" sortable = "true" 
            />
            <sjg:gridColumn
                name = "branchName" id="branchName" index = "branchName" key = "branchName" title = "Branch Name" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Chart Of Account Code" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Chart Of Account Name" width = "200" sortable = "true"
            />
        </sjg:grid >
        <br class="spacer" />
        <br class="spacer" />
    </div>
    

