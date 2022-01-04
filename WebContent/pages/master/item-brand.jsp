
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
        txtItemBrandCode=$("#itemBrand\\.code"),
        txtItemBrandName=$("#itemBrand\\.name"),
        rdbItemBrandActiveStatus=$("#itemBrand\\.activeStatus"),
        txtItemBrandRemark=$("#itemBrand\\.remark"),
        txtItemBrandInActiveBy = $("#itemBrand\\.inActiveBy"),
        dtpItemBrandInActiveDate = $("#itemBrand\\.inActiveDate"),
        txtItemBrandCreatedBy = $("#itemBrand\\.createdBy"),
        dtpItemBrandCreatedDate = $("#itemBrand\\.createdDate"),
        
        allFieldsItemBrand=$([])
            .add(txtItemBrandCode)
            .add(txtItemBrandName)
            .add(txtItemBrandRemark)
            .add(txtItemBrandInActiveBy)
            .add(txtItemBrandCreatedBy);


    function reloadGridItemBrand(){
        $("#itemBrand_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemBrand");
        
        $('#itemBrand\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemBrandSearchActiveStatusRadActive').prop('checked',true);
        $("#itemBrandSearchActiveStatus").val("true");
        
        $('input[name="itemBrandSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemBrandSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBrandSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBrandSearchActiveStatus").val(value);
        });
                
        $('input[name="itemBrandSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBrandSearchActiveStatus").val(value);
        });
        
        $('input[name="itemBrandActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemBrand\\.activeStatus").val(value);
            $("#itemBrand\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemBrandActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemBrand\\.activeStatus").val(value);
        });
        
        $("#btnItemBrandNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-brand-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBrand();
                showInput("itemBrand");
                hideInput("itemBrandSearch");
                $('#itemBrandActiveStatusRadActive').prop('checked',true);
                $("#itemBrand\\.activeStatus").val("true");
                $("#itemBrand\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemBrand\\.createdDate").val("01/01/1900 00:00:00");
                txtItemBrandCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemBrandCode.attr("readonly",true);
                txtItemBrandCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBrandSave").click(function(ev) {
           if(!$("#frmItemBrandInput").valid()) {
//               handlers_input_itemBrand();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           itemBrandFormatDate();
           if (updateRowId < 0){
               url = "master/item-brand-save";
           } else{
               url = "master/item-brand-update";
           }
           
           var params = $("#frmItemBrandInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemBrandFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemBrand");
                showInput("itemBrandSearch");
                allFieldsItemBrand.val('').siblings('label[class="error"]').hide();
                txtItemBrandCode.val("AUTO");
                reloadGridItemBrand();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemBrandUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-brand-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemBrand();
                updateRowId=$("#itemBrand_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemBrand=$("#itemBrand_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-brand-get-data";
                var params="itemBrand.code=" + itemBrand.code;

                txtItemBrandCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemBrandCode.val(data.itemBrandTemp.code);
                        txtItemBrandName.val(data.itemBrandTemp.name);
                        rdbItemBrandActiveStatus.val(data.itemBrandTemp.activeStatus);
                        txtItemBrandRemark.val(data.itemBrandTemp.remark);
                        txtItemBrandInActiveBy.val(data.itemBrandTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemBrandTemp.inActiveDate,true);
                        dtpItemBrandInActiveDate.val(inActiveDate);
                        txtItemBrandCreatedBy.val(data.itemBrandTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemBrandTemp.createdDate,true);
                        dtpItemBrandCreatedDate.val(createdDate);

                        if(data.itemBrandTemp.activeStatus===true) {
                           $('#itemBrandActiveStatusRadActive').prop('checked',true);
                           $("#itemBrand\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemBrandActiveStatusRadInActive').prop('checked',true);              
                           $("#itemBrand\\.activeStatus").val("false");
                        }

                        showInput("itemBrand");
                        hideInput("itemBrandSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemBrandDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-brand-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemBrand_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemBrand=$("#itemBrand_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-brand-delete";
                var params="itemBrand.code=" + itemBrand.code;
                var message="Are You Sure To Delete(Code : "+ itemBrand.code + ")?";
                alertMessageDelete("itemBrand",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemBrand.code+ ')?</div>');
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
//                                var url="master/itemBrand-delete";
//                                var params="itemBrand.code=" + itemBrand.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemBrand();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemBrand.code+ ")")){
//                    var url="master/itemBrand-delete";
//                    var params="itemBrand.code=" + itemBrand.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemBrand();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemBrandCancel").click(function(ev) {
            hideInput("itemBrand");
            showInput("itemBrandSearch");
            allFieldsItemBrand.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemBrandRefresh').click(function(ev) {
            $('#itemBrandSearchActiveStatusRadActive').prop('checked',true);
            $("#itemBrandSearchActiveStatus").val("true");
            $("#itemBrand_grid").jqGrid("clearGridData");
            $("#itemBrand_grid").jqGrid("setGridParam",{url:"master/itemBrand-data?"});
            $("#itemBrand_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemBrandPrint").click(function(ev) {
            
            var url = "reports/item-brand-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemBrand','width=500,height=500');
        });
        
        $('#btnItemBrand_search').click(function(ev) {
            $("#itemBrand_grid").jqGrid("clearGridData");
            $("#itemBrand_grid").jqGrid("setGridParam",{url:"master/item-brand-data?" + $("#frmItemBrandSearchInput").serialize()});
            $("#itemBrand_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemBrand(){
//        unHandlersInput(txtItemBrandCode);
//        unHandlersInput(txtItemBrandName);
//    }
//
//    function handlers_input_itemBrand(){
//        if(txtItemBrandCode.val()===""){
//            handlersInput(txtItemBrandCode);
//        }else{
//            unHandlersInput(txtItemBrandCode);
//        }
//        if(txtItemBrandName.val()===""){
//            handlersInput(txtItemBrandName);
//        }else{
//            unHandlersInput(txtItemBrandName);
//        }
//    }
    
    function itemBrandFormatDate(){
        var inActiveDate=formatDate(dtpItemBrandInActiveDate.val(),true);
        dtpItemBrandInActiveDate.val(inActiveDate);
        $("#itemBrandTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemBrandCreatedDate.val(),true);
        dtpItemBrandCreatedDate.val(createdDate);
        $("#itemBrandTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemBrand" action="item-brand-data" />
<b>Item Brand</b>
<hr>
<br class="spacer"/>


<sj:div id="itemBrandButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemBrandNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemBrandUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemBrandDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemBrandRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemBrandPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemBrandSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemBrandSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemBrandSearchCode" name="itemBrandSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemBrandSearchName" name="itemBrandSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemBrandSearchActiveStatus" name="itemBrandSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemBrandSearchActiveStatusRad" name="itemBrandSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemBrand_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemBrandGrid">
    <sjg:grid
        id="itemBrand_grid"
        dataType="json"
        href="%{remoteurlItemBrand}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemBrandTemp"
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
    
<div id="itemBrandInput" class="content ui-widget">
    <s:form id="frmItemBrandInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemBrand.code" name="itemBrand.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemBrand.name" name="itemBrand.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemBrandActiveStatusRad" name="itemBrandActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemBrand.activeStatus" name="itemBrand.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemBrand.remark" name="itemBrand.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemBrand.inActiveBy"  name="itemBrand.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="itemBrand.inActiveDate" name="itemBrand.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBrand.createdBy"  name="itemBrand.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemBrand.createdDate" name="itemBrand.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemBrandTemp.inActiveDateTemp" name="itemBrandTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemBrandTemp.createdDateTemp" name="itemBrandTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemBrandSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemBrandCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>