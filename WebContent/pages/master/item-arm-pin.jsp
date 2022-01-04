
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
        txtItemArmPinCode=$("#itemArmPin\\.code"),
        txtItemArmPinName=$("#itemArmPin\\.name"),
        rdbItemArmPinActiveStatus=$("#itemArmPin\\.activeStatus"),
        txtItemArmPinRemark=$("#itemArmPin\\.remark"),
        txtItemArmPinInActiveBy = $("#itemArmPin\\.inActiveBy"),
        dtpItemArmPinInActiveDate = $("#itemArmPin\\.inActiveDate"),
        txtItemArmPinCreatedBy = $("#itemArmPin\\.createdBy"),
        dtpItemArmPinCreatedDate = $("#itemArmPin\\.createdDate"),
        
        allFieldsItemArmPin=$([])
            .add(txtItemArmPinCode)
            .add(txtItemArmPinName)
            .add(txtItemArmPinRemark)
            .add(txtItemArmPinInActiveBy)
            .add(txtItemArmPinCreatedBy);


    function reloadGridItemArmPin(){
        $("#itemArmPin_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemArmPin");
        
        $('#itemArmPin\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemArmPinSearchActiveStatusRadActive').prop('checked',true);
        $("#itemArmPinSearchActiveStatus").val("true");
        
        $('input[name="itemArmPinSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemArmPinSearchActiveStatus").val(value);
        });
        
        $('input[name="itemArmPinSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemArmPinSearchActiveStatus").val(value);
        });
                
        $('input[name="itemArmPinSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemArmPinSearchActiveStatus").val(value);
        });
        
        $('input[name="itemArmPinActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemArmPin\\.activeStatus").val(value);
            $("#itemArmPin\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemArmPinActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemArmPin\\.activeStatus").val(value);
        });
        
        $("#btnItemArmPinNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-arm-pin-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemArmPin();
                showInput("itemArmPin");
                hideInput("itemArmPinSearch");
                $('#itemArmPinActiveStatusRadActive').prop('checked',true);
                $("#itemArmPin\\.activeStatus").val("true");
                $("#itemArmPin\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemArmPin\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemArmPinCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemArmPinCode.val("AUTO");
                txtItemArmPinCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemArmPinSave").click(function(ev) {
           if(!$("#frmItemArmPinInput").valid()) {
//               handlers_input_itemArmPin();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemArmPinFormatDate();
           if (updateRowId < 0){
               url = "master/item-arm-pin-save";
           } else{
               url = "master/item-arm-pin-update";
           }
           
           var params = $("#frmItemArmPinInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemArmPinFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemArmPin");
                showInput("itemArmPinSearch");
                allFieldsItemArmPin.val('').siblings('label[class="error"]').hide();
                txtItemArmPinCode.val("AUTO");
                reloadGridItemArmPin();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemArmPinUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-arm-pin-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemArmPin();
                updateRowId=$("#itemArmPin_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemArmPin=$("#itemArmPin_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-arm-pin-get-data";
                var params="itemArmPin.code=" + itemArmPin.code;

                txtItemArmPinCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemArmPinCode.val(data.itemArmPinTemp.code);
                        txtItemArmPinName.val(data.itemArmPinTemp.name);
                        rdbItemArmPinActiveStatus.val(data.itemArmPinTemp.activeStatus);
                        txtItemArmPinRemark.val(data.itemArmPinTemp.remark);
                        txtItemArmPinInActiveBy.val(data.itemArmPinTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemArmPinTemp.inActiveDate,true);
                        dtpItemArmPinInActiveDate.val(inActiveDate);
                        txtItemArmPinCreatedBy.val(data.itemArmPinTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemArmPinTemp.createdDate,true);
                        dtpItemArmPinCreatedDate.val(createdDate);

                        if(data.itemArmPinTemp.activeStatus===true) {
                           $('#itemArmPinActiveStatusRadActive').prop('checked',true);
                           $("#itemArmPin\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemArmPinActiveStatusRadInActive').prop('checked',true);              
                           $("#itemArmPin\\.activeStatus").val("false");
                        }

                        showInput("itemArmPin");
                        hideInput("itemArmPinSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemArmPinDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-arm-pin-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemArmPin_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemArmPin=$("#itemArmPin_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-arm-pin-delete";
                var params="itemArmPin.code=" + itemArmPin.code;
                var message="Are You Sure To Delete(Code : "+ itemArmPin.code + ")?";
                alertMessageDelete("itemArmPin",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemArmPin.code+ ')?</div>');
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
//                                var url="master/itemArmPin-delete";
//                                var params="itemArmPin.code=" + itemArmPin.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemArmPin();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemArmPin.code+ ")")){
//                    var url="master/itemArmPin-delete";
//                    var params="itemArmPin.code=" + itemArmPin.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemArmPin();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemArmPinCancel").click(function(ev) {
            hideInput("itemArmPin");
            showInput("itemArmPinSearch");
            allFieldsItemArmPin.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemArmPinRefresh').click(function(ev) {
            $('#itemArmPinSearchActiveStatusRadActive').prop('checked',true);
            $("#itemArmPinSearchActiveStatus").val("true");
            $("#itemArmPin_grid").jqGrid("clearGridData");
            $("#itemArmPin_grid").jqGrid("setGridParam",{url:"master/itemArmPin-data?"});
            $("#itemArmPin_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemArmPinPrint").click(function(ev) {
            
            var url = "reports/item-arm-pin-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemArmPin','width=500,height=500');
        });
        
        $('#btnItemArmPin_search').click(function(ev) {
            $("#itemArmPin_grid").jqGrid("clearGridData");
            $("#itemArmPin_grid").jqGrid("setGridParam",{url:"master/item-arm-pin-data?" + $("#frmItemArmPinSearchInput").serialize()});
            $("#itemArmPin_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemArmPin(){
//        unHandlersInput(txtItemArmPinCode);
//        unHandlersInput(txtItemArmPinName);
//    }
//
//    function handlers_input_itemArmPin(){
//        if(txtItemArmPinCode.val()===""){
//            handlersInput(txtItemArmPinCode);
//        }else{
//            unHandlersInput(txtItemArmPinCode);
//        }
//        if(txtItemArmPinName.val()===""){
//            handlersInput(txtItemArmPinName);
//        }else{
//            unHandlersInput(txtItemArmPinName);
//        }
//    }
    
    function itemArmPinFormatDate(){
        var inActiveDate=formatDate(dtpItemArmPinInActiveDate.val(),true);
        dtpItemArmPinInActiveDate.val(inActiveDate);
        $("#itemArmPinTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemArmPinCreatedDate.val(),true);
        dtpItemArmPinCreatedDate.val(createdDate);
        $("#itemArmPinTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemArmPin" action="item-arm-pin-data" />
<b>Item Arm Pin</b>
<hr>
<br class="spacer"/>


<sj:div id="itemArmPinButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemArmPinNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemArmPinUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemArmPinDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemArmPinRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemArmPinPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemArmPinSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemArmPinSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemArmPinSearchCode" name="itemArmPinSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemArmPinSearchName" name="itemArmPinSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemArmPinSearchActiveStatus" name="itemArmPinSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemArmPinSearchActiveStatusRad" name="itemArmPinSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemArmPin_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemArmPinGrid">
    <sjg:grid
        id="itemArmPin_grid"
        dataType="json"
        href="%{remoteurlItemArmPin}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemArmPinTemp"
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
    
<div id="itemArmPinInput" class="content ui-widget">
    <s:form id="frmItemArmPinInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemArmPin.code" name="itemArmPin.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemArmPin.name" name="itemArmPin.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemArmPinActiveStatusRad" name="itemArmPinActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemArmPin.activeStatus" name="itemArmPin.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemArmPin.remark" name="itemArmPin.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemArmPin.inActiveBy"  name="itemArmPin.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemArmPin.inActiveDate" name="itemArmPin.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemArmPin.createdBy"  name="itemArmPin.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemArmPin.createdDate" name="itemArmPin.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemArmPinTemp.inActiveDateTemp" name="itemArmPinTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemArmPinTemp.createdDateTemp" name="itemArmPinTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemArmPinSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemArmPinCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>