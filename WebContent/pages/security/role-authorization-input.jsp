

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<style>
    #roleAuthorizationInput_grid_pager_center{
        display: none;
    }
    input{border-radius: 3px;height:18px}
    input[readonly="readonly"] { background:#FFF1A0 }
</style>
<script type="text/javascript">
    
    var roleAuthorization_lastSel = -1, roleAuthorization_lastRowId = 0, roleAuthorization_editGridFirstSelected = true;
    
    var txtRoleAuthorizationRoleCode = $("#roleAutorization\\.code"),
        txtRoleAuthorizationRoleName = $("#roleAutorization\\.name"),
        allFields = $([])
            .add(txtRoleAuthorizationRoleCode)
            .add(txtRoleAuthorizationRoleName);

      var countDetail = 0;
      
        $('#btnRoleAuthorizationSave').click(function(ev) {
            if(roleAuthorization_lastSel != -1) {
                $('#roleAuthorizationInput_grid').jqGrid("saveRow",roleAuthorization_lastSel); 
            }
            
            if (!$("#frmRoleAuthorizationInput").valid()) {
                ev.preventDefault();
                return;
            }
            
            $("#dlgLoading").dialog("open");
                        
            var url = "security/role-authorization-save";
            
            //kirim data2 untuk header
            //var params = $("#frmRoleAuthorizationInput").serialize();
            
            var params = "headerCode=" + txtRoleAuthorizationRoleCode.val();
            
            //siapkan data untuk detail
            //data detail dibuat dalam bentuk JSON
            //ambil data dari Array JQGrid => Masukan ke Array Of Object => Lalu ubah menjadi bentuk JSON
            //JSON itulah yang kita kirim ke Server untuk di save
            var listRoleAuthorization = new Array();
            var ids = jQuery("#roleAuthorizationInput_grid").jqGrid('getDataIDs'); 

            for(var i=0;i < ids.length;i++){ 
                var roleAuthorization_data = $("#roleAuthorizationInput_grid").jqGrid('getRowData',ids[i]); 
                //buat sebuah object menyerupai Object dari RoleAuthorizationRoleDetail. Masukan data dari JQGrid ke Object
                
                var saveAuthority=roleAuthorization_data.authorization_saveAuthority.toString().toUpperCase()==='Y' ? true:false;
                var updateAuthority=roleAuthorization_data.authorization_updateAuthority.toString().toUpperCase()==='Y' ? true:false;
                var deleteAuthority=roleAuthorization_data.authorization_deleteAuthority.toString().toUpperCase()==='Y' ? true:false;
                var printAuthority=roleAuthorization_data.authorization_printAuthority.toString().toUpperCase()==='Y' ? true:false;
                var assignAuthority=roleAuthorization_data.authorization_assignAuthority.toString().toUpperCase()==='Y' ? true:false;
                var roleAuthorization = {
                    code     : "AUTO", 
                    headerCode : txtRoleAuthorizationRoleCode.val(),
                    authorization     : { 
                                            code : roleAuthorization_data.authorization_code,
                                            module : 
                                                    {
                                                       code : roleAuthorization_data.authorization_module_code,
                                                       text : roleAuthorization_data.authorization_module_name
                                                    }
                                        },
                    saveAuthority   : saveAuthority,
                    updateAuthority : updateAuthority,
                    deleteAuthority : deleteAuthority,
                    printAuthority  : printAuthority,
                    assignAuthority : assignAuthority
                };
                
                //Masukan Object Ke Seluah Array
                listRoleAuthorization[i] = roleAuthorization;
            }
            
            params += "&listRoleAuthorizationJSON=" + $.toJSON(listRoleAuthorization);
            
            //alert(params);
            //kirim data lalu kembali ke halaman List
            $.post(url, params, function(data) {
                $("#dlgLoading").dialog("close");
                if (data.error) {
                    alert(data.errorMessage);
                    return;
                }

                alert(data.message);
                allFields.val('').removeClass('ui-state-error');
                var url = "security/role-authorization";
                var params = "";

                pageLoad(url, params, "#tabmnuROLE_AUTHORIZATION");
            });
   
            ev.preventDefault();
        });

        $('#btnRoleAuthorizationCancel').click(function(ev) {
            hideInput("roleAuthorization");
            allFields.val('').removeClass('ui-state-error');
            
            var url = "security/role-authorization";
            var params = "";
            
            pageLoad(url, params, "#tabmnuROLE_AUTHORIZATION"); 
            //ev.preventDefault();
        });
        
        $(document).ready(function() {
            
            loadDetail();

            $('#chkSelectAllGridSave').click(function() {
            
                var selectSave_lastRowId=0;
                var ids = jQuery("#roleAuthorizationInput_grid").jqGrid('getDataIDs');
                if ($(this).is(':checked')) {                    
                    for(var i=0;i<ids.length;i++){ 
                        selectSave_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectSave_lastRowId,"authorization_saveAuthority", "Yes");    
                    }
                }
                if (!$(this).is(':checked')) {
                   for(var i=0;i<ids.length;i++){ 
                        selectSave_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectSave_lastRowId,"authorization_saveAuthority", "No");    
                    }
                }
            });
            
            $('#chkSelectAllGridUpdate').click(function() {
            
                var selectUpdate_lastRowId=0;
                var ids = jQuery("#roleAuthorizationInput_grid").jqGrid('getDataIDs');
                if ($(this).is(':checked')) {                    
                    for(var i=0;i<ids.length;i++){ 
                        selectUpdate_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectUpdate_lastRowId,"authorization_updateAuthority", "Yes");    
                    }
                }
                if (!$(this).is(':checked')) {
                   for(var i=0;i<ids.length;i++){ 
                        selectUpdate_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectUpdate_lastRowId,"authorization_updateAuthority", "No");    
                    }
                }
            });
            
            $('#chkSelectAllGridDelete').click(function() {
            
                var selectDelete_lastRowId=0;
                var ids = jQuery("#roleAuthorizationInput_grid").jqGrid('getDataIDs');
                if ($(this).is(':checked')) {                    
                    for(var i=0;i<ids.length;i++){ 
                        selectDelete_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectDelete_lastRowId,"authorization_deleteAuthority", "Yes");    
                    }
                }
                if (!$(this).is(':checked')) {
                   for(var i=0;i<ids.length;i++){ 
                        selectDelete_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectDelete_lastRowId,"authorization_deleteAuthority", "No");    
                    }
                }
            });
            
            $('#chkSelectAllGridView').click(function() {
            
                var selectView_lastRowId=0;
                var ids = jQuery("#roleAuthorizationInput_grid").jqGrid('getDataIDs');
                if ($(this).is(':checked')) {                    
                    for(var i=0;i<ids.length;i++){ 
                        selectView_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectView_lastRowId,"authorization_assignAuthority", "Yes");    
                    }
                }
                if (!$(this).is(':checked')) {
                   for(var i=0;i<ids.length;i++){ 
                        selectView_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectView_lastRowId,"authorization_assignAuthority", "No");    
                    }
                }
            });
            
            $('#chkSelectAllGridPrint').click(function() {
            
                var selectPrint_lastRowId=0;
                var ids = jQuery("#roleAuthorizationInput_grid").jqGrid('getDataIDs');
                if ($(this).is(':checked')) {                    
                    for(var i=0;i<ids.length;i++){ 
                        selectPrint_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectPrint_lastRowId,"authorization_printAuthority", "Yes");    
                    }
                }
                if (!$(this).is(':checked')) {
                   for(var i=0;i<ids.length;i++){ 
                        selectPrint_lastRowId++;
                        $("#roleAuthorizationInput_grid").jqGrid("setCell", selectPrint_lastRowId,"authorization_printAuthority", "No");    
                    }
                }
            });


//            $.subscribe("roleAuthorizationInput_grid_onSelect", function(event, data) {
//               /*
//               roleAuthorization_editGridFirstSelected = !roleAuthorization_editGridFirstSelected;
//               if (!roleAuthorization_editGridFirstSelected)
//                   return;
//               */
//
//               var selectedRowID = $("#roleAuthorizationInput_grid").jqGrid("getGridParam", "selrow");
//
//               if(selectedRowID!==roleAuthorization_lastSel) {
//                   $('#roleAuthorizationInput_grid').jqGrid("saveRow",roleAuthorization_lastSel); 
//                   $('#roleAuthorizationInput_grid').jqGrid("editRow",selectedRowID,true); 
//                   roleAuthorization_lastSel=selectedRowID;
//               }
//               else
//                   $('#roleAuthorizationInput_grid').jqGrid("saveRow",selectedRowID);
//
//            });
            
        });
        
        function loadDetail() {
            var url = "role-authorization-update-detail-data";
            var params = "headerCode=" + txtRoleAuthorizationRoleCode.val();
            
            $("#dlgLoading").dialog("open");
            $.getJSON(url, params, function(data) {
                $("#dlgLoading").dialog("close");
                roleAuthorization_lastRowId = 0;
               
                for (var i=0; i<data.listRoleAuthorizationTemp.length; i++) {
                    roleAuthorization_lastRowId++;
                    $("#roleAuthorizationInput_grid").jqGrid("addRowData", roleAuthorization_lastRowId, data.listRoleAuthorizationTemp[i]);
                    $("#roleAuthorizationInput_grid").jqGrid('setRowData', roleAuthorization_lastRowId,{
                        authorization_code              : data.listRoleAuthorizationTemp[i].code,
                        authorization_module_code       : data.listRoleAuthorizationTemp[i].modulecode,
                        authorization_module_name       : data.listRoleAuthorizationTemp[i].modulename,
                        authorization_saveAuthority     : data.listRoleAuthorizationTemp[i].saveauthority,
                        authorization_updateAuthority   : data.listRoleAuthorizationTemp[i].updateauthority,
                        authorization_deleteAuthority   : data.listRoleAuthorizationTemp[i].deleteauthority,
                        authorization_assignAuthority   : data.listRoleAuthorizationTemp[i].assignauthority,
                        authorization_printAuthority    : data.listRoleAuthorizationTemp[i].printauthority
                    });
                }
               setHeightGridDLN(data.listRoleAuthorizationTemp.length);
            });
        }
        
        function setHeightGridDLN(length){
            if(length > 15){
                var rowHeight = $("#roleAuthorizationInput_grid"+" tr").eq(1).height();
                $("#roleAuthorizationInput_grid").jqGrid('setGridHeight', rowHeight * 20 , true);
            }else{
                $("#roleAuthorizationInput_grid").jqGrid('setGridHeight', "100%", true);
            }

        }
        
</script>

<s:url id="remotedetailurlRoleAuthorizationInput" action="role-authorization-update-detail-data" />
<b>ROLE AUTHORIZATION</b>
<hr>
<br class="spacer" />
<div id="roleAuthorizationInput" class="content ui-widget">
    <s:form id="frmRoleAuthorizationInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code</B></td>
                <td><s:textfield id="roleAutorization.code" name="roleAutorization.code" title="Please Enter Code <br>" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Name</B></td>
                <td><s:textfield id="roleAutorization.name" name="roleAutorization.name" size="50" title="Please Enter Name <br>" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>               
        </table>
        <table>
            <tr>
                <td>
                    <table width="315px" align="right">
                        <tr>
                            <td align="center">
                                <input type="checkbox" id="chkSelectAllGridSave"/>All
                            </td>
                            <td align="center">
                                <input type="checkbox" id="chkSelectAllGridUpdate"/>All
                            </td>
                            <td align="center">
                                <input type="checkbox" id="chkSelectAllGridDelete"/>All
                            </td>
                            <td align="center">
                                <input type="checkbox" id="chkSelectAllGridView"/>All
                            </td>
                            <td align="center">
                                <input type="checkbox" id="chkSelectAllGridPrint"/>All
                            </td>
                            <td width="15px"/>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="roleAuthorizationInputGrid">
                        <sjg:grid
                            id="roleAuthorizationInput_grid"
                            dataType="local"
                            pager="true"
                            navigator="false"
                            navigatorView="false"
                            navigatorRefresh="false"
                            navigatorDelete="false"
                            navigatorAdd="false"
                            navigatorEdit="false"
                            gridModel="listRoleAuthorization"
                            rowNum="1000"
                            viewrecords="true"
                            rownumbers="true"
                            shrinkToFit="false"
                            width="800"                            
                        >
                            <sjg:gridColumn
                                name="code" index="code" key="code" title="Code" hidden="true" editable="true" edittype="text"
                            />
                            <sjg:gridColumn
                                name="headerCode" index="headerCode" key="headerCode" hidden="true" title="HeaderCode" width="100"
                            />
                            <sjg:gridColumn
                                name = "authorization_code" index = "authorization_code" key = "authorization_code" title = "Authorization" width = "450" hidden = "true"
                            />
                            <sjg:gridColumn
                                name = "authorization_module_code" index = "authorization_module_code" key = "authorization_module_code" title = "Module" width = "150" hidden = "true"
                            />
                            <sjg:gridColumn
                                name = "authorization_module_name" index = "authorization_module_name" key = "authorization_module_name" title = "Module Name" width = "450" resizable="false"
                            />
                            <sjg:gridColumn
                                name="authorization_saveAuthority" index="authorization_saveAuthority" title="Save" width="54"  resizable="false"
                                formatter="checkbox" align="center" 
                                editable="true" edittype="checkbox" editoptions="{value:'Y:N'}" formatoptions="{disabled : false}" sortable="false"
                            />
                            <sjg:gridColumn
                                name="authorization_updateAuthority" index="authorization_updateAuthority" title="Update" width="54" resizable="false"
                                formatter="checkbox" align="center" 
                                editable="true" edittype="checkbox" editoptions="{value:'Y:N'}" formatoptions="{disabled : false}" sortable="false"
                            />
                            <sjg:gridColumn
                                name="authorization_deleteAuthority" index="authorization_deleteAuthority" title="Delete" width="54" resizable="false"
                                formatter="checkbox" align="center" 
                                editable="true" edittype="checkbox" editoptions="{value:'Y:N'}" formatoptions="{disabled : false}" sortable="false"
                            />
                            <sjg:gridColumn
                                name="authorization_assignAuthority" index="authorization_assignAuthority" title="View" width="54" resizable="false"
                                formatter="checkbox" align="center" 
                                editable="true" edittype="checkbox" editoptions="{value:'Y:N'}" formatoptions="{disabled : false}" sortable="false"
                            />
                            <sjg:gridColumn
                                name="authorization_printAuthority" index="authorization_printAuthority" title="Print" width="54" resizable="false"
                                formatter="checkbox" align="center" 
                                editable="true" edittype="checkbox" editoptions="{value:'Y:N'}" formatoptions="{disabled : false}" sortable="false"
                            />
                        </sjg:grid >
                    </div>
                </td>
            </tr>
        </table>
        
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
        </div>
        <br class="spacer" />
        <sj:a href="#" id="btnRoleAuthorizationSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnRoleAuthorizationCancel" button="true">Cancel</sj:a>
        <br class="spacer" />
    </s:form>
</div>

