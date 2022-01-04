<%-- 
    Document   : search-branch-with-array
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
    var input_branchCode;
    var input_branchName;
    var input_branchActiveStatus;
    
    var grid_input_branch;
    var grid_rowID_branch;
    var grid_cellName_branch;
    
    var search_branch_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_branch_code = '<%= request.getParameter("idbranchcode") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgBranch_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_branch_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alert("Please Select Row Branch");
                return;
            }

            var data_search_branch = $("#dlgSearch_branch_grid").jqGrid('getRowData', selectedRowId);

            if (search_branch_type === "grid" ) {
              
                    var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                
                    var ids = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');

                    for(var i=0;i<ids.length;i++){
                        var data = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',ids[i]);
                 
                    }

                    $("#"+selectedRowID+"_"+id_document+"BranchCode",opener.document).val(data_search_branch.code);
                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchCodeChecker", data_search_branch.code); 
//                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchCode", data_search_branch.code); 
                
                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BranchName", data_search_branch.name); 
                
                
                
            }
            else {
             
                $("#"+id_document+"\\.branch\\.code",opener.document).val(data_search_branch.code);
                $("#"+id_document+"\\.branch\\.name",opener.document).val(data_search_branch.name);
                
            }
          
            
            window.close();
        });

        $("#dlgBranch_cancelButton").click(function(ev) { 
            data_search_branch = null;
            window.close();
        });
    
        $("#btn_dlg_BranchSearch").click(function(ev) {
            $("#branchSearchCodeConcat").val(id_branch_code);
            $("#dlgSearch_branch_grid").jqGrid("setGridParam",{url:"master/branch-search-data-with-array?" + $("#frmBranchSearch").serialize(), page:1});
            $("#dlgSearch_branch_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
     });
    
</script>
<body>


    <div class="ui-widget">
        <s:form id="frmBranchSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="branchSearchCode" name="branchSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="branchSearchName" name="branchSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td><s:textfield id="branchSearchCodeConcat" name="branchSearchCodeConcat" size="50" cssStyle="display:none"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_BranchSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_branch_grid"
            dataType="json"
            href="%{remoteurlBranchSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listBranchTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuBranch').width()"
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
    <sj:a href="#" id="dlgBranch_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgBranch_cancelButton" button="true">Cancel</sj:a>
</body>
</html>