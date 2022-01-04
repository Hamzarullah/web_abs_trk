
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
        txtItemEndConCode=$("#itemEndCon\\.code"),
        txtItemEndConName=$("#itemEndCon\\.name"),
        rdbItemEndConActiveStatus=$("#itemEndCon\\.activeStatus"),
        txtItemEndConRemark=$("#itemEndCon\\.remark"),
        txtItemEndConInActiveBy = $("#itemEndCon\\.inActiveBy"),
        dtpItemEndConInActiveDate = $("#itemEndCon\\.inActiveDate"),
        txtItemEndConCreatedBy = $("#itemEndCon\\.createdBy"),
        dtpItemEndConCreatedDate = $("#itemEndCon\\.createdDate"),
        
        allFieldsItemEndCon=$([])
            .add(txtItemEndConCode)
            .add(txtItemEndConName)
            .add(txtItemEndConRemark)
            .add(txtItemEndConInActiveBy)
            .add(txtItemEndConCreatedBy);


    function reloadGridItemEndCon(){
        $("#itemEndCon_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemEndCon");
        
        $('#itemEndCon\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemEndConSearchActiveStatusRadActive').prop('checked',true);
        $("#itemEndConSearchActiveStatus").val("true");
        
        $('input[name="itemEndConSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemEndConSearchActiveStatus").val(value);
        });
        
        $('input[name="itemEndConSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemEndConSearchActiveStatus").val(value);
        });
                
        $('input[name="itemEndConSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemEndConSearchActiveStatus").val(value);
        });
        
        $('input[name="itemEndConActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemEndCon\\.activeStatus").val(value);
            $("#itemEndCon\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemEndConActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemEndCon\\.activeStatus").val(value);
        });
        
        $("#btnItemEndConNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-end-con-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemEndCon();
                showInput("itemEndCon");
                hideInput("itemEndConSearch");
                $('#itemEndConActiveStatusRadActive').prop('checked',true);
                $("#itemEndCon\\.activeStatus").val("true");
                $("#itemEndCon\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemEndCon\\.createdDate").val("01/01/1900 00:00:00");
                txtItemEndConCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemEndConCode.attr("readonly",true);
                txtItemEndConCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemEndConSave").click(function(ev) {
           if(!$("#frmItemEndConInput").valid()) {
//               handlers_input_itemEndCon();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemEndConFormatDate();
           if (updateRowId < 0){
               url = "master/item-end-con-save";
           } else{
               url = "master/item-end-con-update";
           }
           
           var params = $("#frmItemEndConInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemEndConFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemEndCon");
                showInput("itemEndConSearch");
                allFieldsItemEndCon.val('').siblings('label[class="error"]').hide();
                txtItemEndConCode.val("AUTO");
                reloadGridItemEndCon();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemEndConUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-end-con-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemEndCon();
                updateRowId=$("#itemEndCon_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemEndCon=$("#itemEndCon_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-end-con-get-data";
                var params="itemEndCon.code=" + itemEndCon.code;

                txtItemEndConCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemEndConCode.val(data.itemEndConTemp.code);
                        txtItemEndConName.val(data.itemEndConTemp.name);
                        rdbItemEndConActiveStatus.val(data.itemEndConTemp.activeStatus);
                        txtItemEndConRemark.val(data.itemEndConTemp.remark);
                        txtItemEndConInActiveBy.val(data.itemEndConTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemEndConTemp.inActiveDate,true);
                        dtpItemEndConInActiveDate.val(inActiveDate);
                        txtItemEndConCreatedBy.val(data.itemEndConTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemEndConTemp.createdDate,true);
                        dtpItemEndConCreatedDate.val(createdDate);

                        if(data.itemEndConTemp.activeStatus===true) {
                           $('#itemEndConActiveStatusRadActive').prop('checked',true);
                           $("#itemEndCon\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemEndConActiveStatusRadInActive').prop('checked',true);              
                           $("#itemEndCon\\.activeStatus").val("false");
                        }

                        showInput("itemEndCon");
                        hideInput("itemEndConSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemEndConDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-end-con-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemEndCon_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemEndCon=$("#itemEndCon_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-end-con-delete";
                var params="itemEndCon.code=" + itemEndCon.code;
                var message="Are You Sure To Delete(Code : "+ itemEndCon.code + ")?";
                alertMessageDelete("itemEndCon",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemEndCon.code+ ')?</div>');
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
//                                var url="master/item-end-con-delete";
//                                var params="itemEndCon.code=" + itemEndCon.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemEndCon();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemEndCon.code+ ")")){
//                    var url="master/item-end-con-delete";
//                    var params="itemEndCon.code=" + itemEndCon.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemEndCon();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemEndConCancel").click(function(ev) {
            hideInput("itemEndCon");
            showInput("itemEndConSearch");
            allFieldsItemEndCon.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemEndConRefresh').click(function(ev) {
            $('#itemEndConSearchActiveStatusRadActive').prop('checked',true);
            $("#itemEndConSearchActiveStatus").val("true");
            $("#itemEndCon_grid").jqGrid("clearGridData");
            $("#itemEndCon_grid").jqGrid("setGridParam",{url:"master/item-end-con-data?"});
            $("#itemEndCon_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemEndConPrint").click(function(ev) {
            
            var url = "reports/item-end-con-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemEndCon','width=500,height=500');
        });
        
        $('#btnItemEndCon_search').click(function(ev) {
            $("#itemEndCon_grid").jqGrid("clearGridData");
            $("#itemEndCon_grid").jqGrid("setGridParam",{url:"master/item-end-con-data?" + $("#frmItemEndConSearchInput").serialize()});
            $("#itemEndCon_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemEndCon(){
//        unHandlersInput(txtItemEndConCode);
//        unHandlersInput(txtItemEndConName);
//    }
//
//    function handlers_input_itemEndCon(){
//        if(txtItemEndConCode.val()===""){
//            handlersInput(txtItemEndConCode);
//        }else{
//            unHandlersInput(txtItemEndConCode);
//        }
//        if(txtItemEndConName.val()===""){
//            handlersInput(txtItemEndConName);
//        }else{
//            unHandlersInput(txtItemEndConName);
//        }
//    }
    
    function itemEndConFormatDate(){
        var inActiveDate=formatDate(dtpItemEndConInActiveDate.val(),true);
        dtpItemEndConInActiveDate.val(inActiveDate);
        $("#itemEndConTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemEndConCreatedDate.val(),true);
        dtpItemEndConCreatedDate.val(createdDate);
        $("#itemEndConTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemEndCon" action="item-end-con-data" />
<b>Item End Con</b>
<hr>
<br class="spacer"/>


<sj:div id="itemEndConButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemEndConNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemEndConUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemEndConDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemEndConRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemEndConPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemEndConSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemEndConSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemEndConSearchCode" name="itemEndConSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemEndConSearchName" name="itemEndConSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemEndConSearchActiveStatus" name="itemEndConSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemEndConSearchActiveStatusRad" name="itemEndConSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemEndCon_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemEndConGrid">
    <sjg:grid
        id="itemEndCon_grid"
        dataType="json"
        href="%{remoteurlItemEndCon}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemEndConTemp"
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
    
<div id="itemEndConInput" class="content ui-widget">
    <s:form id="frmItemEndConInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemEndCon.code" name="itemEndCon.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemEndCon.name" name="itemEndCon.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemEndConActiveStatusRad" name="itemEndConActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemEndCon.activeStatus" name="itemEndCon.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemEndCon.remark" name="itemEndCon.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemEndCon.inActiveBy"  name="itemEndCon.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemEndCon.inActiveDate" name="itemEndCon.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemEndCon.createdBy"  name="itemEndCon.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemEndCon.createdDate" name="itemEndCon.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemEndConTemp.inActiveDateTemp" name="itemEndConTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemEndConTemp.createdDateTemp" name="itemEndConTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemEndConSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemEndConCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>