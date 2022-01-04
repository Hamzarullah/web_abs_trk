
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
        txtItemBackseatCode=$("#itemBackseat\\.code"),
        txtItemBackseatName=$("#itemBackseat\\.name"),
        rdbItemBackseatActiveStatus=$("#itemBackseat\\.activeStatus"),
        txtItemBackseatRemark=$("#itemBackseat\\.remark"),
        txtItemBackseatInActiveBy = $("#itemBackseat\\.inActiveBy"),
        dtpItemBackseatInActiveDate = $("#itemBackseat\\.inActiveDate"),
        txtItemBackseatCreatedBy = $("#itemBackseat\\.createdBy"),
        dtpItemBackseatCreatedDate = $("#itemBackseat\\.createdDate"),
        
        allFieldsItemBackseat=$([])
            .add(txtItemBackseatCode)
            .add(txtItemBackseatName)
            .add(txtItemBackseatRemark)
            .add(txtItemBackseatInActiveBy)
            .add(txtItemBackseatCreatedBy);


    function reloadGridItemBackseat(){
        $("#itemBackseat_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBackseat");
        
        $('#itemBackseat\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBackseatSearchActiveStatusRadActive').prop('checked',true);
        $("#itemBackseatSearchActiveStatus").val("true");
        
        $('input[name="itemBackseatSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBackseatSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBackseatSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBackseatSearchActiveStatus").val(value);
        });
                
        $('input[name="itemBackseatSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBackseatSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBackseatActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBackseat\\.activeStatus").val(value);
            $("#itemBackseat\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBackseatActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBackseat\\.activeStatus").val(value);
        });
        
        $("#btnItemBackseatNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-backseat-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBackseat();
                showInput("itemBackseat");
                hideInput("itemBackseatSearch");
                $('#itemBackseatActiveStatusRadActive').prop('checked',true);
                $("#itemBackseat\\.activeStatus").val("true");
                $("#itemBackseat\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBackseat\\.createdDate").val("01/01/1900 00:00:00");
//                txtItemBackseatCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBackseatCode.val("AUTO");
                txtItemBackseatCode.attr("readonly",true);
                
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBackseatSave").click(function(ev) {
           if(!$("#frmItemBackseatInput").valid()) {
//               handlers_input_itemBackseat();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBackseatFormatDate();
           if (updateRowId < 0){
               url = "master/item-backseat-save";
           } else{
               url = "master/item-backseat-update";
           }
           
           var params = $("#frmItemBackseatInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBackseatFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBackseat");
                showInput("itemBackseatSearch");
                allFieldsItemBackseat.val('').siblings('label[class="error"]').hide();
                txtItemBackseatCode.val("AUTO");
                reloadGridItemBackseat();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBackseatUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-backseat-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBackseat();
                updateRowId=$("#itemBackseat_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBackseat=$("#itemBackseat_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-backseat-get-data";
                var params="itemBackseat.code=" + itemBackseat.code;

                txtItemBackseatCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBackseatCode.val(data.itemBackseatTemp.code);
                        txtItemBackseatName.val(data.itemBackseatTemp.name);
                        rdbItemBackseatActiveStatus.val(data.itemBackseatTemp.activeStatus);
                        txtItemBackseatRemark.val(data.itemBackseatTemp.remark);
                        txtItemBackseatInActiveBy.val(data.itemBackseatTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBackseatTemp.inActiveDate,true);
                        dtpItemBackseatInActiveDate.val(inActiveDate);
                        txtItemBackseatCreatedBy.val(data.itemBackseatTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBackseatTemp.createdDate,true);
                        dtpItemBackseatCreatedDate.val(createdDate);

                        if(data.itemBackseatTemp.activeStatus===true) {
                           $('#itemBackseatActiveStatusRadActive').prop('checked',true);
                           $("#itemBackseat\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBackseatActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBackseat\\.activeStatus").val("false");
                        }

                        showInput("itemBackseat");
                        hideInput("itemBackseatSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBackseatDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-backseat-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBackseat_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBackseat=$("#itemBackseat_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-backseat-delete";
                var params="itemBackseat.code=" + itemBackseat.code;
                var message="Are You Sure To Delete(Code : "+ itemBackseat.code + ")?";
                alertMessageDelete("itemBackseat",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBackseat.code+ ')?</div>');
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
//                                var url="master/itemBackseat-delete";
//                                var params="itemBackseat.code=" + itemBackseat.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBackseat();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBackseat.code+ ")")){
//                    var url="master/itemBackseat-delete";
//                    var params="itemBackseat.code=" + itemBackseat.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBackseat();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBackseatCancel").click(function(ev) {
            hideInput("itemBackseat");
            showInput("itemBackseatSearch");
            allFieldsItemBackseat.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBackseatRefresh').click(function(ev) {
            $('#itemBackseatSearchActiveStatusRadActive').prop('checked',true);
            $("#itemBackseatSearchActiveStatus").val("true");
            $("#itemBackseat_grid").jqGrid("clearGridData");
            $("#itemBackseat_grid").jqGrid("setGridParam",{url:"master/itemBackseat-data?"});
            $("#itemBackseat_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBackseatPrint").click(function(ev) {
            
            var url = "reports/item-backseat-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBackseat','width=500,height=500');
        });
        
        $('#btnItemBackseat_search').click(function(ev) {
            $("#itemBackseat_grid").jqGrid("clearGridData");
            $("#itemBackseat_grid").jqGrid("setGridParam",{url:"master/item-backseat-data?" + $("#frmItemBackseatSearchInput").serialize()});
            $("#itemBackseat_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBackseat(){
//        unHandlersInput(txtItemBackseatCode);
//        unHandlersInput(txtItemBackseatName);
//    }
//
//    function handlers_input_itemBackseat(){
//        if(txtItemBackseatCode.val()===""){
//            handlersInput(txtItemBackseatCode);
//        }else{
//            unHandlersInput(txtItemBackseatCode);
//        }
//        if(txtItemBackseatName.val()===""){
//            handlersInput(txtItemBackseatName);
//        }else{
//            unHandlersInput(txtItemBackseatName);
//        }
//    }
    
    function itemBackseatFormatDate(){
        var inActiveDate=formatDate(dtpItemBackseatInActiveDate.val(),true);
        dtpItemBackseatInActiveDate.val(inActiveDate);
        $("#itemBackseatTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBackseatCreatedDate.val(),true);
        dtpItemBackseatCreatedDate.val(createdDate);
        $("#itemBackseatTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBackseat" action="item-backseat-data" />
<b>Item Backseat</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBackseatButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBackseatNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBackseatUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBackseatDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBackseatRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBackseatPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBackseatSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBackseatSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBackseatSearchCode" name="itemBackseatSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBackseatSearchName" name="itemBackseatSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBackseatSearchActiveStatus" name="itemBackseatSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBackseatSearchActiveStatusRad" name="itemBackseatSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBackseat_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBackseatGrid">
    <sjg:grid
        id="itemBackseat_grid"
        dataType="json"
        href="%{remoteurlItemBackseat}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBackseatTemp"
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
    
<div id="itemBackseatInput" class="content ui-widget">
    <s:form id="frmItemBackseatInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBackseat.code" name="itemBackseat.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBackseat.name" name="itemBackseat.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBackseatActiveStatusRad" name="itemBackseatActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBackseat.activeStatus" name="itemBackseat.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBackseat.remark" name="itemBackseat.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBackseat.inActiveBy"  name="itemBackseat.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemBackseat.inActiveDate" name="itemBackseat.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBackseat.createdBy"  name="itemBackseat.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBackseat.createdDate" name="itemBackseat.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBackseatTemp.inActiveDateTemp" name="itemBackseatTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBackseatTemp.createdDateTemp" name="itemBackseatTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBackseatSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBackseatCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>