
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
    th.ui-th-column div{
        white-space:normal !important;
        height:auto !important;
        padding:2px;
    }
</style>

<script type="text/javascript">
     
    var 
        txtAdditionalFeeCode=$("#additionalFee\\.code"),
        txtAdditionalFeeName=$("#additionalFee\\.name"),
        rdbAdditionalFeeActiveStatus=$("#additionalFee\\.activeStatus"),
        txtAdditionalFeeRemark=$("#additionalFee\\.remark"),
        txtAdditionalFeeInActiveBy = $("#additionalFee\\.inActiveBy"),
        dtpAdditionalFeeInActiveDate = $("#additionalFee\\.inActiveDate"),
        txtAdditionalFeeCreatedBy = $("#additionalFee\\.createdBy"),
        dtpAdditionalFeeCreatedDate = $("#additionalFee\\.createdDate"),
        txtAdditionalFeeSalesStatus = $("#additionalFee\\.salesStatus"),
        txtAdditionalFeePurchaseStatus = $("#additionalFee\\.purchaseStatus"),
        txtAdditionalFeePurchaseAccountCode = $("#additionalFee\\.purchaseChartOfAccount\\.code"),
        txtAdditionalFeePurchaseAccountName = $("#additionalFee\\.purchaseChartOfAccount\\.name"),
        txtAdditionalFeeSalesAccountCode = $("#additionalFee\\.salesChartOfAccount\\.code"),
        txtAdditionalFeeSalesAccountName = $("#additionalFee\\.salesChartOfAccount\\.name"),
        
        allFieldsAdditionalFee=$([])
            .add(txtAdditionalFeeCode)
            .add(txtAdditionalFeeName)
            .add(txtAdditionalFeeRemark)
            .add(txtAdditionalFeeSalesStatus)
            .add(txtAdditionalFeePurchaseStatus)
            .add(txtAdditionalFeePurchaseAccountCode)
            .add(txtAdditionalFeePurchaseAccountName)
            .add(txtAdditionalFeeSalesAccountCode)
            .add(txtAdditionalFeeSalesAccountName)
            .add(txtAdditionalFeeInActiveBy)
            .add(txtAdditionalFeeCreatedBy);


    function reloadGridAdditionalFee(){
        $("#additionalFee_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("additionalFee");
        
        $('#additionalFee\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#additionalFeeSearchActiveStatusRadActive').prop('checked',true);
        $("#additionalFeeSearchActiveStatus").val("true");
        
        $('input[name="additionalFeeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#additionalFeeSearchActiveStatus").val(value);
        });
        
        $('input[name="additionalFeeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#additionalFeeSearchActiveStatus").val(value);
        });
                
        $('input[name="additionalFeeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#additionalFeeSearchActiveStatus").val(value);
        });
        
        $('input[name="additionalFeeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#additionalFee\\.activeStatus").val(value);
            $("#additionalFee\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="additionalFeeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#additionalFee\\.activeStatus").val(value);
        });
        
        if(!$('#additionalFeePurchaseStatus').is(':checked')){
                var value="false";
                $("#additionalFee\\.purchaseStatus").val(value);
                enabledDisabledPurchaseStatus(value);
            }
        
        if(!$('#additionalFeeSalesStatus').is(':checked')){
                var value="false";
                $("#additionalFee\\.salesStatus").val(value);
                enabledDisabledSalesStatus(value);
            }
        
        $('#additionalFeePurchaseStatus').click(function(){
            if($('#additionalFeePurchaseStatus').is(':checked')){
                var value="true";
                $("#additionalFee\\.purchaseStatus").val(value);
                enabledDisabledPurchaseStatus(value);
            }
            if(!$('#additionalFeePurchaseStatus').is(':checked')){
                var value="false";
                $("#additionalFee\\.purchaseStatus").val(value);
                enabledDisabledPurchaseStatus(value);
            }
        });
        
        $('#additionalFeeSalesStatus').click(function(){
            if($('#additionalFeeSalesStatus').is(':checked')){
                var value="true";
                $("#additionalFee\\.salesStatus").val(value);
                enabledDisabledSalesStatus(value);
            }
            if(!$('#additionalFeeSalesStatus').is(':checked')){
                var value="false";
                $("#additionalFee\\.salesStatus").val(value);
                enabledDisabledSalesStatus(value);
            }
        });
        
        $("#btnAdditionalFeeNew").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/additional-fee-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_additionalFee();
                allFieldsAdditionalFee.val('').removeClass('ui-state-error');
                showInput("additionalFee");
                hideInput("additionalFeeSearch");
                $('#additionalFeeActiveStatusRadActive').prop('checked',true);
                $("#additionalFee\\.activeStatus").val("true");
                $("#additionalFee\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#additionalFee\\.createdDate").val("01/01/1900 00:00:00");
                updateRowId = -1;

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnAdditionalFeeSave").click(function(ev) {
           if(!$("#frmAdditionalFeeInput").valid()) {
//               handlers_input_additionalFee();
               ev.preventDefault();
               return;
           };
           
           if(txtAdditionalFeeSalesStatus.val()==="true" && txtAdditionalFeeSalesAccountCode.val()===""){
              alertMessage("Sales Account Can't be Empty!");
              return; 
           }
            if(txtAdditionalFeePurchaseStatus.val()==="true" && txtAdditionalFeePurchaseAccountCode.val()===""){
              alertMessage("Purchase Account Can't be Empty!");
              return; 
           }
           
           var url = "";
           additionalFeeFormatDate();
           if (updateRowId < 0){
               url = "master/additional-fee-save";
           } else{
               url = "master/additional-fee-update";
           }
           
           var params = $("#frmAdditionalFeeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    additionalFeeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("additionalFee");
                showInput("additionalFeeSearch");
                allFieldsAdditionalFee.val('').siblings('label[class="error"]').hide();
                reloadGridAdditionalFee();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnAdditionalFeeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/additional-fee-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_additionalFee();
                updateRowId=$("#additionalFee_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var additionalFee=$("#additionalFee_grid").jqGrid('getRowData',updateRowId);
                var url="master/additional-fee-get-data";
                var params="additionalFee.code=" + additionalFee.code;

                txtAdditionalFeeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtAdditionalFeeCode.val(data.additionalFeeTemp.code);
                        txtAdditionalFeeName.val(data.additionalFeeTemp.name);
                        txtAdditionalFeePurchaseAccountCode.val(data.additionalFeeTemp.purchaseChartOfAccountCode);
                        txtAdditionalFeePurchaseAccountName.val(data.additionalFeeTemp.purchaseChartOfAccountName);
                        txtAdditionalFeeSalesAccountCode.val(data.additionalFeeTemp.salesChartOfAccountCode);
                        txtAdditionalFeeSalesAccountName.val(data.additionalFeeTemp.salesChartOfAccountName);
                        rdbAdditionalFeeActiveStatus.val(data.additionalFeeTemp.activeStatus);
                        txtAdditionalFeeRemark.val(data.additionalFeeTemp.remark);
                        txtAdditionalFeeInActiveBy.val(data.additionalFeeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.additionalFeeTemp.inActiveDate,true);
                        dtpAdditionalFeeInActiveDate.val(inActiveDate);
                        txtAdditionalFeeCreatedBy.val(data.additionalFeeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.additionalFeeTemp.createdDate,true);
                        dtpAdditionalFeeCreatedDate.val(createdDate);

                        if(data.additionalFeeTemp.activeStatus===true) {
                            $('#additionalFeeActiveStatusRadActive').prop('checked',true);
                            $("#additionalFee\\.activeStatus").val("true");
                        }
                        else {                        
                            $('#additionalFeeActiveStatusRadInActive').prop('checked',true);              
                            $("#additionalFee\\.activeStatus").val("false");
                        }
                        if(data.additionalFeeTemp.salesStatus===true) {
                            $('#additionalFeeSalesStatus').prop('checked',true);
                            $("#additionalFee\\.salesStatus").val("true");
                            var value = "true";
                        }
                        else {                        
                            $('#additionalFeeSalesStatus').prop('checked',false);              
                            $("#additionalFee\\.salesStatus").val("false");
                            var value = "false";
                        }
                        if(data.additionalFeeTemp.purchaseStatus===true) {
                            $('#additionalFeePurchaseStatus').prop('checked',true);
                            $("#additionalFee\\.purchaseStatus").val("true");
                            var value_pur = "true";
                        }
                        else {                        
                            $('#additionalFeePurchaseStatus').prop('checked',false);              
                            $("#additionalFee\\.purchaseStatus").val("false");
                            var value_pur = "false";
                        }
                        enabledDisabledPurchaseStatus(value_pur);
                        enabledDisabledSalesStatus(value);
                        showInput("additionalFee");
                        hideInput("additionalFeeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnAdditionalFeeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/additional-fee-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#additionalFee_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var additionalFee=$("#additionalFee_grid").jqGrid('getRowData',deleteRowID);
                var url="master/additional-fee-delete";
                var params="additionalFee.code=" + additionalFee.code;
                var message="Are You Sure To Delete(Code : "+ additionalFee.code + ")?";
                alertMessageDelete("additionalFee",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ additionalFee.code+ ')?</div>');
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
//                                var url="master/additional-fee-delete";
//                                var params="additionalFee.code=" + additionalFee.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridAdditionalFee();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + additionalFee.code+ ")")){
//                    var url="master/additional-fee-delete";
//                    var params="additionalFee.code=" + additionalFee.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridAdditionalFee();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnAdditionalFeeCancel").click(function(ev) {
            hideInput("additionalFee");
            showInput("additionalFeeSearch");
            allFieldsAdditionalFee.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnAdditionalFeeRefresh').click(function(ev) {
            $('#additionalFeeSearchActiveStatusRadActive').prop('checked',true);
            $("#additionalFeeSearchActiveStatus").val("true");
            $("#additionalFee_grid").jqGrid("clearGridData");
            $("#additionalFee_grid").jqGrid("setGridParam",{url:"master/additional-fee-data?"});
            $("#additionalFee_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnAdditionalFeePrint").click(function(ev) {
            
            var url = "reports/additional-fee-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'additionalFee','width=500,height=500');
        });
        
        $('#btnAdditionalFee_search').click(function(ev) {
            $("#additionalFee_grid").jqGrid("clearGridData");
            $("#additionalFee_grid").jqGrid("setGridParam",{url:"master/additional-fee-data?" + $("#frmAdditionalFeeSearchInput").serialize()});
            $("#additionalFee_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#additionalFee_btnPurchaseCOA').click(function(ev) {
            window.open("./pages/search/search-chart-of-account.jsp?iddoc=additionalFee&idsubdoc=purchaseChartOfAccount","Search", "scrollbars=1,width=600, height=500");
        });

        $('#additionalFee_btnSalesCOA').click(function(ev) {
                window.open("./pages/search/search-chart-of-account.jsp?iddoc=additionalFee&idsubdoc=salesChartOfAccount","Search", "scrollbars=1,width=600, height=500");
        });
        
    });
    
    function enabledDisabledPurchaseStatus(value){
        switch(value){
            case "true":   
                $("#additionalFee\\.purchaseChartOfAccount\\.code").attr('readonly',false);
                $("#additionalFee\\.purchaseChartOfAccount\\.code").focus();
                $("#additionalFee_btnPurchaseCOA").show();
                break;
            case "false":
                $("#additionalFee\\.purchaseChartOfAccount\\.code").attr('readonly',true);
                $("#additionalFee\\.purchaseChartOfAccount\\.code").focus();
                $("#additionalFee_btnPurchaseCOA").hide();
                $("#additionalFee\\.purchaseChartOfAccount\\.code").val("");
                $("#additionalFee\\.purchaseChartOfAccount\\.name").val("");
                break;
        }
    }
    
    function enabledDisabledSalesStatus(value){
        switch(value){
            case "true":   
                $("#additionalFee\\.salesChartOfAccount\\.code").attr('readonly',false);
                $("#additionalFee\\.salesChartOfAccount\\.code").focus();
                $("#additionalFee_btnSalesCOA").show();
                break;
            case "false":
                $("#additionalFee\\.salesChartOfAccount\\.code").attr('readonly',true);
                $("#additionalFee\\.salesChartOfAccount\\.code").focus();
                $("#additionalFee_btnSalesCOA").hide();
                $("#additionalFee\\.salesChartOfAccount\\.code").val("");
                $("#additionalFee\\.salesChartOfAccount\\.name").val("");
                break;
        }
    }
    
//    function unHandlers_input_additionalFee(){
//        unHandlersInput(txtAdditionalFeeCode);
//        unHandlersInput(txtAdditionalFeeName);
//    }
//
//    function handlers_input_additionalFee(){
//        if(txtAdditionalFeeCode.val()===""){
//            handlersInput(txtAdditionalFeeCode);
//        }else{
//            unHandlersInput(txtAdditionalFeeCode);
//        }
//        if(txtAdditionalFeeName.val()===""){
//            handlersInput(txtAdditionalFeeName);
//        }else{
//            unHandlersInput(txtAdditionalFeeName);
//        }
//    }
    
    function additionalFeeFormatDate(){
        var inActiveDate=formatDate(dtpAdditionalFeeInActiveDate.val(),true);
        dtpAdditionalFeeInActiveDate.val(inActiveDate);
        $("#additionalFeeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpAdditionalFeeCreatedDate.val(),true);
        dtpAdditionalFeeCreatedDate.val(createdDate);
        $("#additionalFeeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlAdditionalFee" action="additional-fee-data" />
<b>Additional Fee</b>
<hr>
<br class="spacer"/>


<sj:div id="additionalFeeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnAdditionalFeeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnAdditionalFeeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnAdditionalFeeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnAdditionalFeeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnAdditionalFeePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
    </table>
</sj:div>      
    
<div id="additionalFeeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmAdditionalFeeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="additionalFeeSearchCode" name="additionalFeeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="additionalFeeSearchName" name="additionalFeeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="additionalFeeSearchActiveStatus" name="additionalFeeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="additionalFeeSearchActiveStatusRad" name="additionalFeeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnAdditionalFee_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="additionalFeeGrid">
    <sjg:grid
        id="additionalFee_grid"
        dataType="json"
        href="%{remoteurlAdditionalFee}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listAdditionalFeeTemp"
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
            name="name" index="name" title="Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="purchaseStatus" index="purchaseStatus" title="Purchase Status" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="purchaseChartOfAccountCode" index="purchaseChartOfAccountCode" title="Purchase Account Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="purchaseChartOfAccountName" index="purchaseChartOfAccountName" title="Purchase Account Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="salesStatus" index="salesStatus" title="Sales Status" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="salesChartOfAccountCode" index="salesChartOfAccountCode" title="Sales Account Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="salesChartOfAccountName" index="salesChartOfAccountName" title="Sales Account Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="additionalFeeInput" class="content ui-widget">
    <s:form id="frmAdditionalFeeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="additionalFee.code" name="additionalFee.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="additionalFee.name" name="additionalFee.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Sales Status *</B></td>
                <td colspan="2">
                    <s:checkbox id="additionalFeeSalesStatus" name="additionalFeeSalesStatus" value="false"></s:checkbox>
                    <s:textfield id="additionalFee.salesStatus" name="additionalFee.salesStatus" size="5" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Sales Account</B></td>
                <td>
                    <script type = "text/javascript">

                    txtAdditionalFeeSalesAccountCode.change(function (ev) {

                        if (txtAdditionalFeeSalesAccountCode.val() === "") {
                            txtAdditionalFeeSalesAccountName.val("");
                            return;
                        }
                        var url = "master/chart-of-account-get";
                        var params = "chartOfAccount.code=" + txtAdditionalFeeSalesAccountCode.val();
                        params += "&chartOfAccount.activeStatus=true";
                        params += "&chartOfAccount.AccountType=S";

                        $.post(url, params, function (result) {
                            var data = (result);
                            if (data.chartOfAccountTemp) {
                                txtAdditionalFeeSalesAccountCode.val(data.chartOfAccountTemp.code);
                                txtAdditionalFeeSalesAccountName.val(data.chartOfAccountTemp.name);
                            } else {
                                alertMessage("Chart Of Account Not Found!", txtAdditionalFeeSalesAccountCode);
                                txtAdditionalFeeSalesAccountCode.val("");
                                txtAdditionalFeeSalesAccountName.val("");
                            }
                        });
                    });
                  </script>
                    <div class="searchbox ui-widget-header">
                    <s:textfield id="additionalFee.salesChartOfAccount.code" name="additionalFee.salesChartOfAccount.code" title=" " size = "15"></s:textfield>
                    <sj:a id="additionalFee_btnSalesCOA" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="additionalFee.salesChartOfAccount.name" name="additionalFee.salesChartOfAccount.name" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B><B>Purchase Status *</B></td>
                <td colspan="2">
                    <s:checkbox id="additionalFeePurchaseStatus" name="additionalFeePurchaseStatus" value="false"></s:checkbox>
                    <s:textfield id="additionalFee.purchaseStatus" name="additionalFee.purchaseStatus" size="5" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Purchase Account</B></td>
                <td>
                    <script type = "text/javascript">

                    txtAdditionalFeePurchaseAccountCode.change(function (ev) {

                        if (txtAdditionalFeePurchaseAccountCode.val() === "") {
                            txtAdditionalFeePurchaseAccountName.val("");
                            return;
                        }
                        var url = "master/chart-of-account-get";
                        var params = "chartOfAccount.code=" + txtAdditionalFeePurchaseAccountCode.val();
                        params += "&chartOfAccount.activeStatus=true";
                        params += "&chartOfAccount.AccountType=S";

                        $.post(url, params, function (result) {
                            var data = (result);
                            if (data.chartOfAccountTemp) {
                                txtAdditionalFeePurchaseAccountCode.val(data.chartOfAccountTemp.code);
                                txtAdditionalFeePurchaseAccountName.val(data.chartOfAccountTemp.name);
                            } else {
                                alertMessage("Chart Of Account Not Found!", txtAdditionalFeePurchaseAccountCode);
                                txtAdditionalFeePurchaseAccountCode.val("");
                                txtAdditionalFeePurchaseAccountName.val("");
                            }
                        });
                    });
                  </script>
                    <div class="searchbox ui-widget-header">
                    <s:textfield id="additionalFee.purchaseChartOfAccount.code" name="additionalFee.purchaseChartOfAccount.code" title=" " size = "15"></s:textfield>
                    <sj:a id="additionalFee_btnPurchaseCOA" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="additionalFee.purchaseChartOfAccount.name" name="additionalFee.purchaseChartOfAccount.name" title=" " size = "20" readonly = "true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="additionalFeeActiveStatusRad" name="additionalFeeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="additionalFee.activeStatus" name="additionalFee.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="additionalFee.remark" name="additionalFee.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="additionalFee.inActiveBy"  name="additionalFee.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="additionalFee.inActiveDate" name="additionalFee.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="additionalFee.createdBy"  name="additionalFee.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="additionalFee.createdDate" name="additionalFee.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="additionalFeeTemp.inActiveDateTemp" name="additionalFeeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="additionalFeeTemp.createdDateTemp" name="additionalFeeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnAdditionalFeeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAdditionalFeeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>