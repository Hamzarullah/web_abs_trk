
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
        txtCadDocumentForApprovalCode=$("#cadDocumentForApproval\\.code"),
        txtCadDocumentForApprovalName=$("#cadDocumentForApproval\\.name"),
        rdbCadDocumentForApprovalActiveStatus=$("#cadDocumentForApproval\\.activeStatus"),
        txtCadDocumentForApprovalRemark=$("#cadDocumentForApproval\\.remark"),
        txtCadDocumentForApprovalInActiveBy = $("#cadDocumentForApproval\\.inActiveBy"),
        dtpCadDocumentForApprovalInActiveDate = $("#cadDocumentForApproval\\.inActiveDate"),
        txtCadDocumentForApprovalCreatedBy = $("#cadDocumentForApproval\\.createdBy"),
        dtpCadDocumentForApprovalCreatedDate = $("#cadDocumentForApproval\\.createdDate"),
        
        allFieldsCadDocumentForApproval=$([])
            .add(txtCadDocumentForApprovalCode)
            .add(txtCadDocumentForApprovalName)
            .add(txtCadDocumentForApprovalRemark)
            .add(txtCadDocumentForApprovalInActiveBy)
            .add(txtCadDocumentForApprovalCreatedBy);


    function reloadGridCadDocumentForApproval(){
        $("#cadDocumentForApproval_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("cadDocumentForApproval");
        
        $('#cadDocumentForApproval\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#cadDocumentForApprovalSearchActiveStatusRadActive').prop('checked',true);
        $("#cadDocumentForApprovalSearchActiveStatus").val("true");
        
        $('input[name="cadDocumentForApprovalSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#cadDocumentForApprovalSearchActiveStatus").val(value);
        });
        
        $('input[name="cadDocumentForApprovalSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#cadDocumentForApprovalSearchActiveStatus").val(value);
        });
                
        $('input[name="cadDocumentForApprovalSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#cadDocumentForApprovalSearchActiveStatus").val(value);
        });
        
        $('input[name="cadDocumentForApprovalActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#cadDocumentForApproval\\.activeStatus").val(value);
            $("#cadDocumentForApproval\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="cadDocumentForApprovalActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#cadDocumentForApproval\\.activeStatus").val(value);
        });
        
        $("#btnCadDocumentForApprovalNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/cad-document-for-approval-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_cadDocumentForApproval();
                showInput("cadDocumentForApproval");
                hideInput("cadDocumentForApprovalSearch");
                $('#cadDocumentForApprovalActiveStatusRadActive').prop('checked',true);
                $("#cadDocumentForApproval\\.activeStatus").val("true");
                $("#cadDocumentForApproval\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#cadDocumentForApproval\\.createdDate").val("01/01/1900 00:00:00");
                txtCadDocumentForApprovalCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtCadDocumentForApprovalCode.attr("readonly",true);
                txtCadDocumentForApprovalCode.val("AUTO");
                reloadGridCadDocumentForApproval();
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCadDocumentForApprovalSave").click(function(ev) {
           if(!$("#frmCadDocumentForApprovalInput").valid()) {
//               handlers_input_cadDocumentForApproval();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           cadDocumentForApprovalFormatDate();
           if (updateRowId < 0){
               url = "master/cad-document-for-approval-save";
           } else{
               url = "master/cad-document-for-approval-update";
           }
           
           var params = $("#frmCadDocumentForApprovalInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    cadDocumentForApprovalFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);

                hideInput("cadDocumentForApproval");
                showInput("cadDocumentForApprovalSearch");
                allFieldsCadDocumentForApproval.val('').siblings('label[class="error"]').hide();
                reloadGridCadDocumentForApproval();
                
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCadDocumentForApprovalUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/cad-document-for-approval-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_cadDocumentForApproval();
                updateRowId=$("#cadDocumentForApproval_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var cadDocumentForApproval=$("#cadDocumentForApproval_grid").jqGrid('getRowData',updateRowId);
                var url="master/cad-document-for-approval-get-data";
                var params="cadDocumentForApproval.code=" + cadDocumentForApproval.code;

                txtCadDocumentForApprovalCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCadDocumentForApprovalCode.val(data.cadDocumentForApprovalTemp.code);
                        txtCadDocumentForApprovalName.val(data.cadDocumentForApprovalTemp.name);
                        rdbCadDocumentForApprovalActiveStatus.val(data.cadDocumentForApprovalTemp.activeStatus);
                        txtCadDocumentForApprovalRemark.val(data.cadDocumentForApprovalTemp.remark);
                        txtCadDocumentForApprovalInActiveBy.val(data.cadDocumentForApprovalTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.cadDocumentForApprovalTemp.inActiveDate,true);
                        dtpCadDocumentForApprovalInActiveDate.val(inActiveDate);
                        txtCadDocumentForApprovalCreatedBy.val(data.cadDocumentForApprovalTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.cadDocumentForApprovalTemp.createdDate,true);
                        dtpCadDocumentForApprovalCreatedDate.val(createdDate);

                        if(data.cadDocumentForApprovalTemp.activeStatus===true) {
                           $('#cadDocumentForApprovalActiveStatusRadActive').prop('checked',true);
                           $("#cadDocumentForApproval\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#cadDocumentForApprovalActiveStatusRadInActive').prop('checked',true);              
                           $("#cadDocumentForApproval\\.activeStatus").val("false");
                        }

                        showInput("cadDocumentForApproval");
                        hideInput("cadDocumentForApprovalSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCadDocumentForApprovalDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/cad-document-for-approval-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#cadDocumentForApproval_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var cadDocumentForApproval=$("#cadDocumentForApproval_grid").jqGrid('getRowData',deleteRowID);
                var url="master/cad-document-for-approval-delete";
                var params="cadDocumentForApproval.code=" + cadDocumentForApproval.code;
                var message="Are You Sure To Delete(Code : "+ cadDocumentForApproval.code + ")?";
                alertMessageDelete("cadDocumentForApproval",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ cadDocumentForApproval.code+ ')?</div>');
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
//                                var url="master/cadDocumentForApproval-delete";
//                                var params="cadDocumentForApproval.code=" + cadDocumentForApproval.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridCadDocumentForApproval();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + cadDocumentForApproval.code+ ")")){
//                    var url="master/cadDocumentForApproval-delete";
//                    var params="cadDocumentForApproval.code=" + cadDocumentForApproval.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridCadDocumentForApproval();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnCadDocumentForApprovalCancel").click(function(ev) {
            hideInput("cadDocumentForApproval");
            showInput("cadDocumentForApprovalSearch");
            allFieldsCadDocumentForApproval.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCadDocumentForApprovalRefresh').click(function(ev) {
            $('#cadDocumentForApprovalSearchActiveStatusRadActive').prop('checked',true);
            $("#cadDocumentForApprovalSearchActiveStatus").val("true");
            $("#cadDocumentForApproval_grid").jqGrid("clearGridData");
            $("#cadDocumentForApproval_grid").jqGrid("setGridParam",{url:"master/cad-document-for-approval-data?"});
            $("#cadDocumentForApproval_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCadDocumentForApprovalPrint").click(function(ev) {
            
            var url = "reports/cad-document-for-approval-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'cadDocumentForApproval','width=500,height=500');
        });
        
        $('#btnCadDocumentForApproval_search').click(function(ev) {
            $("#cadDocumentForApproval_grid").jqGrid("clearGridData");
            $("#cadDocumentForApproval_grid").jqGrid("setGridParam",{url:"master/cad-document-for-approval-data?" + $("#frmCadDocumentForApprovalSearchInput").serialize()});
            $("#cadDocumentForApproval_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_cadDocumentForApproval(){
//        unHandlersInput(txtCadDocumentForApprovalCode);
//        unHandlersInput(txtCadDocumentForApprovalName);
//    }
//
//    function handlers_input_cadDocumentForApproval(){
//        if(txtCadDocumentForApprovalCode.val()===""){
//            handlersInput(txtCadDocumentForApprovalCode);
//        }else{
//            unHandlersInput(txtCadDocumentForApprovalCode);
//        }
//        if(txtCadDocumentForApprovalName.val()===""){
//            handlersInput(txtCadDocumentForApprovalName);
//        }else{
//            unHandlersInput(txtCadDocumentForApprovalName);
//        }
//    }
    
    function cadDocumentForApprovalFormatDate(){
        var inActiveDate=formatDate(dtpCadDocumentForApprovalInActiveDate.val(),true);
        dtpCadDocumentForApprovalInActiveDate.val(inActiveDate);
        $("#cadDocumentForApprovalTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCadDocumentForApprovalCreatedDate.val(),true);
        dtpCadDocumentForApprovalCreatedDate.val(createdDate);
        $("#cadDocumentForApprovalTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlCadDocumentForApproval" action="cad-document-for-approval-data" />
<b>Cad Document For Approval</b>
<hr>
<br class="spacer"/>


<sj:div id="cadDocumentForApprovalButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCadDocumentForApprovalNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCadDocumentForApprovalUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCadDocumentForApprovalDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCadDocumentForApprovalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCadDocumentForApprovalPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="cadDocumentForApprovalSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCadDocumentForApprovalSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="cadDocumentForApprovalSearchCode" name="cadDocumentForApprovalSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="cadDocumentForApprovalSearchName" name="cadDocumentForApprovalSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="cadDocumentForApprovalSearchActiveStatus" name="cadDocumentForApprovalSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="cadDocumentForApprovalSearchActiveStatusRad" name="cadDocumentForApprovalSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCadDocumentForApproval_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="cadDocumentForApprovalGrid">
    <sjg:grid
        id="cadDocumentForApproval_grid"
        dataType="json"
        href="%{remoteurlCadDocumentForApproval}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCadDocumentForApprovalTemp"
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
    
<div id="cadDocumentForApprovalInput" class="content ui-widget">
    <s:form id="frmCadDocumentForApprovalInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="cadDocumentForApproval.code" name="cadDocumentForApproval.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="cadDocumentForApproval.name" name="cadDocumentForApproval.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="cadDocumentForApprovalActiveStatusRad" name="cadDocumentForApprovalActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="cadDocumentForApproval.activeStatus" name="cadDocumentForApproval.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="cadDocumentForApproval.remark" name="cadDocumentForApproval.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="cadDocumentForApproval.inActiveBy"  name="cadDocumentForApproval.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="cadDocumentForApproval.inActiveDate" name="cadDocumentForApproval.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="cadDocumentForApproval.createdBy"  name="cadDocumentForApproval.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="cadDocumentForApproval.createdDate" name="cadDocumentForApproval.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="cadDocumentForApprovalTemp.inActiveDateTemp" name="cadDocumentForApprovalTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="cadDocumentForApprovalTemp.createdDateTemp" name="cadDocumentForApprovalTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnCadDocumentForApprovalSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCadDocumentForApprovalCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>