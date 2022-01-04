
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
     var reasonModuleCoalastRowId = 0, reasonModuleCoa_lastSel = -1;
    var 
        txtReasonCode=$("#reason\\.code"),
        txtReasonName=$("#reason\\.name"),
        rdbReasonActiveStatus=$("#reason\\.activeStatus"),
        txtReasonRemark=$("#reason\\.remark"),
        txtReasonInActiveBy = $("#reason\\.inActiveBy"),
        dtpReasonInActiveDate = $("#reason\\.inActiveDate"),
        txtReasonCreatedBy = $("#reason\\.createdBy"),
        dtpReasonCreatedDate = $("#reason\\.createdDate"),
        
        allFieldsReason=$([])
            .add(txtReasonCode)
            .add(txtReasonName)
            .add(txtReasonRemark)
            .add(txtReasonInActiveBy)
            .add(txtReasonCreatedBy);


            
     function reloadGridReason() {
        //$("#reason_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#reason_grid").trigger("reloadGrid");
         $("#reason_module_coa_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("reason");
        
        $('#reason\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $.subscribe("reason_grid_onSelect", function(event, data){
            var selectedRowID = $("#reason_grid").jqGrid("getGridParam", "selrow"); 
            var reasonHeader = $("#reason_grid").jqGrid("getRowData", selectedRowID);
           
            $("#reason_module_coa_grid").jqGrid("setGridParam",{url:"master/reason-module-coa-reload-grid?reason.code=" + reasonHeader.code});
            $("#reason_module_coa_grid").jqGrid("setCaption", "REASON MODULE DETAIL : " + reasonHeader.code);
            $("#reason_module_coa_grid").trigger("reloadGrid");
            
            jQuery("#reason_module_coa_grid").jqGrid('setGridParam', { gridComplete: function(){ 
//            countReasonDetail(reasonHeader.code); 
            }}); 
        });
        
        $('#reasonSearchActiveStatusRadActive').prop('checked',true);
        $("#reasonSearchActiveStatus").val("true");
        
        $('input[name="reasonSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#reasonSearchActiveStatus").val(value);
        });
        
        $('input[name="reasonSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#reasonSearchActiveStatus").val(value);
        });
                
        $('input[name="reasonSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#reasonSearchActiveStatus").val(value);
        });
        
        $('input[name="reasonActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#reason\\.activeStatus").val(value);
            $("#reason\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="reasonActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#reason\\.activeStatus").val(value);
        });
        
        $("#btnReasonNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/reason-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_reason();
                showInput("reason");
                hideInput("reasonSearch");
                $('#reasonActiveStatusRadActive').prop('checked',true);
                $("#reason\\.activeStatus").val("true");
                $("#reason\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#reason\\.createdDate").val("01/01/1900 00:00:00");
                txtReasonCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtReasonCode.attr("readonly",true);
                txtReasonCode.val("AUTO");
                   loadReason();
                    jQuery("#reasonModuleCoaInput_grid").jqGrid('setGridParam', { gridComplete: function(){ 
//                        countReasonDetailInputNew(); 
                    }}); 
                });
            });
//            ev.preventDefault();
        });
        
         $.subscribe("reasonModuleCoaInput_grid_onSelect", function () {
            var selectedRowID = $("#reasonModuleCoaInput_grid").jqGrid("getGridParam", "selrow");
            if (selectedRowID !== reasonModuleCoa_lastSel) {
                $('#reasonModuleCoaInput_grid').jqGrid("saveRow", reasonModuleCoa_lastSel);
                $('#reasonModuleCoaInput_grid').jqGrid("editRow", selectedRowID, true);
                reasonModuleCoa_lastSel = selectedRowID;
            } else {
                $('#reasonModuleCoaInput_grid').jqGrid("saveRow", selectedRowID);
            }
        });
        $("#btnReasonSave").click(function(ev) {
           if(!$("#frmReasonInput").valid()) {
//               handlers_input_reason();
               ev.preventDefault();
               return;
           };
           if (reasonModuleCoa_lastSel !== -1) {
                $('#reasonModuleCoaInput_grid').jqGrid("saveRow", reasonModuleCoa_lastSel);
            }
           var ids = jQuery("#reasonModuleCoaInput_grid").jqGrid('getDataIDs');
            var arrCheckedData =[];
            for (var j = 0; j < ids.length; j++) {
                var dataCheck = $("#reasonModuleCoaInput_grid").jqGrid('getRowData',ids[j]);
                
                if(dataCheck.reasonModuleCoaAssignAuthority === "True" || dataCheck.reasonModuleCoaAssignAuthority === "true"){
                    arrCheckedData.push(dataCheck.reasonModuleCoaModuleCode); 
                }
            }
            
            if(arrCheckedData.length===0){
                 alert("Minimal set 1 Authority!");
                 return;
            }
           
           var url = "";
           reasonFormatDate();
           if (updateRowId < 0){
               url = "master/reason-save";
           } else{
               url = "master/reason-update";
           }
           
          var params = $("#frmReasonInput").serialize();

            var listReasonModuleCoaTemp = new Array();
            for (var i = 0; i < ids.length; i++) { 
                var data = $("#reasonModuleCoaInput_grid").jqGrid('getRowData', ids[i]);
                var reasonModuleCoa = {
                reasonCode : $("#reason\\.code").val(),
                assignAuthority : data.reasonModuleCoaAssignAuthority,
                reasonModule : {code: data.reasonModuleCoaModuleCode},
                chartOfAccount: {code: data.reasonModuleCoaChartOfAccountCode}
                    
                };
                listReasonModuleCoaTemp[i] = reasonModuleCoa;
            }
            params += "&listReasonModuleCoaJSON=" + $.toJSON(listReasonModuleCoaTemp);
            
           $.post(url, params, function(data) {
                if (data.error) {
                    reasonFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("reason");
                showInput("reasonSearch");
                allFieldsReason.val('').siblings('label[class="error"]').hide();
                txtReasonCode.val("AUTO");
                reloadGridReason();
           });
            $("#reason_grid").jqGrid("clearGridData");
                $("#reason_module_coa_grid").jqGrid("clearGridData");
                $("#reason_grid").jqGrid("setGridParam",{url:"master/reason-data?"});
                $("#reason_grid").trigger("reloadGrid");
           ev.preventDefault();
        });
        
        
        $("#btnReasonUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/reason-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_reason();
                updateRowId=$("#reason_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var reason=$("#reason_grid").jqGrid('getRowData',updateRowId);
                var url="master/reason-get-data";
                var params="reason.code=" + reason.code;

                txtReasonCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtReasonCode.val(data.reasonTemp.code);
                        txtReasonName.val(data.reasonTemp.name);
                        rdbReasonActiveStatus.val(data.reasonTemp.activeStatus);
                        txtReasonRemark.val(data.reasonTemp.remark);
                        txtReasonInActiveBy.val(data.reasonTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.reasonTemp.inActiveDate,true);
                        dtpReasonInActiveDate.val(inActiveDate);
                        txtReasonCreatedBy.val(data.reasonTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.reasonTemp.createdDate,true);
                        dtpReasonCreatedDate.val(createdDate);

                        if(data.reasonTemp.activeStatus===true) {
                           $('#reasonActiveStatusRadActive').prop('checked',true);
                           $("#reason\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#reasonActiveStatusRadInActive').prop('checked',true);              
                           $("#reason\\.activeStatus").val("false");
                        }
                        loadReasonModuleCoa(data.reasonTemp.code);
                        showInput("reason");
                        hideInput("reasonSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnReasonDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/reason-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#reason_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var reason=$("#reason_grid").jqGrid('getRowData',deleteRowID);
                var url="master/reason-delete";
                var params="reason.code=" + reason.code;
                var message="Are You Sure To Delete(Code : "+ reason.code + ")?";
                alertMessageDelete("reason",url,params,message,400);
                $("#reason_grid").jqGrid("clearGridData");
                $("#reason_module_coa_grid").jqGrid("clearGridData");
                $("#reason_grid").jqGrid("setGridParam",{url:"master/reason-data?"});
                $("#reason_grid").trigger("reloadGrid");
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ reason.code+ ')?</div>');
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
//                                var url="master/reason-delete";
//                                var params="reason.code=" + reason.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridReason();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + reason.code+ ")")){
//                    var url="master/reason-delete";
//                    var params="reason.code=" + reason.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridReason();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        
          
        $("#btnReasonCancel").click(function(ev) {
            hideInput("reason");
            showInput("reasonSearch");
            allFieldsReason.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnReasonRefresh').click(function(ev) {
            $('#reasonSearchActiveStatusRadActive').prop('checked',true);
            $("#reasonSearchActiveStatus").val("true");
            $("#reason_grid").jqGrid("clearGridData");
            $("#reason_grid").jqGrid("setGridParam",{url:"master/reason-data?"});
            $("#reason_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnReasonPrint").click(function(ev) {
            
            var url = "reports/reason-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'reason','width=500,height=500');
        });
        
        $('#btnReason_search').click(function(ev) {
            $("#reason_grid").jqGrid("clearGridData");
            $("#reason_grid").jqGrid("setGridParam",{url:"master/reason-data?" + $("#frmReasonSearchInput").serialize()});
            $("#reason_grid").trigger("reloadGrid");
            $("#reason_module_coa_grid").jqGrid("clearGridData");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_reason(){
//        unHandlersInput(txtReasonCode);
//        unHandlersInput(txtReasonName);
//    }
//
//    function handlers_input_reason(){
//        if(txtReasonCode.val()===""){
//            handlersInput(txtReasonCode);
//        }else{
//            unHandlersInput(txtReasonCode);
//        }
//        if(txtReasonName.val()===""){
//            handlersInput(txtReasonName);
//        }else{
//            unHandlersInput(txtReasonName);
//        }
//    }
       function reloadGridReason(){
        $("#reason_grid").trigger("reloadGrid");
    };
    function reasonFormatDate(){
        var inActiveDate=formatDate(dtpReasonInActiveDate.val(),true);
        dtpReasonInActiveDate.val(inActiveDate);
        $("#reasonTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpReasonCreatedDate.val(),true);
        dtpReasonCreatedDate.val(createdDate);
        $("#reasonTemp\\.createdDateTemp").val(createdDate);
    }
//     function countReasonDetail(reasonNo){
//            var url = "inventory/reason-detail-count";
//            var params = "reason.code=" + reasonNo;
//
//            $.post(url, params, function(result) {
//                var data = (result);
//                if (data.count){
//                    if(parseInt(data.count) > 7){
//                        var rowHeight = $("#reason_module_coa_grid"+" tr").eq(1).height();
//                        $("#reason_module_coa_grid").jqGrid('setGridHeight', rowHeight * 17.5 , true);
//                    }else{
//                        $("#reason_module_coa_grid").jqGrid('setGridHeight', "100%", true);
//                    }
//                }
//            });
//        }
    function countReasonDetailInputNew(){
           var rowHeight = $("#reasonModuleCoaInput_grid"+" tr").eq(1).height();
           $("#reasonModuleCoaInput_grid").jqGrid('setGridHeight', rowHeight * 16.5 , true);
    }
    function loadReason() {
            $("#reasonModuleCoaInput_grid").jqGrid('clearGridData');
            var url = "master/reason-module-coa-reload-grid-new";
            showLoading();
            $.post(url,function (data) {
                reasonModuleCoalastRowId = 0;
                for (var i = 0; i < data.listReasonModuleCoaTemp.length; i++) {
                    reasonModuleCoalastRowId++;

                    $("#reasonModuleCoaInput_grid").jqGrid("addRowData", reasonModuleCoalastRowId, data.listReasonModuleCoaTemp[i]);
                    $("#reasonModuleCoaInput_grid").jqGrid('setRowData', reasonModuleCoalastRowId, {
                      
                       reasonModuleCoaSearch                : "..",
                       reasonModuleCoaModuleCode            :data.listReasonModuleCoaTemp[i].authorizationCode,
                       reasonModuleCoaModuleName            :data.listReasonModuleCoaTemp[i].authorizationName,
                       reasonModuleCoaStatus                :data.listReasonModuleCoaTemp[i].coaStatus,
                       reasonModuleCoaChartOfAccountCode    : data.listReasonModuleCoaTemp[i].chartOfAccountCode,
                       reasonModuleCoaChartOfAccountName    : data.listReasonModuleCoaTemp[i].chartOfAccountName,
                       reasonModuleCoaAssignAuthority       : data.listReasonModuleCoaTemp[i].coaStatus
                       
                    });
                }
                
                closeLoading();

            });
        }
        function reasonModuleCoaInputGrid_SearchDocument_OnClick() {
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=reasonModuleCoa&type=grid", "Search", "scrollbars=1, width=600, height=500");
    }
    function loadReasonModuleCoa(code) {
        var count=0;
        $("#reasonModuleCoaInput_grid").jqGrid('clearGridData');
//            var url = "master/reason-module-coa-reload-grid";
        var url = "master/reason-module-coa-reload-grid-update";
        var params = "reason.code=" + code;

        showLoading();
        $.post(url, params, function (data) {
            reasonModuleCoalastRowId = 0;
            for (var i = 0; i < data.listReasonModuleCoaTemp.length; i++) {
                reasonModuleCoalastRowId++;

                $("#reasonModuleCoaInput_grid").jqGrid("addRowData", reasonModuleCoalastRowId, data.listReasonModuleCoaTemp[i]);
                $("#reasonModuleCoaInput_grid").jqGrid('setRowData', reasonModuleCoalastRowId, {

                   reasonModuleCoaSearch                : "...",
                   reasonModuleCoaModuleCode            : data.listReasonModuleCoaTemp[i].authorizationCode,
                   reasonModuleCoaModuleName            : data.listReasonModuleCoaTemp[i].authorizationName,
                   reasonModuleCoaChartOfAccountCode    : data.listReasonModuleCoaTemp[i].chartOfAccountCode,
                   reasonModuleCoaChartOfAccountName    : data.listReasonModuleCoaTemp[i].chartOfAccountName,
                   reasonModuleCoaAssignAuthority       : data.listReasonModuleCoaTemp[i].assignAuthority

                });
                
                count+=1;
            }
                 
            if(parseInt(count) > 15){
                var rowHeight = $("#reasonModuleCoaInput_grid"+" tr").eq(1).height();
                $("#reasonModuleCoaInput_grid").jqGrid('setGridHeight', rowHeight * 16.5 , true);
            }else{
                $("#reasonModuleCoaInput_grid").jqGrid('setGridHeight', "100%", true);
            }

        });
            closeLoading();
            
             
        }
</script>
<s:url id="remoteurlreasonmodulecoainput" action="" />
<s:url id="remoteurlReason" action="reason-data" />
<b>REASON</b>
<hr>
<br class="spacer"/>


<sj:div id="reasonButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnReasonNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnReasonUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnReasonDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnReasonRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnReasonPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="reasonSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmReasonSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="reasonSearchCode" name="reasonSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="reasonSearchName" name="reasonSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="reasonSearchActiveStatus" name="reasonSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="reasonSearchActiveStatusRad" name="reasonSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnReason_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="reasonGrid">
    <sjg:grid
        id="reason_grid"
        dataType="json"
        href="%{remoteurlReason}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listReasonTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="reason_grid_onSelect"
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
    
    <br class="spacer" />
    <br class="spacer" />

        <sjg:grid
            id="reason_module_coa_grid"
            caption="Reason Module Detail"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listReasonModuleCoaTemp"
            viewrecords="true"
            rowNum="10000"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuReasonModuleCoa').width()"
           
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
            /> 
            <sjg:gridColumn
                name="reasonCode" index="reasonCode" key="reasonCode" title="ReasonCode" width="10" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name = "moduleCode" index = "moduleCode" key = "moduleCode" title = "Module Code" width = "300" sortable = "true"
            />
            <sjg:gridColumn
                name = "moduleName" index = "moduleName" key = "moduleName" title = "Module Name" width = "300" sortable = "true"
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "ChartOfAccount Code" width = "200" sortable = "true" 
            />
            <sjg:gridColumn
                name = "chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "ChartOfAccount Name" width = "200" sortable = "true" 
            />

           
        </sjg:grid >
    
</div>
    
<div id="reasonInput" class="content ui-widget">
    <s:form id="frmReasonInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="reason.code" name="reason.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="reason.name" name="reason.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="reasonActiveStatusRad" name="reasonActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="reason.activeStatus" name="reason.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="reason.remark" name="reason.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="reason.inActiveBy"  name="reason.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="reason.inActiveDate" name="reason.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="reason.createdBy"  name="reason.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="reason.createdDate" name="reason.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="reasonTemp.inActiveDateTemp" name="reasonTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="reasonTemp.createdDateTemp" name="reasonTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
           
        </table>
        <table>
                <tr>
                   <td>    
                       <br/>
                       <div id="reasonModuleCoaInputGrid">
                           <sjg:grid
                               id="reasonModuleCoaInput_grid"
                               caption="REASON MODULE COA"
                               dataType="json"                    
                               pager="true"
                               navigator="false"
                               navigatorView="false"
                               navigatorRefresh="false"
                               navigatorDelete="false"
                               navigatorAdd="false"
                               navigatorEdit="false"
                               gridModel="listReasonModuleCoaTemp"
                               rowNum="10000"
                               viewrecords="true"
                               rownumbers="true"
                               shrinkToFit="false"
                               width="$('#tabmnuReasonModuleCoa').width()"
                               editinline="true"
                               editurl="%{remoteurlreasonmodulecoainput}"
                               onSelectRowTopics="reasonModuleCoaInput_grid_onSelect"
                               >
                               <sjg:gridColumn
                                   name="reasonModuleCoa" index="reasonModuleCoa" key="reasonModuleCoa" title="" hidden="true" editable="true" edittype="text"
                               />
                               <sjg:gridColumn
                                   name="reasonModuleCoaModuleCode" index="reasonModuleCoaModuleCode" key="reasonModuleCoaModuleCode" title="Module Code" hidden="false"
                                   width="200" sortable="true" editable="false" edittype="text"
                               />
                                <sjg:gridColumn
                                   name="reasonModuleCoaModuleName" index="reasonModuleCoaModuleName" key="reasonModuleCoaModuleName" title="Module Name" hidden="false"
                                   width="200" sortable="true" editable="false" edittype="text"
                               />
                                <sjg:gridColumn
                                   name="reasonModuleCoaStatus" index="reasonModuleCoaStatus" key="reasonModuleCoaStatus" title="Coa Status" hidden="false"
                                   width="100" sortable="true" editable="false" edittype="text"
                               />
                               <sjg:gridColumn
                                    name = "reasonModuleCoaAssignAuthority" index = "reasonModuleCoaAssignAuthority" key = "reasonModuleCoaAssignAuthority" title = "" width = "50" 
                                    formatter="checkbox" align="center" 
                                    editable="false" edittype="checkbox" editoptions="{value:'True:False'}" formatoptions="{disabled : false}"  
                               />
                               <sjg:gridColumn
                                   name="reasonModuleCoaSearch" index="reasonModuleCoaSearch" title="" width="25" align="centre"
                                   editable="true" 
                                   dataType="html"
                                   edittype="button"
                                   editoptions="{onClick:'reasonModuleCoaInputGrid_SearchDocument_OnClick()', value:'...'}"
                               />
                               <sjg:gridColumn
                                   name="reasonModuleCoaChartOfAccountCode" index="reasonModuleCoaChartOfAccountCode" key="reasonModuleCoaChartOfAccountCode" title="Chart Of Account Code" 
                                   width="200" sortable="true" editable="true" edittype="text"
                                   editoptions="{onChange:'onChangeReasonCoa()'}" 
                               />
                               <sjg:gridColumn
                                    name="reasonModuleCoaChartOfAccountName" index="reasonModuleCoaChartOfAccountName" key="reasonModuleCoaChartOfAccountName" title="Chart Of Account Name" 
                                   width="200" sortable="true" editable="false" edittype="text"
                               />
                           </sjg:grid >
                       </div>
                   </td>
               </tr>
               
           </table>
           <sj:a href="#" id="btnReasonSave" button="true">Save</sj:a>
          <sj:a href="#" id="btnReasonCancel" button="true">Cancel</sj:a>
    </s:form>
</div>