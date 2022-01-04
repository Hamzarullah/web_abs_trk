
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
        txtItemSizeCode=$("#itemSize\\.code"),
        txtItemSizeName=$("#itemSize\\.name"),
        rdbItemSizeActiveStatus=$("#itemSize\\.activeStatus"),
        txtItemSizeRemark=$("#itemSize\\.remark"),
        txtItemSizeInActiveBy = $("#itemSize\\.inActiveBy"),
        dtpItemSizeInActiveDate = $("#itemSize\\.inActiveDate"),
        txtItemSizeCreatedBy = $("#itemSize\\.createdBy"),
        dtpItemSizeCreatedDate = $("#itemSize\\.createdDate"),
        
        allFieldsItemSize=$([])
            .add(txtItemSizeCode)
            .add(txtItemSizeName)
            .add(txtItemSizeRemark)
            .add(txtItemSizeInActiveBy)
            .add(txtItemSizeCreatedBy);


    function reloadGridItemSize(){
        $("#itemSize_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSize");
        
        $('#itemSize\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSizeSearchActiveStatusRadActive').prop('checked',true);
        $("#itemSizeSearchActiveStatus").val("true");
        
        $('input[name="itemSizeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSizeSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSizeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSizeSearchActiveStatus").val(value);
        });
                
        $('input[name="itemSizeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSizeSearchActiveStatus").val(value);
        });
        
        $('input[name="itemSizeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSize\\.activeStatus").val(value);
            $("#itemSize\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSizeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSize\\.activeStatus").val(value);
        });
        
        $("#btnItemSizeNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-size-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSize();
                showInput("itemSize");
                hideInput("itemSizeSearch");
                $('#itemSizeActiveStatusRadActive').prop('checked',true);
                $("#itemSize\\.activeStatus").val("true");
                $("#itemSize\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSize\\.createdDate").val("01/01/1900 00:00:00");
                txtItemSizeCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSizeCode.attr("readonly",true);
                txtItemSizeCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSizeSave").click(function(ev) {
           if(!$("#frmItemSizeInput").valid()) {
//               handlers_input_itemSize();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemSizeFormatDate();
           if (updateRowId < 0){
               url = "master/item-size-save";
           } else{
               url = "master/item-size-update";
           }
           
           var params = $("#frmItemSizeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSizeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSize");
                showInput("itemSizeSearch");
                allFieldsItemSize.val('').siblings('label[class="error"]').hide();
                txtItemSizeCode.val("AUTO");
                reloadGridItemSize();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSizeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-size-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSize();
                updateRowId=$("#itemSize_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSize=$("#itemSize_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-size-get-data";
                var params="itemSize.code=" + itemSize.code;

                txtItemSizeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSizeCode.val(data.itemSizeTemp.code);
                        txtItemSizeName.val(data.itemSizeTemp.name);
                        rdbItemSizeActiveStatus.val(data.itemSizeTemp.activeStatus);
                        txtItemSizeRemark.val(data.itemSizeTemp.remark);
                        txtItemSizeInActiveBy.val(data.itemSizeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSizeTemp.inActiveDate,true);
                        dtpItemSizeInActiveDate.val(inActiveDate);
                        txtItemSizeCreatedBy.val(data.itemSizeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSizeTemp.createdDate,true);
                        dtpItemSizeCreatedDate.val(createdDate);

                        if(data.itemSizeTemp.activeStatus===true) {
                           $('#itemSizeActiveStatusRadActive').prop('checked',true);
                           $("#itemSize\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSizeActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSize\\.activeStatus").val("false");
                        }

                        showInput("itemSize");
                        hideInput("itemSizeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSizeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-size-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSize_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSize=$("#itemSize_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-size-delete";
                var params="itemSize.code=" + itemSize.code;
                var message="Are You Sure To Delete(Code : "+ itemSize.code + ")?";
                alertMessageDelete("itemSize",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSize.code+ ')?</div>');
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
//                                var url="master/item-size-delete";
//                                var params="itemSize.code=" + itemSize.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSize();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSize.code+ ")")){
//                    var url="master/item-size-delete";
//                    var params="itemSize.code=" + itemSize.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSize();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSizeCancel").click(function(ev) {
            hideInput("itemSize");
            showInput("itemSizeSearch");
            allFieldsItemSize.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSizeRefresh').click(function(ev) {
            $('#itemSizeSearchActiveStatusRadActive').prop('checked',true);
            $("#itemSizeSearchActiveStatus").val("true");
            $("#itemSize_grid").jqGrid("clearGridData");
            $("#itemSize_grid").jqGrid("setGridParam",{url:"master/item-size-data?"});
            $("#itemSize_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSizePrint").click(function(ev) {
            
            var url = "reports/item-size-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSize','width=500,height=500');
        });
        
        $('#btnItemSize_search').click(function(ev) {
            $("#itemSize_grid").jqGrid("clearGridData");
            $("#itemSize_grid").jqGrid("setGridParam",{url:"master/item-size-data?" + $("#frmItemSizeSearchInput").serialize()});
            $("#itemSize_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSize(){
//        unHandlersInput(txtItemSizeCode);
//        unHandlersInput(txtItemSizeName);
//    }
//
//    function handlers_input_itemSize(){
//        if(txtItemSizeCode.val()===""){
//            handlersInput(txtItemSizeCode);
//        }else{
//            unHandlersInput(txtItemSizeCode);
//        }
//        if(txtItemSizeName.val()===""){
//            handlersInput(txtItemSizeName);
//        }else{
//            unHandlersInput(txtItemSizeName);
//        }
//    }
    
    function itemSizeFormatDate(){
        var inActiveDate=formatDate(dtpItemSizeInActiveDate.val(),true);
        dtpItemSizeInActiveDate.val(inActiveDate);
        $("#itemSizeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSizeCreatedDate.val(),true);
        dtpItemSizeCreatedDate.val(createdDate);
        $("#itemSizeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSize" action="item-size-data" />
<b>Item Size</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSizeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSizeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSizeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSizeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSizeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSizePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSizeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSizeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSizeSearchCode" name="itemSizeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSizeSearchName" name="itemSizeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSizeSearchActiveStatus" name="itemSizeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSizeSearchActiveStatusRad" name="itemSizeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSize_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSizeGrid">
    <sjg:grid
        id="itemSize_grid"
        dataType="json"
        href="%{remoteurlItemSize}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSizeTemp"
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
    
<div id="itemSizeInput" class="content ui-widget">
    <s:form id="frmItemSizeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSize.code" name="itemSize.code" title="*" required="true" cssClass="required" maxLength="16" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSize.name" name="itemSize.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSizeActiveStatusRad" name="itemSizeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSize.activeStatus" name="itemSize.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSize.remark" name="itemSize.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSize.inActiveBy"  name="itemSize.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSize.inActiveDate" name="itemSize.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSize.createdBy"  name="itemSize.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSize.createdDate" name="itemSize.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSizeTemp.inActiveDateTemp" name="itemSizeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSizeTemp.createdDateTemp" name="itemSizeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSizeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSizeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>