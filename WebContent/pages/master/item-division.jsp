
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
        txtItemDivisionCode=$("#itemDivision\\.code"),
        txtItemDivisionName=$("#itemDivision\\.name"),
        rdbItemDivisionActiveStatus=$("#itemDivision\\.activeStatus"),
        txtItemDivisionRemark=$("#itemDivision\\.remark"),
        txtItemDivisionInActiveBy = $("#itemDivision\\.inActiveBy"),
        dtpItemDivisionInActiveDate = $("#itemDivision\\.inActiveDate"),
        txtItemDivisionCreatedBy = $("#itemDivision\\.createdBy"),
        dtpItemDivisionCreatedDate = $("#itemDivision\\.createdDate"),
        
        allFieldsItemDivision=$([])
            .add(txtItemDivisionCode)
            .add(txtItemDivisionName)
            .add(txtItemDivisionRemark)
            .add(txtItemDivisionInActiveBy)
            .add(txtItemDivisionCreatedBy);


    function reloadGridItemDivision(){
        $("#itemDivision_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemDivision");
        
        $('#itemDivision\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemDivisionSearchActiveStatusRadActive').prop('checked',true);
        $("#itemDivisionSearchActiveStatus").val("true");
        
        $('input[name="itemDivisionSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemDivisionSearchActiveStatus").val(value);
        });
        
        $('input[name="itemDivisionSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemDivisionSearchActiveStatus").val(value);
        });
                
        $('input[name="itemDivisionSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemDivisionSearchActiveStatus").val(value);
        });
        
        $('input[name="itemDivisionActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemDivision\\.activeStatus").val(value);
            $("#itemDivision\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemDivisionActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemDivision\\.activeStatus").val(value);
        });
        
        $("#btnItemDivisionNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/itemDivision-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemDivision();
                showInput("itemDivision");
                hideInput("itemDivisionSearch");
                $('#itemDivisionActiveStatusRadActive').prop('checked',true);
                $("#itemDivision\\.activeStatus").val("true");
                $("#itemDivision\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemDivision\\.createdDate").val("01/01/1900 00:00:00");
                txtItemDivisionCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemDivisionCode.attr("readonly",true);
                txtItemDivisionCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemDivisionSave").click(function(ev) {
           if(!$("#frmItemDivisionInput").valid()) {
//               handlers_input_itemDivision();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemDivisionFormatDate();
           if (updateRowId < 0){
               url = "master/item-division-save";
           } else{
               url = "master/item-division-update";
           }
           
           var params = $("#frmItemDivisionInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemDivisionFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemDivision");
                showInput("itemDivisionSearch");
                allFieldsItemDivision.val('').siblings('label[class="error"]').hide();
                txtItemDivisionCode.val("AUTO");
                reloadGridItemDivision();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemDivisionUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-division-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemDivision();
                updateRowId=$("#itemDivision_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemDivision=$("#itemDivision_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-division-get-data";
                var params="itemDivision.code=" + itemDivision.code;

                txtItemDivisionCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemDivisionCode.val(data.itemDivisionTemp.code);
                        txtItemDivisionName.val(data.itemDivisionTemp.name);
                        rdbItemDivisionActiveStatus.val(data.itemDivisionTemp.activeStatus);
                        txtItemDivisionRemark.val(data.itemDivisionTemp.remark);
                        txtItemDivisionInActiveBy.val(data.itemDivisionTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemDivisionTemp.inActiveDate,true);
                        dtpItemDivisionInActiveDate.val(inActiveDate);
                        txtItemDivisionCreatedBy.val(data.itemDivisionTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemDivisionTemp.createdDate,true);
                        dtpItemDivisionCreatedDate.val(createdDate);

                        if(data.itemDivisionTemp.activeStatus===true) {
                           $('#itemDivisionActiveStatusRadActive').prop('checked',true);
                           $("#itemDivision\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemDivisionActiveStatusRadInActive').prop('checked',true);              
                           $("#itemDivision\\.activeStatus").val("false");
                        }

                        showInput("itemDivision");
                        hideInput("itemDivisionSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemDivisionDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-division-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemDivision_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemDivision=$("#itemDivision_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-division-delete";
                var params="itemDivision.code=" + itemDivision.code;
                var message="Are You Sure To Delete(Code : "+ itemDivision.code + ")?";
                alertMessageDelete("itemDivision",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemDivision.code+ ')?</div>');
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
//                                var url="master/itemDivision-delete";
//                                var params="itemDivision.code=" + itemDivision.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemDivision();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemDivision.code+ ")")){
//                    var url="master/itemDivision-delete";
//                    var params="itemDivision.code=" + itemDivision.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemDivision();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemDivisionCancel").click(function(ev) {
            hideInput("itemDivision");
            showInput("itemDivisionSearch");
            allFieldsItemDivision.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemDivisionRefresh').click(function(ev) {
            $('#itemDivisionSearchActiveStatusRadActive').prop('checked',true);
            $("#itemDivisionSearchActiveStatus").val("true");
            $("#itemDivision_grid").jqGrid("clearGridData");
            $("#itemDivision_grid").jqGrid("setGridParam",{url:"master/item-division-data?"});
            $("#itemDivision_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemDivisionPrint").click(function(ev) {
            
            var url = "reports/item-division-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemDivision','width=500,height=500');
        });
        
        $('#btnItemDivision_search').click(function(ev) {
            $("#itemDivision_grid").jqGrid("clearGridData");
            $("#itemDivision_grid").jqGrid("setGridParam",{url:"master/item-division-data?" + $("#frmItemDivisionSearchInput").serialize()});
            $("#itemDivision_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemDivision(){
//        unHandlersInput(txtItemDivisionCode);
//        unHandlersInput(txtItemDivisionName);
//    }
//
//    function handlers_input_itemDivision(){
//        if(txtItemDivisionCode.val()===""){
//            handlersInput(txtItemDivisionCode);
//        }else{
//            unHandlersInput(txtItemDivisionCode);
//        }
//        if(txtItemDivisionName.val()===""){
//            handlersInput(txtItemDivisionName);
//        }else{
//            unHandlersInput(txtItemDivisionName);
//        }
//    }
    
    function itemDivisionFormatDate(){
        var inActiveDate=formatDate(dtpItemDivisionInActiveDate.val(),true);
        dtpItemDivisionInActiveDate.val(inActiveDate);
        $("#itemDivisionTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemDivisionCreatedDate.val(),true);
        dtpItemDivisionCreatedDate.val(createdDate);
        $("#itemDivisionTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemDivision" action="item-division-data" />
<b>Item Division</b>
<hr>
<br class="spacer"/>


<sj:div id="itemDivisionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemDivisionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemDivisionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemDivisionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemDivisionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemDivisionPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemDivisionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemDivisionSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemDivisionSearchCode" name="itemDivisionSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemDivisionSearchName" name="itemDivisionSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemDivisionSearchActiveStatus" name="itemDivisionSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemDivisionSearchActiveStatusRad" name="itemDivisionSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemDivision_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemDivisionGrid">
    <sjg:grid
        id="itemDivision_grid"
        dataType="json"
        href="%{remoteurlItemDivision}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemDivisionTemp"
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
    
<div id="itemDivisionInput" class="content ui-widget">
    <s:form id="frmItemDivisionInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemDivision.code" name="itemDivision.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemDivision.name" name="itemDivision.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemDivisionActiveStatusRad" name="itemDivisionActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemDivision.activeStatus" name="itemDivision.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemDivision.remark" name="itemDivision.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemDivision.inActiveBy"  name="itemDivision.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemDivision.inActiveDate" name="itemDivision.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemDivision.createdBy"  name="itemDivision.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemDivision.createdDate" name="itemDivision.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemDivisionTemp.inActiveDateTemp" name="itemDivisionTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemDivisionTemp.createdDateTemp" name="itemDivisionTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemDivisionSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemDivisionCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>