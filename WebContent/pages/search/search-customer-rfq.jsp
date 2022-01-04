<%-- 
    Document   : search-customer
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
       
    var search_customer= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';  
    var id_ivt='<%= request.getParameter("idivt") %>';  
    
    jQuery(document).ready(function(){  
        $("#dlgCustomer_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_customer_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row Item!");
                return;
            }

            var data_search_customer = $("#dlgSearch_customer_grid").jqGrid('getRowData', selectedRowId);

            if (search_customer === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                }

            $("#"+selectedRowID+"_"+id_document+id_subdoc+"Code",opener.document).val(data_search_customer.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Code", data_search_customer.code);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Name", data_search_customer.name); 
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Phone1", data_search_customer.phone1);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Phone1", data_search_customer.phone2);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"Address", data_search_customer.address);
                 }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_customer.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_customer.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.phone1",opener.document).val(data_search_customer.phone1);
                $("#"+id_document+"\\."+id_subdoc+"\\.phone2",opener.document).val(data_search_customer.phone2);
                $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_customer.address);
                 }
            
            window.close();
        });

        $("#dlgCustomer_cancelButton").click(function(ev) { 
            data_search_customer = null;
            window.close();
        });
    
        $("#btn_dlg_CustomerSearch").click(function(ev) {
            $("#dlgSearch_customer_grid").jqGrid("setGridParam",{url:"master/customer-search-data?" + $("#frmCustomerSearch").serialize(), page:1});
            $("#dlgSearch_customer_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
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
        
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmCustomerSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="code" name="code" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="name" name="name" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_customer_grid"
            dataType="json"
            href="%{remoteurlCustomerSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCustomerTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuCustomer').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="350" sortable="true"
            />
            <sjg:gridColumn
                name="phone1" index="phone1" title="Phone" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="phone2" index="phone2" title="HandPhone" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="address" index="address" title="Address" width="100" sortable="true"
            />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgCustomer_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgCustomer_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


