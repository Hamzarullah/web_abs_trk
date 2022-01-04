
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
        txtCashAccountCode=$("#cashAccount\\.code"),
        txtCashAccountName=$("#cashAccount\\.name"),
        txtCashAccountBKMVoucherNo=$("#cashAccount\\.bkmVoucherNo"),
        txtCashAccountBKKVoucherNo=$("#cashAccount\\.bkkVoucherNo"),
        txtCashAccountChartOfAccountName=$("#cashAccount\\.chartOfAccount\\.name"),
        txtCashAccountChartOfAccountCode=$("#cashAccount\\.chartOfAccount\\.code"),
        rdbCashAccountActiveStatus=$("#cashAccount\\.activeStatus"),
        txtCashAccountRemark=$("#cashAccount\\.remark"),
        txtCashAccountInActiveBy = $("#cashAccount\\.inActiveBy"),
        dtpCashAccountInActiveDate = $("#cashAccount\\.inActiveDate"),
        txtCashAccountCreatedBy = $("#cashAccount\\.createdBy"),
        dtpCashAccountCreatedDate = $("#cashAccount\\.createdDate"),
        
        allFieldsCashAccount=$([])
            .add(txtCashAccountCode)
            .add(txtCashAccountName)
            .add(txtCashAccountBKMVoucherNo)
            .add(txtCashAccountBKKVoucherNo)
            .add(txtCashAccountChartOfAccountName)
            .add(txtCashAccountChartOfAccountName)
            .add(txtCashAccountRemark)
            .add(txtCashAccountInActiveBy)
            .add(txtCashAccountCreatedBy);


    function reloadGridCashAccount(){
        $("#cashAccount_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("cashAccount");
        
        $('#cashAccount\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#cashAccountSearchActiveStatusRadActive').prop('checked',true);
        $("#cashAccountSearchActiveStatus").val("true");
        
        $('input[name="cashAccountSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#cashAccountSearchActiveStatus").val(value);
        });
        
        $('input[name="cashAccountSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#cashAccountSearchActiveStatus").val(value);
        });
                
        $('input[name="cashAccountSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#cashAccountSearchActiveStatus").val(value);
        });
        
        $('input[name="cashAccountActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#cashAccount\\.activeStatus").val(value);
            $("#cashAccount\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="cashAccountActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#cashAccount\\.activeStatus").val(value);
        });
        
        $("#btnCashAccountNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/cash-account-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_cashAccount();
                showInput("cashAccount");
                hideInput("cashAccountSearch");
                $('#cashAccountActiveStatusRadActive').prop('checked',true);
                $("#cashAccount\\.activeStatus").val("true");
                $("#cashAccount\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#cashAccount\\.createdDate").val("01/01/1900 00:00:00");
                txtCashAccountCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtCashAccountCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCashAccountSave").click(function(ev) {
           if(!$("#frmCashAccountInput").valid()) {
//               handlers_input_cashAccount();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           cashAccountFormatDate();
           if (updateRowId < 0){
               url = "master/cash-account-save";
           } else{
               url = "master/cash-account-update";
           }
           
           var params = $("#frmCashAccountInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    cashAccountFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("cashAccount");
                showInput("cashAccountSearch");
                allFieldsCashAccount.val('').siblings('label[class="error"]').hide();
                reloadGridCashAccount();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCashAccountUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/cash-account-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_cashAccount();
                updateRowId=$("#cashAccount_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var cashAccount=$("#cashAccount_grid").jqGrid('getRowData',updateRowId);
                var url="master/cash-account-get-data";
                var params="cashAccount.code=" + cashAccount.code;

                txtCashAccountCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCashAccountCode.val(data.cashAccountTemp.code);
                        txtCashAccountName.val(data.cashAccountTemp.name);
                        txtCashAccountBKMVoucherNo.val(data.cashAccountTemp.bkmVoucherNo);
                        txtCashAccountBKKVoucherNo.val(data.cashAccountTemp.bkkVoucherNo);
                        txtCashAccountChartOfAccountCode.val(data.cashAccountTemp.chartOfAccountCode);
                        rdbCashAccountActiveStatus.val(data.cashAccountTemp.activeStatus);
                        txtCashAccountRemark.val(data.cashAccountTemp.remark);
                        txtCashAccountInActiveBy.val(data.cashAccountTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.cashAccountTemp.inActiveDate,true);
                        dtpCashAccountInActiveDate.val(inActiveDate);
                        txtCashAccountCreatedBy.val(data.cashAccountTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.cashAccountTemp.createdDate,true);
                        dtpCashAccountCreatedDate.val(createdDate);

                        if(data.cashAccountTemp.activeStatus===true) {
                           $('#cashAccountActiveStatusRadActive').prop('checked',true);
                           $("#cashAccount\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#cashAccountActiveStatusRadInActive').prop('checked',true);              
                           $("#cashAccount\\.activeStatus").val("false");
                        }

                        showInput("cashAccount");
                        hideInput("cashAccountSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCashAccountDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/cash-account-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#cashAccount_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var cashAccount=$("#cashAccount_grid").jqGrid('getRowData',deleteRowID);
                var url="master/cash-account-delete";
                var params="cashAccount.code=" + cashAccount.code;
                var message="Are You Sure To Delete(Code : "+ cashAccount.code + ")?";
                alertMessageDelete("cashAccount",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ cashAccount.code+ ')?</div>');
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
//                                var url="master/cash-account-delete";
//                                var params="cashAccount.code=" + cashAccount.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridCashAccount();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + cashAccount.code+ ")")){
//                    var url="master/cash-account-delete";
//                    var params="cashAccount.code=" + cashAccount.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridCashAccount();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnCashAccountCancel").click(function(ev) {
            hideInput("cashAccount");
            showInput("cashAccountSearch");
            allFieldsCashAccount.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCashAccountRefresh').click(function(ev) {
            $('#cashAccountSearchActiveStatusRadActive').prop('checked',true);
            $("#cashAccountSearchActiveStatus").val("true");
            $("#cashAccount_grid").jqGrid("clearGridData");
            $("#cashAccount_grid").jqGrid("setGridParam",{url:"master/cash-account-data?"});
            $("#cashAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCashAccountPrint").click(function(ev) {
            
            var url = "reports/cash-account-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'cashAccount','width=500,height=500');
        });
        
        $('#btnCashAccount_search').click(function(ev) {
            $("#cashAccount_grid").jqGrid("clearGridData");
            $("#cashAccount_grid").jqGrid("setGridParam",{url:"master/cash-account-data?" + $("#frmCashAccountSearchInput").serialize()});
            $("#cashAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#cashAccount_btnchartOfAccount').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=cashAccount&idsubdoc=chartOfAccount&idacctype=S","Search", "Scrollbars=1,width=600, height=500");
        });
    });
    
//    function unHandlers_input_cashAccount(){
//        unHandlersInput(txtCashAccountCode);
//        unHandlersInput(txtCashAccountName);
//    }
//
//    function handlers_input_cashAccount(){
//        if(txtCashAccountCode.val()===""){
//            handlersInput(txtCashAccountCode);
//        }else{
//            unHandlersInput(txtCashAccountCode);
//        }
//        if(txtCashAccountName.val()===""){
//            handlersInput(txtCashAccountName);
//        }else{
//            unHandlersInput(txtCashAccountName);
//        }
//    }
    
    function cashAccountFormatDate(){
        var inActiveDate=formatDate(dtpCashAccountInActiveDate.val(),true);
        dtpCashAccountInActiveDate.val(inActiveDate);
        $("#cashAccountTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCashAccountCreatedDate.val(),true);
        dtpCashAccountCreatedDate.val(createdDate);
        $("#cashAccountTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlCashAccount" action="cash-account-data" />
<b>CASH ACCOUNT</b>
<hr>
<br class="spacer"/>


<sj:div id="cashAccountButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCashAccountNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCashAccountUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCashAccountDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCashAccountRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCashAccountPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="cashAccountSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCashAccountSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="cashAccountSearchCode" name="cashAccountSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="cashAccountSearchName" name="cashAccountSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="cashAccountSearchActiveStatus" name="cashAccountSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="cashAccountSearchActiveStatusRad" name="cashAccountSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCashAccount_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="cashAccountGrid">
    <sjg:grid
        id="cashAccount_grid"
        dataType="json"
        href="%{remoteurlCashAccount}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCashAccountTemp"
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
            name="name" index="name" title="Name" width="200" sortable="true"
        />  
        <sjg:gridColumn
            name="bkmVoucherNo" index="bkmVoucherNo" key="bkmVoucherNo" title="BKMVoucherNo" width="150" sortable="true"
        />  
        <sjg:gridColumn
            name="bkkVoucherNo" index="bkkVoucherNo" key="bkkVoucherNo" title="BKKVoucherNo" width="150" sortable="true"
        />  
        <sjg:gridColumn
            name="chartOfAccountCode" index="chartOfAccountCode" key="chartOfAccountCode" title="ChartOfAccountCode" width="150" sortable="true"
        /> 
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="cashAccountInput" class="content ui-widget">
    <s:form id="frmCashAccountInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="cashAccount.code" name="cashAccount.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="cashAccount.name" name="cashAccount.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <tr>
                <td align="right"><B>Chart Of Account *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearCashAccountChartOfAccountFields(){
                            txtCashAccountChartOfAccountCode=$("#cashAccount\\.chartOfAccount\\.code");
                            txtCashAccountChartOfAccountName=$("#cashAccount\\.chartOfAccount\\.name");        
                            
                        }
                        
                        txtCashAccountChartOfAccountCode.change(function(ev) {
                            
                            if(txtCashAccountChartOfAccountCode.val()===""){
                                clearCashAccountChartOfAccountFields();
                                return;
                            }
                            var url = "master/chart-of-account-get";
                            var params = "chartOfAccount.code=" + txtCashAccountChartOfAccountCode.val();
                                params+= "&chartOfAccount.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.BankTemp){
                                    txtCashAccountChartOfAccountCode.val(data.chartOfAccountTemp.code);
                                    txtCashAccountChartofAccountName.val(data.chartOfAccountTemp.name);
                                }
                                else{
                                    alertMessage("Chart Of Account Not Found!",txtCashAccountChartOfAccountCode);
                                    clearCashAccountChartOfAccountFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="cashAccount.chartOfAccount.code" name="cashAccount.chartOfAccount.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="cashAccount_btnchartOfAccount" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="cashAccount.chartOfAccount.name" name="cashAccount.chartOfAccount.name" size="24" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><b>BKM Voucher No *</b></td>
                <td><s:textfield id="cashAccount.bkmVoucherNo" name="cashAccount.bkmVoucherNo" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>BKK Voucher No *</b></td>
                <td><s:textfield id="cashAccount.bkkVoucherNo" name="cashAccount.bkkVoucherNo" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="cashAccountActiveStatusRad" name="cashAccountActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="cashAccount.activeStatus" name="cashAccount.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="cashAccount.remark" name="cashAccount.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="cashAccount.inActiveBy"  name="cashAccount.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="cashAccount.inActiveDate" name="cashAccount.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="cashAccount.createdBy"  name="cashAccount.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="cashAccount.createdDate" name="cashAccount.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="cashAccountTemp.inActiveDateTemp" name="cashAccountTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="cashAccountTemp.createdDateTemp" name="cashAccountTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnCashAccountSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCashAccountCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>