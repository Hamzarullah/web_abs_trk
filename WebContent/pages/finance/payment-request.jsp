
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #paymentRequestDetail_grid_pager_center{
        display: none;
    }
    #msgPaymentRequestFormatTotalAmount{
        color: green;
    }
</style>
<script type="text/javascript">
                     
    $(document).ready(function(){
        
        hoverButton();
                
        $.subscribe("paymentRequest_grid_onSelect", function(event, data){
            var selectedRowID = $("#paymentRequest_grid").jqGrid("getGridParam", "selrow"); 
            var paymentRequest = $("#paymentRequest_grid").jqGrid("getRowData", selectedRowID);
            
            $("#paymentRequestDetail_grid").jqGrid("setGridParam",{url:"finance/payment-request-detail-data?paymentRequest.code=" + paymentRequest.code});
            $("#paymentRequestDetail_grid").jqGrid("setCaption", "PAYMENT REQUEST DETAIL : "+ paymentRequest.code);
            $("#paymentRequestDetail_grid").trigger("reloadGrid");
        });
        
      
        $('#btnPaymentRequestNew').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/payment-request-input";
                var params = "";
                pageLoad(url, params, "#tabmnuPAYMENT_REQUEST"); 

            });       
        });
        
        $('#btnPaymentRequestUpdate').click(function(ev) {
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#paymentRequest_grid").jqGrid('getGridParam','selrow');
                var paymentRequest = $("#paymentRequest_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="finance/payment-request-confirmation";
                var params="paymentRequest.code="+paymentRequest.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/payment-request-input";
                    var params = "paymentRequestUpdateMode=true" + "&paymentRequest.code=" + paymentRequest.code;
                    pageLoad(url, params, "#tabmnuPAYMENT_REQUEST");
                    
                });
            });
            
            ev.preventDefault();
        });
        
        $('#btnPaymentRequestDelete').click(function(ev) {
                        
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#paymentRequest_grid").jqGrid('getGridParam','selrow');
                var paymentRequest = $("#paymentRequest_grid").jqGrid('getRowData', selectedRowId);
                
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
            
                var url="finance/payment-request-confirmation";
                var params="paymentRequest.code="+paymentRequest.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>ERP No: '+paymentRequest.code+'<br/><br/>' +    
                        '</div>');
                    dynamicDialog.dialog({
                        title : "Confirmation",
                        closeOnEscape: false,
                        modal : true,
                        width: 300,
                        resizable: false,
                        buttons : 
                            [{
                                text : "Yes",
                                click : function() {
                                    var url = "finance/payment-request-delete";
                                    var params = "paymentRequest.code=" + paymentRequest.code;

                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridPaymentRequest();
                                        reloadGridPaymentRequestDetailAfterDelete();
                                    });  
                                    $(this).dialog("close");
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
            });    
            ev.preventDefault();
        });

        $('#btnPaymentRequestRefresh').click(function(ev) {
            var url = "finance/payment-request";
            var params = "";
            pageLoad(url, params, "#tabmnuPAYMENT_REQUEST");
            ev.preventDefault();   
        });
        
        
        $('#btnPaymentRequest_search').click(function(ev) {
            formatDatePaymentRequest();
            $("#paymentRequest_grid").jqGrid("clearGridData");
            $("#paymentRequest_grid").jqGrid("setGridParam",{url:"finance/payment-request-data?" + $("#frmPaymentRequestSearchInput").serialize()});
            $("#paymentRequest_grid").trigger("reloadGrid");
            $("#paymentRequestDetail_grid").jqGrid("clearGridData");
            $("#paymentRequestDetail_grid").jqGrid("setCaption", "Payment Request Detail");
            formatDatePaymentRequest();
            ev.preventDefault();
           
        });
        
        $("#btnPaymentRequestPrint").click(function(ev) {
            var selectRowId = $("#paymentRequest_grid").jqGrid('getGridParam','selrow');
            var paymentRequest = $("#paymentRequest_grid").jqGrid('getRowData', selectRowId);  
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(paymentRequest.transactionType === "REGULAR"){
                var url = "finance/payment-request-regular-print-out-pdf?";
                var params ="prNo=" + paymentRequest.code;
                params+= "&transactionType=" + paymentRequest.transactionType;

            }else
               {
                var url = "finance/payment-request-deposit-print-out-pdf?";
                var params ="prNo=" + paymentRequest.code;
                params+= "&transactionType=" + paymentRequest.transactionType;
   
               }
            
            
            window.open(url+params,'paymentRequest','width=500,height=500');            
            ev.preventDefault();
        });
        
    });//EOF Ready
        
    function reloadGridPaymentRequest() {
        $("#paymentRequest_grid").trigger("reloadGrid");  
    };
    
    function reloadGridPaymentRequestDetailAfterDelete() {
        $("#paymentRequestDetail_grid").jqGrid("clearGridData");
        $("#paymentRequestDetail_grid").jqGrid("setCaption", "PAYMENT REQUEST DETAIL");
    };
        
    function formatDatePaymentRequest(){
        var firstDate=$("#paymentRequestSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#paymentRequestSearchFirstDate").val(firstDateValue);

        var lastDate=$("#paymentRequestSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#paymentRequestSearchLastDate").val(lastDateValue);
    }
    
</script>
   
<s:url id="remoteurlPaymentRequest" action="payment-request-json" />
<b>PAYMENT REQUEST</b>
<hr>
<br class="spacer" />

<sj:div id="PaymentRequestButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnPaymentRequestNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnPaymentRequestUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnPaymentRequestDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnPaymentRequestRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPaymentRequestPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
</sj:div> 
<br class="spacer" />
<br class="spacer" />

<div id="PaymentRequestInputSearch" class="content ui-widget">
    <s:form id="frmPaymentRequestSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">PR No</td>
                <td>
                    <s:textfield id="paymentRequestSearchCode" name="paymentRequestSearchCode" size="22" PlaceHolder=" Request No"></s:textfield>
                </td>
                <td align="right">Remark</td>
                <td>
                    <s:textfield id="paymentRequestSearchRemark" name="paymentRequestSearchRemark" size="34"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Period * </B></td>
                <td>
                    <sj:datepicker id="paymentRequestSearchFirstDate" name="paymentRequestSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="paymentRequestSearchLastDate" name="paymentRequestSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                </td>
                <td align="right">Ref No</td>
                <td>
                    <s:textfield id="paymentRequestSearchRefNo" name="paymentRequestSearchRefNo" size="34"></s:textfield>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <sj:a href="#" id="btnPaymentRequest_search" button="true">Search</sj:a>
        <br class="spacer" />

    </s:form>
</div>  
<br class="spacer" />
                  
<div id="PaymentRequestGrid">
    <sjg:grid
        id="paymentRequest_grid"
        caption="PAYMENT REQUEST"
        dataType="json"
        href="%{remoteurlPaymentRequest}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPaymentRequestTemp"
        rowList="10,20,30"
        rowNum="10"
        sortname="transactionDate"
        sortorder="desc"
        sortable="true"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnupaymentrequest').width()"
        onSelectRowTopics="paymentRequest_grid_onSelect"
    >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "80" sortable = "true"
        />
        <sjg:gridColumn
            name="approvalStatus" index="approvalStatus" key="approvalStatus" title="Status" width="80" sortable="true" 
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="PYM-RQ No" width="200" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name = "totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" title = "Total Transaction" width = "150" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="transactionType" index="transactionType" key="transactionType" title="Type" width="80" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
    </sjg:grid >
</div>
                       
<!-- GRID DETAIL -->    
<br class="spacer" />
<br class="spacer" />

<div id="paymentRequestDetailGrid">
    <sjg:grid
        id="paymentRequestDetail_grid"
        caption="PAYMENT REQUEST DETAIL"
        dataType="json"
        pager="true"
        navigator="false"
        navigatorSearch="false"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPaymentRequestDetailTemp"
        width="$('#tabmnupaymentrequest').width()"
        viewrecords="true"
        rownumbers="true"
        rowNum="10000"
        shrinkToFit="false"
    >
        <sjg:gridColumn
            name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "true" hidden="true" 
        />
        <sjg:gridColumn
            name = "documentNo" id="documentNo" index = "documentNo" key = "documentNo" title = "Document No" width = "150" sortable = "true"
        />
        <sjg:gridColumn
            name = "documentBranchCode" id="documentBranchCode" index = "documentBranchCode" key = "documentBranchCode" title = "DocumentBranch" width = "150" sortable = "true"
        />
        <sjg:gridColumn
            name = "documentType" id="documentType" index = "documentType" key = "documentType" title = "DocumentType" width = "150" sortable = "true"
        />
        <sjg:gridColumn
            name = "documentAmount" id="documentAmount" index = "documentAmount" key = "documentAmount" 
            title = "DocumentAmount" width = "150" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "documentBalanceAmount" id="documentBalanceAmount" index = "documentBalanceAmount" key = "documentBalanceAmount" 
            title = "DocumentBalanceAmount" width = "150" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "300" sortable = "true"
        />
        <sjg:gridColumn
            name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Chart Of Account Code" width = "150" sortable = "true"
        />
        <sjg:gridColumn
            name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Chart Of Account Name" width = "200" sortable = "true"
        />
        <sjg:gridColumn
            name = "currencyCode" id="currencyCode" index = "currencyCode" key = "currencyCode" title = "Currency" width = "60" sortable = "true"  align="center"
        />
        <sjg:gridColumn
            name = "debit" id="debit" index = "debit" key = "debit" 
            title = "Debit" width = "100" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "credit" id="credit" index = "credit" key = "credit" 
            title = "Credit" width = "100" sortable = "true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "transactionStatus" id="transactionStatus" index = "transactionStatus" key = "transactionStatus" title = "TransactionStatus" width = "150" sortable = "true" align="center" 
        />
    </sjg:grid >
    <br class="spacer" />
</div> 