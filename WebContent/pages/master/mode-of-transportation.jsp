
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
        txtModeOfTransportationCode=$("#modeOfTransportation\\.code"),
        txtModeOfTransportationName=$("#modeOfTransportation\\.name"),
        rdbModeOfTransportationActiveStatus=$("#modeOfTransportation\\.activeStatus"),
        txtModeOfTransportationRemark=$("#modeOfTransportation\\.remark"),
        txtModeOfTransportationInActiveBy = $("#modeOfTransportation\\.inActiveBy"),
        dtpModeOfTransportationInActiveDate = $("#modeOfTransportation\\.inActiveDate"),
        txtModeOfTransportationCreatedBy = $("#modeOfTransportation\\.createdBy"),
        dtpModeOfTransportationCreatedDate = $("#modeOfTransportation\\.createdDate"),
        
        allFieldsModeOfTransportation=$([])
            .add(txtModeOfTransportationCode)
            .add(txtModeOfTransportationName)
            .add(txtModeOfTransportationRemark)
            .add(txtModeOfTransportationInActiveBy)
            .add(txtModeOfTransportationCreatedBy);


    function reloadGridModeOfTransportation(){
        $("#modeOfTransportation_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("modeOfTransportation");
        
        $('#modeOfTransportation\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#modeOfTransportationSearchActiveStatusRadActive').prop('checked',true);
        $("#modeOfTransportationSearchActiveStatus").val("true");
        
        $('input[name="modeOfTransportationSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#modeOfTransportationSearchActiveStatus").val(value);
        });
        
        $('input[name="modeOfTransportationSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#modeOfTransportationSearchActiveStatus").val(value);
        });
                
        $('input[name="modeOfTransportationSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#modeOfTransportationSearchActiveStatus").val(value);
        });
        
        $('input[name="modeOfTransportationActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#modeOfTransportation\\.activeStatus").val(value);
            $("#modeOfTransportation\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="modeOfTransportationActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#modeOfTransportation\\.activeStatus").val(value);
        });
        
        $("#btnModeOfTransportationNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/mode-of-transportation-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_modeOfTransportation();
                showInput("modeOfTransportation");
                hideInput("modeOfTransportationSearch");
                $('#modeOfTransportationActiveStatusRadActive').prop('checked',true);
                $("#modeOfTransportation\\.activeStatus").val("true");
                $("#modeOfTransportation\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#modeOfTransportation\\.createdDate").val("01/01/1900 00:00:00");
//                txtModeOfTransportationCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtModeOfTransportationCode.val("AUTO");
                txtModeOfTransportationCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnModeOfTransportationSave").click(function(ev) {
           if(!$("#frmModeOfTransportationInput").valid()) {
//               handlers_input_modeOfTransportation();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           modeOfTransportationFormatDate();
           if (updateRowId < 0){
               url = "master/mode-of-transportation-save";
           } else{
               url = "master/mode-of-transportation-update";
           }
           
           var params = $("#frmModeOfTransportationInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    modeOfTransportationFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("modeOfTransportation");
                showInput("modeOfTransportationSearch");
                allFieldsModeOfTransportation.val('').siblings('label[class="error"]').hide();
                txtModeOfTransportationCode.val("AUTO");
                reloadGridModeOfTransportation();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnModeOfTransportationUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/mode-of-transportation-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_modeOfTransportation();
                updateRowId=$("#modeOfTransportation_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var modeOfTransportation=$("#modeOfTransportation_grid").jqGrid('getRowData',updateRowId);
                var url="master/mode-of-transportation-get-data";
                var params="modeOfTransportation.code=" + modeOfTransportation.code;

                txtModeOfTransportationCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtModeOfTransportationCode.val(data.modeOfTransportationTemp.code);
                        txtModeOfTransportationName.val(data.modeOfTransportationTemp.name);
                        rdbModeOfTransportationActiveStatus.val(data.modeOfTransportationTemp.activeStatus);
                        txtModeOfTransportationRemark.val(data.modeOfTransportationTemp.remark);
                        txtModeOfTransportationInActiveBy.val(data.modeOfTransportationTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.modeOfTransportationTemp.inActiveDate,true);
                        dtpModeOfTransportationInActiveDate.val(inActiveDate);
                        txtModeOfTransportationCreatedBy.val(data.modeOfTransportationTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.modeOfTransportationTemp.createdDate,true);
                        dtpModeOfTransportationCreatedDate.val(createdDate);

                        if(data.modeOfTransportationTemp.activeStatus===true) {
                           $('#modeOfTransportationActiveStatusRadActive').prop('checked',true);
                           $("#modeOfTransportation\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#modeOfTransportationActiveStatusRadInActive').prop('checked',true);              
                           $("#modeOfTransportation\\.activeStatus").val("false");
                        }

                        showInput("modeOfTransportation");
                        hideInput("modeOfTransportationSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnModeOfTransportationDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/mode-of-transportation-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#modeOfTransportation_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var modeOfTransportation=$("#modeOfTransportation_grid").jqGrid('getRowData',deleteRowID);
                var url="master/mode-of-transportation-delete";
                var params="modeOfTransportation.code=" + modeOfTransportation.code;
                var message="Are You Sure To Delete(Code : "+ modeOfTransportation.code + ")?";
                alertMessageDelete("modeOfTransportation",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ modeOfTransportation.code+ ')?</div>');
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
//                                var url="master/modeOfTransportation-delete";
//                                var params="modeOfTransportation.code=" + modeOfTransportation.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridModeOfTransportation();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + modeOfTransportation.code+ ")")){
//                    var url="master/modeOfTransportation-delete";
//                    var params="modeOfTransportation.code=" + modeOfTransportation.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridModeOfTransportation();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnModeOfTransportationCancel").click(function(ev) {
            hideInput("modeOfTransportation");
            showInput("modeOfTransportationSearch");
            allFieldsModeOfTransportation.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnModeOfTransportationRefresh').click(function(ev) {
            $('#modeOfTransportationSearchActiveStatusRadActive').prop('checked',true);
            $("#modeOfTransportationSearchActiveStatus").val("true");
            $("#modeOfTransportation_grid").jqGrid("clearGridData");
            $("#modeOfTransportation_grid").jqGrid("setGridParam",{url:"master/modeOfTransportation-data?"});
            $("#modeOfTransportation_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnModeOfTransportationPrint").click(function(ev) {
            
            var url = "reports/mode-of-transportation-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'modeOfTransportation','width=500,height=500');
        });
        
        $('#btnModeOfTransportation_search').click(function(ev) {
            $("#modeOfTransportation_grid").jqGrid("clearGridData");
            $("#modeOfTransportation_grid").jqGrid("setGridParam",{url:"master/mode-of-transportation-data?" + $("#frmModeOfTransportationSearchInput").serialize()});
            $("#modeOfTransportation_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_modeOfTransportation(){
//        unHandlersInput(txtModeOfTransportationCode);
//        unHandlersInput(txtModeOfTransportationName);
//    }
//
//    function handlers_input_modeOfTransportation(){
//        if(txtModeOfTransportationCode.val()===""){
//            handlersInput(txtModeOfTransportationCode);
//        }else{
//            unHandlersInput(txtModeOfTransportationCode);
//        }
//        if(txtModeOfTransportationName.val()===""){
//            handlersInput(txtModeOfTransportationName);
//        }else{
//            unHandlersInput(txtModeOfTransportationName);
//        }
//    }
    
    function modeOfTransportationFormatDate(){
        var inActiveDate=formatDate(dtpModeOfTransportationInActiveDate.val(),true);
        dtpModeOfTransportationInActiveDate.val(inActiveDate);
        $("#modeOfTransportationTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpModeOfTransportationCreatedDate.val(),true);
        dtpModeOfTransportationCreatedDate.val(createdDate);
        $("#modeOfTransportationTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlModeOfTransportation" action="mode-of-transportation-data" />
<b>Mode Of Transportation</b>
<hr>
<br class="spacer"/>


<sj:div id="modeOfTransportationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnModeOfTransportationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnModeOfTransportationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnModeOfTransportationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnModeOfTransportationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnModeOfTransportationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="modeOfTransportationSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmModeOfTransportationSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="modeOfTransportationSearchCode" name="modeOfTransportationSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="modeOfTransportationSearchName" name="modeOfTransportationSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="modeOfTransportationSearchActiveStatus" name="modeOfTransportationSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="modeOfTransportationSearchActiveStatusRad" name="modeOfTransportationSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnModeOfTransportation_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="modeOfTransportationGrid">
    <sjg:grid
        id="modeOfTransportation_grid"
        dataType="json"
        href="%{remoteurlModeOfTransportation}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listModeOfTransportationTemp"
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
    
<div id="modeOfTransportationInput" class="content ui-widget">
    <s:form id="frmModeOfTransportationInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="modeOfTransportation.code" name="modeOfTransportation.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="modeOfTransportation.name" name="modeOfTransportation.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="modeOfTransportationActiveStatusRad" name="modeOfTransportationActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="modeOfTransportation.activeStatus" name="modeOfTransportation.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="modeOfTransportation.remark" name="modeOfTransportation.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="modeOfTransportation.inActiveBy"  name="modeOfTransportation.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="modeOfTransportation.inActiveDate" name="modeOfTransportation.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="modeOfTransportation.createdBy"  name="modeOfTransportation.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="modeOfTransportation.createdDate" name="modeOfTransportation.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="modeOfTransportationTemp.inActiveDateTemp" name="modeOfTransportationTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="modeOfTransportationTemp.createdDateTemp" name="modeOfTransportationTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnModeOfTransportationSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnModeOfTransportationCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>