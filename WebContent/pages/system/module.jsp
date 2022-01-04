
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #moduleItemDetail_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
            
    $(document).ready(function(){
        hoverButton();
               
        $('#btnModuleUpdate').click(function(ev) {
            
            var url = "system/module-input";
            var params = "";
            pageLoad(url, params, "#tabmnuMODULE");
 
            ev.preventDefault();
        });
        
        $('#btnModuleRefresh').click(function(ev) {
            var url = "system/module";
            var params = "";
            pageLoad(url, params, "#tabmnuMODULE");   
        });
        
        $('#btnModule_search').click(function(ev) {
            $("#module_grid").jqGrid("clearGridData");
            $("#module_grid").jqGrid("setGridParam",{url:"system/module-data?" + $("#frmModuleSearchInput").serialize()});
            $("#module_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
    });//EOF Ready
        
</script>
<s:url id="remoteurlModule" action="module-json" />
<b>MODULE</b>
<hr>
<br class="spacer" />
    <sj:div id="moduleButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnModuleUpdate" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_update.png" border="0" title="Update"/></a>
        <a href="#" id="btnModuleRefresh" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />
    <div id="ModuleInputSearch" class="content ui-widget">
        <s:form id="frmModuleSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Module</b></td>
                    <td>
                        <s:textfield id="moduleSearchName" name="moduleSearchName" size="15" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnModule_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
    <br class="spacer" />
                     
    <div id="moduleGrid">
        <sjg:grid
            id="module_grid"
            dataType="json"
            href="%{remoteurlModule}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listModuleTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="300" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="name" index="name" key="name" title="Name" width="400" sortable="true" 
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="BranchCode" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch Name" width="200" sortable="true" 
            />
            <sjg:gridColumn
                name="companyCode" index="companyCode" key="companyCode" title="Company Code" width="100" sortable="true" 
            />
            <sjg:gridColumn
                name="companyName" index="companyName" key="companyName" title="Company Name" width="200" sortable="true" 
            />
        </sjg:grid>
    </div>
    

