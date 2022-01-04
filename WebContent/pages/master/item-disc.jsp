
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
        txtItemDiscCode=$("#itemDisc\\.code"),
        txtItemDiscName=$("#itemDisc\\.name"),
        rdbItemDiscActiveStatus=$("#itemDisc\\.activeStatus"),
        txtItemDiscRemark=$("#itemDisc\\.remark"),
        txtItemDiscInActiveBy = $("#itemDisc\\.inActiveBy"),
        dtpItemDiscInActiveDate = $("#itemDisc\\.inActiveDate"),
        txtItemDiscCreatedBy = $("#itemDisc\\.createdBy"),
        dtpItemDiscCreatedDate = $("#itemDisc\\.createdDate"),
        
        allFieldsItemDisc=$([])
            .add(txtItemDiscCode)
            .add(txtItemDiscName)
            .add(txtItemDiscRemark)
            .add(txtItemDiscInActiveBy)
            .add(txtItemDiscCreatedBy);


    function reloadGridItemDisc(){
        $("#itemDisc_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemDisc");
        
        $('#itemDisc\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemDiscSearchActiveStatusRadActive').prop('checked',true);
        $("#itemDiscSearchActiveStatus").val("true");
        
        $('input[name="itemDiscSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemDiscSearchActiveStatus").val(value);
        });
        
        $('input[name="itemDiscSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemDiscSearchActiveStatus").val(value);
        });
                
        $('input[name="itemDiscSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemDiscSearchActiveStatus").val(value);
        });
        
        $('input[name="itemDiscActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemDisc\\.activeStatus").val(value);
            $("#itemDisc\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemDiscActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemDisc\\.activeStatus").val(value);
        });
        
        $("#btnItemDiscNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-disc-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemDisc();
                showInput("itemDisc");
                hideInput("itemDiscSearch");
                $('#itemDiscActiveStatusRadActive').prop('checked',true);
                $("#itemDisc\\.activeStatus").val("true");
                $("#itemDisc\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemDisc\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemDiscCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemDiscCode.val("AUTO");
                txtItemDiscCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemDiscSave").click(function(ev) {
           if(!$("#frmItemDiscInput").valid()) {
//               handlers_input_itemDisc();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemDiscFormatDate();
           if (updateRowId < 0){
               url = "master/item-disc-save";
           } else{
               url = "master/item-disc-update";
           }
           
           var params = $("#frmItemDiscInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemDiscFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemDisc");
                showInput("itemDiscSearch");
                allFieldsItemDisc.val('').siblings('label[class="error"]').hide();
                txtItemDiscCode.val("AUTO");
                reloadGridItemDisc();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemDiscUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-disc-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemDisc();
                updateRowId=$("#itemDisc_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemDisc=$("#itemDisc_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-disc-get-data";
                var params="itemDisc.code=" + itemDisc.code;

                txtItemDiscCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemDiscCode.val(data.itemDiscTemp.code);
                        txtItemDiscName.val(data.itemDiscTemp.name);
                        rdbItemDiscActiveStatus.val(data.itemDiscTemp.activeStatus);
                        txtItemDiscRemark.val(data.itemDiscTemp.remark);
                        txtItemDiscInActiveBy.val(data.itemDiscTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemDiscTemp.inActiveDate,true);
                        dtpItemDiscInActiveDate.val(inActiveDate);
                        txtItemDiscCreatedBy.val(data.itemDiscTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemDiscTemp.createdDate,true);
                        dtpItemDiscCreatedDate.val(createdDate);

                        if(data.itemDiscTemp.activeStatus===true) {
                           $('#itemDiscActiveStatusRadActive').prop('checked',true);
                           $("#itemDisc\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemDiscActiveStatusRadInActive').prop('checked',true);              
                           $("#itemDisc\\.activeStatus").val("false");
                        }

                        showInput("itemDisc");
                        hideInput("itemDiscSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemDiscDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-disc-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemDisc_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemDisc=$("#itemDisc_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-disc-delete";
                var params="itemDisc.code=" + itemDisc.code;
                var message="Are You Sure To Delete(Code : "+ itemDisc.code + ")?";
                alertMessageDelete("itemDisc",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemDisc.code+ ')?</div>');
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
//                                var url="master/itemDisc-delete";
//                                var params="itemDisc.code=" + itemDisc.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemDisc();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemDisc.code+ ")")){
//                    var url="master/itemDisc-delete";
//                    var params="itemDisc.code=" + itemDisc.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemDisc();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemDiscCancel").click(function(ev) {
            hideInput("itemDisc");
            showInput("itemDiscSearch");
            allFieldsItemDisc.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemDiscRefresh').click(function(ev) {
            $('#itemDiscSearchActiveStatusRadActive').prop('checked',true);
            $("#itemDiscSearchActiveStatus").val("true");
            $("#itemDisc_grid").jqGrid("clearGridData");
            $("#itemDisc_grid").jqGrid("setGridParam",{url:"master/itemDisc-data?"});
            $("#itemDisc_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemDiscPrint").click(function(ev) {
            
            var url = "reports/item-disc-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemDisc','width=500,height=500');
        });
        
        $('#btnItemDisc_search').click(function(ev) {
            $("#itemDisc_grid").jqGrid("clearGridData");
            $("#itemDisc_grid").jqGrid("setGridParam",{url:"master/item-disc-data?" + $("#frmItemDiscSearchInput").serialize()});
            $("#itemDisc_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemDisc(){
//        unHandlersInput(txtItemDiscCode);
//        unHandlersInput(txtItemDiscName);
//    }
//
//    function handlers_input_itemDisc(){
//        if(txtItemDiscCode.val()===""){
//            handlersInput(txtItemDiscCode);
//        }else{
//            unHandlersInput(txtItemDiscCode);
//        }
//        if(txtItemDiscName.val()===""){
//            handlersInput(txtItemDiscName);
//        }else{
//            unHandlersInput(txtItemDiscName);
//        }
//    }
    
    function itemDiscFormatDate(){
        var inActiveDate=formatDate(dtpItemDiscInActiveDate.val(),true);
        dtpItemDiscInActiveDate.val(inActiveDate);
        $("#itemDiscTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemDiscCreatedDate.val(),true);
        dtpItemDiscCreatedDate.val(createdDate);
        $("#itemDiscTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemDisc" action="item-disc-data" />
<b>Item Disc</b>
<hr>
<br class="spacer"/>


<sj:div id="itemDiscButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemDiscNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemDiscUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemDiscDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemDiscRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemDiscPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemDiscSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemDiscSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemDiscSearchCode" name="itemDiscSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemDiscSearchName" name="itemDiscSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemDiscSearchActiveStatus" name="itemDiscSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemDiscSearchActiveStatusRad" name="itemDiscSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemDisc_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemDiscGrid">
    <sjg:grid
        id="itemDisc_grid"
        dataType="json"
        href="%{remoteurlItemDisc}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemDiscTemp"
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
    
<div id="itemDiscInput" class="content ui-widget">
    <s:form id="frmItemDiscInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemDisc.code" name="itemDisc.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemDisc.name" name="itemDisc.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemDiscActiveStatusRad" name="itemDiscActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemDisc.activeStatus" name="itemDisc.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemDisc.remark" name="itemDisc.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemDisc.inActiveBy"  name="itemDisc.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemDisc.inActiveDate" name="itemDisc.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemDisc.createdBy"  name="itemDisc.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemDisc.createdDate" name="itemDisc.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemDiscTemp.inActiveDateTemp" name="itemDiscTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemDiscTemp.createdDateTemp" name="itemDiscTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemDiscSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemDiscCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>