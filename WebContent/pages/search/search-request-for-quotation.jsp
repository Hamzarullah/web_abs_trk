<%-- 
    Document   : search-requestForQuotation
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
       
    var search_requestForQuotation= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';  
    var id_ivt='<%= request.getParameter("idivt") %>';  
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgRequestForQuotation_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_requestForQuotation_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Item!");
                return;
            }

            var data_search_requestForQuotation = $("#dlgSearch_requestForQuotation_grid").jqGrid('getRowData', selectedRowId);

            if (search_requestForQuotation === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                }

            $("#"+selectedRowID+"_"+id_document+id_subdoc+"Code",opener.document).val(data_search_requestForQuotation.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Code", data_search_requestForQuotation.code);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Name", data_search_requestForQuotation.name); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Phone1", data_search_requestForQuotation.phone1);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Phone1", data_search_requestForQuotation.phone2);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Address", data_search_requestForQuotation.address);
                 }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_requestForQuotation.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.code",opener.document).val(data_search_requestForQuotation.branchCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.branch\\.name",opener.document).val(data_search_requestForQuotation.branchName);
                $("#"+id_document+"\\.branch\\.code",opener.document).val(data_search_requestForQuotation.branchCode);
                $("#"+id_document+"\\.branch\\.name",opener.document).val(data_search_requestForQuotation.branchName);
                $("#"+id_document+"\\."+id_subdoc+"\\.project\\.code",opener.document).val(data_search_requestForQuotation.projectCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.project\\.name",opener.document).val(data_search_requestForQuotation.projectName);
                $("#"+id_document+"\\.project\\.code",opener.document).val(data_search_requestForQuotation.projectCode);
                $("#"+id_document+"\\.project\\.name",opener.document).val(data_search_requestForQuotation.projectName);
                $("#"+id_document+"\\."+id_subdoc+"\\.tenderNo",opener.document).val(data_search_requestForQuotation.tenderNo);
                $("#"+id_document+"\\.tenderNo",opener.document).val(data_search_requestForQuotation.tenderNo);
                $("#"+id_document+"\\."+id_subdoc+"\\.subject",opener.document).val(data_search_requestForQuotation.subject);
                $("#"+id_document+"\\.subject",opener.document).val(data_search_requestForQuotation.subject);
                $("#"+id_document+"\\."+id_subdoc+"\\.orderStatus",opener.document).val(data_search_requestForQuotation.orderStatus);
                $("#"+id_document+"\\.orderStatus",opener.document).val(data_search_requestForQuotation.orderStatus);
                $("#"+id_document+"\\."+id_subdoc+"\\.currency\\.code",opener.document).val(data_search_requestForQuotation.currencyCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.currency\\.name",opener.document).val(data_search_requestForQuotation.currencyName);
                $("#"+id_document+"\\.currency\\.code",opener.document).val(data_search_requestForQuotation.currencyCode);
                $("#"+id_document+"\\.currency\\.name",opener.document).val(data_search_requestForQuotation.currencyName);
                $("#"+id_document+"\\.customer\\.code",opener.document).val(data_search_requestForQuotation.customerCode);
                $("#"+id_document+"\\.customer\\.name",opener.document).val(data_search_requestForQuotation.customerName);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.code",opener.document).val(data_search_requestForQuotation.customerCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.customer\\.name",opener.document).val(data_search_requestForQuotation.customerName);
                $("#"+id_document+"\\."+id_subdoc+"\\.endUser\\.code",opener.document).val(data_search_requestForQuotation.endUserCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.endUser\\.name",opener.document).val(data_search_requestForQuotation.endUserName);
                $("#"+id_document+"\\.endUser\\.code",opener.document).val(data_search_requestForQuotation.endUserCode);
                $("#"+id_document+"\\.endUser\\.name",opener.document).val(data_search_requestForQuotation.endUserName);
                $("#"+id_document+"\\."+id_subdoc+"\\.attn",opener.document).val(data_search_requestForQuotation.attn);
                $("#"+id_document+"\\.attn",opener.document).val(data_search_requestForQuotation.attn);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesPerson\\.code",opener.document).val(data_search_requestForQuotation.salesPersonCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.salesPerson\\.name",opener.document).val(data_search_requestForQuotation.salesPersonName);
                $("#"+id_document+"\\.salesPerson\\.code",opener.document).val(data_search_requestForQuotation.salesPersonCode);
                $("#"+id_document+"\\.salesPerson\\.name",opener.document).val(data_search_requestForQuotation.salesPersonName);
                if(id_document==="salesQuotation"){
                    window.opener.salesQuotationRequestForQuotationLoad(data_search_requestForQuotation.orderStatus);
                }
            }
            
            window.close();
        });

        $("#dlgRequestForQuotation_cancelButton").click(function(ev) { 
            data_search_requestForQuotation = null;
            window.close();
        });
    
        $("#btn_dlg_RequestForQuotationSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_requestForQuotation_grid").jqGrid("setGridParam",{url:"sales/request-for-quotation-search-data?" + $("#frmRequestForQuotationSearch").serialize(), page:1});
            $("#dlgSearch_requestForQuotation_grid").trigger("reloadGrid");
            formatDate();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#requestForQuotationSearchFirstDate").val(firstDateFormat);
        $("#requestForQuotationSearchLastDate").val(lastDateFormat);
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
        var firstDate=$("#requestForQuotationSearchFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#requestForQuotationSearchFirstDate").val(firstDateFormat);

        var lastDate=$("#requestForQuotationSearchLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#requestForQuotationSearchLastDate").val(lastDateFormat);
    }
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmRequestForQuotationSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="requestForQuotationSearchCode" name="requestForQuotationSearchCode" label="Code "></s:textfield></td>
            </tr>
             <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="requestForQuotationSearchFirstDate" name="requestForQuotationSearchFirstDate" size="15" displayFormat="dd/mm/yy"  showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    To
                    <sj:datepicker id="requestForQuotationSearchLastDate" name="requestForQuotationSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_RequestForQuotationSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_requestForQuotation_grid"
            dataType="json"
            href="%{remoteurlRequestForQuotationSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listRequestForQuotationTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuRequestForQuotation').width()"
        >
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="tenderNo" index="tenderNo" title="Tender No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="customerName" index="customerName" title="Customer" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="endUserName" index="endUserName" title="End User" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" 
                title="Transaction Date" width="130" formatter="date"  
                formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s' }"  sortable="true" 
            />
            <sjg:gridColumn
                name="projectName" index="projectName" title="Project" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" title="branch code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" title="branch name" width="200" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="projectCode" index="projectCode" title="project code" width="1000" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="subject" index="subject" title="subject" width="200" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="currencyCode" index="currencyCode" title="currency code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="currencyName" index="currencyName" title="currency name" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="customerCode" index="customerCode" title="customer code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="endUserCode" index="endUserCode" title="end user code" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="attn" index="attn" title="attn" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="subject" index="subject" title="subject" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="salesPersonCode" index="salesPersonCode" title="sales person name" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="salesPersonName" index="salesPersonName" title="sales person name" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="orderStatus" index="orderStatus" title="order Status" width="50" sortable="true" hidden="true"
            />
           
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgRequestForQuotation_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgRequestForQuotation_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


