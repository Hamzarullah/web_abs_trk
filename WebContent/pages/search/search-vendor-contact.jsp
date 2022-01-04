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
    
    var search_vendorContact_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_vendor= '<%= request.getParameter("idvendor") %>';    
    jQuery(document).ready(function(){  
        
        $("#dlgVendorContact_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_vendorContact_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Price Type!");
                return;
            }

            var data_search_vendorContact = $("#dlgSearch_vendorContact_grid").jqGrid('getRowData', selectedRowId);

            if (search_vendorContact_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"VendorContactCode",opener.document).val(data_search_vendorContact.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"VendorContactName", data_search_vendorContact.name);
               
            }
            else {
                
                if(id_document === "vendor"){
                    $("#"+id_document+"\\.defaultContactPerson\\.code",opener.document).val(data_search_vendorContact.code);
                    $("#"+id_document+"\\.defaultContactPerson\\.name",opener.document).val(data_search_vendorContact.name);
                   
                }
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_vendorContact.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_vendorContact.name); 
                
                
            }

            window.close();
        });


        $("#dlgVendorContact_cancelButton").click(function(ev) { 
            data_search_vendorContact = null;
            window.close();
        });
    
    
        $("#btn_dlg_VendorContactSearch").click(function(ev) {

            $("#dlgSearch_vendorContact_grid").jqGrid("setGridParam",{url:"master/vendor-contact-search-data?vendorCode="+id_vendor+"&" + $("#frmPriceTypeSearch").serialize(), page:1});
            $("#dlgSearch_vendorContact_grid").trigger("reloadGrid");
            ev.preventDefault();
        
        });
     });
    
</script>
    
<body>
<s:url id="remoteurlVendorContactSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmPriceTypeSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="vendorContactSearchCode" name="vendorContactSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="vendorContactSearchName" name="vendorContactSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_VendorContactSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="vendorContactSearchActiveStatus" name="vendorContactSearchActiveStatus" readonly="false" size="5" style="display:none" value="True"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_vendorContact_grid"
                dataType="json"
                href="%{remoteurlVendorContactSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listVendorContactTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuvendorContact').width()"
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

            <sj:a href="#" id="dlgVendorContact_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgVendorContact_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>