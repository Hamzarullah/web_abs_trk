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
    
    var search_itemSubCategory_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgItemSubCategory_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_itemSubCategory_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ItemSubCategory!");
                return;
            }

            var data_search_itemSubCategory = $("#dlgSearch_itemSubCategory_grid").jqGrid('getRowData', selectedRowId);

            if (search_itemSubCategory_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ItemSubCategoryCode",opener.document).val(data_search_itemSubCategory.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ItemSubCategoryName", data_search_itemSubCategory.name);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_itemSubCategory.code);
               $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_itemSubCategory.name);
               $("#"+id_document+"\\."+id_subdoc+"\\.itemCategory\\.code",opener.document).val(data_search_itemSubCategory.itemCategoryCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.itemCategory\\.name",opener.document).val(data_search_itemSubCategory.itemCategoryName);
               $("#"+id_document+"\\."+id_subdoc+"\\.itemCategory\\.itemDivision\\.code",opener.document).val(data_search_itemSubCategory.itemDivisionCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.itemCategory\\.itemDivision\\.name",opener.document).val(data_search_itemSubCategory.itemDivisionName);
            }

            window.close();
        });


        $("#dlgItemSubCategory_cancelButton").click(function(ev) { 
            data_search_itemSubCategory = null;
            window.close();
        });
    
    
        $("#btn_dlg_ItemSubCategorySearch").click(function(ev) {
            $("#dlgSearch_itemSubCategory_grid").jqGrid("setGridParam",{url:"master/item-sub-category-data?" + $("#frmItemSubCategorySearch").serialize(), page:1});
            $("#dlgSearch_itemSubCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlItemSubCategorySearch" action="" />
        <div class="ui-widget">
            <s:form id="frmItemSubCategorySearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="itemSubCategorySearchCode" name="itemSubCategorySearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="itemSubCategorySearchName" name="itemSubCategorySearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ItemSubCategorySearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="itemSubCategorySearchActiveStatus" name="itemSubCategorySearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_itemSubCategory_grid"
                dataType="json"
                href="%{remoteurlItemSubCategorySearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listItemSubCategoryTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuitemSubCategory').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                 <sjg:gridColumn
                    name="itemCategoryCode" index="itemCategoryCode" key="itemCategory" title="Item Product Head Code" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="itemCategoryName" index="itemCategoryName" title="Item Product Category Name" width="330" sortable="true"
                />
                 <sjg:gridColumn
                    name="itemDivisionCode" index="itemDivisionCode" key="itemDivision" title="Item Division Code" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="itemDivisionName" index="itemDivisionName" title="Item Division Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgItemSubCategory_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgItemSubCategory_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>