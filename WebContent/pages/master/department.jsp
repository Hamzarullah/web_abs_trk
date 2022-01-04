<%-- 
    Document   : department
    Created on : Jan 15, 2020, 9:20:52 AM
    Author     : Rayis
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #errmsgMinStock,#errmsgMaxStock{
        color: red;
    }
</style>
<script type="text/javascript">

    var     
            txtDepartmentCode = $("#department\\.code"),
            txtDepartmentName = $("#department\\.name"),
            txtDepartmentActiveStatus = $("#department\\.activeStatus"),
            chkDepartmentActiveStatus = $("#departmentActiveStatus"),
            lblActiveDepartment = $("#lblActiveDepartment"),
            txtDepartmentRemark = $("#department\\.remark"),
            txtDepartmentInActiveBy = $("#department\\.inActiveBy"),
            txtDepartmentInActiveDate = $("#department\\.inActiveDate"),
            txtDepartmentCreatedBy = $("#department\\.createdBy"), 
            txtDepartmentCreatedDate = $("#department\\.createdDate"),
            allFieldsDepartment = $([])
            .add(txtDepartmentCode)
            .add(txtDepartmentName)
            .add(txtDepartmentRemark)
            .add(txtDepartmentInActiveBy)
            .add(txtDepartmentInActiveDate);

    function reloadGridDepartment() {
        $("#department_grid").jqGrid('setGridWidth', $("#tabs").width() - 30, false);
        $("#department_grid").jqGrid("setGridParam",{url:"master/department-search-data?" + $("#frmDepartmentSearchInput").serialize()});
        $("#department_grid").trigger("reloadGrid");
    }

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("department");
        $('#department\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $('input[name="departmentSearchActiveStatusRad"][value="Active"]').prop('checked',true);
        $("#departmentSearchActiveStatus").val("Active");
        
        $('input[name="departmentSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="All";
            $("#departmentSearchActiveStatus").val(value);
        });
        
        $('input[name="departmentSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="Active";
            $("#departmentSearchActiveStatus").val(value);
        });
                
        $('input[name="departmentSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="InActive";
            $("#departmentSearchActiveStatus").val(value);
        });
        $('#departmentActiveStatusActive').change(function(ev){
            var value="true";
            $("#department\\.activeStatus").val(value);
        });
                
        $('#departmentActiveStatusInActive').change(function(ev){
            var value="false";
            $("#department\\.activeStatus").val(value);
        });

        $('#btnDepartmentNew').click(function (ev) {
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/department-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("department");
                    hideInput("departmentSearch");
                    txtDepartmentCode.attr("readonly", false);
                    updateRowId = -1;
                    $('#departmentActiveStatusActive').prop('checked',true);
                    var value="true";
                    $("#department\\.activeStatus").val(value);
                    $("#department\\.inActiveDate").val("01/01/1900");
                    ev.preventDefault();
                 });
             });
        });

        $('#btnDepartmentUpdate').click(function (ev) {
                var url="master/department-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#department_grid").jqGrid('getGridParam', 'selrow');
                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        chkDepartmentActiveStatus.attr("disabled", false);
                        txtDepartmentCode.attr("readonly", true);

                        var department = $("#department_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/department-get-data";
                        var params = "department.code=" + department.code;
                            params += "&department.activeStatus=" + department.activeStatus;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtDepartmentCode.val(data.departmentTemp.code);
                            txtDepartmentName.val(data.departmentTemp.name);
                            chkDepartmentActiveStatus.attr('checked', data.departmentTemp.activeStatus);
                            txtDepartmentRemark.val(data.departmentTemp.remark);
                            txtDepartmentCreatedBy.val(data.departmentTemp.createdBy);
                            txtDepartmentCreatedDate.val(data.departmentTemp.createdDate);
                            txtDepartmentInActiveBy.val(data.departmentTemp.inActiveBy);
                            var inActiveDate = data.departmentTemp.inActiveDate;
                            txtDepartmentInActiveDate.val(inActiveDate);
                            
                            if(data.departmentTemp.activeStatus===true) {
                               $('#departmentActiveStatusActive').prop('checked',true);
                               $("#department\\.activeStatus").val("true");
                            }
                            else {                        
                               $('#departmentActiveStatusInActive').prop('checked',true);              
                               $("#department\\.activeStatus").val("false");
                            }

                            showInput("department");
                            hideInput("departmentSearch");
                        });
                    }
                    ev.preventDefault();
            });
        });

        $('#btnDepartmentSave').click(function (ev) {
            if (!$("#frmDepartmentInput").valid()) {
                ev.preventDefault();
                return;
            }

            var url = "";

            if (updateRowId < 0)
                url = "master/department-save";
            else
                url = "master/department-update";

            var params = $("#frmDepartmentInput").serialize();

            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("department");
                showInput("departmentSearch");
                allFieldsDepartment.val('').siblings('label[class="error"]').hide();
                reloadGridDepartment();
            });
            ev.preventDefault();
        });

        $('#btnDepartmentDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/department-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#department_grid").jqGrid('getGridParam', 'selrow');
                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var department = $("#department_grid").jqGrid('getRowData', deleteRowId);
//                        if (confirm("Are You Sure To Delete (Code : " + department.code + ")")) {
                            var url = "master/department-delete";
                            var params = "department.code=" + department.code;
                            var message="Are You Sure To Delete(Code : "+ department.code + ")?";
                            alertMessageDelete("department",url,params,message,400);
//                            $.post(url, params, function () {
                                reloadGridDepartment();
//                            });
//                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $('#btnDepartmentCancel').click(function (ev) {
            hideInput("department");
            showInput("departmentSearch");
            allFieldsDepartment.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        $('#btnDepartment_search').click(function(ev) {
            $("#department_grid").jqGrid("clearGridData");
            $("#department_grid").jqGrid("setGridParam",{url:"master/department-search-data?" + $("#frmDepartmentSearchInput").serialize()});
            $("#department_grid").trigger("reloadGrid");
            ev.preventDefault();
            
        });

        $('#btnDepartmentRefresh').click(function (ev) {
            reloadGridDepartment();
        });
    });

</script>

<s:url id="remoteurlDepartment" action="department-search-data" />

<b>DEPARTMENT</b>
<hr>
<br class="spacer" />
<sj:div id="departmentButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDepartmentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDepartmentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDepartmentDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDepartmentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>


<div id="departmentSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDepartmentSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="center" ><b>Code</b></td>
                <td>
                    <s:textfield id="departmentSearchCode" name="departmentSearchCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="center"><b>Name</b></td>
                <td>
                    <s:textfield id="departmentSearchName" name="departmentSearchName" size="50"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="departmentSearchActiveStatus" name="departmentSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="departmentSearchActiveStatusRad" name="departmentSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDepartment_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
        <br/>
    </s:form>
</div>

<div id="departmentGrid">
    <sjg:grid
        id="department_grid"
        caption="DEPARTMENT"
        dataType="json"
        href="%{remoteurlDepartment}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDepartmentTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuCAR_BRAND').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="50" sortable="true"
            />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />  
    </sjg:grid >
</div>

<div id="departmentInput" class="content ui-widget">
    <s:form id="frmDepartmentInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="department.code" name="department.code" title="Please Enter Code <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="department.name" name="department.name" size="50" title="Please Enter Name <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>

                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="departmentActiveStatus" name="departmentActiveStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="department.activeStatus" name="department.activeStatus"  required="true" size="50"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td align="right"><B>Remark</B></td>
                    <td>
                    <s:textfield id="department.remark" name="department.remark" title="Please Enter Remark" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="department.inActiveBy" name="department.inActiveBy" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <s:textfield disabled="true" id="department.inActiveDate" name="department.inActiveDate" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr> 
                    <td><s:textfield id="department.createdBy"  name="department.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="department.createdDate" name="department.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnDepartmentSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnDepartmentCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>