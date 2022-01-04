
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
        txtRackTypeCode=$("#rackType\\.code"),
        txtRackTypeName=$("#rackType\\.name"),
        rdbRackTypeActiveStatus=$("#rackType\\.activeStatus"),
        txtRackTypeRemark=$("#rackType\\.remark"),
        txtRackTypeInActiveBy = $("#rackType\\.inActiveBy"),
        dtpRackTypeInActiveDate = $("#rackType\\.inActiveDate"),
        txtRackTypeCreatedBy = $("#rackType\\.createdBy"),
        dtpRackTypeCreatedDate = $("#rackType\\.createdDate"),
        
        allFieldsRackType=$([])
            .add(txtRackTypeCode)
            .add(txtRackTypeName)
            .add(txtRackTypeRemark)
            .add(txtRackTypeInActiveBy)
            .add(txtRackTypeCreatedBy);


    function reloadGridRackType(){
        $("#rackType_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("rackType");
        
        $('#rackType\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#rackTypeSearchActiveStatusRadActive').prop('checked',true);
        $("#rackTypeSearchActiveStatus").val("true");
        
        $('input[name="rackTypeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#rackTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="rackTypeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#rackTypeSearchActiveStatus").val(value);
        });
                
        $('input[name="rackTypeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#rackTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="rackTypeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#rackType\\.activeStatus").val(value);
            $("#rackType\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="rackTypeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#rackType\\.activeStatus").val(value);
        });
        
        $("#btnRackTypeNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/rackType-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_rackType();
                showInput("rackType");
                hideInput("rackTypeSearch");
                $('#rackTypeActiveStatusRadActive').prop('checked',true);
                $("#rackType\\.activeStatus").val("true");
                $("#rackType\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#rackType\\.createdDate").val("01/01/1900 00:00:00");
                txtRackTypeCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtRackTypeCode.attr("readonly",true);
                txtRackTypeCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnRackTypeSave").click(function(ev) {
           if(!$("#frmRackTypeInput").valid()) {
//               handlers_input_rackType();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           rackTypeFormatDate();
           if (updateRowId < 0){
               url = "master/rackType-save";
           } else{
               url = "master/rackType-update";
           }
           
           var params = $("#frmRackTypeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    rackTypeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("rackType");
                showInput("rackTypeSearch");
                allFieldsRackType.val('').siblings('label[class="error"]').hide();
                txtRackTypeCode.val("AUTO");
                reloadGridRackType();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnRackTypeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/rackType-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_rackType();
                updateRowId=$("#rackType_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var rackType=$("#rackType_grid").jqGrid('getRowData',updateRowId);
                var url="master/rackType-get-data";
                var params="rackType.code=" + rackType.code;

                txtRackTypeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtRackTypeCode.val(data.rackTypeTemp.code);
                        txtRackTypeName.val(data.rackTypeTemp.name);
                        rdbRackTypeActiveStatus.val(data.rackTypeTemp.activeStatus);
                        txtRackTypeRemark.val(data.rackTypeTemp.remark);
                        txtRackTypeInActiveBy.val(data.rackTypeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.rackTypeTemp.inActiveDate,true);
                        dtpRackTypeInActiveDate.val(inActiveDate);
                        txtRackTypeCreatedBy.val(data.rackTypeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.rackTypeTemp.createdDate,true);
                        dtpRackTypeCreatedDate.val(createdDate);

                        if(data.rackTypeTemp.activeStatus===true) {
                           $('#rackTypeActiveStatusRadActive').prop('checked',true);
                           $("#rackType\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#rackTypeActiveStatusRadInActive').prop('checked',true);              
                           $("#rackType\\.activeStatus").val("false");
                        }

                        showInput("rackType");
                        hideInput("rackTypeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnRackTypeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/rackType-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#rackType_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var rackType=$("#rackType_grid").jqGrid('getRowData',deleteRowID);
                var url="master/rackType-delete";
                var params="rackType.code=" + rackType.code;
                var message="Are You Sure To Delete(Code : "+ rackType.code + ")?";
                alertMessageDelete("rackType",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ rackType.code+ ')?</div>');
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
//                                var url="master/rackType-delete";
//                                var params="rackType.code=" + rackType.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridRackType();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + rackType.code+ ")")){
//                    var url="master/rackType-delete";
//                    var params="rackType.code=" + rackType.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridRackType();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnRackTypeCancel").click(function(ev) {
            hideInput("rackType");
            showInput("rackTypeSearch");
            allFieldsRackType.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnRackTypeRefresh').click(function(ev) {
            $('#rackTypeSearchActiveStatusRadActive').prop('checked',true);
            $("#rackTypeSearchActiveStatus").val("true");
            $("#rackType_grid").jqGrid("clearGridData");
            $("#rackType_grid").jqGrid("setGridParam",{url:"master/rackType-data?"});
            $("#rackType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnRackTypePrint").click(function(ev) {
            
            var url = "reports/rackType-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'rackType','width=500,height=500');
        });
        
        $('#btnRackType_search').click(function(ev) {
            $("#rackType_grid").jqGrid("clearGridData");
            $("#rackType_grid").jqGrid("setGridParam",{url:"master/rackType-data?" + $("#frmRackTypeSearchInput").serialize()});
            $("#rackType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_rackType(){
//        unHandlersInput(txtRackTypeCode);
//        unHandlersInput(txtRackTypeName);
//    }
//
//    function handlers_input_rackType(){
//        if(txtRackTypeCode.val()===""){
//            handlersInput(txtRackTypeCode);
//        }else{
//            unHandlersInput(txtRackTypeCode);
//        }
//        if(txtRackTypeName.val()===""){
//            handlersInput(txtRackTypeName);
//        }else{
//            unHandlersInput(txtRackTypeName);
//        }
//    }
    
    function rackTypeFormatDate(){
        var inActiveDate=formatDate(dtpRackTypeInActiveDate.val(),true);
        dtpRackTypeInActiveDate.val(inActiveDate);
        $("#rackTypeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpRackTypeCreatedDate.val(),true);
        dtpRackTypeCreatedDate.val(createdDate);
        $("#rackTypeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlRackType" action="rackType-data" />
<b>RACK TYPE</b>
<hr>
<br class="spacer"/>


<sj:div id="rackTypeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnRackTypeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnRackTypeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnRackTypeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnRackTypeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnRackTypePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="rackTypeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmRackTypeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="rackTypeSearchCode" name="rackTypeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="rackTypeSearchName" name="rackTypeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="rackTypeSearchActiveStatus" name="rackTypeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="rackTypeSearchActiveStatusRad" name="rackTypeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnRackType_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="rackTypeGrid">
    <sjg:grid
        id="rackType_grid"
        dataType="json"
        href="%{remoteurlRackType}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listRackTypeTemp"
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
    
<div id="rackTypeInput" class="content ui-widget">
    <s:form id="frmRackTypeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="rackType.code" name="rackType.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="rackType.name" name="rackType.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="rackTypeActiveStatusRad" name="rackTypeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="rackType.activeStatus" name="rackType.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="rackType.remark" name="rackType.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="rackType.inActiveBy"  name="rackType.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="rackType.inActiveDate" name="rackType.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="rackType.createdBy"  name="rackType.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="rackType.createdDate" name="rackType.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="rackTypeTemp.inActiveDateTemp" name="rackTypeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="rackTypeTemp.createdDateTemp" name="rackTypeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnRackTypeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnRackTypeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>