
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
        txtCountryCode=$("#country\\.code"),
        txtCountryName=$("#country\\.name"),
        rdbCountryActiveStatus=$("#country\\.activeStatus"),
        txtCountryRemark=$("#country\\.remark"),
        txtCountryInActiveBy = $("#country\\.inActiveBy"),
        dtpCountryInActiveDate = $("#country\\.inActiveDate"),
        txtCountryCreatedBy = $("#country\\.createdBy"),
        dtpCountryCreatedDate = $("#country\\.createdDate"),
        
        allFieldsCountry=$([])
            .add(txtCountryCode)
            .add(txtCountryName)
            .add(txtCountryRemark)
            .add(txtCountryInActiveBy)
            .add(txtCountryCreatedBy);


    function reloadGridCountry(){
        $("#country_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("country");
        
        $('#country\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#countrySearchActiveStatusRadActive').prop('checked',true);
        $("#countrySearchActiveStatus").val("true");
        
        $('input[name="countrySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#countrySearchActiveStatus").val(value);
        });
        
        $('input[name="countrySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#countrySearchActiveStatus").val(value);
        });
                
        $('input[name="countrySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#countrySearchActiveStatus").val(value);
        });
        
        $('input[name="countryActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#country\\.activeStatus").val(value);
            $("#country\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="countryActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#country\\.activeStatus").val(value);
        });
        
        $("#btnCountryNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/country-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_country();
                showInput("country");
                hideInput("countrySearch");
                $('#countryActiveStatusRadActive').prop('checked',true);
                $("#country\\.activeStatus").val("true");
                $("#country\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#country\\.createdDate").val("01/01/1900 00:00:00");
                txtCountryCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtCountryCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCountrySave").click(function(ev) {
           if(!$("#frmCountryInput").valid()) {
//               handlers_input_country();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           countryFormatDate();
           if (updateRowId < 0){
               url = "master/country-save";
           } else{
               url = "master/country-update";
           }
           
           var params = $("#frmCountryInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    countryFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("country");
                showInput("countrySearch");
                allFieldsCountry.val('').siblings('label[class="error"]').hide();
                reloadGridCountry();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCountryUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/country-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_country();
                updateRowId=$("#country_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var country=$("#country_grid").jqGrid('getRowData',updateRowId);
                var url="master/country-get-data";
                var params="country.code=" + country.code;

                txtCountryCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCountryCode.val(data.countryTemp.code);
                        txtCountryName.val(data.countryTemp.name);
                        rdbCountryActiveStatus.val(data.countryTemp.activeStatus);
                        txtCountryRemark.val(data.countryTemp.remark);
                        txtCountryInActiveBy.val(data.countryTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.countryTemp.inActiveDate,true);
                        dtpCountryInActiveDate.val(inActiveDate);
                        txtCountryCreatedBy.val(data.countryTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.countryTemp.createdDate,true);
                        dtpCountryCreatedDate.val(createdDate);

                        if(data.countryTemp.activeStatus===true) {
                           $('#countryActiveStatusRadActive').prop('checked',true);
                           $("#country\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#countryActiveStatusRadInActive').prop('checked',true);              
                           $("#country\\.activeStatus").val("false");
                        }

                        showInput("country");
                        hideInput("countrySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCountryDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/country-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#country_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var country=$("#country_grid").jqGrid('getRowData',deleteRowID);
                var url="master/country-delete";
                var params="country.code=" + country.code;
                var message="Are You Sure To Delete(Code : "+ country.code + ")?";
                alertMessageDelete("country",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ country.code+ ')?</div>');
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
//                                var url="master/country-delete";
//                                var params="country.code=" + country.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridCountry();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + country.code+ ")")){
//                    var url="master/country-delete";
//                    var params="country.code=" + country.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridCountry();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnCountryCancel").click(function(ev) {
            hideInput("country");
            showInput("countrySearch");
            allFieldsCountry.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCountryRefresh').click(function(ev) {
            $('#countrySearchActiveStatusRadActive').prop('checked',true);
            $("#countrySearchActiveStatus").val("true");
            $("#country_grid").jqGrid("clearGridData");
            $("#country_grid").jqGrid("setGridParam",{url:"master/country-data?"});
            $("#country_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCountryPrint").click(function(ev) {
            
            var url = "reports/country-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'country','width=500,height=500');
        });
        
        $('#btnCountry_search').click(function(ev) {
            $("#country_grid").jqGrid("clearGridData");
            $("#country_grid").jqGrid("setGridParam",{url:"master/country-data?" + $("#frmCountrySearchInput").serialize()});
            $("#country_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_country(){
//        unHandlersInput(txtCountryCode);
//        unHandlersInput(txtCountryName);
//    }
//
//    function handlers_input_country(){
//        if(txtCountryCode.val()===""){
//            handlersInput(txtCountryCode);
//        }else{
//            unHandlersInput(txtCountryCode);
//        }
//        if(txtCountryName.val()===""){
//            handlersInput(txtCountryName);
//        }else{
//            unHandlersInput(txtCountryName);
//        }
//    }
    
    function countryFormatDate(){
        var inActiveDate=formatDate(dtpCountryInActiveDate.val(),true);
        dtpCountryInActiveDate.val(inActiveDate);
        $("#countryTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCountryCreatedDate.val(),true);
        dtpCountryCreatedDate.val(createdDate);
        $("#countryTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlCountry" action="country-data" />
<b>Country</b>
<hr>
<br class="spacer"/>


<sj:div id="countryButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCountryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCountryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCountryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCountryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCountryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="countrySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCountrySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="countrySearchCode" name="countrySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="countrySearchName" name="countrySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="countrySearchActiveStatus" name="countrySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="countrySearchActiveStatusRad" name="countrySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCountry_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="countryGrid">
    <sjg:grid
        id="country_grid"
        dataType="json"
        href="%{remoteurlCountry}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCountryTemp"
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
    
<div id="countryInput" class="content ui-widget">
    <s:form id="frmCountryInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="country.code" name="country.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="country.name" name="country.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="countryActiveStatusRad" name="countryActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="country.activeStatus" name="country.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="country.remark" name="country.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="country.inActiveBy"  name="country.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="country.inActiveDate" name="country.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="country.createdBy"  name="country.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="country.createdDate" name="country.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="countryTemp.inActiveDateTemp" name="countryTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="countryTemp.createdDateTemp" name="countryTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnCountrySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCountryCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>