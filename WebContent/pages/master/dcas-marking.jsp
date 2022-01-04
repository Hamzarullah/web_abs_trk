
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
        txtDcasMarkingCode=$("#dcasMarking\\.code"),
        txtDcasMarkingName=$("#dcasMarking\\.name"),
        rdbDcasMarkingActiveStatus=$("#dcasMarking\\.activeStatus"),
        txtDcasMarkingRemark=$("#dcasMarking\\.remark"),
        txtDcasMarkingInActiveBy = $("#dcasMarking\\.inActiveBy"),
        dtpDcasMarkingInActiveDate = $("#dcasMarking\\.inActiveDate"),
        txtDcasMarkingCreatedBy = $("#dcasMarking\\.createdBy"),
        dtpDcasMarkingCreatedDate = $("#dcasMarking\\.createdDate"),
        
        allFieldsDcasMarking=$([])
            .add(txtDcasMarkingCode)
            .add(txtDcasMarkingName)
            .add(txtDcasMarkingRemark)
            .add(txtDcasMarkingInActiveBy)
            .add(txtDcasMarkingCreatedBy);


    function reloadGridDcasMarking(){
        $("#dcasMarking_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasMarking");
        
        $('#dcasMarking\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasMarkingSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasMarkingSearchActiveStatus").val("true");
        
        $('input[name="dcasMarkingSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasMarkingSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasMarkingSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasMarkingSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasMarkingSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasMarkingSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasMarkingActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasMarking\\.activeStatus").val(value);
            $("#dcasMarking\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasMarkingActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasMarking\\.activeStatus").val(value);
        });
        
        $("#btnDcasMarkingNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-marking-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasMarking();
                showInput("dcasMarking");
                hideInput("dcasMarkingSearch");
                $('#dcasMarkingActiveStatusRadActive').prop('checked',true);
                $("#dcasMarking\\.activeStatus").val("true");
                $("#dcasMarking\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasMarking\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasMarkingCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasMarkingCode.attr("readonly",true);
                txtDcasMarkingCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasMarkingSave").click(function(ev) {
           if(!$("#frmDcasMarkingInput").valid()) {
//               handlers_input_dcasMarking();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasMarkingFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-marking-save";
           } else{
               url = "master/dcas-marking-update";
           }
           
           var params = $("#frmDcasMarkingInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasMarkingFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasMarking");
                showInput("dcasMarkingSearch");
                allFieldsDcasMarking.val('').siblings('label[class="error"]').hide();
                txtDcasMarkingCode.val("AUTO");
                reloadGridDcasMarking();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasMarkingUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-marking-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasMarking();
                updateRowId=$("#dcasMarking_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasMarking=$("#dcasMarking_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-marking-get-data";
                var params="dcasMarking.code=" + dcasMarking.code;

                txtDcasMarkingCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasMarkingCode.val(data.dcasMarkingTemp.code);
                        txtDcasMarkingName.val(data.dcasMarkingTemp.name);
                        rdbDcasMarkingActiveStatus.val(data.dcasMarkingTemp.activeStatus);
                        txtDcasMarkingRemark.val(data.dcasMarkingTemp.remark);
                        txtDcasMarkingInActiveBy.val(data.dcasMarkingTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasMarkingTemp.inActiveDate,true);
                        dtpDcasMarkingInActiveDate.val(inActiveDate);
                        txtDcasMarkingCreatedBy.val(data.dcasMarkingTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasMarkingTemp.createdDate,true);
                        dtpDcasMarkingCreatedDate.val(createdDate);

                        if(data.dcasMarkingTemp.activeStatus===true) {
                           $('#dcasMarkingActiveStatusRadActive').prop('checked',true);
                           $("#dcasMarking\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasMarkingActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasMarking\\.activeStatus").val("false");
                        }

                        showInput("dcasMarking");
                        hideInput("dcasMarkingSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasMarkingDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-marking-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasMarking_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasMarking=$("#dcasMarking_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-marking-delete";
                var params="dcasMarking.code=" + dcasMarking.code;
                var message="Are You Sure To Delete(Code : "+ dcasMarking.code + ")?";
                alertMessageDelete("dcasMarking",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasMarking.code+ ')?</div>');
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
//                                var url="master/dcas-marking-delete";
//                                var params="dcasMarking.code=" + dcasMarking.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasMarking();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasMarking.code+ ")")){
//                    var url="master/dcas-marking-delete";
//                    var params="dcasMarking.code=" + dcasMarking.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasMarking();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasMarkingCancel").click(function(ev) {
            hideInput("dcasMarking");
            showInput("dcasMarkingSearch");
            allFieldsDcasMarking.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasMarkingRefresh').click(function(ev) {
            $('#dcasMarkingSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasMarkingSearchActiveStatus").val("true");
            $("#dcasMarking_grid").jqGrid("clearGridData");
            $("#dcasMarking_grid").jqGrid("setGridParam",{url:"master/dcas-marking-data?"});
            $("#dcasMarking_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasMarkingPrint").click(function(ev) {
            
            var url = "reports/dcas-marking-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasMarking','width=500,height=500');
        });
        
        $('#btnDcasMarking_search').click(function(ev) {
            $("#dcasMarking_grid").jqGrid("clearGridData");
            $("#dcasMarking_grid").jqGrid("setGridParam",{url:"master/dcas-marking-data?" + $("#frmDcasMarkingSearchInput").serialize()});
            $("#dcasMarking_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasMarking(){
//        unHandlersInput(txtDcasMarkingCode);
//        unHandlersInput(txtDcasMarkingName);
//    }
//
//    function handlers_input_dcasMarking(){
//        if(txtDcasMarkingCode.val()===""){
//            handlersInput(txtDcasMarkingCode);
//        }else{
//            unHandlersInput(txtDcasMarkingCode);
//        }
//        if(txtDcasMarkingName.val()===""){
//            handlersInput(txtDcasMarkingName);
//        }else{
//            unHandlersInput(txtDcasMarkingName);
//        }
//    }
    
    function dcasMarkingFormatDate(){
        var inActiveDate=formatDate(dtpDcasMarkingInActiveDate.val(),true);
        dtpDcasMarkingInActiveDate.val(inActiveDate);
        $("#dcasMarkingTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasMarkingCreatedDate.val(),true);
        dtpDcasMarkingCreatedDate.val(createdDate);
        $("#dcasMarkingTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasMarking" action="dcas-marking-data" />
<b>Dcas Marking</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasMarkingButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasMarkingNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasMarkingUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasMarkingDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasMarkingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasMarkingPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasMarkingSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasMarkingSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasMarkingSearchCode" name="dcasMarkingSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasMarkingSearchName" name="dcasMarkingSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasMarkingSearchActiveStatus" name="dcasMarkingSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasMarkingSearchActiveStatusRad" name="dcasMarkingSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasMarking_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasMarkingGrid">
    <sjg:grid
        id="dcasMarking_grid"
        dataType="json"
        href="%{remoteurlDcasMarking}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasMarkingTemp"
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
    
<div id="dcasMarkingInput" class="content ui-widget">
    <s:form id="frmDcasMarkingInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasMarking.code" name="dcasMarking.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasMarking.name" name="dcasMarking.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasMarkingActiveStatusRad" name="dcasMarkingActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasMarking.activeStatus" name="dcasMarking.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasMarking.remark" name="dcasMarking.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasMarking.inActiveBy"  name="dcasMarking.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasMarking.inActiveDate" name="dcasMarking.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasMarking.createdBy"  name="dcasMarking.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasMarking.createdDate" name="dcasMarking.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasMarkingTemp.inActiveDateTemp" name="dcasMarkingTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasMarkingTemp.createdDateTemp" name="dcasMarkingTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasMarkingSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasMarkingCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>