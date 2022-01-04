<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/bootstrap.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    .ui-dialog-titlebar-close,#userBranchInput_grid_pager_center,#userBranchList_grid_pager_center,
    #userDivisionInput_grid_pager_center,#userDivisionList_grid_pager_center
    {
        display: none;
    }
</style>
<script type="text/javascript">
    var userBranch_lastRowId = 0, userBranch_lastSel = -1,userBranch_selectedLastSel=-1;
    var userDivision_lastRowId = 0, userDivision_lastSel = -1,userDivision_selectedLastSel=-1;
    var 
        txtUserBranchCode = $("#user\\.branch\\.code"),
        txtUserBranchName = $("#user\\.branch\\.name"),
        txtUserDivisionCode = $("#user\\.division\\.code"),
        txtUserDivisionName = $("#user\\.division\\.name"),
        txtUserCode = $("#user\\.code"),
        txtUserName = $("#user\\.username"),
        txtUserFullName = $("#user\\.fullName"),
        txtUserEmployeeCode = $("#user\\.employee\\.code"),
        txtUserEmployeeName = $("#user\\.employee\\.name"),
        txtUserPassword = $("#user\\.password"),
        txtUserConfirmPassword = $("#user\\.confirmPassword"),
        txtUserRoleCode = $("#user\\.role\\.code"),
        txtUserRoleName = $("#user\\.role\\.name"),  
        txtUserRoleActiveStatus = $("#user\\.role\\.activeStatus"),
        rdbUserActiveStatus = $("#user\\.activeStatus"),
        rdbUserPriceAuthority = $("#user\\.priceAuthority"),
        txtUserRemark=$("#user\\.remark"),
        txtUserInActiveBy = $("#user\\.inActiveBy"),
        dtpUserInActiveDate = $("#user\\.inActiveDate"),
        lblActive = $("#lblActive"),
        lblActivePriceAuthority = $("#lblActive"),
        allFields=$([])
            .add(txtUserBranchCode)
            .add(txtUserBranchName)
            .add(txtUserDivisionCode)
            .add(txtUserDivisionName)
            .add(txtUserCode)
            .add(txtUserName)
            .add(txtUserFullName)
            .add(txtUserEmployeeCode)
            .add(txtUserEmployeeName)
            .add(txtUserPassword)
            .add(txtUserConfirmPassword)
            .add(txtUserRoleCode)
            .add(txtUserRoleName)       
            .add(txtUserRemark)
            .add(txtUserInActiveBy)
            .add(dtpUserInActiveDate)
            .add(txtUserRoleActiveStatus);
            
    function reloadGridUser() {
        var url = "security/user";
        var params = "";
        pageLoad(url, params, "#tabmnuUSER");   
    };
    
    $(document).ready(function(){
        
        hoverButton();
        var updateRowId = -1;
        hideInput("user");
        
        $('#user\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        
        $('#userSearchActiveStatusRadActive').prop('checked',true);
        $("#userSearchActiveStatus").val("true");
        
        $('input[name="userSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#userSearchActiveStatus").val(value);
        });
        
        $('input[name="userSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#userSearchActiveStatus").val(value);
        });
                
        $('input[name="userSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#userSearchActiveStatus").val(value);
        });
        
        $('input[name="user\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#user\\.activeStatus").val(value);
            
        });
                
        $('input[name="user\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#user\\.activeStatus").val(value);
        });
        
        $('input[name="user\\.unlockSoLimit"][value="Yes"]').change(function(ev){
            var value="true";
            $("#user\\.unlockSoLimit").val(value);
            
        });
                
        $('input[name="user\\.unlockSoLimit"][value="No"]').change(function(ev){
            var value="false";
            $("#user\\.unlockSoLimit").val(value);
        });
        
        $('input[name="user\\.priceAuthority"][value="Active"]').change(function(ev){
            var value="true";
            $("#user\\.priceAuthority").val(value);
            
        });
                
        $('input[name="user\\.priceAuthority"][value="InActive"]').change(function(ev){
            var value="false";
            $("#user\\.priceAuthority").val(value);
        });
        
        $.subscribe("user_grid_onSelect", function(event, data){
           var selectedRowID = $("#user_grid").jqGrid("getGridParam", "selrow"); 
           var userCode = $("#user_grid").jqGrid("getRowData", selectedRowID);
                      
           $("#userBranchList_grid").jqGrid("setGridParam",{url:"security/user-branch-data?headerCode=" + userCode.code});
           $("#userBranchList_grid").jqGrid("setCaption", "User Branch : " + userCode.code);
           $("#userBranchList_grid").trigger("reloadGrid");
                      
           $("#userDivisionList_grid").jqGrid("setGridParam",{url:"security/user-division-data?headerCode=" + userCode.code});
           $("#userDivisionList_grid").jqGrid("setCaption", "User Division : " + userCode.code);
           $("#userDivisionList_grid").trigger("reloadGrid");
        });
        
        $("#btnUserNew").click(function(ev){
            showInput("user");
            hideInput("userSearch");
            $('#user\\.activeStatusActive').prop('checked',true);
            $("#user\\.activeStatus").val("true");
            $('#user\\.unlockSoLimitYes').prop('checked',true);
            $("#user\\.unlockSoLimit").val("true");
            $('#user\\.priceAuthorityInActive').prop('checked',true);
            $("#user\\.priceAuthority").val("false");
            $('#btnLock').css("display", "none");
            $('#btnUnLock').css("display", "none");
            $('#user\\.password').attr("readonly",false);
            $('#userPasswordTemp').val($('#user\\.password').val());
            $('#userStatus').val("false");
            txtUserCode.attr("readonly",false);
            updateRowId = -1;
            ev.preventDefault();
            
        });
                
        $("#btnUserUpdate").click(function(ev){
            updateRowId = $("#user_grid").jqGrid("getGridParam","selrow");
            
            if(updateRowId === null){
                alert("Please Select Row!");
                return;
            }
            
            var user = $("#user_grid").jqGrid('getRowData', updateRowId);
            var url = "security/user-get-for-update";
            var params = "user.code=" + user.code;

            txtUserCode.attr("readonly",true);

            $.post(url, params, function(result) {
                var data = (result);
                    txtUserBranchCode.val(data.userTemp.branchCode);
                    txtUserBranchName.val(data.userTemp.branchName);
                    txtUserDivisionCode.val(data.userTemp.divisionCode);
                    txtUserDivisionName.val(data.userTemp.divisionName);
                    txtUserCode.val(data.userTemp.code);
                    txtUserFullName.val(data.userTemp.fullName);
                    txtUserEmployeeCode.val(data.userTemp.employeeCode);
                    txtUserEmployeeName.val(data.userTemp.employeeName);
                    txtUserPassword.val(data.userTemp.password);
                    txtUserConfirmPassword.val(data.userTemp.password);
                    $('#userPassword').val(data.userTemp.password);
                    txtUserRoleCode.val(data.userTemp.roleCode);
                    txtUserRoleName.val(data.userTemp.roleName);

                    if(data.userTemp.activeStatus===true) {
                       $('#user\\.activeStatusActive').prop('checked',true);
                       $("#user\\.activeStatus").val("true");
                    }
                    else {                        
                       $('#user\\.activeStatusInActive').prop('checked',true);              
                       $("#user\\.activeStatus").val("false");
                    }
                    
                    if(data.user.unlockSoLimit===true) {
                       $('#user\\.unlockSoLimitYes').prop('checked',true);
                       $("#user\\.unlockSoLimit").val("true");
                    }
                    else {                        
                       $('#user\\.unlockSoLimitNo').prop('checked',true);              
                       $("#user\\.unlockSoLimit").val("false");
                    }


                    $('#btnLock').css("display", "none");
                    $('#user\\.password').attr("readonly",true);
                    $('#user\\.confirmPassword').attr("readonly",true);
                    $('#userPasswordTemp').val($('#user\\.password').val());
                    $('#userStatus').val("false");
                loadDetailUserBranch(user.code);
                loadDetailUserDivision(user.code);
                showInput("user");
                hideInput("userSearch");
            });                
            ev.preventDefault();
        });
                
        $('#btnUserDelete').click(function(ev) {
            var deleteRowId = $("#user_grid").jqGrid('getGridParam','selrow');
            
            if (deleteRowId === null) {
                alert("Please Select Row");
            }
            else {
                var user = $("#user_grid").jqGrid('getRowData', deleteRowId);
                
                if (confirm("Are You Sure To Delete (User Name : " + user.code + ")")) {
                    var url = "security/user-delete";
                    var params = "user.code=" + user.code;
                    
                    $.post(url, params, function(data) {
                        if (data.error) {
                            alert(data.errorMessage);
                            return;
                        }
                        alert(data.message);
                        reloadGridUser();
                    });
                }
            }
            ev.preventDefault();
        });
        
        $("#btnUserSave").click(function(ev) {
            
            if(!$("#frmUserInput").valid()) {
               handlers_input_user();
               ev.preventDefault();
               return;
            };
            
            if($("#user\\.password").val() !== $("#user\\.confirmPassword").val()){
                alert_change_password("Confirm Password Not Equal!");
                return;
            }
            // Data Branch From Grid to Save Database
            if(userBranch_lastSel !== -1) {
                $('#userBranchInput_grid').jqGrid("saveRow",userBranch_lastSel);
            }
            
            var listUserBranch = new Array();
            var ids = jQuery("#userBranchInput_grid").jqGrid('getDataIDs');
            
            if(ids.length===0){
                alertMessage("Data Branch Can't Empty!");
                return;
            }
            
            for(var i=0;i < ids.length;i++){
                var data = $("#userBranchInput_grid").jqGrid('getRowData',ids[i]);

                if(data.userBranchBranchCode === ""){
                    alertMessage("Branch Can't Empty! ");
                    return;
                }
                
                var userBranch = {
                    branch       : { code : data.userBranchBranchCode }
                };
                listUserBranch[i] = userBranch;
            }
            
            // Data Division From Grid to Save Database
            if(userDivision_lastSel !== -1) {
                $('#userDivisionInput_grid').jqGrid("saveRow",userDivision_lastSel);
            }
            
            var listUserDivision = new Array();
            var ids = jQuery("#userDivisionInput_grid").jqGrid('getDataIDs');
            
            if(ids.length===0){
                alertMessage("Data Division Can't Empty!");
                return;
            }
            
            for(var i=0;i < ids.length;i++){
                var data = $("#userDivisionInput_grid").jqGrid('getRowData',ids[i]);

                if(data.userDivisionDivisionCode === ""){
                    alertMessage("Division Can't Empty! ");
                    return;
                }
                
                var userDivision = {
                    division       : { code : data.userDivisionDivisionCode }
                };
                listUserDivision[i] = userDivision;
            }
            
            var url = "";
            
            if (updateRowId < 0){
                url = "security/user-save";
            }else{
               url = "security/user-update";
            }

            var params = $("#frmUserInput").serialize();
            params += "&listUserBranchJSON=" + $.toJSON(listUserBranch);
            params += "&listUserDivisionJSON=" + $.toJSON(listUserDivision);
           
            if($('#userStatus').val()==="false"){
                $('#user\\.password').val($('#userPasswordTemp').val()); 
                params +="&userStatus= false";
            }else{
               $('#user\\.password').val($('#user\\.password').val());
                params +="&userStatus= true";
            }
           
           $.post(url, params, function(data) {
                if (data.error) {
                    alert(data.errorMessage);
                    return;
                }
                alert(data.message);
                hideInput("user");
                allFields.val('').removeClass('ui-state-error');
                reloadGridUser();           
           });
           
           ev.preventDefault();
        });
                
        $("#btnUserCancel").click(function(ev) {
            reloadGridUser();
        });
        
        $('#btnRefresh').click(function(ev) {
            reloadGridUser();    
        });
        

        $('#btnUserRefresh').click(function(ev) {
            reloadGridUser();    
        });
        
        $('#btnLock').click(function(ev) {
            $('#btnUnLock').css("display", "block");
            $('#btnLock').css("display", "none");
            $('#user\\.password').attr("readonly",true);
            $('#user\\.confirmPassword').attr("readonly",true);
            $('#userStatus').val("false");
            $('#user\\.password').val($('#userPassword').val());
        });

        $('#btnUnLock').click(function(ev) {
            $('#btnLock').css("display", "block");
            $('#btnUnLock').css("display", "none");
            $('#user\\.password').attr("readonly",false);
            $('#user\\.confirmPassword').attr("readonly",false);
            $('#userStatus').val("true");
        });
        
        $('#btnUser_search').click(function(ev) {
            $("#user_grid").jqGrid("clearGridData");
            $("#user_grid").jqGrid("setGridParam",{url:"security/user-data?" + $("#frmUserSearchInput").serialize()});
            $("#user_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
    }); //EOF READY
    
    function userBranchInput_grid_BranchSearch_OnClick() {  
        window.open("./pages/search/search-branch.jsp?type=grid&iddoc=userBranch","Search", "width=450, height=500");
    }

    function unHandlers_input_user(){
        unHandlersInput(txtUserCode);
        unHandlersInput(txtUserPassword);
        unHandlersInput(txtUserRoleCode);
    }

    function handlers_input_user(){
        if(txtUserCode.val()===""){
            handlersInput(txtUserCode);
        }else{
            unHandlersInput(txtUserCode);
        }
        if(txtUserPassword.val()===""){
            handlersInput(txtUserPassword);
        }else{
            unHandlersInput(txtUserPassword);
        }
        if(txtUserRoleCode.val()===""){
            handlersInput(txtUserRoleCode);
        }else{
            unHandlersInput(txtUserRoleCode);
        }
    }
    
    function loadDetailUserBranch(headerCode) {
        
        var url = "security/user-branch-update-get";
        var params = "user.code=" + headerCode;

        $.getJSON(url, params, function(data) {
            userBranch_lastRowId = 0;
            for (var i=0; i<data.listUserBranchTemp.length; i++) {
                userBranch_lastRowId++;
                $("#userBranchInput_grid").jqGrid("addRowData", userBranch_lastRowId, data.listUserBranchTemp[i]);
                $("#userBranchInput_grid").jqGrid('setRowData', userBranch_lastRowId,{
                    userBranchBranchDelete  : "delete",
                    userBranchBranchSearch  : "...",
                    userBranchBranchCode    : data.listUserBranchTemp[i].branchCode,
                    userBranchBranchName    : data.listUserBranchTemp[i].branchName
                });
            }
        });
    }
    
    function loadDetailUserDivision(headerCode) {
        
        var url = "security/user-division-update-get";
        var params = "user.code=" + headerCode;

        $.getJSON(url, params, function(data) {
            userDivision_lastRowId = 0;
            for (var i=0; i<data.listUserDivisionTemp.length; i++) {
                userDivision_lastRowId++;
                $("#userDivisionInput_grid").jqGrid("addRowData", userDivision_lastRowId, data.listUserDivisionTemp[i]);
                $("#userDivisionInput_grid").jqGrid('setRowData', userDivision_lastRowId,{
                    userDivisionDivisionDelete  : "delete",
                    userDivisionDivisionSearch  : "...",
                    userDivisionDivisionCode    : data.listUserDivisionTemp[i].divisionCode,
                    userDivisionDivisionName    : data.listUserDivisionTemp[i].divisionName
                });
            }
        });
    }
    
    function alert_change_password(txt_message,txt_focus){
        var dynamicDialog= $(
            '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>' +
            '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            height:120,
            resizable: false,
            closeText: "hide",
            buttons : 
                [{
                    text : "OK",
                    click : function() {
                        $(this).dialog("close");
                        txt_focus.focus();
                    }
                }]
        });
    }
    
    function userBranchInput_grid_BranchCode_OnChange(){
        var selectedRowID = $("#userBranchInput_grid").jqGrid("getGridParam", "selrow");
	var branchCode = $("#" + selectedRowID + "_userBranchBranchCode").val();
//        alert(branchCode);
//        return;
	var url = "master/branch-get";
	var params = "branch.code=" + branchCode;
            params+= "&branch.activeStatus=TRUE";
		
	if(branchCode===""){
            $("#" + selectedRowID + "_userBranchBranchCode").val("");
            $("#userBranchInput_grid").jqGrid("setCell", selectedRowID,"userBranchBranchName"," ");
            return;
	}
		
	$.post(url, params, function(result) {
            var data = (result);
            if (data.branchTemp){
                $("#" + selectedRowID + "_userBranchBranchCode").val(data.branchTemp.code);
                $("#userBranchInput_grid").jqGrid("setCell", selectedRowID,"userBranchBranchName",data.branchTemp.name);
            }
            else{
                alertMessage("Branch Not Found",$("#" + selectedRowID + "_userBranchBranchCode"));
                $("#" + selectedRowID + "_userBranchBranchCode").val("");
                $("#userBranchInput_grid").jqGrid("setCell", selectedRowID,"userBranchBranchName"," ");
            }
	});
    }


 function setHeightGridHeader(){
        var ids = jQuery("#userBranchInput_grid").jqGrid('getDataIDs'); 
        if(ids.length > 15){
            var rowHeight = $("#userBranchInput_grid"+" tr").eq(1).height();
            $("#userBranchInput_grid").jqGrid('setGridHeight', rowHeight * 15 , true);
        }else{
            $("#userBranchInput_grid").jqGrid('setGridHeight', "100%", true);
        } 
    }
</script>
<s:url id="remoteurlUserBranchInput" action="" />
<s:url id="remoteurlUserDivisionInput" action="" />
<s:url id="remoteurlUser" action="user-data" />
    <b>USER</b>
    <hr>
    <br class="spacer" />
    <sj:div id="userButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnUserNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
        <a href="#" id="btnUserUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
        <a href="#" id="btnUserDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
        <a href="#" id="btnUserRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>      
    </sj:div>
    <div id="userSearchInput" class="content ui-widget">
        <br class="spacer"/>
        <br class="spacer"/>
        <s:form id="frmUserSearchInput">
            <table>
                <tr>
                    <td align="right" valign="center">Username</td>
                    <td>
                        <s:textfield id="userSearchUsername" name="userSearchUsername" size="10"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right" valign="center">Role</td>
                    <td>
                        <s:textfield id="userSearchRoleCode" name="userSearchRoleCode" size="15" Placeholder=" Code"></s:textfield>
                    </td>
                    <td>
                        <s:textfield id="userSearchRoleName" name="userSearchRoleName" size="30" Placeholder=" Name"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right">Status
                        <s:textfield id="userSearchActiveStatus" name="userSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>
                    <td>
                        <s:radio id="userSearchActiveStatusRad" name="userSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                    </td>
                </tr>
            </table>
            <br/>
            <sj:a href="#" id="btnUser_search" button="true">Search</sj:a>
            <br/>
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
            </div>
        </s:form>
    </div>
    <br class="spacer" />
    
    <div id="userGrid">
        <sjg:grid
            id="user_grid"
            dataType="json"
            href="%{remoteurlUser}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listUserTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="user_grid_onSelect"
        >
        <sjg:gridColumn
            name="branchCode" index="branchCode" key="branchCode" title="Branch Code" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="User Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="username" index="username" title="User Name" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="fullName" index="fullName" title="Full Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="employeeCode" index="employeeCode" title="Employee Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="employeeName" index="employeeName" title="Employee Name" width="300" sortable="false"
        />  
        <sjg:gridColumn
            name="password" index="password" key="password" title="Password" width="100" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="roleCode" index="roleCode" title="Role Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="roleName" index="roleName" title="Role Name" width="300" sortable="false"
        />  
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />  
        <%--<sjg:gridColumn--%>
            <!--name="unlockSoLimit" index="unlockSoLimit" title="Unlock SO Limit" width="100" formatter="checkbox" align="center"-->
        <!--/>-->  
        </sjg:grid >
        <br class="spacer" />
        
        <sjg:grid
            id="userBranchList_grid"
            caption="User Branch"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listUserBranch"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="140" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name = "user.code" id="user.code" index = "user.code" key = "user.code" title = "UserCode" width = "140" sortable = "true" hidden="true"
        />
        <sjg:gridColumn
            name="branch.code" index="branch.code" key="branch.code" title="Branch" width="100" sortable="false"
        />
        <sjg:gridColumn
            name="branch.name" index="branch.name" key="branch.name" title="Branch Name" width="400" sortable="false"
        />
        </sjg:grid >
        
        <br class="spacer" />
        
        <sjg:grid
            id="userDivisionList_grid"
            caption="User Division"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listUserDivision"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="140" sortable="true" hidden="true"
                />
            <sjg:gridColumn
                name = "user.code" id="user.code" index = "user.code" key = "user.code" title = "UserCode" width = "140" sortable = "true" hidden="true"
                />
            <sjg:gridColumn
                name="division.code" index="division.code" key="division.code" title="Division" width="100" sortable="false"
                />
            <sjg:gridColumn
                name="division.name" index="division.name" key="division.name" title="Division Name" width="400" sortable="false"
                />
        </sjg:grid >
    </div>
    
    <div id="userInput" class="content ui-widget">
        <s:form id="frmUserInput">
            <table cellpadding="2" cellspacing="2" >
                <tr>
                    <td align="right"><B>User Name *</B></td>
                    <td>
                        <s:textfield id="user.code" name="user.code" required="true" cssClass="required" title="*"></s:textfield>
                        <s:textfield id="userPasswordTemp" name="userPasswordTemp" cssStyle="display:none"></s:textfield>
                        <s:textfield id="userStatus" name="userStatus" cssStyle="display:none"></s:textfield>
                    </td>
                </tr>
            <tr>
                <td align="right"><b>Full Name *</b></td>
                <td><s:textfield id="user.fullName" name="user.fullName" size="49" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
                <tr>
                <td align="right">Employee</td>
                <td>
                    <script type = "text/javascript">
                            $('#user_btnEmployee').click(function(ev) {
                                window.open("./pages/search/search-employee.jsp?iddoc=user","Search", "width=600, height=500");
                            });
                            
                            txtUserEmployeeCode.change(function(ev) {
                            if(txtUserEmployeeCode.val()===""){
                               clearUserEmployeeFields();
                                return;
                            }

                            var url = "master/employee-get";
                            var params = "employee.code=" + txtUserEmployeeCode.val();

                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.employeeTemp){
                                    txtUserEmployeeCode.val(data.employeeTemp.code);
                                    txtUserEmployeeName.val(data.employeeTemp.name);
                                }
                                else{
                                    alertMessage("Employee Not Found!",txtUserEmployeeCode);
                                    txtUserEmployeeName.val("");
                                } 
                            });
                        });
                    </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="user.employee.code" name="user.employee.code" title=" " size="15"></s:textfield>
                            <sj:a id="user_btnEmployee" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        &nbsp;<s:textfield id="user.employee.name" name="user.employee.name" size="28" readonly="true"></s:textfield> 
                </td>
                </tr>
                <tr id="tr-password-temp" hidden="true">
                    <td align="right"><B>Password Temp*</B></td>
                    <td>
                        <s:password id="userPassword" name="userPassword" title="*"></s:password>
                    </td>
                </tr>
                <tr id="tr-password">
                    <td align="right"><B>Password *</B></td>
                    <td>
                        <s:password id="user.password" name="user.password" required="true" cssClass="required" title="*"></s:password>
                    </td>
                    <td>
                        <sj:a href="#" id="btnLock" button="true" cssStyle="width:20%"> Lock </sj:a>
                        <sj:a href="#" id="btnUnLock" button="true"  cssStyle="width:20%"> UnLock </sj:a>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Confirm Password *</B></td>
                    <td><s:password id="user.confirmPassword" name="user.confirmPassword" title="Please Confirm Password!" required="true" cssClass="required"></s:password></td>
                </tr>
                <tr>
                    <td align="right"><B>Role *</B></td>
                    <td>
                        <script type = "text/javascript">
                            $('#user_btnRole').click(function(ev) {
                                window.open("./pages/search/search-role.jsp?iddoc=user","Search", "width=600, height=500");
                            });

                            txtUserRoleCode.change(function(ev) {
                                if(txtUserRoleCode.val()===""){
                                    txtUserRoleName.val("");
                                    return;
                                }
                                var url = "security/role-get";
                                var params = "role.code=" + txtUserRoleCode.val();
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.roleTemp){
                                        txtUserRoleCode.val(data.roleTemp.code);
                                        txtUserRoleName.val(data.roleTemp.name);
                                    }
                                    else{
                                        alertMessage("Role Not Found!",txtUserRoleCode);
                                        txtUserRoleName.val("");
                                        
                                    }
                                        
                                });
                            });
                </script>
                <div class="searchbox ui-widget-header">
                        <s:textfield id="user.role.code" name="user.role.code" required="true" cssClass="required" title="*" size="15"></s:textfield><sj:a id="user_btnRole" href="#" openDialog="dlgRole">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                </div>
                
                    <s:textfield id="user.role.name" name="user.role.name" required="true" size="28" readonly="true"></s:textfield>
                    <%--<s:textfield id="user.branchCode" name="user.branchCode" required="true" size="50" readonly="true" cssStyle="display:nones"></s:textfield>--%>
                </tr>
                <tr>
                    <td align="right"><B>Active Status *</B></td>
                    <td>
                        <s:textfield id="user.activeStatus" name="user.activeStatus" readonly="false" size="5" cssStyle="Display:none"></s:textfield>
                        <s:radio id="user.activeStatus" name="user.activeStatus" list="{'Active','InActive'}"></s:radio>
                    </td>                    
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td colspan="3">
                        <s:textarea id="user.remark" name="user.remark"  cols="47" rows="2" height="20"></s:textarea>
                    </td>
                </tr> 
                <tr>
                    <td align="right">InActive By</td>
                    <td><s:textfield id="user.inActiveBy"  name="user.inActiveBy" size="20" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">InActive Date</td>
                    <td>
                        <sj:datepicker id="user.inActiveDate" name="user.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                    </td>
                </tr>
                
                <tr>
                    <td height="10px"/>
                </tr>
                
            </table>
        
        <br class="spacer" />
        
        <!--Branch-->
        <table>
            <tr>
                <td align="right"><B>Default Branch</B>
                    <script type = "text/javascript">

                        $('#user_btnBranch').click(function(ev) {
            
                            var ids = jQuery("#userBranchInput_grid").jqGrid('getDataIDs');

                            if($("#userBranchInput_grid").jqGrid('getDataIDs').length===0){
                                {alertMessage("Grid Branch Can't Be Empty!");
                                return;}

                            }

                            if(userBranch_lastSel !== -1) {
                                $('#userBranchInput_grid').jqGrid("saveRow",userBranch_lastSel); 
                            }

                            var listBranchCode = new Array();
                            var listCode = new Array();

                            for(var i=0;i<ids.length;i++){
                                var Detail = $("#userBranchInput_grid").jqGrid('getRowData',ids[i]); 
                                listCode = {
                                  code:Detail.userBranchBranchCode
                                };
                                listBranchCode.push(listCode);
                            }


                            var result = Enumerable.From(listBranchCode)
                                            .GroupBy("$.code", null,
                                                "[$ ]"
                                            )
                                            .ToArray();


                            var strr = "";
                                    for(var i = 0; i < result.length; i++){
                                        if(i == 0){
                                            strr = "" + result[i];
                                        }else{
                                            strr += "," + result[i];
                                        }
                                    }

                            window.open("./pages/search/search-branch-with-array.jsp?iddoc=user&idbranchcode="+strr,"Search", "Scrollbars=1,width=600, height=500");

                        });

                        function clearUserBranchFields() {
                            txtUserBranchCode.val("");
                            txtUserBranchName.val("");
                        }

                        txtUserBranchCode.change(function (ev) {

                            if(txtUserBranchCode.val()===""){
                                clearUserBranchFields();
                                return;
                            }
                            var ids = jQuery("#userBranchInput_grid").jqGrid('getDataIDs'); 

                            if(ids.length === 0 ){
                                alertMessage("Grid Branch Is Empty");
                                clearUserBranchFields();
                                return;
                            }
                            
                            var validate= true;
                            for(var i=0;i < ids.length;i++){ 
                                var data = $("#userBranchInput_grid").jqGrid('getRowData',ids[i]);
                                if(txtUserBranchCode.val().toUpperCase() === data.userBranchBranchCode.toUpperCase()){
                                    txtUserBranchCode.val(data.userBranchBranchCode);
                                    txtUserBranchName.val(data.userBranchBranchName);
                                    validate= false;
                                }
                            }

                            if(validate === true){
                                clearUserBranchFields();
                                alertMessage("Branch Not Found");
                            }
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="user.branch.code" name="user.branch.code" title="" size="10" required="true" cssClass="required"></s:textfield>
                        <sj:a id="user_btnBranch" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        &nbsp;<s:textfield id="user.branch.name" name="user.branch.name" size="28" readonly="true"></s:textfield> 
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <script>
                        $.subscribe("userBranchInput_grid_onSelect", function (event, data) {
                            var selectedRowID = $("#userBranchInput_grid").jqGrid("getGridParam", "selrow");

                            if (selectedRowID !== userBranch_lastSel) {
                                $('#userBranchInput_grid').jqGrid("saveRow", userBranch_lastSel);
                                $('#userBranchInput_grid').jqGrid("editRow", selectedRowID, true);
                                userBranch_lastSel = selectedRowID;
                            } else
                                $('#userBranchInput_grid').jqGrid("saveRow", selectedRowID);
                        });

                        function userBranchInputGrid_Delete_OnClick() {
                            var selectDetailRowId = $("#userBranchInput_grid").jqGrid('getGridParam', 'selrow');
                            if (selectDetailRowId === null) {
                                alert("Please Select Row!");
                                return;
                            }
                            $("#userBranchInput_grid").jqGrid('delRowData', selectDetailRowId);
                        }

                        $('#btnUserBranch').click(function (ev) {
                            window.open("./pages/search/search-branch-multiple.jsp?iddoc=userBranch&type=grid" + "&rowLast=" + userBranch_lastRowId, "Search", "scrollbars=1, width=900, height=600");
                        });

                        function addRowUserBranchDataMultiSelected(lastRowId, defRow) {

                            var ids = jQuery("#userBranchInput_grid").jqGrid('getDataIDs');
                            var lastRow = [0];

                            for (var i = 0; i < ids.length; i++) {
                                var comp = (ids[i] - lastRow[0]) > 0;
                                if (comp) {
                                    lastRow = [];
                                    lastRow.push(ids[i]);
                                }
                            }
                            userBranch_lastRowId = lastRowId;
                            var data = $("#userBranchInput_grid").jqGrid('getRowData', lastRowId);

                            $("#userBranchInput_grid").jqGrid("addRowData", lastRowId, defRow);
                            $("#userBranchInput_grid").jqGrid('setRowData', lastRowId, {
                                userBranchDelete: "delete",
                                userBranchBranchCode: defRow.code,
                                userBranchBranchName: defRow.name
                            });
                            setHeightGridBranch();
                        }

                        function setHeightGridBranch() {
                            var ids = jQuery("#userBranchInput_grid").jqGrid('getDataIDs');
                            if (ids.length > 15) {
                                var rowHeight = $("#userBranchInput_grid" + " tr").eq(1).height();
                                $("#userBranchInput_grid").jqGrid('setGridHeight', rowHeight * 15, true);
                            } else {
                                $("#userBranchInput_grid").jqGrid('setGridHeight', "100%", true);
                            }

                        }
                    </script>
                    <div id="userBranchInputGrid">
                        <table width="20%">
                            <tr>
                                <td>
                                    <sj:a href="#" id="btnUserBranch" button="true" style="width: 130%">Search Branch</sj:a> 
                                    </td>
                                </tr>
                            </table>
                        <sjg:grid
                            id="userBranchInput_grid"
                            dataType="local"                    
                            pager="true"
                            navigator="false"
                            navigatorView="false"
                            navigatorRefresh="false"
                            navigatorDelete="false"
                            navigatorAdd="false"
                            navigatorEdit="false"
                            gridModel="listUserBranch"
                            rowList="10,20,30"
                            rowNum="10"
                            viewrecords="true"
                            rownumbers="true"
                            shrinkToFit="false"
                            editinline="true"
                            width="460"
                            editurl="%{remoteurlUserBranchInput}"
                            onSelectRowTopics="userBranchInput_grid_onSelect"
                            >
                            <sjg:gridColumn
                                name="userBranch" index="userBranch" title="" width="10" align="centre"
                                editable="true" edittype="text" hidden="true"
                                />
                            <sjg:gridColumn
                                name="userBranchDelete" index="userBranchDelete" title="" width="50" align="centre"
                                editable="true"
                                edittype="button"
                                editoptions="{onClick:'userBranchInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                            <sjg:gridColumn
                                name="userBranchBranchCode" index="userBranchBranchCode" 
                                key="userBranchBranchCode" title="Branch Code" width="80" sortable="true" 
                                />
                            <sjg:gridColumn
                                name="userBranchBranchName" index="userBranchBranchName" 
                                key="userBranchBranchName" title="Branch Name" width="285" sortable="true"
                                />
                        </sjg:grid>                
                    </div>
                    <br/>
                </td>
            </tr>
        </table>
        <!--End Branch-->
        <br class="spacer" />
        
        <!--Division-->
        <table>
            <tr>
                <td align="right"><B>Default Division</B>
                    <script type = "text/javascript">

                        $('#user_btnDivision').click(function(ev) {
            
                            var ids = jQuery("#userDivisionInput_grid").jqGrid('getDataIDs');

                            if($("#userDivisionInput_grid").jqGrid('getDataIDs').length===0){
                                {alertMessage("Grid Division Can't Be Empty!");
                                return;}

                            }

                            if(userDivision_lastSel !== -1) {
                                $('#userDivisionInput_grid').jqGrid("saveRow",userDivision_lastSel); 
                            }

                            var listDivisionCode = new Array();
                            var listCode = new Array();

                            for(var i=0;i<ids.length;i++){
                                var Detail = $("#userDivisionInput_grid").jqGrid('getRowData',ids[i]); 
                                listCode = {
                                  code:Detail.userDivisionDivisionCode
                                };
                                listDivisionCode.push(listCode);
                            }


                            var result = Enumerable.From(listDivisionCode)
                                            .GroupBy("$.code", null,
                                                "[$ ]"
                                            )
                                            .ToArray();


                            var strr = "";
                                    for(var i = 0; i < result.length; i++){
                                        if(i == 0){
                                            strr = "" + result[i];
                                        }else{
                                            strr += "," + result[i];
                                        }
                                    }

                            window.open("./pages/search/search-division-with-array.jsp?iddoc=user&iddivisioncode="+strr,"Search", "Scrollbars=1,width=600, height=500");

                        });

                        function clearUserDivisionFields() {
                            txtUserDivisionCode.val("");
                            txtUserDivisionName.val("");
                        }

                        txtUserDivisionCode.change(function (ev) {

                            if(txtUserDivisionCode.val()===""){
                                clearUserDivisionFields();
                                return;
                            }
                            var ids = jQuery("#userDivisionInput_grid").jqGrid('getDataIDs'); 

                            if(ids.length === 0 ){
                                alertMessage("Grid Division Is Empty");
                                clearUserDivisionFields();
                                return;
                            }
                            
                            var validate= true;
                            for(var i=0;i < ids.length;i++){ 
                                var data = $("#userDivisionInput_grid").jqGrid('getRowData',ids[i]);
                                if(txtUserDivisionCode.val().toUpperCase() === data.userDivisionDivisionCode.toUpperCase()){
                                    txtUserDivisionCode.val(data.userDivisionDivisionCode);
                                    txtUserDivisionName.val(data.userDivisionDivisionName);
                                    validate= false;
                                }
                            }

                            if(validate === true){
                                clearUserDivisionFields();
                                alertMessage("Division Not Found");
                            }
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="user.division.code" name="user.division.code" title="" size="10" required="true" cssClass="required"></s:textfield>
                        <sj:a id="user_btnDivision" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                        &nbsp;<s:textfield id="user.division.name" name="user.division.name" size="28" readonly="true"></s:textfield> 
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td>
                    <script>
                        $.subscribe("userDivisionInput_grid_onSelect", function (event, data) {
                            var selectedRowID = $("#userDivisionInput_grid").jqGrid("getGridParam", "selrow");

                            if (selectedRowID !== userDivision_lastSel) {
                                $('#userDivisionInput_grid').jqGrid("saveRow", userDivision_lastSel);
                                $('#userDivisionInput_grid').jqGrid("editRow", selectedRowID, true);
                                userDivision_lastSel = selectedRowID;
                            } else
                                $('#userDivisionInput_grid').jqGrid("saveRow", selectedRowID);
                        });

                        function userDivisionInputGrid_Delete_OnClick() {
                            var selectDetailRowId = $("#userDivisionInput_grid").jqGrid('getGridParam', 'selrow');
                            if (selectDetailRowId === null) {
                                alert("Please Select Row!");
                                return;
                            }
                            $("#userDivisionInput_grid").jqGrid('delRowData', selectDetailRowId);
                        }

                        $('#btnUserDivision').click(function (ev) {
                            window.open("./pages/search/search-division-multiple.jsp?iddoc=userDivision&type=grid" + "&rowLast=" + userDivision_lastRowId, "Search", "scrollbars=1, width=900, height=600");
                        });

                        function addRowUserDivisionDataMultiSelected(lastRowId, defRow) {

                            var ids = jQuery("#userDivisionInput_grid").jqGrid('getDataIDs');
                            var lastRow = [0];

                            for (var i = 0; i < ids.length; i++) {
                                var comp = (ids[i] - lastRow[0]) > 0;
                                if (comp) {
                                    lastRow = [];
                                    lastRow.push(ids[i]);
                                }
                            }
                            userDivision_lastRowId = lastRowId;
                            var data = $("#userDivisionInput_grid").jqGrid('getRowData', lastRowId);

                            $("#userDivisionInput_grid").jqGrid("addRowData", lastRowId, defRow);
                            $("#userDivisionInput_grid").jqGrid('setRowData', lastRowId, {
                                userDivisionDelete: "delete",
                                userDivisionDivisionCode: defRow.code,
                                userDivisionDivisionName: defRow.name
                            });
                            setHeightGridDivision();
                        }

                        function setHeightGridDivision() {
                            var ids = jQuery("#userDivisionInput_grid").jqGrid('getDataIDs');
                            if (ids.length > 15) {
                                var rowHeight = $("#userDivisionInput_grid" + " tr").eq(1).height();
                                $("#userDivisionInput_grid").jqGrid('setGridHeight', rowHeight * 15, true);
                            } else {
                                $("#userDivisionInput_grid").jqGrid('setGridHeight', "100%", true);
                            }

                        }
                    </script>
                    <div id="userDivisionInputGrid">
                        <table width="20%">
                            <tr>
                                <td>
                                    <sj:a href="#" id="btnUserDivision" button="true" style="width: 130%">Search Division</sj:a> 
                                    </td>
                                </tr>
                            </table>
                        <sjg:grid
                            id="userDivisionInput_grid"
                            dataType="local"                    
                            pager="true"
                            navigator="false"
                            navigatorView="false"
                            navigatorRefresh="false"
                            navigatorDelete="false"
                            navigatorAdd="false"
                            navigatorEdit="false"
                            gridModel="listUserDivision"
                            rowList="10,20,30"
                            rowNum="10"
                            viewrecords="true"
                            rownumbers="true"
                            shrinkToFit="false"
                            editinline="true"
                            width="460"
                            editurl="%{remoteurlUserDivisionInput}"
                            onSelectRowTopics="userDivisionInput_grid_onSelect"
                            >
                            <sjg:gridColumn
                                name="userDivision" index="userDivision" title="" width="10" align="centre"
                                editable="true" edittype="text" hidden="true"
                                />
                            <sjg:gridColumn
                                name="userDivisionDelete" index="userDivisionDelete" title="" width="50" align="centre"
                                editable="true"
                                edittype="button"
                                editoptions="{onClick:'userDivisionInputGrid_Delete_OnClick()', value:'delete'}"
                                />
                            <sjg:gridColumn
                                name="userDivisionDivisionCode" index="userDivisionDivisionCode" 
                                key="userDivisionDivisionCode" title="Division Code" width="80" sortable="true" 
                                />
                            <sjg:gridColumn
                                name="userDivisionDivisionName" index="userDivisionDivisionName" 
                                key="userDivisionDivisionName" title="Division Name" width="285" sortable="true"
                                />
                        </sjg:grid>                
                    </div>
                    <br/>
                </td>
            </tr>
        </table>
        <!--End Division-->
        </s:form>
        <br class="spacer" />    
        <table>
            <tr>
                <td/>
                <td>
                    <sj:a href="#" id="btnUserSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnUserCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </div>