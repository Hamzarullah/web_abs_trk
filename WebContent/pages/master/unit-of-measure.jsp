
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
        txtUnitOfMeasureCode=$("#unitOfMeasure\\.code"),
        txtUnitOfMeasureName=$("#unitOfMeasure\\.name"),
        rdbUnitOfMeasureActiveStatus=$("#unitOfMeasure\\.activeStatus"),
        txtUnitOfMeasureRemark=$("#unitOfMeasure\\.remark"),
        txtUnitOfMeasureInActiveBy = $("#unitOfMeasure\\.inActiveBy"),
        dtpUnitOfMeasureInActiveDate = $("#unitOfMeasure\\.inActiveDate"),
        txtUnitOfMeasureCreatedBy = $("#unitOfMeasure\\.createdBy"),
        dtpUnitOfMeasureCreatedDate = $("#unitOfMeasure\\.createdDate"),
        
        allFieldsUnitOfMeasure=$([])
            .add(txtUnitOfMeasureCode)
            .add(txtUnitOfMeasureName)
            .add(txtUnitOfMeasureRemark)
            .add(txtUnitOfMeasureInActiveBy)
            .add(txtUnitOfMeasureCreatedBy);


    function reloadGridUnitOfMeasure(){
        $("#unitOfMeasure_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("unitOfMeasure");
        
        $('#unitOfMeasure\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#unitOfMeasureSearchActiveStatusRadActive').prop('checked',true);
        $("#unitOfMeasureSearchActiveStatus").val("true");
        
        $('input[name="unitOfMeasureSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#unitOfMeasureSearchActiveStatus").val(value);
        });
        
        $('input[name="unitOfMeasureSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#unitOfMeasureSearchActiveStatus").val(value);
        });
                
        $('input[name="unitOfMeasureSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#unitOfMeasureSearchActiveStatus").val(value);
        });
        
        $('input[name="unitOfMeasureActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#unitOfMeasure\\.activeStatus").val(value);
            $("#unitOfMeasure\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="unitOfMeasureActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#unitOfMeasure\\.activeStatus").val(value);
        });
        
        $("#btnUnitOfMeasureNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/unit-of-measure-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_unitOfMeasure();
                showInput("unitOfMeasure");
                hideInput("unitOfMeasureSearch");
                $('#unitOfMeasureActiveStatusRadActive').prop('checked',true);
                $("#unitOfMeasure\\.activeStatus").val("true");
                $("#unitOfMeasure\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#unitOfMeasure\\.createdDate").val("01/01/1900 00:00:00");
                txtUnitOfMeasureCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtUnitOfMeasureCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnUnitOfMeasureSave").click(function(ev) {
           if(!$("#frmUnitOfMeasureInput").valid()) {
//               handlers_input_unitOfMeasure();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           unitOfMeasureFormatDate();
           if (updateRowId < 0){
               url = "master/unit-of-measure-save";
           } else{
               url = "master/unit-of-measure-update";
           }
           
           var params = $("#frmUnitOfMeasureInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    unitOfMeasureFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("unitOfMeasure");
                showInput("unitOfMeasureSearch");
                allFieldsUnitOfMeasure.val('').siblings('label[class="error"]').hide();
                reloadGridUnitOfMeasure();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnUnitOfMeasureUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/unit-of-measure-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_unitOfMeasure();
                updateRowId=$("#unitOfMeasure_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var unitOfMeasure=$("#unitOfMeasure_grid").jqGrid('getRowData',updateRowId);
                var url="master/unit-of-measure-get-data";
                var params="unitOfMeasure.code=" + unitOfMeasure.code;

                txtUnitOfMeasureCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtUnitOfMeasureCode.val(data.unitOfMeasureTemp.code);
                        txtUnitOfMeasureName.val(data.unitOfMeasureTemp.name);
                        rdbUnitOfMeasureActiveStatus.val(data.unitOfMeasureTemp.activeStatus);
                        txtUnitOfMeasureRemark.val(data.unitOfMeasureTemp.remark);
                        txtUnitOfMeasureInActiveBy.val(data.unitOfMeasureTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.unitOfMeasureTemp.inActiveDate,true);
                        dtpUnitOfMeasureInActiveDate.val(inActiveDate);
                        txtUnitOfMeasureCreatedBy.val(data.unitOfMeasureTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.unitOfMeasureTemp.createdDate,true);
                        dtpUnitOfMeasureCreatedDate.val(createdDate);

                        if(data.unitOfMeasureTemp.activeStatus===true) {
                           $('#unitOfMeasureActiveStatusRadActive').prop('checked',true);
                           $("#unitOfMeasure\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#unitOfMeasureActiveStatusRadInActive').prop('checked',true);              
                           $("#unitOfMeasure\\.activeStatus").val("false");
                        }

                        showInput("unitOfMeasure");
                        hideInput("unitOfMeasureSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnUnitOfMeasureDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/unit-of-measure-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#unitOfMeasure_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var unitOfMeasure=$("#unitOfMeasure_grid").jqGrid('getRowData',deleteRowID);
                var url="master/unit-of-measure-delete";
                var params="unitOfMeasure.code=" + unitOfMeasure.code;
                var message="Are You Sure To Delete(Code : "+ unitOfMeasure.code + ")?";
                alertMessageDelete("unitOfMeasure",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ unitOfMeasure.code+ ')?</div>');
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
//                                var url="master/unitOfMeasure-delete";
//                                var params="unitOfMeasure.code=" + unitOfMeasure.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridUnitOfMeasure();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + unitOfMeasure.code+ ")")){
//                    var url="master/unitOfMeasure-delete";
//                    var params="unitOfMeasure.code=" + unitOfMeasure.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridUnitOfMeasure();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnUnitOfMeasureCancel").click(function(ev) {
            hideInput("unitOfMeasure");
            showInput("unitOfMeasureSearch");
            allFieldsUnitOfMeasure.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnUnitOfMeasureRefresh').click(function(ev) {
            $('#unitOfMeasureSearchActiveStatusRadActive').prop('checked',true);
            $("#unitOfMeasureSearchActiveStatus").val("true");
            $("#unitOfMeasure_grid").jqGrid("clearGridData");
            $("#unitOfMeasure_grid").jqGrid("setGridParam",{url:"master/unitOfMeasure-data?"});
            $("#unitOfMeasure_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnUnitOfMeasurePrint").click(function(ev) {
            
            var url = "reports/unitOfMeasure-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'unitOfMeasure','width=500,height=500');
        });
        
        $('#btnUnitOfMeasure_search').click(function(ev) {
            $("#unitOfMeasure_grid").jqGrid("clearGridData");
            $("#unitOfMeasure_grid").jqGrid("setGridParam",{url:"master/unit-of-measure-data?" + $("#frmUnitOfMeasureSearchInput").serialize()});
            $("#unitOfMeasure_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_unitOfMeasure(){
//        unHandlersInput(txtUnitOfMeasureCode);
//        unHandlersInput(txtUnitOfMeasureName);
//    }
//
//    function handlers_input_unitOfMeasure(){
//        if(txtUnitOfMeasureCode.val()===""){
//            handlersInput(txtUnitOfMeasureCode);
//        }else{
//            unHandlersInput(txtUnitOfMeasureCode);
//        }
//        if(txtUnitOfMeasureName.val()===""){
//            handlersInput(txtUnitOfMeasureName);
//        }else{
//            unHandlersInput(txtUnitOfMeasureName);
//        }
//    }
    
    function unitOfMeasureFormatDate(){
        var inActiveDate=formatDate(dtpUnitOfMeasureInActiveDate.val(),true);
        dtpUnitOfMeasureInActiveDate.val(inActiveDate);
        $("#unitOfMeasureTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpUnitOfMeasureCreatedDate.val(),true);
        dtpUnitOfMeasureCreatedDate.val(createdDate);
        $("#unitOfMeasureTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlUnitOfMeasure" action="unit-of-measure-data" />
<b>UNIT OF MEASURE</b>
<hr>
<br class="spacer"/>


<sj:div id="unitOfMeasureButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnUnitOfMeasureNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnUnitOfMeasureUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnUnitOfMeasureDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnUnitOfMeasureRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnUnitOfMeasurePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="unitOfMeasureSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmUnitOfMeasureSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="unitOfMeasureSearchCode" name="unitOfMeasureSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="unitOfMeasureSearchName" name="unitOfMeasureSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="unitOfMeasureSearchActiveStatus" name="unitOfMeasureSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="unitOfMeasureSearchActiveStatusRad" name="unitOfMeasureSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnUnitOfMeasure_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="unitOfMeasureGrid">
    <sjg:grid
        id="unitOfMeasure_grid"
        dataType="json"
        href="%{remoteurlUnitOfMeasure}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listUnitOfMeasureTemp"
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
    
<div id="unitOfMeasureInput" class="content ui-widget">
    <s:form id="frmUnitOfMeasureInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="unitOfMeasure.code" name="unitOfMeasure.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="unitOfMeasure.name" name="unitOfMeasure.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="unitOfMeasureActiveStatusRad" name="unitOfMeasureActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="unitOfMeasure.activeStatus" name="unitOfMeasure.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="unitOfMeasure.remark" name="unitOfMeasure.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="unitOfMeasure.inActiveBy"  name="unitOfMeasure.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="unitOfMeasure.inActiveDate" name="unitOfMeasure.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="unitOfMeasure.createdBy"  name="unitOfMeasure.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="unitOfMeasure.createdDate" name="unitOfMeasure.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="unitOfMeasureTemp.inActiveDateTemp" name="unitOfMeasureTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="unitOfMeasureTemp.createdDateTemp" name="unitOfMeasureTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnUnitOfMeasureSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnUnitOfMeasureCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>