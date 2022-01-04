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
    
    var search_island_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgIsland_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_island_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Island!");
                return;
            }

            var data_search_island = $("#dlgSearch_island_grid").jqGrid('getRowData', selectedRowId);

            if (search_island_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"IslandCode",opener.document).val(data_search_island.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"IslandName", data_search_island.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_island.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_island.name);
            }

            window.close();
        });


        $("#dlgIsland_cancelButton").click(function(ev) { 
            data_search_island = null;
            window.close();
        });
    
    
        $("#btn_dlg_IslandSearch").click(function(ev) {
            $("#dlgSearch_island_grid").jqGrid("setGridParam",{url:"master/island-search?" + $("#frmIslandSearch").serialize(), page:1});
            $("#dlgSearch_island_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlIslandSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmIslandSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="searchIsland.code" name="searchIsland.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="searchIsland.name" name="searchIsland.name" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_IslandSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="searchIsland.activeStatus" name="searchIsland.activeStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_island_grid"
                dataType="json"
                href="%{remoteurlIslandSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listIsland"
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

            <sj:a href="#" id="dlgIsland_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgIsland_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>