<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow: scroll;
        }
    </style>
    
<script type = "text/javascript">
      
    var search_paymentRequest_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    var id_firstDate= '<%= request.getParameter("firstDate") %>';
    var id_lastDate= '<%= request.getParameter("lastDate") %>';
    var id_transaction_type= '<%= request.getParameter("idtransaction") %>';
    
    jQuery(document).ready(function(){  
        
        var firstDate=id_firstDate.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        
        var lastDate=id_lastDate.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#paymentRequestSearchFirstDate").val(firstDateFormat);
        $("#paymentRequestSearchLastDate").val(lastDateFormat);
        
        $("#dlgPaymentRequest_okButton").click(function(ev) { 

            var bankPaymentDetaillastRowId=rowLast;
            var programPaymentRequestDetailLastRowId=rowLast;
            
            if (search_paymentRequest_type === "grid" ) {
                var ids = jQuery("#dlgSearch_paymentRequest_grid").jqGrid('getDataIDs');
                var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                for(var i=0;i<ids.length;i++){
                    var exist = false;
                    var data = $("#dlgSearch_paymentRequest_grid").jqGrid('getRowData',ids[i]);
                    if($("input:checkbox[id='jqg_dlgSearch_paymentRequest_grid_"+ids[i]+"']").is(":checked")){
                        for(var j=0; j<idsOpener.length; j++){
                            var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            if(id_document === 'promoPaymentRequestPaymentRequestDetail'){
                                if(data.code === dataExist.promoPaymentRequestPaymentRequestDetailPaymentRequestCode){
                                    exist = true;
                                }
                            }
                        }
                        if(exist){
//                            alert("data was in grid");
                        }else{
                            if(id_document === 'bankPaymentPaymentRequest'){
                                var defRow = {
                                    bankPaymentPaymentRequestCodeTemp               : data.code,
                                    bankPaymentPaymentRequestBranchCode             : data.branchCode,
                                    bankPaymentPaymentRequestCode                   : data.code,
                                    bankPaymentPaymentRequestTransactionDate        : data.transactionDate,
                                    bankPaymentPaymentRequestCurrencyCode           : data.currencyCode,
                                    bankPaymentPaymentRequestTotalTransactionAmount : data.totalTransactionAmount,
                                    bankPaymentPaymentRequestTransactionType        : data.transactionType, 
                                    bankPaymentPaymentRequestRefNo                  : data.refNo, 
                                    bankPaymentPaymentRequestRemark                 : data.remark
                                };

                                bankPaymentDetaillastRowId++;
                                window.opener.addRowDataMultiSelected(bankPaymentDetaillastRowId,defRow);
                            }
                        }
                    }
                    
                }
                window.opener.bankPaymentSubDetaillastRowId = bankPaymentDetaillastRowId;
                window.opener.addRowPaymentDetail();
                window.opener.bankPaymentCalculateTotalTransactionAmountForeign();
                window.close();
            }
        });

        $("#dlgPaymentRequest_cancelButton").click(function(ev) { 
            data_search_paymentRequest = null;
            window.close();
        });
    
        $("#btn_dlg_PaymentRequestSearch").click(function(ev) {
            formatDateSearchPaymentRequestByBankPayment();
            $("#dlgSearch_paymentRequest_grid").jqGrid("setGridParam",{url:"finance/payment-request-search-data-payment?" +"transactionCashBankType="+id_transaction_type+"&"+ $("#frmPaymentRequestSearch").serialize(), page:1});
            $("#dlgSearch_paymentRequest_grid").trigger("reloadGrid");
            formatDateSearchPaymentRequestByBankPayment();
            ev.preventDefault();
        });
     });
     
     function formatDateSearchPaymentRequestByBankPayment(){
        var firstDate=$("#paymentRequestSearchFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=$("#paymentRequestSearchLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];

        $("#paymentRequestSearchFirstDate").val(firstDateFormat);
        $("#paymentRequestSearchLastDate").val(lastDateFormat);
    }
    
</script>
<ball>
<s:url id="remoteurlPaymentRequestSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmPaymentRequestSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" width="80px"><B>Period *</B></td>
                <td>
                    <sj:datepicker id="paymentRequestSearchFirstDate" name="paymentRequestSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeYear="true" changeMonth="true" ></sj:datepicker>
                    <B>To *</B>
                    <sj:datepicker id="paymentRequestSearchLastDate" name="paymentRequestSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeYear="true" changeMonth="true" ></sj:datepicker>
                </td>    
            </tr>
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="paymentRequestSearchCode" name="paymentRequestSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Payment To</td>
                <td><s:textfield id="paymentRequestSearchPaymentTo" name="paymentRequestSearchPaymentTo" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_PaymentRequestSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_paymentRequest_grid"
            dataType="json"
            href="%{remoteurlPaymentRequestSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listPaymentRequestTemp"
            rowList="10,20,30"
            rowNum="10"
            multiselect = "true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnupaymentRequest').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Payment Request Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch Code" width = "100" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name = "branchName" id="branchName" index = "branchName" key = "branchName" 
            title = "Branch Name" width = "150" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="transactionType" index="transactionType" key="transactionType" title="Type" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name = "totalTransactionAmount" index = "totalTransactionAmount" key = "totalTransactionAmount" title = "Total Amount" width = "150" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="paymentTo" index="paymentTo" key="paymentTo" title="Payment To" width="150" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgPaymentRequest_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgPaymentRequest_cancelButton" button="true">Cancel</sj:a>
</ball>
</html>