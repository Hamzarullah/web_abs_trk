
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
        txtEducationCode=$("#education\\.code"),
        txtEducationName=$("#education\\.name"),
        rdbEducationActiveStatus=$("#education\\.activeStatus"),
        txtEducationRemark=$("#education\\.remark"),
        txtEducationInActiveBy = $("#education\\.inActiveBy"),
        dtpEducationInActiveDate = $("#education\\.inActiveDate"),
        txtEducationCreatedBy = $("#education\\.createdBy"),
        dtpEducationCreatedDate = $("#education\\.createdDate"),
        
        allFieldsEducation=$([])
            .add(txtEducationCode)
            .add(txtEducationName)
            .add(txtEducationRemark)
            .add(txtEducationInActiveBy)
            .add(txtEducationCreatedBy);


    function reloadGridEducation(){
        $("#education_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("education");
        
        $('#education\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#educationSearchActiveStatusRadActive').prop('checked',true);
        $("#educationSearchActiveStatus").val("true");
        
        $('input[name="educationSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#educationSearchActiveStatus").val(value);
        });
        
        $('input[name="educationSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#educationSearchActiveStatus").val(value);
        });
                
        $('input[name="educationSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#educationSearchActiveStatus").val(value);
        });
        
        $('input[name="educationActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#education\\.activeStatus").val(value);
            $("#education\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="educationActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#education\\.activeStatus").val(value);
        });
        
        $("#btnEducationNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/education-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_education();
                showInput("education");
                hideInput("educationSearch");
                $('#educationActiveStatusRadActive').prop('checked',true);
                $("#education\\.activeStatus").val("true");
                $("#education\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#education\\.createdDate").val("01/01/1900 00:00:00");
                txtEducationCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtEducationCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnEducationSave").click(function(ev) {
           if(!$("#frmEducationInput").valid()) {
//               handlers_input_education();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           educationFormatDate();
           if (updateRowId < 0){
               url = "master/education-save";
           } else{
               url = "master/education-update";
           }
           
           var params = $("#frmEducationInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    educationFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("education");
                showInput("educationSearch");
                allFieldsEducation.val('').siblings('label[class="error"]').hide();
                reloadGridEducation();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnEducationUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/education-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_education();
                updateRowId=$("#education_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var education=$("#education_grid").jqGrid('getRowData',updateRowId);
                var url="master/education-get-data";
                var params="education.code=" + education.code;

                txtEducationCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtEducationCode.val(data.educationTemp.code);
                        txtEducationName.val(data.educationTemp.name);
                        rdbEducationActiveStatus.val(data.educationTemp.activeStatus);
                        txtEducationRemark.val(data.educationTemp.remark);
                        txtEducationInActiveBy.val(data.educationTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.educationTemp.inActiveDate,true);
                        dtpEducationInActiveDate.val(inActiveDate);
                        txtEducationCreatedBy.val(data.educationTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.educationTemp.createdDate,true);
                        dtpEducationCreatedDate.val(createdDate);

                        if(data.educationTemp.activeStatus===true) {
                           $('#educationActiveStatusRadActive').prop('checked',true);
                           $("#education\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#educationActiveStatusRadInActive').prop('checked',true);              
                           $("#education\\.activeStatus").val("false");
                        }

                        showInput("education");
                        hideInput("educationSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnEducationDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/education-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#education_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var education=$("#education_grid").jqGrid('getRowData',deleteRowID);
                var url="master/education-delete";
                var params="education.code=" + education.code;
                var message="Are You Sure To Delete(Code : "+ education.code + ")?";
                alertMessageDelete("education",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ education.code+ ')?</div>');
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
//                                var url="master/education-delete";
//                                var params="education.code=" + education.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridEducation();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + education.code+ ")")){
//                    var url="master/education-delete";
//                    var params="education.code=" + education.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridEducation();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnEducationCancel").click(function(ev) {
            hideInput("education");
            showInput("educationSearch");
            allFieldsEducation.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnEducationRefresh').click(function(ev) {
            $('#educationSearchActiveStatusRadActive').prop('checked',true);
            $("#educationSearchActiveStatus").val("true");
            $("#education_grid").jqGrid("clearGridData");
            $("#education_grid").jqGrid("setGridParam",{url:"master/education-data?"});
            $("#education_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnEducationPrint").click(function(ev) {
            
            var url = "reports/education-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'education','width=500,height=500');
        });
        
        $('#btnEducation_search').click(function(ev) {
            $("#education_grid").jqGrid("clearGridData");
            $("#education_grid").jqGrid("setGridParam",{url:"master/education-data?" + $("#frmEducationSearchInput").serialize()});
            $("#education_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_education(){
//        unHandlersInput(txtEducationCode);
//        unHandlersInput(txtEducationName);
//    }
//
//    function handlers_input_education(){
//        if(txtEducationCode.val()===""){
//            handlersInput(txtEducationCode);
//        }else{
//            unHandlersInput(txtEducationCode);
//        }
//        if(txtEducationName.val()===""){
//            handlersInput(txtEducationName);
//        }else{
//            unHandlersInput(txtEducationName);
//        }
//    }
    
    function educationFormatDate(){
        var inActiveDate=formatDate(dtpEducationInActiveDate.val(),true);
        dtpEducationInActiveDate.val(inActiveDate);
        $("#educationTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpEducationCreatedDate.val(),true);
        dtpEducationCreatedDate.val(createdDate);
        $("#educationTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlEducation" action="education-data" />
<b>EDUCATION</b>
<hr>
<br class="spacer"/>


<sj:div id="educationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnEducationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnEducationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnEducationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnEducationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnEducationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="educationSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmEducationSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="educationSearchCode" name="educationSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="educationSearchName" name="educationSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="educationSearchActiveStatus" name="educationSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="educationSearchActiveStatusRad" name="educationSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnEducation_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="educationGrid">
    <sjg:grid
        id="education_grid"
        dataType="json"
        href="%{remoteurlEducation}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listEducationTemp"
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
    
<div id="educationInput" class="content ui-widget">
    <s:form id="frmEducationInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="education.code" name="education.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="education.name" name="education.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="educationActiveStatusRad" name="educationActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="education.activeStatus" name="education.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="education.remark" name="education.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="education.inActiveBy"  name="education.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="education.inActiveDate" name="education.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="education.createdBy"  name="education.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="education.createdDate" name="education.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="educationTemp.inActiveDateTemp" name="educationTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="educationTemp.createdDateTemp" name="educationTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnEducationSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnEducationCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>