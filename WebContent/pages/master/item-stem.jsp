
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
        txtItemStemCode=$("#itemStem\\.code"),
        txtItemStemName=$("#itemStem\\.name"),
        rdbItemStemActiveStatus=$("#itemStem\\.activeStatus"),
        txtItemStemRemark=$("#itemStem\\.remark"),
        txtItemStemInActiveBy = $("#itemStem\\.inActiveBy"),
        dtpItemStemInActiveDate = $("#itemStem\\.inActiveDate"),
        txtItemStemCreatedBy = $("#itemStem\\.createdBy"),
        dtpItemStemCreatedDate = $("#itemStem\\.createdDate"),
        
        allFieldsItemStem=$([])
            .add(txtItemStemCode)
            .add(txtItemStemName)
            .add(txtItemStemRemark)
            .add(txtItemStemInActiveBy)
            .add(txtItemStemCreatedBy);


    function reloadGridItemStem(){
        $("#itemStem_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemStem");
        
        $('#itemStem\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemStemSearchActiveStatusRadActive').prop('checked',true);
        $("#itemStemSearchActiveStatus").val("true");
        
        $('input[name="itemStemSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemStemSearchActiveStatus").val(value);
        });
        
        $('input[name="itemStemSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemStemSearchActiveStatus").val(value);
        });
                
        $('input[name="itemStemSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemStemSearchActiveStatus").val(value);
        });
        
        $('input[name="itemStemActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemStem\\.activeStatus").val(value);
            $("#itemStem\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemStemActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemStem\\.activeStatus").val(value);
        });
        
        $("#btnItemStemNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-stem-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemStem();
                showInput("itemStem");
                hideInput("itemStemSearch");
                $('#itemStemActiveStatusRadActive').prop('checked',true);
                $("#itemStem\\.activeStatus").val("true");
                $("#itemStem\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemStem\\.createdDate").val("01/01/1900 00:00:00");
                txtItemStemCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemStemCode.attr("readonly",true);
                txtItemStemCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemStemSave").click(function(ev) {
           if(!$("#frmItemStemInput").valid()) {
//               handlers_input_itemStem();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemStemFormatDate();
           if (updateRowId < 0){
               url = "master/item-stem-save";
           } else{
               url = "master/item-stem-update";
           }
           
           var params = $("#frmItemStemInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemStemFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemStem");
                showInput("itemStemSearch");
                allFieldsItemStem.val('').siblings('label[class="error"]').hide();
                txtItemStemCode.val("AUTO");
                reloadGridItemStem();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemStemUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-stem-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemStem();
                updateRowId=$("#itemStem_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemStem=$("#itemStem_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-stem-get-data";
                var params="itemStem.code=" + itemStem.code;

                txtItemStemCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemStemCode.val(data.itemStemTemp.code);
                        txtItemStemName.val(data.itemStemTemp.name);
                        rdbItemStemActiveStatus.val(data.itemStemTemp.activeStatus);
                        txtItemStemRemark.val(data.itemStemTemp.remark);
                        txtItemStemInActiveBy.val(data.itemStemTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemStemTemp.inActiveDate,true);
                        dtpItemStemInActiveDate.val(inActiveDate);
                        txtItemStemCreatedBy.val(data.itemStemTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemStemTemp.createdDate,true);
                        dtpItemStemCreatedDate.val(createdDate);

                        if(data.itemStemTemp.activeStatus===true) {
                           $('#itemStemActiveStatusRadActive').prop('checked',true);
                           $("#itemStem\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemStemActiveStatusRadInActive').prop('checked',true);              
                           $("#itemStem\\.activeStatus").val("false");
                        }

                        showInput("itemStem");
                        hideInput("itemStemSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemStemDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-stem-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemStem_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemStem=$("#itemStem_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-stem-delete";
                var params="itemStem.code=" + itemStem.code;
                var message="Are You Sure To Delete(Code : "+ itemStem.code + ")?";
                alertMessageDelete("itemStem",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemStem.code+ ')?</div>');
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
//                                var url="master/item-stem-delete";
//                                var params="itemStem.code=" + itemStem.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemStem();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemStem.code+ ")")){
//                    var url="master/item-stem-delete";
//                    var params="itemStem.code=" + itemStem.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemStem();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemStemCancel").click(function(ev) {
            hideInput("itemStem");
            showInput("itemStemSearch");
            allFieldsItemStem.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemStemRefresh').click(function(ev) {
            $('#itemStemSearchActiveStatusRadActive').prop('checked',true);
            $("#itemStemSearchActiveStatus").val("true");
            $("#itemStem_grid").jqGrid("clearGridData");
            $("#itemStem_grid").jqGrid("setGridParam",{url:"master/item-stem-data?"});
            $("#itemStem_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemStemPrint").click(function(ev) {
            
            var url = "reports/item-stem-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemStem','width=500,height=500');
        });
        
        $('#btnItemStem_search').click(function(ev) {
            $("#itemStem_grid").jqGrid("clearGridData");
            $("#itemStem_grid").jqGrid("setGridParam",{url:"master/item-stem-data?" + $("#frmItemStemSearchInput").serialize()});
            $("#itemStem_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemStem(){
//        unHandlersInput(txtItemStemCode);
//        unHandlersInput(txtItemStemName);
//    }
//
//    function handlers_input_itemStem(){
//        if(txtItemStemCode.val()===""){
//            handlersInput(txtItemStemCode);
//        }else{
//            unHandlersInput(txtItemStemCode);
//        }
//        if(txtItemStemName.val()===""){
//            handlersInput(txtItemStemName);
//        }else{
//            unHandlersInput(txtItemStemName);
//        }
//    }
    
    function itemStemFormatDate(){
        var inActiveDate=formatDate(dtpItemStemInActiveDate.val(),true);
        dtpItemStemInActiveDate.val(inActiveDate);
        $("#itemStemTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemStemCreatedDate.val(),true);
        dtpItemStemCreatedDate.val(createdDate);
        $("#itemStemTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemStem" action="item-stem-data" />
<b>Item Stem</b>
<hr>
<br class="spacer"/>


<sj:div id="itemStemButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemStemNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemStemUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemStemDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemStemRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemStemPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemStemSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemStemSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemStemSearchCode" name="itemStemSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemStemSearchName" name="itemStemSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemStemSearchActiveStatus" name="itemStemSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemStemSearchActiveStatusRad" name="itemStemSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemStem_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemStemGrid">
    <sjg:grid
        id="itemStem_grid"
        dataType="json"
        href="%{remoteurlItemStem}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemStemTemp"
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
    
<div id="itemStemInput" class="content ui-widget">
    <s:form id="frmItemStemInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemStem.code" name="itemStem.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemStem.name" name="itemStem.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemStemActiveStatusRad" name="itemStemActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemStem.activeStatus" name="itemStem.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemStem.remark" name="itemStem.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemStem.inActiveBy"  name="itemStem.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemStem.inActiveDate" name="itemStem.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemStem.createdBy"  name="itemStem.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemStem.createdDate" name="itemStem.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemStemTemp.inActiveDateTemp" name="itemStemTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemStemTemp.createdDateTemp" name="itemStemTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemStemSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemStemCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>