<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<s:url id="remoteurlDriver" action="driver-json" />

<%--<jsp:include page="../search/search-driver-type.jsp"></jsp:include>
<jsp:include page="../search/search-customer.jsp"></jsp:include>--%>

<script type="text/javascript">
    var
            txtDriverCode = $("#driver\\.code"),
            txtDriverName = $("#driver\\.name"),
            txtDriverCityCode = $("#driver\\.city\\.code"),
            txtDriverCityName = $("#driver\\.city\\.name"),
            txtDriverCountryCode = $("#driver\\.city\\.province\\.island\\.country\\.code"),
            txtDriverCountryName = $("#driver\\.city\\.province\\.island\\.country\\.name"),
            txtDriverPhone1 = $("#driver\\.phone1"),
            txtDriverPhone2 = $("#driver\\.phone2"),
            txtDriverAddress = $("#driver\\.address"),
            txtDriverZipCode = $("#driver\\.zipCode"),
            txtDriverFax = $("#driver\\.fax"),
            txtDriverEmail = $("#driver\\.email"),
            txtDriverEmployeeCode = $("#driver\\.employee\\.code"),
            txtDriverEmployeeName = $("#driver\\.employee\\.name"),
            txtDriverEmployeeAddress = $("#driver\\.employee\\.address"),
            txtDriverEmployeeZipCode = $("#driver\\.employee\\.zipCode"),
            txtDriverEmployeeCityCode = $("#driver\\.employee\\.city\\.code"),
            txtDriverEmployeeCityName = $("#driver\\.employee\\.city\\.name"),
            txtDriverEmployeeCountryCode = $("#driver\\.employee\\.city\\.province\\.island\\.country\\.code"),
            txtDriverEmployeeCountryName = $("#driver\\.employee\\.city\\.province\\.island\\.country\\.name"),
            txtDriverEmployeePhone1 = $("#driver\\.employee\\.phone1"),
            txtDriverEmployeePhone2 = $("#driver\\.employee\\.phone2"),
            txtDriverEmployeeFax = $("#driver\\.employee\\.fax"),
            txtDriverEmployeeEmail = $("#driver\\.employee\\.email"),
            txtDriverRemark = $("#driver\\.remark"),
            txtDriverInActiveBy = $("#driver\\.inActiveBy"),
            txtDriverInActiveDate = $("#driver\\.inActiveDate"),
            txtDriverCreatedDate = $("#driver\\.createdDate"),
            txtDriverCreatedBy = $("#driver\\.createdBy"),
            allFieldsDriver = $([])
            .add(txtDriverCode)
            .add(txtDriverName)
            .add(txtDriverRemark)
            .add(txtDriverCityCode)
            .add(txtDriverCityName)
            .add(txtDriverCountryCode)
            .add(txtDriverCountryName)
            .add(txtDriverPhone1)
            .add(txtDriverPhone2)
            .add(txtDriverAddress)
            .add(txtDriverZipCode)
            .add(txtDriverFax)
            .add(txtDriverEmail)
            .add(txtDriverEmployeeCode)
            .add(txtDriverEmployeeName)
            .add(txtDriverEmployeeAddress)
            .add(txtDriverEmployeeZipCode)
            .add(txtDriverEmployeeCityCode)
            .add(txtDriverEmployeeCityName)
            .add(txtDriverEmployeeCountryCode)
            .add(txtDriverEmployeeCountryName)
            .add(txtDriverEmployeePhone1)
            .add(txtDriverEmployeePhone2)
            .add(txtDriverEmployeeFax)
            .add(txtDriverEmployeeEmail)
    ;

    function reloadGridDriver() {
        //
        $("#driver_grid").trigger("reloadGrid");
    };

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("driver");
        
        txtDriverEmployeeCode.keyup(function() {
           this.value = this.value.toUpperCase();
        });
        txtDriverCityCode.keyup(function() {
           this.value = this.value.toUpperCase();
        });

        $('#searchDriverActiveStatusRADActive').prop('checked',true);
            $("#searchDriverActiveStatus").val("yes");
        
        $('input[name="searchDriverActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchDriverActiveStatus").val(value);
        });
        
        $('input[name="searchDriverActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchDriverActiveStatus").val(value);
        });
                
        $('input[name="searchDriverActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchDriverActiveStatus").val(value);
        });
        
        $('#internalExternalStatusINTERNAL').change(function (ev) {
            $("#driver\\.internalExternalStatus").val("INTERNAL");
            $("#driver_btnCity").hide();
            $("#driver_btnEmployee").show();
            
            txtDriverName.attr("readonly",true);
            txtDriverCityCode.attr("readonly",true);
            txtDriverAddress.attr("readonly",true);
            txtDriverZipCode.attr("readonly",true);
            txtDriverPhone1.attr("readonly",true);
            txtDriverPhone2.attr("readonly",true);
            txtDriverEmail.attr("readonly",true);
            txtDriverEmployeeCode.attr("readonly",false);
            
            txtDriverName.val("");
            txtDriverEmployeeCode.val("");
            txtDriverEmployeeName.val("");
            txtDriverEmployeeAddress.val("");
            txtDriverEmployeeZipCode.val("");
            txtDriverEmployeeCityCode.val(""),
            txtDriverEmployeeCityName.val(""),
            txtDriverEmployeeCountryCode.val(""),
            txtDriverEmployeeCountryName.val(""),
            txtDriverEmployeePhone1.val("");
            txtDriverEmployeePhone2.val("");
            txtDriverEmployeeEmail.val("");
            txtDriverCode.val("AUTO");
            txtDriverAddress.val("");
            txtDriverZipCode.val("");
            txtDriverCityCode.val(""),
            txtDriverCityName.val(""),
            txtDriverCountryCode.val(""),
            txtDriverCountryName.val(""),
            txtDriverPhone1.val("");
            txtDriverPhone2.val("");
            txtDriverEmail.val("");
           
        });

        $('#internalExternalStatusEKSTERNAL').change(function (ev) {
            $("#driver\\.internalExternalStatus").val("EXTERNAL");
            $("#driver_btnCity").show();
            $("#driver_btnEmployee").hide();
            
            txtDriverName.attr("readonly",false);
            txtDriverCityCode.attr("readonly",false);
            txtDriverAddress.attr("readonly",false);
            txtDriverZipCode.attr("readonly",false);
            txtDriverPhone1.attr("readonly",false);
            txtDriverPhone2.attr("readonly",false);
            txtDriverEmail.attr("readonly",false);
            txtDriverEmployeeCode.attr("readonly",true);
            
            txtDriverName.val("");
            txtDriverEmployeeCode.val("");
            txtDriverEmployeeName.val("");
            txtDriverEmployeeAddress.val("");
            txtDriverEmployeeZipCode.val("");
            txtDriverEmployeeCityCode.val(""),
            txtDriverEmployeeCityName.val(""),
            txtDriverEmployeeCountryCode.val(""),
            txtDriverEmployeeCountryName.val(""),
            txtDriverEmployeePhone1.val("");
            txtDriverEmployeePhone2.val("");
            txtDriverEmployeeEmail.val("");
            txtDriverCode.val("AUTO");
            txtDriverAddress.val("");
            txtDriverZipCode.val("");
            txtDriverCityCode.val(""),
            txtDriverCityName.val(""),
            txtDriverCountryCode.val(""),
            txtDriverCountryName.val(""),
            txtDriverPhone1.val("");
            txtDriverPhone2.val("");
            txtDriverEmail.val("");
        });

        $('#driverActiveStatusActive').change(function (ev) {
            var value = "true";
            $("#driver\\.activeStatus").val(value);
        });

        $('#driverActiveStatusInActive').change(function (ev) {
            var value = "false";
            $("#driver\\.activeStatus").val(value);
        });

        $("#btnDriverNew").click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/driver-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("driver");
                    $("#driverSearchInput").hide();
                    updateRowId = -1;
                    txtDriverCode.val("AUTO");
                    txtDriverCode.attr("readonly", true);
                    $('#internalExternalStatusINTERNAL').prop('checked', true);
                    $("#driver\\.internalExternalStatus").val("INTERNAL");
                    $("#driver_btnCity").hide();
                    $("#driver_btnEmployee").show();

                    txtDriverName.attr("readonly",true);
                    txtDriverCityCode.attr("readonly",true);
                    txtDriverAddress.attr("readonly",true);
                    txtDriverZipCode.attr("readonly",true);
                    txtDriverPhone1.attr("readonly",true);
                    txtDriverPhone2.attr("readonly",true);
                    txtDriverEmail.attr("readonly",true);
                    txtDriverEmployeeCode.attr("readonly",false);

                    txtDriverName.val("");
                    txtDriverEmployeeCode.val("");
                    txtDriverEmployeeName.val("");
                    txtDriverEmployeeAddress.val("");
                    txtDriverEmployeeZipCode.val("");
                    txtDriverEmployeeCityCode.val(""),
                    txtDriverEmployeeCityName.val(""),
                    txtDriverEmployeeCountryCode.val(""),
                    txtDriverEmployeeCountryName.val(""),
                    txtDriverEmployeePhone1.val("");
                    txtDriverEmployeePhone2.val("");
                    txtDriverEmployeeEmail.val("");
                    txtDriverCode.val("AUTO");
                    txtDriverAddress.val("");
                    txtDriverZipCode.val("");
                    txtDriverCityCode.val(""),
                    txtDriverCityName.val(""),
                    txtDriverCountryCode.val(""),
                    txtDriverCountryName.val(""),
                    txtDriverPhone1.val("");
                    txtDriverPhone2.val("");
                    txtDriverEmail.val("");

                    $('input[name="onCallStatus"][value="Yes"]').prop('checked',true);
                    $("#driver\\.onCallStatus").val("true");

                    $('#driverActiveStatusActive').prop('checked', true);
                    $("#driver\\.activeStatus").val("true");
                    $("#driver\\.inActiveDate").val("01/01/1900");
                    ev.preventDefault();
                });
            });
        });

        $("#btnDriverUpdate").click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/driver-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                updateRowId = $("#driver_grid").jqGrid("getGridParam", "selrow");

                if (updateRowId == null) {
                    alert("Please Select Row");
                } else {
                    var driver = $("#driver_grid").jqGrid('getRowData', updateRowId);
                    var url = "master/driver-get";
                    var params = "driver.code=" + driver.code;

                    txtDriverCode.attr("readonly", true);

                    $.post(url, params, function (result) {
                        var data = (result);
                        txtDriverCreatedBy.val(data.driver.createdBy);
                        txtDriverCreatedDate.val(data.driver.createdDate);
                        txtDriverCode.val(data.driver.code);
                        txtDriverName.val(data.driver.name);
                        txtDriverRemark.val(data.driver.remark);
                        if(data.driver.internalExternalStatus==="EXTERNAL"){
                            $('#internalExternalStatusEKSTERNAL').prop('checked', true);
                            $("#driver\\.internalExternalStatus").val("EXTERNAL");
                            $('#internalExternalStatusINTERNAL').attr('disabled', true);
                            $('#internalExternalStatusEKSTERNAL').attr('disabled', false);
                            txtDriverCityCode.attr("readonly",false);
                            $("#driver_btnCity").show();
                            $("#ui-icon-search-city-driver").show();
                            txtDriverEmployeeCode.attr("readonly",false);
                            $("#driver_btnEmployee").show();
                            $("#ui-icon-search-employee-driver").show();
                            txtDriverAddress.attr("readonly",false);
                            txtDriverZipCode.attr("readonly",false);
                            txtDriverPhone1.attr("readonly",false);
                            txtDriverPhone2.attr("readonly",false);
                            txtDriverEmail.attr("readonly",false);

                            txtDriverAddress.val(data.driver.address);
                            txtDriverZipCode.val(data.driver.zipCode);
                            txtDriverCityCode.val(data.driver.city.code);
                            txtDriverCityName.val(data.driver.city.name);
                            txtDriverCountryCode.val(data.driver.city.province.island.country.code);
                            txtDriverCountryName.val(data.driver.city.province.island.country.name);
                            txtDriverPhone1.val(data.driver.phone1);
                            txtDriverPhone2.val(data.driver.phone2);
                            txtDriverEmail.val(data.driver.email);

                            txtDriverEmployeeCode.val("");
                            txtDriverEmployeeName.val("");
                            txtDriverEmployeeAddress.val("");
                            txtDriverEmployeeZipCode.val("");
                            txtDriverEmployeeCityCode.val(""),
                            txtDriverEmployeeCityName.val(""),
                            txtDriverEmployeeCountryCode.val(""),
                            txtDriverEmployeeCountryName.val(""),
                            txtDriverEmployeePhone1.val("");
                            txtDriverEmployeePhone2.val("");
                            txtDriverEmployeeFax.val("");
                            txtDriverEmployeeEmail.val("");

                        }
                        else if (data.driver.internalExternalStatus==="INTERNAL"){
                            $('#internalExternalStatusINTERNAL').prop('checked', true);
                            $("#driver\\.internalExternalStatus").val("INTERNAL");
                            $('#internalExternalStatusEKSTERNAL').attr('disabled', true);
                            $('#internalExternalStatusINTERNAL').attr('disabled', false);
                            txtDriverCityCode.attr("readonly",true);
                            $("#driver_btnCity").hide();
                            $("#ui-icon-search-city-driver").hide();

                            txtDriverEmployeeCode.attr("readonly",false);
                            $("#driver_btnEmployee").show();
                            $("#ui-icon-search-employee-driver").show();

                            txtDriverAddress.attr("readonly",true);
                            txtDriverZipCode.attr("readonly",true);
                            txtDriverPhone1.attr("readonly",true);
                            txtDriverPhone2.attr("readonly",true);
                            txtDriverEmail.attr("readonly",true);


                            txtDriverEmployeeCode.val(data.driver.employee.code);
                            txtDriverEmployeeName.val(data.driver.employee.name);
                            txtDriverEmployeeAddress.val(data.driver.employee.address);
                            txtDriverEmployeeZipCode.val(data.driver.employee.zipCode);
                            txtDriverEmployeeCityCode.val(data.driver.employee.city.code);
                            txtDriverEmployeeCityName.val(data.driver.employee.city.name);
                            txtDriverEmployeeCountryCode.val(data.driver.employee.city.province.island.country.code);
                            txtDriverEmployeeCountryName.val(data.driver.employee.city.province.island.country.name);
                            txtDriverEmployeePhone1.val(data.driver.phone1);
                            txtDriverEmployeePhone2.val(data.driver.phone2);
                            txtDriverEmployeeEmail.val(data.driver.employee.email);
                            
                            txtDriverAddress.val(data.driver.address);
                            txtDriverZipCode.val(data.driver.zipCode);
                            txtDriverCityCode.val(data.driver.city.code);
                            txtDriverCityName.val(data.driver.city.name);
                            txtDriverCountryCode.val(data.driver.city.province.island.country.code);
                            txtDriverCountryName.val(data.driver.city.province.island.country.name);
                            txtDriverPhone1.val(data.driver.phone1);
                            txtDriverPhone2.val(data.driver.phone2);
                            txtDriverEmail.val(data.driver.email);
                            
//                            txtDriverAddress.val("");
//                            txtDriverZipCode.val("");
//                            txtDriverCityCode.val(""),
//                            txtDriverCityName.val(""),
//                            txtDriverCountryCode.val(""),
//                            txtDriverCountryName.val(""),
//                            txtDriverPhone1.val("");
//                            txtDriverPhone2.val("");
//                            txtDriverEmail.val("");

                        }

                        txtDriverInActiveBy.val(data.driver.inActiveBy);
                        var inActiveDate = data.driver.inActiveDate;
                        var inActiveDate = inActiveDate.split('T')[0];
                        var inActiveDate = inActiveDate.split('-');
                        var inActiveDate = inActiveDate[1] + "/" + inActiveDate[2] + "/" + inActiveDate[0];
                        txtDriverInActiveDate.val(inActiveDate);

                       if (data.driver.onCallStatus == true) {
                            $('input[name="onCallStatus"][value="Yes"]').prop('checked',true);
                            $("#driver\\.onCallStatus").val("true");
                        } else {
                            $('input[name="onCallStatus"][value="No"]').prop('checked',true);
                            $("#driver\\.onCallStatus").val("false");
                        }

                        if (data.driver.activeStatus == true) {
                            $('#driverActiveStatusActive').prop('checked', true);
                            $("#driver\\.activeStatus").val("true");
                        } else {
                            $('#driverActiveStatusInActive').prop('checked', true);
                            $("#driver\\.activeStatus").val("false");
                        }

                        showInput("driver");
                        $("#driverSearchInput").hide();
                    });
                }
                ev.preventDefault();
                });
            });
        });

        $('#btnDriverDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/driver-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#driver_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var driver = $("#driver_grid").jqGrid('getRowData', deleteRowId);

//                        if (confirm("Are You Sure To Delete (Code : " + driver.code + ")")) {
                            var url = "master/driver-delete";
                            var params = "driver.code=" + driver.code;
                            var message="Are You Sure To Delete(Code : "+ driver.code + ")?";
                            alertMessageDelete("driver",url,params,message,400);
//                            $.post(url, params, function () {
                                reloadGridDriver();
//                            });
//                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnDriverSave").click(function (ev) {
            if($("#driver\\.internalExternalStatus").val()==="INTERNAL"){
                if(txtDriverEmployeeCode.val()===""){
                    alertMessage("Field Employee Can't be Empty");
                    return;
                }
            }
            if($("#driver\\.internalExternalStatus").val()==="EXTERNAL"){
                if(txtDriverName.val()===""){
                    alertMessage("Field Name Can't be Empty");
                    return;
                }
                if(txtDriverAddress.val()===""){
                    alertMessage("Field Address Can't be Empty");
                    return;
                }
                if(txtDriverZipCode.val()===""){
                    alertMessage("Field ZipCode Can't be Empty");
                    return;
                }
                if(txtDriverCityCode.val()===""){
                    alertMessage("Field City Can't be Empty");
                    return;
                }
                if(txtDriverPhone1.val()===""){
                    alertMessage("Field Phone 1 Can't be Empty");
                    return;
                }
            }

            var url = "";

            if (updateRowId < 0)
                url = "master/driver-save";
            else
                url = "master/driver-update";

            var params = $("#frmDriverInput").serialize();
            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("driver");
                $("#driverSearchInput").show();
                allFieldsDriver.val('').siblings('label[class="error"]').hide();
                txtDriverCode.val("AUTO");
                reloadGridDriver();
            });
            ev.preventDefault();
        });

        $('#btnDriver_search').click(function(ev) {
            $("#driver_grid").jqGrid("clearGridData");
            $("#driver_grid").jqGrid("setGridParam",{url:"master/driver-search?" + $("#frmDriverSearchInput").serialize()});
            $("#driver_grid").trigger("reloadGrid");
            ev.preventDefault();
        });

        $("#btnDriverCancel").click(function (ev) {
            hideInput("driver");
            $("#driverSearchInput").show();
            allFieldsDriver.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnDriverRefresh').click(function (ev) {
            reloadGridDriver();
        });
    });
        
    function intExt(){
        if($("#driver\\.internalExternalStatus").val() == "INTERNAL"){
            $(".internal").attr("style","display:block");                
            $(".external").attr("style","display:none");                
        }else{
            $(".internal").attr("style","display:none");                
            $(".external").attr("style","display:block");                
        }
    }
</script>
<b>DRIVER</b>
<hr>
<br class="spacer"/> 


<sj:div id="driverButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnDriverNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnDriverUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnDriverDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnDriverRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnDriverPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>    
<div id="driverSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmDriverSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="searchDriver.code" name="searchDriver.code" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="searchDriver.name" name="searchDriver.name" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="searchDriverActiveStatus" name="searchDriverActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchDriverActiveStatusRAD" name="searchDriverActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnDriver_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
        <br/>
    </s:form>
</div>   

<div id="driverGrid">
    <sjg:grid
        id="driver_grid"
        dataType="json"
        href="%{remoteurlDriver}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listDriver"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuDriver').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="125" sortable="false"
            />
        <sjg:gridColumn
            name="address" index="address" title="Address" width="200" sortable="false"
            />
        
        <sjg:gridColumn
            name="city.code" index="city.code" title="City Code" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="city.name" index="city.name" title="City Name" width="125" sortable="false"
            />
        <sjg:gridColumn
            name="city.province.island.country.code" index="city.province.island.country.code" title="Country Code" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="city.province.island.country.name" index="city.province.island.country.name" title="Country Name" width="125" sortable="false"
            />
        <sjg:gridColumn
            name="zipCode" index="zipCode" title="Zip Code" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="phone1" index="phone1" title="Phone 1" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="phone2" index="phone2" title="Phone 2" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="email" index="email" title="Email" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />
        <sjg:gridColumn
            name="internalExternalStatus" index="internalExternalStatus" title="internalExternalStatus" width="100" sortable="false"
            />
         <sjg:gridColumn
            name="onCallStatus" index="onCallStatus" title="onCallStatus" width="100" sortable="false" hidden="true"
            />
    </sjg:grid >
</div>

<div id="driverInput" class="content ui-widget">
    <s:form id="frmDriverInput">
        <div style="width: 100%">
            <table cellpadding="2" cellspacing="2" style="float: left;">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                                <td align="right"><B>Code*</B></td>
                                <td><s:textfield id="driver.code" name="driver.code" title="Please Enter Code!" required="true" cssClass="required" cssStyle="text-align: center;" ></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Name*</B></td>
                                <td><s:textfield id="driver.name" name="driver.name" size="20" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Active Status</B></td>
                                <td>
                                    <s:radio id="driverActiveStatus" name="driverActiveStatus" list="{'Active','InActive'}"></s:radio>
                                </td>
                                <td>
                                    <s:textfield style="display:none" id="driver.activeStatus" name="driver.activeStatus" title="Please Enter Role Name" required="true" size="20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Remark</B></td>
                                <td>
                                    <s:textfield id="driver.remark" name="driver.remark" title="Please Enter Remark" size="20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>InActive By</B></td>
                                <td>
                                    <s:textfield disabled="true" id="driver.inActiveBy" name="driver.inActiveBy" title="Please Enter Remark" size="20" readonly="true"></s:textfield>
                                </td>
                            </tr> 
                            <tr>
                                <td align="right"><B>InActive Date</B></td>
                                <td>
                                    <s:textfield disabled="true" id="driver.inActiveDate" name="driver.inActiveDate" title="Please Enter Remark" size="20" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr> 
                                <td><s:textfield id="driver.createdBy"  name="driver.createdBy" size="20" style="display:none"></s:textfield></td>
                                <td><s:textfield id="driver.createdDate" name="driver.createdDate" size="20" style="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="padding-left: 113px;">
                                    <br />
                                    <div class="error ui-state-error ui-corner-all">
                                        <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
                                    </div>
                                    <br />
                                    </div>
                                    <sj:a href="#" id="btnDriverSave" button="true">Save</sj:a>
                                    <sj:a href="#" id="btnDriverCancel" button="true">Cancel</sj:a>
                                        <br /><br />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table border="true">
                               <tr>
                                   <td colspan="2" align="center">
                                       <table>
                                           <tr>
                                                <td><B>INTERNAL / EKSTERNAL</td>
                                                <td>
                                                    <s:radio id="internalExternalStatus" name="internalExternalStatus" list="{'INTERNAL','EKSTERNAL'}"></s:radio>
                                                </td>
                                                <td>
                                                    <s:textfield style="display:none" id="driver.internalExternalStatus" name="driver.internalExternalStatus" title="Please Enter internalExternalStatus" required="true" value="INTERNAL" size="20"></s:textfield>
                                                </td>
                                                </tr>
                                       </table>
                                   </td>
                               </tr>
                               <tr>
                                   <td>
                                       <table>
                                        <tr>
                                        <td align="right" valign="top"><b>Employee*</b></td>
                                        <td>
                                            <script type = "text/javascript">
                                                $('#driver_btnEmployee').click(function (ev) {
                                                    window.open("./pages/search/search-employee.jsp?iddoc=driver&idsubdoc=employee", "Search", "scrollbars=1,width=600, height=500");
                                                });

                                                txtDriverEmployeeCode.change(function (ev) {
                                                    var url = "master/employee-get";
                                                    var params = "employee.code=" + txtDriverEmployeeCode.val();

                                                    $.post(url, params, function (result) {
                                                        var data = (result);
                                                        if (data.employee) {
                                                            txtDriverEmployeeCode.val(data.employee.code);
                                                            txtDriverEmployeeName.val(data.employee.name);
                                                            txtDriverEmployeeCityCode.val(data.employee.city.code);
                                                            txtDriverEmployeeCityName.val(data.employee.city.name);
                                                            txtDriverEmployeeCountryCode.val(data.employee.city.province.island.country.code),
                                                            txtDriverEmployeeCountryName.val(data.employee.city.province.island.country.name),
                                                            txtDriverEmployeePhone1.val(data.employee.mobileNo1);
                                                            txtDriverEmployeePhone2.val(data.employee.mobileNo2);
                                                            txtDriverEmployeeFax.val(data.employee.fax);
                                                            txtDriverEmployeeEmail.val(data.employee.email);
                                                            txtDriverEmployeeCode.val(data.employee.code);
                                                            txtDriverAddress.val(data.employeeTemp.address);
                                                            txtDriverZipCode.val(data.employeeTemp.zipCode);
                                                            txtDriverCityCode.val(data.employeeTemp.cityCode);
                                                            txtDriverCityName.val(data.employeeTemp.cityName);
                                                            txtDriverCountryCode.val(data.employeeTemp.countryCode);
                                                            txtDriverCountryName.val(data.employeeTemp.countryName);
                                                            txtDriverPhone1.val(data.employeeTemp.phone1);
                                                            txtDriverPhone2.val(data.employeeTemp.phone2);
                                                            txtDriverEmail.val(data.employeeTemp.email);
                                                            txtDriverfax.val(data.employeeTemp.fax);
                                                        } else {
                                                            alert("Employee Not Found");
                                                            txtDriverEmployeeCode.val("");
                                                            txtDriverEmployeeName.val("");
                                                            txtDriverEmployeeCityCode.val("");
                                                            txtDriverEmployeeCityName.val("");
                                                            txtDriverEmployeeCountryCode.val("");
                                                            txtDriverEmployeeCountryName.val("");
                                                            txtDriverEmployeePhone1.val("");
                                                            txtDriverEmployeePhone2.val("");
                                                            txtDriverEmployeeFax.val("");
                                                            txtDriverEmployeeEmail.val("");
                                                            txtDriverAddress.val("");
                                                            txtDriverZipCode.val("");
                                                            txtDriverCityCode.val("");
                                                            txtDriverCityName.val("");
                                                            txtDriverCountryCode.val("");
                                                            txtDriverCountryName.val("");
                                                            txtDriverPhone1.val("");
                                                            txtDriverPhone2.val("");
                                                            txtDriverEmail.val("");
                                                            txtDriverfax.val("");
                                                        }
                                                    });
                                                });
                                            </script>
                                            <div class="searchbox ui-widget-header">
                                            <s:textfield id="driver.employee.code" name="driver.employee.code" title="Please Enter Employee Code" ></s:textfield>
                                            <sj:a id="driver_btnEmployee">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-employee-driver"/></sj:a>
                                            </div>                                    
                                        </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Address</td>
                                            <td><s:textfield id="driver.employee.address" name="driver.employee.address" size="20" readonly="true" disabled="true"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right">Zip Code</td>
                                            <td><s:textfield id="driver.employee.zipCode" name="driver.employee.zipCode" size="20" readonly="true" disabled="true"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top">City </td>
                                            <td>
                                                <s:textfield id="driver.employee.city.code" name="driver.employee.city.code" size="15"  readonly="true" disabled="true"></s:textfield>
                                                <s:textfield id="driver.employee.city.name" name="driver.employee.city.name" size="15"  readonly="true" disabled="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Country</td>
                                            <td> 
                                                <s:textfield id="driver.employee.city.province.island.country.code" name="driver.employee.city.province.island.country.code" readonly="true" disabled="true"></s:textfield>
                                                <s:textfield id="driver.employee.city.province.island.country.name" name="driver.employee.city.province.island.country.name" readonly="true" disabled="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Phone 1</td>
                                            <td>
                                                <s:textfield id="driver.employee.phone1" name="driver.employee.phone1"  size="15"  readonly="true" disabled="true"></s:textfield>
                                                    Phone 2
                                                <s:textfield id="driver.employee.phone2" name="driver.employee.phone2"  size="15"  readonly="true" disabled="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Email</td>
                                            <td>
                                                <s:textfield id="driver.employee.email" name="driver.employee.email" size="25"  readonly="true" disabled="true"></s:textfield>
                                            </td>
                                        </tr>
                                        </table>
                                   </td>
                                   <td>
                                       <table>
                                        <tr>
                                            <td align="right"><B>Address*</B></td>
                                            <td><s:textfield id="driver.address" name="driver.address" size="20" title="Please Enter Address!" required="true" cssClass="required"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><B>Zip Code*</B></td>
                                            <td><s:textfield id="driver.zipCode" name="driver.zipCode" size="20" title="Please Enter Zip Code!" required="true" cssClass="required"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top"><B>City*</B></td>
                                            <td>
                                                <script type = "text/javascript">
                                                    $('#driver_btnCity').click(function (ev) {
                                                        window.open("./pages/search/search-city.jsp?iddoc=driver&idsubdoc=city", "Search", "scrollbars=1,width=600, height=500");
                                                    });

                                                    txtDriverCityCode.change(function (ev) {
                                                        var url = "master/city-get";
                                                        var params = "city.code=" + txtDriverCityCode.val();

                                                        $.post(url, params, function (result) {
                                                            var data = (result);
                                                            if (data.city) {
                                                                txtDriverCityName.val(data.city.name);
                                                                txtDriverCountryCode.val(data.city.province.island.country.code);
                                                                txtDriverCountryName.val(data.city.province.island.country.name);
                                                            } else {
                                                                alert("City Not Found");
                                                                txtDriverCityName.val("");
                                                                txtDriverCountryCode.val("");
                                                                txtDriverCountryName.val("");
                                                            }
                                                        });
                                                    });
                                                </script>
                                                <div class="searchbox ui-widget-header">
                                                <s:textfield id="driver.city.code" name="driver.city.code" title="Please Enter City Code" required="true" cssClass="required"></s:textfield>
                                                <sj:a id="driver_btnCity">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-city-driver"/></sj:a>
                                                </div>                                    
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Country</td>
                                            <td> 
                                            <s:textfield id="driver.city.province.island.country.code" name="driver.city.province.island.country.code" required="true" readonly="true" disabled="true"></s:textfield>
                                            <s:textfield id="driver.city.province.island.country.name" name="driver.city.province.island.country.name" required="true" size="20" readonly="true" disabled="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right"><B>Phone 1*</B></td>
                                            <td>
                                                <s:textfield id="driver.phone1" name="driver.phone1" required="true" title="Please Enter Phone1!" cssClass="required"></s:textfield>
                                                    Phone 2
                                                <s:textfield id="driver.phone2" name="driver.phone2" required="true" size="20" ></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Email</td>
                                            <td>
                                                <s:textfield id="driver.email" name="driver.email" required="true" size="25" ></s:textfield>
                                            </td>
                                        </tr>
                                       </table>
                                   </td>
                               </tr> 
                           </table>
                    </td>
                </tr>
            </table>
    </s:form>
</div>