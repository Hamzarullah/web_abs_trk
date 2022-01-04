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
      
    var search_salesQuotation= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';  
    var id_customer='<%= request.getParameter("customer") %>';  
    var id_customer_name='<%= request.getParameter("customerName") %>';  
    var id_branch='<%= request.getParameter("branch") %>';  
    var id_branch_name='<%= request.getParameter("branchName") %>';  
    var id_end_user='<%= request.getParameter("endUser") %>';  
    var id_end_user_name='<%= request.getParameter("endUserName") %>';  
    var id_sales_person='<%= request.getParameter("salesPerson") %>';  
    var id_sales_person_name='<%= request.getParameter("salesPersonName") %>';  
    var id_project='<%= request.getParameter("project") %>';  
    var id_project_name='<%= request.getParameter("projectName") %>';  
    var id_currency='<%= request.getParameter("currency") %>';  
    var id_currency_name='<%= request.getParameter("currencyName") %>';  
    var id_order_status='<%= request.getParameter("orderStatus") %>';  
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgSalesQuotation_okButton").click(function(ev) { 
            
            customerPurchaseOrderSalesQuotationLastRowId=rowLast;
            customerPurchaseOrderToBlanketOrderItemDetailLastRowId=rowLast;
            customerPurchaseOrderReleaseItemDetailLastRowId=rowLast;
            salesOrderItemDetailLastRowId=rowLast;
            blanketOrderItemDetailLastRowId=rowLast;
            
            if (search_salesQuotation === "grid" ) {
                    var ids = jQuery("#dlgSearch_salesQuotation_grid").jqGrid('getDataIDs');
                    var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                    for(var i=0;i<ids.length;i++){
                        var exist = false;
                        var data = $("#dlgSearch_salesQuotation_grid").jqGrid('getRowData',ids[i]);
                        if($("input:checkbox[id='jqg_dlgSearch_salesQuotation_grid_"+ids[i]+"']").is(":checked")){
                            for(var j=0; j<idsOpener.length; j++){
                                var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                                if(data.code === dataExist.customerPurchaseOrderSalesQuotationCode){
                                        exist = true;
                                }else if(data.code === dataExist.customerPurchaseOrderToBlanketOrderSalesQuotationCode){
                                   exist = true;
                                }else if(data.code === dataExist.salesOrderSalesQuotationCode){
                                   exist = true;
                                }else if(data.code === dataExist.blanketOrderSalesQuotationCode){
                                   exist = true;
                                }
                            }if(exist){
                                alert('Code Has been existing in Grid');
                                return;
                            }else{
                                if(id_document === 'customerPurchaseOrderSalesQuotation'){
                                    var defRow = {
                                        customerPurchaseOrderSalesQuotationDelete              :"delete",
                                        customerPurchaseOrderSalesQuotationCode                : data.code,
                                        customerPurchaseOrderSalesQuotationTransactionDate     : data.transactionDate,
                                        customerPurchaseOrderSalesQuotationCustomerCode        : data.customerCode,
                                        customerPurchaseOrderSalesQuotationCustomerName        : data.customerName,
                                        customerPurchaseOrderSalesQuotationEndUserCode         : data.endUserCode,
                                        customerPurchaseOrderSalesQuotationEndUserName         : data.endUserName,
                                        customerPurchaseOrderSalesQuotationRfqCode             : data.rfqNo,
                                        customerPurchaseOrderSalesQuotationProjectCode         : data.projectCode,
                                        customerPurchaseOrderSalesQuotationSubject             : data.subject,
                                        customerPurchaseOrderSalesQuotationAttn                : data.attn,
                                        customerPurchaseOrderSalesQuotationRefNo               : data.refNo,
                                        customerPurchaseOrderSalesQuotationRemark              : data.remark
                                    };

                                    window.opener.addRowDataMultiSelectedCPOSO(customerPurchaseOrderSalesQuotationLastRowId,defRow);
                                    customerPurchaseOrderSalesQuotationLastRowId++;
                                }
                                if(id_document === 'customerPurchaseOrderToBlanketOrderSalesQuotation'){
                                    var defRow = {
                                        customerPurchaseOrderToBlanketOrderSalesQuotationDelete              :"delete",
                                        customerPurchaseOrderToBlanketOrderSalesQuotationCode                : data.code,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationTransactionDate     : data.transactionDate,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationCustomerCode        : data.customerCode,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationCustomerName        : data.customerName,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationEndUserCode         : data.endUserCode,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationEndUserName         : data.endUserName,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationRfqCode             : data.rfqNo,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationProjectCode         : data.projectCode,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationSubject             : data.subject,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationAttn                : data.attn,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationRefNo               : data.refNo,
                                        customerPurchaseOrderToBlanketOrderSalesQuotationRemark              : data.remark
                                    };

                                    window.opener.addRowDataMultiSelectedCPOBO(customerPurchaseOrderToBlanketOrderItemDetailLastRowId,defRow);
                                    customerPurchaseOrderToBlanketOrderItemDetailLastRowId++;
                                }
                                if(id_document === 'salesOrderSalesQuotation'){
                                    var defRow = {
                                        salesOrderSalesQuotationDelete              :"delete",
                                        salesOrderSalesQuotationCode                : data.code,
                                        salesOrderSalesQuotationTransactionDate     : data.transactionDate,
                                        salesOrderSalesQuotationCustomerCode        : data.customerCode,
                                        salesOrderSalesQuotationCustomerName        : data.customerName,
                                        salesOrderSalesQuotationEndUserCode         : data.endUserCode,
                                        salesOrderSalesQuotationEndUserName         : data.endUserName,
                                        salesOrderSalesQuotationRfqCode             : data.rfqNo,
                                        salesOrderSalesQuotationProjectCode         : data.projectCode,
                                        salesOrderSalesQuotationSubject             : data.subject,
                                        salesOrderSalesQuotationAttn                : data.attn,
                                        salesOrderSalesQuotationRefNo               : data.refNo,
                                        salesOrderSalesQuotationRemark              : data.remark
                                    };

                                    window.opener.addRowDataMultiSelectedSO(salesOrderItemDetailLastRowId,defRow);
                                    salesOrderItemDetailLastRowId++;
                                }
                                if(id_document === 'blanketOrderSalesQuotation'){
                                    var defRow = {
                                        blanketOrderSalesQuotationDelete              :"delete",
                                        blanketOrderSalesQuotationCode                : data.code,
                                        blanketOrderSalesQuotationTransactionDate     : data.transactionDate,
                                        blanketOrderSalesQuotationCustomerCode        : data.customerCode,
                                        blanketOrderSalesQuotationCustomerName        : data.customerName,
                                        blanketOrderSalesQuotationEndUserCode         : data.endUserCode,
                                        blanketOrderSalesQuotationEndUserName         : data.endUserName,
                                        blanketOrderSalesQuotationRfqCode             : data.rfqNo,
                                        blanketOrderSalesQuotationProjectCode         : data.projectCode,
                                        blanketOrderSalesQuotationSubject             : data.subject,
                                        blanketOrderSalesQuotationAttn                : data.attn,
                                        blanketOrderSalesQuotationRefNo               : data.refNo,
                                        blanketOrderSalesQuotationRemark              : data.remark
                                    };

                                    window.opener.addRowDataMultiSelected(blanketOrderItemDetailLastRowId,defRow);
                                    blanketOrderItemDetailLastRowId++;
                                }
                            }
                        }
                    }
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_branch.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_branch.name);
                
            }

            window.close();
        });

       $("#dlgSalesQuotation_cancelButton").click(function(ev) { 
            data_search_salesQuotation = null;
            window.close();
        });
    
        $("#btn_dlg_SalesQuotationSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_salesQuotation_grid").jqGrid("setGridParam",{url:"sales/sales-quotation-search-data?" + $("#frmSalesQuotationSearch").serialize(), page:1});
            $("#dlgSearch_salesQuotation_grid").trigger("reloadGrid");
            formatDate();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#salesQuotationTemp\\.firstDate").val(firstDateFormat);
        $("#salesQuotationTemp\\.lastDate").val(lastDateFormat);
        
        $("#salesQuotationTemp\\.customerCode").val(id_customer);
        $("#salesQuotationTemp\\.customerName").val(id_customer_name);
        $("#salesQuotationTemp\\.endUserCode").val(id_end_user);
        $("#salesQuotationTemp\\.endUserName").val(id_end_user_name);
        $("#salesQuotationTemp\\.salesPersonCode").val(id_sales_person);
        $("#salesQuotationTemp\\.salesPersonName").val(id_sales_person_name);
        $("#salesQuotationTemp\\.projectCode").val(id_project);
        $("#salesQuotationTemp\\.projectName").val(id_project_name);
        $("#salesQuotationTemp\\.currencyCode").val(id_currency);
        $("#salesQuotationTemp\\.currencyName").val(id_currency_name);
        $("#salesQuotationTemp\\.branchCode").val(id_branch);
        $("#salesQuotationTemp\\.branchName").val(id_branch_name);
        $("#salesQuotationTemp\\.orderStatus").val(id_order_status);
    });
    
    function alertMsg(txt_message){
        var dynamicDialog= $(
        '<div id="conformBoxError">'+
            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
            '</span>' +
        '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            resizable: false,
            closeText: "hide",
            buttons : 
            [{
                text : "OK",
                click : function() {
                    $(this).dialog("close");
                }
            }]
        });
    }
     function formatDate(){
        var firstDate=$("#salesQuotationTemp\\.firstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#salesQuotationTemp\\.firstDate").val(firstDateFormat);

        var lastDate=$("#salesQuotationTemp\\.lastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#salesQuotationTemp\\.lastDate").val(lastDateFormat);
    }
    
</script>
<body>
 <div class="ui-widget">
        <s:form id="frmSalesQuotationSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="salesQuotationTemp.code" name="salesQuotationTemp.code" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td><s:textfield id="salesQuotationTemp.branchCode" name="salesQuotationTemp.branchCode" readonly="true"></s:textfield>
                <s:textfield id="salesQuotationTemp.branchName" name="salesQuotationTemp.branchName" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td><s:textfield id="salesQuotationTemp.customerCode" name="salesQuotationTemp.customerCode" readonly="true"></s:textfield>
                <s:textfield id="salesQuotationTemp.customerName" name="salesQuotationTemp.customerName" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">End User</td>
                <td><s:textfield id="salesQuotationTemp.endUserCode" name="salesQuotationTemp.endUserCode" readonly="true"></s:textfield>
                <s:textfield id="salesQuotationTemp.endUserName" name="salesQuotationTemp.endUserName" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Sales Person</td>
                <td><s:textfield id="salesQuotationTemp.salesPersonCode" name="salesQuotationTemp.salesPersonCode" readonly="true"></s:textfield>
                <s:textfield id="salesQuotationTemp.salesPersonName" name="salesQuotationTemp.salesPersonName" readonly="true"></s:textfield></td>
            </tr>
            <tr hidden="true">
                <td align="right">Project</td>
                <td><s:textfield id="salesQuotationTemp.projectCode" name="salesQuotationTemp.projectCode" readonly="true"></s:textfield>
                <s:textfield id="salesQuotationTemp.projectName" name="salesQuotationTemp.projectName" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Currency</td>
                <td><s:textfield id="salesQuotationTemp.currencyCode" name="salesQuotationTemp.currencyCode" readonly="true"></s:textfield>
                <s:textfield id="salesQuotationTemp.currencyName" name="salesQuotationTemp.currencyName" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td>
                    <s:textfield id="salesQuotationTemp.orderStatus" name="salesQuotationTemp.orderStatus" readonly="true" hidden="true"></s:textfield>
                </td>
            </tr>
             <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="salesQuotationTemp.firstDate" name="salesQuotationTemp.firstDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                    To
                    <sj:datepicker id="salesQuotationTemp.lastDate" name="salesQuotationTemp.lastDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_SalesQuotationSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
   <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_salesQuotation_grid"
            dataType="json"
            href="%{remoteurlSalesQuotationSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listSalesQuotationTemp"
            multiselect = "true"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuSalesQuotation').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="120" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  title="Transaction Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" title="customer code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" title="customer name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="endUserCode" index="endUserCode" title="end user code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="endUserName" index="endUserName" title="end user name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="rfqCode" index="rfqCode" title="RFQ No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="projectCode" index="projectCode" title="project" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="subject" index="subject" title="subject" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="attn" index="attn" title="attn" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" title="Ref No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" title="remark" width="200" sortable="true"
            />
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgSalesQuotation_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgSalesQuotation_cancelButton" button="true">Cancel</sj:a>
</body>
</html>