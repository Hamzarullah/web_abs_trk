
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
        txtJobPositionCode=$("#jobPosition\\.code"),
        txtJobPositionName=$("#jobPosition\\.name"),
        rdbJobPositionActiveStatus=$("#jobPosition\\.activeStatus"),
        txtJobPositionRemark=$("#jobPosition\\.remark"),
        txtJobPositionInActiveBy = $("#jobPosition\\.inActiveBy"),
        dtpJobPositionInActiveDate = $("#jobPosition\\.inActiveDate"),
        txtJobPositionCreatedBy = $("#jobPosition\\.createdBy"),
        dtpJobPositionCreatedDate = $("#jobPosition\\.createdDate"),
        
        allFieldsJobPosition=$([])
            .add(txtJobPositionCode)
            .add(txtJobPositionName)
            .add(txtJobPositionRemark)
            .add(txtJobPositionInActiveBy)
            .add(txtJobPositionCreatedBy);


    function reloadGridJobPosition(){
        $("#jobPosition_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("jobPosition");
        
        $('#jobPosition\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#jobPositionSearchActiveStatusRadActive').prop('checked',true);
        $("#jobPositionSearchActiveStatus").val("true");
        
        $('input[name="jobPositionSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#jobPositionSearchActiveStatus").val(value);
        });
        
        $('input[name="jobPositionSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#jobPositionSearchActiveStatus").val(value);
        });
                
        $('input[name="jobPositionSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#jobPositionSearchActiveStatus").val(value);
        });
        
        $('input[name="jobPositionActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#jobPosition\\.activeStatus").val(value);
            $("#jobPosition\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="jobPositionActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#jobPosition\\.activeStatus").val(value);
        });
        
        $("#btnJobPositionNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/job-position-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_jobPosition();
                showInput("jobPosition");
                hideInput("jobPositionSearch");
                $('#jobPositionActiveStatusRadActive').prop('checked',true);
                $("#jobPosition\\.activeStatus").val("true");
                $("#jobPosition\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#jobPosition\\.createdDate").val("01/01/1900 00:00:00");
                txtJobPositionCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtJobPositionCode.attr("readonly",true);
                txtJobPositionCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnJobPositionSave").click(function(ev) {
           if(!$("#frmJobPositionInput").valid()) {
//               handlers_input_jobPosition();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           jobPositionFormatDate();
           if (updateRowId < 0){
               url = "master/job-position-save";
           } else{
               url = "master/job-position-update";
           }
           
           var params = $("#frmJobPositionInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    jobPositionFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("jobPosition");
                showInput("jobPositionSearch");
                allFieldsJobPosition.val('').siblings('label[class="error"]').hide();
                txtJobPositionCode.val("AUTO");
                reloadGridJobPosition();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnJobPositionUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/job-position-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_jobPosition();
                updateRowId=$("#jobPosition_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var jobPosition=$("#jobPosition_grid").jqGrid('getRowData',updateRowId);
                var url="master/job-position-get-data";
                var params="jobPosition.code=" + jobPosition.code;

                txtJobPositionCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtJobPositionCode.val(data.jobPositionTemp.code);
                        txtJobPositionName.val(data.jobPositionTemp.name);
                        rdbJobPositionActiveStatus.val(data.jobPositionTemp.activeStatus);
                        txtJobPositionRemark.val(data.jobPositionTemp.remark);
                        txtJobPositionInActiveBy.val(data.jobPositionTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.jobPositionTemp.inActiveDate,true);
                        dtpJobPositionInActiveDate.val(inActiveDate);
                        txtJobPositionCreatedBy.val(data.jobPositionTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.jobPositionTemp.createdDate,true);
                        dtpJobPositionCreatedDate.val(createdDate);

                        if(data.jobPositionTemp.activeStatus===true) {
                           $('#jobPositionActiveStatusRadActive').prop('checked',true);
                           $("#jobPosition\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#jobPositionActiveStatusRadInActive').prop('checked',true);              
                           $("#jobPosition\\.activeStatus").val("false");
                        }

                        showInput("jobPosition");
                        hideInput("jobPositionSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnJobPositionDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/job-position-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#jobPosition_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var jobPosition=$("#jobPosition_grid").jqGrid('getRowData',deleteRowID);
                var url="master/job-position-delete";
                var params="jobPosition.code=" + jobPosition.code;
                var message="Are You Sure To Delete(Code : "+ jobPosition.code + ")?";
                alertMessageDelete("jobPosition",url,params,message,400);
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnJobPositionCancel").click(function(ev) {
            hideInput("jobPosition");
            showInput("jobPositionSearch");
            allFieldsJobPosition.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnJobPositionRefresh').click(function(ev) {
            $('#jobPositionSearchActiveStatusRadActive').prop('checked',true);
            $("#jobPositionSearchActiveStatus").val("true");
            $("#jobPosition_grid").jqGrid("clearGridData");
            $("#jobPosition_grid").jqGrid("setGridParam",{url:"master/job-position-data?"});
            $("#jobPosition_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnJobPositionPrint").click(function(ev) {
            
            var url = "reports/job-position-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'jobPosition','width=500,height=500');
        });
        
        $('#btnJobPosition_search').click(function(ev) {
            $("#jobPosition_grid").jqGrid("clearGridData");
            $("#jobPosition_grid").jqGrid("setGridParam",{url:"master/job-position-data?" + $("#frmJobPositionSearchInput").serialize()});
            $("#jobPosition_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_jobPosition(){
//        unHandlersInput(txtJobPositionCode);
//        unHandlersInput(txtJobPositionName);
//    }
//
//    function handlers_input_jobPosition(){
//        if(txtJobPositionCode.val()===""){
//            handlersInput(txtJobPositionCode);
//        }else{
//            unHandlersInput(txtJobPositionCode);
//        }
//        if(txtJobPositionName.val()===""){
//            handlersInput(txtJobPositionName);
//        }else{
//            unHandlersInput(txtJobPositionName);
//        }
//    }
    
    function jobPositionFormatDate(){
        var inActiveDate=formatDate(dtpJobPositionInActiveDate.val(),true);
        dtpJobPositionInActiveDate.val(inActiveDate);
        $("#jobPositionTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpJobPositionCreatedDate.val(),true);
        dtpJobPositionCreatedDate.val(createdDate);
        $("#jobPositionTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlJobPosition" action="job-position-data" />
<b>JobPosition</b>
<hr>
<br class="spacer"/>


<sj:div id="jobPositionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnJobPositionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnJobPositionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnJobPositionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnJobPositionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnJobPositionPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="jobPositionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmJobPositionSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="jobPositionSearchCode" name="jobPositionSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="jobPositionSearchName" name="jobPositionSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="jobPositionSearchActiveStatus" name="jobPositionSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="jobPositionSearchActiveStatusRad" name="jobPositionSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnJobPosition_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="jobPositionGrid">
    <sjg:grid
        id="jobPosition_grid"
        dataType="json"
        href="%{remoteurlJobPosition}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listJobPositionTemp"
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
    
<div id="jobPositionInput" class="content ui-widget">
    <s:form id="frmJobPositionInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="jobPosition.code" name="jobPosition.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="jobPosition.name" name="jobPosition.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="jobPositionActiveStatusRad" name="jobPositionActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="jobPosition.activeStatus" name="jobPosition.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="jobPosition.remark" name="jobPosition.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="jobPosition.inActiveBy"  name="jobPosition.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="jobPosition.inActiveDate" name="jobPosition.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="jobPosition.createdBy"  name="jobPosition.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="jobPosition.createdDate" name="jobPosition.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="jobPositionTemp.inActiveDateTemp" name="jobPositionTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="jobPositionTemp.createdDateTemp" name="jobPositionTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnJobPositionSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnJobPositionCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>