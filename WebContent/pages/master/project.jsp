
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
     
    var 
        txtProjectCode=$("#project\\.code"),
        txtProjectName=$("#project\\.name"),
        rdbProjectActiveStatus=$("#project\\.activeStatus"),
        txtProjectRemark=$("#project\\.remark"),
        txtProjectInActiveBy = $("#project\\.inActiveBy"),
        dtpProjectInActiveDate = $("#project\\.inActiveDate"),
        txtProjectCreatedBy = $("#project\\.createdBy"),
        dtpProjectCreatedDate = $("#project\\.createdDate"),
        
        allFieldsProject=$([])
            .add(txtProjectCode)
            .add(txtProjectName)
            .add(txtProjectRemark)
            .add(txtProjectInActiveBy)
            .add(txtProjectCreatedBy);


    function reloadGridProject(){
        $("#project_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("project");
        
        $('#project\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#projectSearchActiveStatusRadActive').prop('checked',true);
        $("#projectSearchActiveStatus").val("true");
        
        $('input[name="projectSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#projectSearchActiveStatus").val(value);
        });
        
        $('input[name="projectSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#projectSearchActiveStatus").val(value);
        });
                
        $('input[name="projectSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#projectSearchActiveStatus").val(value);
        });
        
        $('input[name="projectActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#project\\.activeStatus").val(value);
            $("#project\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="projectActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#project\\.activeStatus").val(value);
        });
        
        $("#btnProjectNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/project-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_project();
                showInput("project");
                hideInput("projectSearch");
                $('#projectActiveStatusRadActive').prop('checked',true);
                $("#project\\.activeStatus").val("true");
                $("#project\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#project\\.createdDate").val("01/01/1900 00:00:00");
                txtProjectCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtProjectCode.attr("readonly",true);
                txtProjectCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnProjectSave").click(function(ev) {
           if(!$("#frmProjectInput").valid()) {
//               handlers_input_project();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           projectFormatDate();
           if (updateRowId < 0){
               url = "master/project-save";
           } else{
               url = "master/project-update";
           }
           
           var params = $("#frmProjectInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    projectFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("project");
                showInput("projectSearch");
                allFieldsProject.val('').siblings('label[class="error"]').hide();
                txtProjectCode.val("AUTO");
                reloadGridProject();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnProjectUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/project-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_project();
                updateRowId=$("#project_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var project=$("#project_grid").jqGrid('getRowData',updateRowId);
                var url="master/project-get-data";
                var params="project.code=" + project.code;

                txtProjectCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtProjectCode.val(data.projectTemp.code);
                        txtProjectName.val(data.projectTemp.name);
                        rdbProjectActiveStatus.val(data.projectTemp.activeStatus);
                        txtProjectRemark.val(data.projectTemp.remark);
                        txtProjectInActiveBy.val(data.projectTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.projectTemp.inActiveDate,true);
                        dtpProjectInActiveDate.val(inActiveDate);
                        txtProjectCreatedBy.val(data.projectTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.projectTemp.createdDate,true);
                        dtpProjectCreatedDate.val(createdDate);

                        if(data.projectTemp.activeStatus===true) {
                           $('#projectActiveStatusRadActive').prop('checked',true);
                           $("#project\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#projectActiveStatusRadInActive').prop('checked',true);              
                           $("#project\\.activeStatus").val("false");
                        }

                        showInput("project");
                        hideInput("projectSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnProjectDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/project-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#project_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var project=$("#project_grid").jqGrid('getRowData',deleteRowID);
                var url="master/project-delete";
                var params="project.code=" + project.code;
                var message="Are You Sure To Delete(Code : "+ project.code + ")?";
                alertMessageDelete("project",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ project.code+ ')?</div>');
//
//                dynamicDialog.dialog({
//                    title : "Confirmation:",
//                    closeOnEscape: false,
//                    modal : true,
//                    width: 500,
//                    resizable: false,
//                    buttons : 
//                        [{
//                            text : "Yes",
//                            click : function() {
//
//                                $(this).dialog("close");
//                                var url="master/project-delete";
//                                var params="project.code=" + project.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridProject();
//                                });
//                            }
//                        },
//                        {
//                            text : "No",
//                            click : function() {
//
//                                $(this).dialog("close");
//                            }
//                        }]
//                });
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + project.code+ ")")){
//                    var url="master/project-delete";
//                    var params="project.code=" + project.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridProject();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnProjectCancel").click(function(ev) {
            hideInput("project");
            showInput("projectSearch");
            allFieldsProject.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnProjectRefresh').click(function(ev) {
            $('#projectSearchActiveStatusRadActive').prop('checked',true);
            $("#projectSearchActiveStatus").val("true");
            $("#project_grid").jqGrid("clearGridData");
            $("#project_grid").jqGrid("setGridParam",{url:"master/project-data?"});
            $("#project_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnProjectPrint").click(function(ev) {
            
            var url = "reports/project-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'project','width=500,height=500');
        });
        
        $('#btnProject_search').click(function(ev) {
            $("#project_grid").jqGrid("clearGridData");
            $("#project_grid").jqGrid("setGridParam",{url:"master/project-data?" + $("#frmProjectSearchInput").serialize()});
            $("#project_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_project(){
//        unHandlersInput(txtProjectCode);
//        unHandlersInput(txtProjectName);
//    }
//
//    function handlers_input_project(){
//        if(txtProjectCode.val()===""){
//            handlersInput(txtProjectCode);
//        }else{
//            unHandlersInput(txtProjectCode);
//        }
//        if(txtProjectName.val()===""){
//            handlersInput(txtProjectName);
//        }else{
//            unHandlersInput(txtProjectName);
//        }
//    }
    
    function projectFormatDate(){
        var inActiveDate=formatDate(dtpProjectInActiveDate.val(),true);
        dtpProjectInActiveDate.val(inActiveDate);
        $("#projectTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpProjectCreatedDate.val(),true);
        dtpProjectCreatedDate.val(createdDate);
        $("#projectTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlProject" action="project-data" />
<b>Item Division</b>
<hr>
<br class="spacer"/>


<sj:div id="projectButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnProjectNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnProjectUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnProjectDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnProjectRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnProjectPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="projectSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmProjectSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="projectSearchCode" name="projectSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="projectSearchName" name="projectSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="projectSearchActiveStatus" name="projectSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="projectSearchActiveStatusRad" name="projectSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnProject_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="projectGrid">
    <sjg:grid
        id="project_grid"
        dataType="json"
        href="%{remoteurlProject}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listProjectTemp"
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
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="projectInput" class="content ui-widget">
    <s:form id="frmProjectInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="project.code" name="project.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="project.name" name="project.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="projectActiveStatusRad" name="projectActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="project.activeStatus" name="project.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="project.remark" name="project.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="project.inActiveBy"  name="project.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="project.inActiveDate" name="project.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="project.createdBy"  name="project.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="project.createdDate" name="project.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="projectTemp.inActiveDateTemp" name="projectTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="projectTemp.createdDateTemp" name="projectTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnProjectSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnProjectCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>