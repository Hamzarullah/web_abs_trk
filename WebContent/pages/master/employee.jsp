
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
        txtEmployeeCode=$("#employee\\.code"),
        txtEmployeeNIK=$("#employee\\.nik"),
        txtEmployeeName=$("#employee\\.name"),
        txtEmployeeAddress=$("#employee\\.address"),
        txtEmployeeZipCode=$("#employee\\.zipCode"),
        txtEmployeeCityCode=$("#employee\\.city\\.code"),
        txtEmployeeCityName=$("#employee\\.city\\.name"),
        txtEmployeeCountryCode=$("#employee\\.city\\.province\\.island\\.country\\.code"),
        txtEmployeeCountryName=$("#employee\\.city\\.province\\.island\\.country\\.name"),
        txtEmployeeDomicileAddress1=$("#employee\\.domicileAddress1"),
        txtEmployeeDomicileAddress2=$("#employee\\.domicileAddress2"),
        txtEmployeePhone=$("#employee\\.phone"),
        txtEmployeeMobileNo1=$("#employee\\.mobileNo1"),
        txtEmployeeMobileNo2=$("#employee\\.mobileNo2"),
        txtEmployeeEmailAddress=$("#employee\\.emailAddress"),
        rdbEmployeeGender=$("#employee\\.gender"),
        rdbEmployeeMaritalStatus=$("#employee\\.maritalStatus"),
        txtEmployeeReligionCode=$("#employee\\.religion\\.code"),
        txtEmployeeReligionName=$("#employee\\.religion\\.name"),
        txtEmployeeEducationCode=$("#employee\\.education\\.code"),
        txtEmployeeEducationName=$("#employee\\.education\\.name"),
        txtEmployeeKTPNo=$("#employee\\.ktpNo"),
        txtEmployeeNPWP=$("#employee\\.npwp"),
        txtEmployeeNPWPName=$("#employee\\.npwpName"),
        txtEmployeeNPWPAddress=$("#employee\\.npwpAddress"),
        txtEmployeeNPWPCityCode=$("#employee\\.npwpCity\\.code"),
        txtEmployeeNPWPCityName=$("#employee\\.npwpCity\\.name"),
        txtEmployeeNPWPZipCode=$("#employee\\.npwpZipCode"),
        txtEmployeeACNo = $("#employee\\.acNo"),
        txtEmployeeACName = $("#employee\\.acName"),
        txtEmployeeBankCode = $("#employee\\.bank\\.code"),
        txtEmployeeBankName = $("#employee\\.bank\\.name"),
        txtEmployeeBankBranch=$("#employee\\.bankBranch"),
        rdbEmployeeActiveStatus=$("#employee\\.activeStatus"),
        txtEmployeeRemark=$("#employee\\.remark"),
        txtEmployeeInActiveBy = $("#employee\\.inActiveBy"),
        dtpEmployeeInActiveDate = $("#employee\\.inActiveDate"),
        dtpEmployeeJoinDate = $("#employee\\.joinDate"),
        dtpEmployeeResignDate = $("#employee\\.resignDate"),
        dtpEmployeeBirthDate = $("#employee\\.birthDate"),
        txtEmployeeBirthPlace = $("#employee\\.birthPlace"),
        txtEmployeeCreatedBy = $("#employee\\.createdBy"),
        dtpEmployeeCreatedDate = $("#employee\\.createdDate"),
        
        allFieldsEmployee=$([])
            .add(txtEmployeeCode)
            .add(txtEmployeeNIK)
            .add(txtEmployeeName)
            .add(txtEmployeeAddress)
            .add(txtEmployeeZipCode)
            .add(txtEmployeeCityCode)
            .add(txtEmployeeCityName)
            .add(txtEmployeeCountryCode)
            .add(txtEmployeeCountryName)
            .add(txtEmployeeDomicileAddress1)
            .add(txtEmployeeDomicileAddress2)
            .add(txtEmployeePhone)
            .add(txtEmployeeMobileNo1)
            .add(txtEmployeeMobileNo2)
            .add(txtEmployeeEmailAddress)
            .add(rdbEmployeeGender)
            .add(rdbEmployeeMaritalStatus)
            .add(txtEmployeeReligionCode)
            .add(txtEmployeeReligionName)
            .add(txtEmployeeEducationCode)
            .add(txtEmployeeEducationName)
            .add(txtEmployeeKTPNo)
            .add(txtEmployeeNPWP)
            .add(txtEmployeeNPWPName)
            .add(txtEmployeeNPWPAddress)
            .add(txtEmployeeNPWPCityCode)
            .add(txtEmployeeNPWPCityName)
            .add(txtEmployeeNPWPZipCode)
            .add(txtEmployeeACNo)
            .add(txtEmployeeACName)
            .add(txtEmployeeBankCode)
            .add(txtEmployeeBankName)
            .add(txtEmployeeBankBranch)
            .add(dtpEmployeeJoinDate)
            .add(dtpEmployeeResignDate)
            .add(dtpEmployeeBirthDate)
            .add(txtEmployeeRemark)
            .add(txtEmployeeInActiveBy)
            .add(txtEmployeeCreatedBy);


    function reloadGridEmployee(){
        $("#employee_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("employee");
        
        $('#employee\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#employeeSearchActiveStatusRadActive').prop('checked',true);
        $("#employeeSearchActiveStatus").val("true");
        
        $('input[name="employeeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#employeeSearchActiveStatus").val(value);
        });
        
        $('input[name="employeeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#employeeSearchActiveStatus").val(value);
        });
                
        $('input[name="employeeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#employeeSearchActiveStatus").val(value);
        });
        
        $('input[name="employeeActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#employee\\.activeStatus").val(value);
            $("#employee\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="employeeActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#employee\\.activeStatus").val(value);
        });
        
         $('input[name="employeeGenderRad"][value="MALE"]').change(function(ev){
            var value="MALE";
            $("#employee\\.gender").val(value);
        });
                
        $('input[name="employeeGenderRad"][value="FEMALE"]').change(function(ev){
            var value="FEMALE";
            $("#employee\\.gender").val(value);
        });
        
        $('input[name="employeeMaritalStatusRad"][value="MARRIED"]').change(function(ev){
            var value="MARRIED";
            $("#employee\\.maritalStatus").val(value);
        });
                
        $('input[name="employeeMaritalStatusRad"][value="SINGLE"]').change(function(ev){
            var value="SINGLE";
            $("#employee\\.maritalStatus").val(value);
        });
        
        $('input[name="employeeMaritalStatusRad"][value="DIVORCE"]').change(function(ev){
            var value="DIVORCE";
            $("#employee\\.maritalStatus").val(value);
        });
        
        $("#btnEmployeeNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/employee-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_employee();
                showInput("employee");
                hideInput("employeeSearch");
                $('#employeeGenderRadMALE').prop('checked',true);
                $("#employee\\.gender").val("MALE");
                $('#employeeMaritalStatusRadMARRIED').prop('checked',true);
                $("#employee\\.maritalStatus").val("MARRIED");
                $('#employeeActiveStatusRadActive').prop('checked',true);
                $("#employee\\.activeStatus").val("true");
                $("#employee\\.resignDate").val("01/01/1900 00:00:00");
                $("#employee\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#employee\\.createdDate").val("01/01/1900 00:00:00");
                $("#employee\\.code").val("AUTO");
                txtEmployeeCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtEmployeeCode.attr("readonly",true);
                txtEmployeeCode.val("AUTO");
                reloadGridEmployee();
                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnEmployeeSave").click(function(ev) {
           if(!$("#frmEmployeeInput").valid()) {
//               handlers_input_employee();
               ev.preventDefault();
               return;
           };
           
           var url = "";
           employeeFormatDate();
           if (updateRowId < 0){
               url = "master/employee-save";
           } else{
               url = "master/employee-update";
           }
           
           var params = $("#frmEmployeeInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    employeeFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("employee");
                showInput("employeeSearch");
                allFieldsEmployee.val('').siblings('label[class="error"]').hide();
                txtEmployeeCode.val("AUTO");
                reloadGridEmployee();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnEmployeeUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/employee-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_employee();
                updateRowId=$("#employee_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var employee=$("#employee_grid").jqGrid('getRowData',updateRowId);
                var url="master/employee-get-data";
                var params="employee.code=" + employee.code;

                txtEmployeeCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtEmployeeCode.val(data.employeeTemp.code);
                        txtEmployeeNIK.val(data.employeeTemp.nik);
                        txtEmployeeName.val(data.employeeTemp.name);
                        txtEmployeeAddress.val(data.employeeTemp.address);
                        txtEmployeeZipCode.val(data.employeeTemp.zipCode);
                        txtEmployeeCityCode.val(data.employeeTemp.cityCode);
                        txtEmployeeCityName.val(data.employeeTemp.cityName);
                        txtEmployeeCountryCode.val(data.employeeTemp.countryCode);
                        txtEmployeeCountryName.val(data.employeeTemp.countryName);
                        txtEmployeeDomicileAddress1.val(data.employeeTemp.domicileAddress1);
                        txtEmployeeDomicileAddress2.val(data.employeeTemp.domicileAddress2);
                        txtEmployeePhone.val(data.employeeTemp.phone);
                        txtEmployeeMobileNo1.val(data.employeeTemp.mobileNo1);
                        txtEmployeeMobileNo2.val(data.employeeTemp.mobileNo2);
                        txtEmployeeEmailAddress.val(data.employeeTemp.emailAddress);
                        rdbEmployeeGender.val(data.employeeTemp.gender);
                        rdbEmployeeMaritalStatus.val(data.employeeTemp.maritalStatus);
                        txtEmployeeReligionCode.val(data.employeeTemp.religionCode);
                        txtEmployeeReligionName.val(data.employeeTemp.religionName);
                        txtEmployeeEducationCode.val(data.employeeTemp.educationCode);
                        txtEmployeeEducationName.val(data.employeeTemp.educationName);
                        txtEmployeeKTPNo.val(data.employeeTemp.ktpNo);
                        txtEmployeeNPWP.val(data.employeeTemp.npwp);
                        txtEmployeeNPWPName.val(data.employeeTemp.npwpName);
                        txtEmployeeNPWPAddress.val(data.employeeTemp.npwpAddress);
                        txtEmployeeNPWPCityCode.val(data.employeeTemp.npwpCityCode);
                        txtEmployeeNPWPCityName.val(data.employeeTemp.npwpCityName);
                        txtEmployeeNPWPZipCode.val(data.employeeTemp.npwpZipCode);
                        txtEmployeeACNo.val(data.employeeTemp.acNo);
                        txtEmployeeACName.val(data.employeeTemp.acName);
                        txtEmployeeBankCode.val(data.employeeTemp.bankCode);
                        txtEmployeeBankName.val(data.employeeTemp.bankName);
                        txtEmployeeBankBranch.val(data.employeeTemp.bankBranch);
                        rdbEmployeeActiveStatus.val(data.employeeTemp.activeStatus);
                        txtEmployeeRemark.val(data.employeeTemp.remark);
                        txtEmployeeInActiveBy.val(data.employeeTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.employeeTemp.inActiveDate,true);
                        dtpEmployeeInActiveDate.val(inActiveDate);
                        var joinDate=formatDateRemoveT(data.employeeTemp.joinDate,false);
                        dtpEmployeeJoinDate.val(joinDate);
                        var resignDate=formatDateRemoveT(data.employeeTemp.resignDate,false);
                        dtpEmployeeResignDate.val(resignDate);
                        var birthDate=formatDateRemoveT(data.employeeTemp.birthDate,false);
                        dtpEmployeeBirthDate.val(birthDate);
                        txtEmployeeBirthPlace.val(data.employeeTemp.birthPlace);
                        txtEmployeeCreatedBy.val(data.employeeTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.employeeTemp.createdDate,true);
                        dtpEmployeeCreatedDate.val(createdDate);

                        if(data.employeeTemp.activeStatus===true) {
                           $('#employeeActiveStatusRadActive').prop('checked',true);
                           $("#employee\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#employeeActiveStatusRadInActive').prop('checked',true);              
                           $("#employee\\.activeStatus").val("false");
                        }
                        if(data.employeeTemp.gender==="MALE") {
                           $('#employeeGenderRadMALE').prop('checked',true);
                           $("#employee\\.gender").val("MALE");
                        }
                        else {                        
                           $('#employeeGenderRadFEMALE').prop('checked',true);              
                           $("#employee\\.gender").val("FEMALE");
                        }
                        if(data.employeeTemp.maritalStatus==="MARRIED") {
                           $('#employeeMaritalStatusRadMARRIED').prop('checked',true);
                           $("#employee\\.maritalStatus").val("MARRIED");
                        }
                        else if(data.employeeTemp.maritalStatus==="DIVORCE") {
                           $('#employeeMaritalStatusRadDIVORCE').prop('checked',true);
                           $("#employee\\.maritalStatus").val("DIVORCE");
                        }
                        else {                        
                           $('#employeeMaritalStatusRadSINGLE').prop('checked',true);              
                           $("#employee\\.maritalStatus").val("SINGLE");
                        }


                        showInput("employee");
                        hideInput("employeeSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnEmployeeDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/employee-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#employee_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var employee=$("#employee_grid").jqGrid('getRowData',deleteRowID);
                var url="master/employee-delete";
                var params="employee.code=" + employee.code;
                var message="Are You Sure To Delete(Code : "+ employee.code + ")?";
                alertMessageDelete("employee",url,params,message,400);
     
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnEmployeeCancel").click(function(ev) {
            hideInput("employee");
            showInput("employeeSearch");
            allFieldsEmployee.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnEmployeeRefresh').click(function(ev) {
            $('#employeeSearchActiveStatusRadActive').prop('checked',true);
            $("#employeeSearchActiveStatus").val("true");
            $("#employee_grid").jqGrid("clearGridData");
            $("#employee_grid").jqGrid("setGridParam",{url:"master/employee-data?"});
            $("#employee_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnEmployeePrint").click(function(ev) {
            
            var url = "reports/employee-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'employee','width=500,height=500');
        });
        
        $('#btnEmployee_search').click(function(ev) {
            $("#employee_grid").jqGrid("clearGridData");
            $("#employee_grid").jqGrid("setGridParam",{url:"master/employee-data?" + $("#frmEmployeeSearchInput").serialize()});
            $("#employee_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#employee_btnCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=employee&idsubdoc=city","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#employee_btnReligion').click(function(ev) {
            window.open("./pages/search/search-religion.jsp?iddoc=employee&idsubdoc=religion","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#employee_btnEducation').click(function(ev) {
            window.open("./pages/search/search-education.jsp?iddoc=employee&idsubdoc=education","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#employee_btnNPWPCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=employee&idsubdoc=npwpCity","Search", "Scrollbars=1,width=600, height=500");
        });
        
        $('#employee_btnBankName').click(function(ev) {
            window.open("./pages/search/search-bank.jsp?iddoc=employee&idsubdoc=bank","Search", "Scrollbars=1,width=600, height=500");
        });
        
    });
    
     function formatDate(date) {
        var dateSplit = date.split('/');
        var dateFormat = dateSplit[1] + "/" + dateSplit[0] + "/" + dateSplit[2];
        return dateFormat;
    }
    
     function formatDateRemoveT(date, useTime) {
        var dateValues = date.split('T');
        var dateValuesTemp = dateValues[0].split('-');
        var dateValue = dateValuesTemp[2] + "/" + dateValuesTemp[1] + "/" + dateValuesTemp[0];
        var dateValuesTemps;

        if (useTime) {
            dateValuesTemps = dateValue + ' ' + dateValues[1];
        } else {
            dateValuesTemps = dateValue;
        }

        return dateValuesTemps;
    }
    
    
    function employeeFormatDate(){
        var joinDate=formatDate(dtpEmployeeJoinDate.val(),true);
        dtpEmployeeJoinDate.val(joinDate);
        $("#employeeTemp\\.joinDateTemp").val(joinDate);
        
        var resignDate=formatDate(dtpEmployeeResignDate.val(),true);
        dtpEmployeeResignDate.val(resignDate);
        $("#employeeTemp\\.resignDateTemp").val(resignDate);
        
        var birthDate=formatDate(dtpEmployeeBirthDate.val(),true);
        dtpEmployeeBirthDate.val(birthDate);
        $("#employeeTemp\\.birthDateTemp").val(birthDate);
        
        var inActiveDate=formatDate(dtpEmployeeInActiveDate.val(),true);
        dtpEmployeeInActiveDate.val(inActiveDate);
        $("#employeeTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpEmployeeCreatedDate.val(),true);
        dtpEmployeeCreatedDate.val(createdDate);
        $("#employeeTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlEmployee" action="employee-data" />
<b>EMPLOYEE</b>
<hr>
<br class="spacer"/>


<sj:div id="employeeButton" cssClass="ikb-buttonset ikb-buttonset-SINGLE">
    <table>
        <tr>
            <td><a href="#" id="btnEmployeeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnEmployeeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnEmployeeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnEmployeeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnEmployeePrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="employeeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmEmployeeSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="employeeSearchCode" name="employeeSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="employeeSearchName" name="employeeSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="employeeSearchActiveStatus" name="employeeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="employeeSearchActiveStatusRad" name="employeeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnEmployee_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="employeeGrid">
    <sjg:grid
        id="employee_grid"
        dataType="json"
        href="%{remoteurlEmployee}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listEmployeeTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuemployee').width()"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="nik" index="nik" title="NIK" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="address" index="address" title="Address" width="400" sortable="true"
        />
         <sjg:gridColumn
            name="zipCode" index="zipCode" title="ZipCode" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="cityCode" index="cityCode" title="CityCode" width="400" sortable="true"
        />
         <sjg:gridColumn
            name="cityName" index="cityName" title="CityName" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="domicileAddress1" index="domicileAddress1" title="DomicileAddress1" width="400" sortable="true"
        />
         <sjg:gridColumn
            name="domicileAddress2" index="domicileAddress2" title="DomicileAddress2" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="phone" index="phone" title="Phone" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="mobileNo1" index="mobileNo1" title="MobileNo1" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="mobileNo2" index="mobileNo2" title="MobileNo2" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="emailAddress" index="emailAddress" title="Email Address" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="phone" index="phone" title="Phone" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="gender" index="gender" title="Gender" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="maritalStatus" index="maritalStatus" title="MaritalStatus" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="religionCode" index="religionCode" title="ReligionCode" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="religionName" index="religionName" title="ReligionName" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="educationCode" index="educationCode" title="EducationCode" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="educationName" index="educationName" title="EducationName" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="ktpNo" index="ktpNo" title="KTPNo" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="npwp" index="npwp" title="NPWP" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="npwpName" index="npwpName" title="NPWPName" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="npwpAddress" index="npwpAddress" title="NPWPAddress" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="npwpCityCode" index="npwpCityCode" title="NPWPCityCode" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="npwpCityName" index="npwpCityName" title="NPWPCityName" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="npwpZipCode" index="npwpZipCode" title="NPWPZipCode" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="acNo" index="acNo" title="ACNo" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="acName" index="acName" title="ACName" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="bankCode" index="bankCode" title="BankCode" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="bankName" index="bankName" title="BankName" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="bankBranch" index="bankBranch" title="BankBranch" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="joinDate" index="joinDate" key="joinDate" formatter="date"  formatoptions="{newformat : 'd/m/Y ', srcformat : 'Y/m/d H:i:s'}"  title="Join Date" width="150" search="false" align="center"
        />
        <sjg:gridColumn
            name="resignDate" index="resignDate" key="resignDate" formatter="date"  formatoptions="{newformat : 'd/m/Y ', srcformat : 'Y/m/d H:i:s'}"  title="Resign Date" width="150" search="false" align="center"
        />
        <sjg:gridColumn
            name="birthDate" index="birthDate" key="birthDate" formatter="date"  formatoptions="{newformat : 'd/m/Y ', srcformat : 'Y/m/d H:i:s'}"  title="Birth Date" width="150" search="false" align="center"
        />
        <sjg:gridColumn
            name="birthPlace" index="birthPlace" title="BirthPlace" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="employeeInput" class="content ui-widget">
    <s:form id="frmEmployeeInput">
        <table cellpadding="2" cellspacing="2" style="float: left">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="employee.code" name="employee.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>NIK *</b></td>
                <td><s:textfield id="employee.nik" name="employee.nik" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="employee.name" name="employee.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Address *</b></td>
                <td><s:textarea id="employee.address" name="employee.address" cols="47" rows="2" height="20" title="*" required="true" cssClass="required"></s:textarea></td>
            </tr>
            <tr>
                <td align="right"><b>Zip Code *</b></td>
                <td><s:textfield id="employee.zipCode" name="employee.zipCode" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>City *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearEmployeeCityFields(){
                            txtEmployeeCityCode.val("");
                            txtEmployeeCityName.val("");
                            txtEmployeeCountryCode.val("");
                            txtEmployeeCountryName.val("");
                            
                        }
                        
                        txtEmployeeCityCode.change(function(ev) {
                            
                            if(txtEmployeeCityCode.val()===""){
                                clearEmployeeCityFields();
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtEmployeeCityCode.val();
                                params+= "&city.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){

                                    txtEmployeeCityCode.val(data.cityTemp.code);
                                    txtEmployeeCityName.val(data.cityTemp.name);
                                    txtEmployeeCountryCode.val(data.cityTemp.provinceCountryCode);
                                    txtEmployeeCountryName.val(data.cityTemp.provinceCountryName);
                                     
                                }
                                else{
                                    alertMessage("City Not Found!",txtEmployeeCityCode);
                                    clearEmployeeCityFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="employee.city.code" name="employee.city.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="employee_btnCity" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="employee.city.name" name="employee.city.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Country</td>
                    <td>
                        <s:textfield id="employee.city.province.island.country.code" name="employee.city.province.island.country.code" size="25" maxLength="45" readonly="true"></s:textfield>
                        <s:textfield id="employee.city.province.island.country.name" name="employee.city.province.island.country.name" size="25" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><b>Domicile Address 1 *</b></td>
                <td><s:textarea id="employee.domicileAddress1" name="employee.domicileAddress1" cols="47" rows="2" height="20" title="*" required="true" cssClass="required" ></s:textarea></td>
            </tr>
            <tr>
                <td align="right"><b>Domicile Address 2 *</b></td>
                <td><s:textarea id="employee.domicileAddress2" name="employee.domicileAddress2" cols="47" rows="2" height="20" title="*" required="true" cssClass="required" ></s:textarea></td>
            </tr>
            <tr>
                <td align="right"><b>Phone *</b></td>
                <td><s:textfield id="employee.phone" name="employee.phone" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Mobile No 1 *</b></td>
                    <td>
                    <s:textfield id="employee.mobileNo1" name="employee.mobileNo1"  size="20" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                         Mobile No 2
                    <s:textfield id="employee.mobileNo2" name="employee.mobileNo2"  size="20" maxLength="45"></s:textfield>
                    </td>
            </tr>
            <tr>
                <td align="right"><b>Email *</b></td>
                <td><s:textfield id="employee.emailAddress" name="employee.emailAddress" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Gender *</B></td>
                <td colspan="2">
                    <s:radio id="employeeGenderRad" name="employeeGenderRad" list="{'MALE','FEMALE'}"></s:radio>
                    <s:textfield id="employee.gender" name="employee.gender" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right"><B>Marital Status *</B></td>
                <td colspan="2">
                    <s:radio id="employeeMaritalStatusRad" name="employeeMaritalStatusRad" list="{'MARRIED','SINGLE','DIVORCE'}"></s:radio>
                    <s:textfield id="employee.maritalStatus" name="employee.maritalStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right"><B>Religion *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearEmployeeReligionFields(){
                            txtEmployeeReligionCode.val("");
                            txtEmployeeReligionName.val("");
                            
                        }
                        
                        txtEmployeeReligionCode.change(function(ev) {
                            
                            if(txtEmployeeReligionCode.val()===""){
                                clearEmployeeReligionFields();
                                return;
                            }
                            var url = "master/religion-get-data";
                            var params = "religion.code=" + txtEmployeeReligionCode.val();
                                params+= "&religion.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.religionTemp){
                                    txtEmployeeReligionCode.val(data.religionTemp.code);
                                    txtEmployeeReligionName.val(data.religionTemp.name);
                                     
                                }
                                else{
                                    alertMessage("Religion Not Found!",txtEmployeeReligionCode);
                                    clearEmployeeReligionFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="employee.religion.code" name="employee.religion.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="employee_btnReligion" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="employee.religion.name" name="employee.religion.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Education *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearEmployeeEducationFields(){
                            txtEmployeeEducationCode.val("");
                            txtEmployeeEducationName.val("");
                            
                        }
                        
                        txtEmployeeEducationCode.change(function(ev) {
                            
                            if(txtEmployeeEducationCode.val()===""){
                                clearEmployeeEducationFields();
                                return;
                            }
                            var url = "master/education-get";
                            var params = "education.code=" + txtEmployeeEducationCode.val();
                                params+= "&education.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.educationTemp){
                                    txtEmployeeEducationCode.val(data.educationTemp.code);
                                    txtEmployeeEducationName.val(data.educationTemp.name);
                                     
                                }
                                else{
                                    alertMessage("Education Not Found!",txtEmployeeEducationCode);
                                    clearEmployeeEducationFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="employee.education.code" name="employee.education.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="employee_btnEducation" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="employee.education.name" name="employee.education.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnEmployeeSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnEmployeeCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
            </table>
            <table>
            <tr>
                <td align="right"><b>KTP No *</b></td>
                <td><s:textfield id="employee.ktpNo" name="employee.ktpNo" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>NPWP *</b></td>
                <td><s:textfield id="employee.npwp" name="employee.npwp" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>NPWP Name *</b></td>
                <td><s:textfield id="employee.npwpName" name="employee.npwpName" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>NPWP Address *</b></td>
                <td><s:textfield id="employee.npwpAddress" name="employee.npwpAddress" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>NPWP City *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearEmployeeNPWPCityFields(){
                            txtEmployeeNPWPCityCode.val("");
                            txtEmployeeNPWPCityName.val("");
                            
                        }
                        
                        txtEmployeeNPWPCityCode.change(function(ev) {
                            
                            if(txtEmployeeNPWPCityCode.val()===""){
                                clearEmployeeNPWPCityFields();
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtEmployeeNPWPCityCode.val();
                                params+= "&city.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){
                                    txtEmployeeNPWPCityCode.val(data.cityTemp.code);
                                    txtEmployeeNPWPCityName.val(data.cityTemp.name);
                                     
                                }
                                else{
                                    alertMessage("City Not Found!",txtEmployeeNPWPCityCode);
                                    clearEmployeeNPWPCityFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="employee.npwpCity.code" name="employee.npwpCity.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="employee_btnNPWPCity" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="employee.npwpCity.name" name="employee.npwpCity.name" size="25" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><b>NPWP Zip Code *</b></td>
                <td><s:textfield id="employee.npwpZipCode" name="employee.npwpZipCode" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>AC No *</b></td>
                <td><s:textfield id="employee.acNo" name="employee.acNo" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>AC Name *</b></td>
                <td><s:textfield id="employee.acName" name="employee.acName" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Bank Name *</B></td>
                <td>
                    <script type = "text/javascript">

                        txtEmployeeBankCode.change(function(ev) {
                            if(txtEmployeeBankCode.val()===""){
                                txtEmployeeBankCode.val("");
                                txtEmployeeBanktName.val("");
                                return;
                            }

                            var url = "master/bank-get";
                            var params = "bank.code=" + txtEmployeeBankCode.val();
                                params += "&bank.activeStatus="+true;
                                
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.bankTemp){
                                    txtEmployeeBankCode.val(data.bankTemp.code);
                                    txtEmployeeBankName.val(data.bankTemp.name);
                                }
                                else{
                                    txtEmployeeBankCode.val("");
                                    txtEmployeeBankName.val("");
                                    alert("Bank Not Found");
                                }
                            });
                        });

                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="employee.bank.code" name="employee.bank.code" title="*" size="20" required="true" cssClass="required" maxLength="45"></s:textfield>
                        <sj:a id="employee_btnBankName" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="employee.bank.name" name="employee.bank.name" size="25" readonly="true" ></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><b>Bank Branch *</b></td>
                <td><s:textfield id="employee.bankBranch" name="employee.bankBranch" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Join Date *</B></td>
                <td>
                        <sj:datepicker id="employee.joinDate" name="employee.joinDate"  title = "*" required="true" cssClass="required" displayFormat="dd/mm/yy" showOn="focus" size="20" value="%{new java.util.Date()}"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Resign Date</td>
                <td>
                    <sj:datepicker id="employee.resignDate" name="employee.resignDate" title=" " displayFormat="dd/mm/yy" size="20" showOn="focus" readonly="true"></sj:datepicker>
                </td>
            </tr>
                            
            <tr>
                <td align="right"><B>Birth Date *</B></td>
                <td>
                    <sj:datepicker id="employee.birthDate" name="employee.birthDate" title="*" displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus"  changeYear="true" changeMonth="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><b>Birth Place *</b></td>
                <td><s:textfield id="employee.birthPlace" name="employee.birthPlace" size="20" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="employeeActiveStatusRad" name="employeeActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="employee.activeStatus" name="employee.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="employee.remark" name="employee.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="employee.inActiveBy"  name="employee.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="employee.inActiveDate" name="employee.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="employee.createdBy"  name="employee.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="employee.createdDate" name="employee.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="employeeTemp.inActiveDateTemp" name="employeeTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="employeeTemp.createdDateTemp" name="employeeTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
        </table>
    </s:form>
</div>