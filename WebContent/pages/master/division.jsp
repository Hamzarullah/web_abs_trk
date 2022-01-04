<%-- 
    Document   : division
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

<script type="text/javascript">

    var     
            txtDivisionCode = $("#division\\.code"),
            txtDivisionName = $("#division\\.name"),
            txtDivisionDepartmentCode = $("#division\\.department\\.code"),
            txtDivisionDepartmentName = $("#division\\.department\\.name"),
            txtDivisionActiveStatus = $("#division\\.activeStatus"),
            chkDivisionActiveStatus = $("#divisionActiveStatus"),
            lblActiveDivision = $("#lblActiveDivision"),
            txtDivisionRemark = $("#division\\.remark"),
            txtDivisionInActiveBy = $("#division\\.inActiveBy"),
            dtpDivisionInActiveDate = $("#division\\.inActiveDate"),
            txtDivisionCreatedBy = $("#division\\.createdBy"), 
            dtpDivisionCreatedDate = $("#division\\.createdDate"),
            allFieldsDivision = $([])
            .add(txtDivisionCode)
            .add(txtDivisionName)
            .add(txtDivisionDepartmentCode)
            .add(txtDivisionDepartmentName)
            .add(txtDivisionRemark)
            .add(txtDivisionInActiveBy)
            .add(dtpDivisionInActiveDate);

    function reloadGridDivision() {
        $("#division_grid").jqGrid('setGridWidth', $("#tabs").width() - 30, false);
        $("#division_grid").jqGrid("setGridParam",{url:"master/division-search-data?" + $("#frmDivisionSearchInput").serialize()});
        $("#division_grid").trigger("reloadGrid");
    }
    
    function formatDivisionDate(date, useTime) {
        var dateValuesTemps;

        if (useTime) {
            var dateValues = date.split(' ');
            var dateValuesTemp = dateValues[0].split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            var dateValuesTemp = date.split('/');
            var dateValue = dateValuesTemp[1] + "/" + dateValuesTemp[0] + "/" + dateValuesTemp[2];
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    function formatDivisionDateRemoveT(date, useTime) {
        var dateValues = date.split('T');
        var dateValuesTemp = dateValues[0].split('-');
        var dateValue = dateValuesTemp[2] + "/" + dateValuesTemp[1] + "/" + dateValuesTemp[0];
        var dateValuesTemps;

        if (useTime) {
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
            
    function divisionFormatDate(){
        
        var inActiveDate=formatDivisionDate(dtpDivisionInActiveDate.val(),true);
        dtpDivisionInActiveDate.val(inActiveDate);
        $("#divisionTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDivisionDate(dtpDivisionCreatedDate.val(),true);
        dtpDivisionCreatedDate.val(createdDate);
        $("#divisionTemp\\.createdDateTemp").val(createdDate);
    }
    
    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("division");
        $('#division\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $('input[name="divisionSearchActiveStatusRad"][value="Active"]').prop('checked',true);
        $("#divisionSearchActiveStatus").val("Active");
        
        $('input[name="divisionSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="All";
            $("#divisionSearchActiveStatus").val(value);
        });
        
        $('input[name="divisionSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="Active";
            $("#divisionSearchActiveStatus").val(value);
        });
                
        $('input[name="divisionSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="InActive";
            $("#divisionSearchActiveStatus").val(value);
        });
        $('#divisionActiveStatusActive').change(function(ev){
            var value="true";
            $("#division\\.activeStatus").val(value);
        });
                
        $('#divisionActiveStatusInActive').change(function(ev){
            var value="false";
            $("#division\\.activeStatus").val(value);
        });

        $('#btnDivisionNew').click(function (ev) {
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/division-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("division");
                    hideInput("divisionSearch");
                    txtDivisionCode.attr("readonly", false);
                    updateRowId = -1;
                    $('#divisionActiveStatusActive').prop('checked',true);
                    var value="true";
                    $("#division\\.activeStatus").val(value);
                    $("#division\\.inActiveDate").val("01/01/1900");
                    ev.preventDefault();
                 });
             });
        });

        $('#btnDivisionUpdate').click(function (ev) {
                var url="master/division-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#division_grid").jqGrid('getGridParam', 'selrow');
                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        chkDivisionActiveStatus.attr("disabled", false);
                        txtDivisionCode.attr("readonly", true);

                        var division = $("#division_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/division-get-data";
                        var params = "division.code=" + division.code;
                            params += "&division.activeStatus=" + division.activeStatus;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtDivisionCode.val(data.divisionTemp.code);
                            txtDivisionName.val(data.divisionTemp.name);
                            txtDivisionDepartmentCode.val(data.divisionTemp.departmentCode);
                            txtDivisionDepartmentName.val(data.divisionTemp.departmentName);
                            chkDivisionActiveStatus.attr('checked', data.divisionTemp.activeStatus);
                            txtDivisionRemark.val(data.divisionTemp.remark);
                            txtDivisionCreatedBy.val(data.divisionTemp.createdBy);
                            dtpDivisionCreatedDate.val(data.divisionTemp.createdDate);
                            txtDivisionInActiveBy.val(data.divisionTemp.inActiveBy);
                            var inActiveDate =formatDivisionDateRemoveT(data.divisionTemp.inActiveDate,true);
                            dtpDivisionInActiveDate.val(inActiveDate);
                            
                            if(data.divisionTemp.activeStatus===true) {
                               $('#divisionActiveStatusActive').prop('checked',true);
                               $("#division\\.activeStatus").val("true");
                            }
                            else {                        
                               $('#divisionActiveStatusInActive').prop('checked',true);              
                               $("#division\\.activeStatus").val("false");
                            }

                            showInput("division");
                            hideInput("divisionSearch");
                        });
                    }
                    ev.preventDefault();
            });
        });

        $('#btnDivisionSave').click(function (ev) {
            if (!$("#frmDivisionInput").valid()) {
                ev.preventDefault();
                return;
            }

            var url = "";

            if (updateRowId < 0)
                url = "master/division-save";
            else
                url = "master/division-update";

            var params = $("#frmDivisionInput").serialize();

            $.post(url, params, function (data) {
                if (data.error) {
                    alert(data.errorMessage);
                    return;
                }
                hideInput("division");
                showInput("divisionSearch");
                allFieldsDivision.val('').siblings('label[class="error"]').hide();
                reloadGridDivision();
            });
            ev.preventDefault();
        });

        $('#btnDivisionDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/division-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#division_grid").jqGrid('getGridParam', 'selrow');
                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var division = $("#division_grid").jqGrid('getRowData', deleteRowId);
                        if (confirm("Are You Sure To Delete (Code : " + division.code + ")")) {
                            var url = "master/division-delete";
                            var params = "division.code=" + division.code;
                            $.post(url, params, function () {
                                reloadGridDivision();
                            });
                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $('#btnDivisionCancel').click(function (ev) {
            hideInput("division");
            showInput("divisionSearch");
            allFieldsDivision.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        $('#btnDivision_search').click(function(ev) {
            $("#division_grid").jqGrid("clearGridData");
            $("#division_grid").jqGrid("setGridParam",{url:"master/division-search-data?" + $("#frmDivisionSearchInput").serialize()});
            $("#division_grid").trigger("reloadGrid");
            ev.preventDefault();
            
        });

        $('#btnDivisionRefresh').click(function (ev) {
            reloadGridDivision();
        });
    });

</script>

<s:url id="remoteurlDivision" action="division-search-data" />

<b>DIVISION</b>
<hr>
<br class="spacer" />
<sj:div id="divisionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDivisionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDivisionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDivisionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDivisionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>


<div id="divisionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDivisionSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="center" ><b>Code</b></td>
                <td>
                    <s:textfield id="divisionSearchCode" name="divisionSearchCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="center"><b>Name</b></td>
                <td>
                    <s:textfield id="divisionSearchName" name="divisionSearchName" size="50"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="divisionSearchActiveStatus" name="divisionSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="divisionSearchActiveStatusRad" name="divisionSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDivision_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
        <br/>
    </s:form>
</div>

<div id="divisionGrid">
    <sjg:grid
        id="division_grid"
        caption="DIVISION"
        dataType="json"
        href="%{remoteurlDivision}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDivisionTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuDIVISION').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="50" sortable="true"
            />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="departmentCode" index="departmentCode" title="Department Code" width="150" sortable="true"
            />
        <sjg:gridColumn
            name="departmentName" index="departmentName" title="Department Name" width="200" sortable="true"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />  
    </sjg:grid >
</div>

<div id="divisionInput" class="content ui-widget">
    <s:form id="frmDivisionInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="division.code" name="division.code" title="Please Enter Code <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="division.name" name="division.name" size="50" title="Please Enter Name <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top"><b>Department *</b></td>
                    <td>
                        <script type = "text/javascript">
                            $('#division_btnDepartment').click(function (ev) {
                                window.open("./pages/search/search-department.jsp?iddoc=division&idsubdoc=department", "Search", "scrollbars=1,width=600, height=500");
                            });

                            txtDivisionDepartmentCode.change(function (ev) {
                                
                                if(txtDivisionDepartmentCode.val()===""){
                                    txtDivisionDepartmentName.val("");
                                    return;
                                }
                                
                                var url = "master/department-get";
                                var params = "department.code=" + txtDivisionDepartmentCode.val();
                                    params+="&department.activeStatus=TRUE";
                                $.post(url, params, function (result) {
                                    var data = (result);
                                    if (data.departmentTemp) {
                                        txtDivisionDepartmentCode.val(data.departmentTemp.code);
                                        txtDivisionDepartmentName.val(data.departmentTemp.name);
                                    } else {
                                        alert("Department Not Found");
                                        txtDivisionDepartmentCode.val("");
                                        txtDivisionDepartmentName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="division.department.code" name="division.department.code" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="division_btnDepartment">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-division-department"/></sj:a>
                        </div>       
                        <s:textfield id="division.department.name" name="division.department.name" size="25" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="divisionActiveStatus" name="divisionActiveStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="division.activeStatus" name="division.activeStatus"  required="true" size="50"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td align="right">Remark</td>
                    <td>
                    <s:textarea id="division.remark" name="division.remark" title="Please Enter Remark" cols="50" rows="3"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="division.inActiveBy" name="division.inActiveBy" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                        <sj:datepicker id="division.inActiveDate" name="division.inActiveDate" displayFormat="dd/mm/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus" disabled="true" readonly="true"></sj:datepicker>
                    </td>
                </tr>
                <tr> 
                    <td><s:textfield id="division.createdBy"  name="division.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td>
                        <sj:datepicker id="division.createdDate" name="division.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus" style="display:none"></sj:datepicker>
                    </td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnDivisionSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnDivisionCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>