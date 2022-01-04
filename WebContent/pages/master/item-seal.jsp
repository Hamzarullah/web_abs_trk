
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
        txtItemSealCode=$("#itemSeal\\.code"),
        txtItemSealName=$("#itemSeal\\.name"),
        rdbItemSealActiveStatus=$("#itemSeal\\.activeStatus"),
        txtItemSealRemark=$("#itemSeal\\.remark"),
        txtItemSealInActiveBy = $("#itemSeal\\.inActiveBy"),
        dtpItemSealInActiveDate = $("#itemSeal\\.inActiveDate"),
        txtItemSealCreatedBy = $("#itemSeal\\.createdBy"),
        dtpItemSealCreatedDate = $("#itemSeal\\.createdDate"),
        
        allFieldsItemSeal=$([])
            .add(txtItemSealCode)
            .add(txtItemSealName)
            .add(txtItemSealRemark)
            .add(txtItemSealInActiveBy)
            .add(txtItemSealCreatedBy);


    function reloadGridItemSeal(){
        $("#itemSeal_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSeal");
        
        $('#itemSeal\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSealSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSealSearchActiveStatus").val("true");
        
        $('input[name="itemSealSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSealSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSealSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSealSearchActiveStatus").val(value);
        });
                
        $('input[name="itemSealSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSealSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSealActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeal\\.activeStatus").val(value);
            $("#itemSeal\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSealActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeal\\.activeStatus").val(value);
        });
        
        $("#btnItemSealNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seal-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeal();
                showInput("itemSeal");
                hideInput("itemSealSearch");
                $('#itemSealActiveStatusRadActive').prop('checked',true);
                $("#itemSeal\\.activeStatus").val("true");
                $("#itemSeal\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSeal\\.createdDate").val("01/01/1900 00:00:00");
                txtItemSealCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSealCode.attr("readonly",true);
                txtItemSealCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSealSave").click(function(ev) {
           if(!$("#frmItemSealInput").valid()) {
//               handlers_input_itemSeal();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemSealFormatDate();
           if (updateRowId < 0){
               url = "master/item-seal-save";
           } else{
               url = "master/item-seal-update";
           }
           
           var params = $("#frmItemSealInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSealFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSeal");
                showInput("itemSealSearch");
                allFieldsItemSeal.val('').siblings('label[class="error"]').hide();
                txtItemSealCode.val("AUTO");
                reloadGridItemSeal();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSealUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seal-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeal();
                updateRowId=$("#itemSeal_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSeal=$("#itemSeal_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-seal-get-data";
                var params="itemSeal.code=" + itemSeal.code;

                txtItemSealCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSealCode.val(data.itemSealTemp.code);
                        txtItemSealName.val(data.itemSealTemp.name);
                        rdbItemSealActiveStatus.val(data.itemSealTemp.activeStatus);
                        txtItemSealRemark.val(data.itemSealTemp.remark);
                        txtItemSealInActiveBy.val(data.itemSealTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSealTemp.inActiveDate,true);
                        dtpItemSealInActiveDate.val(inActiveDate);
                        txtItemSealCreatedBy.val(data.itemSealTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSealTemp.createdDate,true);
                        dtpItemSealCreatedDate.val(createdDate);

                        if(data.itemSealTemp.activeStatus===true) {
                           $('#itemSealActiveStatusRadActive').prop('checked',true);
                           $("#itemSeal\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSealActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSeal\\.activeStatus").val("false");
                        }

                        showInput("itemSeal");
                        hideInput("itemSealSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSealDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seal-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSeal_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSeal=$("#itemSeal_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-seal-delete";
                var params="itemSeal.code=" + itemSeal.code;
                var message="Are You Sure To Delete(Code : "+ itemSeal.code + ")?";
                alertMessageDelete("itemSeal",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSeal.code+ ')?</div>');
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
//                                var url="master/item-seal-delete";
//                                var params="itemSeal.code=" + itemSeal.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSeal();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSeal.code+ ")")){
//                    var url="master/item-seal-delete";
//                    var params="itemSeal.code=" + itemSeal.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSeal();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSealCancel").click(function(ev) {
            hideInput("itemSeal");
            showInput("itemSealSearch");
            allFieldsItemSeal.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSealRefresh').click(function(ev) {
            $('#itemSealSearchActiveStatusRadActive').prop('checked',true);
            $("#itemSealSearchActiveStatus").val("true");
            $("#itemSeal_grid").jqGrid("clearGridData");
            $("#itemSeal_grid").jqGrid("setGridParam",{url:"master/item-seal-data?"});
            $("#itemSeal_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSealPrint").click(function(ev) {
            
            var url = "reports/item-seal-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSeal','width=500,height=500');
        });
        
        $('#btnItemSeal_search').click(function(ev) {
            $("#itemSeal_grid").jqGrid("clearGridData");
            $("#itemSeal_grid").jqGrid("setGridParam",{url:"master/item-seal-data?" + $("#frmItemSealSearchInput").serialize()});
            $("#itemSeal_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSeal(){
//        unHandlersInput(txtItemSealCode);
//        unHandlersInput(txtItemSealName);
//    }
//
//    function handlers_input_itemSeal(){
//        if(txtItemSealCode.val()===""){
//            handlersInput(txtItemSealCode);
//        }else{
//            unHandlersInput(txtItemSealCode);
//        }
//        if(txtItemSealName.val()===""){
//            handlersInput(txtItemSealName);
//        }else{
//            unHandlersInput(txtItemSealName);
//        }
//    }
    
    function itemSealFormatDate(){
        var inActiveDate=formatDate(dtpItemSealInActiveDate.val(),true);
        dtpItemSealInActiveDate.val(inActiveDate);
        $("#itemSealTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSealCreatedDate.val(),true);
        dtpItemSealCreatedDate.val(createdDate);
        $("#itemSealTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSeal" action="item-seal-data" />
<b>Item Seal</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSealButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSealNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSealUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSealDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSealRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSealPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSealSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSealSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSealSearchCode" name="itemSealSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSealSearchName" name="itemSealSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSealSearchActiveStatus" name="itemSealSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSealSearchActiveStatusRad" name="itemSealSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSeal_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSealGrid">
    <sjg:grid
        id="itemSeal_grid"
        dataType="json"
        href="%{remoteurlItemSeal}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSealTemp"
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
    
<div id="itemSealInput" class="content ui-widget">
    <s:form id="frmItemSealInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSeal.code" name="itemSeal.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSeal.name" name="itemSeal.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSealActiveStatusRad" name="itemSealActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSeal.activeStatus" name="itemSeal.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSeal.remark" name="itemSeal.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSeal.inActiveBy"  name="itemSeal.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSeal.inActiveDate" name="itemSeal.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeal.createdBy"  name="itemSeal.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSeal.createdDate" name="itemSeal.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSealTemp.inActiveDateTemp" name="itemSealTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSealTemp.createdDateTemp" name="itemSealTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSealSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSealCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>