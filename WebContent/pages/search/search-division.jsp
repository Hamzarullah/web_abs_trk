
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
       
    var search_division_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgDivision_okButton").click(function(ev) { 
            
            selectedRowId = $("#division_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Division");
                return;
            }

            var data_search_division = $("#division_grid").jqGrid('getRowData', selectedRowId);

            if (search_division_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"DivisionCode",opener.document).val(data_search_division.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"DivisionName", data_search_division.name);           
            }else{
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_division.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_division.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.department\\.code",opener.document).val(data_search_division.departmentCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.department\\.name",opener.document).val(data_search_division.departmentName);
            }

            window.close();
        });

        $("#dlgDivision_cancelButton").click(function(ev) { 
            data_search_division = null;
            window.close();
        });
    
        $("#btn_dlg_DivisionSearch").click(function(ev) {  
            $("#division_grid").jqGrid("setGridParam",{url:"master/division-search-data-with-user-auth?" + $("#frmDivisionSearch").serialize(), page:1});
            $("#division_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
     });
    
</script>
<body>
    <s:url id="remoteurlDivisionSearch" action="" />

        <div class="ui-widget">
            <s:form id="frmDivisionSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="divisionSearchCodee" name="divisionSearchCode" label="Code "></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td>
                        <s:textfield id="divisionSearchName" name="divisionSearchName" size="50"></s:textfield>
                    </td>
                    <td align="right">
                        <s:textfield id="divisionSearchAccountType" name="divisionSearchAccountType" readonly="false" size="5" cssStyle="Display:none" value="S"></s:textfield>
                    </td>
                    <td align="right">
                        <s:textfield id="divisionSearchActiveStatus" name="divisionSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_DivisionSearch" button="true">Search</sj:a></td>
                </tr>
            </table>
            </s:form>
        </div>
        <div id="divisionGrid">
        <sjg:grid
            id="division_grid"
            dataType="json"
            href="%{remoteurlDivision}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listDivisionTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="300" sortable="true"
            />
            <sjg:gridColumn
                name="departmentCode" index="departmentCode" title="Department" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="departmentName" index="departmentName" title="Department" width="300" sortable="true"
            />
            <sjg:gridColumn
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />
        </sjg:grid >
    </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgDivision_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgDivision_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>