<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<s:url id="remoteurlCoDriver" action="co-driver-json" />

<%--<jsp:include page="../search/search-coDriver-type.jsp"></jsp:include>
<jsp:include page="../search/search-customer.jsp"></jsp:include>--%>

<script type="text/javascript">
    var
            txtCoDriverCode = $("#coDriver\\.code"),
            txtCoDriverName = $("#coDriver\\.name"),
            txtCoDriverCityCode = $("#coDriver\\.city\\.code"),
            txtCoDriverCityName = $("#coDriver\\.city\\.name"),
            txtCoDriverCountryCode = $("#coDriver\\.city\\.province\\.island\\.country\\.code"),
            txtCoDriverCountryName = $("#coDriver\\.city\\.province\\.island\\.country\\.name"),
            txtCoDriverPhone1 = $("#coDriver\\.phone1"),
            txtCoDriverPhone2 = $("#coDriver\\.phone2"),
            txtCoDriverAddress = $("#coDriver\\.address"),
            txtCoDriverZipCode = $("#coDriver\\.zipCode"),
            txtCoDriverFax = $("#coDriver\\.fax"),
            txtCoDriverEmailAddress = $("#coDriver\\.emailAddress"),
            txtCoDriverEmployeeCode = $("#coDriver\\.employee\\.code"),
            txtCoDriverEmployeeName = $("#coDriver\\.employee\\.name"),
            txtCoDriverEmployeeAddress = $("#coDriver\\.employee\\.address"),
            txtCoDriverEmployeeZipCode = $("#coDriver\\.employee\\.zipCode"),
            txtCoDriverEmployeeCityCode = $("#coDriver\\.employee\\.city\\.code"),
            txtCoDriverEmployeeCityName = $("#coDriver\\.employee\\.city\\.name"),
            txtCoDriverEmployeeCountryCode = $("#coDriver\\.employee\\.city\\.province\\.island\\.country\\.code"),
            txtCoDriverEmployeeCountryName = $("#coDriver\\.employee\\.city\\.province\\.island\\.country\\.name"),
            txtCoDriverEmployeePhone1 = $("#coDriver\\.employee\\.phone1"),
            txtCoDriverEmployeePhone2 = $("#coDriver\\.employee\\.phone2"),
            txtCoDriverEmployeeFax = $("#coDriver\\.employee\\.fax"),
            txtCoDriverEmployeeEmailAddress = $("#coDriver\\.employee\\.emailAddress"),
            txtCoDriverRemark = $("#coDriver\\.remark"),
            txtCoDriverInActiveBy = $("#coDriver\\.inActiveBy"),
            txtCoDriverInActiveDate = $("#coDriver\\.inActiveDate"),
            txtCoDriverCreatedDate = $("#coDriver\\.createdDate"),
            txtCoDriverCreatedBy = $("#coDriver\\.createdBy"),
            allFieldsCoDriver = $([])
            .add(txtCoDriverCode)
            .add(txtCoDriverName)
            .add(txtCoDriverRemark)
            .add(txtCoDriverCityCode)
            .add(txtCoDriverCityName)
            .add(txtCoDriverCountryCode)
            .add(txtCoDriverCountryName)
            .add(txtCoDriverPhone1)
            .add(txtCoDriverPhone2)
            .add(txtCoDriverAddress)
            .add(txtCoDriverZipCode)
            .add(txtCoDriverFax)
            .add(txtCoDriverEmailAddress)
            .add(txtCoDriverEmployeeCode)
            .add(txtCoDriverEmployeeName)
            .add(txtCoDriverEmployeeAddress)
            .add(txtCoDriverEmployeeZipCode)
            .add(txtCoDriverEmployeeCityCode)
            .add(txtCoDriverEmployeeCityName)
            .add(txtCoDriverEmployeeCountryCode)
            .add(txtCoDriverEmployeeCountryName)
            .add(txtCoDriverEmployeePhone1)
            .add(txtCoDriverEmployeePhone2)
            .add(txtCoDriverEmployeeFax)
            .add(txtCoDriverEmployeeEmailAddress)
    ;

    function reloadGridCoDriver() {
        $("#coDriver_grid").trigger("reloadGrid");
    };

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("coDriver");
        $('#coDriver\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        $('#searchCoDriverActiveStatusRADActive').prop('checked',true);
            $("#searchCoDriverActiveStatus").val("yes");
        
        $('input[name="searchCoDriverActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchCoDriverActiveStatus").val(value);
        });
        
        $('input[name="searchCoDriverActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchCoDriverActiveStatus").val(value);
        });
                
        $('input[name="searchCoDriverActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchCoDriverActiveStatus").val(value);
        });
        
        $('#internalExternalStatusINTERNAL').change(function (ev) {
            $("#coDriver\\.internalExternalStatus").val("INTERNAL");
            txtCoDriverName.attr("readonly",true);
            txtCoDriverCityCode.attr("readonly",true);
            $("#coDriver_btnCity").hide();
            $("#ui-icon-search-city-coDriver").hide();
            
            txtCoDriverAddress.attr("readonly",true);
            txtCoDriverZipCode.attr("readonly",true);
            txtCoDriverPhone1.attr("readonly",true);
            txtCoDriverPhone2.attr("readonly",true);
            txtCoDriverEmailAddress.attr("readonly",true);
            
            txtCoDriverEmployeeCode.attr("readonly",false);
            $("#coDriver_btnEmployee").show();
            $("#ui-icon-search-employee-coDriver").show();
            
            txtCoDriverName.val("");
            txtCoDriverCode.val("AUTO");
            txtCoDriverName.val("");
            txtCoDriverAddress.val("");
            txtCoDriverZipCode.val("");
            txtCoDriverCityCode.val(""),
            txtCoDriverCityName.val(""),
            txtCoDriverCountryCode.val(""),
            txtCoDriverCountryName.val(""),
            txtCoDriverPhone1.val("");
            txtCoDriverPhone2.val("");
            txtCoDriverEmailAddress.val("");
           
        });

        $('#internalExternalStatusEKSTERNAL').change(function (ev) {
            $("#coDriver\\.internalExternalStatus").val("EXTERNAL");
            txtCoDriverName.attr("readonly",false);
            txtCoDriverCityCode.attr("readonly",false);
            $("#coDriver_btnCity").show();
            $("#ui-icon-search-city-coDriver").show();
            
            txtCoDriverAddress.attr("readonly",false);
            txtCoDriverZipCode.attr("readonly",false);
            txtCoDriverPhone1.attr("readonly",false);
            txtCoDriverPhone2.attr("readonly",false);
            txtCoDriverEmailAddress.attr("readonly",false);

            $("#coDriver_btnCity").show();
            $("#ui-icon-search-city-coDriver").show();

            txtCoDriverEmployeeCode.attr("readonly",true);
            $("#coDriver_btnEmployee").hide();
            $("#ui-icon-search-employee-coDriver").hide();
            txtCoDriverName.val("");
            txtCoDriverEmployeeCode.val("");
            txtCoDriverEmployeeName.val("");
            txtCoDriverEmployeeAddress.val("");
            txtCoDriverEmployeeZipCode.val("");
            txtCoDriverEmployeeCityCode.val(""),
            txtCoDriverEmployeeCityName.val(""),
            txtCoDriverEmployeeCountryCode.val(""),
            txtCoDriverEmployeeCountryName.val(""),
            txtCoDriverEmployeePhone1.val("");
            txtCoDriverEmployeePhone2.val("");
            txtCoDriverEmployeeEmailAddress.val("");
            txtCoDriverCode.val("AUTO");
            txtCoDriverAddress.val("");
            txtCoDriverZipCode.val("");
            txtCoDriverCityCode.val(""),
            txtCoDriverCityName.val(""),
            txtCoDriverCountryCode.val(""),
            txtCoDriverCountryName.val(""),
            txtCoDriverPhone1.val("");
            txtCoDriverPhone2.val("");
            txtCoDriverEmailAddress.val("");
        });

        $('#coDriverActiveStatusActive').change(function (ev) {
            var value = "true";
            $("#coDriver\\.activeStatus").val(value);
        });

        $('#coDriverActiveStatusInActive').change(function (ev) {
            var value = "false";
            $("#coDriver\\.activeStatus").val(value);
        });

        $('#onCallStatusYes').change(function (ev) {
            var value = "true";
            $("#coDriver\\.onCallStatus").val(value);
        });

        $('#onCallStatusNo').change(function (ev) {
            var value = "false";
            $("#coDriver\\.onCallStatus").val(value);
        });

        $("#btnCoDriverNew").click(function (ev) {

                
                var url="master/co-driver-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("coDriver");
                    $("#coDriverSearchInput").hide();
                    updateRowId = -1;
                    txtCoDriverCode.val("AUTO");
                    txtCoDriverCode.attr("readonly", true);
                    $('#internalExternalStatusINTERNAL').attr('disabled', false);
                    $('#internalExternalStatusEKSTERNAL').attr('disabled', false);
                    $('#internalExternalStatusINTERNAL').prop('checked', true);
                    $("#coDriver\\.internalExternalStatus").val("INTERNAL");

                    txtCoDriverName.attr("readonly",true);
                    txtCoDriverCityCode.attr("readonly",true);
                    $("#coDriver_btnCity").hide();
                    $("#ui-icon-search-city-coDriver").hide();
                    txtCoDriverAddress.attr("readonly",true);
                    txtCoDriverZipCode.attr("readonly",true);
                    txtCoDriverPhone1.attr("readonly",true);
                    txtCoDriverPhone2.attr("readonly",true);
                    txtCoDriverEmailAddress.attr("readonly",true);

                    txtCoDriverEmployeeCode.attr("readonly",false);
                    $("#coDriver_btnEmployee").show();
                    $("#ui-icon-search-employee-coDriver").show();

                    $('input[name="onCallStatus"][value="Yes"]').prop('checked',true);
                    $("#coDriver\\.onCallStatus").val("true");

                    $('#coDriverActiveStatusActive').prop('checked', true);
                    $("#coDriver\\.activeStatus").val("true");
                    $("#coDriver\\.inActiveDate").val("01/01/1900");

        //            $('#internalExternalStatusINTERNAL').prop('checked', true);
        //            $('#coDriverActiveStatusActive').prop('checked', true);
        //            $('#onCallStatusYes').prop('checked', true);
        //            var value = "true";
        //            $("#coDriver\\.internalExternalStatus").val("INTERNAL");
        //            $("#coDriver\\.activeStatus").val(value);
        //            $("#coDriver\\.onCallStatus").val(value);
        //            $("#coDriver\\.inActiveDate").val("01/01/1900");
        //            intExt();
                    ev.preventDefault();
                });

        });

        $("#btnCoDriverUpdate").click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/co-driver-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                updateRowId = $("#coDriver_grid").jqGrid("getGridParam", "selrow");

                if (updateRowId == null) {
                    alertMessage("Please Select Row");
                } else {
                    var coDriver = $("#coDriver_grid").jqGrid('getRowData', updateRowId);
                    var url = "master/co-driver-get";
                    var params = "coDriver.code=" + coDriver.code;

                    txtCoDriverCode.attr("readonly", true);

                    $.post(url, params, function (result) {
                        var data = (result);
                        txtCoDriverCreatedBy.val(data.coDriver.createdBy);
                        txtCoDriverCreatedDate.val(data.coDriver.createdDate);
                        txtCoDriverCode.val(data.coDriver.code);
                        txtCoDriverName.val(data.coDriver.name);
                        txtCoDriverRemark.val(data.coDriver.remark);
                        if(data.coDriver.internalExternalStatus==="EXTERNAL"){
                            $('#internalExternalStatusEKSTERNAL').prop('checked', true);
                            $("#coDriver\\.internalExternalStatus").val("EXTERNAL");
                            $('#internalExternalStatusINTERNAL').attr('disabled', true);
                            $('#internalExternalStatusEKSTERNAL').attr('disabled', false);
                            txtCoDriverCityCode.attr("readonly",false);
                            $("#coDriver_btnCity").show();
                            $("#ui-icon-search-city-coDriver").show();
                            txtCoDriverEmployeeCode.attr("readonly",true);
                            $("#coDriver_btnEmployee").hide();
                            $("#ui-icon-search-employee-coDriver").hide();
                            txtCoDriverAddress.attr("readonly",false);
                            txtCoDriverZipCode.attr("readonly",false);
                            txtCoDriverPhone1.attr("readonly",false);
                            txtCoDriverPhone2.attr("readonly",false);
                            txtCoDriverEmailAddress.attr("readonly",false);

                            txtCoDriverAddress.val(data.coDriver.address);
                            txtCoDriverZipCode.val(data.coDriver.zipCode);
                            txtCoDriverCityCode.val(data.coDriver.city.code);
                            txtCoDriverCityName.val(data.coDriver.city.name);
                            txtCoDriverCountryCode.val(data.coDriver.city.province.island.country.code);
                            txtCoDriverCountryName.val(data.coDriver.city.province.island.country.name);
                            txtCoDriverPhone1.val(data.coDriver.phone1);
                            txtCoDriverPhone2.val(data.coDriver.phone2);
                            txtCoDriverEmailAddress.val(data.coDriver.emailAddress);

                            txtCoDriverEmployeeCode.val("");
                            txtCoDriverEmployeeName.val("");
                            txtCoDriverEmployeeAddress.val("");
                            txtCoDriverEmployeeZipCode.val("");
                            txtCoDriverEmployeeCityCode.val(""),
                            txtCoDriverEmployeeCityName.val(""),
                            txtCoDriverEmployeeCountryCode.val(""),
                            txtCoDriverEmployeeCountryName.val(""),
                            txtCoDriverEmployeePhone1.val("");
                            txtCoDriverEmployeePhone2.val("");
                            txtCoDriverEmployeeFax.val("");
                            txtCoDriverEmployeeEmailAddress.val("");

                        }
                        else if (data.coDriver.internalExternalStatus==="INTERNAL"){
                            $('#internalExternalStatusINTERNAL').prop('checked', true);
                            $("#coDriver\\.internalExternalStatus").val("INTERNAL");
                            $('#internalExternalStatusEKSTERNAL').attr('disabled', true);
                            $('#internalExternalStatusINTERNAL').attr('disabled', false);
                            txtCoDriverCityCode.attr("readonly",true);
                            $("#coDriver_btnCity").hide();
                            $("#ui-icon-search-city-coDriver").hide();

                            txtCoDriverEmployeeCode.attr("readonly",false);
                            $("#coDriver_btnEmployee").show();
                            $("#ui-icon-search-employee-coDriver").show();

                            txtCoDriverAddress.attr("readonly",true)
                            txtCoDriverZipCode.attr("readonly",true);
                            txtCoDriverPhone1.attr("readonly",true);
                            txtCoDriverPhone2.attr("readonly",true);
                            txtCoDriverEmailAddress.attr("readonly",true);


                            txtCoDriverEmployeeCode.val(data.coDriver.employee.code);
                            txtCoDriverEmployeeName.val(data.coDriver.employee.name);
                            txtCoDriverEmployeeAddress.val(data.coDriver.employee.address);
                            txtCoDriverEmployeeZipCode.val(data.coDriver.employee.zipCode);
                            txtCoDriverEmployeeCityCode.val(data.coDriver.employee.city.code);
                            txtCoDriverEmployeeCityName.val(data.coDriver.employee.city.name);
                            txtCoDriverEmployeeCountryCode.val(data.coDriver.employee.city.province.island.country.code);
                            txtCoDriverEmployeeCountryName.val(data.coDriver.employee.city.province.island.country.name);
                            txtCoDriverEmployeePhone1.val(data.coDriver.phone1);
                            txtCoDriverEmployeePhone2.val(data.coDriver.phone2);
                            txtCoDriverEmployeeEmailAddress.val(data.coDriver.employee.emailAddress);

                            txtCoDriverAddress.val("");
                            txtCoDriverZipCode.val("");
                            txtCoDriverCityCode.val(""),
                            txtCoDriverCityName.val(""),
                            txtCoDriverCountryCode.val(""),
                            txtCoDriverCountryName.val(""),
                            txtCoDriverPhone1.val("");
                            txtCoDriverPhone2.val("");
                            txtCoDriverEmailAddress.val("");

                        }

                        txtCoDriverInActiveBy.val(data.coDriver.inActiveBy);
                        var inActiveDate = data.coDriver.inActiveDate;
                        var inActiveDate = inActiveDate.split('T')[0];
                        var inActiveDate = inActiveDate.split('-');
                        var inActiveDate = inActiveDate[1] + "/" + inActiveDate[2] + "/" + inActiveDate[0];
                        txtCoDriverInActiveDate.val(inActiveDate);


                        if (data.coDriver.activeStatus == true) {
                            $('#coDriverActiveStatusActive').prop('checked', true);
                            $("#coDriver\\.activeStatus").val("true");
                        } else {
                            $('#coDriverActiveStatusInActive').prop('checked', true);
                            $("#coDriver\\.activeStatus").val("false");
                        }

                        showInput("coDriver");
                        $("#coDriverSearchInput").hide();
                    });
                }
                ev.preventDefault();
                });
            });
        });

        $('#btnCoDriverDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/co-driver-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#coDriver_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alertMessage("Please Select Row");
                    } else {
                        var coDriver = $("#coDriver_grid").jqGrid('getRowData', deleteRowId);

//                        if (confirm("Are You Sure To Delete (Code : " + coDriver.code + ")")) {
                            var url = "master/co-driver-delete";
                            var params = "coDriver.code=" + coDriver.code;
                            var message="Are You Sure To Delete(Code : "+ coDriver.code + ")?";
                            alertMessageDelete("coDriver",url,params,message,400);
//                            $.post(url, params, function () {
                                reloadGridCoDriver();
//                            });
//                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnCoDriverSave").click(function (ev) {
            if($("#coDriver\\.internalExternalStatus").val()==="INTERNAL"){
                if(txtCoDriverEmployeeCode.val()===""){
                    alertMessage("Field Employee Can't be Empty");
                    return;
                }
            }
            if($("#coDriver\\.internalExternalStatus").val()==="EXTERNAL"){
                if(txtCoDriverName.val()===""){
                    alertMessage("Field Name Can't be Empty");
                    return;
                }
                if(txtCoDriverAddress.val()===""){
                    alertMessage("Field Address Can't be Empty");
                    return;
                }
                if(txtCoDriverZipCode.val()===""){
                    alertMessage("Field ZipCode Can't be Empty");
                    return;
                }
                if(txtCoDriverCityCode.val()===""){
                    alertMessage("Field City Can't be Empty");
                    return;
                }
                if(txtCoDriverPhone1.val()===""){
                    alertMessage("Field Phone 1 Can't be Empty");
                    return;
                }
            }

            var url = "";

            if (updateRowId < 0)
                url = "master/co-driver-save";
            else
                url = "master/co-driver-update";

            var params = $("#frmCoDriverInput").serialize();
            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("coDriver");
                $("#coDriverSearchInput").show();
                allFieldsCoDriver.val('').siblings('label[class="error"]').hide();
                reloadGridCoDriver();
            });
            ev.preventDefault();
        });

        $('#btnCoDriver_search').click(function(ev) {
            $("#coDriver_grid").jqGrid("clearGridData");
            $("#coDriver_grid").jqGrid("setGridParam",{url:"master/co-driver-search?" + $("#frmCoDriverSearchInput").serialize()});
            $("#coDriver_grid").trigger("reloadGrid");
            ev.preventDefault();
        });

        $("#btnCoDriverCancel").click(function (ev) {
            hideInput("coDriver");
            $("#coDriverSearchInput").show();
            allFieldsCoDriver.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnCoDriverRefresh').click(function (ev) {
            reloadGridCoDriver();
        });
    });
        
    function intExt(){
        if($("#coDriver\\.internalExternalStatus").val() === "INTERNAL"){
            $(".internal").attr("style","display:block");                
            $(".external").attr("style","display:none");                
        }else{
            $(".internal").attr("style","display:none");                
            $(".external").attr("style","display:block");                
        }
    }
</script>
<b>CO-DRIVER</b>
<hr>
<br class="spacer"/> 


<sj:div id="coDriverButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCoDriverNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnCoDriverUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnCoDriverDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnCoDriverRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnCoDriverPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>    
<div id="coDriverSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCoDriverSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="searchCoDriver.code" name="searchCoDriver.code" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="searchCoDriver.name" name="searchCoDriver.name" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="searchCoDriverActiveStatus" name="searchCoDriverActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchCoDriverActiveStatusRAD" name="searchCoDriverActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCoDriver_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
        <br/>
    </s:form>
</div>   

<div id="coDriverGrid">
    <sjg:grid
        id="coDriver_grid"
        dataType="json"
        href="%{remoteurlCoDriver}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCoDriver"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuCoDriver').width()"
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
            name="emailAddress" index="emailAddress" title="EmailAddress" width="100" sortable="false"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />
        <sjg:gridColumn
            name="internalExternalStatus" index="internalExternalStatus" title="internalExternalStatus" width="100" sortable="false"
            />
    </sjg:grid >
</div>

<div id="coDriverInput" class="content ui-widget">
    <s:form id="frmCoDriverInput">
        <div style="width: 100%">
            <table cellpadding="2" cellspacing="2" style="float: left;">
                <tr>
                    <td valign="top">
                        <table>
                            <tr>
                                <td align="right"><B>Code*</B></td>
                                <td><s:textfield id="coDriver.code" name="coDriver.code" title="Please Enter Code!" required="true" cssClass="required" ></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Name*</B></td>
                                <td><s:textfield id="coDriver.name" name="coDriver.name" size="20" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="right"><B>Active Status</B></td>
                                <td>
                                    <s:radio id="coDriverActiveStatus" name="coDriverActiveStatus" list="{'Active','InActive'}"></s:radio>
                                </td>
                                <td>
                                    <s:textfield style="display:none" id="coDriver.activeStatus" name="coDriver.activeStatus" title="Please Enter Role Name" required="true" size="20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>Remark</B></td>
                                <td>
                                    <s:textfield id="coDriver.remark" name="coDriver.remark" title="Please Enter Remark" size="20"></s:textfield>
                                </td>
                            </tr>
                            <tr>
                                <td align="right"><B>InActive By</B></td>
                                <td>
                                    <s:textfield disabled="true" id="coDriver.inActiveBy" name="coDriver.inActiveBy" title="Please Enter Remark" size="20" readonly="true"></s:textfield>
                                </td>
                            </tr> 
                            <tr>
                                <td align="right"><B>InActive Date</B></td>
                                <td>
                                    <s:textfield disabled="true" id="coDriver.inActiveDate" name="coDriver.inActiveDate" title="Please Enter Remark" size="20" readonly="true"></s:textfield>
                                </td>
                            </tr>
                            <tr> 
                                <td><s:textfield id="coDriver.createdBy"  name="coDriver.createdBy" size="20" style="display:none"></s:textfield></td>
                                <td><s:textfield id="coDriver.createdDate" name="coDriver.createdDate" size="20" style="display:none"></s:textfield></td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2" style="padding-left: 113px;">
                                    <br />
                                    <div class="error ui-state-error ui-corner-all">
                                        <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
                                    </div>
                                    <br />
                                    </div>
                                    <sj:a href="#" id="btnCoDriverSave" button="true">Save</sj:a>
                                    <sj:a href="#" id="btnCoDriverCancel" button="true">Cancel</sj:a>
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
                                                    <s:textfield style="display:none" id="coDriver.internalExternalStatus" name="coDriver.internalExternalStatus" title="Please Enter internalExternalStatus" required="true" value="INTERNAL" size="20"></s:textfield>
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
                                                $('#coDriver_btnEmployee').click(function (ev) {
                                                    window.open("./pages/search/search-employee.jsp?iddoc=coDriver&idsubdoc=employee", "Search", "scrollbars=1,width=600, height=500");
                                                });

                                                txtCoDriverEmployeeCode.change(function (ev) {
                                                    var url = "master/employee-get";
                                                    var params = "employee.code=" + txtCoDriverEmployeeCode.val();

                                                    $.post(url, params, function (result) {
                                                        var data = (result);
                                                        if (data.employee) {
                                                            txtCoDriverEmployeeCode.val(data.employee.code);
                                                            txtCoDriverEmployeeName.val(data.employee.name);
                                                            txtCoDriverEmployeeCityCode.val(data.employee.city.code);
                                                            txtCoDriverEmployeeCityName.val(data.employee.city.name);
                                                            txtCoDriverEmployeeCountryCode.val(data.employee.city.province.island.country.code),
                                                            txtCoDriverEmployeeCountryName.val(data.employee.city.province.island.country.name),
                                                            txtCoDriverEmployeePhone1.val(data.employee.mobileNo1);
                                                            txtCoDriverEmployeePhone2.val(data.employee.mobileNo2);
                                                            txtCoDriverEmployeeFax.val(data.employee.fax);
                                                            txtCoDriverEmployeeEmailAddress.val(data.employee.emailAddress);
                                                            txtCoDriverEmployeeCode.val(data.employee.code);
                                                            txtCoDriverAddress.val(data.employeeTemp.address);
                                                            txtCoDriverZipCode.val(data.employeeTemp.zipCode);
                                                            txtCoDriverCityCode.val(data.employeeTemp.cityCode);
                                                            txtCoDriverCityName.val(data.employeeTemp.cityName);
                                                            txtCoDriverCountryCode.val(data.employeeTemp.countryCode);
                                                            txtCoDriverCountryName.val(data.employeeTemp.countryName);
                                                            txtCoDriverPhone1.val(data.employeeTemp.phone1);
                                                            txtCoDriverPhone2.val(data.employeeTemp.phone2);
                                                            txtCoDriverEmailAddress.val(data.employeeTemp.emailAddress);
                                                            txtCoDriverfax.val(data.employeeTemp.fax);
                                                        } else {
                                                            alert("Employee Not Found");
                                                            txtCoDriverEmployeeCode.val("");
                                                            txtCoDriverEmployeeName.val("");
                                                            txtCoDriverEmployeeCityCode.val("");
                                                            txtCoDriverEmployeeCityName.val("");
                                                            txtCoDriverEmployeeCountryCode.val("");
                                                            txtCoDriverEmployeeCountryName.val("");
                                                            txtCoDriverEmployeePhone1.val("");
                                                            txtCoDriverEmployeePhone2.val("");
                                                            txtCoDriverEmployeeFax.val("");
                                                            txtCoDriverEmployeeEmailAddress.val("");
                                                            txtCoDriverAddress.val("");
                                                            txtCoDriverZipCode.val("");
                                                            txtCoDriverCityCode.val("");
                                                            txtCoDriverCityName.val("");
                                                            txtCoDriverCountryCode.val("");
                                                            txtCoDriverCountryName.val("");
                                                            txtCoDriverPhone1.val("");
                                                            txtCoDriverPhone2.val("");
                                                            txtCoDriverEmailAddress.val("");
                                                            txtCoDriverfax.val("");
                                                        }
                                                    });
                                                });
                                            </script>
                                            <div class="searchbox ui-widget-header">
                                            <s:textfield id="coDriver.employee.code" name="coDriver.employee.code" title="Please Enter Employee Code" ></s:textfield>
                                            <sj:a id="coDriver_btnEmployee">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-employee-coDriver"/></sj:a>
                                            </div>                                    
                                        </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Address</td>
                                            <td><s:textfield id="coDriver.employee.address" name="coDriver.employee.address" size="20" readonly="true"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right">Zip Code</td>
                                            <td><s:textfield id="coDriver.employee.zipCode" name="coDriver.employee.zipCode" size="20" readonly="true"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top">City </td>
                                            <td>
                                                <s:textfield id="coDriver.employee.city.code" name="coDriver.employee.city.code" size="15"  readonly="true"></s:textfield>
                                                <s:textfield id="coDriver.employee.city.name" name="coDriver.employee.city.name" size="15"  readonly="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Country</td>
                                            <td> 
                                                <s:textfield id="coDriver.employee.city.province.island.country.code" name="coDriver.employee.city.province.island.country.code" readonly="true"></s:textfield>
                                                <s:textfield id="coDriver.employee.city.province.island.country.name" name="coDriver.employee.city.province.island.country.name" readonly="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Phone 1</td>
                                            <td>
                                                <s:textfield id="coDriver.employee.phone1" name="coDriver.employee.phone1"  size="15"  readonly="true"></s:textfield>
                                                    Phone 2
                                                <s:textfield id="coDriver.employee.phone2" name="coDriver.employee.phone2"  size="15"  readonly="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Email Address</td>
                                            <td>
                                                <s:textfield id="coDriver.employee.emailAddress" name="coDriver.employee.emailAddress" size="25"  readonly="true"></s:textfield>
                                            </td>
                                        </tr>
                                        </table>
                                   </td>
                                   <td>
                                       <table>
                                        <tr>
                                            <td align="right"><B>Address*</B></td>
                                            <td><s:textfield id="coDriver.address" name="coDriver.address" size="20" title="Please Enter Address!" required="true" cssClass="required"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><B>Zip Code*</B></td>
                                            <td><s:textfield id="coDriver.zipCode" name="coDriver.zipCode" size="20" title="Please Enter Zip Code!" required="true" cssClass="required"></s:textfield></td>
                                        </tr>
                                        <tr>
                                            <td align="right" valign="top"><B>City*</B></td>
                                            <td>
                                                <script type = "text/javascript">
                                                    $('#coDriver_btnCity').click(function (ev) {
                                                        window.open("./pages/search/search-city.jsp?iddoc=coDriver&idsubdoc=city", "Search", "scrollbars=1,width=600, height=500");
                                                    });

                                                    txtCoDriverCityCode.change(function (ev) {
                                                        var url = "master/city-get-data";
                                                        var params = "city.code=" + txtCoDriverCityCode.val();

                                                        $.post(url, params, function (result) {
                                                            var data = (result);
                                                            if (data.cityTemp) {
                                                                txtCoDriverCityName.val(data.cityTemp.name);
                                                                txtCoDriverCountryCode.val(data.cityTemp.countryCode);
                                                                txtCoDriverCountryName.val(data.cityTemp.countryName);
                                                            } else {
                                                                alert("City Not Found");
                                                                txtCoDriverCityName.val("");
                                                                txtCoDriverCountryCode.val("");
                                                                txtCoDriverCountryName.val("");
                                                            }
                                                        });
                                                    });
                                                </script>
                                                <div class="searchbox ui-widget-header">
                                                <s:textfield id="coDriver.city.code" name="coDriver.city.code" title="Please Enter City Code" required="true" cssClass="required"></s:textfield>
                                                <sj:a id="coDriver_btnCity">&nbsp;&nbsp;<span class="ui-icon ui-icon-search" id="ui-icon-search-city-coDriver"/></sj:a>
                                                </div>
                                                 <s:textfield id="coDriver.city.name" name="coDriver.city.name" size="20" readonly="true"></s:textfield> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Country</td>
                                            <td> 
                                            <s:textfield id="coDriver.city.province.island.country.code" name="coDriver.city.province.island.country.code" required="true" readonly="true"></s:textfield>
                                            <s:textfield id="coDriver.city.province.island.country.name" name="coDriver.city.province.island.country.name" required="true" size="20" readonly="true"></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right"><B>Phone 1*</B></td>
                                            <td>
                                                <s:textfield id="coDriver.phone1" name="coDriver.phone1" required="true" title="Please Enter Phone1!" cssClass="required"></s:textfield>
                                                    Phone 2
                                                <s:textfield id="coDriver.phone2" name="coDriver.phone2" required="true" size="20" ></s:textfield>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">Email Address</td>
                                            <td>
                                                <s:textfield id="coDriver.emailAddress" name="coDriver.emailAddress" required="true" size="25" ></s:textfield>
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