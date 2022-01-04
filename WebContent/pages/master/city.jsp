
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
        txtCityCode=$("#city\\.code"),
        txtCityName=$("#city\\.name"),
        txtCityProvinceCode=$("#city\\.province\\.code"),
        txtCityProvinceName=$("#city\\.province\\.name"),
        txtCityProvinceIslandCode=$("#city\\.province\\.island\\.code"),
        txtCityProvinceIslandName=$("#city\\.province\\.island\\.name"),
        txtCityProvinceCountryCode=$("#city\\.province\\.island\\.country\\.code"),
        txtCityProvinceCountryName=$("#city\\.province\\.island\\.country\\.name"),
        rdbCityActiveStatus=$("#city\\.activeStatus"),
        txtCityRemark=$("#city\\.remark"),
        txtCityInActiveBy = $("#city\\.inActiveBy"),
        dtpCityInActiveDate = $("#city\\.inActiveDate"),
        txtCityCreatedBy = $("#city\\.createdBy"),
        dtpCityCreatedDate = $("#city\\.createdDate"),
        
        allFieldsCity=$([])
            .add(txtCityCode)
            .add(txtCityName)
            .add(txtCityProvinceCode)
            .add(txtCityProvinceName)
            .add(txtCityProvinceIslandCode)
            .add(txtCityProvinceIslandName)
            .add(txtCityProvinceCountryCode)
            .add(txtCityProvinceCountryName)
            .add(rdbCityActiveStatus)
            .add(txtCityRemark)
            .add(txtCityInActiveBy)
            .add(txtCityCreatedBy);


    function reloadGridCity(){
        $("#city_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("city");
        
        $('#city\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#citySearchActiveStatusRadActive').prop('checked',true);
        $("#citySearchActiveStatus").val("true");
        
        $('input[name="citySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#citySearchActiveStatus").val(value);
        });
        
        $('input[name="citySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#citySearchActiveStatus").val(value);
        });
                
        $('input[name="citySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#citySearchActiveStatus").val(value);
        });
        
        $('input[name="cityActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#city\\.activeStatus").val(value);
            $("#city\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="cityActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#city\\.activeStatus").val(value);
        });
        
        $("#btnCityNew").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/city-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_city();
                showInput("city");
                hideInput("citySearch");
                $('#cityActiveStatusRadActive').prop('checked',true);
                $("#city\\.activeStatus").val("true");
                $("#city\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#city\\.createdDate").val("01/01/1900 00:00:00");
                txtCityCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtCityCode.attr("readonly",false);

            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCitySave").click(function(ev) {
           if(!$("#frmCityInput").valid()) {
//               handlers_input_city();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           cityFormatDate();
           if (updateRowId < 0){
               url = "master/city-save";
           } else{
               url = "master/city-update";
           }
           
           var params = $("#frmCityInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    cityFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("city");
                showInput("citySearch");
                allFieldsCity.val('').siblings('label[class="error"]').hide();
                reloadGridCity();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCityUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/city-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_city();
                updateRowId=$("#city_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var city=$("#city_grid").jqGrid('getRowData',updateRowId);
                var url="master/city-get-data";
                var params="city.code=" + city.code;

                txtCityCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCityCode.val(data.cityTemp.code);
                        txtCityName.val(data.cityTemp.name);
                        txtCityProvinceCode.val(data.cityTemp.provinceCode);
                        txtCityProvinceName.val(data.cityTemp.provinceName);
                        txtCityProvinceIslandCode.val(data.cityTemp.provinceIslandCode);
                        txtCityProvinceIslandName.val(data.cityTemp.provinceIslandName);
                        txtCityProvinceCountryCode.val(data.cityTemp.provinceCountryCode);
                        txtCityProvinceCountryName.val(data.cityTemp.provinceCountryName);
                        rdbCityActiveStatus.val(data.cityTemp.activeStatus);
                        txtCityRemark.val(data.cityTemp.remark);
                        txtCityInActiveBy.val(data.cityTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.cityTemp.inActiveDate,true);
                        dtpCityInActiveDate.val(inActiveDate);
                        txtCityCreatedBy.val(data.cityTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.cityTemp.createdDate,true);
                        dtpCityCreatedDate.val(createdDate);

                        if(data.cityTemp.activeStatus===true) {
                           $('#cityActiveStatusRadActive').prop('checked',true);
                           $("#city\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#cityActiveStatusRadInActive').prop('checked',true);              
                           $("#city\\.activeStatus").val("false");
                        }

                        showInput("city");
                        hideInput("citySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnCityDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/city-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#city_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var city=$("#city_grid").jqGrid('getRowData',deleteRowID);
                var url="master/city-delete";
                var params="city.code=" + city.code;
                var message="Are You Sure To Delete(Code : "+ city.code + ")?";
                alertMessageDelete("city",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ city.code+ ')?</div>');
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
//                                var url="master/city-delete";
//                                var params="city.code=" + city.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridCity();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + city.code+ ")")){
//                    var url="master/city-delete";
//                    var params="city.code=" + city.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridCity();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnCityCancel").click(function(ev) {
            hideInput("city");
            showInput("citySearch");
            allFieldsCity.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCityRefresh').click(function(ev) {
            $('#citySearchActiveStatusRadActive').prop('checked',true);
            $("#citySearchActiveStatus").val("true");
            $("#city_grid").jqGrid("clearGridData");
            $("#city_grid").jqGrid("setGridParam",{url:"master/city-data?"});
            $("#city_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCityPrint").click(function(ev) {
            
            var url = "reports/city-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'city','width=500,height=500');
        });
        
        $('#btnCity_search').click(function(ev) {
            $("#city_grid").jqGrid("clearGridData");
            $("#city_grid").jqGrid("setGridParam",{url:"master/city-data?" + $("#frmCitySearchInput").serialize()});
            $("#city_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#city_btnProvince').click(function(ev) {
            window.open("./pages/search/search-province.jsp?iddoc=city&idsubdoc=province","Search", "Scrollbars=1,width=600, height=500");
        });
    });
    
//    function unHandlers_input_city(){
//        unHandlersInput(txtCityCode);
//        unHandlersInput(txtCityName);
//    }
//
//    function handlers_input_city(){
//        if(txtCityCode.val()===""){
//            handlersInput(txtCityCode);
//        }else{
//            unHandlersInput(txtCityCode);
//        }
//        if(txtCityName.val()===""){
//            handlersInput(txtCityName);
//        }else{
//            unHandlersInput(txtCityName);
//        }
//    }
    
    function cityFormatDate(){
        var inActiveDate=formatDate(dtpCityInActiveDate.val(),true);
        dtpCityInActiveDate.val(inActiveDate);
        $("#cityTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCityCreatedDate.val(),true);
        dtpCityCreatedDate.val(createdDate);
        $("#cityTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlCity" action="city-data" />
<b>CITY</b>
<hr>
<br class="spacer"/>

<sj:div id="cityButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCityNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCityUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCityDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCityRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCityPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>    
    
<div id="citySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCitySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="citySearchCode" name="citySearchCode" size="20" Placeholder=" Code"></s:textfield>
                    <s:textfield id="citySearchName" name="citySearchName" size="40" Placeholder=" Name"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center" >Island</td>
                <td>
                    <s:textfield id="citySearchIslandCode" name="citySearchIslandCode" size="20" Placeholder=" Code"></s:textfield>
                    <s:textfield id="citySearchIslandName" name="citySearchIslandName" size="40" Placeholder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="center" >Province</td>
                <td>
                    <s:textfield id="citySearchProvinceCode" name="citySearchProvinceCode" size="20" Placeholder=" Code"></s:textfield>
                    <s:textfield id="citySearchProvinceName" name="citySearchProvinceName" size="40" Placeholder=" Name"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center" >Country</td>
                <td>
                    <s:textfield id="citySearchCountryCode" name="citySearchCountryCode" size="20" Placeholder=" Code"></s:textfield>
                    <s:textfield id="citySearchCountryName" name="citySearchCountryName" size="40" Placeholder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Status</td>
                <td>
                    <s:textfield id="citySearchActiveStatus" name="citySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    <s:radio id="citySearchActiveStatusRad" name="citySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCity_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="cityGrid">
    <sjg:grid
        id="city_grid"
        dataType="json"
        href="%{remoteurlCity}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCityTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="1000"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="provinceCode" index="provinceCode" key="provinceCode" title="Province Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="provinceName" index="provinceName" title="Province Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="provinceIslandCode" index="provinceIslandCode" key="provinceIslandCode" title="Island Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="provinceIslandName" index="provinceIslandName" key="provinceIslandName" title="Island Name" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="provinceCountryCode" index="provinceCountryCode" key="provinceCountryCode" title="Country Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="provinceCountryName" index="provinceCountryName" title="Country Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="cityInput" class="content ui-widget">
    <s:form id="frmCityInput">
        <table cellpadding="2" cellspacing="2" width="100%">
            <tr>
                <td align="right" width="100px"><b>Code *</b></td>
                <td><s:textfield id="city.code" name="city.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="city.name" name="city.name" cssStyle="width:30%" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Province *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearCityProviceFields(){
                            txtCityProvinceCode.val("");
                            txtCityProvinceName.val("");
                            txtCityProvinceIslandCode.val("");
                            txtCityProvinceIslandName.val("");
                            txtCityProvinceCountryCode.val("");
                            txtCityProvinceCountryName.val("");
                            
                        }
                        
                        txtCityProvinceCode.change(function(ev) {
                            
                            if(txtCityProvinceCode.val()===""){
                                clearCityProviceFields();
                                return;
                            }
                            var url = "master/province-get";
                            var params = "province.code=" + txtCityProvinceCode.val();
                                params+= "&province.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.provinceTemp){
                                    txtCityProvinceCode.val(data.provinceTemp.code);
                                    txtCityProvinceName.val(data.provinceTemp.name);
                                    txtCityProvinceIslandCode.val(data.provinceTemp.islandCode);
                                    txtCityProvinceIslandName.val(data.provinceTemp.islandName);
                                    txtCityProvinceCountryCode.val(data.provinceTemp.countryCode);
                                    txtCityProvinceCountryName.val(data.provinceTemp.countryName);
                                }
                                else{
                                    alertMessage("Province Not Found!",txtCityProvinceCode);
                                    clearCityProviceFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="city.province.code" name="city.province.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="city_btnProvince" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="city.province.name" name="city.province.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Island</td>
                <td colspan="2">
                    <s:textfield id="city.province.island.code" name="city.province.island.code" size="20" readonly="true"></s:textfield>
                    <s:textfield id="city.province.island.name" name="city.province.island.name" cssStyle="width:30%" readonly="true"></s:textfield>    
                </td>
            </tr>
            <tr>
                <td align="right">Country</td>
                <td colspan="2">
                    <s:textfield id="city.province.island.country.code" name="city.province.island.country.code" size="20" readonly="true"></s:textfield>
                    <s:textfield id="city.province.island.country.name" name="city.province.island.country.name" cssStyle="width:30%" readonly="true"></s:textfield>    
                </td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="cityActiveStatusRad" name="cityActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="city.activeStatus" name="city.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="city.remark" name="city.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="city.inActiveBy"  name="city.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="city.inActiveDate" name="city.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="city.createdBy"  name="city.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="city.createdDate" name="city.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="cityTemp.inActiveDateTemp" name="cityTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="cityTemp.createdDateTemp" name="cityTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnCitySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnCityCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>