
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
        txtItemSeatInsertCode=$("#itemSeatInsert\\.code"),
        txtItemSeatInsertName=$("#itemSeatInsert\\.name"),
        rdbItemSeatInsertActiveStatus=$("#itemSeatInsert\\.activeStatus"),
        txtItemSeatInsertRemark=$("#itemSeatInsert\\.remark"),
        txtItemSeatInsertInActiveBy = $("#itemSeatInsert\\.inActiveBy"),
        dtpItemSeatInsertInActiveDate = $("#itemSeatInsert\\.inActiveDate"),
        txtItemSeatInsertCreatedBy = $("#itemSeatInsert\\.createdBy"),
        dtpItemSeatInsertCreatedDate = $("#itemSeatInsert\\.createdDate"),
        
        allFieldsItemSeatInsert=$([])
            .add(txtItemSeatInsertCode)
            .add(txtItemSeatInsertName)
            .add(txtItemSeatInsertRemark)
            .add(txtItemSeatInsertInActiveBy)
            .add(txtItemSeatInsertCreatedBy);


    function reloadGridItemSeatInsert(){
        $("#itemSeatInsert_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSeatInsert");
        
        $('#itemSeatInsert\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSeatInsertSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSeatInsertSearchActiveStatus").val("true");
        
        $('input[name="itemSeatInsertSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSeatInsertSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSeatInsertSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeatInsertSearchActiveStatus").val(value);
        });
                
        $('input[name="itemSeatInsertSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeatInsertSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSeatInsertActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeatInsert\\.activeStatus").val(value);
            $("#itemSeatInsert\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSeatInsertActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeatInsert\\.activeStatus").val(value);
        });
        
        $("#btnItemSeatInsertNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-insert-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeatInsert();
                showInput("itemSeatInsert");
                hideInput("itemSeatInsertSearch");
                $('#itemSeatInsertActiveStatusRadActive').prop('checked',true);
                $("#itemSeatInsert\\.activeStatus").val("true");
                $("#itemSeatInsert\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSeatInsert\\.createdDate").val("01/01/1900 00:00:00");
                txtItemSeatInsertCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSeatInsertCode.attr("readonly",true);
                txtItemSeatInsertCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSeatInsertSave").click(function(ev) {
           if(!$("#frmItemSeatInsertInput").valid()) {
//               handlers_input_itemSeatInsert();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemSeatInsertFormatDate();
           if (updateRowId < 0){
               url = "master/item-seat-insert-save";
           } else{
               url = "master/item-seat-insert-update";
           }
           
           var params = $("#frmItemSeatInsertInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSeatInsertFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSeatInsert");
                showInput("itemSeatInsertSearch");
                allFieldsItemSeatInsert.val('').siblings('label[class="error"]').hide();
                txtItemSeatInsertCode.val("AUTO");
                reloadGridItemSeatInsert();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSeatInsertUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-insert-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeatInsert();
                updateRowId=$("#itemSeatInsert_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSeatInsert=$("#itemSeatInsert_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-seat-insert-get-data";
                var params="itemSeatInsert.code=" + itemSeatInsert.code;

                txtItemSeatInsertCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSeatInsertCode.val(data.itemSeatInsertTemp.code);
                        txtItemSeatInsertName.val(data.itemSeatInsertTemp.name);
                        rdbItemSeatInsertActiveStatus.val(data.itemSeatInsertTemp.activeStatus);
                        txtItemSeatInsertRemark.val(data.itemSeatInsertTemp.remark);
                        txtItemSeatInsertInActiveBy.val(data.itemSeatInsertTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSeatInsertTemp.inActiveDate,true);
                        dtpItemSeatInsertInActiveDate.val(inActiveDate);
                        txtItemSeatInsertCreatedBy.val(data.itemSeatInsertTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSeatInsertTemp.createdDate,true);
                        dtpItemSeatInsertCreatedDate.val(createdDate);

                        if(data.itemSeatInsertTemp.activeStatus===true) {
                           $('#itemSeatInsertActiveStatusRadActive').prop('checked',true);
                           $("#itemSeatInsert\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSeatInsertActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSeatInsert\\.activeStatus").val("false");
                        }

                        showInput("itemSeatInsert");
                        hideInput("itemSeatInsertSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSeatInsertDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-insert-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSeatInsert_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSeatInsert=$("#itemSeatInsert_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-seat-insert-delete";
                var params="itemSeatInsert.code=" + itemSeatInsert.code;
                var message="Are You Sure To Delete(Code : "+ itemSeatInsert.code + ")?";
                alertMessageDelete("itemSeatInsert",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSeatInsert.code+ ')?</div>');
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
//                                var url="master/item-seat-insert-delete";
//                                var params="itemSeatInsert.code=" + itemSeatInsert.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSeatInsert();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSeatInsert.code+ ")")){
//                    var url="master/item-seat-insert-delete";
//                    var params="itemSeatInsert.code=" + itemSeatInsert.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSeatInsert();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSeatInsertCancel").click(function(ev) {
            hideInput("itemSeatInsert");
            showInput("itemSeatInsertSearch");
            allFieldsItemSeatInsert.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSeatInsertRefresh').click(function(ev) {
            $('#itemSeatInsertSearchActiveStatusRadActive').prop('checked',true);
            $("#itemSeatInsertSearchActiveStatus").val("true");
            $("#itemSeatInsert_grid").jqGrid("clearGridData");
            $("#itemSeatInsert_grid").jqGrid("setGridParam",{url:"master/item-seat-insert-data?"});
            $("#itemSeatInsert_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSeatInsertPrint").click(function(ev) {
            
            var url = "reports/item-seat-insert-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSeatInsert','width=500,height=500');
        });
        
        $('#btnItemSeatInsert_search').click(function(ev) {
            $("#itemSeatInsert_grid").jqGrid("clearGridData");
            $("#itemSeatInsert_grid").jqGrid("setGridParam",{url:"master/item-seat-insert-data?" + $("#frmItemSeatInsertSearchInput").serialize()});
            $("#itemSeatInsert_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSeatInsert(){
//        unHandlersInput(txtItemSeatInsertCode);
//        unHandlersInput(txtItemSeatInsertName);
//    }
//
//    function handlers_input_itemSeatInsert(){
//        if(txtItemSeatInsertCode.val()===""){
//            handlersInput(txtItemSeatInsertCode);
//        }else{
//            unHandlersInput(txtItemSeatInsertCode);
//        }
//        if(txtItemSeatInsertName.val()===""){
//            handlersInput(txtItemSeatInsertName);
//        }else{
//            unHandlersInput(txtItemSeatInsertName);
//        }
//    }
    
    function itemSeatInsertFormatDate(){
        var inActiveDate=formatDate(dtpItemSeatInsertInActiveDate.val(),true);
        dtpItemSeatInsertInActiveDate.val(inActiveDate);
        $("#itemSeatInsertTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSeatInsertCreatedDate.val(),true);
        dtpItemSeatInsertCreatedDate.val(createdDate);
        $("#itemSeatInsertTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSeatInsert" action="item-seat-insert-data" />
<b>Item Seat Insert</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSeatInsertButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSeatInsertNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSeatInsertUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSeatInsertDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSeatInsertRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSeatInsertPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSeatInsertSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSeatInsertSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSeatInsertSearchCode" name="itemSeatInsertSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSeatInsertSearchName" name="itemSeatInsertSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSeatInsertSearchActiveStatus" name="itemSeatInsertSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSeatInsertSearchActiveStatusRad" name="itemSeatInsertSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSeatInsert_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSeatInsertGrid">
    <sjg:grid
        id="itemSeatInsert_grid"
        dataType="json"
        href="%{remoteurlItemSeatInsert}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSeatInsertTemp"
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
    
<div id="itemSeatInsertInput" class="content ui-widget">
    <s:form id="frmItemSeatInsertInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSeatInsert.code" name="itemSeatInsert.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSeatInsert.name" name="itemSeatInsert.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSeatInsertActiveStatusRad" name="itemSeatInsertActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSeatInsert.activeStatus" name="itemSeatInsert.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSeatInsert.remark" name="itemSeatInsert.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSeatInsert.inActiveBy"  name="itemSeatInsert.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSeatInsert.inActiveDate" name="itemSeatInsert.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeatInsert.createdBy"  name="itemSeatInsert.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSeatInsert.createdDate" name="itemSeatInsert.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeatInsertTemp.inActiveDateTemp" name="itemSeatInsertTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSeatInsertTemp.createdDateTemp" name="itemSeatInsertTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSeatInsertSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSeatInsertCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>