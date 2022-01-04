
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
        txtPaymentTermCode=$("#paymentTerm\\.code"),
        txtPaymentTermName=$("#paymentTerm\\.name"),
        txtPaymentTermDays=$("#paymantTerm\\.days"),
        rdbPaymentTermActiveStatus=$("#paymentTerm\\.activeStatus"),
        txtPaymentTermRemark=$("#paymentTerm\\.remark"),
        txtPaymentTermInActiveBy = $("#paymentTerm\\.inActiveBy"),
        dtpPaymentTermInActiveDate = $("#paymentTerm\\.inActiveDate"),
        txtPaymentTermCreatedBy = $("#paymentTerm\\.createdBy"),
        dtpPaymentTermCreatedDate = $("#paymentTerm\\.createdDate"),
        
        allFieldsPaymentTerm=$([])
            .add(txtPaymentTermCode)
            .add(txtPaymentTermName)
            .add(txtPaymentTermDays)
            .add(txtPaymentTermRemark)
            .add(txtPaymentTermInActiveBy)
            .add(txtPaymentTermCreatedBy);


    function reloadGridPaymentTerm(){
        $("#paymentTerm_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("paymentTerm");
        
        $('#paymentTerm\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#paymentTermSearchActiveStatusRadActive').prop('checked',true);
        $("#paymentTermSearchActiveStatus").val("true");
        
        $('input[name="paymentTermSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#paymentTermSearchActiveStatus").val(value);
        });
        
        $('input[name="paymentTermSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#paymentTermSearchActiveStatus").val(value);
        });
                
        $('input[name="paymentTermSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#paymentTermSearchActiveStatus").val(value);
        });
        
        $('input[name="paymentTermActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#paymentTerm\\.activeStatus").val(value);
            $("#paymentTerm\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="paymentTermActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#paymentTerm\\.activeStatus").val(value);
        });
        
        $("#btnPaymentTermNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/payment-term-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_paymentTerm();
                showInput("paymentTerm");
                hideInput("paymentTermSearch");
                $('#paymentTermActiveStatusRadActive').prop('checked',true);
                $("#paymentTerm\\.activeStatus").val("true");
                $("#paymentTerm\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#paymentTerm\\.createdDate").val("01/01/1900 00:00:00");
                txtPaymentTermCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtPaymentTermCode.attr("readonly",true);
                txtPaymentTermCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnPaymentTermSave").click(function(ev) {
           if(!$("#frmPaymentTermInput").valid()) {
//               handlers_input_paymentTerm();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           paymentTermFormatDate();
           if (updateRowId < 0){
               url = "master/payment-term-save";
           } else{
               url = "master/payment-term-update";
           }
           
           var params = $("#frmPaymentTermInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    paymentTermFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("paymentTerm");
                showInput("paymentTermSearch");
                allFieldsPaymentTerm.val('').siblings('label[class="error"]').hide();
                txtPaymentTermCode.val("AUTO");
                reloadGridPaymentTerm();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnPaymentTermUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/payment-term-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_paymentTerm();
                updateRowId=$("#paymentTerm_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var paymentTerm=$("#paymentTerm_grid").jqGrid('getRowData',updateRowId);
                var url="master/payment-term-get-data";
                var params="paymentTerm.code=" + paymentTerm.code;

                txtPaymentTermCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtPaymentTermCode.val(data.paymentTermTemp.code);
                        txtPaymentTermName.val(data.paymentTermTemp.name);
                        txtPaymentTermDays.val(data.paymentTermTemp.days);
                        rdbPaymentTermActiveStatus.val(data.paymentTermTemp.activeStatus);
                        txtPaymentTermRemark.val(data.paymentTermTemp.remark);
                        txtPaymentTermInActiveBy.val(data.paymentTermTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.paymentTermTemp.inActiveDate,true);
                        dtpPaymentTermInActiveDate.val(inActiveDate);
                        txtPaymentTermCreatedBy.val(data.paymentTermTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.paymentTermTemp.createdDate,true);
                        dtpPaymentTermCreatedDate.val(createdDate);

                        if(data.paymentTermTemp.activeStatus===true) {
                           $('#paymentTermActiveStatusRadActive').prop('checked',true);
                           $("#paymentTerm\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#paymentTermActiveStatusRadInActive').prop('checked',true);              
                           $("#paymentTerm\\.activeStatus").val("false");
                        }

                        showInput("paymentTerm");
                        hideInput("paymentTermSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnPaymentTermDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/payment-term-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#paymentTerm_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var paymentTerm=$("#paymentTerm_grid").jqGrid('getRowData',deleteRowID);
                var url="master/payment-term-delete";
                var params="paymentTerm.code=" + paymentTerm.code;
                var message="Are You Sure To Delete(Code : "+ paymentTerm.code + ")?";
                alertMessageDelete("paymentTerm",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ paymentTerm.code+ ')?</div>');
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
//                                var url="master/payment-term-delete";
//                                var params="paymentTerm.code=" + paymentTerm.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridPaymentTerm();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + paymentTerm.code+ ")")){
//                    var url="master/payment-term-delete";
//                    var params="paymentTerm.code=" + paymentTerm.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridPaymentTerm();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnPaymentTermCancel").click(function(ev) {
            hideInput("paymentTerm");
            showInput("paymentTermSearch");
            allFieldsPaymentTerm.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnPaymentTermRefresh').click(function(ev) {
            $('#paymentTermSearchActiveStatusRadActive').prop('checked',true);
            $("#paymentTermSearchActiveStatus").val("true");
            $("#paymentTerm_grid").jqGrid("clearGridData");
            $("#paymentTerm_grid").jqGrid("setGridParam",{url:"master/payment-term-data?"});
            $("#paymentTerm_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnPaymentTermPrint").click(function(ev) {
            
            var url = "reports/payment-term-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'paymentTerm','width=500,height=500');
        });
        
        $('#btnPaymentTerm_search').click(function(ev) {
            $("#paymentTerm_grid").jqGrid("clearGridData");
            $("#paymentTerm_grid").jqGrid("setGridParam",{url:"master/payment-term-data?" + $("#frmPaymentTermSearchInput").serialize()});
            $("#paymentTerm_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_paymentTerm(){
//        unHandlersInput(txtPaymentTermCode);
//        unHandlersInput(txtPaymentTermName);
//    }
//
//    function handlers_input_paymentTerm(){
//        if(txtPaymentTermCode.val()===""){
//            handlersInput(txtPaymentTermCode);
//        }else{
//            unHandlersInput(txtPaymentTermCode);
//        }
//        if(txtPaymentTermName.val()===""){
//            handlersInput(txtPaymentTermName);
//        }else{
//            unHandlersInput(txtPaymentTermName);
//        }
//    }
    
    function paymentTermFormatDate(){
        var inActiveDate=formatDate(dtpPaymentTermInActiveDate.val(),true);
        dtpPaymentTermInActiveDate.val(inActiveDate);
        $("#paymentTermTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpPaymentTermCreatedDate.val(),true);
        dtpPaymentTermCreatedDate.val(createdDate);
        $("#paymentTermTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlPaymentTerm" action="payment-term-data" />
<b>Payment Term</b>
<hr>
<br class="spacer"/>


<sj:div id="paymentTermButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnPaymentTermNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnPaymentTermUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnPaymentTermDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnPaymentTermRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPaymentTermPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="paymentTermSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmPaymentTermSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="paymentTermSearchCode" name="paymentTermSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="paymentTermSearchName" name="paymentTermSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="paymentTermSearchActiveStatus" name="paymentTermSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="paymentTermSearchActiveStatusRad" name="paymentTermSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnPaymentTerm_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="paymentTermGrid">
    <sjg:grid
        id="paymentTerm_grid"
        dataType="json"
        href="%{remoteurlPaymentTerm}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPaymentTermTemp"
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
            name="days" index="days" title="Days" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="paymentTermInput" class="content ui-widget">
    <s:form id="frmPaymentTermInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="paymentTerm.code" name="paymentTerm.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="paymentTerm.name" name="paymentTerm.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Days *</b></td>
                <td><s:textfield id="paymentTerm.days" name="paymentTerm.days" size="10" title="*" required="true" cssClass="required" maxLength="2"></s:textfield> Day(s)</td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="paymentTermActiveStatusRad" name="paymentTermActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="paymentTerm.activeStatus" name="paymentTerm.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="paymentTerm.remark" name="paymentTerm.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="paymentTerm.inActiveBy"  name="paymentTerm.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="paymentTerm.inActiveDate" name="paymentTerm.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="paymentTerm.createdBy"  name="paymentTerm.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="paymentTerm.createdDate" name="paymentTerm.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="paymentTermTemp.inActiveDateTemp" name="paymentTermTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="paymentTermTemp.createdDateTemp" name="paymentTermTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnPaymentTermSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnPaymentTermCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>