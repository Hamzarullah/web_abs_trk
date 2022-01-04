
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="sjt" uri="/struts-jquery-tree-tags"%>


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
    
    
    var search_role_type = '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    
    jQuery(document).ready(function(){
        
        $("#btn_dlg_RoleSearch").click(function(ev) {
            $("#dlgSearch_role_grid").jqGrid("clearGridData");
            $("#dlgSearch_role_grid").jqGrid("setGridParam",{url:"security/role-search?" + $("#frmRoleSearch").serialize(), page:1});
            $("#dlgSearch_role_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#dlgRole_okButton").click(function(ev){
            
            selectedRowId = $("#dlgSearch_role_grid").jqGrid("getGridParam","selrow");
        
            if(selectedRowId == null){
                alert("Please Select Row Role");
                return;
            }

            var data_search_role = $("#dlgSearch_role_grid").jqGrid('getRowData', selectedRowId);

            if (search_role_type == "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                
                 $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RoleCode", data_search_role.code);
                 $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"RoleName", data_search_role.name);            
            }
            else {
                $("#"+id_document+"\\.role\\.code",opener.document).val(data_search_role.code);
                $("#"+id_document+"\\.role\\.name",opener.document).val(data_search_role.name);
            }
            window.close();
        });
        
        $("dlgRole_cancelButton").click(function(ev){
            window.close();
        });
        
    });
    
</script>
<body>
<s:url id="remoteurlRoleSearch" action="role-search" />
<div class="ui-widget">
        <s:form id="frmRoleSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="searchRole.code" name="searchRole.code" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="searchRole.name" name="searchRole.name" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_RoleSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_role_grid"
            dataType="json"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listRole"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnurole').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="300" sortable="true"
            />
        </sjg:grid > 
    </div>
    <br></br>
    <sj:a href="#" id="dlgRole_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgRole_cancelButton" onclick="dlgRole_cancelButton()" button="true">Cancel</sj:a>
</body>
</html>
