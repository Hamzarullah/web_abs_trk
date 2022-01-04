
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
        txtItemShaftCode=$("#itemShaft\\.code"),
        txtItemShaftName=$("#itemShaft\\.name"),
        rdbItemShaftActiveStatus=$("#itemShaft\\.activeStatus"),
        txtItemShaftRemark=$("#itemShaft\\.remark"),
        txtItemShaftInActiveBy = $("#itemShaft\\.inActiveBy"),
        dtpItemShaftInActiveDate = $("#itemShaft\\.inActiveDate"),
        txtItemShaftCreatedBy = $("#itemShaft\\.createdBy"),
        dtpItemShaftCreatedDate = $("#itemShaft\\.createdDate"),
        
        allFieldsItemShaft=$([])
            .add(txtItemShaftCode)
            .add(txtItemShaftName)
            .add(txtItemShaftRemark)
            .add(txtItemShaftInActiveBy)
            .add(txtItemShaftCreatedBy);


    function reloadGridItemShaft(){
        $("#itemShaft_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemShaft");
        
        $('#itemShaft\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemShaftSearchActiveStatusRadActive').prop('checked',true);
        $("#itemShaftSearchActiveStatus").val("true");
        
        $('input[name="itemShaftSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemShaftSearchActiveStatus").val(value);
        });
        
        $('input[name="itemShaftSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemShaftSearchActiveStatus").val(value);
        });
                
        $('input[name="itemShaftSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemShaftSearchActiveStatus").val(value);
        });
        
        $('input[name="itemShaftActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemShaft\\.activeStatus").val(value);
            $("#itemShaft\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemShaftActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemShaft\\.activeStatus").val(value);
        });
        
        $("#btnItemShaftNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-shaft-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemShaft();
                showInput("itemShaft");
                hideInput("itemShaftSearch");
                $('#itemShaftActiveStatusRadActive').prop('checked',true);
                $("#itemShaft\\.activeStatus").val("true");
                $("#itemShaft\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemShaft\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemShaftCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemShaftCode.val("AUTO");
                txtItemShaftCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemShaftSave").click(function(ev) {
           if(!$("#frmItemShaftInput").valid()) {
//               handlers_input_itemShaft();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemShaftFormatDate();
           if (updateRowId < 0){
               url = "master/item-shaft-save";
           } else{
               url = "master/item-shaft-update";
           }
           
           var params = $("#frmItemShaftInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemShaftFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemShaft");
                showInput("itemShaftSearch");
                allFieldsItemShaft.val('').siblings('label[class="error"]').hide();
                txtItemShaftCode.val("AUTO");
                reloadGridItemShaft();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemShaftUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-shaft-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemShaft();
                updateRowId=$("#itemShaft_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemShaft=$("#itemShaft_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-shaft-get-data";
                var params="itemShaft.code=" + itemShaft.code;

                txtItemShaftCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemShaftCode.val(data.itemShaftTemp.code);
                        txtItemShaftName.val(data.itemShaftTemp.name);
                        rdbItemShaftActiveStatus.val(data.itemShaftTemp.activeStatus);
                        txtItemShaftRemark.val(data.itemShaftTemp.remark);
                        txtItemShaftInActiveBy.val(data.itemShaftTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemShaftTemp.inActiveDate,true);
                        dtpItemShaftInActiveDate.val(inActiveDate);
                        txtItemShaftCreatedBy.val(data.itemShaftTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemShaftTemp.createdDate,true);
                        dtpItemShaftCreatedDate.val(createdDate);

                        if(data.itemShaftTemp.activeStatus===true) {
                           $('#itemShaftActiveStatusRadActive').prop('checked',true);
                           $("#itemShaft\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemShaftActiveStatusRadInActive').prop('checked',true);              
                           $("#itemShaft\\.activeStatus").val("false");
                        }

                        showInput("itemShaft");
                        hideInput("itemShaftSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemShaftDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-shaft-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemShaft_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemShaft=$("#itemShaft_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-shaft-delete";
                var params="itemShaft.code=" + itemShaft.code;
                var message="Are You Sure To Delete(Code : "+ itemShaft.code + ")?";
                alertMessageDelete("itemShaft",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemShaft.code+ ')?</div>');
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
//                                var url="master/itemShaft-delete";
//                                var params="itemShaft.code=" + itemShaft.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemShaft();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemShaft.code+ ")")){
//                    var url="master/itemShaft-delete";
//                    var params="itemShaft.code=" + itemShaft.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemShaft();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemShaftCancel").click(function(ev) {
            hideInput("itemShaft");
            showInput("itemShaftSearch");
            allFieldsItemShaft.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemShaftRefresh').click(function(ev) {
            $('#itemShaftSearchActiveStatusRadActive').prop('checked',true);
            $("#itemShaftSearchActiveStatus").val("true");
            $("#itemShaft_grid").jqGrid("clearGridData");
            $("#itemShaft_grid").jqGrid("setGridParam",{url:"master/itemShaft-data?"});
            $("#itemShaft_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemShaftPrint").click(function(ev) {
            
            var url = "reports/item-shaft-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemShaft','width=500,height=500');
        });
        
        $('#btnItemShaft_search').click(function(ev) {
            $("#itemShaft_grid").jqGrid("clearGridData");
            $("#itemShaft_grid").jqGrid("setGridParam",{url:"master/item-shaft-data?" + $("#frmItemShaftSearchInput").serialize()});
            $("#itemShaft_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemShaft(){
//        unHandlersInput(txtItemShaftCode);
//        unHandlersInput(txtItemShaftName);
//    }
//
//    function handlers_input_itemShaft(){
//        if(txtItemShaftCode.val()===""){
//            handlersInput(txtItemShaftCode);
//        }else{
//            unHandlersInput(txtItemShaftCode);
//        }
//        if(txtItemShaftName.val()===""){
//            handlersInput(txtItemShaftName);
//        }else{
//            unHandlersInput(txtItemShaftName);
//        }
//    }
    
    function itemShaftFormatDate(){
        var inActiveDate=formatDate(dtpItemShaftInActiveDate.val(),true);
        dtpItemShaftInActiveDate.val(inActiveDate);
        $("#itemShaftTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemShaftCreatedDate.val(),true);
        dtpItemShaftCreatedDate.val(createdDate);
        $("#itemShaftTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemShaft" action="item-shaft-data" />
<b>Item Shaft</b>
<hr>
<br class="spacer"/>


<sj:div id="itemShaftButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemShaftNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemShaftUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemShaftDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemShaftRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemShaftPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemShaftSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemShaftSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemShaftSearchCode" name="itemShaftSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemShaftSearchName" name="itemShaftSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemShaftSearchActiveStatus" name="itemShaftSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemShaftSearchActiveStatusRad" name="itemShaftSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemShaft_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemShaftGrid">
    <sjg:grid
        id="itemShaft_grid"
        dataType="json"
        href="%{remoteurlItemShaft}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemShaftTemp"
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
    
<div id="itemShaftInput" class="content ui-widget">
    <s:form id="frmItemShaftInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemShaft.code" name="itemShaft.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemShaft.name" name="itemShaft.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemShaftActiveStatusRad" name="itemShaftActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemShaft.activeStatus" name="itemShaft.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemShaft.remark" name="itemShaft.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemShaft.inActiveBy"  name="itemShaft.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemShaft.inActiveDate" name="itemShaft.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemShaft.createdBy"  name="itemShaft.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemShaft.createdDate" name="itemShaft.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemShaftTemp.inActiveDateTemp" name="itemShaftTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemShaftTemp.createdDateTemp" name="itemShaftTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemShaftSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemShaftCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>