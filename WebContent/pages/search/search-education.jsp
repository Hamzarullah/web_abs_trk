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
    
    var search_education_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgEducation_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_education_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Education!");
                return;
            }

            var data_search_education = $("#dlgSearch_education_grid").jqGrid('getRowData', selectedRowId);

            if (search_education_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"EducationCode",opener.document).val(data_search_education.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"EducationName", data_search_education.name);           
                
                $("#"+selectedRowID+"_"+id_document+id_subdoc+"EducationCode",opener.document).val(data_search_education.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+id_subdoc+"EducationName", data_search_education.name);           
            }
            else {
                $("#"+id_document+"\\."+"\\.code",opener.document).val(data_search_education.code);
                $("#"+id_document+"\\."+"\\.name",opener.document).val(data_search_education.name);
                
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_education.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_education.name);
            }

            window.close();
        });


        $("#dlgEducation_cancelButton").click(function(ev) { 
            data_search_education = null;
            window.close();
        });
    
    
        $("#btn_dlg_EducationSearch").click(function(ev) {
            $("#dlgSearch_education_grid").jqGrid("setGridParam",{url:"master/education-data?" + $("#frmEducationSearch").serialize(), page:1});
            $("#dlgSearch_education_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlEducationSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmEducationSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="searchEducation.code" name="searchEducation.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="searchEducation.name" name="searchEducation.name" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_EducationSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <%--<s:textfield id="searchEducationActiveStatus" name="searchEducationActiveStatus" readonly="true" size="5" style="display:none" value="Yes"></s:textfield>--%>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_education_grid"
                dataType="json"
                href="%{remoteurlEducationSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listEducationTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuEDUCATION').width()"
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

            <sj:a href="#" id="dlgEducation_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgEducation_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>