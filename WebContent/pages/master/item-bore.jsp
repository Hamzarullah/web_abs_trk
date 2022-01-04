
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
        txtItemBoreCode=$("#itemBore\\.code"),
        txtItemBoreName=$("#itemBore\\.name"),
        rdbItemBoreActiveStatus=$("#itemBore\\.activeStatus"),
        txtItemBoreRemark=$("#itemBore\\.remark"),
        txtItemBoreInActiveBy = $("#itemBore\\.inActiveBy"),
        dtpItemBoreInActiveDate = $("#itemBore\\.inActiveDate"),
        txtItemBoreCreatedBy = $("#itemBore\\.createdBy"),
        dtpItemBoreCreatedDate = $("#itemBore\\.createdDate"),
        
        allFieldsItemBore=$([])
            .add(txtItemBoreCode)
            .add(txtItemBoreName)
            .add(txtItemBoreRemark)
            .add(txtItemBoreInActiveBy)
            .add(txtItemBoreCreatedBy);


    function reloadGridItemBore(){
        $("#itemBore_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBore");
        
        $('#itemBore\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBoreSearchActiveStatusRadActive').prop('checked',true);
        $("#itemBoreSearchActiveStatus").val("true");
        
        $('input[name="itemBoreSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBoreSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBoreSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBoreSearchActiveStatus").val(value);
        });
                
        $('input[name="itemBoreSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBoreSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBoreActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBore\\.activeStatus").val(value);
            $("#itemBore\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBoreActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBore\\.activeStatus").val(value);
        });
        
        $("#btnItemBoreNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-bore-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBore();
                showInput("itemBore");
                hideInput("itemBoreSearch");
                $('#itemBoreActiveStatusRadActive').prop('checked',true);
                $("#itemBore\\.activeStatus").val("true");
                $("#itemBore\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBore\\.createdDate").val("01/01/1900 00:00:00");
                txtItemBoreCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBoreCode.attr("readonly",true);
                txtItemBoreCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBoreSave").click(function(ev) {
           if(!$("#frmItemBoreInput").valid()) {
//               handlers_input_itemBore();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBoreFormatDate();
           if (updateRowId < 0){
               url = "master/item-bore-save";
           } else{
               url = "master/item-bore-update";
           }
           
           var params = $("#frmItemBoreInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBoreFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBore");
                showInput("itemBoreSearch");
                allFieldsItemBore.val('').siblings('label[class="error"]').hide();
                txtItemBoreCode.val("AUTO");
                reloadGridItemBore();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBoreUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-bore-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBore();
                updateRowId=$("#itemBore_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBore=$("#itemBore_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-bore-get-data";
                var params="itemBore.code=" + itemBore.code;

                txtItemBoreCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBoreCode.val(data.itemBoreTemp.code);
                        txtItemBoreName.val(data.itemBoreTemp.name);
                        rdbItemBoreActiveStatus.val(data.itemBoreTemp.activeStatus);
                        txtItemBoreRemark.val(data.itemBoreTemp.remark);
                        txtItemBoreInActiveBy.val(data.itemBoreTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBoreTemp.inActiveDate,true);
                        dtpItemBoreInActiveDate.val(inActiveDate);
                        txtItemBoreCreatedBy.val(data.itemBoreTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBoreTemp.createdDate,true);
                        dtpItemBoreCreatedDate.val(createdDate);

                        if(data.itemBoreTemp.activeStatus===true) {
                           $('#itemBoreActiveStatusRadActive').prop('checked',true);
                           $("#itemBore\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBoreActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBore\\.activeStatus").val("false");
                        }

                        showInput("itemBore");
                        hideInput("itemBoreSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBoreDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-bore-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBore_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBore=$("#itemBore_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-bore-delete";
                var params="itemBore.code=" + itemBore.code;
                var message="Are You Sure To Delete(Code : "+ itemBore.code + ")?";
                alertMessageDelete("itemBore",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBore.code+ ')?</div>');
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
//                                var url="master/item-bore-delete";
//                                var params="itemBore.code=" + itemBore.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBore();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBore.code+ ")")){
//                    var url="master/item-bore-delete";
//                    var params="itemBore.code=" + itemBore.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBore();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBoreCancel").click(function(ev) {
            hideInput("itemBore");
            showInput("itemBoreSearch");
            allFieldsItemBore.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBoreRefresh').click(function(ev) {
            $('#itemBoreSearchActiveStatusRadActive').prop('checked',true);
            $("#itemBoreSearchActiveStatus").val("true");
            $("#itemBore_grid").jqGrid("clearGridData");
            $("#itemBore_grid").jqGrid("setGridParam",{url:"master/item-bore-data?"});
            $("#itemBore_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBorePrint").click(function(ev) {
            
            var url = "reports/item-bore-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBore','width=500,height=500');
        });
        
        $('#btnItemBore_search').click(function(ev) {
            $("#itemBore_grid").jqGrid("clearGridData");
            $("#itemBore_grid").jqGrid("setGridParam",{url:"master/item-bore-data?" + $("#frmItemBoreSearchInput").serialize()});
            $("#itemBore_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBore(){
//        unHandlersInput(txtItemBoreCode);
//        unHandlersInput(txtItemBoreName);
//    }
//
//    function handlers_input_itemBore(){
//        if(txtItemBoreCode.val()===""){
//            handlersInput(txtItemBoreCode);
//        }else{
//            unHandlersInput(txtItemBoreCode);
//        }
//        if(txtItemBoreName.val()===""){
//            handlersInput(txtItemBoreName);
//        }else{
//            unHandlersInput(txtItemBoreName);
//        }
//    }
    
    function itemBoreFormatDate(){
        var inActiveDate=formatDate(dtpItemBoreInActiveDate.val(),true);
        dtpItemBoreInActiveDate.val(inActiveDate);
        $("#itemBoreTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBoreCreatedDate.val(),true);
        dtpItemBoreCreatedDate.val(createdDate);
        $("#itemBoreTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBore" action="item-bore-data" />
<b>Item Bore</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBoreButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBoreNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBoreUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBoreDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBoreRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBorePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBoreSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBoreSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBoreSearchCode" name="itemBoreSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBoreSearchName" name="itemBoreSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBoreSearchActiveStatus" name="itemBoreSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBoreSearchActiveStatusRad" name="itemBoreSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBore_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBoreGrid">
    <sjg:grid
        id="itemBore_grid"
        dataType="json"
        href="%{remoteurlItemBore}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBoreTemp"
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
    
<div id="itemBoreInput" class="content ui-widget">
    <s:form id="frmItemBoreInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBore.code" name="itemBore.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBore.name" name="itemBore.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBoreActiveStatusRad" name="itemBoreActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBore.activeStatus" name="itemBore.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBore.remark" name="itemBore.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBore.inActiveBy"  name="itemBore.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemBore.inActiveDate" name="itemBore.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBore.createdBy"  name="itemBore.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBore.createdDate" name="itemBore.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBoreTemp.inActiveDateTemp" name="itemBoreTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBoreTemp.createdDateTemp" name="itemBoreTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBoreSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBoreCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>