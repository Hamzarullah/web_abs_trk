<%-- 
    Document   : vat-in
    Created on : Dec 10, 2019, 2:03:11 PM
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
      

        $('#btnVatInRefresh').click(function(ev) {
            var url = "finance/vat-in";
            var params = "";
            pageLoad(url, params, "#tabmnuVAT_IN");
        });
        
        
        $('#btnVatIn_search').click(function(ev) {
            formatDatePORelease();

            $("#vatIn_grid").jqGrid("clearGridData");
            $("#vatIn_grid").jqGrid("setGridParam",{url:"finance/vat-in-data?" + $("#frmVatInSearchInput").serialize()});
            $("#vatIn_grid").trigger("reloadGrid");

                       
            formatDatePORelease();
        });
    });
        
    function formatDatePORelease(){
        var firstDate=$("#vatInSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#vatInSearchFirstDate").val(firstDateValue);

        var lastDate=$("#vatInSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#vatInSearchLastDate").val(lastDateValue);
    }
    
</script>
<s:url id="remoteurlVatIn" action="vat-in-data" />
<b>VAT IN</b>
<hr>
<br class="spacer" />
<sj:div id="vatInButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <a href="#" id="btnVatInRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
</sj:div>
    
<br class="spacer" />

<div id="vatInSearch" class="content ui-widget">
<br class="spacer" />
<s:form id="frmVatInSearchInput">
   <table cellpadding="2" cellspacing="2">
       <tr>
            <td align="right">Document No</td>
            <td>
                <s:textfield id="vatInSearchDocumentCode" name="vatInSearchDocumentCode" placeHolder="Document No" size="30"></s:textfield>
            </td>
             <td width="2%"/>
            <td align="right">Vendor Code</td>
            <td>
                <s:textfield id="vatInSearchVendorCode" name="vatInSearchVendorCode" placeHolder="Vendor Code" size="30"></s:textfield>
            </td>
            <td width="2%"/>
            <td align="right">Vendor Name</td>
            <td>
                <s:textfield id="vatInSearchVendorName" name="vatInSearchVendorName" placeHolder="Vendor Name" size="30"></s:textfield>
            </td>
        </tr>
       <tr>
            <td align="right"><B>Period *</B></td>
            <td colspan="4">
                <sj:datepicker id="vatInSearchFirstDate" name="vatInSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                <B>To *</B>
                <sj:datepicker id="vatInSearchLastDate" name="vatInSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
            </td>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
            <td/>
        </tr>
        
       
   </table>
   <br class="spacer" />
   <sj:a href="#" id="btnVatIn_search" button="true">Search</sj:a>
   <br class="spacer" />

</s:form>
</div>
<br class="spacer" />
<br class="spacer" />
                     
    <!-- GRID HEADER -->    
<div id="VatInGrid">
    <sjg:grid
        id="vatIn_grid"
        dataType="json"
        href="%{remoteurlVatIn}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorInvoiceTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        editinline="true"
        width="$('#tabmnuvatin').width()"
    >
        
        <sjg:gridColumn
            name="documentCode" index="documentCode" key="documentCode" title="Document No" width="150" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="documentType" index="documentType" key="documentType" title="DocumentType" width="100" sortable="true" 
        />
         <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="130" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
        />
        <sjg:gridColumn
            name = "taxInvoiceNo" id="taxInvoiceNo" index = "taxInvoiceNo" key = "taxInvoiceNo" 
            title = "Tax Invoice No" width = "150" sortable = "true" align="center"
        />
           <sjg:gridColumn
            name="taxInvoiceDate" index="taxInvoiceDate" key="taxInvoiceDate" 
            title="Tax Invoice Date" width="130" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
        />
        <sjg:gridColumn
            name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="120" sortable="true" align="center"
        />
         <sjg:gridColumn
            name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="120" sortable="true"  align="left" 
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="120" sortable="true"  align="left" 
        />
        
        <sjg:gridColumn
            name="totalTransactionAmount" index="totalTransactionAmount" key="totalTransactionAmount" title="Total Transaction Amount" width="200" sortable="true" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}" hidden="true"
        />
        
         <sjg:gridColumn
            name="discountAmount" index="discountAmount" key="discountAmount" title="Discount Amount" width="150" sortable="true" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}" hidden="true"
        />
          <sjg:gridColumn
            name="downPaymentAmount" index="downPaymentAmount" key="downPaymentAmount" title="Down Payment Amount" width="150" sortable="true" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}" hidden="true"
        />
           <sjg:gridColumn
            name="taxBaseAmount" index="taxBaseAmount" key="taxBaseAmount" title="Document Amount" width="150" sortable="true" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}" 
        />
        <sjg:gridColumn
            name="vatAmount" index="vatAmount" key="vatAmount" title="VAT Amount" width="150" sortable="true" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}" 
        />
        <sjg:gridColumn
            name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" title="Grand Total Amount" width="150" sortable="true" formatter="number" align="right" formatoptions= "{ thousandsSeparator:','}" hidden="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="RefNo" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="250" sortable="true"
        />
    </sjg:grid>
</div>