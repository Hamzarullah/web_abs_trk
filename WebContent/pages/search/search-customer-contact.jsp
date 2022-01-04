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
    
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
    </style>
    
<script type = "text/javascript">
    
    var search_customerContact_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_customer= '<%= request.getParameter("idcustomer") %>';    
    jQuery(document).ready(function(){  
        
        $("#dlgCustomerContact_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_customerContact_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Price Type!");
                return;
            }

            var data_search_customerContact = $("#dlgSearch_customerContact_grid").jqGrid('getRowData', selectedRowId);

            if (search_customerContact_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"CustomerContactCode",opener.document).val(data_search_customerContact.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CustomerContactName", data_search_customerContact.name);
               
            }
            else {
                
                if(id_document === "customer"){
                    $("#"+id_document+"\\.defaultContactPerson\\.code",opener.document).val(data_search_customerContact.code);
                    $("#"+id_document+"\\.defaultContactPerson\\.name",opener.document).val(data_search_customerContact.name);
                   
                }
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_customerContact.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_customerContact.name); 
                
                
            }

            window.close();
        });


        $("#dlgCustomerContact_cancelButton").click(function(ev) { 
            data_search_customerContact = null;
            window.close();
        });
    
    
        $("#btn_dlg_CustomerContactSearch").click(function(ev) {

            $("#dlgSearch_customerContact_grid").jqGrid("setGridParam",{url:"master/customer-contact-search-data?customerCode="+id_customer+"&" + $("#frmPriceTypeSearch").serialize(), page:1});
            $("#dlgSearch_customerContact_grid").trigger("reloadGrid");
            ev.preventDefault();
        
        });
     });
    
</script>
    
<body>
<s:url id="remoteurlCustomerContactSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmPriceTypeSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="customerContactSearchCode" name="customerContactSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="customerContactSearchName" name="customerContactSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerContactSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="customerContactSearchActiveStatus" name="customerContactSearchActiveStatus" readonly="false" size="5" style="display:none" value="True"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_customerContact_grid"
                dataType="json"
                href="%{remoteurlCustomerContactSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listCustomerContactTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnucustomerContact').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgCustomerContact_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgCustomerContact_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>