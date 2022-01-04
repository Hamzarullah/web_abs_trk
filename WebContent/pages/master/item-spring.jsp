
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
        txtItemSpringCode=$("#itemSpring\\.code"),
        txtItemSpringName=$("#itemSpring\\.name"),
        rdbItemSpringActiveStatus=$("#itemSpring\\.activeStatus"),
        txtItemSpringRemark=$("#itemSpring\\.remark"),
        txtItemSpringInActiveBy = $("#itemSpring\\.inActiveBy"),
        dtpItemSpringInActiveDate = $("#itemSpring\\.inActiveDate"),
        txtItemSpringCreatedBy = $("#itemSpring\\.createdBy"),
        dtpItemSpringCreatedDate = $("#itemSpring\\.createdDate"),
        
        allFieldsItemSpring=$([])
            .add(txtItemSpringCode)
            .add(txtItemSpringName)
            .add(txtItemSpringRemark)
            .add(txtItemSpringInActiveBy)
            .add(txtItemSpringCreatedBy);


    function reloadGridItemSpring(){
        $("#itemSpring_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSpring");
        
        $('#itemSpring\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSpringSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSpringSearchActiveStatus").val("true");
        
        $('input[name="itemSpringSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSpringSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSpringSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSpringSearchActiveStatus").val(value);
        });
                
        $('input[name="itemSpringSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSpringSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSpringActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSpring\\.activeStatus").val(value);
            $("#itemSpring\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSpringActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSpring\\.activeStatus").val(value);
        });
        
        $("#btnItemSpringNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-spring-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSpring();
                showInput("itemSpring");
                hideInput("itemSpringSearch");
                $('#itemSpringActiveStatusRadActive').prop('checked',true);
                $("#itemSpring\\.activeStatus").val("true");
                $("#itemSpring\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSpring\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemSpringCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSpringCode.val("AUTO");
                txtItemSpringCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSpringSave").click(function(ev) {
           if(!$("#frmItemSpringInput").valid()) {
//               handlers_input_itemSpring();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemSpringFormatDate();
           if (updateRowId < 0){
               url = "master/item-spring-save";
           } else{
               url = "master/item-spring-update";
           }
           
           var params = $("#frmItemSpringInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSpringFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSpring");
                showInput("itemSpringSearch");
                allFieldsItemSpring.val('').siblings('label[class="error"]').hide();
                txtItemSpringCode.val("AUTO");
                reloadGridItemSpring();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSpringUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-spring-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSpring();
                updateRowId=$("#itemSpring_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSpring=$("#itemSpring_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-spring-get-data";
                var params="itemSpring.code=" + itemSpring.code;

                txtItemSpringCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSpringCode.val(data.itemSpringTemp.code);
                        txtItemSpringName.val(data.itemSpringTemp.name);
                        rdbItemSpringActiveStatus.val(data.itemSpringTemp.activeStatus);
                        txtItemSpringRemark.val(data.itemSpringTemp.remark);
                        txtItemSpringInActiveBy.val(data.itemSpringTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSpringTemp.inActiveDate,true);
                        dtpItemSpringInActiveDate.val(inActiveDate);
                        txtItemSpringCreatedBy.val(data.itemSpringTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSpringTemp.createdDate,true);
                        dtpItemSpringCreatedDate.val(createdDate);

                        if(data.itemSpringTemp.activeStatus===true) {
                           $('#itemSpringActiveStatusRadActive').prop('checked',true);
                           $("#itemSpring\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSpringActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSpring\\.activeStatus").val("false");
                        }

                        showInput("itemSpring");
                        hideInput("itemSpringSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSpringDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-spring-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSpring_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSpring=$("#itemSpring_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-spring-delete";
                var params="itemSpring.code=" + itemSpring.code;
                var message="Are You Sure To Delete(Code : "+ itemSpring.code + ")?";
                alertMessageDelete("itemSpring",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSpring.code+ ')?</div>');
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
//                                var url="master/itemSpring-delete";
//                                var params="itemSpring.code=" + itemSpring.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSpring();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSpring.code+ ")")){
//                    var url="master/itemSpring-delete";
//                    var params="itemSpring.code=" + itemSpring.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSpring();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSpringCancel").click(function(ev) {
            hideInput("itemSpring");
            showInput("itemSpringSearch");
            allFieldsItemSpring.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSpringRefresh').click(function(ev) {
            $('#itemSpringSearchActiveStatusRadActive').prop('checked',true);
            $("#itemSpringSearchActiveStatus").val("true");
            $("#itemSpring_grid").jqGrid("clearGridData");
            $("#itemSpring_grid").jqGrid("setGridParam",{url:"master/itemSpring-data?"});
            $("#itemSpring_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSpringPrint").click(function(ev) {
            
            var url = "reports/item-spring-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSpring','width=500,height=500');
        });
        
        $('#btnItemSpring_search').click(function(ev) {
            $("#itemSpring_grid").jqGrid("clearGridData");
            $("#itemSpring_grid").jqGrid("setGridParam",{url:"master/item-spring-data?" + $("#frmItemSpringSearchInput").serialize()});
            $("#itemSpring_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSpring(){
//        unHandlersInput(txtItemSpringCode);
//        unHandlersInput(txtItemSpringName);
//    }
//
//    function handlers_input_itemSpring(){
//        if(txtItemSpringCode.val()===""){
//            handlersInput(txtItemSpringCode);
//        }else{
//            unHandlersInput(txtItemSpringCode);
//        }
//        if(txtItemSpringName.val()===""){
//            handlersInput(txtItemSpringName);
//        }else{
//            unHandlersInput(txtItemSpringName);
//        }
//    }
    
    function itemSpringFormatDate(){
        var inActiveDate=formatDate(dtpItemSpringInActiveDate.val(),true);
        dtpItemSpringInActiveDate.val(inActiveDate);
        $("#itemSpringTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSpringCreatedDate.val(),true);
        dtpItemSpringCreatedDate.val(createdDate);
        $("#itemSpringTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSpring" action="item-spring-data" />
<b>Item Spring</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSpringButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSpringNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSpringUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSpringDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSpringRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSpringPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSpringSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSpringSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSpringSearchCode" name="itemSpringSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSpringSearchName" name="itemSpringSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSpringSearchActiveStatus" name="itemSpringSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSpringSearchActiveStatusRad" name="itemSpringSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSpring_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSpringGrid">
    <sjg:grid
        id="itemSpring_grid"
        dataType="json"
        href="%{remoteurlItemSpring}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSpringTemp"
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
    
<div id="itemSpringInput" class="content ui-widget">
    <s:form id="frmItemSpringInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSpring.code" name="itemSpring.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSpring.name" name="itemSpring.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSpringActiveStatusRad" name="itemSpringActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSpring.activeStatus" name="itemSpring.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSpring.remark" name="itemSpring.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSpring.inActiveBy"  name="itemSpring.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSpring.inActiveDate" name="itemSpring.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSpring.createdBy"  name="itemSpring.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSpring.createdDate" name="itemSpring.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSpringTemp.inActiveDateTemp" name="itemSpringTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSpringTemp.createdDateTemp" name="itemSpringTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSpringSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSpringCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>