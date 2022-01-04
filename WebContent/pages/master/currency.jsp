
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
        txtCurrencyCode=$("#currency\\.code"),
        txtCurrencyName=$("#currency\\.name"),
        rdbCurrencyActiveStatus=$("#currency\\.activeStatus"),
        txtCurrencyRemark=$("#currency\\.remark"),
        txtCurrencyInActiveBy = $("#currency\\.inActiveBy"),
        dtpCurrencyInActiveDate = $("#currency\\.inActiveDate"),
        txtCurrencyCreatedBy = $("#currency\\.createdBy"),
        dtpCurrencyCreatedDate = $("#currency\\.createdDate"),
        
        allFieldsCurrency=$([])
            .add(txtCurrencyCode)
            .add(txtCurrencyName)
            .add(txtCurrencyRemark)
            .add(txtCurrencyInActiveBy)
            .add(txtCurrencyCreatedBy);


    function reloadGridCurrency(){
        $("#currency_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("currency");
        
        $('#currency\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#currencySearchActiveStatusRadActive').prop('checked',true);
        $("#currencySearchActiveStatus").val("true");
        
        $('input[name="currencySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#currencySearchActiveStatus").val(value);
        });
        
        $('input[name="currencySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#currencySearchActiveStatus").val(value);
        });
                
        $('input[name="currencySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#currencySearchActiveStatus").val(value);
        });
        
        $('input[name="currencyActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#currency\\.activeStatus").val(value);
            $("#currency\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="currencyActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#currency\\.activeStatus").val(value);
        });
        
        $("#btnCurrencyNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/currency-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_currency();
                showInput("currency");
                hideInput("currencySearch");
                $('#currencyActiveStatusRadActive').prop('checked',true);
                $("#currency\\.activeStatus").val("true");
                $("#currency\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#currency\\.createdDate").val("01/01/1900 00:00:00");
                txtCurrencyCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtCurrencyCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCurrencySave").click(function(ev) {
           if(!$("#frmCurrencyInput").valid()) {
//               handlers_input_currency();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           currencyFormatDate();
           if (updateRowId < 0){
               url = "master/currency-save";
           } else{
               url = "master/currency-update";
           }
           
           var params = $("#frmCurrencyInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    currencyFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("currency");
                showInput("currencySearch");
                allFieldsCurrency.val('').siblings('label[class="error"]').hide();
                reloadGridCurrency();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCurrencyUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/currency-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_currency();
                updateRowId=$("#currency_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var currency=$("#currency_grid").jqGrid('getRowData',updateRowId);
                var url="master/currency-get-data";
                var params="currency.code=" + currency.code;

                txtCurrencyCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCurrencyCode.val(data.currencyTemp.code);
                        txtCurrencyName.val(data.currencyTemp.name);
                        rdbCurrencyActiveStatus.val(data.currencyTemp.activeStatus);
                        txtCurrencyRemark.val(data.currencyTemp.remark);
                        txtCurrencyInActiveBy.val(data.currencyTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.currencyTemp.inActiveDate,true);
                        dtpCurrencyInActiveDate.val(inActiveDate);
                        txtCurrencyCreatedBy.val(data.currencyTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.currencyTemp.createdDate,true);
                        dtpCurrencyCreatedDate.val(createdDate);

                        if(data.currencyTemp.activeStatus===true) {
                           $('#currencyActiveStatusRadActive').prop('checked',true);
                           $("#currency\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#currencyActiveStatusRadInActive').prop('checked',true);              
                           $("#currency\\.activeStatus").val("false");
                        }

                        showInput("currency");
                        hideInput("currencySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCurrencyDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/currency-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#currency_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var currency=$("#currency_grid").jqGrid('getRowData',deleteRowID);
                var url="master/currency-delete";
                var params="currency.code=" + currency.code;
                var message="Are You Sure To Delete(Code : "+ currency.code + ")?";
                alertMessageDelete("currency",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ currency.code+ ')?</div>');
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
//                                var url="master/currency-delete";
//                                var params="currency.code=" + currency.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridCurrency();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + currency.code+ ")")){
//                    var url="master/currency-delete";
//                    var params="currency.code=" + currency.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridCurrency();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnCurrencyCancel").click(function(ev) {
            hideInput("currency");
            showInput("currencySearch");
            allFieldsCurrency.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCurrencyRefresh').click(function(ev) {
            $('#currencySearchActiveStatusRadActive').prop('checked',true);
            $("#currencySearchActiveStatus").val("true");
            $("#currency_grid").jqGrid("clearGridData");
            $("#currency_grid").jqGrid("setGridParam",{url:"master/currency-data?"});
            $("#currency_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCurrencyPrint").click(function(ev) {
            
            var url = "reports/currency-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'currency','width=500,height=500');
        });
        
        $('#btnCurrency_search').click(function(ev) {
            $("#currency_grid").jqGrid("clearGridData");
            $("#currency_grid").jqGrid("setGridParam",{url:"master/currency-data?" + $("#frmCurrencySearchInput").serialize()});
            $("#currency_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_currency(){
//        unHandlersInput(txtCurrencyCode);
//        unHandlersInput(txtCurrencyName);
//    }
//
//    function handlers_input_currency(){
//        if(txtCurrencyCode.val()===""){
//            handlersInput(txtCurrencyCode);
//        }else{
//            unHandlersInput(txtCurrencyCode);
//        }
//        if(txtCurrencyName.val()===""){
//            handlersInput(txtCurrencyName);
//        }else{
//            unHandlersInput(txtCurrencyName);
//        }
//    }
    
    function currencyFormatDate(){
        var inActiveDate=formatDate(dtpCurrencyInActiveDate.val(),true);
        dtpCurrencyInActiveDate.val(inActiveDate);
        $("#currencyTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCurrencyCreatedDate.val(),true);
        dtpCurrencyCreatedDate.val(createdDate);
        $("#currencyTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlCurrency" action="currency-data" />
<b>CURRENCY</b>
<hr>
<br class="spacer"/>


<sj:div id="currencyButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCurrencyNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCurrencyUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCurrencyDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCurrencyRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCurrencyPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="currencySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCurrencySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="currencySearchCode" name="currencySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="currencySearchName" name="currencySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="currencySearchActiveStatus" name="currencySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="currencySearchActiveStatusRad" name="currencySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCurrency_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="currencyGrid">
    <sjg:grid
        id="currency_grid"
        dataType="json"
        href="%{remoteurlCurrency}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCurrencyTemp"
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
    
<div id="currencyInput" class="content ui-widget">
    <s:form id="frmCurrencyInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="currency.code" name="currency.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="currency.name" name="currency.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="currencyActiveStatusRad" name="currencyActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="currency.activeStatus" name="currency.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="currency.remark" name="currency.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="currency.inActiveBy"  name="currency.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="currency.inActiveDate" name="currency.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="currency.createdBy"  name="currency.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="currency.createdDate" name="currency.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="currencyTemp.inActiveDateTemp" name="currencyTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="currencyTemp.createdDateTemp" name="currencyTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnCurrencySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCurrencyCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>