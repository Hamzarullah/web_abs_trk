<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    
    $(document).ready(function(){
        
        hoverButton();
        var updateRowId = -1;
        
        $("#btnCustomerDepositAssignment_Process").click(function(ev){
            
            updateRowId = $("#customerDepositAssignment_grid").jqGrid("getGridParam","selrow");

            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }
            var customerDepositAssignment = $("#customerDepositAssignment_grid").jqGrid('getRowData', updateRowId);
            var url = "finance/customer-deposit-assignment-input";
            var params = "customerDepositAssignment.depositNo="+customerDepositAssignment.depositNo;
            params += "&customerDepositAssignment.grandTotalAmount="+customerDepositAssignment.grandTotalAmount;
            params += "&customerDepositAssignment.remark="+customerDepositAssignment.remark;
            params += "&customerDepositAssignment.transType="+customerDepositAssignment.transType;
            params += "&customerDepositAssignment.customerCode="+customerDepositAssignment.customerCode;
            params += "&customerDepositAssignment.customerName="+customerDepositAssignment.customerName;
//            params += "&customerDepositAssignment.transactionDate="+customerDepositAssignment.transactionDate;
                
            pageLoad(url, params, "#tabmnuCUSTOMER_DEPOSIT_ASSIGNMENT");

        });
        
        $('#btnCustomerDepositAssignment_search').click(function(ev) {
            
            formatDateCustomerDepositAssignment();
            $("#customerDepositAssignment_grid").jqGrid("clearGridData");
            $("#customerDepositAssignment_grid").jqGrid("setGridParam",{url:"finance/customer-deposit-assignment-data?" + $("#frmCustomerDepositAssignmentSearchInput").serialize()});
            $("#customerDepositAssignment_grid").trigger("reloadGrid");
            formatDateCustomerDepositAssignment();
            ev.preventDefault();
        });
    });
    
    function formatDateCustomerDepositAssignment(){
        var firstDate=$("#customerDepositAssignmentSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#customerDepositAssignmentSearchFirstDate").val(firstDateValue);

        var lastDate=$("#customerDepositAssignmentSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#customerDepositAssignmentSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridCustomerDepositAssignment() {
        $("#customerDepositAssignment_grid").trigger("reloadGrid");
    };
</script>

<s:url id="remoteurlCustomerDepositAssignment" action="customer-deposit-assignment-data" />
<b>CUSTOMER DEPOSIT ASSIGNMENT</b>
<hr>
<div id="customerDepositAssignmentSearchInput" class="content ui-widget">
    <s:form id="frmCustomerDepositAssignmentSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre"><b>Deposit No</b></td>
                <td>
                    <s:textfield id="customerDepositAssignmentSearchDepositNo" name="customerDepositAssignmentSearchDepositNo" size="30" placeHolder=" Deposit No"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Remark</b></td>
                <td>
                    <s:textfield id="customerDepositAssignmentSearchRemark" name="customerDepositAssignmentSearchRemark" size="30" placeHolder=" Remark"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="customerDepositAssignmentSearchFirstDate" name="customerDepositAssignmentSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="customerDepositAssignmentSearchLastDate" name="customerDepositAssignmentSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                <td align="right" valign="centre"><b>Ref No</b></td>
                <td>
                    <s:textfield id="customerDepositAssignmentSearchRefNo" name="customerDepositAssignmentSearchRefNo" size="30" placeHolder=" Ref No"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnCustomerDepositAssignment_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />  
<div id="customerDepositAssignmentGrid">
    <sjg:grid
        id="customerDepositAssignment_grid"
        dataType="json"
        caption="CUSTOMER DEPOSIT ASSIGNMENT"
        href="%{remoteurlCustomerDepositAssignment}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCustomerDepositAssignmentTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="customerDepositAssignment_grid_onSelect"
        width="$('#tabmnuCUSTOMER_DEPOSIT_ASSIGNMENT').width()"
    >

        <sjg:gridColumn
            name="depositNo" index="depositNo" key="depositNo" title="Deposit No" width="170" sortable="true"
        />
        <sjg:gridColumn
            name="transType" index="transType" key="transType" title="Transaksi Type" width="170" sortable="true"
        />
        <sjg:gridColumn
            name="branchCode" index="branchCode" key="branchCode" title="Branch" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="150" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            align="center"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="75" sortable="true"
        />
        <sjg:gridColumn
            name="exchangeRate" index="exchangeRate" key="exchangeRate" title="Exhange Rate" width="100" sortable="true"
            formatter="number" formatoptions= "{ thousandsSeparator:','}" align="right"
        />
        <sjg:gridColumn
            name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="customerName" index="customerName" key="customerName" title="Customer Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="RefNo" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" title="Grand Total Amount" width="150" sortable="true"
        />
    </sjg:grid >
</div>
<sj:a href="#" id="btnCustomerDepositAssignment_Process" button="true">Assign</sj:a>