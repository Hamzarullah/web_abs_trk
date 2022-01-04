
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
        txtDcasTestingCode=$("#dcasTesting\\.code"),
        txtDcasTestingName=$("#dcasTesting\\.name"),
        rdbDcasTestingActiveStatus=$("#dcasTesting\\.activeStatus"),
        txtDcasTestingRemark=$("#dcasTesting\\.remark"),
        txtDcasTestingInActiveBy = $("#dcasTesting\\.inActiveBy"),
        dtpDcasTestingInActiveDate = $("#dcasTesting\\.inActiveDate"),
        txtDcasTestingCreatedBy = $("#dcasTesting\\.createdBy"),
        dtpDcasTestingCreatedDate = $("#dcasTesting\\.createdDate"),
        
        allFieldsDcasTesting=$([])
            .add(txtDcasTestingCode)
            .add(txtDcasTestingName)
            .add(txtDcasTestingRemark)
            .add(txtDcasTestingInActiveBy)
            .add(txtDcasTestingCreatedBy);


    function reloadGridDcasTesting(){
        $("#dcasTesting_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasTesting");
        
        $('#dcasTesting\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasTestingSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasTestingSearchActiveStatus").val("true");
        
        $('input[name="dcasTestingSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasTestingSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasTestingSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasTestingSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasTestingSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasTestingSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasTestingActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasTesting\\.activeStatus").val(value);
            $("#dcasTesting\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasTestingActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasTesting\\.activeStatus").val(value);
        });
        
        $("#btnDcasTestingNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-testing-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasTesting();
                showInput("dcasTesting");
                hideInput("dcasTestingSearch");
                $('#dcasTestingActiveStatusRadActive').prop('checked',true);
                $("#dcasTesting\\.activeStatus").val("true");
                $("#dcasTesting\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasTesting\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasTestingCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasTestingCode.attr("readonly",true);
                txtDcasTestingCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasTestingSave").click(function(ev) {
           if(!$("#frmDcasTestingInput").valid()) {
//               handlers_input_dcasTesting();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasTestingFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-testing-save";
           } else{
               url = "master/dcas-testing-update";
           }
           
           var params = $("#frmDcasTestingInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasTestingFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasTesting");
                showInput("dcasTestingSearch");
                allFieldsDcasTesting.val('').siblings('label[class="error"]').hide();
                txtDcasTestingCode.val("AUTO");
                reloadGridDcasTesting();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasTestingUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-testing-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasTesting();
                updateRowId=$("#dcasTesting_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasTesting=$("#dcasTesting_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-testing-get-data";
                var params="dcasTesting.code=" + dcasTesting.code;

                txtDcasTestingCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasTestingCode.val(data.dcasTestingTemp.code);
                        txtDcasTestingName.val(data.dcasTestingTemp.name);
                        rdbDcasTestingActiveStatus.val(data.dcasTestingTemp.activeStatus);
                        txtDcasTestingRemark.val(data.dcasTestingTemp.remark);
                        txtDcasTestingInActiveBy.val(data.dcasTestingTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasTestingTemp.inActiveDate,true);
                        dtpDcasTestingInActiveDate.val(inActiveDate);
                        txtDcasTestingCreatedBy.val(data.dcasTestingTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasTestingTemp.createdDate,true);
                        dtpDcasTestingCreatedDate.val(createdDate);

                        if(data.dcasTestingTemp.activeStatus===true) {
                           $('#dcasTestingActiveStatusRadActive').prop('checked',true);
                           $("#dcasTesting\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasTestingActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasTesting\\.activeStatus").val("false");
                        }

                        showInput("dcasTesting");
                        hideInput("dcasTestingSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasTestingDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-testing-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasTesting_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasTesting=$("#dcasTesting_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-testing-delete";
                var params="dcasTesting.code=" + dcasTesting.code;
                var message="Are You Sure To Delete(Code : "+ dcasTesting.code + ")?";
                alertMessageDelete("dcasTesting",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasTesting.code+ ')?</div>');
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
//                                var url="master/dcas-testing-delete";
//                                var params="dcasTesting.code=" + dcasTesting.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasTesting();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasTesting.code+ ")")){
//                    var url="master/dcas-testing-delete";
//                    var params="dcasTesting.code=" + dcasTesting.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasTesting();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasTestingCancel").click(function(ev) {
            hideInput("dcasTesting");
            showInput("dcasTestingSearch");
            allFieldsDcasTesting.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasTestingRefresh').click(function(ev) {
            $('#dcasTestingSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasTestingSearchActiveStatus").val("true");
            $("#dcasTesting_grid").jqGrid("clearGridData");
            $("#dcasTesting_grid").jqGrid("setGridParam",{url:"master/dcas-testing-data?"});
            $("#dcasTesting_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasTestingPrint").click(function(ev) {
            
            var url = "reports/dcas-testing-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasTesting','width=500,height=500');
        });
        
        $('#btnDcasTesting_search').click(function(ev) {
            $("#dcasTesting_grid").jqGrid("clearGridData");
            $("#dcasTesting_grid").jqGrid("setGridParam",{url:"master/dcas-testing-data?" + $("#frmDcasTestingSearchInput").serialize()});
            $("#dcasTesting_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasTesting(){
//        unHandlersInput(txtDcasTestingCode);
//        unHandlersInput(txtDcasTestingName);
//    }
//
//    function handlers_input_dcasTesting(){
//        if(txtDcasTestingCode.val()===""){
//            handlersInput(txtDcasTestingCode);
//        }else{
//            unHandlersInput(txtDcasTestingCode);
//        }
//        if(txtDcasTestingName.val()===""){
//            handlersInput(txtDcasTestingName);
//        }else{
//            unHandlersInput(txtDcasTestingName);
//        }
//    }
    
    function dcasTestingFormatDate(){
        var inActiveDate=formatDate(dtpDcasTestingInActiveDate.val(),true);
        dtpDcasTestingInActiveDate.val(inActiveDate);
        $("#dcasTestingTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasTestingCreatedDate.val(),true);
        dtpDcasTestingCreatedDate.val(createdDate);
        $("#dcasTestingTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasTesting" action="dcas-testing-data" />
<b>Dcas Testing</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasTestingButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasTestingNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasTestingUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasTestingDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasTestingRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasTestingPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasTestingSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasTestingSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasTestingSearchCode" name="dcasTestingSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasTestingSearchName" name="dcasTestingSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasTestingSearchActiveStatus" name="dcasTestingSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasTestingSearchActiveStatusRad" name="dcasTestingSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasTesting_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasTestingGrid">
    <sjg:grid
        id="dcasTesting_grid"
        dataType="json"
        href="%{remoteurlDcasTesting}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasTestingTemp"
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
    
<div id="dcasTestingInput" class="content ui-widget">
    <s:form id="frmDcasTestingInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasTesting.code" name="dcasTesting.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasTesting.name" name="dcasTesting.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasTestingActiveStatusRad" name="dcasTestingActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasTesting.activeStatus" name="dcasTesting.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasTesting.remark" name="dcasTesting.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasTesting.inActiveBy"  name="dcasTesting.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasTesting.inActiveDate" name="dcasTesting.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasTesting.createdBy"  name="dcasTesting.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasTesting.createdDate" name="dcasTesting.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasTestingTemp.inActiveDateTemp" name="dcasTestingTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasTestingTemp.createdDateTemp" name="dcasTestingTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasTestingSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasTestingCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>