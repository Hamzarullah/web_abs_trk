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
    
    var search_city_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgCity_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_city_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row City!");
                return;
            }

            var data_search_city = $("#dlgSearch_city_grid").jqGrid('getRowData', selectedRowId);

            if (search_city_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"CityCode",opener.document).val(data_search_city.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CityName", data_search_city.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_city.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_city.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.province\\.code",opener.document).val(data_search_city.provinceCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.province\\.name",opener.document).val(data_search_city.provinceName);
                $("#"+id_document+"\\."+id_subdoc+"\\.province\\.island\\.code",opener.document).val(data_search_city.provinceIslandCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.province\\.island\\.name",opener.document).val(data_search_city.provinceIslandName);
                $("#"+id_document+"\\."+id_subdoc+"\\.province\\.island\\.country\\.code",opener.document).val(data_search_city.provinceCountryCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.province\\.island\\.country\\.name",opener.document).val(data_search_city.provinceCountryName);
            }

            window.close();
        });


        $("#dlgCity_cancelButton").click(function(ev) { 
            data_search_city = null;
            window.close();
        });
    
    
        $("#btn_dlg_CitySearch").click(function(ev) {
            $("#dlgSearch_city_grid").jqGrid("setGridParam",{url:"master/city-data?" + $("#frmCitySearch").serialize(), page:1});
            $("#dlgSearch_city_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlCitySearch" action="" />
        <div class="ui-widget">
            <s:form id="frmCitySearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="citySearchCode" name="citySearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="citySearchName" name="citySearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_CitySearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="citySearchActiveStatus" name="citySearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_city_grid"
                dataType="json"
                href="%{remoteurlCitySearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listCityTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnucity').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="150" sortable="true"
                />
                 <sjg:gridColumn
                    name="provinceCode" index="provinceCode" title="Province Code" width="125" sortable="true" 
                />
                <sjg:gridColumn
                    name="provinceName" index="provinceName" title="Province Name" width="150" sortable="true" 
                />
                 <sjg:gridColumn
                    name="provinceIslandCode" index="provinceIslandCode" title="Island Code" width="125" sortable="true" 
                />
                <sjg:gridColumn
                    name="provinceIslandName" index="provinceIslandName" title="Country Name" width="150" sortable="true" 
                />
                <sjg:gridColumn
                    name="provinceCountryCode" index="provinceCountryCode" title="Country Name" width="125" sortable="true" 
                />
                <sjg:gridColumn
                    name="provinceCountryName" index="provinceCountryName" title="Country" width="150" sortable="true" 
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgCity_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgCity_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>