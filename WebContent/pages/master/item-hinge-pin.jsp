
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
        txtItemHingePinCode=$("#itemHingePin\\.code"),
        txtItemHingePinName=$("#itemHingePin\\.name"),
        rdbItemHingePinActiveStatus=$("#itemHingePin\\.activeStatus"),
        txtItemHingePinRemark=$("#itemHingePin\\.remark"),
        txtItemHingePinInActiveBy = $("#itemHingePin\\.inActiveBy"),
        dtpItemHingePinInActiveDate = $("#itemHingePin\\.inActiveDate"),
        txtItemHingePinCreatedBy = $("#itemHingePin\\.createdBy"),
        dtpItemHingePinCreatedDate = $("#itemHingePin\\.createdDate"),
        
        allFieldsItemHingePin=$([])
            .add(txtItemHingePinCode)
            .add(txtItemHingePinName)
            .add(txtItemHingePinRemark)
            .add(txtItemHingePinInActiveBy)
            .add(txtItemHingePinCreatedBy);


    function reloadGridItemHingePin(){
        $("#itemHingePin_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemHingePin");
        
        $('#itemHingePin\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemHingePinSearchActiveStatusRadActive').prop('checked',true);
        $("#itemHingePinSearchActiveStatus").val("true");
        
        $('input[name="itemHingePinSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemHingePinSearchActiveStatus").val(value);
        });
        
        $('input[name="itemHingePinSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemHingePinSearchActiveStatus").val(value);
        });
                
        $('input[name="itemHingePinSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemHingePinSearchActiveStatus").val(value);
        });
        
        $('input[name="itemHingePinActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemHingePin\\.activeStatus").val(value);
            $("#itemHingePin\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemHingePinActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemHingePin\\.activeStatus").val(value);
        });
        
        $("#btnItemHingePinNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-hinge-pin-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemHingePin();
                showInput("itemHingePin");
                hideInput("itemHingePinSearch");
                $('#itemHingePinActiveStatusRadActive').prop('checked',true);
                $("#itemHingePin\\.activeStatus").val("true");
                $("#itemHingePin\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemHingePin\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemHingePinCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemHingePinCode.val("AUTO");
                txtItemHingePinCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemHingePinSave").click(function(ev) {
           if(!$("#frmItemHingePinInput").valid()) {
//               handlers_input_itemHingePin();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemHingePinFormatDate();
           if (updateRowId < 0){
               url = "master/item-hinge-pin-save";
           } else{
               url = "master/item-hinge-pin-update";
           }
           
           var params = $("#frmItemHingePinInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemHingePinFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemHingePin");
                showInput("itemHingePinSearch");
                allFieldsItemHingePin.val('').siblings('label[class="error"]').hide();
                txtItemHingePinCode.val("AUTO");
                reloadGridItemHingePin();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemHingePinUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-hinge-pin-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemHingePin();
                updateRowId=$("#itemHingePin_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemHingePin=$("#itemHingePin_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-hinge-pin-get-data";
                var params="itemHingePin.code=" + itemHingePin.code;

                txtItemHingePinCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemHingePinCode.val(data.itemHingePinTemp.code);
                        txtItemHingePinName.val(data.itemHingePinTemp.name);
                        rdbItemHingePinActiveStatus.val(data.itemHingePinTemp.activeStatus);
                        txtItemHingePinRemark.val(data.itemHingePinTemp.remark);
                        txtItemHingePinInActiveBy.val(data.itemHingePinTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemHingePinTemp.inActiveDate,true);
                        dtpItemHingePinInActiveDate.val(inActiveDate);
                        txtItemHingePinCreatedBy.val(data.itemHingePinTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemHingePinTemp.createdDate,true);
                        dtpItemHingePinCreatedDate.val(createdDate);

                        if(data.itemHingePinTemp.activeStatus===true) {
                           $('#itemHingePinActiveStatusRadActive').prop('checked',true);
                           $("#itemHingePin\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemHingePinActiveStatusRadInActive').prop('checked',true);              
                           $("#itemHingePin\\.activeStatus").val("false");
                        }

                        showInput("itemHingePin");
                        hideInput("itemHingePinSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemHingePinDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-hinge-pin-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemHingePin_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemHingePin=$("#itemHingePin_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-hinge-pin-delete";
                var params="itemHingePin.code=" + itemHingePin.code;
                var message="Are You Sure To Delete(Code : "+ itemHingePin.code + ")?";
                alertMessageDelete("itemHingePin",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemHingePin.code+ ')?</div>');
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
//                                var url="master/itemHingePin-delete";
//                                var params="itemHingePin.code=" + itemHingePin.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemHingePin();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemHingePin.code+ ")")){
//                    var url="master/itemHingePin-delete";
//                    var params="itemHingePin.code=" + itemHingePin.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemHingePin();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemHingePinCancel").click(function(ev) {
            hideInput("itemHingePin");
            showInput("itemHingePinSearch");
            allFieldsItemHingePin.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemHingePinRefresh').click(function(ev) {
            $('#itemHingePinSearchActiveStatusRadActive').prop('checked',true);
            $("#itemHingePinSearchActiveStatus").val("true");
            $("#itemHingePin_grid").jqGrid("clearGridData");
            $("#itemHingePin_grid").jqGrid("setGridParam",{url:"master/itemHingePin-data?"});
            $("#itemHingePin_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemHingePinPrint").click(function(ev) {
            
            var url = "reports/item-hinge-pin-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemHingePin','width=500,height=500');
        });
        
        $('#btnItemHingePin_search').click(function(ev) {
            $("#itemHingePin_grid").jqGrid("clearGridData");
            $("#itemHingePin_grid").jqGrid("setGridParam",{url:"master/item-hinge-pin-data?" + $("#frmItemHingePinSearchInput").serialize()});
            $("#itemHingePin_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemHingePin(){
//        unHandlersInput(txtItemHingePinCode);
//        unHandlersInput(txtItemHingePinName);
//    }
//
//    function handlers_input_itemHingePin(){
//        if(txtItemHingePinCode.val()===""){
//            handlersInput(txtItemHingePinCode);
//        }else{
//            unHandlersInput(txtItemHingePinCode);
//        }
//        if(txtItemHingePinName.val()===""){
//            handlersInput(txtItemHingePinName);
//        }else{
//            unHandlersInput(txtItemHingePinName);
//        }
//    }
    
    function itemHingePinFormatDate(){
        var inActiveDate=formatDate(dtpItemHingePinInActiveDate.val(),true);
        dtpItemHingePinInActiveDate.val(inActiveDate);
        $("#itemHingePinTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemHingePinCreatedDate.val(),true);
        dtpItemHingePinCreatedDate.val(createdDate);
        $("#itemHingePinTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemHingePin" action="item-hinge-pin-data" />
<b>Item Hinge Pin</b>
<hr>
<br class="spacer"/>


<sj:div id="itemHingePinButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemHingePinNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemHingePinUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemHingePinDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemHingePinRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemHingePinPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemHingePinSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemHingePinSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemHingePinSearchCode" name="itemHingePinSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemHingePinSearchName" name="itemHingePinSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemHingePinSearchActiveStatus" name="itemHingePinSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemHingePinSearchActiveStatusRad" name="itemHingePinSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemHingePin_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemHingePinGrid">
    <sjg:grid
        id="itemHingePin_grid"
        dataType="json"
        href="%{remoteurlItemHingePin}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemHingePinTemp"
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
    
<div id="itemHingePinInput" class="content ui-widget">
    <s:form id="frmItemHingePinInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemHingePin.code" name="itemHingePin.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemHingePin.name" name="itemHingePin.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemHingePinActiveStatusRad" name="itemHingePinActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemHingePin.activeStatus" name="itemHingePin.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemHingePin.remark" name="itemHingePin.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemHingePin.inActiveBy"  name="itemHingePin.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemHingePin.inActiveDate" name="itemHingePin.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemHingePin.createdBy"  name="itemHingePin.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemHingePin.createdDate" name="itemHingePin.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemHingePinTemp.inActiveDateTemp" name="itemHingePinTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemHingePinTemp.createdDateTemp" name="itemHingePinTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemHingePinSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemHingePinCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>