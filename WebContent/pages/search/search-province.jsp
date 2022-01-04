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
            overflow: scroll;
        }
    </style>
    
<script type = "text/javascript">
    
    var search_province_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgProvince_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_province_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Province!");
                return;
            }

            var data_search_province = $("#dlgSearch_province_grid").jqGrid('getRowData', selectedRowId);

            if (search_province_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"ProvinceCode",opener.document).val(data_search_province.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ProvinceName", data_search_province.name);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_province.code);
               $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_province.name);
               $("#"+id_document+"\\."+id_subdoc+"\\.island\\.code",opener.document).val(data_search_province.islandCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.island\\.name",opener.document).val(data_search_province.islandName);
               $("#"+id_document+"\\."+id_subdoc+"\\.island\\.country\\.code",opener.document).val(data_search_province.countryCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.island\\.country\\.name",opener.document).val(data_search_province.countryName);
            }

            window.close();
        });


        $("#dlgProvince_cancelButton").click(function(ev) { 
            data_search_province = null;
            window.close();
        });
    
    
        $("#btn_dlg_ProvinceSearch").click(function(ev) {
            $("#dlgSearch_province_grid").jqGrid("setGridParam",{url:"master/province-data?" + $("#frmProvinceSearch").serialize(), page:1});
            $("#dlgSearch_province_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlProvinceSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmProvinceSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="provinceSearchCode" name="provinceSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="provinceSearchName" name="provinceSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_ProvinceSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="provinceSearchActiveStatus" name="provinceSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_province_grid"
                dataType="json"
                href="%{remoteurlProvinceSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listProvinceTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuprovince').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="islandCode" index="islandCode" title="Island Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="islandName" index="islandName" title="Island Name" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="countryCode" index="countryCode" title="CountryCode" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="countryName" index="countryName" title="CountryName" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgProvince_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgProvince_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>