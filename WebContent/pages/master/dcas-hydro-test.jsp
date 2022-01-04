
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
        txtDcasHydroTestCode=$("#dcasHydroTest\\.code"),
        txtDcasHydroTestName=$("#dcasHydroTest\\.name"),
        rdbDcasHydroTestActiveStatus=$("#dcasHydroTest\\.activeStatus"),
        txtDcasHydroTestRemark=$("#dcasHydroTest\\.remark"),
        txtDcasHydroTestInActiveBy = $("#dcasHydroTest\\.inActiveBy"),
        dtpDcasHydroTestInActiveDate = $("#dcasHydroTest\\.inActiveDate"),
        txtDcasHydroTestCreatedBy = $("#dcasHydroTest\\.createdBy"),
        dtpDcasHydroTestCreatedDate = $("#dcasHydroTest\\.createdDate"),
        
        allFieldsDcasHydroTest=$([])
            .add(txtDcasHydroTestCode)
            .add(txtDcasHydroTestName)
            .add(txtDcasHydroTestRemark)
            .add(txtDcasHydroTestInActiveBy)
            .add(txtDcasHydroTestCreatedBy);


    function reloadGridDcasHydroTest(){
        $("#dcasHydroTest_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("dcasHydroTest");
        
        $('#dcasHydroTest\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#dcasHydroTestSearchActiveStatusRadActive').prop('checked',true);
        $("#dcasHydroTestSearchActiveStatus").val("true");
        
        $('input[name="dcasHydroTestSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#dcasHydroTestSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasHydroTestSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasHydroTestSearchActiveStatus").val(value);
        });
                
        $('input[name="dcasHydroTestSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasHydroTestSearchActiveStatus").val(value);
        });
        
        $('input[name="dcasHydroTestActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#dcasHydroTest\\.activeStatus").val(value);
            $("#dcasHydroTest\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="dcasHydroTestActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#dcasHydroTest\\.activeStatus").val(value);
        });
        
        $("#btnDcasHydroTestNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-hydro-test-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasHydroTest();
                showInput("dcasHydroTest");
                hideInput("dcasHydroTestSearch");
                $('#dcasHydroTestActiveStatusRadActive').prop('checked',true);
                $("#dcasHydroTest\\.activeStatus").val("true");
                $("#dcasHydroTest\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#dcasHydroTest\\.createdDate").val("01/01/1900 00:00:00");
                txtDcasHydroTestCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtDcasHydroTestCode.attr("readonly",true);
                txtDcasHydroTestCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasHydroTestSave").click(function(ev) {
           if(!$("#frmDcasHydroTestInput").valid()) {
//               handlers_input_dcasHydroTest();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           dcasHydroTestFormatDate();
           if (updateRowId < 0){
               url = "master/dcas-hydro-test-save";
           } else{
               url = "master/dcas-hydro-test-update";
           }
           
           var params = $("#frmDcasHydroTestInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    dcasHydroTestFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("dcasHydroTest");
                showInput("dcasHydroTestSearch");
                allFieldsDcasHydroTest.val('').siblings('label[class="error"]').hide();
                txtDcasHydroTestCode.val("AUTO");
                reloadGridDcasHydroTest();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnDcasHydroTestUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-hydro-test-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_dcasHydroTest();
                updateRowId=$("#dcasHydroTest_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var dcasHydroTest=$("#dcasHydroTest_grid").jqGrid('getRowData',updateRowId);
                var url="master/dcas-hydro-test-get-data";
                var params="dcasHydroTest.code=" + dcasHydroTest.code;

                txtDcasHydroTestCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtDcasHydroTestCode.val(data.dcasHydroTestTemp.code);
                        txtDcasHydroTestName.val(data.dcasHydroTestTemp.name);
                        rdbDcasHydroTestActiveStatus.val(data.dcasHydroTestTemp.activeStatus);
                        txtDcasHydroTestRemark.val(data.dcasHydroTestTemp.remark);
                        txtDcasHydroTestInActiveBy.val(data.dcasHydroTestTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.dcasHydroTestTemp.inActiveDate,true);
                        dtpDcasHydroTestInActiveDate.val(inActiveDate);
                        txtDcasHydroTestCreatedBy.val(data.dcasHydroTestTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.dcasHydroTestTemp.createdDate,true);
                        dtpDcasHydroTestCreatedDate.val(createdDate);

                        if(data.dcasHydroTestTemp.activeStatus===true) {
                           $('#dcasHydroTestActiveStatusRadActive').prop('checked',true);
                           $("#dcasHydroTest\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#dcasHydroTestActiveStatusRadInActive').prop('checked',true);              
                           $("#dcasHydroTest\\.activeStatus").val("false");
                        }

                        showInput("dcasHydroTest");
                        hideInput("dcasHydroTestSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnDcasHydroTestDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/dcas-hydro-test-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#dcasHydroTest_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var dcasHydroTest=$("#dcasHydroTest_grid").jqGrid('getRowData',deleteRowID);
                var url="master/dcas-hydro-test-delete";
                var params="dcasHydroTest.code=" + dcasHydroTest.code;
                var message="Are You Sure To Delete(Code : "+ dcasHydroTest.code + ")?";
                alertMessageDelete("dcasHydroTest",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ dcasHydroTest.code+ ')?</div>');
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
//                                var url="master/dcas-hydro-test-delete";
//                                var params="dcasHydroTest.code=" + dcasHydroTest.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridDcasHydroTest();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + dcasHydroTest.code+ ")")){
//                    var url="master/dcas-hydro-test-delete";
//                    var params="dcasHydroTest.code=" + dcasHydroTest.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridDcasHydroTest();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnDcasHydroTestCancel").click(function(ev) {
            hideInput("dcasHydroTest");
            showInput("dcasHydroTestSearch");
            allFieldsDcasHydroTest.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnDcasHydroTestRefresh').click(function(ev) {
            $('#dcasHydroTestSearchActiveStatusRadActive').prop('checked',true);
            $("#dcasHydroTestSearchActiveStatus").val("true");
            $("#dcasHydroTest_grid").jqGrid("clearGridData");
            $("#dcasHydroTest_grid").jqGrid("setGridParam",{url:"master/dcas-hydro-test-data?"});
            $("#dcasHydroTest_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnDcasHydroTestPrint").click(function(ev) {
            
            var url = "reports/dcas-hydro-test-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'dcasHydroTest','width=500,height=500');
        });
        
        $('#btnDcasHydroTest_search').click(function(ev) {
            $("#dcasHydroTest_grid").jqGrid("clearGridData");
            $("#dcasHydroTest_grid").jqGrid("setGridParam",{url:"master/dcas-hydro-test-data?" + $("#frmDcasHydroTestSearchInput").serialize()});
            $("#dcasHydroTest_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_dcasHydroTest(){
//        unHandlersInput(txtDcasHydroTestCode);
//        unHandlersInput(txtDcasHydroTestName);
//    }
//
//    function handlers_input_dcasHydroTest(){
//        if(txtDcasHydroTestCode.val()===""){
//            handlersInput(txtDcasHydroTestCode);
//        }else{
//            unHandlersInput(txtDcasHydroTestCode);
//        }
//        if(txtDcasHydroTestName.val()===""){
//            handlersInput(txtDcasHydroTestName);
//        }else{
//            unHandlersInput(txtDcasHydroTestName);
//        }
//    }
    
    function dcasHydroTestFormatDate(){
        var inActiveDate=formatDate(dtpDcasHydroTestInActiveDate.val(),true);
        dtpDcasHydroTestInActiveDate.val(inActiveDate);
        $("#dcasHydroTestTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpDcasHydroTestCreatedDate.val(),true);
        dtpDcasHydroTestCreatedDate.val(createdDate);
        $("#dcasHydroTestTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlDcasHydroTest" action="dcas-hydro-test-data" />
<b>Dcas Hydro Test</b>
<hr>
<br class="spacer"/>


<sj:div id="dcasHydroTestButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDcasHydroTestNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDcasHydroTestUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDcasHydroTestDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDcasHydroTestRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDcasHydroTestPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="dcasHydroTestSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDcasHydroTestSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="dcasHydroTestSearchCode" name="dcasHydroTestSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="dcasHydroTestSearchName" name="dcasHydroTestSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="dcasHydroTestSearchActiveStatus" name="dcasHydroTestSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="dcasHydroTestSearchActiveStatusRad" name="dcasHydroTestSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDcasHydroTest_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="dcasHydroTestGrid">
    <sjg:grid
        id="dcasHydroTest_grid"
        dataType="json"
        href="%{remoteurlDcasHydroTest}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDcasHydroTestTemp"
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
    
<div id="dcasHydroTestInput" class="content ui-widget">
    <s:form id="frmDcasHydroTestInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="dcasHydroTest.code" name="dcasHydroTest.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="dcasHydroTest.name" name="dcasHydroTest.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="dcasHydroTestActiveStatusRad" name="dcasHydroTestActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="dcasHydroTest.activeStatus" name="dcasHydroTest.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="dcasHydroTest.remark" name="dcasHydroTest.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="dcasHydroTest.inActiveBy"  name="dcasHydroTest.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="dcasHydroTest.inActiveDate" name="dcasHydroTest.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasHydroTest.createdBy"  name="dcasHydroTest.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="dcasHydroTest.createdDate" name="dcasHydroTest.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="dcasHydroTestTemp.inActiveDateTemp" name="dcasHydroTestTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="dcasHydroTestTemp.createdDateTemp" name="dcasHydroTestTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnDcasHydroTestSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnDcasHydroTestCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>