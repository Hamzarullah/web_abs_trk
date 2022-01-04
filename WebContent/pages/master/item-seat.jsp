
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
        txtItemSeatCode=$("#itemSeat\\.code"),
        txtItemSeatName=$("#itemSeat\\.name"),
        rdbItemSeatActiveStatus=$("#itemSeat\\.activeStatus"),
        txtItemSeatRemark=$("#itemSeat\\.remark"),
        txtItemSeatInActiveBy = $("#itemSeat\\.inActiveBy"),
        dtpItemSeatInActiveDate = $("#itemSeat\\.inActiveDate"),
        txtItemSeatCreatedBy = $("#itemSeat\\.createdBy"),
        dtpItemSeatCreatedDate = $("#itemSeat\\.createdDate"),
        
        allFieldsItemSeat=$([])
            .add(txtItemSeatCode)
            .add(txtItemSeatName)
            .add(txtItemSeatRemark)
            .add(txtItemSeatInActiveBy)
            .add(txtItemSeatCreatedBy);


    function reloadGridItemSeat(){
        $("#itemSeat_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSeat");
        
        $('#itemSeat\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSeatSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSeatSearchActiveStatus").val("true");
        
        $('input[name="itemSeatSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSeatSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSeatSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeatSearchActiveStatus").val(value);
        });
                
        $('input[name="itemSeatSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeatSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSeatActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSeat\\.activeStatus").val(value);
            $("#itemSeat\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSeatActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSeat\\.activeStatus").val(value);
        });
        
        $("#btnItemSeatNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeat();
                showInput("itemSeat");
                hideInput("itemSeatSearch");
                $('#itemSeatActiveStatusRadActive').prop('checked',true);
                $("#itemSeat\\.activeStatus").val("true");
                $("#itemSeat\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSeat\\.createdDate").val("01/01/1900 00:00:00");
                txtItemSeatCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSeatCode.attr("readonly",true);
                txtItemSeatCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSeatSave").click(function(ev) {
           if(!$("#frmItemSeatInput").valid()) {
//               handlers_input_itemSeat();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemSeatFormatDate();
           if (updateRowId < 0){
               url = "master/item-seat-save";
           } else{
               url = "master/item-seat-update";
           }
           
           var params = $("#frmItemSeatInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSeatFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSeat");
                showInput("itemSeatSearch");
                allFieldsItemSeat.val('').siblings('label[class="error"]').hide();
                txtItemSeatCode.val("AUTO");
                reloadGridItemSeat();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSeatUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSeat();
                updateRowId=$("#itemSeat_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSeat=$("#itemSeat_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-seat-get-data";
                var params="itemSeat.code=" + itemSeat.code;

                txtItemSeatCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSeatCode.val(data.itemSeatTemp.code);
                        txtItemSeatName.val(data.itemSeatTemp.name);
                        rdbItemSeatActiveStatus.val(data.itemSeatTemp.activeStatus);
                        txtItemSeatRemark.val(data.itemSeatTemp.remark);
                        txtItemSeatInActiveBy.val(data.itemSeatTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSeatTemp.inActiveDate,true);
                        dtpItemSeatInActiveDate.val(inActiveDate);
                        txtItemSeatCreatedBy.val(data.itemSeatTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSeatTemp.createdDate,true);
                        dtpItemSeatCreatedDate.val(createdDate);

                        if(data.itemSeatTemp.activeStatus===true) {
                           $('#itemSeatActiveStatusRadActive').prop('checked',true);
                           $("#itemSeat\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSeatActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSeat\\.activeStatus").val("false");
                        }

                        showInput("itemSeat");
                        hideInput("itemSeatSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSeatDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-seat-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSeat_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSeat=$("#itemSeat_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-seat-delete";
                var params="itemSeat.code=" + itemSeat.code;
                var message="Are You Sure To Delete(Code : "+ itemSeat.code + ")?";
                alertMessageDelete("itemSeat",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSeat.code+ ')?</div>');
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
//                                var url="master/item-seat-delete";
//                                var params="itemSeat.code=" + itemSeat.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSeat();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSeat.code+ ")")){
//                    var url="master/item-seat-delete";
//                    var params="itemSeat.code=" + itemSeat.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSeat();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSeatCancel").click(function(ev) {
            hideInput("itemSeat");
            showInput("itemSeatSearch");
            allFieldsItemSeat.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSeatRefresh').click(function(ev) {
            $('#itemSeatSearchActiveStatusRadActive').prop('checked',true);
            $("#itemSeatSearchActiveStatus").val("true");
            $("#itemSeat_grid").jqGrid("clearGridData");
            $("#itemSeat_grid").jqGrid("setGridParam",{url:"master/item-seat-data?"});
            $("#itemSeat_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSeatPrint").click(function(ev) {
            
            var url = "reports/item-seat-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSeat','width=500,height=500');
        });
        
        $('#btnItemSeat_search').click(function(ev) {
            $("#itemSeat_grid").jqGrid("clearGridData");
            $("#itemSeat_grid").jqGrid("setGridParam",{url:"master/item-seat-data?" + $("#frmItemSeatSearchInput").serialize()});
            $("#itemSeat_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSeat(){
//        unHandlersInput(txtItemSeatCode);
//        unHandlersInput(txtItemSeatName);
//    }
//
//    function handlers_input_itemSeat(){
//        if(txtItemSeatCode.val()===""){
//            handlersInput(txtItemSeatCode);
//        }else{
//            unHandlersInput(txtItemSeatCode);
//        }
//        if(txtItemSeatName.val()===""){
//            handlersInput(txtItemSeatName);
//        }else{
//            unHandlersInput(txtItemSeatName);
//        }
//    }
    
    function itemSeatFormatDate(){
        var inActiveDate=formatDate(dtpItemSeatInActiveDate.val(),true);
        dtpItemSeatInActiveDate.val(inActiveDate);
        $("#itemSeatTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSeatCreatedDate.val(),true);
        dtpItemSeatCreatedDate.val(createdDate);
        $("#itemSeatTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSeat" action="item-seat-data" />
<b>Item Seat</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSeatButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSeatNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSeatUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSeatDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSeatRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSeatPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSeatSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSeatSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSeatSearchCode" name="itemSeatSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSeatSearchName" name="itemSeatSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSeatSearchActiveStatus" name="itemSeatSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSeatSearchActiveStatusRad" name="itemSeatSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSeat_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSeatGrid">
    <sjg:grid
        id="itemSeat_grid"
        dataType="json"
        href="%{remoteurlItemSeat}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSeatTemp"
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
    
<div id="itemSeatInput" class="content ui-widget">
    <s:form id="frmItemSeatInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSeat.code" name="itemSeat.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSeat.name" name="itemSeat.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSeatActiveStatusRad" name="itemSeatActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSeat.activeStatus" name="itemSeat.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSeat.remark" name="itemSeat.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSeat.inActiveBy"  name="itemSeat.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSeat.inActiveDate" name="itemSeat.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeat.createdBy"  name="itemSeat.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSeat.createdDate" name="itemSeat.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSeatTemp.inActiveDateTemp" name="itemSeatTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSeatTemp.createdDateTemp" name="itemSeatTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSeatSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSeatCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>