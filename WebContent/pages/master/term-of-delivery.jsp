
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
        txtTermOfDeliveryCode=$("#termOfDelivery\\.code"),
        txtTermOfDeliveryName=$("#termOfDelivery\\.name"),
        rdbTermOfDeliveryActiveStatus=$("#termOfDelivery\\.activeStatus"),
        txtTermOfDeliveryRemark=$("#termOfDelivery\\.remark"),
        txtTermOfDeliveryInActiveBy = $("#termOfDelivery\\.inActiveBy"),
        dtpTermOfDeliveryInActiveDate = $("#termOfDelivery\\.inActiveDate"),
        txtTermOfDeliveryCreatedBy = $("#termOfDelivery\\.createdBy"),
        dtpTermOfDeliveryCreatedDate = $("#termOfDelivery\\.createdDate"),
        
        allFieldsTermOfDelivery=$([])
            .add(txtTermOfDeliveryCode)
            .add(txtTermOfDeliveryName)
            .add(txtTermOfDeliveryRemark)
            .add(txtTermOfDeliveryInActiveBy)
            .add(txtTermOfDeliveryCreatedBy);


    function reloadGridTermOfDelivery(){
        $("#termOfDelivery_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("termOfDelivery");
        
        $('#termOfDelivery\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#termOfDeliverySearchActiveStatusRadActive').prop('checked',true);
        $("#termOfDeliverySearchActiveStatus").val("true");
        
        $('input[name="termOfDeliverySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#termOfDeliverySearchActiveStatus").val(value);
        });
        
        $('input[name="termOfDeliverySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#termOfDeliverySearchActiveStatus").val(value);
        });
                
        $('input[name="termOfDeliverySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#termOfDeliverySearchActiveStatus").val(value);
        });
        
        $('input[name="termOfDeliveryActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#termOfDelivery\\.activeStatus").val(value);
            $("#termOfDelivery\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="termOfDeliveryActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#termOfDelivery\\.activeStatus").val(value);
        });
        
        $("#btnTermOfDeliveryNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/term-of-delivery-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_termOfDelivery();
                showInput("termOfDelivery");
                hideInput("termOfDeliverySearch");
                $('#termOfDeliveryActiveStatusRadActive').prop('checked',true);
                $("#termOfDelivery\\.activeStatus").val("true");
                $("#termOfDelivery\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#termOfDelivery\\.createdDate").val("01/01/1900 00:00:00");
                txtTermOfDeliveryCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtTermOfDeliveryCode.attr("readonly",true);
                txtTermOfDeliveryCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnTermOfDeliverySave").click(function(ev) {
           if(!$("#frmTermOfDeliveryInput").valid()) {
//               handlers_input_termOfDelivery();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           termOfDeliveryFormatDate();
           if (updateRowId < 0){
               url = "master/term-of-delivery-save";
           } else{
               url = "master/term-of-delivery-update";
           }
           
           var params = $("#frmTermOfDeliveryInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    termOfDeliveryFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("termOfDelivery");
                showInput("termOfDeliverySearch");
                allFieldsTermOfDelivery.val('').siblings('label[class="error"]').hide();
                txtTermOfDeliveryCode.val("AUTO");
                
                reloadGridTermOfDelivery();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnTermOfDeliveryUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/term-of-delivery-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_termOfDelivery();
                updateRowId=$("#termOfDelivery_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var termOfDelivery=$("#termOfDelivery_grid").jqGrid('getRowData',updateRowId);
                var url="master/term-of-delivery-get-data";
                var params="termOfDelivery.code=" + termOfDelivery.code;

                txtTermOfDeliveryCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtTermOfDeliveryCode.val(data.termOfDeliveryTemp.code);
                        txtTermOfDeliveryName.val(data.termOfDeliveryTemp.name);
                        rdbTermOfDeliveryActiveStatus.val(data.termOfDeliveryTemp.activeStatus);
                        txtTermOfDeliveryRemark.val(data.termOfDeliveryTemp.remark);
                        txtTermOfDeliveryInActiveBy.val(data.termOfDeliveryTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.termOfDeliveryTemp.inActiveDate,true);
                        dtpTermOfDeliveryInActiveDate.val(inActiveDate);
                        txtTermOfDeliveryCreatedBy.val(data.termOfDeliveryTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.termOfDeliveryTemp.createdDate,true);
                        dtpTermOfDeliveryCreatedDate.val(createdDate);

                        if(data.termOfDeliveryTemp.activeStatus===true) {
                           $('#termOfDeliveryActiveStatusRadActive').prop('checked',true);
                           $("#termOfDelivery\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#termOfDeliveryActiveStatusRadInActive').prop('checked',true);              
                           $("#termOfDelivery\\.activeStatus").val("false");
                        }

                        showInput("termOfDelivery");
                        hideInput("termOfDeliverySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnTermOfDeliveryDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/term-of-delivery-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#termOfDelivery_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var termOfDelivery=$("#termOfDelivery_grid").jqGrid('getRowData',deleteRowID);
                var url="master/term-of-delivery-delete";
                var params="termOfDelivery.code=" + termOfDelivery.code;
                var message="Are You Sure To Delete(Code : "+ termOfDelivery.code + ")?";
                alertMessageDelete("termOfDelivery",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ termOfDelivery.code+ ')?</div>');
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
//                                var url="master/term-of-delivery-delete";
//                                var params="termOfDelivery.code=" + termOfDelivery.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridTermOfDelivery();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + termOfDelivery.code+ ")")){
//                    var url="master/term-of-delivery-delete";
//                    var params="termOfDelivery.code=" + termOfDelivery.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridTermOfDelivery();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnTermOfDeliveryCancel").click(function(ev) {
            hideInput("termOfDelivery");
            showInput("termOfDeliverySearch");
            allFieldsTermOfDelivery.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnTermOfDeliveryRefresh').click(function(ev) {
            $('#termOfDeliverySearchActiveStatusRadActive').prop('checked',true);
            $("#termOfDeliverySearchActiveStatus").val("true");
            $("#termOfDelivery_grid").jqGrid("clearGridData");
            $("#termOfDelivery_grid").jqGrid("setGridParam",{url:"master/term-of-delivery-data?"});
            $("#termOfDelivery_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnTermOfDeliveryPrint").click(function(ev) {
            
            var url = "reports/term-of-delivery-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'termOfDelivery','width=500,height=500');
        });
        
        $('#btnTermOfDelivery_search').click(function(ev) {
            $("#termOfDelivery_grid").jqGrid("clearGridData");
            $("#termOfDelivery_grid").jqGrid("setGridParam",{url:"master/term-of-delivery-data?" + $("#frmTermOfDeliverySearchInput").serialize()});
            $("#termOfDelivery_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_termOfDelivery(){
//        unHandlersInput(txtTermOfDeliveryCode);
//        unHandlersInput(txtTermOfDeliveryName);
//    }
//
//    function handlers_input_termOfDelivery(){
//        if(txtTermOfDeliveryCode.val()===""){
//            handlersInput(txtTermOfDeliveryCode);
//        }else{
//            unHandlersInput(txtTermOfDeliveryCode);
//        }
//        if(txtTermOfDeliveryName.val()===""){
//            handlersInput(txtTermOfDeliveryName);
//        }else{
//            unHandlersInput(txtTermOfDeliveryName);
//        }
//    }
    
    function termOfDeliveryFormatDate(){
        var inActiveDate=formatDate(dtpTermOfDeliveryInActiveDate.val(),true);
        dtpTermOfDeliveryInActiveDate.val(inActiveDate);
        $("#termOfDeliveryTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpTermOfDeliveryCreatedDate.val(),true);
        dtpTermOfDeliveryCreatedDate.val(createdDate);
        $("#termOfDeliveryTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlTermOfDelivery" action="term-of-delivery-data" />
<b>Term Of Delivery</b>
<hr>
<br class="spacer"/>


<sj:div id="termOfDeliveryButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnTermOfDeliveryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnTermOfDeliveryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnTermOfDeliveryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnTermOfDeliveryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnTermOfDeliveryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="termOfDeliverySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmTermOfDeliverySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="termOfDeliverySearchCode" name="termOfDeliverySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="termOfDeliverySearchName" name="termOfDeliverySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="termOfDeliverySearchActiveStatus" name="termOfDeliverySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="termOfDeliverySearchActiveStatusRad" name="termOfDeliverySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnTermOfDelivery_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="termOfDeliveryGrid">
    <sjg:grid
        id="termOfDelivery_grid"
        dataType="json"
        href="%{remoteurlTermOfDelivery}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listTermOfDeliveryTemp"
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
    
<div id="termOfDeliveryInput" class="content ui-widget">
    <s:form id="frmTermOfDeliveryInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="termOfDelivery.code" name="termOfDelivery.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="termOfDelivery.name" name="termOfDelivery.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="termOfDeliveryActiveStatusRad" name="termOfDeliveryActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="termOfDelivery.activeStatus" name="termOfDelivery.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="termOfDelivery.remark" name="termOfDelivery.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="termOfDelivery.inActiveBy"  name="termOfDelivery.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="termOfDelivery.inActiveDate" name="termOfDelivery.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="termOfDelivery.createdBy"  name="termOfDelivery.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="termOfDelivery.createdDate" name="termOfDelivery.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="termOfDeliveryTemp.inActiveDateTemp" name="termOfDeliveryTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="termOfDeliveryTemp.createdDateTemp" name="termOfDeliveryTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnTermOfDeliverySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnTermOfDeliveryCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>