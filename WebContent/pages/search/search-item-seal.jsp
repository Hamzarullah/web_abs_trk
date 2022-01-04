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
      
    var search_itemSeal_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgItemSeal_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_itemSeal_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ItemSeal!");
                return;
            }
                
            var data_search_itemSeal = $("#dlgSearch_itemSeal_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemSeal_type === "grid" ) {
                
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemSealCode",opener.document).val(data_search_itemSeal.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemSealName", data_search_itemSeal.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemSeal.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemSeal.name);
                
            }

            window.close();
        });

        $("#dlgItemSeal_cancelButton").click(function(ev) { 
            data_search_itemSeal = null;
            window.close();
        });
    
        $("#btn_dlg_ItemSealSearch").click(function(ev) {
            $("#dlgSearch_itemSeal_grid").jqGrid("setGridParam",{url:"master/item-seal-data?" + $("#frmItemSealSearch").serialize(), page:1});
            $("#dlgSearch_itemSeal_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     });
    
</script>
<seal>
<s:url id="remoteurlItemSealSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmItemSealSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="itemSealSearchCode" name="itemSealSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="itemSealSearchName" name="itemSealSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ItemSealSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_itemSeal_grid"
            dataType="json"
            href="%{remoteurlItemSealSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listItemSealTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuitemSeal').width()"
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
    <sj:a href="#" id="dlgItemSeal_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgItemSeal_cancelButton" button="true">Cancel</sj:a>
</seal>
</html>