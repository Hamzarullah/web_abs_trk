
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
        txtValveTypeCode=$("#valveType\\.code"),
        txtValveTypeName=$("#valveType\\.name"),
        rdbValveTypeActiveStatus=$("#valveType\\.activeStatus"),
        txtValveTypeRemark=$("#valveType\\.remark"),
        txtValveTypeInActiveBy = $("#valveType\\.inActiveBy"),
        dtpValveTypeInActiveDate = $("#valveType\\.inActiveDate"),
        txtValveTypeCreatedBy = $("#valveType\\.createdBy"),
        dtpValveTypeCreatedDate = $("#valveType\\.createdDate"),
        
        allFieldsValveType=$([])
            .add(txtValveTypeCode)
            .add(txtValveTypeName)
            .add(txtValveTypeRemark)
            .add(txtValveTypeInActiveBy)
            .add(txtValveTypeCreatedBy);


    function reloadGridValveType(){
        $("#valveType_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("valveType");
        
        $('#valveType\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#valveTypeSearchActiveStatusRadActive').prop('checked',true);
        $("#valveTypeSearchActiveStatus").val("true");
        
        $('input[name="valveTypeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#valveTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="valveTypeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#valveTypeSearchActiveStatus").val(value);
        });
                
        $('input[name="valveTypeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#valveTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="valveTypeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#valveType\\.activeStatus").val(value);
            $("#valveType\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="valveTypeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#valveType\\.activeStatus").val(value);
        });
        
        $("#btnValveTypeNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/valve-type-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_valveType();
                showInput("valveType");
                hideInput("valveTypeSearch");
                $('#valveTypeActiveStatusRadActive').prop('checked',true);
                $("#valveType\\.activeStatus").val("true");
                $("#valveType\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#valveType\\.createdDate").val("01/01/1900 00:00:00");
                txtValveTypeCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtValveTypeCode.attr("readonly",false);
                txtValveTypeCode.val("");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnValveTypeSave").click(function(ev) {
           if(!$("#frmValveTypeInput").valid()) {
//               handlers_input_valveType();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           valveTypeFormatDate();
           if (updateRowId < 0){
               url = "master/valve-type-save";
           } else{
               url = "master/valve-type-update";
           }
           
           var params = $("#frmValveTypeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    valveTypeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("valveType");
                showInput("valveTypeSearch");
                allFieldsValveType.val('').siblings('label[class="error"]').hide();
                txtValveTypeCode.val("AUTO");
                reloadGridValveType();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnValveTypeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/valve-type-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_valveType();
                updateRowId=$("#valveType_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var valveType=$("#valveType_grid").jqGrid('getRowData',updateRowId);
                var url="master/valve-type-get-data";
                var params="valveType.code=" + valveType.code;

                txtValveTypeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtValveTypeCode.val(data.valveTypeTemp.code);
                        txtValveTypeName.val(data.valveTypeTemp.name);
                        rdbValveTypeActiveStatus.val(data.valveTypeTemp.activeStatus);
                        txtValveTypeRemark.val(data.valveTypeTemp.remark);
                        txtValveTypeInActiveBy.val(data.valveTypeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.valveTypeTemp.inActiveDate,true);
                        dtpValveTypeInActiveDate.val(inActiveDate);
                        txtValveTypeCreatedBy.val(data.valveTypeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.valveTypeTemp.createdDate,true);
                        dtpValveTypeCreatedDate.val(createdDate);

                        if(data.valveTypeTemp.activeStatus===true) {
                           $('#valveTypeActiveStatusRadActive').prop('checked',true);
                           $("#valveType\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#valveTypeActiveStatusRadInActive').prop('checked',true);              
                           $("#valveType\\.activeStatus").val("false");
                        }

                        showInput("valveType");
                        hideInput("valveTypeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnValveTypeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/valve-type-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#valveType_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var valveType=$("#valveType_grid").jqGrid('getRowData',deleteRowID);
                var url="master/valve-type-delete";
                var params="valveType.code=" + valveType.code;
                var message="Are You Sure To Delete(Code : "+ valveType.code + ")?";
                alertMessageDelete("valveType",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ valveType.code+ ')?</div>');
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
//                                var url="master/valve-type-delete";
//                                var params="valveType.code=" + valveType.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridValveType();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + valveType.code+ ")")){
//                    var url="master/valve-type-delete";
//                    var params="valveType.code=" + valveType.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridValveType();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnValveTypeCancel").click(function(ev) {
            hideInput("valveType");
            showInput("valveTypeSearch");
            allFieldsValveType.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnValveTypeRefresh').click(function(ev) {
            $('#valveTypeSearchActiveStatusRadActive').prop('checked',true);
            $("#valveTypeSearchActiveStatus").val("true");
            $("#valveType_grid").jqGrid("clearGridData");
            $("#valveType_grid").jqGrid("setGridParam",{url:"master/valve-type-data?"});
            $("#valveType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnValveTypePrint").click(function(ev) {
            
            var url = "reports/valve-type-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'valveType','width=500,height=500');
        });
        
        $('#btnValveType_search').click(function(ev) {
            $("#valveType_grid").jqGrid("clearGridData");
            $("#valveType_grid").jqGrid("setGridParam",{url:"master/valve-type-data?" + $("#frmValveTypeSearchInput").serialize()});
            $("#valveType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_valveType(){
//        unHandlersInput(txtValveTypeCode);
//        unHandlersInput(txtValveTypeName);
//    }
//
//    function handlers_input_valveType(){
//        if(txtValveTypeCode.val()===""){
//            handlersInput(txtValveTypeCode);
//        }else{
//            unHandlersInput(txtValveTypeCode);
//        }
//        if(txtValveTypeName.val()===""){
//            handlersInput(txtValveTypeName);
//        }else{
//            unHandlersInput(txtValveTypeName);
//        }
//    }
    
    function valveTypeFormatDate(){
        var inActiveDate=formatDate(dtpValveTypeInActiveDate.val(),true);
        dtpValveTypeInActiveDate.val(inActiveDate);
        $("#valveTypeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpValveTypeCreatedDate.val(),true);
        dtpValveTypeCreatedDate.val(createdDate);
        $("#valveTypeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlValveType" action="valve-type-data" />
<b>Valve Type</b>
<hr>
<br class="spacer"/>


<sj:div id="valveTypeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnValveTypeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnValveTypeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnValveTypeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnValveTypeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnValveTypePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="valveTypeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmValveTypeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="valveTypeSearchCode" name="valveTypeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="valveTypeSearchName" name="valveTypeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="valveTypeSearchActiveStatus" name="valveTypeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="valveTypeSearchActiveStatusRad" name="valveTypeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnValveType_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="valveTypeGrid">
    <sjg:grid
        id="valveType_grid"
        dataType="json"
        href="%{remoteurlValveType}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listValveTypeTemp"
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
    
<div id="valveTypeInput" class="content ui-widget">
    <s:form id="frmValveTypeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="valveType.code" name="valveType.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="valveType.name" name="valveType.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="valveTypeActiveStatusRad" name="valveTypeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="valveType.activeStatus" name="valveType.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="valveType.remark" name="valveType.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="valveType.inActiveBy"  name="valveType.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="valveType.inActiveDate" name="valveType.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="valveType.createdBy"  name="valveType.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="valveType.createdDate" name="valveType.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="valveTypeTemp.inActiveDateTemp" name="valveTypeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="valveTypeTemp.createdDateTemp" name="valveTypeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnValveTypeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnValveTypeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>