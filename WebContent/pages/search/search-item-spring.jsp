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
      
    var search_itemSpring_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgItemSpring_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_itemSpring_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Item Body Construction!");
                return;
            }
                
            var data_search_itemSpring = $("#dlgSearch_itemSpring_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemSpring_type === "grid" ) {
                
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemSpringCode",opener.document).val(data_search_itemSpring.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemSpringName", data_search_itemSpring.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemSpring.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemSpring.name);
                
            }

            window.close();
        });

        $("#dlgItemSpring_cancelButton").click(function(ev) { 
            data_search_itemSpring = null;
            window.close();
        });
    
        $("#btn_dlg_ItemSpringSearch").click(function(ev) {
            $("#dlgSearch_itemSpring_grid").jqGrid("setGridParam",{url:"master/item-spring-data?" + $("#frmItemSpringSearch").serialize(), page:1});
            $("#dlgSearch_itemSpring_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     });
    
</script>
<ball>
<s:url id="remoteurlItemSpringSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmItemSpringSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="itemSpringSearchCode" name="itemSpringSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="itemSpringSearchName" name="itemSpringSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ItemSpringSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_itemSpring_grid"
            dataType="json"
            href="%{remoteurlItemSpringSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listItemSpringTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuitemSpring').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />       
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgItemSpring_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgItemSpring_cancelButton" button="true">Cancel</sj:a>
</ball>
</html>