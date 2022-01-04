
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
        txtDcasNdeCode=$("#dcasNde\\.code"),
        txtDcasNdeName=$("#dcasNde\\.name"),
        rdbDcasNdeActiveStatus=$("#dcasNde\\.activeStatus"),
        txtDcasNdeRemark=$("#dcasNde\\.remark"),
        txtDcasNdeInActiveBy = $("#dcasNde\\.inActiveBy"),
        dtpDcasNdeInActiveDate = $("#dcasNde\\.inActiveDate"),
        txtDcasNdeCreatedBy = $("#dcasNde\\.createdBy"),
        dtpDcasNdeCreatedDate = $("#dcasNde\\.createdDate"),
        
        allFieldsDcasNde=$([])
            .add(txtDcasNdeCode)
            .add(txtDcasNdeName)
            .add(txtDcasNdeRemark)
            .add(txtDcasNdeInActiveBy)
            .add(txtDcasNdeCreatedBy);


    function reloadGridDcasNde(){
        $("#dcasNde_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasNde");
        
        $('#dcasNde\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasNdeSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasNdeSearchActiveStatus").val("true");
        
        $('input[name="dcasNdeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasNdeSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasNdeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasNdeSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasNdeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasNdeSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasNdeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasNde\\.activeStatus").val(value);
            $("#dcasNde\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasNdeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasNde\\.activeStatus").val(value);
        });
        
        $("#btnDcasNdeNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-nde-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasNde();
                showInput("dcasNde");
                hideInput("dcasNdeSearch");
                $('#dcasNdeActiveStatusRadActive').prop('checked',true);
                $("#dcasNde\\.activeStatus").val("true");
                $("#dcasNde\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasNde\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasNdeCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasNdeCode.attr("readonly",true);
                txtDcasNdeCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasNdeSave").click(function(ev) {
           if(!$("#frmDcasNdeInput").valid()) {
//               handlers_input_dcasNde();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasNdeFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-nde-save";
           } else{
               url = "master/dcas-nde-update";
           }
           
           var params = $("#frmDcasNdeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasNdeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasNde");
                showInput("dcasNdeSearch");
                allFieldsDcasNde.val('').siblings('label[class="error"]').hide();
                txtDcasNdeCode.val("AUTO");
                reloadGridDcasNde();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasNdeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-nde-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasNde();
                updateRowId=$("#dcasNde_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasNde=$("#dcasNde_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-nde-get-data";
                var params="dcasNde.code=" + dcasNde.code;

                txtDcasNdeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasNdeCode.val(data.dcasNdeTemp.code);
                        txtDcasNdeName.val(data.dcasNdeTemp.name);
                        rdbDcasNdeActiveStatus.val(data.dcasNdeTemp.activeStatus);
                        txtDcasNdeRemark.val(data.dcasNdeTemp.remark);
                        txtDcasNdeInActiveBy.val(data.dcasNdeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasNdeTemp.inActiveDate,true);
                        dtpDcasNdeInActiveDate.val(inActiveDate);
                        txtDcasNdeCreatedBy.val(data.dcasNdeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasNdeTemp.createdDate,true);
                        dtpDcasNdeCreatedDate.val(createdDate);

                        if(data.dcasNdeTemp.activeStatus===true) {
                           $('#dcasNdeActiveStatusRadActive').prop('checked',true);
                           $("#dcasNde\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasNdeActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasNde\\.activeStatus").val("false");
                        }

                        showInput("dcasNde");
                        hideInput("dcasNdeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasNdeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-nde-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasNde_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasNde=$("#dcasNde_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-nde-delete";
                var params="dcasNde.code=" + dcasNde.code;
                var message="Are You Sure To Delete(Code : "+ dcasNde.code + ")?";
                alertMessageDelete("dcasNde",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasNde.code+ ')?</div>');
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
//                                var url="master/dcas-nde-delete";
//                                var params="dcasNde.code=" + dcasNde.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasNde();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasNde.code+ ")")){
//                    var url="master/dcas-nde-delete";
//                    var params="dcasNde.code=" + dcasNde.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasNde();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasNdeCancel").click(function(ev) {
            hideInput("dcasNde");
            showInput("dcasNdeSearch");
            allFieldsDcasNde.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasNdeRefresh').click(function(ev) {
            $('#dcasNdeSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasNdeSearchActiveStatus").val("true");
            $("#dcasNde_grid").jqGrid("clearGridData");
            $("#dcasNde_grid").jqGrid("setGridParam",{url:"master/dcas-nde-data?"});
            $("#dcasNde_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasNdePrint").click(function(ev) {
            
            var url = "reports/dcas-nde-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasNde','width=500,height=500');
        });
        
        $('#btnDcasNde_search').click(function(ev) {
            $("#dcasNde_grid").jqGrid("clearGridData");
            $("#dcasNde_grid").jqGrid("setGridParam",{url:"master/dcas-nde-data?" + $("#frmDcasNdeSearchInput").serialize()});
            $("#dcasNde_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasNde(){
//        unHandlersInput(txtDcasNdeCode);
//        unHandlersInput(txtDcasNdeName);
//    }
//
//    function handlers_input_dcasNde(){
//        if(txtDcasNdeCode.val()===""){
//            handlersInput(txtDcasNdeCode);
//        }else{
//            unHandlersInput(txtDcasNdeCode);
//        }
//        if(txtDcasNdeName.val()===""){
//            handlersInput(txtDcasNdeName);
//        }else{
//            unHandlersInput(txtDcasNdeName);
//        }
//    }
    
    function dcasNdeFormatDate(){
        var inActiveDate=formatDate(dtpDcasNdeInActiveDate.val(),true);
        dtpDcasNdeInActiveDate.val(inActiveDate);
        $("#dcasNdeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasNdeCreatedDate.val(),true);
        dtpDcasNdeCreatedDate.val(createdDate);
        $("#dcasNdeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasNde" action="dcas-nde-data" />
<b>Dcas Nde</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasNdeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasNdeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasNdeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasNdeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasNdeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasNdePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasNdeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasNdeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasNdeSearchCode" name="dcasNdeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasNdeSearchName" name="dcasNdeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasNdeSearchActiveStatus" name="dcasNdeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasNdeSearchActiveStatusRad" name="dcasNdeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasNde_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasNdeGrid">
    <sjg:grid
        id="dcasNde_grid"
        dataType="json"
        href="%{remoteurlDcasNde}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasNdeTemp"
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
    
<div id="dcasNdeInput" class="content ui-widget">
    <s:form id="frmDcasNdeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasNde.code" name="dcasNde.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasNde.name" name="dcasNde.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasNdeActiveStatusRad" name="dcasNdeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasNde.activeStatus" name="dcasNde.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasNde.remark" name="dcasNde.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasNde.inActiveBy"  name="dcasNde.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasNde.inActiveDate" name="dcasNde.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasNde.createdBy"  name="dcasNde.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasNde.createdDate" name="dcasNde.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasNdeTemp.inActiveDateTemp" name="dcasNdeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasNdeTemp.createdDateTemp" name="dcasNdeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasNdeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasNdeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>