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
      
    var search_customerPurchaseOrder_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgCustomerPurchaseOrder_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_customerPurchaseOrder_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row CustomerPurchaseOrder!");
                return;
            }
                
            var data_search_customerPurchaseOrder = $("#dlgSearch_customerPurchaseOrder_grid").jqGrid('getRowData', selectedRowId);

            if (search_customerPurchaseOrder_type === "grid" ) {
                
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"CustomerPurchaseOrderCode",opener.document).val(data_search_customerPurchaseOrder.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CustomerPurchaseOrderName", data_search_customerPurchaseOrder.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_customerPurchaseOrder.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.revision",opener.document).val(data_search_customerPurchaseOrder.revision);
                $("#"+id_document+"\\."+id_subdoc+"\\.customerPurchaseOrderNo",opener.document).val(data_search_customerPurchaseOrder.customerPurchaseOrderNo);
                $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.code",opener.document).val(data_search_customerPurchaseOrder.branchCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.name",opener.document).val(data_search_customerPurchaseOrder.branchName);
                $("#"+id_document+"\\.currency\\.code",opener.document).val(data_search_customerPurchaseOrder.currencyCode);
                $("#"+id_document+"\\.currency\\.name",opener.document).val(data_search_customerPurchaseOrder.currencyName);
                $("#"+id_document+"\\.project\\.code",opener.document).val(data_search_customerPurchaseOrder.projectCode);
                $("#"+id_document+"\\.project\\.name",opener.document).val(data_search_customerPurchaseOrder.projectName);
                $("#"+id_document+"\\.customer\\.code",opener.document).val(data_search_customerPurchaseOrder.customerCode);
                $("#"+id_document+"\\.customer\\.name",opener.document).val(data_search_customerPurchaseOrder.customerName);
                $("#"+id_document+"\\.endUser\\.code",opener.document).val(data_search_customerPurchaseOrder.endUserCode);
                $("#"+id_document+"\\.endUser\\.name",opener.document).val(data_search_customerPurchaseOrder.endUserName);
                $("#"+id_document+"\\.salesPerson\\.code",opener.document).val(data_search_customerPurchaseOrder.salesPersonCode);
                $("#"+id_document+"\\.salesPerson\\.name",opener.document).val(data_search_customerPurchaseOrder.salesPersonName);
                $("#"+id_document+"\\.orderStatus",opener.document).val(data_search_customerPurchaseOrder.orderStatus);
                if(id_document==="salesOrderByCustomerPurchaseOrder"){
                    window.opener.requestForQuotationSalesOrderLoad(data_search_customerPurchaseOrder.orderStatus);
                }
            }
             if(id_document==='contractReview'){
                $("#"+id_document+"\\."+id_subdoc+"\\.currency\\.code",opener.document).val(data_search_customerPurchaseOrder.currencyCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.currency\\.name",opener.document).val(data_search_customerPurchaseOrder.currencyName);
                $("#"+id_document+"\\."+id_subdoc+"\\.project\\.code",opener.document).val(data_search_customerPurchaseOrder.projectCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.project\\.name",opener.document).val(data_search_customerPurchaseOrder.projectName);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.code",opener.document).val(data_search_customerPurchaseOrder.customerCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.name",opener.document).val(data_search_customerPurchaseOrder.customerName);
                $("#"+id_document+"\\."+id_subdoc+"\\.endUser\\.code",opener.document).val(data_search_customerPurchaseOrder.endUserCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.endUser\\.name",opener.document).val(data_search_customerPurchaseOrder.endUserName);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesPerson\\.code",opener.document).val(data_search_customerPurchaseOrder.salesPersonCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesPerson\\.name",opener.document).val(data_search_customerPurchaseOrder.salesPersonName);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesOrderCode",opener.document).val(data_search_customerPurchaseOrder.salesOrderCode);
                window.opener.loadDataContractReviewDetail(data_search_customerPurchaseOrder.code);
                }
            window.close();
        });

        $("#dlgCustomerPurchaseOrder_cancelButton").click(function(ev) { 
            data_search_customerPurchaseOrder = null;
            window.close();
        });
    
        $("#btn_dlg_CustomerPurchaseOrderSearch").click(function(ev) {
            formatDateCPOLookup();
            $("#dlgSearch_customerPurchaseOrder_grid").jqGrid("setGridParam",{url:"sales/customer-purchase-order-data-lookup?" + $("#frmCustomerPurchaseOrderSearch").serialize(), page:1});
            $("#dlgSearch_customerPurchaseOrder_grid").trigger("reloadGrid");
            formatDateCPOLookup();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#customerPurchaseOrderSearchLookUpFirstDate").val(firstDateFormat);
        $("#customerPurchaseOrderSearchLookUpLastDate").val(lastDateFormat);
     });
     
    function formatDateCPOLookup(){
        var firstDate=$("#customerPurchaseOrderSearchLookUpFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#customerPurchaseOrderSearchLookUpFirstDate").val(firstDateFormat);

        var lastDate=$("#customerPurchaseOrderSearchLookUpLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#customerPurchaseOrderSearchLookUpLastDate").val(lastDateFormat);
    }
    
</script>
<body>
<s:url id="remoteurlCustomerPurchaseOrderSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmCustomerPurchaseOrderSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="customerPurchaseOrderSearchLookUpFirstDate" name="customerPurchaseOrderSearchLookUpFirstDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                    To
                    <sj:datepicker id="customerPurchaseOrderSearchLookUpLastDate" name="customerPurchaseOrderSearchLookUpLastDate" size="15" displayFormat="dd/mm/yy" changeMonth="true" changeYear="true" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="customerPurchaseOrder.code" name="customerPurchaseOrder.code" label="Code "></s:textfield></td>
            </tr>
           <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="customerPurchaseOrder.customerCode" name="customerPurchaseOrder.customerCode" size="25" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="customerPurchaseOrder.customerName" name="customerPurchaseOrder.customerName" size="40" PlaceHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerPurchaseOrderSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_customerPurchaseOrder_grid"
            dataType="json"
            href="%{remoteurlCustomerPurchaseOrderSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerPurchaseOrder"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucustomerPurchaseOrder').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="160" sortable="true"
        />
        <sjg:gridColumn
            name="custPONo" index="custPONo" key="custPONo" title="Cust PO No" width="160" sortable="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="160" sortable="true"
        />
        <sjg:gridColumn
            name="branchCode" index="branchCode" title="Branch Code" width="120" sortable="true"
        />
        <sjg:gridColumn
            name="branchName" index="branchName" title="Branch Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" title="Currency Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" title="Currency Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="projectCode" index="projectCode" title="Project Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="projectName" index="projectName" title="Project Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="customerCode" index="customerCode" title="Customer Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="customerName" index="customerName" title="Customer Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="endUserCode" index="endUserCode" title="EndUser Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="endUserName" index="endUserName" title="EndUser Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="salesPersonCode" index="salesPersonCode" title="Sales Person Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="salesPersonName" index="salesPersonName" title="Sales Person Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="revision" index="revision" title="Revision" width="100" sortable="true"
        />   
        <sjg:gridColumn
            name="customerPurchaseOrderNo" index="customerPurchaseOrderNo" title="customerPurchaseOrderNo" width="100" sortable="true"
        />   
        <sjg:gridColumn
            name="discountPercent" index="discountPercent" title="Discount" width="80" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="totalAdditionalFeeAmount" index="totalAdditionalFeeAmount" title="TotalAdditionalFeeAmount" width="80" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="vatPercent" index="vatPercent" title="Vat" width="80" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="orderStatus" index="orderStatus" title="Order Status" width="80" sortable="true"
        />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgCustomerPurchaseOrder_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgCustomerPurchaseOrder_cancelButton" button="true">Cancel</sj:a>
</body>
</html>