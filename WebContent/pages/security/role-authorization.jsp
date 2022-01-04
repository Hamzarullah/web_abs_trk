

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<!-- ...............................-->
<!--  Ini Hanya untuk menampilkan Data   -->
<!-- ...............................-->

<s:url id="remoteurlroleAuthorizationRole" action="role-authorization-json" />
<s:url id="remotedetailRoleAuthorizationurl" action="role-authorization-data" />
<style>
    
    input{border-radius: 3px;height:18px}
    input[readonly="readonly"] { background:#FFF1A0 }
</style>
<script type="text/javascript">
                
    function reloadGrid() {
        $("#roleAuthorizationRole_grid").trigger("reloadGrid");
        $("#roleAuthorization_grid").trigger("reloadGrid");
    };
    
    function getRoleAuthorization(){
       var role = $("#roleAuthorizationRole_grid").jqGrid("getRowData", selectedRowID);

       $("#roleAuthorization_grid").jqGrid("setGridParam",{url:"security/role-authorization-detail-data?headerCode=" + role.code});
       $("#roleAuthorization_grid").jqGrid("setCaption", "Role  Authorization : " + role.code);
       $("#roleAuthorization_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("roleAuthorization");
        
        $.subscribe("role_Authorization_Role_grid_onSelect", function(event, data){
           var selectedRowID = $("#roleAuthorizationRole_grid").jqGrid("getGridParam", "selrow"); 
           var role = $("#roleAuthorizationRole_grid").jqGrid("getRowData", selectedRowID);
                      
           $("#roleAuthorization_grid").jqGrid("setGridParam",{url:"security/role-authorization-detail-data?headerCode=" + role.code});
           $("#roleAuthorization_grid").jqGrid("setCaption", "Role  Authorization : " + role.code);
           $("#roleAuthorization_grid").trigger("reloadGrid");
        });
        
        $('#btnRoleAuthorizationUpdate').click(function(ev) {
           var selectRowId = $("#roleAuthorizationRole_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId == null) {
                alert("Please Select Row");
            }
            else {
                var role = $("#roleAuthorizationRole_grid").jqGrid('getRowData', selectRowId);
                var url = "security/role-authorization-input";
                var params = "roleAuthorizationUpdateMode=true" + "&role.code=" + role.code;
                
                pageLoad(url, params, "#tabmnuROLE_AUTHORIZATION");
            }
            ev.preventDefault();
        });
        
        $('#btnRoleAuthorizationRefresh').click(function(ev) {
            reloadGrid();    
        });
                
    });
</script>
    
    <b>ROLE AUTHORIZATION</b>
    <hr>
    <br class="spacer" />
    <sj:div id="roleAuthorizationButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <!--<a href="#" id="btnRoleAuthorizationNew" class="ikb-button ui-state-default ui-corner-left" hidden="true"><img src="images/button_new.png" border="0" /></a>-->
        <a href="#" id="btnRoleAuthorizationUpdate" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_update.png" border="0" /></a>
        <!--<a href="#" id="btnRoleAuthorizationDelete" class="ikb-button ui-state-default" hidden="true"><img src="images/button_remove.png" border="0" /></a>-->
        <a href="#" id="btnRoleAuthorizationRefresh" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_refresh.png" border="0" /></a>
        <!--<a href="#" id="btnRoleAuthorizationPrint" class="ikb-button ui-state-default ui-corner-right" hidden="true"><img src="images/button_printer.png" border="0" /></a>-->
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />
  
    <!-- GRID HEADER -->    
    <div id="roleAuthorizationRoleGrid">
        <sjg:grid
            id="roleAuthorizationRole_grid"
            dataType="json"
            href="%{remoteurlroleAuthorizationRole}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listRole"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="role_Authorization_Role_grid_onSelect"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name = "name" index = "name" key = "name" title = "Name" width = "300" sortable = "true"
        />
        </sjg:grid >
    </div>
        
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="roleAuthorizationGrid">
        <sjg:grid
            id="roleAuthorization_grid"
            caption="Role Authorization"
            dataType="json"
            href="%{remotedetailRoleAuthorizationurl}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listRoleAuthorization"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="720"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="headerCode" index="headerCode" key="headerCode" title="HeaderCode" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name = "authorization.code" index = "authorization.code" key = "authorization.code" title = "Authorization" width = "100" hidden="true"
        />
        <sjg:gridColumn
            name = "authorization.module.parentCode" index = "authorization.module.parentCode" key = "authorization.module.parentCode" title = "Parent Code" width = "150" sortable = "true"
        />
        <sjg:gridColumn
            name = "authorization.module.code" index = "authorization.module.code" key = "authorization.module.code" title = "Module" width = "150" sortable = "true" hidden="true"
        />
        <sjg:gridColumn
            name = "authorization.module.text" index = "authorization.module.text" key = "authorization.module.text" title = "Module Name" width = "400" sortable = "false"
        />
        <sjg:gridColumn
            name = "saveAuthority" index = "saveAuthority" key = "saveAuthority" title = "Save" width = "50" formatter="checkbox" align="center" 
        />
        <sjg:gridColumn
            name = "updateAuthority" index = "updateAuthority" key = "updateAuthority" title = "Update" width = "50" formatter="checkbox" align="center" 
        />
        <sjg:gridColumn
            name = "deleteAuthority" index = "deleteAuthority" key = "deleteAuthority" title = "Delete" width = "50" formatter="checkbox" align="center" 
        />
        <sjg:gridColumn
            name = "assignAuthority" index = "assignAuthority" key = "assignAuthority" title = "View" width = "50" formatter="checkbox" align="center" 
        />
        <sjg:gridColumn
            name = "printAuthority" index = "printAuthority" key = "printAuthority" title = "Print" width = "50" formatter="checkbox" align="center" 
        />
        </sjg:grid >
    </div>
