
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
        txtDcasLegalRequirementsCode=$("#dcasLegalRequirements\\.code"),
        txtDcasLegalRequirementsName=$("#dcasLegalRequirements\\.name"),
        rdbDcasLegalRequirementsActiveStatus=$("#dcasLegalRequirements\\.activeStatus"),
        txtDcasLegalRequirementsRemark=$("#dcasLegalRequirements\\.remark"),
        txtDcasLegalRequirementsInActiveBy = $("#dcasLegalRequirements\\.inActiveBy"),
        dtpDcasLegalRequirementsInActiveDate = $("#dcasLegalRequirements\\.inActiveDate"),
        txtDcasLegalRequirementsCreatedBy = $("#dcasLegalRequirements\\.createdBy"),
        dtpDcasLegalRequirementsCreatedDate = $("#dcasLegalRequirements\\.createdDate"),
        
        allFieldsDcasLegalRequirements=$([])
            .add(txtDcasLegalRequirementsCode)
            .add(txtDcasLegalRequirementsName)
            .add(txtDcasLegalRequirementsRemark)
            .add(txtDcasLegalRequirementsInActiveBy)
            .add(txtDcasLegalRequirementsCreatedBy);


    function reloadGridDcasLegalRequirements(){
        $("#dcasLegalRequirements_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasLegalRequirements");
        
        $('#dcasLegalRequirements\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasLegalRequirementsSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasLegalRequirementsSearchActiveStatus").val("true");
        
        $('input[name="dcasLegalRequirementsSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasLegalRequirementsSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasLegalRequirementsSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasLegalRequirementsSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasLegalRequirementsSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasLegalRequirementsSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasLegalRequirementsActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasLegalRequirements\\.activeStatus").val(value);
            $("#dcasLegalRequirements\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasLegalRequirementsActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasLegalRequirements\\.activeStatus").val(value);
        });
        
        $("#btnDcasLegalRequirementsNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-legal-requirements-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasLegalRequirements();
                showInput("dcasLegalRequirements");
                hideInput("dcasLegalRequirementsSearch");
                $('#dcasLegalRequirementsActiveStatusRadActive').prop('checked',true);
                $("#dcasLegalRequirements\\.activeStatus").val("true");
                $("#dcasLegalRequirements\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasLegalRequirements\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasLegalRequirementsCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasLegalRequirementsCode.attr("readonly",true);
                txtDcasLegalRequirementsCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasLegalRequirementsSave").click(function(ev) {
           if(!$("#frmDcasLegalRequirementsInput").valid()) {
//               handlers_input_dcasLegalRequirements();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasLegalRequirementsFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-legal-requirements-save";
           } else{
               url = "master/dcas-legal-requirements-update";
           }
           
           var params = $("#frmDcasLegalRequirementsInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasLegalRequirementsFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasLegalRequirements");
                showInput("dcasLegalRequirementsSearch");
                allFieldsDcasLegalRequirements.val('').siblings('label[class="error"]').hide();
                txtDcasLegalRequirementsCode.val("AUTO");
                reloadGridDcasLegalRequirements();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasLegalRequirementsUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-legal-requirements-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasLegalRequirements();
                updateRowId=$("#dcasLegalRequirements_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasLegalRequirements=$("#dcasLegalRequirements_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-legal-requirements-get-data";
                var params="dcasLegalRequirements.code=" + dcasLegalRequirements.code;

                txtDcasLegalRequirementsCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasLegalRequirementsCode.val(data.dcasLegalRequirementsTemp.code);
                        txtDcasLegalRequirementsName.val(data.dcasLegalRequirementsTemp.name);
                        rdbDcasLegalRequirementsActiveStatus.val(data.dcasLegalRequirementsTemp.activeStatus);
                        txtDcasLegalRequirementsRemark.val(data.dcasLegalRequirementsTemp.remark);
                        txtDcasLegalRequirementsInActiveBy.val(data.dcasLegalRequirementsTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasLegalRequirementsTemp.inActiveDate,true);
                        dtpDcasLegalRequirementsInActiveDate.val(inActiveDate);
                        txtDcasLegalRequirementsCreatedBy.val(data.dcasLegalRequirementsTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasLegalRequirementsTemp.createdDate,true);
                        dtpDcasLegalRequirementsCreatedDate.val(createdDate);

                        if(data.dcasLegalRequirementsTemp.activeStatus===true) {
                           $('#dcasLegalRequirementsActiveStatusRadActive').prop('checked',true);
                           $("#dcasLegalRequirements\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasLegalRequirementsActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasLegalRequirements\\.activeStatus").val("false");
                        }

                        showInput("dcasLegalRequirements");
                        hideInput("dcasLegalRequirementsSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasLegalRequirementsDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-legal-requirements-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasLegalRequirements_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasLegalRequirements=$("#dcasLegalRequirements_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-legal-requirements-delete";
                var params="dcasLegalRequirements.code=" + dcasLegalRequirements.code;
                var message="Are You Sure To Delete(Code : "+ dcasLegalRequirements.code + ")?";
                alertMessageDelete("dcasLegalRequirements",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasLegalRequirements.code+ ')?</div>');
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
//                                var url="master/dcas-legal-requirements-delete";
//                                var params="dcasLegalRequirements.code=" + dcasLegalRequirements.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasLegalRequirements();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasLegalRequirements.code+ ")")){
//                    var url="master/dcas-legal-requirements-delete";
//                    var params="dcasLegalRequirements.code=" + dcasLegalRequirements.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasLegalRequirements();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasLegalRequirementsCancel").click(function(ev) {
            hideInput("dcasLegalRequirements");
            showInput("dcasLegalRequirementsSearch");
            allFieldsDcasLegalRequirements.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasLegalRequirementsRefresh').click(function(ev) {
            $('#dcasLegalRequirementsSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasLegalRequirementsSearchActiveStatus").val("true");
            $("#dcasLegalRequirements_grid").jqGrid("clearGridData");
            $("#dcasLegalRequirements_grid").jqGrid("setGridParam",{url:"master/dcas-legal-requirements-data?"});
            $("#dcasLegalRequirements_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasLegalRequirementsPrint").click(function(ev) {
            
            var url = "reports/dcas-legal-requirements-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasLegalRequirements','width=500,height=500');
        });
        
        $('#btnDcasLegalRequirements_search').click(function(ev) {
            $("#dcasLegalRequirements_grid").jqGrid("clearGridData");
            $("#dcasLegalRequirements_grid").jqGrid("setGridParam",{url:"master/dcas-legal-requirements-data?" + $("#frmDcasLegalRequirementsSearchInput").serialize()});
            $("#dcasLegalRequirements_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasLegalRequirements(){
//        unHandlersInput(txtDcasLegalRequirementsCode);
//        unHandlersInput(txtDcasLegalRequirementsName);
//    }
//
//    function handlers_input_dcasLegalRequirements(){
//        if(txtDcasLegalRequirementsCode.val()===""){
//            handlersInput(txtDcasLegalRequirementsCode);
//        }else{
//            unHandlersInput(txtDcasLegalRequirementsCode);
//        }
//        if(txtDcasLegalRequirementsName.val()===""){
//            handlersInput(txtDcasLegalRequirementsName);
//        }else{
//            unHandlersInput(txtDcasLegalRequirementsName);
//        }
//    }
    
    function dcasLegalRequirementsFormatDate(){
        var inActiveDate=formatDate(dtpDcasLegalRequirementsInActiveDate.val(),true);
        dtpDcasLegalRequirementsInActiveDate.val(inActiveDate);
        $("#dcasLegalRequirementsTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasLegalRequirementsCreatedDate.val(),true);
        dtpDcasLegalRequirementsCreatedDate.val(createdDate);
        $("#dcasLegalRequirementsTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasLegalRequirements" action="dcas-legal-requirements-data" />
<b>Dcas Legal Requirements</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasLegalRequirementsButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasLegalRequirementsNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasLegalRequirementsUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasLegalRequirementsDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasLegalRequirementsRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasLegalRequirementsPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasLegalRequirementsSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasLegalRequirementsSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasLegalRequirementsSearchCode" name="dcasLegalRequirementsSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasLegalRequirementsSearchName" name="dcasLegalRequirementsSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasLegalRequirementsSearchActiveStatus" name="dcasLegalRequirementsSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasLegalRequirementsSearchActiveStatusRad" name="dcasLegalRequirementsSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasLegalRequirements_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasLegalRequirementsGrid">
    <sjg:grid
        id="dcasLegalRequirements_grid"
        dataType="json"
        href="%{remoteurlDcasLegalRequirements}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasLegalRequirementsTemp"
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
    
<div id="dcasLegalRequirementsInput" class="content ui-widget">
    <s:form id="frmDcasLegalRequirementsInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasLegalRequirements.code" name="dcasLegalRequirements.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasLegalRequirements.name" name="dcasLegalRequirements.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasLegalRequirementsActiveStatusRad" name="dcasLegalRequirementsActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasLegalRequirements.activeStatus" name="dcasLegalRequirements.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasLegalRequirements.remark" name="dcasLegalRequirements.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasLegalRequirements.inActiveBy"  name="dcasLegalRequirements.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasLegalRequirements.inActiveDate" name="dcasLegalRequirements.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasLegalRequirements.createdBy"  name="dcasLegalRequirements.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasLegalRequirements.createdDate" name="dcasLegalRequirements.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasLegalRequirementsTemp.inActiveDateTemp" name="dcasLegalRequirementsTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasLegalRequirementsTemp.createdDateTemp" name="dcasLegalRequirementsTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasLegalRequirementsSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasLegalRequirementsCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>