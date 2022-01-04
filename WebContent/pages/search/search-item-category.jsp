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
    
    var search_itemCategory_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgItemCategory_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_itemCategory_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ItemCategory!");
                return;
            }

            var data_search_itemCategory = $("#dlgSearch_itemCategory_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemCategory_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemCategoryCode",opener.document).val(data_search_itemCategory.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemCategoryName", data_search_itemCategory.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemCategory.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemCategory.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemDivision\\.code",opener.document).val(data_search_itemCategory["itemDivision.code"]);
                $("#"+id_document+"\\."+id_subdoc+"\\.itemDivision\\.name",opener.document).val(data_search_itemCategory["itemDivision.name"]);
            }

            window.close();
        });


        $("#dlgItemCategory_cancelButton").click(function(ev) { 
            data_search_itemCategory = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemCategorySearch").click(function(ev) {
            $("#dlgSearch_itemCategory_grid").jqGrid("setGridParam",{url:"master/item-category-search?" + $("#frmItemCategorySearch").serialize(), page:1});
            $("#dlgSearch_itemCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlItemCategorySearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemCategorySearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="searchItemCategory.code" name="searchItemCategory.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="searchItemCategory.name" name="searchItemCategory.name" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemCategorySearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="searchItemCategory.activeStatus" name="searchItemCategory.activeStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_itemCategory_grid"
                dataType="json"
                href="%{remoteurlItemCategorySearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemCategory"
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
                    name="name" index="name" title="Name" width="250" sortable="true"
                />
                <sjg:gridColumn
                    name="itemDivision.code" index="itemDivision.code" title="Item Division Code" width="250" sortable="true"
                />
                <sjg:gridColumn
                    name="itemDivision.name" index="itemDivision.name" title="Item Division Name" width="250" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemCategory_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemCategory_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>