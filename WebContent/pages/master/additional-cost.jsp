
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
        txtAdditionalCostCode=$("#additionalCost\\.code"),
        txtAdditionalCostName=$("#additionalCost\\.name"),
        txtAdditionalCostChartOfAccountPurchaseChartOfAccountCode=$("#additionalCost\\.purchaseChartOfAccount\\.code"),
        txtAdditionalCostChartOfAccountPurchaseChartOfAccountName=$("#additionalCost\\.purchaseChartOfAccount\\.name"),
        txtAdditionalCostChartOfAccountSalesChartOfAccountCode=$("#additionalCost\\.salesChartOfAccount\\.code"),
        txtAdditionalCostChartOfAccountSalesChartOfAccountName=$("#additionalCost\\.salesChartOfAccount\\.name"),
        chkAdditionalCostPurchaseStatus=$("#additionalCost\\.purchaseStatus"),
        chkAdditionalCostSalesStatus=$("#additionalCost\\.salesStatus"),
        rdbAdditionalCostActiveStatus=$("#additionalCost\\.activeStatus"),
        txtAdditionalCostRemark=$("#additionalCost\\.remark"),
        txtAdditionalCostInActiveBy = $("#additionalCost\\.inActiveBy"),
        dtpAdditionalCostInActiveDate = $("#additionalCost\\.inActiveDate"),
        txtAdditionalCostCreatedBy = $("#additionalCost\\.createdBy"),
        dtpAdditionalCostCreatedDate = $("#additionalCost\\.createdDate"),
        
        allFieldsAdditionalCost=$([])
            .add(txtAdditionalCostCode)
            .add(txtAdditionalCostName)
            .add(txtAdditionalCostChartOfAccountPurchaseChartOfAccountCode)
            .add(txtAdditionalCostChartOfAccountPurchaseChartOfAccountName)
            .add(txtAdditionalCostChartOfAccountSalesChartOfAccountCode)
            .add(txtAdditionalCostChartOfAccountSalesChartOfAccountName)
            .add(txtAdditionalCostRemark)
            .add(txtAdditionalCostInActiveBy)
            .add(txtAdditionalCostCreatedBy);


    function reloadGridAdditionalCost(){
        $("#additionalCost_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("additionalCost");
        
        $('#additionalCost\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#additionalCostSearchActiveStatusRadActive').prop('checked',true);
        $("#additionalCostSearchActiveStatus").val("true");
        
        $('input[name="additionalCostSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#additionalCostSearchActiveStatus").val(value);
        });
        
        $('input[name="additionalCostSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#additionalCostSearchActiveStatus").val(value);
        });
                
        $('input[name="additionalCostSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#additionalCostSearchActiveStatus").val(value);
        });
        
        $('input[name="additionalCostActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#additionalCost\\.activeStatus").val(value);
            $("#additionalCost\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="additionalCostActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#additionalCost\\.activeStatus").val(value);
        });
        
        $("#btnAdditionalCostNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/additional-cost-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_additionalCost();
                showInput("additionalCost");
                hideInput("additionalCostSearch");
                $('#additionalCostActiveStatusRadActive').prop('checked',true);
                $("#additionalCost\\.activeStatus").val("true");
                $("#additionalCost\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#additionalCost\\.createdDate").val("01/01/1900 00:00:00");
                txtAdditionalCostCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtAdditionalCostCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnAdditionalCostSave").click(function(ev) {
           if(!$("#frmAdditionalCostInput").valid()) {
//               handlers_input_additionalCost();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           additionalCostFormatDate();
           if (updateRowId < 0){
               url = "master/additional-cost-save";
           } else{
               url = "master/additional-cost-update";
           }
           
           var params = $("#frmAdditionalCostInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    additionalCostFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("additionalCost");
                showInput("additionalCostSearch");
                allFieldsAdditionalCost.val('').siblings('label[class="error"]').hide();
                reloadGridAdditionalCost();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnAdditionalCostUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/additional-cost-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_additionalCost();
                updateRowId=$("#additionalCost_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var additionalCost=$("#additionalCost_grid").jqGrid('getRowData',updateRowId);
                var url="master/additional-cost-get-data";
                var params="additionalCost.code=" + additionalCost.code;

                txtAdditionalCostCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtAdditionalCostCode.val(data.additionalCostTemp.code);
                        txtAdditionalCostName.val(data.additionalCostTemp.name);
                        rdbAdditionalCostActiveStatus.val(data.additionalCostTemp.activeStatus);
                        txtAdditionalCostRemark.val(data.additionalCostTemp.remark);
                        txtAdditionalCostInActiveBy.val(data.additionalCostTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.additionalCostTemp.inActiveDate,true);
                        dtpAdditionalCostInActiveDate.val(inActiveDate);
                        txtAdditionalCostCreatedBy.val(data.additionalCostTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.additionalCostTemp.createdDate,true);
                        dtpAdditionalCostCreatedDate.val(createdDate);

                        if(data.additionalCostTemp.activeStatus===true) {
                           $('#additionalCostActiveStatusRadActive').prop('checked',true);
                           $("#additionalCost\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#additionalCostActiveStatusRadInActive').prop('checked',true);              
                           $("#additionalCost\\.activeStatus").val("false");
                        }

                        showInput("additionalCost");
                        hideInput("additionalCostSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnAdditionalCostDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/additional-cost-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#additionalCost_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var additionalCost=$("#additionalCost_grid").jqGrid('getRowData',deleteRowID);
                var url="master/additional-cost-delete";
                var params="additionalCost.code=" + additionalCost.code;
                var message="Are You Sure To Delete(Code : "+ additionalCost.code + ")?";
                alertMessageDelete("additionalCost",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ additionalCost.code+ ')?</div>');
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
//                                var url="master/additional-cost-delete";
//                                var params="additionalCost.code=" + additionalCost.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridAdditionalCost();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + additionalCost.code+ ")")){
//                    var url="master/additional-cost-delete";
//                    var params="additionalCost.code=" + additionalCost.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridAdditionalCost();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnAdditionalCostCancel").click(function(ev) {
            hideInput("additionalCost");
            showInput("additionalCostSearch");
            allFieldsAdditionalCost.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnAdditionalCostRefresh').click(function(ev) {
            $('#additionalCostSearchActiveStatusRadActive').prop('checked',true);
            $("#additionalCostSearchActiveStatus").val("true");
            $("#additionalCost_grid").jqGrid("clearGridData");
            $("#additionalCost_grid").jqGrid("setGridParam",{url:"master/additional-cost-data?"});
            $("#additionalCost_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnAdditionalCostPrint").click(function(ev) {
            
            var url = "reports/additional-cost-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'additionalCost','width=500,height=500');
        });
        
        $('#btnAdditionalCost_search').click(function(ev) {
            $("#additionalCost_grid").jqGrid("clearGridData");
            $("#additionalCost_grid").jqGrid("setGridParam",{url:"master/additional-cost-data?" + $("#frmAdditionalCostSearchInput").serialize()});
            $("#additionalCost_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_additionalCost(){
//        unHandlersInput(txtAdditionalCostCode);
//        unHandlersInput(txtAdditionalCostName);
//    }
//
//    function handlers_input_additionalCost(){
//        if(txtAdditionalCostCode.val()===""){
//            handlersInput(txtAdditionalCostCode);
//        }else{
//            unHandlersInput(txtAdditionalCostCode);
//        }
//        if(txtAdditionalCostName.val()===""){
//            handlersInput(txtAdditionalCostName);
//        }else{
//            unHandlersInput(txtAdditionalCostName);
//        }
//    }
    
    function additionalCostFormatDate(){
        var inActiveDate=formatDate(dtpAdditionalCostInActiveDate.val(),true);
        dtpAdditionalCostInActiveDate.val(inActiveDate);
        $("#additionalCostTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpAdditionalCostCreatedDate.val(),true);
        dtpAdditionalCostCreatedDate.val(createdDate);
        $("#additionalCostTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlAdditionalCost" action="additional-cost-data" />
<b>AdditionalCost</b>
<hr>
<br class="spacer"/>


<sj:div id="additionalCostButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnAdditionalCostNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnAdditionalCostUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnAdditionalCostDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnAdditionalCostRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnAdditionalCostPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="additionalCostSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmAdditionalCostSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="additionalCostSearchCode" name="additionalCostSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="additionalCostSearchName" name="additionalCostSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="additionalCostSearchActiveStatus" name="additionalCostSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="additionalCostSearchActiveStatusRad" name="additionalCostSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnAdditionalCost_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="additionalCostGrid">
    <sjg:grid
        id="additionalCost_grid"
        dataType="json"
        href="%{remoteurlAdditionalCost}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listAdditionalCostTemp"
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
    
<div id="additionalCostInput" class="content ui-widget">
    <s:form id="frmAdditionalCostInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="additionalCost.code" name="additionalCost.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="additionalCost.name" name="additionalCost.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="additionalCostActiveStatusRad" name="additionalCostActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="additionalCost.activeStatus" name="additionalCost.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="additionalCost.remark" name="additionalCost.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="additionalCost.inActiveBy"  name="additionalCost.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="additionalCost.inActiveDate" name="additionalCost.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="additionalCost.createdBy"  name="additionalCost.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="additionalCost.createdDate" name="additionalCost.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="additionalCostTemp.inActiveDateTemp" name="additionalCostTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="additionalCostTemp.createdDateTemp" name="additionalCostTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnAdditionalCostSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAdditionalCostCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>