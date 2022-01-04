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
        $('input[name="giroReceivedRejectSearchStatusRad"][value="PENDING"]').prop('checked',true);
        $("#giroReceivedRejectSearchStatus").val("Pending");
        
        $('input[name="giroReceivedRejectSearchStatusRad"][value="CLEARED"]').change(function(ev){
            var value="Cleared";
            $("#giroReceivedRejectSearchStatus").val(value);
        });
        $('input[name="giroReceivedRejectSearchStatusRad"][value="REJECTED"]').change(function(ev){
            var value="Rejected";
            $("#giroReceivedRejectSearchStatus").val(value);
        });    
        $('input[name="giroReceivedRejectSearchStatusRad"][value="PENDING"]').change(function(ev){
            var value="Pending";
            $("#giroReceivedRejectSearchStatus").val(value);
        });
        $('input[name="giroReceivedRejectSearchStatusRad"][value="All"]').change(function(ev){
            $("#giroReceivedRejectSearchStatus").val("");
        });
        
//        button proses SEARCH
          var updateRowId = -1;
        
        $("#btnGiroReceivedReject_Process").click(function(ev){
            
            updateRowId = $("#giroReceivedReject_grid").jqGrid("getGridParam","selrow");

            if(updateRowId === null){
                alertMessage("Please Select Row!");
                return;
            }
            
            
            
            var giroReceivedReject = $("#giroReceivedReject_grid").jqGrid('getRowData', updateRowId);
            var url = "finance/giro-received-reject-input";
            var params = "giroReceivedReject.code="+giroReceivedReject.code;
//            params += "&giroReceivedReject.transactionDate="+giroReceivedReject.transactionDate;
            params += "&giroReceivedReject.branchCode="+giroReceivedReject.branchCode;
            params += "&giroReceivedReject.branchName="+giroReceivedReject.branchName;
            params += "&giroReceivedReject.grpNo="+giroReceivedReject.grpNo;
            params += "&giroReceivedReject.giroNo="+giroReceivedReject.giroNo;
            params += "&giroReceivedReject.bankCode="+giroReceivedReject.bankCode;
            params += "&giroReceivedReject.bankName="+giroReceivedReject.bankName;
            params += "&giroReceivedReject.currencyCode="+giroReceivedReject.currencyCode;
            params += "&giroReceivedReject.currencyName="+giroReceivedReject.currencyName;
            params += "&giroReceivedReject.amount="+giroReceivedReject.amount;
            params += "&giroReceivedReject.refNo="+giroReceivedReject.refNo;
            params += "&giroReceivedReject.receivedFrom="+giroReceivedReject.receivedFrom;
            params += "&giroReceivedReject.rejectedReasonCode="+giroReceivedReject.rejectedReasonCode;
            params += "&giroReceivedReject.rejectedRemark="+giroReceivedReject.rejectedRemark;
            
            
            var giroStatus = giroReceivedReject.giroStatus;
            
            if(giroStatus === 'Rejected'){
                alertMessage("Data was Rejected!");
                return;
            }
            
            pageLoad(url, params, "#tabmnuGIRO_RECEIVED_REJECT");

        });
//        end Button proses
        
        $('#btnGiroReceivedReject_search').click(function(ev) {
            formatDateGiroReceived();
            formatDueDateGiroReceived();
            $("#giroReceivedReject_grid").jqGrid("clearGridData");
            $("#giroReceivedReject_grid").jqGrid("setGridParam",{url:"finance/giro-received-reject-data?" + $("#frmGiroReceivedRejectSearchInput").serialize()});
            $("#giroReceivedReject_grid").trigger("reloadGrid");
            formatDateGiroReceived();
            formatDueDateGiroReceived();
            ev.preventDefault();
        });

        
    });//EOF Ready
    
    function formatDateGiroReceived(){
        var firstDate=$("#giroReceivedRejectSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#giroReceivedRejectSearchFirstDate").val(firstDateValue);

        var lastDate=$("#giroReceivedRejectSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#giroReceivedRejectSearchLastDate").val(lastDateValue);
 
    }
    
    function formatDueDateGiroReceived(){
        var firstDueDate=$("#giroReceivedRejectSearchFirstDateDueDate").val();
        var firstDueDateValues= firstDueDate.split('/');
        var firstDueDateValue =firstDueDateValues[1]+"/"+firstDueDateValues[0]+"/"+firstDueDateValues[2];
        $("#giroReceivedRejectSearchFirstDateDueDate").val(firstDueDateValue);

        var lastDueDate=$("#giroReceivedRejectSearchLastDateDueDate").val();
        var lastDueDateValues= lastDueDate.split('/');
        var lastDueDateValue =lastDueDateValues[1]+"/"+lastDueDateValues[0]+"/"+lastDueDateValues[2];
        $("#giroReceivedRejectSearchLastDateDueDate").val(lastDueDateValue);
    }
    
    function reloadGridGiroReceived() {
        $("#giroReceivedReject_grid").trigger("reloadGrid");
    };
</script>

<!--Search Navbar-->
<s:url id="remoteurlGiroReceivedReject" action="giro-received-reject-data" />
<b>GIRO RECEIVED</b>
<hr>
<div id="giroReceivedRejectSearchInput" class="content ui-widget">
    <s:form id="frmGiroReceivedRejectSearchInput">
        <table cellpadding="2" cellspacing="2">
            
            <tr>
                <td align="right" valign="centre"><b>GRR No</b></td>
                <td>
                    <s:textfield id="giroReceivedRejectSearchCode" name="giroReceivedRejectSearchCode" size="20" placeHolder=" Grr No"></s:textfield>
                </td>
              
                <td align="right"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="giroReceivedRejectSearchFirstDate" name="giroReceivedRejectSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroReceivedRejectSearchLastDate" name="giroReceivedRejectSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Code</b></td>
                <td>
                    <s:textfield id="giroReceivedRejectSearchBankCode" name="giroReceivedRejectSearchBankCode" size="15" placeHolder=" Bank Code"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Remark</b></td>
                <td>
                    <s:textfield id="giroReceivedRejectSearchRemark" name="giroReceivedRejectSearchRemark" size="15" placeHolder=" Remark"></s:textfield>
                </td>
            </tr>
            
            <tr>
                <td align="right" valign="centre"><b>Giro No</b></td>
                <td>
                    <s:textfield id="giroReceivedRejectSearchGiroNo" name="giroReceivedRejectSearchGiroNo" size="20" placeHolder=" Giro No"></s:textfield>
                </td>
              
                <td align="right"><B>Due Date *</B></td>
                <td>
                    <sj:datepicker id="giroReceivedRejectSearchFirstDateDueDate" name="giroReceivedRejectSearchFirstDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="giroReceivedRejectSearchLastDateDueDate" name="giroReceivedRejectSearchLastDateDueDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                
                <td align="right" valign="centre"><b>Bank Name</b></td>
                <td>
                    <s:textfield id="giroReceivedRejectSearchBankName" name="giroReceivedRejectSearchBankName" size="15" placeHolder=" Bank Name"></s:textfield>
                </td>
                
                <td align="right" valign="centre"><b>Ref No</b></td>
                <td>
                    <s:textfield id="giroReceivedRejectSearchRefNo" name="giroReceivedRejectSearchRefNo" size="15" placeHolder=" RefNo"></s:textfield>
                </td>
            </tr>
            <br class="spacer" />
            <tr>
                <td align="right"></td>
                <td align="right"></td>
                <td align="right"></td>
                <td>
                <s:radio id="giroReceivedRejectSearchStatusRad" name="giroReceivedRejectSearchStatusRad" list="{'PENDING','CLEARED','REJECTED','All'}"></s:radio>
                <s:textfield id="giroReceivedRejectSearchStatus" name="giroReceivedRejectSearchStatus" value="REQUEST" size="20" cssStyle="display:none"></s:textfield>
                </td>                   
            </tr>
            
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnGiroReceivedReject_search" button="true">Search</sj:a>
        <br class="spacer" />
    </s:form>
</div>
<br class="spacer" />
<!--End Search Navbar-->

<br class="spacer" />

<!--Grid-->       

<div id="giroReceivedRejectGrid">
    <sjg:grid
        id="giroReceivedReject_grid"
        dataType="json"
        caption="GIRO RECEIVED REJECT"
        href="%{remoteurlGiroReceivedReject}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listGiroReceivedRejectTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="giroReceivedReject_grid_onSelect"
        width="$('#tabmnuGIRO_RECEIVED_REJECT').width()"
    >
        <sjg:gridColumn
            name="branchCode" index="branchCode" key="branchCode" title="BRANCH CODE" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="branchName" index="branchName" key="branchName" title="Branch" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="GRR NO" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="150" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            align="center"
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
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency Code" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="200" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="amount" index="amount" key="amount" title="Amount" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="receivedFrom" index="receivedFrom" key="receivedFrom" title="Received From" width="150" sortable="true"
        />
    </sjg:grid >
</div>

<!--End Grid-->

<sj:a href="#" id="btnGiroReceivedReject_Process" button="true">Reject</sj:a>
<sj:a href="#" id="btnGiroReceivedReject_Exit" button="true">Exit</sj:a>