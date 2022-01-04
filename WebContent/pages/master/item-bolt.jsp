
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
        txtItemBoltCode=$("#itemBolt\\.code"),
        txtItemBoltName=$("#itemBolt\\.name"),
        rdbItemBoltActiveStatus=$("#itemBolt\\.activeStatus"),
        txtItemBoltRemark=$("#itemBolt\\.remark"),
        txtItemBoltInActiveBy = $("#itemBolt\\.inActiveBy"),
        dtpItemBoltInActiveDate = $("#itemBolt\\.inActiveDate"),
        txtItemBoltCreatedBy = $("#itemBolt\\.createdBy"),
        dtpItemBoltCreatedDate = $("#itemBolt\\.createdDate"),
        
        allFieldsItemBolt=$([])
            .add(txtItemBoltCode)
            .add(txtItemBoltName)
            .add(txtItemBoltRemark)
            .add(txtItemBoltInActiveBy)
            .add(txtItemBoltCreatedBy);


    function reloadGridItemBolt(){
        $("#itemBolt_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBolt");
        
        $('#itemBolt\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBoltSearchActiveStatusRadActive').prop('checked',true);
        $("#itemBoltSearchActiveStatus").val("true");
        
        $('input[name="itemBoltSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBoltSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBoltSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBoltSearchActiveStatus").val(value);
        });
                
        $('input[name="itemBoltSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBoltSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBoltActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBolt\\.activeStatus").val(value);
            $("#itemBolt\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBoltActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBolt\\.activeStatus").val(value);
        });
        
        $("#btnItemBoltNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-bolt-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBolt();
                showInput("itemBolt");
                hideInput("itemBoltSearch");
                $('#itemBoltActiveStatusRadActive').prop('checked',true);
                $("#itemBolt\\.activeStatus").val("true");
                $("#itemBolt\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBolt\\.createdDate").val("01/01/1900 00:00:00");
                txtItemBoltCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBoltCode.attr("readonly",true);
                txtItemBoltCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBoltSave").click(function(ev) {
           if(!$("#frmItemBoltInput").valid()) {
//               handlers_input_itemBolt();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBoltFormatDate();
           if (updateRowId < 0){
               url = "master/item-bolt-save";
           } else{
               url = "master/item-bolt-update";
           }
           
           var params = $("#frmItemBoltInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBoltFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBolt");
                showInput("itemBoltSearch");
                allFieldsItemBolt.val('').siblings('label[class="error"]').hide();
                txtItemBoltCode.val("AUTO");
                reloadGridItemBolt();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBoltUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-bolt-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBolt();
                updateRowId=$("#itemBolt_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBolt=$("#itemBolt_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-bolt-get-data";
                var params="itemBolt.code=" + itemBolt.code;

                txtItemBoltCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBoltCode.val(data.itemBoltTemp.code);
                        txtItemBoltName.val(data.itemBoltTemp.name);
                        rdbItemBoltActiveStatus.val(data.itemBoltTemp.activeStatus);
                        txtItemBoltRemark.val(data.itemBoltTemp.remark);
                        txtItemBoltInActiveBy.val(data.itemBoltTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBoltTemp.inActiveDate,true);
                        dtpItemBoltInActiveDate.val(inActiveDate);
                        txtItemBoltCreatedBy.val(data.itemBoltTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBoltTemp.createdDate,true);
                        dtpItemBoltCreatedDate.val(createdDate);

                        if(data.itemBoltTemp.activeStatus===true) {
                           $('#itemBoltActiveStatusRadActive').prop('checked',true);
                           $("#itemBolt\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBoltActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBolt\\.activeStatus").val("false");
                        }

                        showInput("itemBolt");
                        hideInput("itemBoltSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBoltDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-bolt-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBolt_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBolt=$("#itemBolt_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-bolt-delete";
                var params="itemBolt.code=" + itemBolt.code;
                var message="Are You Sure To Delete(Code : "+ itemBolt.code + ")?";
                alertMessageDelete("itemBolt",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBolt.code+ ')?</div>');
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
//                                var url="master/item-bolt-delete";
//                                var params="itemBolt.code=" + itemBolt.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBolt();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBolt.code+ ")")){
//                    var url="master/item-bolt-delete";
//                    var params="itemBolt.code=" + itemBolt.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBolt();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBoltCancel").click(function(ev) {
            hideInput("itemBolt");
            showInput("itemBoltSearch");
            allFieldsItemBolt.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBoltRefresh').click(function(ev) {
            $('#itemBoltSearchActiveStatusRadActive').prop('checked',true);
            $("#itemBoltSearchActiveStatus").val("true");
            $("#itemBolt_grid").jqGrid("clearGridData");
            $("#itemBolt_grid").jqGrid("setGridParam",{url:"master/item-bolt-data?"});
            $("#itemBolt_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBoltPrint").click(function(ev) {
            
            var url = "reports/item-bolt-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBolt','width=500,height=500');
        });
        
        $('#btnItemBolt_search').click(function(ev) {
            $("#itemBolt_grid").jqGrid("clearGridData");
            $("#itemBolt_grid").jqGrid("setGridParam",{url:"master/item-bolt-data?" + $("#frmItemBoltSearchInput").serialize()});
            $("#itemBolt_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBolt(){
//        unHandlersInput(txtItemBoltCode);
//        unHandlersInput(txtItemBoltName);
//    }
//
//    function handlers_input_itemBolt(){
//        if(txtItemBoltCode.val()===""){
//            handlersInput(txtItemBoltCode);
//        }else{
//            unHandlersInput(txtItemBoltCode);
//        }
//        if(txtItemBoltName.val()===""){
//            handlersInput(txtItemBoltName);
//        }else{
//            unHandlersInput(txtItemBoltName);
//        }
//    }
    
    function itemBoltFormatDate(){
        var inActiveDate=formatDate(dtpItemBoltInActiveDate.val(),true);
        dtpItemBoltInActiveDate.val(inActiveDate);
        $("#itemBoltTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBoltCreatedDate.val(),true);
        dtpItemBoltCreatedDate.val(createdDate);
        $("#itemBoltTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBolt" action="item-bolt-data" />
<b>Item Bolt</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBoltButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBoltNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBoltUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBoltDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBoltRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBoltPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBoltSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBoltSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBoltSearchCode" name="itemBoltSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBoltSearchName" name="itemBoltSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBoltSearchActiveStatus" name="itemBoltSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBoltSearchActiveStatusRad" name="itemBoltSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBolt_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBoltGrid">
    <sjg:grid
        id="itemBolt_grid"
        dataType="json"
        href="%{remoteurlItemBolt}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBoltTemp"
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
    
<div id="itemBoltInput" class="content ui-widget">
    <s:form id="frmItemBoltInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBolt.code" name="itemBolt.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBolt.name" name="itemBolt.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBoltActiveStatusRad" name="itemBoltActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBolt.activeStatus" name="itemBolt.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBolt.remark" name="itemBolt.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBolt.inActiveBy"  name="itemBolt.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker  disabled="true" id="itemBolt.inActiveDate" name="itemBolt.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBolt.createdBy"  name="itemBolt.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBolt.createdDate" name="itemBolt.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBoltTemp.inActiveDateTemp" name="itemBoltTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBoltTemp.createdDateTemp" name="itemBoltTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBoltSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBoltCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>