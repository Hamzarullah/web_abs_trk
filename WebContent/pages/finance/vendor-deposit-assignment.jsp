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
        
        $("#btnVendorDepositAssignment_Process").click(function(ev){
            
            updateRowId = $("#vendorDepositAssignment_grid").jqGrid("getGridParam","selrow");

            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }
            var vendorDepositAssignment = $("#vendorDepositAssignment_grid").jqGrid('getRowData', updateRowId);
            
            var url = "finance/vendor-deposit-assignment-input";
            var params = "vendorDepositAssignment.depositNo="+vendorDepositAssignment.depositNo;
            params += "&vendorDepositAssignment.grandTotalAmount="+vendorDepositAssignment.grandTotalAmount;
            params += "&vendorDepositAssignment.remark="+vendorDepositAssignment.remark;
            params += "&vendorDepositAssignment.transType="+vendorDepositAssignment.transType;
            params += "&vendorDepositAssignment.vendorCode="+vendorDepositAssignment.vendorCode;
            params += "&vendorDepositAssignment.vendorName="+vendorDepositAssignment.vendorName;
//            params += "&vendorDepositAssignment.transactionDate="+vendorDepositAssignment.transactionDate;
          
            pageLoad(url, params, "#tabmnuVENDOR_DEPOSIT_ASSIGNMENT");

        });
        
        $('#btnVendorDepositAssignment_search').click(function(ev) {
            
            formatDateVendorDepositAssignment();
            $("#vendorDepositAssignment_grid").jqGrid("clearGridData");
            $("#vendorDepositAssignment_grid").jqGrid("setGridParam",{url:"finance/vendor-deposit-assignment-data?" + $("#frmVendorDepositAssignmentSearchInput").serialize()});
            $("#vendorDepositAssignment_grid").trigger("reloadGrid");
            formatDateVendorDepositAssignment();
            ev.preventDefault();
        });
    });
    
    function formatDateVendorDepositAssignment(){
        var firstDate=$("#vendorDepositAssignmentSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#vendorDepositAssignmentSearchFirstDate").val(firstDateValue);

        var lastDate=$("#vendorDepositAssignmentSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#vendorDepositAssignmentSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridVendorDepositAssignment() {
        $("#vendorDepositAssignment_grid").trigger("reloadGrid");
    };
</script>

<s:url id="remoteurlVendorDepositAssignment" action="vendor-deposit-assignment-data" />
<b>VENDOR DEPOSIT ASSIGNMENT</b>
<hr>
<div id="vendorDepositAssignmentSearchInput" class="content ui-widget">
    <s:form id="frmVendorDepositAssignmentSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre"><b>Deposit No</b></td>
                <td>
                    <s:textfield id="vendorDepositAssignmentSearchDepositNo" name="vendorDepositAssignmentSearchDepositNo" size="30" placeHolder=" Deposit No"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Remark</b></td>
                <td>
                    <s:textfield id="vendorDepositAssignmentSearchRemark" name="vendorDepositAssignmentSearchRemark" size="30" placeHolder=" Remark"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="vendorDepositAssignmentSearchFirstDate" name="vendorDepositAssignmentSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="vendorDepositAssignmentSearchLastDate" name="vendorDepositAssignmentSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                <td align="right" valign="centre"><b>Ref No</b></td>
                <td>
                    <s:textfield id="vendorDepositAssignmentSearchRefNo" name="vendorDepositAssignmentSearchRefNo" size="30" placeHolder=" Ref No"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnVendorDepositAssignment_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />  
<div id="vendorDepositAssignmentGrid">
    <sjg:grid
        id="vendorDepositAssignment_grid"
        dataType="json"
        caption="VENDOR DEPOSIT ASSIGNMENT"
        href="%{remoteurlVendorDepositAssignment}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorDepositAssignmentTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="vendorDepositAssignment_grid_onSelect"
        width="$('#tabmnuVENDOR_DEPOSIT_ASSIGNMENT').width()"
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
            name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="100" sortable="true"
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
<sj:a href="#" id="btnVendorDepositAssignment_Process" button="true">Assign</sj:a>