<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type = "text/javascript">
    
    var txtRoleCode = $("#role\\.code"),
        txtRoleName = $("#role\\.name"),
        allRoleFields = $([])
            .add(txtRoleCode)
            .add(txtRoleName);

    function reloadGridRole() {
        $("#role_grid").trigger("reloadGrid");
    }
    
    function setFocus(){
        $("input:text:visible:first").focus();     
    }
    
    $(document).ready(function() {    	
        hoverButton();
        var updateRowId = -1;
        hideInput("role");
        
        $('#role\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#btnRoleNew').click(function(ev) {
            showInput("role");
            updateRowId = -1;
            txtRoleCode.attr("readonly",false);
            allRoleFields.val('').removeClass('ui-state-error');
            ev.preventDefault();
            setFocus();
        });

    $('#btnRoleUpdate').click(function(ev) {
        updateRowId = $("#role_grid").jqGrid('getGridParam','selrow');
        if (updateRowId === null) {
            alert("Please Select Row!");
            return;
        }
       
        var role = $("#role_grid").jqGrid('getRowData', updateRowId);
        var url = "master/role-get";
        var params = "role.code=" + role.code;
        $.post(url, params, function(result) {
            var data = (result);
            txtRoleCode.val(data.roleTemp.code);
            txtRoleName.val(data.roleTemp.name);
            
            showInput("role");
            txtRoleCode.attr("readonly",true);
            setFocus();
        });
        ev.preventDefault();
            
        });

        $('#btnRoleSave').click(function(ev) {
            if (!$("#frmRoleInput").valid()) {
                ev.preventDefault();
                return;
            }

            var url = "";

            if (updateRowId < 0)
                url = "master/role-save";
            else
                url = "master/role-update";

            var params = $("#frmRoleInput").serialize();
            
            $.post(url, params, function(data) {
                if (data.error) {
                    alert(data.errorMessage);
                    return;
                }
                
                alert(data.message);
                hideInput('role');
                allRoleFields.val('').removeClass('ui-state-error');
                reloadGridRole();
            });
   
            ev.preventDefault();
        });

        $('#btnRoleDelete').click(function(ev) {
            var deleteRowId = $("#role_grid").jqGrid('getGridParam','selrow');
            if (deleteRowId === null) {
                alert("Please Select Row!");
                return;
            }
            
            var role = $("#role_grid").jqGrid('getRowData', deleteRowId);
            if (confirm("Are You Sure To Delete (Code : " + role.code + ")")) {
                var url = "master/role-delete";
                var params = "role.code=" + role.code;
                $.post(url, params, function(data) {
                    if (data.error) {
                        alert(data.errorMessage);
                        return;
                    }

                    alert(data.message);
                    reloadGridRole();
                });
            }
            ev.preventDefault();
        });

        $('#btnRoleCancel').click(function(ev) {
            hideInput("role");
            allRoleFields.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });

        $('#btnRefresh').click(function(ev) {
            reloadGridRole();
        });       
    });

</script>

<s:url id="remoteurlRole" action="role-json" />

    <b>ROLE</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="roleButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnRoleNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" /></a>
        <a href="#" id="btnRoleUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" /></a>
        <a href="#" id="btnRoleDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" /></a>
        <a href="#" id="btnRoleRefresh" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_refresh.png" border="0" /></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="roleGrid">
        <sjg:grid
            id="role_grid"
            dataType="json"
            href="%{remoteurlRole}"
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
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        </sjg:grid >
    </div>

    <div id="roleInput" class="content ui-widget">
        <s:form id="frmRoleInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Code *</B></td>
                    <td><s:textfield id="role.code" name="role.code" title="Please Enter Code <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="role.name" name="role.name" size="50" title="Please Enter Name <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td height="10px"/>
                </tr>
                <tr>
                    <td/>
                    <td>
                        <sj:a href="#" id="btnRoleSave" button="true">Save</sj:a>
                        <sj:a href="#" id="btnRoleCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
        </s:form>
    </div>
