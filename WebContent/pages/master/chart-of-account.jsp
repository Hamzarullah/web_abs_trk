
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type = "text/javascript">
    
    var 
        txtChartOfAccountCode = $("#chartOfAccount\\.code"),
        txtChartOfAccountCodeType = $("#chartOfAccount\\.codeType"),
        txtChartOfAccountCodePrefix = $("#chartOfAccount\\.codePrefix"),
        txtChartOfAccountCodeHeading = $("#chartOfAccount\\.codeHeading"),
        txtChartOfAccountCodeGroup = $("#chartOfAccount\\.codeGroup"),
        txtChartOfAccountCodeSub1 = $("#chartOfAccount\\.codeSub1"),
        txtChartOfAccountCodeSub2 = $("#chartOfAccount\\.codeSub2"),
        txtChartOfAccountName = $("#chartOfAccount\\.name"),
        txtChartOfAccountAccountType = $("#chartOfAccount\\.accountType"),
        txtChartOfAccountCurrencyCode = $("#chartOfAccount\\.currency\\.code"),
        txtChartOfAccountCurrencyName =$("#chartOfAccount\\.currency\\.name"),
        rdbChartOfAccountActiveStatus=$("chartOfAccount\\.activeStatus"),
        rdbChartOfAccountBBMStatus=$("chartOfAccount\\.bbmStatus"),
        rdbChartOfAccountBBKStatus=$("chartOfAccount\\.bbkStatus"),
        rdbChartOfAccountBKMStatus=$("chartOfAccount\\.bkmStatus"),
        rdbChartOfAccountBKKStatus=$("chartOfAccount\\.bkkStatus"),
        txtChartOfAccountCreatedBy = $("#chartOfAccount\\.createdBy"),
        txtChartOfAccountCreatedDate = $("#chartOfAccount\\.createdDate"),
        
        allFieldsChartOfAccount = $([])
            .add(txtChartOfAccountCodePrefix)
            .add(txtChartOfAccountCodeHeading)
            .add(txtChartOfAccountCodeGroup)
            .add(txtChartOfAccountCodeSub1)
            .add(txtChartOfAccountCodeSub2)
            .add(txtChartOfAccountName)
            .add(txtChartOfAccountAccountType)
            .add(txtChartOfAccountCurrencyCode)
            .add(txtChartOfAccountCurrencyName)
            .add(txtChartOfAccountCreatedBy)
            .add(txtChartOfAccountCreatedDate);


    function concatChartOfAccountCode(accountType){
         var chartOfAccountCode="";
         switch(accountType){
            case "H":
                chartOfAccountCode=txtChartOfAccountCodePrefix.val()+"-"+txtChartOfAccountCodeHeading.val();
                break;
            case "G":
                chartOfAccountCode=txtChartOfAccountCodePrefix.val()+"-"+txtChartOfAccountCodeHeading.val()+"-"+txtChartOfAccountCodeGroup.val();
                break;
            case "S":
                chartOfAccountCode=txtChartOfAccountCodePrefix.val()+"-"+txtChartOfAccountCodeHeading.val()+"-"+txtChartOfAccountCodeGroup.val()+"-"+txtChartOfAccountCodeSub1.val()+"-"+txtChartOfAccountCodeSub2.val();
                break;
        }
        txtChartOfAccountCode.val(chartOfAccountCode);
    }
    
    function enabledDisabledAccountCode(accountType){
        switch(accountType){
            case "H":
                $("#chartOfAccount\\.accountType").val("H");    
                $("#chartOfAccount\\.codeHeading").attr('readonly',false);
                $("#chartOfAccount\\.codeHeading").focus();
                $("#chartOfAccount\\.codeGroup").attr('readonly',true);
                $("#chartOfAccount\\.codeSub1").attr('readonly',true);
                $("#chartOfAccount\\.codeSub2").attr('readonly',true);
                txtChartOfAccountCodeGroup.val("");
                txtChartOfAccountCodeSub1.val("");
                txtChartOfAccountCodeSub2.val("");
                break;
            case "G":
                $("#chartOfAccount\\.accountType").val("G");
                $("#chartOfAccount\\.codeHeading").attr('readonly',false);
                $("#chartOfAccount\\.codeHeading").focus();
                $("#chartOfAccount\\.codeGroup").attr('readonly',false);
                $("#chartOfAccount\\.codeSub1").attr('readonly',true);
                $("#chartOfAccount\\.codeSub2").attr('readonly',true);
                txtChartOfAccountCodeSub1.val("");
                txtChartOfAccountCodeSub2.val("");
                break;
            case "S":
                $("#chartOfAccount\\.accountType").val("S");
                $("#chartOfAccount\\.codeHeading").attr('readonly',false);
                $("#chartOfAccount\\.codeHeading").focus();
                $("#chartOfAccount\\.codeGroup").attr('readonly',false);
                $("#chartOfAccount\\.codeSub1").attr('readonly',false);
                $("#chartOfAccount\\.codeSub2").attr('readonly',false);
                break;
        }
    }
    
    $(document).ready(function() {    	
        
        hoverButton();
        var updateRowId = -1;
        hideInput("chartOfAccount");
        $('#chartOfAccount\\.codeSub2').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $('#chartOfAccount\\.name').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        
        $('#chartOfAccountSearchAccountTypeRadAll').prop('checked',true);
        $("#chartOfAccountSearchAccountType").val("");
        $('#chartOfAccountSearchActiveStatusRadActive').prop('checked',true);
        $("#chartOfAccountSearchActiveStatus").val("true");
        
        $('input[name="chartOfAccountSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#chartOfAccountSearchActiveStatus").val(value);
            
        });
                
        $('input[name="chartOfAccountSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#chartOfAccountSearchActiveStatus").val(value);
        });
        
        $('input[name="chartOfAccountSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#chartOfAccountSearchActiveStatus").val(value);
        });
        
        $('input[name="chartOfAccountSearchAccountTypeRad"][value="All"]').change(function(ev){
            var value="";
            $("#chartOfAccountSearchAccountType").val(value);    
        });
        
        $('input[name="chartOfAccountSearchAccountTypeRad"][value="Head"]').change(function(ev){
            var value="H";
            $("#chartOfAccountSearchAccountType").val(value);    
        });
                
        $('input[name="chartOfAccountSearchAccountTypeRad"][value="Group"]').change(function(ev){
            var value="G";
            $("#chartOfAccountSearchAccountType").val(value);
        });
        
        $('input[name="chartOfAccountSearchAccountTypeRad"][value="Sub"]').change(function(ev){
            var value="S";
            $("#chartOfAccountSearchAccountType").val(value);
        });
        
        $('input[name="chartOfAccount\\.accountTypeRad"][value="Head"]').change(function(ev){
            enabledDisabledAccountCode("H");
        });
                
        $('input[name="chartOfAccount\\.accountTypeRad"][value="Group"]').change(function(ev){
            enabledDisabledAccountCode("G");
        });
        
        $('input[name="chartOfAccount\\.accountTypeRad"][value="Sub"]').change(function(ev){
            enabledDisabledAccountCode("S");
        });
        
        
        $('input[name="chartOfAccount\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#chartOfAccount\\.activeStatus").val(value);
        });
                
        $('input[name="chartOfAccount\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#chartOfAccount\\.activeStatus").val(value);
        });
        
        //BBM
        $('input[name="chartOfAccount\\.bbmStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#chartOfAccount\\.bbmStatus").val(value);
        });
                
        $('input[name="chartOfAccount\\.bbmStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#chartOfAccount\\.bbmStatus").val(value);
        });
        
        //BBK
        $('input[name="chartOfAccount\\.bbkStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#chartOfAccount\\.bbkStatus").val(value);
        });
                
        $('input[name="chartOfAccount\\.bbkStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#chartOfAccount\\.bbkStatus").val(value);
        });
        
        //BKM
        $('input[name="chartOfAccount\\.bkmStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#chartOfAccount\\.bkmStatus").val(value);
        });
                
        $('input[name="chartOfAccount\\.bkmStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#chartOfAccount\\.bkmStatus").val(value);
        });
        
        //BKK
        $('input[name="chartOfAccount\\.bkkStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#chartOfAccount\\.bkkStatus").val(value);
        });
                
        $('input[name="chartOfAccount\\.bkkStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#chartOfAccount\\.bkkStatus").val(value);
        });
        

        $('#btnChartOfAccountNew').click(function(ev) {
            var url="master/chart-of-account-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                showInput("chartOfAccount");
                hideInput("chartOfAccountSearch");
                $('#chartOfAccount\\.accountTypeRadHead').prop('checked',true);
                $("#chartOfAccount\\.accountType").val("H");
                onChangeCodeType();
                $('#chartOfAccount\\.accountTypeRad').attr("disabled", false);
                $('#chartOfAccount\\.codeType').attr("disabled", false);
                $("#chartOfAccount\\.codeHeading").attr('readonly',false);
                $("#chartOfAccount\\.codeHeading").focus();
                $("#chartOfAccount\\.codeGroup").attr('readonly',true);
                $("#chartOfAccount\\.codeSub1").attr('readonly',true);
                $("#chartOfAccount\\.codeSub2").attr('readonly',true);
                $('#chartOfAccount\\.activeStatusActive').prop('checked',true);
                $("#chartOfAccount\\.activeStatus").val("true");
                
                setDefaultStatusModule();
                updateRowId = -1;
            });
            ev.preventDefault();
        });


        $('#btnChartOfAccountUpdate').click(function(ev) {
            var url="master/chart-of-account-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                updateRowId = $("#chartOfAccount_grid").jqGrid('getGridParam','selrow');
                if (updateRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }

                var chartOfAccount = $("#chartOfAccount_grid").jqGrid('getRowData', updateRowId);
                var url = "master/chart-of-account-get-data";
                var params = "chartOfAccount.code=" + chartOfAccount.code;

                $.post(url, params, function(result){
                    var data = (result);
                    var accountCode=data.chartOfAccountTemp.code.split('-');
                    txtChartOfAccountCodePrefix.val(accountCode[0]);
                    txtChartOfAccountCodeHeading.val(accountCode[1]);
                    txtChartOfAccountCodeGroup.val(accountCode[2]);
                    txtChartOfAccountCodeSub1.val(accountCode[3]);
                    txtChartOfAccountCodeSub2.val(accountCode[4]);
                    txtChartOfAccountName.val(data.chartOfAccountTemp.name);
                    txtChartOfAccountAccountType.val(data.chartOfAccountTemp.accountType);
                    txtChartOfAccountCurrencyCode.val(data.chartOfAccountTemp.currencyCode);
                    txtChartOfAccountCurrencyName.val(data.chartOfAccountTemp.currencyName);
                    rdbChartOfAccountActiveStatus.val(data.chartOfAccountTemp.activeStatus);
                    rdbChartOfAccountBBMStatus.val(data.chartOfAccountTemp.bbmStatus);
                    rdbChartOfAccountBBKStatus.val(data.chartOfAccountTemp.bbkStatus);
                    rdbChartOfAccountBKMStatus.val(data.chartOfAccountTemp.bkmStatus);
                    rdbChartOfAccountBKKStatus.val(data.chartOfAccountTemp.bkkStatus);
                    txtChartOfAccountCreatedBy.val(data.chartOfAccountTemp.createdBy);
                    txtChartOfAccountCreatedDate.val(data.chartOfAccountTemp.createdDate);
                    
                    $('#chartOfAccount\\.accountTypeRad').attr("disabled", true);
                    $('#chartOfAccount\\.codeType').attr("disabled", true);
                    txtChartOfAccountCodePrefix.attr("readonly",true);
                    txtChartOfAccountCodeHeading.attr("readonly",true);
                    txtChartOfAccountCodeGroup.attr("readonly",true);
                    txtChartOfAccountCodeSub1.attr("readonly",true);
                    txtChartOfAccountCodeSub2.attr("readonly",true);
                    
                    if(data.chartOfAccountTemp.accountType==="H"){
                        $('#chartOfAccount\\.accountTypeRadHead').prop('checked',true);
                        $("#chartOfAccount\\.accountType").val("H");
                        txtChartOfAccountCodeHeading.attr("readonly",false);
                    }
                    else if(data.chartOfAccountTemp.accountType==="G"){
                        $('#chartOfAccount\\.accountTypeRadGroup').prop('checked',true);
                        $("#chartOfAccount\\.accountType").val("G");
                        txtChartOfAccountCodeHeading.attr("readonly",false);
                        txtChartOfAccountCodeGroup.attr("readonly",false);
                    }
                    else{
                        $('#chartOfAccount\\.accountTypeRadSub').prop('checked',true);
                        $("#chartOfAccount\\.accountType").val("S");
                        txtChartOfAccountCodeHeading.attr("readonly",false);
                        txtChartOfAccountCodeGroup.attr("readonly",false);
                        txtChartOfAccountCodeSub1.attr("readonly",false);
                        txtChartOfAccountCodeSub2.attr("readonly",false);
                    }

//                    enabledDisabledAccountCode(data.chartOfAccountTemp.accountType);

                    if(data.chartOfAccountTemp.activeStatus===true) {
                        $('#chartOfAccount\\.activeStatusActive').prop('checked',true);
                        $("#chartOfAccount\\.activeStatus").val("true");
                    }
                    else {                        
                        $('#chartOfAccount\\.activeStatusInActive').prop('checked',true);              
                        $("#chartOfAccount\\.activeStatus").val("false");
                    }

                    if(data.chartOfAccountTemp.bbmStatus===true) {
                        $('#chartOfAccount\\.bbmStatusYes').prop('checked',true);
                        $("#chartOfAccount\\.bbmStatus").val("true");
                    }
                    else {                        
                        $('#chartOfAccount\\.bbmStatusNo').prop('checked',true);              
                        $("#chartOfAccount\\.bbmStatus").val("false");
                    }

                    if(data.chartOfAccountTemp.bbkStatus===true) {
                        $('#chartOfAccount\\.bbkStatusYes').prop('checked',true);
                        $("#chartOfAccount\\.bbkStatus").val("true");
                    }
                    else {                        
                        $('#chartOfAccount\\.bbkStatusNo').prop('checked',true);              
                        $("#chartOfAccount\\.bbkStatus").val("false");
                    }

                    if(data.chartOfAccountTemp.bkmStatus===true) {
                        $('#chartOfAccount\\.bkmStatusYes').prop('checked',true);
                        $("#chartOfAccount\\.bkmStatus").val("true");
                    }
                    else {                        
                        $('#chartOfAccount\\.bkmStatusNo').prop('checked',true);              
                        $("#chartOfAccount\\.bkmStatus").val("false");
                    }

                    if(data.chartOfAccountTemp.bkkStatus===true) {
                        $('#chartOfAccount\\.bkkStatusYes').prop('checked',true);
                        $("#chartOfAccount\\.bkkStatus").val("true");
                    }
                    else {                        
                        $('#chartOfAccount\\.bkkStatusNo').prop('checked',true);              
                        $("#chartOfAccount\\.bkkStatus").val("false");
                    }

                    if(data.chartOfAccountTemp.gjmStatus===true) {
                        $('#chartOfAccount\\.gjmStatusYes').prop('checked',true);
                        $("#chartOfAccount\\.gjmStatus").val("true");
                    }
                    else {                        
                        $('#chartOfAccount\\.gjmStatusNo').prop('checked',true);              
                        $("#chartOfAccount\\.gjmStatus").val("false");
                    }


                    onChangeCodeTypeFromID();   
                    showInput("chartOfAccount");
                    hideInput("chartOfAccountSearch");
                });
            });
            ev.preventDefault();
        });



        $('#btnChartOfAccountSave').click(function(ev) {
            var accountType=$("#chartOfAccount\\.accountType").val().trim();
            concatChartOfAccountCode(accountType);
            switch(accountType){
                case "H":
                    if(txtChartOfAccountCodeHeading.val().length<2){
                        alertMessage("Code Heading Must Be 2 Digit Only!",txtChartOfAccountCodeHeading);
                        return;
                    }
                    break;
                case "G":
                    if(txtChartOfAccountCodeHeading.val().length<2){
                        alertMessage("Code Heading Must Be 2 Digit Only!",txtChartOfAccountCodeHeading);
                        return;
                    }else if(txtChartOfAccountCodeGroup.val().length<3){
                        alertMessage("Code Group Must Be 3 Digit Only!",txtChartOfAccountCodeGroup);
                        return;
                    }
                    break;
                case "S":
                    if(txtChartOfAccountCodeHeading.val().length<2){
                        alertMessage("Code Heading Must Be 2 Digit Only!",txtChartOfAccountCodeHeading);
                        return;
                    }else if(txtChartOfAccountCodeGroup.val().length<3){
                        alertMessage("Code Group Must Be 3 Digit Only!",txtChartOfAccountCodeGroup);
                        return;
                    }else if(txtChartOfAccountCodeSub1.val().length<4){
                        alertMessage("Code Sub 1 Must Be 4 Digit Only!",txtChartOfAccountCodeSub1);
                        return;
                    }else if(txtChartOfAccountCodeSub2.val().length<3){
                        alertMessage("Code Sub 2 Must Be 3 Digit Only!",txtChartOfAccountCodeSub2);
                        return;
                    }
                    break;
            }
            
            if(txtChartOfAccountName.val()===""){
                alertMessage("Account Name Can't Empty!",txtChartOfAccountName);
                return;
            }

            var url = "";

            if (updateRowId < 0){
                url = "master/chart-of-account-save";
            }
            else{
                url = "master/chart-of-account-update";
            }

            var params = $("#frmChartOfAccountInput").serialize();
            
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
                
                hideInput('chartOfAccount');
                showInput("chartOfAccountSearch");
                allFieldsChartOfAccount.val('').removeClass('ui-state-error');
                reloadGridChartOfAccount();
            });

            ev.preventDefault();
        });


        $('#btnChartOfAccountDelete').click(function(ev) {
            var url="master/chart-of-account-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#chartOfAccount_grid").jqGrid('getGridParam','selrow');
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var chartOfAccount = $("#chartOfAccount_grid").jqGrid('getRowData', deleteRowId);
//                if (confirm("Are You Sure To Delete (Code : " + chartOfAccount.code + ")")) {
                    var url = "master/chart-of-account-delete";
                    var params = "chartOfAccount.code=" + chartOfAccount.code;
                    var message="Are You Sure To Delete(Code : "+ chartOfAccount.code + ")?";
                    alertMessageDelete("chartOfAccount",url,params,message,400);
//                    $.post(url, params, function(data) {
//                        if (data.error) {
//                            alertMessage(data.errorMessage);
//                            return;
//                        }

//                        alertMessage(data.message);

                        reloadGridChartOfAccount();
//                    });
//                }

            });    
            ev.preventDefault();
        });


        $('#btnChartOfAccountCancel').click(function(ev) {
            hideInput("chartOfAccount");
            showInput("chartOfAccountSearch");
            allFieldsChartOfAccount.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });

        $("#btnChartOfAccountPrint").click(function(ev) {
            var status=$('#chartOfAccountSearchActiveStatus').val();
            var url = "reports/chart-of-account-print-out-pdf?";
            var params = "activeStatus=" + status;
              
            window.open(url+params,'chartOfAccount','width=500,height=500');
        });

        $('#btnChartOfAccountRefresh').click(function(ev) {
            
            $('#chartOfAccountSearchAccountTypeRadAll').prop('checked',true);
            $("#chartOfAccountSearchAccountType").val("");
            $('#chartOfAccountSearchActiveStatusRadActive').prop('checked',true);
            $("#chartOfAccountSearchActiveStatus").val("true");

            $("#chartOfAccount_grid").jqGrid("clearGridData");
            $("#chartOfAccount_grid").jqGrid("setGridParam",{url:"master/chart-of-account-data?"});
            $("#chartOfAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
        });    
        
        
        $('#btnChartOfAccount_search').click(function(ev) {
            $("#chartOfAccount_grid").jqGrid("clearGridData");
            $("#chartOfAccount_grid").jqGrid("setGridParam",{url:"master/chart-of-account-data?" + $("#frmChartOfAccountSearchInput").serialize()});
            $("#chartOfAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
       });
       
       
    });
    
    function reloadGridChartOfAccount() {
        $("#chartOfAccount_grid").trigger("reloadGrid");
    }
    
    function onChangeCodeType(){
        var codeType=$("#chartOfAccount\\.codeType").val();
        switch(codeType){
            case "Current Assets":
                $("#chartOfAccount\\.codePrefix").val("01");
                break;
            case "Non Current Assets":
                $("#chartOfAccount\\.codePrefix").val("02");
                break;
            case "Current Liabilities":
                $("#chartOfAccount\\.codePrefix").val("03");
                break;
            case "Long Term liabilities":
                $("#chartOfAccount\\.codePrefix").val("04");
                break;
            case "Capital":
                $("#chartOfAccount\\.codePrefix").val("05");
                break;
            case "Sales":
                $("#chartOfAccount\\.codePrefix").val("06");
                break;
            case "Cost Of Goods Sold":
                $("#chartOfAccount\\.codePrefix").val("07");
                break;
            case "Marketing Expenses":
                $("#chartOfAccount\\.codePrefix").val("08");
                break;
            case "General And Administration Expenses":
                $("#chartOfAccount\\.codePrefix").val("09");
                break;
            case "Other Expenses":
                $("#chartOfAccount\\.codePrefix").val("10");
                break;
            case "Other Revenues":
                $("#chartOfAccount\\.codePrefix").val("11");
                break;
            case "Income Tax":
                $("#chartOfAccount\\.codePrefix").val("12");
                break;
        }
    }

    function onChangeCodeTypeFromID(){
        var idType=$("#chartOfAccount\\.codePrefix").val();
        switch(idType){
            case "01":
                $("#chartOfAccount\\.codeType").val("Current Assets");
                break;
            case "02":
                $("#chartOfAccount\\.codeType").val("Non Current Assets");
                break;
            case "03":
                $("#chartOfAccount\\.codeType").val("Current Liabilities");
                break;
            case "04":
                $("#chartOfAccount\\.codeType").val("Long Term liabilities");
                break;
            case "05":
                $("#chartOfAccount\\.codeType").val("Capital");
                break;
            case "06":
                $("#chartOfAccount\\.codeType").val("Sales");
                break;
            case "07":
                $("#chartOfAccount\\.codeType").val("Cost Of Goods Sold");
                break;
            case "08":
                $("#chartOfAccount\\.codeType").val("Marketing Expenses");
                break;
            case "09":
                $("#chartOfAccount\\.codeType").val("General And Administration Expenses");
                break;
            case "10":
                $("#chartOfAccount\\.codeType").val("Other Expenses");
                break;
            case "11":
                $("#chartOfAccount\\.codeType").val("Other Revenues");
                break;
            case "12":
                $("#chartOfAccount\\.codeType").val("Income Tax");
                break;
        }
    }
    
    function setDefaultStatusModule() {
        
        //default false
        $('#chartOfAccount\\.bbmStatusYes').prop('checked',true);
        $("#chartOfAccount\\.bbmStatus").val("true");

        $('#chartOfAccount\\.bbkStatusYes').prop('checked',true);
        $("#chartOfAccount\\.bbkStatus").val("true");

        $('#chartOfAccount\\.bkmStatusYes').prop('checked',true);
        $("#chartOfAccount\\.bkmStatus").val("true");

        $('#chartOfAccount\\.bkkStatusYes').prop('checked',true);
        $("#chartOfAccount\\.bkkStatus").val("true");
            
    }
    
    $('#chartOfAccount_btnCurrency').click(function(ev) {
        window.open("./pages/search/search-currency.jsp?iddoc=chartOfAccount&idsubdoc=currency","Search", "width=550, height=500");
    });
</script>

<s:url id="remoteurlChartOfAccount" action="chart-of-account-data" />
    <b>CHART OF ACCOUNT</b>
    <hr>
    <br class="spacer" />
    <sj:div id="chartOfAccountButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnChartOfAccountNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnChartOfAccountUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnChartOfAccountDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnChartOfAccountRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnChartOfAccountPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>    
        </table>
    </sj:div>

    <div id="chartOfAccountSearchInput" class="content ui-widget">
        <br class="spacer" />
        <br class="spacer" />
        <s:form id="frmChartOfAccountSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Account Type
                        <s:textfield id="chartOfAccountSearchAccountType" name="chartOfAccountSearchAccountType" readonly="false" size="5" cssStyle="Display:none"></s:textfield>
                    </td>
                    <td>
                        <s:radio id="chartOfAccountSearchAccountTypeRad" name="chartOfAccountSearchAccountTypeRad" list="{'Head','Group','Sub','All'}"></s:radio>
                    </td>  
                </tr>
                <tr>
                    <td align="right" valign="centre">Code</td>
                    <td>
                        <s:textfield id="chartOfAccountSearchCode" name="chartOfAccountSearchCode" size="30"></s:textfield>
                    </td>
                    <td align="right" valign="centre">Name</td>
                    <td>
                        <s:textfield id="chartOfAccountSearchName" name="chartOfAccountSearchName" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right">Status
                        <s:textfield id="chartOfAccountSearchActiveStatus" name="chartOfAccountSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>
                    <td>
                        <s:radio id="chartOfAccountSearchActiveStatusRad" name="chartOfAccountSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                    </td>
                </tr>  
            </table>
            <br />
            <sj:a href="#" id="btnChartOfAccount_search" button="true">Search</sj:a>
        </s:form>
        <br /><br />
    </div>
    
    
    <table id="chartOfAccountGrid">
        <tr>
            <td valign="top">
                <div id="chartOfAccountGrid">
                    <sjg:grid
                        id="chartOfAccount_grid"
                        dataType="json"
                        href="%{remoteurlChartOfAccount}"
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listChartOfAccountTemp"
                        rowList="10,20,30"
                        rowNum="10"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        >
                        <sjg:gridColumn
                            name="code" index="code" key="code" title="Account Code" width="150" sortable="true"
                        />
                        <sjg:gridColumn
                            name="name" index="name" title="Account Name" width="300" sortable="true"
                        />
                        <sjg:gridColumn
                            name="accountType" index="accountType" title="Type" width="80" sortable="true"
                        />
                        <sjg:gridColumn
                            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
                        />
                    </sjg:grid >
                </div>
            </td>
            <td valign="top">
                <table cellpadding="2" cellspacing="2">
                    <tr><td height="16px"></td></tr>
                    <tr><td><lable>01=Current Assets(D)</lable></td></tr>
                    <tr><td><lable>02=Non Current Assets(D)</lable></td></tr>
                    <tr><td><lable>03=Current Liabilities(C)</lable></td></tr>
                    <tr><td><lable>04=Long Term liabilities(C)</lable></td></tr>
                    <tr><td><lable>05=Capital(C)</lable></td></tr>
                    <tr><td><lable>06=Sales(C)</lable></td></tr>
                    <tr><td><lable>07=Cost Of Goods Sold(D)</lable></td></tr>
                    <tr><td><lable>08=Marketing Expenses(D)</lable></td></tr>
                    <tr><td><lable>09=General And Administration Expenses(D)</lable></td></tr>
                    <tr><td><lable>10=Other Expenses(D)</lable></td></tr>
                    <tr><td><lable>11=Other Revenues(C)</lable></td></tr>
                    <tr><td><lable>12=Income Tax</lable></td></tr>
                </table>
            </td>
        </tr>
    </table>
    

   
    <div id="chartOfAccountInput" class="content ui-widget">
        <s:form id="frmChartOfAccountInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td valign="top" width="75%">
                        <table width="100%">
                            <tr>
                                <td align="right"><B>Account Type *</B></td>
                                <s:textfield id="chartOfAccount.accountType" name="chartOfAccount.accountType" readonly="false" size="5" cssStyle="Display:none"></s:textfield>
                                <td><s:radio id="chartOfAccount.accountTypeRad" name="chartOfAccount.accountTypeRad" key="chartOfAccount.accountTypeRad" list="{'Head','Group','Sub'}"></s:radio></td>                    
                            </tr>
                            <tr>
                                <td align="right"><B>Code *</B></td>
                                <td>
                                    <s:select label="Select Code Type" 
                                        headerKey="-1" 
                                        list="{'Current Assets','Non Current Assets','Current Liabilities','Long Term liabilities','Capital','Sales','Cost Of Goods Sold','Marketing Expenses','General And Administration Expenses','Other Expenses','Other Revenues','Income Tax'}" 
                                        id="chartOfAccount.codeType" name="chartOfAccount.codeType" onchange="onChangeCodeType()" style="width: 37%"/>
                                    <s:textfield id="chartOfAccount.codePrefix" name="chartOfAccount.codePrefix" size="3" readonly="true" cssStyle="text-align:center"></s:textfield>-
                                    <s:textfield id="chartOfAccount.codeHeading" name="chartOfAccount.codeHeading" size="3" cssStyle="text-align:center" maxLength="2"></s:textfield>-
                                    <s:textfield id="chartOfAccount.codeGroup" name="chartOfAccount.codeGroup" size="3" cssStyle="text-align:center" maxLength="3"></s:textfield>-
                                    <s:textfield id="chartOfAccount.codeSub1" name="chartOfAccount.codeSub1" size="5" cssStyle="text-align:center" maxLength="4"></s:textfield>-
                                    <s:textfield id="chartOfAccount.codeSub2" name="chartOfAccount.codeSub2" size="4" cssStyle="text-align:center" maxLength="3"></s:textfield>
                                    <s:textfield id="chartOfAccount.code" name="chartOfAccount.code" readonly="true" cssStyle="Display:none"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Name *</B></td>
                                <td><s:textfield id="chartOfAccount.name" name="chartOfAccount.name" size="90" title="Please Enter Name" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                            </tr>
                            <tr> 
                                <td align="right"><B>Active Status *</B>
                                <s:textfield id="chartOfAccount.activeStatus" name="chartOfAccount.activeStatus" readonly="false" size="5" hidden="true"></s:textfield></td>
                                <td><s:radio id="chartOfAccount.activeStatus" name="chartOfAccount.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                            </tr>
                        </table>
                        <table id="module-status" width="100%">
                            <tr> 
                                <td align="right"><B>BBM Status *</B>
                                    <s:textfield id="chartOfAccount.bbmStatus" name="chartOfAccount.bbmStatus" readonly="false" size="5" hidden="true"></s:textfield></td>
                                <td><s:radio id="chartOfAccount.bbmStatus" name="chartOfAccount.bbmStatus" list="{'Yes','No'}"></s:radio></td>                    
                            </tr>
                            
                            <tr> 
                                <td align="right"><B>BBK Status *</B>
                                    <s:textfield id="chartOfAccount.bbkStatus" name="chartOfAccount.bbkStatus" readonly="false" size="5" hidden="true"></s:textfield></td>
                                <td><s:radio id="chartOfAccount.bbkStatus" name="chartOfAccount.bbkStatus" list="{'Yes','No'}"></s:radio></td>                    
                            </tr>
                            
                            <tr> 
                                <td align="right"><B>BKM Status *</B>
                                    <s:textfield id="chartOfAccount.bkmStatus" name="chartOfAccount.bkmStatus" readonly="false" size="5" hidden="true"></s:textfield></td>
                                <td><s:radio id="chartOfAccount.bkmStatus" name="chartOfAccount.bkmStatus" list="{'Yes','No'}"></s:radio></td>                    
                            </tr>
                            
                            <tr> 
                                <td align="right"><B>BKK Status *</B>
                                    <s:textfield id="chartOfAccount.bkkStatus" name="chartOfAccount.bkkStatus" readonly="false" size="5" hidden="true"></s:textfield></td>
                                <td><s:radio id="chartOfAccount.bkkStatus" name="chartOfAccount.bkkStatus" list="{'Yes','No'}"></s:radio></td>                    
                            </tr>
                            
                            <tr>
                                <td><s:textfield id="chartOfAccount.createdBy"  name="chartOfAccount.createdBy" size="20" style="display:none"></s:textfield></td>
                                <td><s:textfield id="chartOfAccount.createdDate" name="chartOfAccount.createdDate" size="20" style="display:none"></s:textfield></td>
                                <td><s:textfield id="chartOfAccount.currency.code" name="chartOfAccount.currency.code" size="20" style="display:none"></s:textfield></td>
                            </tr>
                            
                            <tr height="50">
                                <td></td>
                                <td>
                                    <sj:a href="#" id="btnChartOfAccountSave" button="true">Save</sj:a>
                                    <sj:a href="#" id="btnChartOfAccountCancel" button="true">Cancel</sj:a>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td valign="top" style="border-style: double">
                        <table cellpadding="2" cellspacing="2">
                            <tr><td><lable>01=Current Assets(D)</lable></td></tr>
                            <tr><td><lable>02=Non Current Assets(D)</lable></td></tr>
                            <tr><td><lable>03=Current Liabilities(C)</lable></td></tr>
                            <tr><td><lable>04=Long Term liabilities(C)</lable></td></tr>
                            <tr><td><lable>05=Capital(C)</lable></td></tr>
                            <tr><td><lable>06=Sales(C)</lable></td></tr>
                            <tr><td><lable>07=Cost Of Goods Sold(D)</lable></td></tr>
                            <tr><td><lable>08=Marketing Expenses(D)</lable></td></tr>
                            <tr><td><lable>09=General And Administration Expenses(D)</lable></td></tr>
                            <tr><td><lable>10=Other Expenses(D)</lable></td></tr>
                            <tr><td><lable>11=Other Revenues(C)</lable></td></tr>
                            <tr><td><lable>12=Income Tax</lable></td></tr>
                        </table>
                    </td>
                </tr>
            </table>
                    
        </s:form>
    </div>
 