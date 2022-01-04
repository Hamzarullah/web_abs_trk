

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
       
    var search_customerOrderDocument= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_doctype= '<%= request.getParameter("iddoctype") %>';  
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgCustomerOrderDocument_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_customerOrderDocument_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Data!");
                return;
            }

            var data_search_customerOrderDocument = $("#dlgSearch_customerOrderDocument_grid").jqGrid('getRowData', selectedRowId);

            if (search_customerOrderDocument === "grid" ) {}
            else {
                $("#"+id_document+"\\.documentCode",opener.document).val(data_search_customerOrderDocument.documentCode);
                $("#"+id_document+"\\.customer\\.code",opener.document).val(data_search_customerOrderDocument.customerCode);
                $("#"+id_document+"\\.customer\\.name",opener.document).val(data_search_customerOrderDocument.customerName);
            }
            window.close();
        });

        $("#dlgCustomerOrderDocument_cancelButton").click(function(ev) { 
            data_search_customerOrderDocument = null;
            window.close();
        });
    
        $("#btn_dlg_CustomerOrderDocumentSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_customerOrderDocument_grid").jqGrid("setGridParam",{url:"sales/customer-order-document-search?" + $("#frmCustomerOrderDocumentSearch").serialize(), page:1});
            $("#dlgSearch_customerOrderDocument_grid").trigger("reloadGrid");
            formatDate();
            ev.preventDefault();
        });
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#customerOrderDocument\\.transactionFirstDate").val(firstDateFormat);
        $("#customerOrderDocument\\.transactionLastDate").val(lastDateFormat);
        $("#customerOrderDocument\\.documentType").val(id_doctype);
        
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
        var firstDate=$("#customerOrderDocument\\.transactionFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#customerOrderDocument\\.transactionFirstDate").val(firstDateFormat);

        var lastDate=$("#customerOrderDocument\\.transactionLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#customerOrderDocument\\.transactionLastDate").val(lastDateFormat);
    }
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmCustomerOrderDocumentSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="customerOrderDocument.transactionFirstDate" name="customerOrderDocument.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    To
                    <sj:datepicker id="customerOrderDocument.transactionLastDate" name="customerOrderDocument.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td>
                    <s:textfield id="customerOrderDocument.code" name="customerOrderDocument.code" label="Code "></s:textfield>
                    <s:textfield id="customerOrderDocument.documentType" name="customerOrderDocument.documentType" label="Code " hidden="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="customerOrderDocument.customerCode" name="customerOrderDocument.customerCode" PlaceHolder=" Code"></s:textfield>
                    <s:textfield id="customerOrderDocument.customerName" name="customerOrderDocument.customerName" PlaceHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerOrderDocumentSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_customerOrderDocument_grid"
            dataType="json"
            href="%{remoteurlCustomerOrderDocumentSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerOrderDocument"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuCustomerOrderDocument').width()"
        >
            <sjg:gridColumn
                name="documentCode" index="documentCode" key="documentCode" title="Code" width="200" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="BranchCode" width="100" sortable="true"
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
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgCustomerOrderDocument_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgCustomerOrderDocument_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


