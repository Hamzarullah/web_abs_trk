
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
        txtBankCode=$("#bank\\.code"),
        txtBankName=$("#bank\\.name"),
        rdbBankActiveStatus=$("#bank\\.activeStatus"),
        txtBankRemark=$("#bank\\.remark"),
        txtBankInActiveBy = $("#bank\\.inActiveBy"),
        dtpBankInActiveDate = $("#bank\\.inActiveDate"),
        txtBankCreatedBy = $("#bank\\.createdBy"),
        dtpBankCreatedDate = $("#bank\\.createdDate"),
        
        allFieldsBank=$([])
            .add(txtBankCode)
            .add(txtBankName)
            .add(txtBankRemark)
            .add(txtBankInActiveBy)
            .add(txtBankCreatedBy);


    function reloadGridBank(){
        $("#bank_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("bank");
        
        $('#bank\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#bankSearchActiveStatusRadActive').prop('checked',true);
        $("#bankSearchActiveStatus").val("true");
        
        $('input[name="bankSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#bankSearchActiveStatus").val(value);
        });
        
        $('input[name="bankSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#bankSearchActiveStatus").val(value);
        });
                
        $('input[name="bankSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#bankSearchActiveStatus").val(value);
        });
        
        $('input[name="bankActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#bank\\.activeStatus").val(value);
            $("#bank\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="bankActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#bank\\.activeStatus").val(value);
        });
        
        $("#btnBankNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/bank-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_bank();
                showInput("bank");
                hideInput("bankSearch");
                $('#bankActiveStatusRadActive').prop('checked',true);
                $("#bank\\.activeStatus").val("true");
                $("#bank\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#bank\\.createdDate").val("01/01/1900 00:00:00");
                txtBankCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtBankCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnBankSave").click(function(ev) {
           if(!$("#frmBankInput").valid()) {
//               handlers_input_bank();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           bankFormatDate();
           if (updateRowId < 0){
               url = "master/bank-save";
           } else{
               url = "master/bank-update";
           }
           
           var params = $("#frmBankInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    bankFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("bank");
                showInput("bankSearch");
                allFieldsBank.val('').siblings('label[class="error"]').hide();
                reloadGridBank();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnBankUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/bank-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_bank();
                updateRowId=$("#bank_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var bank=$("#bank_grid").jqGrid('getRowData',updateRowId);
                var url="master/bank-get-data";
                var params="bank.code=" + bank.code;

                txtBankCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtBankCode.val(data.bankTemp.code);
                        txtBankName.val(data.bankTemp.name);
                        rdbBankActiveStatus.val(data.bankTemp.activeStatus);
                        txtBankRemark.val(data.bankTemp.remark);
                        txtBankInActiveBy.val(data.bankTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.bankTemp.inActiveDate,true);
                        dtpBankInActiveDate.val(inActiveDate);
                        txtBankCreatedBy.val(data.bankTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.bankTemp.createdDate,true);
                        dtpBankCreatedDate.val(createdDate);

                        if(data.bankTemp.activeStatus===true) {
                           $('#bankActiveStatusRadActive').prop('checked',true);
                           $("#bank\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#bankActiveStatusRadInActive').prop('checked',true);              
                           $("#bank\\.activeStatus").val("false");
                        }

                        showInput("bank");
                        hideInput("bankSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnBankDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/bank-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#bank_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var bank=$("#bank_grid").jqGrid('getRowData',deleteRowID);
                var url="master/bank-delete";
                var params="bank.code=" + bank.code;
                var message="Are You Sure To Delete(Code : "+ bank.code + ")?";
                alertMessageDelete("bank",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ bank.code+ ')?</div>');
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
//                                var url="master/bank-delete";
//                                var params="bank.code=" + bank.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridBank();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + bank.code+ ")")){
//                    var url="master/bank-delete";
//                    var params="bank.code=" + bank.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridBank();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnBankCancel").click(function(ev) {
            hideInput("bank");
            showInput("bankSearch");
            allFieldsBank.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnBankRefresh').click(function(ev) {
            $('#bankSearchActiveStatusRadActive').prop('checked',true);
            $("#bankSearchActiveStatus").val("true");
            $("#bank_grid").jqGrid("clearGridData");
            $("#bank_grid").jqGrid("setGridParam",{url:"master/bank-data?"});
            $("#bank_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnBankPrint").click(function(ev) {
            
            var url = "reports/bank-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'bank','width=500,height=500');
        });
        
        $('#btnBank_search').click(function(ev) {
            $("#bank_grid").jqGrid("clearGridData");
            $("#bank_grid").jqGrid("setGridParam",{url:"master/bank-data?" + $("#frmBankSearchInput").serialize()});
            $("#bank_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_bank(){
//        unHandlersInput(txtBankCode);
//        unHandlersInput(txtBankName);
//    }
//
//    function handlers_input_bank(){
//        if(txtBankCode.val()===""){
//            handlersInput(txtBankCode);
//        }else{
//            unHandlersInput(txtBankCode);
//        }
//        if(txtBankName.val()===""){
//            handlersInput(txtBankName);
//        }else{
//            unHandlersInput(txtBankName);
//        }
//    }
    
    function bankFormatDate(){
        var inActiveDate=formatDate(dtpBankInActiveDate.val(),true);
        dtpBankInActiveDate.val(inActiveDate);
        $("#bankTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpBankCreatedDate.val(),true);
        dtpBankCreatedDate.val(createdDate);
        $("#bankTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlBank" action="bank-data" />
<b>Bank</b>
<hr>
<br class="spacer"/>


<sj:div id="bankButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnBankNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnBankUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnBankDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnBankRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnBankPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="bankSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmBankSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="bankSearchCode" name="bankSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="bankSearchName" name="bankSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="bankSearchActiveStatus" name="bankSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="bankSearchActiveStatusRad" name="bankSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnBank_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="bankGrid">
    <sjg:grid
        id="bank_grid"
        dataType="json"
        href="%{remoteurlBank}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listBankTemp"
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
    
<div id="bankInput" class="content ui-widget">
    <s:form id="frmBankInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="bank.code" name="bank.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="bank.name" name="bank.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="bankActiveStatusRad" name="bankActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="bank.activeStatus" name="bank.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="bank.remark" name="bank.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="bank.inActiveBy"  name="bank.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="bank.inActiveDate" name="bank.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="bank.createdBy"  name="bank.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="bank.createdDate" name="bank.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="bankTemp.inActiveDateTemp" name="bankTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="bankTemp.createdDateTemp" name="bankTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnBankSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnBankCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>