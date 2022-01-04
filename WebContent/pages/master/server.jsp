
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
        txtServerCode=$("#server\\.code"),
        txtServerName=$("#server\\.name"),
        txtServerComputerName=$("#server\\.computerName"),
        txtServerIPAddress=$("#server\\.ipAddress"),
        txtServerBrand=$("#server\\.brand"),
        txtServerType=$("#server\\.type"),
        txtServerRAMCapacity=$("#server\\.ramCapacity"),
        txtServerRAMUOM=$("#server\\.ramUOM"),
        txtServerHardDriveCapacity=$("#server\\.hardDriveCapacity"),
        txtServerHardDriveUOM=$("#server\\.hardDriveUOM"),
        txtServerProcessor=$("#server\\.processor"),
        txtServerAcquisitionMonth=$("#server\\.acquisitionMonth"),
        txtServerAcquisitionYear=$("#server\\.acquisitionYear"),
        rdbServerActiveStatus=$("#server\\.activeStatus"),
        txtServerRemark=$("#server\\.remark"),
        txtServerInActiveBy = $("#server\\.inActiveBy"),
        dtpServerInActiveDate = $("#server\\.inActiveDate"),
        txtServerCreatedBy = $("#server\\.createdBy"),
        dtpServerCreatedDate = $("#server\\.createdDate"),
        
        allFieldsServer=$([])
            .add(txtServerCode)
            .add(txtServerName)
            .add(txtServerComputerName)
            .add(txtServerIPAddress)
            .add(txtServerBrand)
            .add(txtServerType)
            .add(txtServerRAMCapacity)
            .add(txtServerRAMUOM)
            .add(txtServerHardDriveCapacity)
            .add(txtServerHardDriveUOM)
            .add(txtServerProcessor)
            .add(txtServerAcquisitionMonth)
            .add(txtServerAcquisitionYear)
            .add(txtServerRemark)
            .add(txtServerInActiveBy)
            .add(txtServerCreatedBy);


    function reloadGridServer(){
        $("#server_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("server");
        
        $('#server\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#serverSearchActiveStatusRadActive').prop('checked',true);
        $("#serverSearchActiveStatus").val("true");
        
        $('input[name="serverSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#serverSearchActiveStatus").val(value);
        });
        
        $('input[name="serverSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#serverSearchActiveStatus").val(value);
        });
                
        $('input[name="serverSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#serverSearchActiveStatus").val(value);
        });
        
        $('input[name="serverActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#server\\.activeStatus").val(value);
            $("#server\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="serverActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#server\\.activeStatus").val(value);
        });
        
        $("#btnServerNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/server-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_server();
                showInput("server");
                hideInput("serverSearch");
                $('#serverActiveStatusRadActive').prop('checked',true);
                $("#server\\.activeStatus").val("true");
                $("#server\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#server\\.createdDate").val("01/01/1900 00:00:00");
                txtServerCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtServerCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnServerSave").click(function(ev) {
           if(!$("#frmServerInput").valid()) {
//               handlers_input_server();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           serverFormatDate();
           if (updateRowId < 0){
               url = "master/server-save";
           } else{
               url = "master/server-update";
           }
           
           var params = $("#frmServerInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    serverFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("server");
                showInput("serverSearch");
                allFieldsServer.val('').siblings('label[class="error"]').hide();
                reloadGridServer();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnServerUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/server-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_server();
                updateRowId=$("#server_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var server=$("#server_grid").jqGrid('getRowData',updateRowId);
                var url="master/server-get-data";
                var params="server.code=" + server.code;

                txtServerCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtServerCode.val(data.serverTemp.code);
                        txtServerName.val(data.serverTemp.name);
                        txtServerComputerName.val(data.serverTemp.computerName);
                        txtServerIPAddress.val(data.serverTemp.ipAddress);
                        txtServerBrand.val(data.serverTemp.brand);
                        txtServerType.val(data.serverTemp.type);
                        txtServerRAMCapacity.val(data.serverTemp.ramCapacity);
                        txtServerRAMUOM.val(data.serverTemp.ramUOM);
                        txtServerHardDriveCapacity.val(data.serverTemp.hardDriveCapacity);
                        txtServerHardDriveUOM.val(data.serverTemp.hardDriveUOM);
                        txtServerProcessor.val(data.serverTemp.processor);
                        txtServerAcquisitionMonth.val(data.serverTemp.acquisitionMonth);
                        txtServerAcquisitionYear.val(data.serverTemp.acquisitionYear);
                        rdbServerActiveStatus.val(data.serverTemp.activeStatus);
                        txtServerRemark.val(data.serverTemp.remark);
                        txtServerInActiveBy.val(data.serverTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.serverTemp.inActiveDate,true);
                        dtpServerInActiveDate.val(inActiveDate);
                        txtServerCreatedBy.val(data.serverTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.serverTemp.createdDate,true);
                        dtpServerCreatedDate.val(createdDate);

                        if(data.serverTemp.activeStatus===true) {
                           $('#serverActiveStatusRadActive').prop('checked',true);
                           $("#server\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#serverActiveStatusRadInActive').prop('checked',true);              
                           $("#server\\.activeStatus").val("false");
                        }

                        showInput("server");
                        hideInput("serverSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnServerDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/server-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#server_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var server=$("#server_grid").jqGrid('getRowData',deleteRowID);
                var url="master/server-delete";
                var params="server.code=" + server.code;
                var message="Are You Sure To Delete(Code : "+ server.code + ")?";
                alertMessageDelete("server",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ server.code+ ')?</div>');
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
//                                var url="master/server-delete";
//                                var params="server.code=" + server.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridServer();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + server.code+ ")")){
//                    var url="master/server-delete";
//                    var params="server.code=" + server.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridServer();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnServerCancel").click(function(ev) {
            hideInput("server");
            showInput("serverSearch");
            allFieldsServer.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnServerRefresh').click(function(ev) {
            $('#serverSearchActiveStatusRadActive').prop('checked',true);
            $("#serverSearchActiveStatus").val("true");
            $("#server_grid").jqGrid("clearGridData");
            $("#server_grid").jqGrid("setGridParam",{url:"master/server-data?"});
            $("#server_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnServerPrint").click(function(ev) {
            
            var url = "reports/server-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'server','width=500,height=500');
        });
        
        $('#btnServer_search').click(function(ev) {
            $("#server_grid").jqGrid("clearGridData");
            $("#server_grid").jqGrid("setGridParam",{url:"master/server-data?" + $("#frmServerSearchInput").serialize()});
            $("#server_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_server(){
//        unHandlersInput(txtServerCode);
//        unHandlersInput(txtServerName);
//    }
//
//    function handlers_input_server(){
//        if(txtServerCode.val()===""){
//            handlersInput(txtServerCode);
//        }else{
//            unHandlersInput(txtServerCode);
//        }
//        if(txtServerName.val()===""){
//            handlersInput(txtServerName);
//        }else{
//            unHandlersInput(txtServerName);
//        }
//    }
    
    function serverFormatDate(){
        var inActiveDate=formatDate(dtpServerInActiveDate.val(),true);
        dtpServerInActiveDate.val(inActiveDate);
        $("#serverTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpServerCreatedDate.val(),true);
        dtpServerCreatedDate.val(createdDate);
        $("#serverTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlServer" action="server-data" />
<b>Server</b>
<hr>
<br class="spacer"/>


<sj:div id="serverButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnServerNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnServerUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnServerDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnServerRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnServerPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="serverSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmServerSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="serverSearchCode" name="serverSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="serverSearchName" name="serverSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="serverSearchActiveStatus" name="serverSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="serverSearchActiveStatusRad" name="serverSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnServer_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="serverGrid">
    <sjg:grid
        id="server_grid"
        dataType="json"
        href="%{remoteurlServer}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listServerTemp"
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
            name="computerName" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="ipAddress" index="ipAddress" title="IP Address" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="brand" index="brand" title="Brand" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="type" index="brand" title="Brand" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="ramCapacity" index="ramCapacity" title="RAM Capacity" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="ramUOM" index="ramUOM" title="RAM UOM" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="hardDriveCapacity" index="hardDriveCapacity" title="Hard Drive Capacity" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="hardDriveUOM" index="hardDriveUOM" title="Hard Drive UOM" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="processor" index="processor" title="Processor" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="acquisitionMonth" index="acquisitionMonth" title="Acquisition Month" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="acquisitionYear" index="acquisitionYear" title="Acquisition Year" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="serverInput" class="content ui-widget">
    <s:form id="frmServerInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="server.code" name="server.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="server.name" name="server.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Computer Name *</b></td>
                <td><s:textfield id="server.computerName" name="server.computerName" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>IP Address *</b></td>
                <td><s:textfield id="server.ipAddress" name="server.ipAddress" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Brand *</b></td>
                <td><s:textfield id="server.brand" name="server.brand" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Type *</b></td>
                <td><s:textfield id="server.type" name="server.type" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>RAM Capacity *</b></td>
                <td><s:textfield id="server.ramCapacity" name="server.ramCapacity" size="20" title="*" required="true" cssClass="required" maxLength="95" cssStyle="text-align:right"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>RAM UOM *</b></td>
                <td><s:textfield id="server.ramUOM" name="server.ramUOM" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Hard Drive Capacity *</b></td>
                <td><s:textfield id="server.hardDriveCapacity" name="server.hardDriveCapacity" size="20" title="*" required="true" cssClass="required" maxLength="95" cssStyle="text-align:right"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Hard Drive UOM *</b></td>
                <td><s:textfield id="server.ramUOM" name="server.ramUOM" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Processor *</b></td>
                <td><s:textfield id="server.processor" name="server.processor" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                    <td align="right"><b>Acquisition Month *</b></td>
                <td><s:textfield id="server.acquisitionMonth" name="server.acquisitionMonth" size="20" title="*" required="true" cssClass="required" maxLength="95" cssStyle="text-align:right"></s:textfield></td>
            </tr>
            <tr>
                    <td align="right"><b>Acquisition Year *</b></td>
                <td><s:textfield id="server.acquisitionYear" name="server.acquisitionYear" size="20" title="*" required="true" cssClass="required" maxLength="95" cssStyle="text-align:right"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="serverActiveStatusRad" name="serverActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="server.activeStatus" name="server.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="server.remark" name="server.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="server.inActiveBy"  name="server.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="server.inActiveDate" name="server.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="server.createdBy"  name="server.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="server.createdDate" name="server.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="serverTemp.inActiveDateTemp" name="serverTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="serverTemp.createdDateTemp" name="serverTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnServerSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnServerCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>