
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
        txtItemBodyCode=$("#itemBody\\.code"),
        txtItemBodyName=$("#itemBody\\.name"),
        rdbItemBodyActiveStatus=$("#itemBody\\.activeStatus"),
        txtItemBodyRemark=$("#itemBody\\.remark"),
        txtItemBodyInActiveBy = $("#itemBody\\.inActiveBy"),
        dtpItemBodyInActiveDate = $("#itemBody\\.inActiveDate"),
        txtItemBodyCreatedBy = $("#itemBody\\.createdBy"),
        dtpItemBodyCreatedDate = $("#itemBody\\.createdDate"),
        
        allFieldsItemBody=$([])
            .add(txtItemBodyCode)
            .add(txtItemBodyName)
            .add(txtItemBodyRemark)
            .add(txtItemBodyInActiveBy)
            .add(txtItemBodyCreatedBy);


    function reloadGridItemBody(){
        $("#itemBody_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBody");
        
        $('#itemBody\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBodySearchActiveStatusRadActive').prop('checked',true);
        $("#itemBodySearchActiveStatus").val("true");
        
        $('input[name="itemBodySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBodySearchActiveStatus").val(value);
        });
        
        $('input[name="itemBodySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBodySearchActiveStatus").val(value);
        });
                
        $('input[name="itemBodySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBodySearchActiveStatus").val(value);
        });
        
        $('input[name="itemBodyActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBody\\.activeStatus").val(value);
            $("#itemBody\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBodyActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBody\\.activeStatus").val(value);
        });
        
        $("#btnItemBodyNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-body-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBody();
                showInput("itemBody");
                hideInput("itemBodySearch");
                $('#itemBodyActiveStatusRadActive').prop('checked',true);
                $("#itemBody\\.activeStatus").val("true");
                $("#itemBody\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBody\\.createdDate").val("01/01/1900 00:00:00");
                txtItemBodyCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBodyCode.attr("readonly",true);
                txtItemBodyCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBodySave").click(function(ev) {
           if(!$("#frmItemBodyInput").valid()) {
//               handlers_input_itemBody();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBodyFormatDate();
           if (updateRowId < 0){
               url = "master/item-body-save";
           } else{
               url = "master/item-body-update";
           }
           
           var params = $("#frmItemBodyInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBodyFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBody");
                showInput("itemBodySearch");
                allFieldsItemBody.val('').siblings('label[class="error"]').hide();
                txtItemBodyCode.val("AUTO");
                reloadGridItemBody();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBodyUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-body-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBody();
                updateRowId=$("#itemBody_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBody=$("#itemBody_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-body-get-data";
                var params="itemBody.code=" + itemBody.code;

                txtItemBodyCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBodyCode.val(data.itemBodyTemp.code);
                        txtItemBodyName.val(data.itemBodyTemp.name);
                        rdbItemBodyActiveStatus.val(data.itemBodyTemp.activeStatus);
                        txtItemBodyRemark.val(data.itemBodyTemp.remark);
                        txtItemBodyInActiveBy.val(data.itemBodyTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBodyTemp.inActiveDate,true);
                        dtpItemBodyInActiveDate.val(inActiveDate);
                        txtItemBodyCreatedBy.val(data.itemBodyTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBodyTemp.createdDate,true);
                        dtpItemBodyCreatedDate.val(createdDate);

                        if(data.itemBodyTemp.activeStatus===true) {
                           $('#itemBodyActiveStatusRadActive').prop('checked',true);
                           $("#itemBody\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBodyActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBody\\.activeStatus").val("false");
                        }

                        showInput("itemBody");
                        hideInput("itemBodySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBodyDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-body-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBody_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBody=$("#itemBody_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-body-delete";
                var params="itemBody.code=" + itemBody.code;
                var message="Are You Sure To Delete(Code : "+ itemBody.code + ")?";
                alertMessageDelete("itemBody",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBody.code+ ')?</div>');
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
//                                var url="master/item-body-delete";
//                                var params="itemBody.code=" + itemBody.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBody();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBody.code+ ")")){
//                    var url="master/item-body-delete";
//                    var params="itemBody.code=" + itemBody.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBody();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBodyCancel").click(function(ev) {
            hideInput("itemBody");
            showInput("itemBodySearch");
            allFieldsItemBody.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBodyRefresh').click(function(ev) {
            $('#itemBodySearchActiveStatusRadActive').prop('checked',true);
            $("#itemBodySearchActiveStatus").val("true");
            $("#itemBody_grid").jqGrid("clearGridData");
            $("#itemBody_grid").jqGrid("setGridParam",{url:"master/item-body-data?"});
            $("#itemBody_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBodyPrint").click(function(ev) {
            
            var url = "reports/item-body-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBody','width=500,height=500');
        });
        
        $('#btnItemBody_search').click(function(ev) {
            $("#itemBody_grid").jqGrid("clearGridData");
            $("#itemBody_grid").jqGrid("setGridParam",{url:"master/item-body-data?" + $("#frmItemBodySearchInput").serialize()});
            $("#itemBody_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBody(){
//        unHandlersInput(txtItemBodyCode);
//        unHandlersInput(txtItemBodyName);
//    }
//
//    function handlers_input_itemBody(){
//        if(txtItemBodyCode.val()===""){
//            handlersInput(txtItemBodyCode);
//        }else{
//            unHandlersInput(txtItemBodyCode);
//        }
//        if(txtItemBodyName.val()===""){
//            handlersInput(txtItemBodyName);
//        }else{
//            unHandlersInput(txtItemBodyName);
//        }
//    }
    
    function itemBodyFormatDate(){
        var inActiveDate=formatDate(dtpItemBodyInActiveDate.val(),true);
        dtpItemBodyInActiveDate.val(inActiveDate);
        $("#itemBodyTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBodyCreatedDate.val(),true);
        dtpItemBodyCreatedDate.val(createdDate);
        $("#itemBodyTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBody" action="item-body-data" />
<b>Item Body</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBodyButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBodyNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBodyUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBodyDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBodyRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBodyPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBodySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBodySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBodySearchCode" name="itemBodySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBodySearchName" name="itemBodySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBodySearchActiveStatus" name="itemBodySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBodySearchActiveStatusRad" name="itemBodySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBody_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBodyGrid">
    <sjg:grid
        id="itemBody_grid"
        dataType="json"
        href="%{remoteurlItemBody}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBodyTemp"
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
    
<div id="itemBodyInput" class="content ui-widget">
    <s:form id="frmItemBodyInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBody.code" name="itemBody.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBody.name" name="itemBody.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBodyActiveStatusRad" name="itemBodyActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBody.activeStatus" name="itemBody.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBody.remark" name="itemBody.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBody.inActiveBy"  name="itemBody.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemBody.inActiveDate" name="itemBody.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBody.createdBy"  name="itemBody.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBody.createdDate" name="itemBody.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBodyTemp.inActiveDateTemp" name="itemBodyTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBodyTemp.createdDateTemp" name="itemBodyTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBodySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBodyCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>