
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
        txtItemPlatesCode=$("#itemPlates\\.code"),
        txtItemPlatesName=$("#itemPlates\\.name"),
        rdbItemPlatesActiveStatus=$("#itemPlates\\.activeStatus"),
        txtItemPlatesRemark=$("#itemPlates\\.remark"),
        txtItemPlatesInActiveBy = $("#itemPlates\\.inActiveBy"),
        dtpItemPlatesInActiveDate = $("#itemPlates\\.inActiveDate"),
        txtItemPlatesCreatedBy = $("#itemPlates\\.createdBy"),
        dtpItemPlatesCreatedDate = $("#itemPlates\\.createdDate"),
        
        allFieldsItemPlates=$([])
            .add(txtItemPlatesCode)
            .add(txtItemPlatesName)
            .add(txtItemPlatesRemark)
            .add(txtItemPlatesInActiveBy)
            .add(txtItemPlatesCreatedBy);


    function reloadGridItemPlates(){
        $("#itemPlates_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemPlates");
        
        $('#itemPlates\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemPlatesSearchActiveStatusRadActive').prop('checked',true);
        $("#itemPlatesSearchActiveStatus").val("true");
        
        $('input[name="itemPlatesSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemPlatesSearchActiveStatus").val(value);
        });
        
        $('input[name="itemPlatesSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemPlatesSearchActiveStatus").val(value);
        });
                
        $('input[name="itemPlatesSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemPlatesSearchActiveStatus").val(value);
        });
        
        $('input[name="itemPlatesActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemPlates\\.activeStatus").val(value);
            $("#itemPlates\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemPlatesActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemPlates\\.activeStatus").val(value);
        });
        
        $("#btnItemPlatesNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-plates-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemPlates();
                showInput("itemPlates");
                hideInput("itemPlatesSearch");
                $('#itemPlatesActiveStatusRadActive').prop('checked',true);
                $("#itemPlates\\.activeStatus").val("true");
                $("#itemPlates\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemPlates\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemPlatesCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemPlatesCode.val("AUTO");
                txtItemPlatesCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemPlatesSave").click(function(ev) {
           if(!$("#frmItemPlatesInput").valid()) {
//               handlers_input_itemPlates();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemPlatesFormatDate();
           if (updateRowId < 0){
               url = "master/item-plates-save";
           } else{
               url = "master/item-plates-update";
           }
           
           var params = $("#frmItemPlatesInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemPlatesFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemPlates");
                showInput("itemPlatesSearch");
                allFieldsItemPlates.val('').siblings('label[class="error"]').hide();
                txtItemPlatesCode.val("AUTO");
                reloadGridItemPlates();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemPlatesUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-plates-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemPlates();
                updateRowId=$("#itemPlates_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemPlates=$("#itemPlates_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-plates-get-data";
                var params="itemPlates.code=" + itemPlates.code;

                txtItemPlatesCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemPlatesCode.val(data.itemPlatesTemp.code);
                        txtItemPlatesName.val(data.itemPlatesTemp.name);
                        rdbItemPlatesActiveStatus.val(data.itemPlatesTemp.activeStatus);
                        txtItemPlatesRemark.val(data.itemPlatesTemp.remark);
                        txtItemPlatesInActiveBy.val(data.itemPlatesTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemPlatesTemp.inActiveDate,true);
                        dtpItemPlatesInActiveDate.val(inActiveDate);
                        txtItemPlatesCreatedBy.val(data.itemPlatesTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemPlatesTemp.createdDate,true);
                        dtpItemPlatesCreatedDate.val(createdDate);

                        if(data.itemPlatesTemp.activeStatus===true) {
                           $('#itemPlatesActiveStatusRadActive').prop('checked',true);
                           $("#itemPlates\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemPlatesActiveStatusRadInActive').prop('checked',true);              
                           $("#itemPlates\\.activeStatus").val("false");
                        }

                        showInput("itemPlates");
                        hideInput("itemPlatesSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemPlatesDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-plates-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemPlates_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemPlates=$("#itemPlates_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-plates-delete";
                var params="itemPlates.code=" + itemPlates.code;
                var message="Are You Sure To Delete(Code : "+ itemPlates.code + ")?";
                alertMessageDelete("itemPlates",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemPlates.code+ ')?</div>');
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
//                                var url="master/itemPlates-delete";
//                                var params="itemPlates.code=" + itemPlates.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemPlates();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemPlates.code+ ")")){
//                    var url="master/itemPlates-delete";
//                    var params="itemPlates.code=" + itemPlates.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemPlates();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemPlatesCancel").click(function(ev) {
            hideInput("itemPlates");
            showInput("itemPlatesSearch");
            allFieldsItemPlates.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemPlatesRefresh').click(function(ev) {
            $('#itemPlatesSearchActiveStatusRadActive').prop('checked',true);
            $("#itemPlatesSearchActiveStatus").val("true");
            $("#itemPlates_grid").jqGrid("clearGridData");
            $("#itemPlates_grid").jqGrid("setGridParam",{url:"master/itemPlates-data?"});
            $("#itemPlates_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemPlatesPrint").click(function(ev) {
            
            var url = "reports/item-plates-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemPlates','width=500,height=500');
        });
        
        $('#btnItemPlates_search').click(function(ev) {
            $("#itemPlates_grid").jqGrid("clearGridData");
            $("#itemPlates_grid").jqGrid("setGridParam",{url:"master/item-plates-data?" + $("#frmItemPlatesSearchInput").serialize()});
            $("#itemPlates_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemPlates(){
//        unHandlersInput(txtItemPlatesCode);
//        unHandlersInput(txtItemPlatesName);
//    }
//
//    function handlers_input_itemPlates(){
//        if(txtItemPlatesCode.val()===""){
//            handlersInput(txtItemPlatesCode);
//        }else{
//            unHandlersInput(txtItemPlatesCode);
//        }
//        if(txtItemPlatesName.val()===""){
//            handlersInput(txtItemPlatesName);
//        }else{
//            unHandlersInput(txtItemPlatesName);
//        }
//    }
    
    function itemPlatesFormatDate(){
        var inActiveDate=formatDate(dtpItemPlatesInActiveDate.val(),true);
        dtpItemPlatesInActiveDate.val(inActiveDate);
        $("#itemPlatesTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemPlatesCreatedDate.val(),true);
        dtpItemPlatesCreatedDate.val(createdDate);
        $("#itemPlatesTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemPlates" action="item-plates-data" />
<b>Item Plates</b>
<hr>
<br class="spacer"/>


<sj:div id="itemPlatesButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemPlatesNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemPlatesUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemPlatesDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemPlatesRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemPlatesPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemPlatesSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemPlatesSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemPlatesSearchCode" name="itemPlatesSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemPlatesSearchName" name="itemPlatesSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemPlatesSearchActiveStatus" name="itemPlatesSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemPlatesSearchActiveStatusRad" name="itemPlatesSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemPlates_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemPlatesGrid">
    <sjg:grid
        id="itemPlates_grid"
        dataType="json"
        href="%{remoteurlItemPlates}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemPlatesTemp"
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
    
<div id="itemPlatesInput" class="content ui-widget">
    <s:form id="frmItemPlatesInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemPlates.code" name="itemPlates.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemPlates.name" name="itemPlates.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemPlatesActiveStatusRad" name="itemPlatesActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemPlates.activeStatus" name="itemPlates.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemPlates.remark" name="itemPlates.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemPlates.inActiveBy"  name="itemPlates.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemPlates.inActiveDate" name="itemPlates.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemPlates.createdBy"  name="itemPlates.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemPlates.createdDate" name="itemPlates.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemPlatesTemp.inActiveDateTemp" name="itemPlatesTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemPlatesTemp.createdDateTemp" name="itemPlatesTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemPlatesSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemPlatesCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>