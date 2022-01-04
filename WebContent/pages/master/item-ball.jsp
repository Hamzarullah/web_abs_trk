
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
        txtItemBallCode=$("#itemBall\\.code"),
        txtItemBallName=$("#itemBall\\.name"),
        rdbItemBallActiveStatus=$("#itemBall\\.activeStatus"),
        txtItemBallRemark=$("#itemBall\\.remark"),
        txtItemBallInActiveBy = $("#itemBall\\.inActiveBy"),
        dtpItemBallInActiveDate = $("#itemBall\\.inActiveDate"),
        txtItemBallCreatedBy = $("#itemBall\\.createdBy"),
        dtpItemBallCreatedDate = $("#itemBall\\.createdDate"),
        
        allFieldsItemBall=$([])
            .add(txtItemBallCode)
            .add(txtItemBallName)
            .add(txtItemBallRemark)
            .add(txtItemBallInActiveBy)
            .add(txtItemBallCreatedBy);


    function reloadGridItemBall(){
        $("#itemBall_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBall");
        
        $('#itemBall\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBallSearchActiveStatusRadActive').prop('checked',true);
        $("#itemBallSearchActiveStatus").val("true");
        
        $('input[name="itemBallSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBallSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBallSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBallSearchActiveStatus").val(value);
        });
                
        $('input[name="itemBallSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBallSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBallActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBall\\.activeStatus").val(value);
            $("#itemBall\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBallActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBall\\.activeStatus").val(value);
        });
        
        $("#btnItemBallNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-ball-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBall();
                showInput("itemBall");
                hideInput("itemBallSearch");
                $('#itemBallActiveStatusRadActive').prop('checked',true);
                $("#itemBall\\.activeStatus").val("true");
                $("#itemBall\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBall\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemBallCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBallCode.val("AUTO");
                txtItemBallCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBallSave").click(function(ev) {
           if(!$("#frmItemBallInput").valid()) {
//               handlers_input_itemBall();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBallFormatDate();
           if (updateRowId < 0){
               url = "master/item-ball-save";
           } else{
               url = "master/item-ball-update";
           }
           
           var params = $("#frmItemBallInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBallFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBall");
                showInput("itemBallSearch");
                allFieldsItemBall.val('').siblings('label[class="error"]').hide();
                txtItemBallCode.val("AUTO");
                reloadGridItemBall();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBallUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-ball-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBall();
                updateRowId=$("#itemBall_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBall=$("#itemBall_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-ball-get-data";
                var params="itemBall.code=" + itemBall.code;

                txtItemBallCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBallCode.val(data.itemBallTemp.code);
                        txtItemBallName.val(data.itemBallTemp.name);
                        rdbItemBallActiveStatus.val(data.itemBallTemp.activeStatus);
                        txtItemBallRemark.val(data.itemBallTemp.remark);
                        txtItemBallInActiveBy.val(data.itemBallTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBallTemp.inActiveDate,true);
                        dtpItemBallInActiveDate.val(inActiveDate);
                        txtItemBallCreatedBy.val(data.itemBallTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBallTemp.createdDate,true);
                        dtpItemBallCreatedDate.val(createdDate);

                        if(data.itemBallTemp.activeStatus===true) {
                           $('#itemBallActiveStatusRadActive').prop('checked',true);
                           $("#itemBall\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBallActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBall\\.activeStatus").val("false");
                        }

                        showInput("itemBall");
                        hideInput("itemBallSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBallDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-ball-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBall_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBall=$("#itemBall_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-ball-delete";
                var params="itemBall.code=" + itemBall.code;
                var message="Are You Sure To Delete(Code : "+ itemBall.code + ")?";
                alertMessageDelete("itemBall",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBall.code+ ')?</div>');
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
//                                var url="master/itemBall-delete";
//                                var params="itemBall.code=" + itemBall.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBall();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBall.code+ ")")){
//                    var url="master/itemBall-delete";
//                    var params="itemBall.code=" + itemBall.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBall();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBallCancel").click(function(ev) {
            hideInput("itemBall");
            showInput("itemBallSearch");
            allFieldsItemBall.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBallRefresh').click(function(ev) {
            $('#itemBallSearchActiveStatusRadActive').prop('checked',true);
            $("#itemBallSearchActiveStatus").val("true");
            $("#itemBall_grid").jqGrid("clearGridData");
            $("#itemBall_grid").jqGrid("setGridParam",{url:"master/itemBall-data?"});
            $("#itemBall_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBallPrint").click(function(ev) {
            
            var url = "reports/item-ball-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBall','width=500,height=500');
        });
        
        $('#btnItemBall_search').click(function(ev) {
            $("#itemBall_grid").jqGrid("clearGridData");
            $("#itemBall_grid").jqGrid("setGridParam",{url:"master/item-ball-data?" + $("#frmItemBallSearchInput").serialize()});
            $("#itemBall_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBall(){
//        unHandlersInput(txtItemBallCode);
//        unHandlersInput(txtItemBallName);
//    }
//
//    function handlers_input_itemBall(){
//        if(txtItemBallCode.val()===""){
//            handlersInput(txtItemBallCode);
//        }else{
//            unHandlersInput(txtItemBallCode);
//        }
//        if(txtItemBallName.val()===""){
//            handlersInput(txtItemBallName);
//        }else{
//            unHandlersInput(txtItemBallName);
//        }
//    }
    
    function itemBallFormatDate(){
        var inActiveDate=formatDate(dtpItemBallInActiveDate.val(),true);
        dtpItemBallInActiveDate.val(inActiveDate);
        $("#itemBallTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBallCreatedDate.val(),true);
        dtpItemBallCreatedDate.val(createdDate);
        $("#itemBallTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBall" action="item-ball-data" />
<b>Item Ball</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBallButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBallNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBallUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBallDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBallRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBallPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBallSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBallSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBallSearchCode" name="itemBallSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBallSearchName" name="itemBallSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBallSearchActiveStatus" name="itemBallSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBallSearchActiveStatusRad" name="itemBallSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBall_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBallGrid">
    <sjg:grid
        id="itemBall_grid"
        dataType="json"
        href="%{remoteurlItemBall}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBallTemp"
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
    
<div id="itemBallInput" class="content ui-widget">
    <s:form id="frmItemBallInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBall.code" name="itemBall.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBall.name" name="itemBall.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBallActiveStatusRad" name="itemBallActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBall.activeStatus" name="itemBall.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBall.remark" name="itemBall.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBall.inActiveBy"  name="itemBall.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemBall.inActiveDate" name="itemBall.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBall.createdBy"  name="itemBall.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBall.createdDate" name="itemBall.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBallTemp.inActiveDateTemp" name="itemBallTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBallTemp.createdDateTemp" name="itemBallTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBallSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBallCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>