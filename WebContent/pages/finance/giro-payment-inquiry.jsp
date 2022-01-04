<%-- 
    Document   : giro-payment-inquiry
    Created on : Dec 10, 2019, 1:15:00 PM
    Author     : Rayis
--%>
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
        $('input[name="giroPaymentInquirySearchStatusRad"][value="PENDING"]').prop('checked',true);
        $("#giroPaymentInquirySearchStatus").val("Pending");
        
        $('input[name="giroPaymentInquirySearchStatusRad"][value="CLEARED"]').change(function(ev){
            var value="Cleared";
            $("#giroPaymentInquirySearchStatus").val(value);
        });
        
        $('input[name="giroPaymentInquirySearchStatusRad"][value="REJECTED"]').change(function(ev){
            var value="Rejected";
            $("#giroPaymentInquirySearchStatus").val(value);
        });
        $('input[name="giroPaymentInquirySearchStatusRad"][value="All"]').change(function(ev){
            $("#giroPaymentInquirySearchStatus").val("");
        });
        
//        button proses SEARCH
          var updateRowId = -1;
        
        $("#btnGiroPaymentInquiry_Process").click(function(ev){
            
            updateRowId = $("#giroPaymentInquiry_grid").jqGrid("getGridParam","selrow");

            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }
            
            var giroPaymentInquiry = $("#giroPaymentInquiry_grid").jqGrid('getRowData', updateRowId);
            var url = "finance/giro-payment-inquiry-input";
            var params = "giroPaymentInquiry.code="+giroPaymentInquiry.code;
            
            pageLoad(url, params, "#tabmnuGIRO_PAYMENT_INQUIRY");

        });
//        end Button proses
        
        $('#btnGiroPaymentInquiry_search').click(function(ev) {
            formatDateGiroPayment();
            formatDueDateGiroPayment();
            $("#giroPaymentInquiry_grid").jqGrid("clearGridData");
            $("#giroPaymentInquiry_grid").jqGrid("setGridParam",{url:"finance/giro-payment-inquiry-data?" + $("#frmGiroPaymentInquirySearchInput").serialize()});
            $("#giroPaymentInquiry_grid").trigger("reloadGrid");
            formatDateGiroPayment();
            formatDueDateGiroPayment();
            ev.preventDefault();
        });

        
    });//EOF Ready
    
    function formatDateGiroPayment(){
        var firstDate=$("#giroPaymentInquirySearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#giroPaymentInquirySearchFirstDate").val(firstDateValue);

        var lastDate=$("#giroPaymentInquirySearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#giroPaymentInquirySearchLastDate").val(lastDateValue);
    }
    
    function formatDueDateGiroPayment(){
        var firstDueDate=$("#giroPaymentInquirySearchFirstDateDueDate").val();
        var firstDueDateValues= firstDueDate.split('/');
        var firstDueDateValue =firstDueDateValues[1]+"/"+firstDueDateValues[0]+"/"+firstDueDateValues[2];
        $("#giroPaymentInquirySearchFirstDateDueDate").val(firstDueDateValue);

        var lastDueDate=$("#giroPaymentInquirySearchLastDateDueDate").val();
        var lastDueDateValues= lastDueDate.split('/');
        var lastDueDateValue =lastDueDateValues[1]+"/"+lastDueDateValues[0]+"/"+lastDueDateValues[2];
        $("#giroPaymentInquirySearchLastDateDueDate").val(lastDueDateValue);
    }
    
    function reloadGridGiroPayment() {
        $("#giroPaymentInquiry_grid").trigger("reloadGrid");
    };
</script>

<!--Search Navbar-->
<s:url id="remoteurlGiroPaymentInquiry" action="giro-payment-inquiry-data" />
<b>GIRO PAYMENT INQUIRY</b>
<hr>
<div id="giroPaymentInquirySearchInput" class="content ui-widget">
    <s:form id="frmGiroPaymentInquirySearchInput">
        <table cellpadding="2" cellspacing="2">
            
            <tr>
                <td align="right" valign="centre"><b>GRP No</b></td>
                <td>
                    <s:textfield id="giroPaymentInquirySearchCode" name="giroPaymentInquirySearchCode" size="20" placeHolder=" Grp No"></s:textfield>
                </td>
              
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="giroPaymentInquirySearchFirstDate" name="giroPaymentInquirySearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroPaymentInquirySearchLastDate" name="giroPaymentInquirySearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Code</b></td>
                <td>
                    <s:textfield id="giroPaymentInquirySearchBankCode" name="giroPaymentInquirySearchBankCode" size="15" placeHolder=" Bank Code"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Remark</b></td>
                <td>
                    <s:textfield id="giroPaymentInquirySearchRemark" name="giroPaymentInquirySearchRemark" size="15" placeHolder=" Remark"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right" valign="centre"><b>Giro No</b></td>
                <td>
                    <s:textfield id="giroPaymentInquirySearchGiroNo" name="giroPaymentInquirySearchGiroNo" size="20" placeHolder=" Giro No"></s:textfield>
                </td>
              
                <td align="right"><B>Due Date *</B></td>
                <td>
                    <sj:datepicker id="giroPaymentInquirySearchFirstDateDueDate" name="giroPaymentInquirySearchFirstDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroPaymentInquirySearchLastDateDueDate" name="giroPaymentInquirySearchLastDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Name</b></td>
                <td>
                    <s:textfield id="giroPaymentInquirySearchBankName" name="giroPaymentInquirySearchBankName" size="15" placeHolder=" Bank Name"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Ref No</b></td>
                <td>
                    <s:textfield id="giroPaymentInquirySearchRefNo" name="giroPaymentInquirySearchRefNo" size="15" placeHolder=" Ref No"></s:textfield>
                </td>
            </tr>
            <br class="spacer" />
            <tr>
                <td align="right"></td>
                <td align="right"></td>
                <td align="right"></td>
                <td>
                <s:radio id="giroPaymentInquirySearchStatusRad" name="giroPaymentInquirySearchStatusRad" list="{'PENDING','CLEARED','REJECTED','All'}"></s:radio>
                <s:textfield id="giroPaymentInquirySearchStatus" name="giroPaymentInquirySearchStatus" value="REQUEST" size="20" cssStyle="display:none"></s:textfield>
                </td>                   
            </tr>
            
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGiroPaymentInquiry_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
<!--End Search Navbar-->

<br class="spacer" />

<!--Grid-->       

<div id="giroPaymentInquiryGrid">
    <sjg:grid
        id="giroPaymentInquiry_grid"
        dataType="json"
        caption="GIRO PAYMENT INQUIRY"
        href="%{remoteurlGiroPaymentInquiry}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGiroPaymentInquiryTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="giroPaymentInquiry_grid_onSelect"
        width="$('#tabmnuGIRO_PAYMENT_INQUIRY').width()"
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
            name="inquiryReasonCode" index="inquiryReasonCode" key="inquiryReasonCode" title="Inquiry Reason" width="180" sortable="true"
        />
        <sjg:gridColumn
            name="inquiryRemark" index="inquiryRemark" key="inquiryRemark" title="Inquiry Remark" width="180" sortable="true"
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

<sj:a href="#" id="btnGiroPaymentInquiry_Process" button="true">Inquiry</sj:a>
<sj:a href="#" id="btnGiroPaymentInquiry_Exit" button="true">Exit</sj:a>