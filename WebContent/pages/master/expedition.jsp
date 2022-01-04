
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
        txtExpeditionCode=$("#expedition\\.code"),
        txtExpeditionName=$("#expedition\\.name"),
        txtExpeditionAddress=$("#expedition\\.address"),
        txtExpeditionZipCode=$("#expedition\\.zipCode"),
        txtExpeditionPhone1=$("#expedition\\.phone1"),
        txtExpeditionPhone2=$("#expedition\\.phone2"),
        txtExpeditionFax=$("#expedition\\.fax"),
        txtExpeditionCityCode = $("#expedition\\.city\\.code"),
        txtExpeditionCityName = $("#expedition\\.city\\.name"),
//        txtExpeditionProvinceCode=$("#expedition\\.city\\.province\\.code"),
//        txtExpeditionProvinceName=$("#expedition\\.city\\.province\\.name"),
//        txtExpeditionIslandCode=$("#expedition\\.city\\.province\\.island\\.code"),
//        txtExpeditionIslandName=$("#expedition\\.city\\.province\\.island\\.name"),
        txtExpeditionCountryCode=$("#expedition\\.city\\.province\\.island\\.country\\.code"),
        txtExpeditionCountryName=$("#expedition\\.city\\.province\\.island\\.country\\.name"),
        txtExpeditionContactPerson=$("#expedition\\.contactPerson"),
        txtExpeditionEmail=$("#expedition\\.emailAddress"),
        txtExpeditionRemark=$("#expedition\\.remark"),
        rdbExpeditionActiveStatus=$("#expedition\\.activeStatus"),
        txtExpeditionInActiveBy = $("#expedition\\.inActiveBy"),
        dtpExpeditionInActiveDate = $("#expedition\\.inActiveDate"),
        txtExpeditionCreatedBy = $("#expedition\\.createdBy"),
        dtpExpeditionCreatedDate = $("#expedition\\.createdDate"),
        
        allFieldsExpedition=$([])
            .add(txtExpeditionCode)
            .add(txtExpeditionName)
            .add(txtExpeditionAddress)
            .add(txtExpeditionZipCode)
            .add(txtExpeditionPhone1)
            .add(txtExpeditionPhone2)
            .add(txtExpeditionFax)
            .add(txtExpeditionCityCode)
            .add(txtExpeditionCityName)
            .add(txtExpeditionCountryCode)
            .add(txtExpeditionCountryName)
            .add(txtExpeditionContactPerson)
            .add(txtExpeditionEmail)
            .add(txtExpeditionRemark)
            .add(rdbExpeditionActiveStatus)
            .add(txtExpeditionInActiveBy)
            .add(txtExpeditionCreatedBy);

    function reloadGridExpedition(){
        $("#expedition_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("expedition");
        
        $('#expedition\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#expeditionSearchActiveStatusRadActive').prop('checked',true);
        $("#expeditionSearchActiveStatus").val("true");
        
        $('input[name="expeditionSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#expeditionSearchActiveStatus").val(value);
        });
        
        $('input[name="expeditionSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#expeditionSearchActiveStatus").val(value);
        });
                
        $('input[name="expeditionSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#expeditionSearchActiveStatus").val(value);
        });
        
        $('input[name="expeditionActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#expedition\\.activeStatus").val(value);
            $("#expedition\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="expeditionActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#expedition\\.activeStatus").val(value);
        });
        
        $("#btnExpeditionNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/expedition-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_expedition();
                showInput("expedition");
                hideInput("expeditionSearch");
                $('#expeditionActiveStatusRadActive').prop('checked',true);
                $("#expedition\\.activeStatus").val("true");
                $("#expedition\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#expedition\\.createdDate").val("01/01/1900 00:00:00");
                txtExpeditionCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtExpeditionCode.attr("readonly",true);
                txtExpeditionCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnExpeditionSave").click(function(ev) {
           if(!$("#frmExpeditionInput").valid()) {
//               handlers_input_expedition();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           expeditionFormatDate();
           if (updateRowId < 0){
               url = "master/expedition-save";
           } else{
               url = "master/expedition-update";
           }
           
           var params = $("#frmExpeditionInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    expeditionFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("expedition");
                showInput("expeditionSearch");
                allFieldsExpedition.val('').siblings('label[class="error"]').hide();
                txtExpeditionCode.val("AUTO");
                reloadGridExpedition();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnExpeditionUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/expedition-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_expedition();
                updateRowId=$("#expedition_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var expedition=$("#expedition_grid").jqGrid('getRowData',updateRowId);
                var url="master/expedition-get-data";
                var params="expedition.code=" + expedition.code;

                txtExpeditionCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtExpeditionCode.val(data.expeditionTemp.code);
                        txtExpeditionName.val(data.expeditionTemp.name);
                        txtExpeditionAddress.val(data.expeditionTemp.address);
                        txtExpeditionZipCode.val(data.expeditionTemp.zipCode);
                        txtExpeditionPhone1.val(data.expeditionTemp.phone1);
                        txtExpeditionPhone2.val(data.expeditionTemp.phone2);
                        txtExpeditionFax.val(data.expeditionTemp.fax);
                        txtExpeditionCityCode.val(data.expeditionTemp.cityCode);
                        txtExpeditionCityName.val(data.expeditionTemp.cityName);
                        txtExpeditionCountryCode.val(data.expeditionTemp.countryCode);
                        txtExpeditionCountryName.val(data.expeditionTemp.countryName);
                        txtExpeditionContactPerson.val(data.expeditionTemp.contactPerson);
                        txtExpeditionEmail.val(data.expeditionTemp.emailAddress);
                        rdbExpeditionActiveStatus.val(data.expeditionTemp.activeStatus);
                        txtExpeditionRemark.val(data.expeditionTemp.remark);
                        txtExpeditionInActiveBy.val(data.expeditionTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.expeditionTemp.inActiveDate,true);
                        dtpExpeditionInActiveDate.val(inActiveDate);
                        txtExpeditionCreatedBy.val(data.expeditionTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.expeditionTemp.createdDate,true);
                        dtpExpeditionCreatedDate.val(createdDate);

                        if(data.expeditionTemp.activeStatus===true) {
                           $('#expeditionActiveStatusRadActive').prop('checked',true);
                           $("#expedition\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#expeditionActiveStatusRadInActive').prop('checked',true);              
                           $("#expedition\\.activeStatus").val("false");
                        }

                        showInput("expedition");
                        hideInput("expeditionSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnExpeditionDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/expedition-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#expedition_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var expedition=$("#expedition_grid").jqGrid('getRowData',deleteRowID);
                var url="master/expedition-delete";
                var params="expedition.code=" + expedition.code;
                var message="Are You Sure To Delete(Code : "+ expedition.code + ")?";
                alertMessageDelete("expedition",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ expedition.code+ ')?</div>');
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
//                                var url="master/expedition-delete";
//                                var params="expedition.code=" + expedition.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridExpedition();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + expedition.code+ ")")){
//                    var url="master/expedition-delete";
//                    var params="expedition.code=" + expedition.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridExpedition();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnExpeditionCancel").click(function(ev) {
            hideInput("expedition");
            showInput("expeditionSearch");
            allFieldsExpedition.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnExpeditionRefresh').click(function(ev) {
            $('#expeditionSearchActiveStatusRadActive').prop('checked',true);
            $("#expeditionSearchActiveStatus").val("true");
            $("#expedition_grid").jqGrid("clearGridData");
            $("#expedition_grid").jqGrid("setGridParam",{url:"master/expedition-data?"});
            $("#expedition_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnExpeditionPrint").click(function(ev) {
            
            var url = "reports/expedition-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'expedition','width=500,height=500');
        });
        
        $('#btnExpedition_search').click(function(ev) {
            $("#expedition_grid").jqGrid("clearGridData");
            $("#expedition_grid").jqGrid("setGridParam",{url:"master/expedition-data?" + $("#frmExpeditionSearchInput").serialize()});
            $("#expedition_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_expedition(){
//        unHandlersInput(txtExpeditionCode);
//        unHandlersInput(txtExpeditionName);
//    }
//
//    function handlers_input_expedition(){
//        if(txtExpeditionCode.val()===""){
//            handlersInput(txtExpeditionCode);
//        }else{
//            unHandlersInput(txtExpeditionCode);
//        }
//        if(txtExpeditionName.val()===""){
//            handlersInput(txtExpeditionName);
//        }else{
//            unHandlersInput(txtExpeditionName);
//        }
//    }
    
    function expeditionFormatDate(){
        var inActiveDate=formatDate(dtpExpeditionInActiveDate.val(),true);
        dtpExpeditionInActiveDate.val(inActiveDate);
        $("#expeditionTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpExpeditionCreatedDate.val(),true);
        dtpExpeditionCreatedDate.val(createdDate);
        $("#expeditionTemp\\.createdDateTemp").val(createdDate);
    }
    
    $('#expedition_btnCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=expedition&idsubdoc=city","Search", "Scrollbars=1,width=600, height=500");
        });
</script>

<s:url id="remoteurlExpedition" action="expedition-data" />
<b>EXPEDITION</b>
<hr>
<br class="spacer"/>


<sj:div id="expeditionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnExpeditionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnExpeditionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnExpeditionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnExpeditionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnExpeditionPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="expeditionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmExpeditionSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="expeditionSearchCode" name="expeditionSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="expeditionSearchName" name="expeditionSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="expeditionSearchActiveStatus" name="expeditionSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="expeditionSearchActiveStatusRad" name="expeditionSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnExpedition_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="expeditionGrid">
    <sjg:grid
        id="expedition_grid"
        dataType="json"
        href="%{remoteurlExpedition}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listExpeditionTemp"
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
            name="address" index="address" title="Address" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="zipCode" index="zipCode" title="ZipCode" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="phone1" index="phone1" title="Phone1" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="phone2" index="phone2" title="Phone2" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="fax" index="fax" title="Fax" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="cityCode" index="cityCode" title="CityCode" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="cityName" index="cityName" title="CityName" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="countryCode" index="countryCode" title="CountryCode" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="countryName" index="countryName" title="CountryName" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="contactPerson" index="contactPerson" title="ContactPerson" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="emailAddress" index="emailAddress" title="Email" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
    </sjg:grid>
</div>
    
<div id="expeditionInput" class="content ui-widget">
    <s:form id="frmExpeditionInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="expedition.code" name="expedition.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="expedition.name" name="expedition.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Address *</b></td>
                <td><s:textarea id="expedition.address" name="expedition.address" rows="3" cols="40"  title=" " required="true" cssClass="required"></s:textarea></td>
            </tr>
            <tr>
                <td align="right"><b>ZipCode *</b></td>
                <td><s:textfield id="expedition.zipCode" name="expedition.zipCode" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Phone1 *</b></td>
                <td><s:textfield id="expedition.phone1" name="expedition.phone1" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Phone2 *</b></td>
                <td><s:textfield id="expedition.phone2" name="expedition.phone2" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Fax *</b></td>
                <td><s:textfield id="expedition.fax" name="expedition.fax" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>City *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearExpeditionCityFields(){
                            txtExpeditionCityCode.val("");
                            txtExpeditionCityName.val("");
                            txtExpeditionCountryCode.val("");
                            txtExpeditionCountryName.val("");
                            
                        }
                        
                        txtExpeditionCityCode.change(function(ev) {
                            
                            if(txtExpeditionCityCode.val()===""){
                                clearExpeditionCityFields();
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtExpeditionCityCode.val();
                                params+= "&city.activeStatus=TRUE";
//                                alert(txtExpeditionCityCode.val());
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){
                                    
                                    txtExpeditionCityCode.val(data.cityTemp.code);
                                    txtExpeditionCityName.val(data.cityTemp.name);
                                    txtExpeditionCountryCode.val(data.cityTemp.provinceCountryCode);
                                    txtExpeditionCountryName.val(data.cityTemp.provinceCountryName);
                                     
                                }
                                else{
                                    alertMessage("City Not Found!",txtExpeditionCityCode);
                                    clearExpeditionCityFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="expedition.city.code" name="expedition.city.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="expedition_btnCity" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="expedition.city.name" name="expedition.city.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Country</td>
                <td colspan="2">
                    <s:textfield id="expedition.city.province.island.country.code" name="expedition.city.province.island.country.code" size="20" readonly="true"></s:textfield>
                    <s:textfield id="expedition.city.province.island.country.name" name="expedition.city.province.island.country.name" cssStyle="width:30%" readonly="true"></s:textfield>    
                </td>
            </tr>
            <tr>
                <td align="right"><b>ContactPerson *</b></td>
                <td><s:textfield id="expedition.contactPerson" name="expedition.contactPerson" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Email *</b></td>
                <td><s:textfield id="expedition.emailAddress" name="expedition.emailAddress" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="expeditionActiveStatusRad" name="expeditionActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="expedition.activeStatus" name="expedition.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="expedition.remark" name="expedition.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="expedition.inActiveBy"  name="expedition.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="expedition.inActiveDate" name="expedition.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="expedition.createdBy"  name="expedition.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="expedition.createdDate" name="expedition.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="expeditionTemp.inActiveDateTemp" name="expeditionTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="expeditionTemp.createdDateTemp" name="expeditionTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnExpeditionSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnExpeditionCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>