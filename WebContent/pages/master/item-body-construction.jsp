
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
        txtItemBodyConstructionCode=$("#itemBodyConstruction\\.code"),
        txtItemBodyConstructionName=$("#itemBodyConstruction\\.name"),
        rdbItemBodyConstructionActiveStatus=$("#itemBodyConstruction\\.activeStatus"),
        txtItemBodyConstructionRemark=$("#itemBodyConstruction\\.remark"),
        txtItemBodyConstructionInActiveBy = $("#itemBodyConstruction\\.inActiveBy"),
        dtpItemBodyConstructionInActiveDate = $("#itemBodyConstruction\\.inActiveDate"),
        txtItemBodyConstructionCreatedBy = $("#itemBodyConstruction\\.createdBy"),
        dtpItemBodyConstructionCreatedDate = $("#itemBodyConstruction\\.createdDate"),
        
        allFieldsItemBodyConstruction=$([])
            .add(txtItemBodyConstructionCode)
            .add(txtItemBodyConstructionName)
            .add(txtItemBodyConstructionRemark)
            .add(txtItemBodyConstructionInActiveBy)
            .add(txtItemBodyConstructionCreatedBy);


    function reloadGridItemBodyConstruction(){
        $("#itemBodyConstruction_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBodyConstruction");
        
        $('#itemBodyConstruction\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBodyConstructionSearchActiveStatusRadActive').prop('checked',true);
        $("#itemBodyConstructionSearchActiveStatus").val("true");
        
        $('input[name="itemBodyConstructionSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBodyConstructionSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBodyConstructionSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBodyConstructionSearchActiveStatus").val(value);
        });
                
        $('input[name="itemBodyConstructionSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBodyConstructionSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBodyConstructionActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBodyConstruction\\.activeStatus").val(value);
            $("#itemBodyConstruction\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBodyConstructionActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBodyConstruction\\.activeStatus").val(value);
        });
        
        $("#btnItemBodyConstructionNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-body-construction-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBodyConstruction();
                showInput("itemBodyConstruction");
                hideInput("itemBodyConstructionSearch");
                $('#itemBodyConstructionActiveStatusRadActive').prop('checked',true);
                $("#itemBodyConstruction\\.activeStatus").val("true");
                $("#itemBodyConstruction\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBodyConstruction\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemBodyConstructionCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBodyConstructionCode.val("AUTO");
                txtItemBodyConstructionCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBodyConstructionSave").click(function(ev) {
           if(!$("#frmItemBodyConstructionInput").valid()) {
//               handlers_input_itemBodyConstruction();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBodyConstructionFormatDate();
           if (updateRowId < 0){
               url = "master/item-body-construction-save";
           } else{
               url = "master/item-body-construction-update";
           }
           
           var params = $("#frmItemBodyConstructionInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBodyConstructionFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBodyConstruction");
                showInput("itemBodyConstructionSearch");
                allFieldsItemBodyConstruction.val('').siblings('label[class="error"]').hide();
                txtItemBodyConstructionCode.val("AUTO");
                reloadGridItemBodyConstruction();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBodyConstructionUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-body-construction-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBodyConstruction();
                updateRowId=$("#itemBodyConstruction_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBodyConstruction=$("#itemBodyConstruction_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-body-construction-get-data";
                var params="itemBodyConstruction.code=" + itemBodyConstruction.code;

                txtItemBodyConstructionCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBodyConstructionCode.val(data.itemBodyConstructionTemp.code);
                        txtItemBodyConstructionName.val(data.itemBodyConstructionTemp.name);
                        rdbItemBodyConstructionActiveStatus.val(data.itemBodyConstructionTemp.activeStatus);
                        txtItemBodyConstructionRemark.val(data.itemBodyConstructionTemp.remark);
                        txtItemBodyConstructionInActiveBy.val(data.itemBodyConstructionTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBodyConstructionTemp.inActiveDate,true);
                        dtpItemBodyConstructionInActiveDate.val(inActiveDate);
                        txtItemBodyConstructionCreatedBy.val(data.itemBodyConstructionTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBodyConstructionTemp.createdDate,true);
                        dtpItemBodyConstructionCreatedDate.val(createdDate);

                        if(data.itemBodyConstructionTemp.activeStatus===true) {
                           $('#itemBodyConstructionActiveStatusRadActive').prop('checked',true);
                           $("#itemBodyConstruction\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBodyConstructionActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBodyConstruction\\.activeStatus").val("false");
                        }

                        showInput("itemBodyConstruction");
                        hideInput("itemBodyConstructionSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBodyConstructionDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-body-construction-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBodyConstruction_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBodyConstruction=$("#itemBodyConstruction_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-body-construction-delete";
                var params="itemBodyConstruction.code=" + itemBodyConstruction.code;
                var message="Are You Sure To Delete(Code : "+ itemBodyConstruction.code + ")?";
                alertMessageDelete("itemBodyConstruction",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBodyConstruction.code+ ')?</div>');
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
//                                var url="master/itemBodyConstruction-delete";
//                                var params="itemBodyConstruction.code=" + itemBodyConstruction.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBodyConstruction();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBodyConstruction.code+ ")")){
//                    var url="master/itemBodyConstruction-delete";
//                    var params="itemBodyConstruction.code=" + itemBodyConstruction.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBodyConstruction();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBodyConstructionCancel").click(function(ev) {
            hideInput("itemBodyConstruction");
            showInput("itemBodyConstructionSearch");
            allFieldsItemBodyConstruction.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBodyConstructionRefresh').click(function(ev) {
            $('#itemBodyConstructionSearchActiveStatusRadActive').prop('checked',true);
            $("#itemBodyConstructionSearchActiveStatus").val("true");
            $("#itemBodyConstruction_grid").jqGrid("clearGridData");
            $("#itemBodyConstruction_grid").jqGrid("setGridParam",{url:"master/itemBodyConstruction-data?"});
            $("#itemBodyConstruction_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBodyConstructionPrint").click(function(ev) {
            
            var url = "reports/item-body-construction-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBodyConstruction','width=500,height=500');
        });
        
        $('#btnItemBodyConstruction_search').click(function(ev) {
            $("#itemBodyConstruction_grid").jqGrid("clearGridData");
            $("#itemBodyConstruction_grid").jqGrid("setGridParam",{url:"master/item-body-construction-data?" + $("#frmItemBodyConstructionSearchInput").serialize()});
            $("#itemBodyConstruction_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBodyConstruction(){
//        unHandlersInput(txtItemBodyConstructionCode);
//        unHandlersInput(txtItemBodyConstructionName);
//    }
//
//    function handlers_input_itemBodyConstruction(){
//        if(txtItemBodyConstructionCode.val()===""){
//            handlersInput(txtItemBodyConstructionCode);
//        }else{
//            unHandlersInput(txtItemBodyConstructionCode);
//        }
//        if(txtItemBodyConstructionName.val()===""){
//            handlersInput(txtItemBodyConstructionName);
//        }else{
//            unHandlersInput(txtItemBodyConstructionName);
//        }
//    }
    
    function itemBodyConstructionFormatDate(){
        var inActiveDate=formatDate(dtpItemBodyConstructionInActiveDate.val(),true);
        dtpItemBodyConstructionInActiveDate.val(inActiveDate);
        $("#itemBodyConstructionTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBodyConstructionCreatedDate.val(),true);
        dtpItemBodyConstructionCreatedDate.val(createdDate);
        $("#itemBodyConstructionTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBodyConstruction" action="item-body-construction-data" />
<b>Item Body Construction</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBodyConstructionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBodyConstructionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBodyConstructionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBodyConstructionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBodyConstructionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBodyConstructionPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBodyConstructionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBodyConstructionSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBodyConstructionSearchCode" name="itemBodyConstructionSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBodyConstructionSearchName" name="itemBodyConstructionSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBodyConstructionSearchActiveStatus" name="itemBodyConstructionSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBodyConstructionSearchActiveStatusRad" name="itemBodyConstructionSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBodyConstruction_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBodyConstructionGrid">
    <sjg:grid
        id="itemBodyConstruction_grid"
        dataType="json"
        href="%{remoteurlItemBodyConstruction}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBodyConstructionTemp"
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
    
<div id="itemBodyConstructionInput" class="content ui-widget">
    <s:form id="frmItemBodyConstructionInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBodyConstruction.code" name="itemBodyConstruction.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBodyConstruction.name" name="itemBodyConstruction.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBodyConstructionActiveStatusRad" name="itemBodyConstructionActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBodyConstruction.activeStatus" name="itemBodyConstruction.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBodyConstruction.remark" name="itemBodyConstruction.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBodyConstruction.inActiveBy"  name="itemBodyConstruction.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemBodyConstruction.inActiveDate" name="itemBodyConstruction.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBodyConstruction.createdBy"  name="itemBodyConstruction.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBodyConstruction.createdDate" name="itemBodyConstruction.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBodyConstructionTemp.inActiveDateTemp" name="itemBodyConstructionTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBodyConstructionTemp.createdDateTemp" name="itemBodyConstructionTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBodyConstructionSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBodyConstructionCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>