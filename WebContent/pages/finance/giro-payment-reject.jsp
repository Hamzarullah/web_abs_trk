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
        
//                radio button function 
        $('input[name="giroPaymentRejectSearchStatusRad"][value="PENDING"]').prop('checked',true);
        $("#giroPaymentRejectSearchStatus").val("Pending");
        
        $('input[name="giroPaymentRejectSearchStatusRad"][value="CLEARED"]').change(function(ev){
            var value="Cleared";
            $("#giroPaymentRejectSearchStatus").val(value);
        });
        $('input[name="giroPaymentRejectSearchStatusRad"][value="REJECTED"]').change(function(ev){
            var value="Rejected";
            $("#giroPaymentRejectSearchStatus").val(value);
        });    
        $('input[name="giroPaymentRejectSearchStatusRad"][value="PENDING"]').change(function(ev){
            var value="Pending";
            $("#giroPaymentRejectSearchStatus").val(value);
        });
        $('input[name="giroPaymentRejectSearchStatusRad"][value="All"]').change(function(ev){
            $("#giroPaymentRejectSearchStatus").val("");
        });
        
//        button proses SEARCH
          var updateRowId = -1;
        
        $("#btnGiroPaymentReject_Process").click(function(ev){
            
            updateRowId = $("#giroPaymentReject_grid").jqGrid("getGridParam","selrow");

            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }
            
            var giroPaymentReject = $("#giroPaymentReject_grid").jqGrid('getRowData', updateRowId);
            var url = "finance/giro-payment-reject-input";
            var params = "giroPaymentRejected.code="+giroPaymentReject.code;
            
            var giroStatus = giroPaymentReject.giroStatus;
            
            if(giroStatus === 'Rejected'){
                alertMessage("Data was Rejected!");
                return;
            }
            
            pageLoad(url, params, "#tabmnuGIRO_PAYMENT_REJECT");

        });
//        end Button proses
        
        $('#btnGiroPaymentReject_search').click(function(ev) {
            formatDateGiroPayment();
            formatDueDateGiroPayment();
            $("#giroPaymentReject_grid").jqGrid("clearGridData");
            $("#giroPaymentReject_grid").jqGrid("setGridParam",{url:"finance/giro-payment-reject-data?" + $("#frmGiroPaymentRejectSearchInput").serialize()});
            $("#giroPaymentReject_grid").trigger("reloadGrid");
            formatDateGiroPayment();
            formatDueDateGiroPayment();
            ev.preventDefault();
        });

        
    });//EOF Ready
    
    function formatDateGiroPayment(){
        var firstDate=$("#giroPaymentRejectSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#giroPaymentRejectSearchFirstDate").val(firstDateValue);

        var lastDate=$("#giroPaymentRejectSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#giroPaymentRejectSearchLastDate").val(lastDateValue);
    }
    
    function formatDueDateGiroPayment(){
        var firstDueDate=$("#giroPaymentRejectSearchFirstDateDueDate").val();
        var firstDueDateValues= firstDueDate.split('/');
        var firstDueDateValue =firstDueDateValues[1]+"/"+firstDueDateValues[0]+"/"+firstDueDateValues[2];
        $("#giroPaymentRejectSearchFirstDateDueDate").val(firstDueDateValue);

        var lastDueDate=$("#giroPaymentRejectSearchLastDateDueDate").val();
        var lastDueDateValues= lastDueDate.split('/');
        var lastDueDateValue =lastDueDateValues[1]+"/"+lastDueDateValues[0]+"/"+lastDueDateValues[2];
        $("#giroPaymentRejectSearchLastDateDueDate").val(lastDueDateValue);
    }
    
    function reloadGridGiroPayment() {
        $("#giroPaymentReject_grid").trigger("reloadGrid");
    };
</script>

<!--Search Navbar-->
<s:url id="remoteurlGiroPaymentReject" action="giro-payment-reject-data" />
<b>GIRO PAYMENT REJECT</b>
<hr>
<div id="giroPaymentRejectSearchInput" class="content ui-widget">
    <s:form id="frmGiroPaymentRejectSearchInput">
        <table cellpadding="2" cellspacing="2">
            
            <tr>
                <td align="right" valign="centre"><b>GRP No</b></td>
                <td>
                    <s:textfield id="giroPaymentRejectSearchCode" name="giroPaymentRejectSearchCode" size="20" placeHolder=" Grp No"></s:textfield>
                </td>
              
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="giroPaymentRejectSearchFirstDate" name="giroPaymentRejectSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroPaymentRejectSearchLastDate" name="giroPaymentRejectSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Code</b></td>
                <td>
                    <s:textfield id="giroPaymentRejectSearchBankCode" name="giroPaymentRejectSearchBankCode" size="15" placeHolder=" Bank Code"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Remark</b></td>
                <td>
                    <s:textfield id="giroPaymentRejectSearchRemark" name="giroPaymentRejectSearchRemark" size="15" placeHolder=" Remark"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right" valign="centre"><b>Giro No</b></td>
                <td>
                    <s:textfield id="giroPaymentRejectSearchGiroNo" name="giroPaymentRejectSearchGiroNo" size="20" placeHolder=" Giro No"></s:textfield>
                </td>
              
                <td align="right"><B>Due Date *</B></td>
                <td>
                    <sj:datepicker id="giroPaymentRejectSearchFirstDateDueDate" name="giroPaymentRejectSearchFirstDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroPaymentRejectSearchLastDateDueDate" name="giroPaymentRejectSearchLastDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Name</b></td>
                <td>
                    <s:textfield id="giroPaymentRejectSearchBankName" name="giroPaymentRejectSearchBankName" size="15" placeHolder=" Bank Name"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Ref No</b></td>
                <td>
                    <s:textfield id="giroPaymentRejectSearchRefNo" name="giroPaymentRejectSearchRefNo" size="15" placeHolder=" Ref No"></s:textfield>
                </td>
            </tr>
            <br class="spacer" />
            <tr>
                <td align="right"></td>
                <td align="right"></td>
                <td align="right"></td>
                <td>
                <s:radio id="giroPaymentRejectSearchStatusRad" name="giroPaymentRejectSearchStatusRad" list="{'PENDING','CLEARED','REJECTED','All'}"></s:radio>
                <s:textfield id="giroPaymentRejectSearchStatus" name="giroPaymentRejectSearchStatus" value="REQUEST" size="20" cssStyle="display:none"></s:textfield>
                </td>                   
            </tr>
            
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGiroPaymentReject_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
<!--End Search Navbar-->

<br class="spacer" />

<!--Grid-->       

<div id="giroPaymentRejectGrid">
    <sjg:grid
        id="giroPaymentReject_grid"
        dataType="json"
        caption="GIRO PAYMENT REJECT"
        href="%{remoteurlGiroPaymentReject}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGiroPaymentRejectTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="giroPaymentReject_grid_onSelect"
        width="$('#tabmnuGIRO_PAYMENT_REJECT').width()"
    >
        <sjg:gridColumn
            name="branchCode" index="branchCode" key="branchCode" title="Branch Code" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="branchName" index="branchName" key="branchName" title="Branch" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="Grp No" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="150" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            align="center"
        />
        <sjg:gridColumn
            name="dueDate" index="dueDate" key="dueDate" 
            title="Due Date" width="150" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            align="center" hidden="true" 
        />
        <sjg:gridColumn
            name="giroNo" index="giroNo" key="giroNo" title="Giro No" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="giroStatus" index="giroStatus" key="giroStatus" title="Giro Status" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="rejectedReasonCode" index="rejectedReasonCode" key="rejectedReasonCode" title="Rejected Reason" width="180" sortable="true"
        />
        <sjg:gridColumn
            name="rejectedRemark" index="rejectedRemark" key="rejectedRemark" title="Rejected Remark" width="180" sortable="true"
        />
        <sjg:gridColumn
            name="bankCode" index="bankCode" key="bankCode" title="Bank Code" width="75" sortable="true"
        />
        <sjg:gridColumn
            name="bankName" index="bankName" key="bankName" title="Bank Name" width="75" sortable="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="amount" index="amount" key="amount" title="Amount" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="paymentTo" index="paymentTo" key="paymentTo" title="Payment To" width="150" sortable="true" hidden="true"
        />
    </sjg:grid >
</div>

<!--End Grid-->

<sj:a href="#" id="btnGiroPaymentReject_Process" button="true">Reject</sj:a>
<sj:a href="#" id="btnGiroPaymentReject_Exit" button="true">Exit</sj:a>