
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
        txtBankAccountCode = $("#bankAccount\\.code"),
        txtBankAccountName = $("#bankAccount\\.name"),
        txtBankAccountACNo = $("#bankAccount\\.acNo"),
        txtBankAccountACName = $("#bankAccount\\.acName"),
        txtBankAccountBankCode = $("#bankAccount\\.bank\\.code"),
        txtBankAccountBankName = $("#bankAccount\\.bank\\.name"),
        txtBankAccountBankBranch=$("#bankAccount\\.bankBranch"),
        txtBankAccountChartOfAccountCode=$("#bankAccount\\.chartOfAccount\\.code"),
        txtBankAccountChartOfAccountName=$("#bankAccount\\.chartOfAccount\\.name"),
        txtBankAccountBBMVoucherNo = $("#bankAccount\\.bBMVoucherNo"),
        txtBankAccountBBKVoucherNo = $("#bankAccount\\.bBKVoucherNo"),
        txtBankAccountRemark=$("#bankAccount\\.remark"),
        txtBankAccountInActiveBy = $("#bankAccount\\.inActiveBy"),
        dtpBankAccountInActiveDate = $("#bankAccount\\.inActiveDate"),
        rdbBankAccountActiveStatus = $("#bankAccount\\.activeStatus"),
        txtBankAccountCreatedBy = $("#bankAccount\\.createdBy"),
        txtBankAccountCreatedDate = $("#bankAccount\\.createdDate"),
        
        allFieldsBankAccount=$([])
            .add(txtBankAccountCode)
            .add(txtBankAccountName)
            .add(txtBankAccountACNo)
            .add(txtBankAccountACName)
            .add(txtBankAccountBankCode)
            .add(txtBankAccountBankName)
            .add(txtBankAccountBankBranch)
            .add(txtBankAccountBBMVoucherNo)
            .add(txtBankAccountBBKVoucherNo)
            .add(txtBankAccountChartOfAccountCode)
            .add(txtBankAccountChartOfAccountName)
            .add(rdbBankAccountActiveStatus)
            .add(txtBankAccountRemark)
            .add(txtBankAccountInActiveBy)
            .add(txtBankAccountCreatedBy)
            .add(txtBankAccountCreatedDate);  
      
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("bankAccount");
        $('#bankAccount\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#bankAccountSearchActiveStatusRadActive').prop('checked',true);
        $("#bankAccountSearchActiveStatus").val("true");
        
        $('input[name="bankAccountSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#bankAccountSearchActiveStatus").val(value);
            
        });
                
        $('input[name="bankAccountSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#bankAccountSearchActiveStatus").val(value);
        });
        
        $('input[name="bankAccountSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#bankAccountSearchActiveStatus").val(value);
        });
        
        $('input[name="bankAccount\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#bankAccount\\.activeStatus").val(value);
            
        });
                
        $('input[name="bankAccount\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#bankAccount\\.activeStatus").val(value);
        });
        
        $("#btnBankAccountNew").click(function(ev){
            var url="master/bank-account-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_bank_account();
                showInput("bankAccount");
                hideInput("bankAccountSearch");
                $('#bankAccount\\.activeStatusActive').prop('checked',true);
                $("#bankAccount\\.activeStatus").val("true");
                $("#bankAccount\\.inActiveDate").val("01/01/1900 00:00:00");
                updateRowId = -1;
                txtBankAccountCode.attr("readonly",false);
            });
            ev.preventDefault();
        });
        
        
        
        $("#btnBankAccountSave").click(function(ev) {
            
            if(!$("#frmBankAccountInput").valid()) {
                handlers_input_bank_account();
                ev.preventDefault();
                return;
            };
           
            var url = "";

            if (updateRowId < 0)
                url = "master/bank-account-save";
            else
                url = "master/bank-account-update";

            var params = $("#frmBankAccountInput").serialize();

            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }

                alertMessage(data.message);

                hideInput("bankAccount");
                showInput("bankAccountSearch");
                allFieldsBankAccount.val('').removeClass('ui-state-error');
                txtBankAccountCode.attr("readonly",true);
                reloadGridBankAccount();           
            });
           
            ev.preventDefault();
        });
        
        
        $("#btnBankAccountUpdate").click(function(ev){
            var url="master/bank-account-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_bank_account();
                updateRowId = $("#bankAccount_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var bankAccount = $("#bankAccount_grid").jqGrid('getRowData', updateRowId);
                var url = "master/bank-account-get-data";
                var params = "bankAccount.code=" + bankAccount.code;

                txtBankAccountCode.attr("readonly",true);

                $.post(url, params, function(result) {
                    var data = (result);
                        txtBankAccountCode.val(data.bankAccountTemp.code);
                        txtBankAccountName.val(data.bankAccountTemp.name);
                        txtBankAccountACNo.val(data.bankAccountTemp.acNo);
                        txtBankAccountACName.val(data.bankAccountTemp.acName);
                        txtBankAccountBankCode.val(data.bankAccountTemp.bankCode);
                        txtBankAccountBankName.val(data.bankAccountTemp.bankName);
                        txtBankAccountBankBranch.val(data.bankAccountTemp.bankBranch);
                        txtBankAccountBBMVoucherNo.val(data.bankAccountTemp.bBMVoucherNo);
                        txtBankAccountBBKVoucherNo.val(data.bankAccountTemp.bBKVoucherNo);
                        txtBankAccountChartOfAccountCode.val(data.bankAccountTemp.chartOfAccountCode);
                        txtBankAccountChartOfAccountName.val(data.bankAccountTemp.chartOfAccountName);
                        rdbBankAccountActiveStatus.val(data.bankAccountTemp.activeStatus);
                        txtBankAccountRemark.val(data.bankAccountTemp.remark);
                        txtBankAccountInActiveBy.val(data.bankAccountTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.bankAccountTemp.inActiveDate,true);
                        dtpBankAccountInActiveDate.val(inActiveDate);
                        txtBankAccountCreatedBy.val(data.bankAccountTemp.createdBy);
                        txtBankAccountCreatedDate.val(data.bankAccountTemp.createdDate);
                        txtBankAccountBBMVoucherNo.val(data.bankAccountTemp.bbmVoucherNo);
                        txtBankAccountBBKVoucherNo.val(data.bankAccountTemp.bbkVoucherNo);
                        if(data.bankAccountTemp.activeStatus===true) {
                           $('#bankAccount\\.activeStatusActive').prop('checked',true);
                           $("#bankAccount\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#bankAccount\\.activeStatusInActive').prop('checked',true);              
                           $("#bankAccount\\.activeStatus").val("false");
                        }

                    showInput("bankAccount");
                    hideInput("bankAccountSearch");
                });
                
            });
            ev.preventDefault();
        });
        
        
        $('#btnBankAccountDelete').click(function(ev) {
            var url="master/bank-account-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#bankAccount_grid").jqGrid('getGridParam','selrow');
            
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var bankAccount = $("#bankAccount_grid").jqGrid('getRowData', deleteRowId);

//                if (confirm("Are You Sure To Delete (Code : " + bankAccount.code + ")")) {
                    var url = "master/bank-account-delete";
                    var params = "bankAccount.code=" + bankAccount.code;
                    var message="Are You Sure To Delete(Code : "+ bankAccount.code + ")?";
                    alertMessageDelete("bankAccount",url,params,message,400);
//                    $.post(url, params, function(data) {
//                        if (data.error) {
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
                        reloadGridBankAccount();
//                    });
//                }
            });
            ev.preventDefault();
        });


        $("#btnBankAccountCancel").click(function(ev) {
            hideInput("bankAccount");
            showInput("bankAccountSearch");
            allFieldsBankAccount.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        
        $('#btnBankAccountRefresh').click(function(ev) {  
            $('#bankAccountSearchActiveStatusRadActive').prop('checked',true);
            $("#bankAccountSearchActiveStatus").val("true");
            $("#bankAccount_grid").jqGrid("clearGridData");
            $("#bankAccount_grid").jqGrid("setGridParam",{url:"master/bank-account-data?"});
            $("#bankAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
        $('#btnBankAccount_search').click(function(ev) {
            $("#bankAccount_grid").jqGrid("clearGridData");
            $("#bankAccount_grid").jqGrid("setGridParam",{url:"master/bank-account-data?" + $("#frmBankAccountSearchInput").serialize()});
            $("#bankAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnBankAccountPrint").click(function(ev) {
            var status=$('#bankAccountSearchActiveStatus').val();
            var url = "report/bank-account-print-out-pdf?";
            var params = "activeStatus="+status;
              
            window.open(url+params,'bankAccount','width=500,height=500');
        });
       
        $('#bankAccount_btnAccountNo').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=bankAccount&idsubdoc=chartOfAccount&idacctype=S","Search", "width=700, height=500");
        });
       
        $('#bankAccount_btnBankName').click(function(ev) {
            window.open("./pages/search/search-bank.jsp?iddoc=bankAccount&idsubdoc=bank","Search", "width=700, height=500");
        });
        
       
    });
    
    function reloadGridBankAccount() {
        $("#bankAccount_grid").trigger("reloadGrid");
    };

    function unHandlers_input_bank_account(){
        unHandlersInput(txtBankAccountCode);
        unHandlersInput(txtBankAccountName);
        unHandlersInput(txtBankAccountACNo);
        unHandlersInput(txtBankAccountACName);
        unHandlersInput(txtBankAccountBankCode);
        unHandlersInput(txtBankAccountBankBranch);
        unHandlersInput(txtBankAccountBBMVoucherNo);
        unHandlersInput(txtBankAccountBBKVoucherNo);
        unHandlersInput(txtBankAccountChartOfAccountCode);
    }
       
    function handlers_input_bank_account(){
        if(txtBankAccountCode.val()===""){
            handlersInput(txtBankAccountCode);
        }else{
            unHandlersInput(txtBankAccountCode);
        }
        if(txtBankAccountName.val()===""){
            handlersInput(txtBankAccountName);
        }else{
            unHandlersInput(txtBankAccountName);
        }
        if(txtBankAccountACNo.val()===""){
            handlersInput(txtBankAccountACNo);
        }else{
            unHandlersInput(txtBankAccountACNo);
        }
        if(txtBankAccountACName.val()===""){
            handlersInput(txtBankAccountACName);
        }else{
            unHandlersInput(txtBankAccountACName);
        }
        if(txtBankAccountBankCode.val()===""){
            handlersInput(txtBankAccountBankCode);
        }else{
            unHandlersInput(txtBankAccountBankCode);
        }
       
        if(txtBankAccountBankBranch.val()===""){
            handlersInput(txtBankAccountBankBranch);
        }else{
            unHandlersInput(txtBankAccountBankBranch);
        }
        if(txtBankAccountBBMVoucherNo.val()===""){
            handlersInput(txtBankAccountBBMVoucherNo);
        }else{
            unHandlersInput(txtBankAccountBBMVoucherNo);
        }
        if(txtBankAccountBBKVoucherNo.val()===""){
            handlersInput(txtBankAccountBBKVoucherNo);
        }else{
            unHandlersInput(txtBankAccountBBKVoucherNo);
        }
        if(txtBankAccountChartOfAccountCode.val()===""){
            handlersInput(txtBankAccountChartOfAccountCode);
        }else{
            unHandlersInput(txtBankAccountChartOfAccountCode);
        }
        if(txtBankAccountBBMGiroChartOfAccountCode.val()===""){
            handlersInput(txtBankAccountBBMGiroChartOfAccountCode);
        }else{
            unHandlersInput(txtBankAccountBBMGiroChartOfAccountCode);
        }
        if(txtBankAccountBBKGiroChartOfAccountCode.val()===""){
            handlersInput(txtBankAccountBBKGiroChartOfAccountCode);
        }else{
            unHandlersInput(txtBankAccountBBKGiroChartOfAccountCode);
        }
    }
    
    function bankAccountFormatDate(){
        var inActiveDate=formatDate(dtpBankAccountInActiveDate.val(),true);
        dtpBankAccountInActiveDate.val(inActiveDate);
        $("#bankAccountTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpBankAccountCreatedDate.val(),true);
        dtpBankAccountCreatedDate.val(createdDate);
        $("#bankAccountTemp\\.createdDateTemp").val(createdDate);
    }
</script>

<s:url id="remoteurlBankAccount" action="bank-account-data" />
<b>BANK ACCOUNT</b>
<hr>
<br class="spacer" />
<sj:div id="bankAccountButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnBankAccountNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnBankAccountUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnBankAccountDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnBankAccountRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnBankAccountPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>
        
<div id="bankAccountSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmBankAccountSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre">Code</td>
                <td>
                    <s:textfield id="bankAccountSearchCode" name="bankAccountSearchCode" size="30"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="centre">Name</td>
                <td>
                    <s:textfield id="bankAccountSearchName" name="bankAccountSearchName" size="50"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="bankAccountSearchActiveStatus" name="bankAccountSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="bankAccountSearchActiveStatusRad" name="bankAccountSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>  
        </table>
        <br />
        <sj:a href="#" id="btnBankAccount_search" button="true">Search</sj:a>
    </s:form>
</div>
<br class="spacer" />
    
<div id="bankAccountGrid">
    <sjg:grid
        id="bankAccount_grid"
        dataType="json"
        href="%{remoteurlBankAccount}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listBankAccountTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuBankAccount').width()"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="acNo" index="acNo" title="AC No" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="acName" index="acName" title="AC Name" width="250" sortable="true"
        />
        <sjg:gridColumn
            name="bankCode" index="bankCode" title="Bank Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="bbmVoucherNo" index="bbmVoucherNo" key="bbmVoucherNo" title="BBMVoucherNo" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="bbkVoucherNo" index="bbkVoucherNo" key="bbkVoucherNo" title="BBKVoucherNo" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="chartOfAccountName" index="chartOfAccountName" title="Account Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid >

</div>
    
<div id="bankAccountInput" class="content ui-widget">
    <s:form id="frmBankAccountInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="bankAccount.code" name="bankAccount.code" title="*" size="20" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Name *</B></td>
                <td><s:textfield id="bankAccount.name" name="bankAccount.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
             <tr>
                <td align="right"><B>AC No *</B></td>
                <td><s:textfield id="bankAccount.acNo" name="bankAccount.acNo" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>AC Name *</B></td>
                <td><s:textfield id="bankAccount.acName" name="bankAccount.acName" size="50" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Bank *</B></td>
                <td>
                    <script type = "text/javascript">

                        txtBankAccountBankCode.change(function(ev) {
                            if(txtBankAccountBankCode.val()===""){
                                txtBankAccountBankCode.val("");
                                txtBankAccountBanktName.val("");
                                return;
                            }

                            var url = "master/bank-get";
                            var params = "bank.code=" + txtBankAccountBankCode.val();
                                params += "&bank.activeStatus="+true;
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.bankTemp){
                                    txtBankAccountBankCode.val(data.bankTemp.code);
                                    txtBankAccountBankName.val(data.bankTemp.name);
                                }
                                else{
                                    txtBankAccountBankCode.val("");
                                    txtBankAccountBankName.val("");
                                    alert("Bank Not Found");
                                }
                            });
                        });

                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="bankAccount.bank.code" name="bankAccount.bank.code" title="*" size="25" required="true" cssClass="required" maxLength="45"></s:textfield>
                        <sj:a id="bankAccount_btnBankName" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="bankAccount.bank.name" name="bankAccount.bank.name" size="45" readonly="true" ></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><B>Bank Branch *</B></td>
                <td><s:textfield id="bankAccount.bankBranch" name="bankAccount.bankBranch" title="*" size="25" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Chart Of Account *</B></td>
                <td>
                    <script type = "text/javascript">

                        txtBankAccountChartOfAccountCode.change(function(ev) {

                            if(txtBankAccountChartOfAccountCode.val()===""){
                                txtBankAccountChartOfAccountCode.val("");
                                txtBankAccountChartOfAccountName.val("");
                                return;
                            }

                            var url = "master/chart-of-account-get";
                            var params = "chartOfAccount.code=" + txtBankAccountChartOfAccountCode.val();
                            params += "&chartOfAccount.accountType=S";
                            params += "&chartOfAccount.activeStatus="+true;
                            
                            $.post(url, params, function(result) {
                                var data = (result);

                                if (data.chartOfAccountTemp){
                                    txtBankAccountChartOfAccountCode.val(data.chartOfAccountTemp.code);
                                    txtBankAccountChartOfAccountName.val(data.chartOfAccountTemp.name);
                                }
                                else{
                                    txtBankAccountChartOfAccountCode.val("");
                                    txtBankAccountChartOfAccountName.val("");
                                    alert("Account Not Found");
                                }
                            });
                        });

                    </script>
                    <div class="searchbox ui-widget-header">
                    <s:textfield id="bankAccount.chartOfAccount.code" name="bankAccount.chartOfAccount.code" title="*" required="true" cssClass="required" size="25" maxLength="45"></s:textfield>
                        <sj:a id="bankAccount_btnAccountNo" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="bankAccount.chartOfAccount.name" name="bankAccount.chartOfAccount.name" size="45" readonly="true"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><b>BBM Voucher No *</b></td>
                <td><s:textfield id="bankAccount.bBMVoucherNo" name="bankAccount.bbmVoucherNo" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>BBK Voucher No *</b></td>
                <td><s:textfield id="bankAccount.bBKVoucherNo" name="bankAccount.bbkVoucherNo" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>

            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="bankAccount.activeStatus" name="bankAccount.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="bankAccount.activeStatus" name="bankAccount.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="bankAccount.remark" name="bankAccount.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="bankAccount.inActiveBy"  name="bankAccount.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="bankAccount.inActiveDate" name="bankAccount.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <td></td>
            <td>
                <sj:a href="#" id="btnBankAccountSave" button="true">Save</sj:a>
                <sj:a href="#" id="btnBankAccountCancel" button="true">Cancel</sj:a>
            </td>
            <td><s:textfield id="bankAccount.createdBy"  name="bankAccount.createdBy" size="20" style="display:none"></s:textfield></td>
            <td><s:textfield id="bankAccount.createdDate" name="bankAccount.createdDate" size="20" style="display:none"></s:textfield></td>

        </table>
    </s:form>
</div>