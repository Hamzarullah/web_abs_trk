<%-- 
    Document   : search-salesQuotation
    Created on : Aug 23, 2019, 9:59:08 AM
    Author     : jsone
--%>

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
    
    jQuery(document).ready(function(){  
        $("#dlgSalesQuotation_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_salesQuotation_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }

            var data_search_salesQuotation = $("#dlgSearch_salesQuotation_grid").jqGrid('getRowData', selectedRowId);

            if (search_salesQuotation === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                    if(data_search_salesQuotation.code === dataOpener.customerPurchaseOrderSalesQuotationCode){
                        alertMsg("Sales Quotation "+data_search_salesQuotation.code+" Has Been Existing In Grid!");
                        return;
                    }
                }
                
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Code", data_search_salesQuotation.code);         
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"TransactionDate", data_search_salesQuotation.transactionDate); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CustomerCode", data_search_salesQuotation.customerCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CustomerName", data_search_salesQuotation.customerName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EndUserCode", data_search_salesQuotation.endUserCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EndUserName", data_search_salesQuotation.endUserName);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RfqNo", data_search_salesQuotation.rfqNo);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ProjectCode", data_search_salesQuotation.projectCode);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Subject", data_search_salesQuotation.subject);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Attn", data_search_salesQuotation.attn);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RefNo", data_search_salesQuotation.refNo);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Remark", data_search_salesQuotation.remark);
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_salesQuotation.code);
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
                    <sj:datepicker id="salesQuotationTemp.firstDate" name="salesQuotationTemp.firstDate" size="15" displayFormat="dd/mm/yy"  showOn="focus"></sj:datepicker>
                    To
                    <sj:datepicker id="salesQuotationTemp.lastDate" name="salesQuotationTemp.lastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
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
                name="rfqNo" index="rfqNo" title="RFQNo" width="100" sortable="true"
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


