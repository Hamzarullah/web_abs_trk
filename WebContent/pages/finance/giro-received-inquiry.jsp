<%-- 
    Document   : giro-received-inquiry
    Created on : Jan 15, 2020, 2:56:00 PM
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
        $('input[name="giroReceivedInquirySearchStatusRad"][value="PENDING"]').prop('checked',true);
        $("#giroReceivedInquirySearchStatus").val("Pending");
        
        $('input[name="giroReceivedInquirySearchStatusRad"][value="PENDING"]').change(function(ev){
            var value="Pending";
            $("#giroReceivedInquirySearchStatus").val(value);
        });
        
        $('input[name="giroReceivedInquirySearchStatusRad"][value="CLEARED"]').change(function(ev){
            var value="Cleared";
            $("#giroReceivedInquirySearchStatus").val(value);
        });
        
        $('input[name="giroReceivedInquirySearchStatusRad"][value="REJECTED"]').change(function(ev){
            var value="Rejected";
            $("#giroReceivedInquirySearchStatus").val(value);
        });
        $('input[name="giroReceivedInquirySearchStatusRad"][value="All"]').change(function(ev){
            $("#giroReceivedInquirySearchStatus").val("");
        });
        
//        button proses SEARCH
          var updateRowId = -1;
        
        $("#btnGiroReceivedInquiry_Process").click(function(ev){
            
            updateRowId = $("#giroReceivedInquiry_grid").jqGrid("getGridParam","selrow");

            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }
            
            var giroReceivedInquiry = $("#giroReceivedInquiry_grid").jqGrid('getRowData', updateRowId);
            var url = "finance/giro-received-inquiry-input";
            var params = "giroReceivedInquiry.code="+giroReceivedInquiry.code;
            
            pageLoad(url, params, "#tabmnuGIRO_RECEIVED_INQUIRY");

        });
//        end Button proses
        
        $('#btnGiroReceivedInquiry_search').click(function(ev) {
            formatDateGiroReceived();
            formatDueDateGiroReceived();
            $("#giroReceivedInquiry_grid").jqGrid("clearGridData");
            $("#giroReceivedInquiry_grid").jqGrid("setGridParam",{url:"finance/giro-received-inquiry-data?" + $("#frmGiroReceivedInquirySearchInput").serialize()});
            $("#giroReceivedInquiry_grid").trigger("reloadGrid");
            formatDateGiroReceived();
            formatDueDateGiroReceived();
            ev.preventDefault();
        });

        
    });//EOF Ready
    
    function formatDateGiroReceived(){
        var firstDate=$("#giroReceivedInquirySearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#giroReceivedInquirySearchFirstDate").val(firstDateValue);

        var lastDate=$("#giroReceivedInquirySearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#giroReceivedInquirySearchLastDate").val(lastDateValue);
    }
    
    function formatDueDateGiroReceived(){
        var firstDueDate=$("#giroReceivedInquirySearchFirstDateDueDate").val();
        var firstDueDateValues= firstDueDate.split('/');
        var firstDueDateValue =firstDueDateValues[1]+"/"+firstDueDateValues[0]+"/"+firstDueDateValues[2];
        $("#giroReceivedInquirySearchFirstDateDueDate").val(firstDueDateValue);

        var lastDueDate=$("#giroReceivedInquirySearchLastDateDueDate").val();
        var lastDueDateValues= lastDueDate.split('/');
        var lastDueDateValue =lastDueDateValues[1]+"/"+lastDueDateValues[0]+"/"+lastDueDateValues[2];
        $("#giroReceivedInquirySearchLastDateDueDate").val(lastDueDateValue);
    }
    
    function reloadGridGiroReceived() {
        $("#giroReceivedInquiry_grid").trigger("reloadGrid");
    };
</script>

<!--Search Navbar-->
<s:url id="remoteurlGiroReceivedInquiry" action="giro-received-inquiry-data" />
<b>GIRO RECEIVED INQUIRY</b>
<hr>
<div id="giroReceivedInquirySearchInput" class="content ui-widget">
    <s:form id="frmGiroReceivedInquirySearchInput">
        <table cellpadding="2" cellspacing="2">
            
            <tr>
                <td align="right" valign="centre"><b>GRP No</b></td>
                <td>
                    <s:textfield id="giroReceivedInquirySearchCode" name="giroReceivedInquirySearchCode" size="20" placeHolder=" Grp No"></s:textfield>
                </td>
              
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="giroReceivedInquirySearchFirstDate" name="giroReceivedInquirySearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroReceivedInquirySearchLastDate" name="giroReceivedInquirySearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Code</b></td>
                <td>
                    <s:textfield id="giroReceivedInquirySearchBankCode" name="giroReceivedInquirySearchBankCode" size="15" placeHolder=" Bank Code"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Remark</b></td>
                <td>
                    <s:textfield id="giroReceivedInquirySearchRemark" name="giroReceivedInquirySearchRemark" size="15" placeHolder=" Remark"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right" valign="centre"><b>Giro No</b></td>
                <td>
                    <s:textfield id="giroReceivedInquirySearchGiroNo" name="giroReceivedInquirySearchGiroNo" size="20" placeHolder=" Giro No"></s:textfield>
                </td>
              
                <td align="right"><B>Due Date *</B></td>
                <td>
                    <sj:datepicker id="giroReceivedInquirySearchFirstDateDueDate" name="giroReceivedInquirySearchFirstDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroReceivedInquirySearchLastDateDueDate" name="giroReceivedInquirySearchLastDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Name</b></td>
                <td>
                    <s:textfield id="giroReceivedInquirySearchBankName" name="giroReceivedInquirySearchBankName" size="15" placeHolder=" Bank Name"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Ref No</b></td>
                <td>
                    <s:textfield id="giroReceivedInquirySearchRefNo" name="giroReceivedInquirySearchRefNo" size="15" placeHolder=" Ref No"></s:textfield>
                </td>
            </tr>
            <br class="spacer" />
            <tr>
                <td align="right"></td>
                <td align="right"></td>
                <td align="right"></td>
                <td>
                <s:radio id="giroReceivedInquirySearchStatusRad" name="giroReceivedInquirySearchStatusRad" list="{'PENDING','CLEARED','REJECTED','All'}"></s:radio>
                <s:textfield id="giroReceivedInquirySearchStatus" name="giroReceivedInquirySearchStatus" value="REQUEST" size="20" cssStyle="display:none"></s:textfield>
                </td>                   
            </tr>
            
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGiroReceivedInquiry_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
<!--End Search Navbar-->

<br class="spacer" />

<!--Grid-->       

<div id="giroReceivedInquiryGrid">
    <sjg:grid
        id="giroReceivedInquiry_grid"
        dataType="json"
        caption="GIRO RECEIVED INQUIRY"
        href="%{remoteurlGiroReceivedInquiry}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGiroReceivedInquiryTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="giroReceivedInquiry_grid_onSelect"
        width="$('#tabmnuGIRO_RECEIVED_INQUIRY').width()"
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
            name="rejectedReasonName" index="rejectedReasonName" key="rejectedReasonName" title="Inquiry Reason" width="180" sortable="true"
        />
        <sjg:gridColumn
            name="rejectedRemark" index="rejectedRemark" key="rejectedRemark" title="Inquiry Remark" width="180" sortable="true"
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

<sj:a href="#" id="btnGiroReceivedInquiry_Process" button="true">Inquiry</sj:a>
<sj:a href="#" id="btnGiroReceivedInquiry_Exit" button="true">Exit</sj:a>