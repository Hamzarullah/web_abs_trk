

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
       
    var search_customerSalesOrder= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';  
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgCustomerSalesOrder_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_customerSalesOrder_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }
           

            var data_search_customerSalesOrder = $("#dlgSearch_customerSalesOrder_grid").jqGrid('getRowData', selectedRowId);
            if (search_customerSalesOrder === "grid" ) {}
            else {
                $("#"+id_document+"\\.salesOrder\\.code",opener.document).val(data_search_customerSalesOrder.code);
                $("#"+id_document+"\\.salesOrder\\.transactionDate",opener.document).val(data_search_customerSalesOrder.transactionDate);
                $("#"+id_document+"\\.salesOrderSource",opener.document).val(data_search_customerSalesOrder.salesOrderSource);
                $("#"+id_document+"\\.salesOrder\\.customerPurchaseOrder\\.code",opener.document).val(data_search_customerSalesOrder.customerPurchaseOrderCode);
                $("#"+id_document+"\\.salesOrder\\.blanketOrder\\.code",opener.document).val(data_search_customerSalesOrder.blanketOrderCode);
                $("#"+id_document+"\\.salesOrder\\.branch\\.code",opener.document).val(data_search_customerSalesOrder.branchCode);
                $("#"+id_document+"\\.salesOrder\\.branch\\.name",opener.document).val(data_search_customerSalesOrder.branchName);
                $("#"+id_document+"\\.salesOrder\\.salesPerson\\.code",opener.document).val(data_search_customerSalesOrder.salesPersonCode);
                $("#"+id_document+"\\.salesOrder\\.salesPerson\\.name",opener.document).val(data_search_customerSalesOrder.salesPersonName);
                $("#"+id_document+"\\.salesOrder\\.customer\\.code",opener.document).val(data_search_customerSalesOrder.customerCode);
                $("#"+id_document+"\\.salesOrder\\.customer\\.name",opener.document).val(data_search_customerSalesOrder.customerName);
            }
//            window.opener.onChangeListOfApplicableDocumentSalesOrderSource(data_search_customerSalesOrder.salesOrderSource);
            window.close();
        });

        $("#dlgCustomerSalesOrder_cancelButton").click(function(ev) { 
            data_search_customerSalesOrder = null;
            window.close();
        });
    
        $("#btn_dlg_CustomerSalesOrderSearch").click(function(ev) {
            if(id_document === "listOfApplicableDocument"){
                formatDate();
                $("#dlgSearch_customerSalesOrder_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-search-data-lad?" + $("#frmCustomerSalesOrderSearch").serialize(), page:1});
                $("#dlgSearch_customerSalesOrder_grid").trigger("reloadGrid");
                formatDate();
            }else{
                formatDate();
                $("#dlgSearch_customerSalesOrder_grid").jqGrid("setGridParam",{url:"sales/customer-sales-order-search-data?" + $("#frmCustomerSalesOrderSearch").serialize(), page:1});
                $("#dlgSearch_customerSalesOrder_grid").trigger("reloadGrid");
                formatDate();
            }
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#salesOrderSearchFirstDate").val(firstDateFormat);
        $("#salesOrderSearchLastDate").val(lastDateFormat);
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
        var firstDate=$("#salesOrderSearchFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#salesOrderSearchFirstDate").val(firstDateFormat);

        var lastDate=$("#salesOrderSearchLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#salesOrderSearchLastDate").val(lastDateFormat);
    }
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmCustomerSalesOrderSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="salesOrderSearchFirstDate" name="salesOrderSearchFirstDate" size="15" displayFormat="dd/mm/yy"  showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    To
                    <sj:datepicker id="salesOrderSearchLastDate" name="salesOrderSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="customerSalesOrder.code" name="customerSalesOrder.code" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="customerSalesOrder.customerCode" name="customerSalesOrder.customerCode" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="customerSalesOrder.customerName" name="customerSalesOrder.customerName" PlaceHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerSalesOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_customerSalesOrder_grid"
            dataType="json"
            href="%{remoteurlCustomerSalesOrderSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerSalesOrder"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuCustomerSalesOrder').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="BranchCode" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="branchName" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  title="Transaction Date" width="150" search="false" align="center"
            />
            <sjg:gridColumn
                name="salesOrderSource" index="salesOrderSource" title="Source" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="blanketOrderCode" index="blanketOrderCode" title="Blanket/Customer Purchase" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" title="customer code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" title="customer name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="salesPersonCode" index="salesPersonCode" title="SalesPerson code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="salesPersonName" index="salesPersonName" title="SalesPerson name" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="customerPurchaseOrderCode" index="customerPurchaseOrderCode" title="" width="200" sortable="true" hidden="true"
            />
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgCustomerSalesOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgCustomerSalesOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


