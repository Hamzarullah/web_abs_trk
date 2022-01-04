
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
        txtItemArmCode=$("#itemArm\\.code"),
        txtItemArmName=$("#itemArm\\.name"),
        rdbItemArmActiveStatus=$("#itemArm\\.activeStatus"),
        txtItemArmRemark=$("#itemArm\\.remark"),
        txtItemArmInActiveBy = $("#itemArm\\.inActiveBy"),
        dtpItemArmInActiveDate = $("#itemArm\\.inActiveDate"),
        txtItemArmCreatedBy = $("#itemArm\\.createdBy"),
        dtpItemArmCreatedDate = $("#itemArm\\.createdDate"),
        
        allFieldsItemArm=$([])
            .add(txtItemArmCode)
            .add(txtItemArmName)
            .add(txtItemArmRemark)
            .add(txtItemArmInActiveBy)
            .add(txtItemArmCreatedBy);


    function reloadGridItemArm(){
        $("#itemArm_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemArm");
        
        $('#itemArm\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemArmSearchActiveStatusRadActive').prop('checked',true);
        $("#itemArmSearchActiveStatus").val("true");
        
        $('input[name="itemArmSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemArmSearchActiveStatus").val(value);
        });
        
        $('input[name="itemArmSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemArmSearchActiveStatus").val(value);
        });
                
        $('input[name="itemArmSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemArmSearchActiveStatus").val(value);
        });
        
        $('input[name="itemArmActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemArm\\.activeStatus").val(value);
            $("#itemArm\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemArmActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemArm\\.activeStatus").val(value);
        });
        
        $("#btnItemArmNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-arm-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemArm();
                showInput("itemArm");
                hideInput("itemArmSearch");
                $('#itemArmActiveStatusRadActive').prop('checked',true);
                $("#itemArm\\.activeStatus").val("true");
                $("#itemArm\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemArm\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemArmCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemArmCode.val("AUTO");
                txtItemArmCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemArmSave").click(function(ev) {
           if(!$("#frmItemArmInput").valid()) {
//               handlers_input_itemArm();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemArmFormatDate();
           if (updateRowId < 0){
               url = "master/item-arm-save";
           } else{
               url = "master/item-arm-update";
           }
           
           var params = $("#frmItemArmInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemArmFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemArm");
                showInput("itemArmSearch");
                allFieldsItemArm.val('').siblings('label[class="error"]').hide();
                txtItemArmCode.val("AUTO");
                reloadGridItemArm();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemArmUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-arm-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemArm();
                updateRowId=$("#itemArm_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemArm=$("#itemArm_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-arm-get-data";
                var params="itemArm.code=" + itemArm.code;

                txtItemArmCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemArmCode.val(data.itemArmTemp.code);
                        txtItemArmName.val(data.itemArmTemp.name);
                        rdbItemArmActiveStatus.val(data.itemArmTemp.activeStatus);
                        txtItemArmRemark.val(data.itemArmTemp.remark);
                        txtItemArmInActiveBy.val(data.itemArmTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemArmTemp.inActiveDate,true);
                        dtpItemArmInActiveDate.val(inActiveDate);
                        txtItemArmCreatedBy.val(data.itemArmTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemArmTemp.createdDate,true);
                        dtpItemArmCreatedDate.val(createdDate);

                        if(data.itemArmTemp.activeStatus===true) {
                           $('#itemArmActiveStatusRadActive').prop('checked',true);
                           $("#itemArm\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemArmActiveStatusRadInActive').prop('checked',true);              
                           $("#itemArm\\.activeStatus").val("false");
                        }

                        showInput("itemArm");
                        hideInput("itemArmSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemArmDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-arm-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemArm_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemArm=$("#itemArm_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-arm-delete";
                var params="itemArm.code=" + itemArm.code;
                var message="Are You Sure To Delete(Code : "+ itemArm.code + ")?";
                alertMessageDelete("itemArm",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemArm.code+ ')?</div>');
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
//                                var url="master/itemArm-delete";
//                                var params="itemArm.code=" + itemArm.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemArm();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemArm.code+ ")")){
//                    var url="master/itemArm-delete";
//                    var params="itemArm.code=" + itemArm.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemArm();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemArmCancel").click(function(ev) {
            hideInput("itemArm");
            showInput("itemArmSearch");
            allFieldsItemArm.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemArmRefresh').click(function(ev) {
            $('#itemArmSearchActiveStatusRadActive').prop('checked',true);
            $("#itemArmSearchActiveStatus").val("true");
            $("#itemArm_grid").jqGrid("clearGridData");
            $("#itemArm_grid").jqGrid("setGridParam",{url:"master/itemArm-data?"});
            $("#itemArm_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemArmPrint").click(function(ev) {
            
            var url = "reports/item-arm-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemArm','width=500,height=500');
        });
        
        $('#btnItemArm_search').click(function(ev) {
            $("#itemArm_grid").jqGrid("clearGridData");
            $("#itemArm_grid").jqGrid("setGridParam",{url:"master/item-arm-data?" + $("#frmItemArmSearchInput").serialize()});
            $("#itemArm_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemArm(){
//        unHandlersInput(txtItemArmCode);
//        unHandlersInput(txtItemArmName);
//    }
//
//    function handlers_input_itemArm(){
//        if(txtItemArmCode.val()===""){
//            handlersInput(txtItemArmCode);
//        }else{
//            unHandlersInput(txtItemArmCode);
//        }
//        if(txtItemArmName.val()===""){
//            handlersInput(txtItemArmName);
//        }else{
//            unHandlersInput(txtItemArmName);
//        }
//    }
    
    function itemArmFormatDate(){
        var inActiveDate=formatDate(dtpItemArmInActiveDate.val(),true);
        dtpItemArmInActiveDate.val(inActiveDate);
        $("#itemArmTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemArmCreatedDate.val(),true);
        dtpItemArmCreatedDate.val(createdDate);
        $("#itemArmTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemArm" action="item-arm-data" />
<b>Item Arm</b>
<hr>
<br class="spacer"/>


<sj:div id="itemArmButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemArmNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemArmUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemArmDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemArmRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemArmPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemArmSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemArmSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemArmSearchCode" name="itemArmSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemArmSearchName" name="itemArmSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemArmSearchActiveStatus" name="itemArmSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemArmSearchActiveStatusRad" name="itemArmSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemArm_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemArmGrid">
    <sjg:grid
        id="itemArm_grid"
        dataType="json"
        href="%{remoteurlItemArm}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemArmTemp"
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
    
<div id="itemArmInput" class="content ui-widget">
    <s:form id="frmItemArmInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemArm.code" name="itemArm.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemArm.name" name="itemArm.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemArmActiveStatusRad" name="itemArmActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemArm.activeStatus" name="itemArm.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemArm.remark" name="itemArm.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemArm.inActiveBy"  name="itemArm.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemArm.inActiveDate" name="itemArm.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemArm.createdBy"  name="itemArm.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemArm.createdDate" name="itemArm.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemArmTemp.inActiveDateTemp" name="itemArmTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemArmTemp.createdDateTemp" name="itemArmTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemArmSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemArmCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>