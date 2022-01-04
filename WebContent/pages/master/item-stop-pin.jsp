
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
        txtItemStopPinCode=$("#itemStopPin\\.code"),
        txtItemStopPinName=$("#itemStopPin\\.name"),
        rdbItemStopPinActiveStatus=$("#itemStopPin\\.activeStatus"),
        txtItemStopPinRemark=$("#itemStopPin\\.remark"),
        txtItemStopPinInActiveBy = $("#itemStopPin\\.inActiveBy"),
        dtpItemStopPinInActiveDate = $("#itemStopPin\\.inActiveDate"),
        txtItemStopPinCreatedBy = $("#itemStopPin\\.createdBy"),
        dtpItemStopPinCreatedDate = $("#itemStopPin\\.createdDate"),
        
        allFieldsItemStopPin=$([])
            .add(txtItemStopPinCode)
            .add(txtItemStopPinName)
            .add(txtItemStopPinRemark)
            .add(txtItemStopPinInActiveBy)
            .add(txtItemStopPinCreatedBy);


    function reloadGridItemStopPin(){
        $("#itemStopPin_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemStopPin");
        
        $('#itemStopPin\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemStopPinSearchActiveStatusRadActive').prop('checked',true);
        $("#itemStopPinSearchActiveStatus").val("true");
        
        $('input[name="itemStopPinSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemStopPinSearchActiveStatus").val(value);
        });
        
        $('input[name="itemStopPinSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemStopPinSearchActiveStatus").val(value);
        });
                
        $('input[name="itemStopPinSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemStopPinSearchActiveStatus").val(value);
        });
        
        $('input[name="itemStopPinActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemStopPin\\.activeStatus").val(value);
            $("#itemStopPin\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemStopPinActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemStopPin\\.activeStatus").val(value);
        });
        
        $("#btnItemStopPinNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-stop-pin-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemStopPin();
                showInput("itemStopPin");
                hideInput("itemStopPinSearch");
                $('#itemStopPinActiveStatusRadActive').prop('checked',true);
                $("#itemStopPin\\.activeStatus").val("true");
                $("#itemStopPin\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemStopPin\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemStopPinCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemStopPinCode.val("AUTO");
                txtItemStopPinCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemStopPinSave").click(function(ev) {
           if(!$("#frmItemStopPinInput").valid()) {
//               handlers_input_itemStopPin();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemStopPinFormatDate();
           if (updateRowId < 0){
               url = "master/item-stop-pin-save";
           } else{
               url = "master/item-stop-pin-update";
           }
           
           var params = $("#frmItemStopPinInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemStopPinFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemStopPin");
                showInput("itemStopPinSearch");
                allFieldsItemStopPin.val('').siblings('label[class="error"]').hide();
                txtItemStopPinCode.val("AUTO");
                reloadGridItemStopPin();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemStopPinUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-stop-pin-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemStopPin();
                updateRowId=$("#itemStopPin_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemStopPin=$("#itemStopPin_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-stop-pin-get-data";
                var params="itemStopPin.code=" + itemStopPin.code;

                txtItemStopPinCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemStopPinCode.val(data.itemStopPinTemp.code);
                        txtItemStopPinName.val(data.itemStopPinTemp.name);
                        rdbItemStopPinActiveStatus.val(data.itemStopPinTemp.activeStatus);
                        txtItemStopPinRemark.val(data.itemStopPinTemp.remark);
                        txtItemStopPinInActiveBy.val(data.itemStopPinTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemStopPinTemp.inActiveDate,true);
                        dtpItemStopPinInActiveDate.val(inActiveDate);
                        txtItemStopPinCreatedBy.val(data.itemStopPinTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemStopPinTemp.createdDate,true);
                        dtpItemStopPinCreatedDate.val(createdDate);

                        if(data.itemStopPinTemp.activeStatus===true) {
                           $('#itemStopPinActiveStatusRadActive').prop('checked',true);
                           $("#itemStopPin\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemStopPinActiveStatusRadInActive').prop('checked',true);              
                           $("#itemStopPin\\.activeStatus").val("false");
                        }

                        showInput("itemStopPin");
                        hideInput("itemStopPinSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemStopPinDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-stop-pin-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemStopPin_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemStopPin=$("#itemStopPin_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-stop-pin-delete";
                var params="itemStopPin.code=" + itemStopPin.code;
                var message="Are You Sure To Delete(Code : "+ itemStopPin.code + ")?";
                alertMessageDelete("itemStopPin",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemStopPin.code+ ')?</div>');
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
//                                var url="master/itemStopPin-delete";
//                                var params="itemStopPin.code=" + itemStopPin.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemStopPin();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemStopPin.code+ ")")){
//                    var url="master/itemStopPin-delete";
//                    var params="itemStopPin.code=" + itemStopPin.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemStopPin();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemStopPinCancel").click(function(ev) {
            hideInput("itemStopPin");
            showInput("itemStopPinSearch");
            allFieldsItemStopPin.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemStopPinRefresh').click(function(ev) {
            $('#itemStopPinSearchActiveStatusRadActive').prop('checked',true);
            $("#itemStopPinSearchActiveStatus").val("true");
            $("#itemStopPin_grid").jqGrid("clearGridData");
            $("#itemStopPin_grid").jqGrid("setGridParam",{url:"master/itemStopPin-data?"});
            $("#itemStopPin_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemStopPinPrint").click(function(ev) {
            
            var url = "reports/item-stop-pin-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemStopPin','width=500,height=500');
        });
        
        $('#btnItemStopPin_search').click(function(ev) {
            $("#itemStopPin_grid").jqGrid("clearGridData");
            $("#itemStopPin_grid").jqGrid("setGridParam",{url:"master/item-stop-pin-data?" + $("#frmItemStopPinSearchInput").serialize()});
            $("#itemStopPin_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemStopPin(){
//        unHandlersInput(txtItemStopPinCode);
//        unHandlersInput(txtItemStopPinName);
//    }
//
//    function handlers_input_itemStopPin(){
//        if(txtItemStopPinCode.val()===""){
//            handlersInput(txtItemStopPinCode);
//        }else{
//            unHandlersInput(txtItemStopPinCode);
//        }
//        if(txtItemStopPinName.val()===""){
//            handlersInput(txtItemStopPinName);
//        }else{
//            unHandlersInput(txtItemStopPinName);
//        }
//    }
    
    function itemStopPinFormatDate(){
        var inActiveDate=formatDate(dtpItemStopPinInActiveDate.val(),true);
        dtpItemStopPinInActiveDate.val(inActiveDate);
        $("#itemStopPinTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemStopPinCreatedDate.val(),true);
        dtpItemStopPinCreatedDate.val(createdDate);
        $("#itemStopPinTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemStopPin" action="item-stop-pin-data" />
<b>Item Stop Pin</b>
<hr>
<br class="spacer"/>


<sj:div id="itemStopPinButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemStopPinNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemStopPinUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemStopPinDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemStopPinRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemStopPinPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemStopPinSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemStopPinSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemStopPinSearchCode" name="itemStopPinSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemStopPinSearchName" name="itemStopPinSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemStopPinSearchActiveStatus" name="itemStopPinSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemStopPinSearchActiveStatusRad" name="itemStopPinSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemStopPin_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemStopPinGrid">
    <sjg:grid
        id="itemStopPin_grid"
        dataType="json"
        href="%{remoteurlItemStopPin}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemStopPinTemp"
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
    
<div id="itemStopPinInput" class="content ui-widget">
    <s:form id="frmItemStopPinInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemStopPin.code" name="itemStopPin.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemStopPin.name" name="itemStopPin.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemStopPinActiveStatusRad" name="itemStopPinActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemStopPin.activeStatus" name="itemStopPin.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemStopPin.remark" name="itemStopPin.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemStopPin.inActiveBy"  name="itemStopPin.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemStopPin.inActiveDate" name="itemStopPin.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemStopPin.createdBy"  name="itemStopPin.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemStopPin.createdDate" name="itemStopPin.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemStopPinTemp.inActiveDateTemp" name="itemStopPinTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemStopPinTemp.createdDateTemp" name="itemStopPinTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemStopPinSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemStopPinCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>