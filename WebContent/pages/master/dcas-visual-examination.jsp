
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
        txtDcasVisualExaminationCode=$("#dcasVisualExamination\\.code"),
        txtDcasVisualExaminationName=$("#dcasVisualExamination\\.name"),
        rdbDcasVisualExaminationActiveStatus=$("#dcasVisualExamination\\.activeStatus"),
        txtDcasVisualExaminationRemark=$("#dcasVisualExamination\\.remark"),
        txtDcasVisualExaminationInActiveBy = $("#dcasVisualExamination\\.inActiveBy"),
        dtpDcasVisualExaminationInActiveDate = $("#dcasVisualExamination\\.inActiveDate"),
        txtDcasVisualExaminationCreatedBy = $("#dcasVisualExamination\\.createdBy"),
        dtpDcasVisualExaminationCreatedDate = $("#dcasVisualExamination\\.createdDate"),
        
        allFieldsDcasVisualExamination=$([])
            .add(txtDcasVisualExaminationCode)
            .add(txtDcasVisualExaminationName)
            .add(txtDcasVisualExaminationRemark)
            .add(txtDcasVisualExaminationInActiveBy)
            .add(txtDcasVisualExaminationCreatedBy);


    function reloadGridDcasVisualExamination(){
        $("#dcasVisualExamination_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasVisualExamination");
        
        $('#dcasVisualExamination\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasVisualExaminationSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasVisualExaminationSearchActiveStatus").val("true");
        
        $('input[name="dcasVisualExaminationSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasVisualExaminationSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasVisualExaminationSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasVisualExaminationSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasVisualExaminationSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasVisualExaminationSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasVisualExaminationActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasVisualExamination\\.activeStatus").val(value);
            $("#dcasVisualExamination\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasVisualExaminationActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasVisualExamination\\.activeStatus").val(value);
        });
        
        $("#btnDcasVisualExaminationNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-visual-examination-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasVisualExamination();
                showInput("dcasVisualExamination");
                hideInput("dcasVisualExaminationSearch");
                $('#dcasVisualExaminationActiveStatusRadActive').prop('checked',true);
                $("#dcasVisualExamination\\.activeStatus").val("true");
                $("#dcasVisualExamination\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasVisualExamination\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasVisualExaminationCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasVisualExaminationCode.attr("readonly",true);
                txtDcasVisualExaminationCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasVisualExaminationSave").click(function(ev) {
           if(!$("#frmDcasVisualExaminationInput").valid()) {
//               handlers_input_dcasVisualExamination();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasVisualExaminationFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-visual-examination-save";
           } else{
               url = "master/dcas-visual-examination-update";
           }
           
           var params = $("#frmDcasVisualExaminationInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasVisualExaminationFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasVisualExamination");
                showInput("dcasVisualExaminationSearch");
                allFieldsDcasVisualExamination.val('').siblings('label[class="error"]').hide();
                txtDcasVisualExaminationCode.val("AUTO");
                reloadGridDcasVisualExamination();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasVisualExaminationUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-visual-examination-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasVisualExamination();
                updateRowId=$("#dcasVisualExamination_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasVisualExamination=$("#dcasVisualExamination_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-visual-examination-get-data";
                var params="dcasVisualExamination.code=" + dcasVisualExamination.code;

                txtDcasVisualExaminationCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasVisualExaminationCode.val(data.dcasVisualExaminationTemp.code);
                        txtDcasVisualExaminationName.val(data.dcasVisualExaminationTemp.name);
                        rdbDcasVisualExaminationActiveStatus.val(data.dcasVisualExaminationTemp.activeStatus);
                        txtDcasVisualExaminationRemark.val(data.dcasVisualExaminationTemp.remark);
                        txtDcasVisualExaminationInActiveBy.val(data.dcasVisualExaminationTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasVisualExaminationTemp.inActiveDate,true);
                        dtpDcasVisualExaminationInActiveDate.val(inActiveDate);
                        txtDcasVisualExaminationCreatedBy.val(data.dcasVisualExaminationTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasVisualExaminationTemp.createdDate,true);
                        dtpDcasVisualExaminationCreatedDate.val(createdDate);

                        if(data.dcasVisualExaminationTemp.activeStatus===true) {
                           $('#dcasVisualExaminationActiveStatusRadActive').prop('checked',true);
                           $("#dcasVisualExamination\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasVisualExaminationActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasVisualExamination\\.activeStatus").val("false");
                        }

                        showInput("dcasVisualExamination");
                        hideInput("dcasVisualExaminationSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasVisualExaminationDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-visual-examination-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasVisualExamination_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasVisualExamination=$("#dcasVisualExamination_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-visual-examination-delete";
                var params="dcasVisualExamination.code=" + dcasVisualExamination.code;
                var message="Are You Sure To Delete(Code : "+ dcasVisualExamination.code + ")?";
                alertMessageDelete("dcasVisualExamination",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasVisualExamination.code+ ')?</div>');
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
//                                var url="master/dcas-visual-examination-delete";
//                                var params="dcasVisualExamination.code=" + dcasVisualExamination.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasVisualExamination();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasVisualExamination.code+ ")")){
//                    var url="master/dcas-visual-examination-delete";
//                    var params="dcasVisualExamination.code=" + dcasVisualExamination.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasVisualExamination();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasVisualExaminationCancel").click(function(ev) {
            hideInput("dcasVisualExamination");
            showInput("dcasVisualExaminationSearch");
            allFieldsDcasVisualExamination.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasVisualExaminationRefresh').click(function(ev) {
            $('#dcasVisualExaminationSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasVisualExaminationSearchActiveStatus").val("true");
            $("#dcasVisualExamination_grid").jqGrid("clearGridData");
            $("#dcasVisualExamination_grid").jqGrid("setGridParam",{url:"master/dcas-visual-examination-data?"});
            $("#dcasVisualExamination_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasVisualExaminationPrint").click(function(ev) {
            
            var url = "reports/dcas-visual-examination-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasVisualExamination','width=500,height=500');
        });
        
        $('#btnDcasVisualExamination_search').click(function(ev) {
            $("#dcasVisualExamination_grid").jqGrid("clearGridData");
            $("#dcasVisualExamination_grid").jqGrid("setGridParam",{url:"master/dcas-visual-examination-data?" + $("#frmDcasVisualExaminationSearchInput").serialize()});
            $("#dcasVisualExamination_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasVisualExamination(){
//        unHandlersInput(txtDcasVisualExaminationCode);
//        unHandlersInput(txtDcasVisualExaminationName);
//    }
//
//    function handlers_input_dcasVisualExamination(){
//        if(txtDcasVisualExaminationCode.val()===""){
//            handlersInput(txtDcasVisualExaminationCode);
//        }else{
//            unHandlersInput(txtDcasVisualExaminationCode);
//        }
//        if(txtDcasVisualExaminationName.val()===""){
//            handlersInput(txtDcasVisualExaminationName);
//        }else{
//            unHandlersInput(txtDcasVisualExaminationName);
//        }
//    }
    
    function dcasVisualExaminationFormatDate(){
        var inActiveDate=formatDate(dtpDcasVisualExaminationInActiveDate.val(),true);
        dtpDcasVisualExaminationInActiveDate.val(inActiveDate);
        $("#dcasVisualExaminationTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasVisualExaminationCreatedDate.val(),true);
        dtpDcasVisualExaminationCreatedDate.val(createdDate);
        $("#dcasVisualExaminationTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasVisualExamination" action="dcas-visual-examination-data" />
<b>Dcas Visual Examination</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasVisualExaminationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasVisualExaminationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasVisualExaminationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasVisualExaminationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasVisualExaminationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasVisualExaminationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasVisualExaminationSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasVisualExaminationSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasVisualExaminationSearchCode" name="dcasVisualExaminationSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasVisualExaminationSearchName" name="dcasVisualExaminationSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasVisualExaminationSearchActiveStatus" name="dcasVisualExaminationSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasVisualExaminationSearchActiveStatusRad" name="dcasVisualExaminationSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasVisualExamination_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasVisualExaminationGrid">
    <sjg:grid
        id="dcasVisualExamination_grid"
        dataType="json"
        href="%{remoteurlDcasVisualExamination}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasVisualExaminationTemp"
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
    
<div id="dcasVisualExaminationInput" class="content ui-widget">
    <s:form id="frmDcasVisualExaminationInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasVisualExamination.code" name="dcasVisualExamination.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasVisualExamination.name" name="dcasVisualExamination.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasVisualExaminationActiveStatusRad" name="dcasVisualExaminationActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasVisualExamination.activeStatus" name="dcasVisualExamination.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasVisualExamination.remark" name="dcasVisualExamination.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasVisualExamination.inActiveBy"  name="dcasVisualExamination.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasVisualExamination.inActiveDate" name="dcasVisualExamination.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasVisualExamination.createdBy"  name="dcasVisualExamination.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasVisualExamination.createdDate" name="dcasVisualExamination.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasVisualExaminationTemp.inActiveDateTemp" name="dcasVisualExaminationTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasVisualExaminationTemp.createdDateTemp" name="dcasVisualExaminationTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasVisualExaminationSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasVisualExaminationCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>