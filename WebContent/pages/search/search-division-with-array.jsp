<%-- 
    Document   : search-division-with-array
    Created on : Jul 16, 2019, 11:17:59 AM
    Author     : CHRIST
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
    
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
        }
        input{border-radius: 3px;height:18px}
    </style>
    
    
<script type = "text/javascript">
    var input_divisionCode;
    var input_divisionName;
    var input_divisionActiveStatus;
    
    var grid_input_division;
    var grid_rowID_division;
    var grid_cellName_division;
    
    var search_division_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_division_code = '<%= request.getParameter("iddivisioncode") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgDivision_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_division_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alert("Please Select Row Division");
                return;
            }

            var data_search_division = $("#dlgSearch_division_grid").jqGrid('getRowData', selectedRowId);

            if (search_division_type === "grid" ) {
              
                    var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                
                    var ids = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');

                    for(var i=0;i<ids.length;i++){
                        var data = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',ids[i]);
                 
                    }

                    $("#"+selectedRowID+"_"+id_document+"DivisionCode",opener.document).val(data_search_division.code);
                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"DivisionCodeChecker", data_search_division.code); 
                
                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"DivisionName", data_search_division.name); 
                
                
                
            }
            else {
             
                $("#"+id_document+"\\.division\\.code",opener.document).val(data_search_division.code);
                $("#"+id_document+"\\.division\\.name",opener.document).val(data_search_division.name);
                
            }
          
            
            window.close();
        });

        $("#dlgDivision_cancelButton").click(function(ev) { 
            data_search_division = null;
            window.close();
        });
    
        $("#btn_dlg_DivisionSearch").click(function(ev) {
            $("#divisionSearchCodeConcat").val(id_division_code);
            $("#dlgSearch_division_grid").jqGrid("setGridParam",{url:"master/division-search-data-with-array?" + $("#frmDivisionSearch").serialize(), page:1});
            $("#dlgSearch_division_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
     });
    
</script>
<body>


    <div class="ui-widget">
        <s:form id="frmDivisionSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="divisionSearchCode" name="divisionSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="divisionSearchName" name="divisionSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td><s:textfield id="divisionSearchCodeConcat" name="divisionSearchCodeConcat" size="50" cssStyle="display:none"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_DivisionSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_division_grid"
            dataType="json"
            href="%{remoteurlDivisionSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listDivisionTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuDivision').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="350" sortable="true"
        />
        </sjg:grid >
    </div>
<br></br>
    <sj:a href="#" id="dlgDivision_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgDivision_cancelButton" button="true">Cancel</sj:a>
</body>
</html>