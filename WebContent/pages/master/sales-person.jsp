

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<s:url id="remoteurlSalesPerson" action="sales-person-json" />
<s:url id="remotedetailurlsalesPersonDistributionChannelInput" action="" />
<s:url id="remotedetailurlsalesPersonItemProductHeadInput" action="" />
<s:url id="remotedetailurlsalesPersonDistributionChannelView" action="" />

<script type="text/javascript">

    var 
        txtSalesPersonCode = $("#salesPerson\\.code"),
        txtSalesPersonName = $("#salesPerson\\.name"),
        txtSalesPersonEmployeeCode = $("#salesPerson\\.employee\\.code"),
        txtSalesPersonEmployeeName = $("#salesPerson\\.employee\\.name"),
        txtSalesPersonEmployeeAddress = $("#salesPerson\\.employee\\.address"),
        txtSalesPersonEmployeeCityCode = $("#salesPerson\\.employee\\.city\\.code"),
        txtSalesPersonEmployeeCityName = $("#salesPerson\\.employee\\.city\\.name"),
        txtSalesPersonEmployeeCountryCode = $("#salesPerson\\.employee\\.city\\.province\\.island\\.country\\.code"),
        txtSalesPersonEmployeeCountryName = $("#salesPerson\\.employee\\.city\\.province\\.island\\.country\\.name"),
        txtSalesPersonEmployeeZipCode = $("#salesPerson\\.employee\\.zipCode"),
        txtSalesPersonEmployeeMobileNo1 = $("#salesPerson\\.employee\\.mobileNo1"),
        txtSalesPersonEmployeeMobileNo2 = $("#salesPerson\\.employee\\.mobileNo2"),
        txtSalesPersonEmployeeEmail = $("#salesPerson\\.employee\\.email"),
        rdbSalesPersonActiveStatus = $("#salesPerson\\.activeStatus"),
        txtSalesPersonRemark=$("#salesPerson\\.remark"),
        txtSalesPersonInActiveBy = $("#salesPerson\\.inActiveBy"),
        dtpSalesPersonInActiveDate = $("#salesPerson\\.inActiveDate"),
        txtSalesPersonCreatedBy = $("#salesPerson\\.createdBy"),
        dtpSalesPersonCreatedDate = $("#salesPerson\\.createdDate"),
        
        allFieldsSalesPerson=$([])
            .add(txtSalesPersonCode)
            .add(txtSalesPersonName)
            .add(txtSalesPersonEmployeeCode)
            .add(txtSalesPersonEmployeeName)
            .add(txtSalesPersonEmployeeAddress)
            .add(txtSalesPersonEmployeeCityCode)
            .add(txtSalesPersonEmployeeCityName)
            .add(txtSalesPersonEmployeeCountryCode)
            .add(txtSalesPersonEmployeeCountryName)
            .add(txtSalesPersonEmployeeZipCode)
            .add(txtSalesPersonEmployeeMobileNo1)
            .add(txtSalesPersonEmployeeMobileNo2)
            .add(txtSalesPersonEmployeeEmail)
            .add(txtSalesPersonRemark)
            .add(txtSalesPersonInActiveBy)
            .add(txtSalesPersonCreatedBy);  
    
    function reloadGridSalesPerson() {
        $("#salesPerson_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("salesPerson");
        $('#salesPerson\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#salesPersonSearchActiveStatusRadActive').prop('checked',true);
        $("#salesPersonSearchActiveStatus").val("true");
        
        $('input[name="salesPersonSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#salesPersonSearchActiveStatus").val(value);
        });
        
        $('input[name="salesPersonSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#salesPersonSearchActiveStatus").val(value);
        });
                
        $('input[name="salesPersonSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#salesPersonSearchActiveStatus").val(value);
        });
        
        $('input[name="salesPerson\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#salesPerson\\.activeStatus").val(value);
            
        });
                
        $('input[name="salesPerson\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#salesPerson\\.activeStatus").val(value);
        });
   
       
        
        
        $("#btnSalesPersonNew").click(function(ev){
        
            var url="master/sales-person-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                showInput("salesPerson");
                hideInput("salesPersonSearch");
                $('#salesPerson\\.activeStatusActive').prop('checked',true);
                $("#salesPerson\\.activeStatus").val("true");
                $("#salesPerson\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#salesPerson\\.createdDate").val("01/01/1900 00:00:00");
                txtSalesPersonCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtSalesPersonCode.attr("readonly",true);
                txtSalesPersonCode.val("AUTO");
            });
//            });
//            ev.preventDefault();
        });
        
        $("#btnSalesPersonSave").click(function(ev) {
            
           if(!$("#frmSalesPersonInput").valid()) {
               ev.preventDefault();
               return;
           };

            // Check Distribution Channel Detail
           
            
           
           salesPersonFormatDate();
           
           var url = "";
           if (updateRowId < 0){
               url = "master/sales-person-save";
           }else{
               url = "master/sales-person-update";
           }
               
           var params = $("#frmSalesPersonInput").serialize();
      
           $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                hideInput("salesPerson");
                showInput("salesPersonSearch");
                allFieldsSalesPerson.val('').siblings('label[class="error"]').hide();
                txtSalesPersonCode.val("AUTO");
                reloadGridSalesPerson();
           });
           
           ev.preventDefault();
        });
        
        $("#btnSalesPersonUpdate").click(function(ev){
        
            var url="master/sales-person-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
             
                updateRowId = $("#salesPerson_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                
                txtSalesPersonCode.attr("readonly",true);
                
                var salesPerson = $("#salesPerson_grid").jqGrid('getRowData', updateRowId);
                
                var url = "master/sales-person-get-data";
                var params = "salesPerson.code=" + salesPerson.code;

                $.post(url, params, function(result) {
                    
                    var data = (result);
                        txtSalesPersonCode.val(data.salesPersonTemp.code);
                        txtSalesPersonName.val(data.salesPersonTemp.name);
                        txtSalesPersonEmployeeCode.val(data.salesPersonTemp.employeeCode);
                        txtSalesPersonEmployeeName.val(data.salesPersonTemp.employeeName);
                        txtSalesPersonEmployeeAddress.val(data.salesPersonTemp.employeeAddress);
                        txtSalesPersonEmployeeCityCode.val(data.salesPersonTemp.employeeCityCode);
                        txtSalesPersonEmployeeCityName.val(data.salesPersonTemp.employeeCityName);
                        txtSalesPersonEmployeeCountryCode.val(data.salesPersonTemp.employeeCountryCode);
                        txtSalesPersonEmployeeCountryName.val(data.salesPersonTemp.employeeCountryName);
                        txtSalesPersonEmployeeZipCode.val(data.salesPersonTemp.employeeZipCode);
                        txtSalesPersonEmployeeMobileNo1.val(data.salesPersonTemp.employeePhone1);
                        txtSalesPersonEmployeeMobileNo2.val(data.salesPersonTemp.employeePhone2);
                        txtSalesPersonEmployeeEmail.val(data.salesPersonTemp.employeeEmail);
                        rdbSalesPersonActiveStatus.val(data.salesPersonTemp.activeStatus);
                        txtSalesPersonRemark.val(data.salesPersonTemp.remark);
                        txtSalesPersonInActiveBy.val(data.salesPersonTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.salesPersonTemp.inActiveDate,true);
                        dtpSalesPersonInActiveDate.val(inActiveDate);
                        txtSalesPersonCreatedBy.val(data.salesPersonTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.salesPersonTemp.createdDate,true);
                        dtpSalesPersonCreatedDate.val(createdDate);

                        if(data.salesPersonTemp.activeStatus===true) {
                           $('#salesPerson\\.activeStatusActive').prop('checked',true);
                           $("#salesPerson\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#salesPerson\\.activeStatusInActive').prop('checked',true);              
                           $("#salesPerson\\.activeStatus").val("false");
                        }

                    showInput("salesPerson");
                    hideInput("salesPersonSearch");
                });
            });
//            });
            ev.preventDefault();
        });
        
        $('#btnSalesPersonDelete').click(function(ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
        
                var url="master/sales-person-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }

                    var deleteRowId = $("#salesPerson_grid").jqGrid('getGridParam','selrow');

                    if (deleteRowId === null) {
                        alertMessage("Please Select Row!");
                        return;
                    }

                    var salesPerson=$("#salesPerson_grid").jqGrid('getRowData',deleteRowId);
                    var url="master/sales-person-delete";
                    var params="salesPerson.code=" + salesPerson.code;
                    var message="Are You Sure To Delete(Code : "+ salesPerson.code + ")?";
                    alertMessageDelete("salesPerson",url,params,message,400);
                });
            });
//            ev.preventDefault();
        });
        
       $("#btnSalesPersonCancel").click(function(ev) {
            hideInput("salesPerson");
            showInput("salesPersonSearch");
            allFieldsSalesPerson.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        $('#btnSalesPersonRefresh').click(function(ev) {
            $('#salesPersonSearchActiveStatusRadActive').prop('checked',true);
            $("#salesPersonSearchActiveStatus").val("true");
            $("#salesPerson_grid").jqGrid("clearGridData");
            $("#salesPerson_grid").jqGrid("setGridParam",{url:"master/sales-person-data?"});
            $("#salesPerson_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnSalesPerson_search').click(function(ev) {
            $("#salesPerson_grid").jqGrid("clearGridData");
            $("#salesPerson_grid").jqGrid("setGridParam",{url:"master/sales-person-data?" + $("#frmSalesPersonSearchInput").serialize()});
            $("#salesPerson_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
         
        $('#salesPerson_btnEmployee').click(function(ev) {
            window.open("./pages/search/search-employee.jsp?iddoc=salesPerson&idsubdoc=employee","Search", "scrollbars=1, width=600, height=500");
        });

}); // End Of Ready

   

   
            
    function reloadGridSalesPerson(){
        $("#salesPerson_grid").trigger("reloadGrid");
        $("#salesPersonDistributionChannelList_grid").trigger("reloadGrid");
        $("#salesPersonItemProductHeadList_grid").trigger("reloadGrid");
    };
    
    function salesPersonFormatDate(){
               
        var inActiveDate=formatDate(dtpSalesPersonInActiveDate.val(),true);
        dtpSalesPersonInActiveDate.val(inActiveDate);
        $("#salesPersonTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpSalesPersonCreatedDate.val(),true);
        dtpSalesPersonCreatedDate.val(createdDate);
        $("#salesPersonTemp\\.createdDateTemp").val(createdDate); 
    }
  
</script>

<s:url id="remoteurlSalesPerson" action="sales-person-data" />
<b>SALES PERSON</b>
<hr>
<br class="spacer" />

    <sj:div id="salesPersonButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnSalesPersonNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnSalesPersonUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnSalesPersonDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnSalesPersonRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnSalesPersonPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>

        </table>
    </sj:div>  

    <div id="salesPersonSearchInput" class="content ui-widget">
        <br class="spacer" />
        <br class="spacer" />
        <s:form id="frmSalesPersonSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right" valign="centre"><b>Code</b></td>
                    <td>
                        <s:textfield id="salesPersonSearchCode" name="salesPersonSearchCode" size="20"></s:textfield>
                    </td>
                    <td align="right" valign="centre"><b>Name</b></td>
                    <td>
                        <s:textfield id="salesPersonSearchName" name="salesPersonSearchName" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right">Status
                        <s:textfield id="salesPersonSearchActiveStatus" name="salesPersonSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>
                    <td>
                        <s:radio id="salesPersonSearchActiveStatusRad" name="salesPersonSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                    </td>
                </tr>  
            </table>
            <br />
            <sj:a href="#" id="btnSalesPerson_search" button="true">Search</sj:a>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
        </s:form>
    </div>
    <br class="spacer" />  
    
    <div id="salesPersonGrid">
        <sjg:grid
            id="salesPerson_grid"
            dataType="json"
            href="%{remoteurlSalesPerson}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesPersonTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="salesPersonList_grid_onSelect"
            width="$('#tabmnusalesPerson').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="80" sortable="true"
            />
            
            <sjg:gridColumn
                name="name" index="name" title="Name" width="300" sortable="true"
            />
            
            <sjg:gridColumn
                name="employeeCode" index="employeeCode" title="Employee" width="300" sortable="true"
            />
            
            <sjg:gridColumn
                name="employeeName" index="employeeName" title="Employee" width="300" sortable="true"
            />
            
            <sjg:gridColumn
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />
        </sjg:grid >
        
              
    </div>
    
    <div id="salesPersonInput" class="content ui-widget">
        <s:form id="frmSalesPersonInput">
            <table cellpadding="2" cellspacing="2" width="100%">
                <tr>
                    <td valign="top">
                        <table width="100%">
                            <tr>
                                <td align="right"><B>Code *</B></td>
                                <td><s:textfield id="salesPerson.code" name="salesPerson.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
                            </tr>
                            
                            <tr>
                                <td align="right"><B>Name *</B></td>
                                <td><s:textfield id="salesPerson.name" name="salesPerson.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                            </tr>
                           
                            <tr>
                                <td align="right"><B>Active Status *</B>
                                <s:textfield id="salesPerson.activeStatus" name="salesPerson.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                                <td><s:radio id="salesPerson.activeStatus" name="salesPerson.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                            </tr>
                            
                            <tr>
                                <td align="right" valign="top">Remark</td>
                                <td colspan="3">
                                    <s:textarea id="salesPerson.remark" name="salesPerson.remark"  cols="47" rows="3" height="20"></s:textarea>
                                </td>
                            </tr> 
                            
                            <tr>
                                <td align="right">InActive By</td>
                                <td><s:textfield id="salesPerson.inActiveBy"  name="salesPerson.inActiveBy" size="20" readonly="true"></s:textfield></td>
                            </tr>
                            
                            <tr>
                                <td align="right">InActive Date</td>
                                <td>
                                    <sj:datepicker id="salesPerson.inActiveDate" name="salesPerson.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                                </td>
                            </tr>
                            
                            <tr hidden="true">
                                <td/>
                                <td colspan="2">
                                    <s:textfield id="salesPerson.createdBy"  name="salesPerson.createdBy" size="20"></s:textfield>
                                    <s:textfield id="salesPerson.createdDate" name="salesPerson.createdDate" size="20"></s:textfield>
                                </td>
                            </tr>
                            
                            <tr hidden="true">
                                <td/>
                                <td colspan="2">
                                    <s:textfield id="salesPersonTemp.inActiveDateTemp" name="salesPersonTemp.inActiveDateTemp" size="22"></s:textfield>
                                    <s:textfield id="salesPersonTemp.createdDateTemp" name="salesPersonTemp.createdDateTemp" size="22"></s:textfield>
                                </td>
                            </tr>
                                                        
                        </table>
                    </td>
                    <td valign="top">
                        <table width="100%">
                            <tr>
                                <td align="right"><B>Employee *</B></td>
                                <td>
                                    <script type = "text/javascript">
                                        
                                        function clearSalesPersonEmployeeFields(){
                                            txtSalesPersonEmployeeCode.val("");
                                            txtSalesPersonEmployeeName.val("");
                                            txtSalesPersonEmployeeAddress.val("");
                                            txtSalesPersonEmployeeZipCode.val("");
                                            txtSalesPersonEmployeeCityCode.val("");
                                            txtSalesPersonEmployeeCityName.val("");
                                            txtSalesPersonEmployeeCountryCode.val("");
                                            txtSalesPersonEmployeeCountryName.val("");
                                            txtSalesPersonEmployeeMobileNo1.val("");
                                            txtSalesPersonEmployeeMobileNo2.val("");
                                            txtSalesPersonEmployeeEmail.val("");
                                        }
                                        
                                        txtSalesPersonEmployeeCode.change(function(ev) {

                                            if(txtSalesPersonEmployeeCode.val()===""){
                                               clearSalesPersonEmployeeFields();
                                                return;
                                            }

                                            var url = "master/employee-get";
                                            var params = "employee.code=" + txtSalesPersonEmployeeCode.val();
                                                params += "&employee.activeStatus=TRUE";

                                            $.post(url, params, function(result) {
                                                var data = (result);
                                                if (data.employeeTemp){
                                                    txtSalesPersonEmployeeCode.val(data.employeeTemp.code);
                                                    txtSalesPersonEmployeeName.val(data.employeeTemp.name);
                                                    txtSalesPersonEmployeeAddress.val(data.employeeTemp.address);
                                                    txtSalesPersonEmployeeZipCode.val(data.employeeTemp.zipCode);
                                                    txtSalesPersonEmployeeCityCode.val(data.employeeTemp.cityCode);
                                                    txtSalesPersonEmployeeCityName.val(data.employeeTemp.cityName);
                                                    txtSalesPersonEmployeeCountryCode.val(data.employeeTemp.countryCode);
                                                    txtSalesPersonEmployeeCountryName.val(data.employeeTemp.countryName);
                                                    txtSalesPersonEmployeeMobileNo1.val(data.employeeTemp.mobileNo1);
                                                    txtSalesPersonEmployeeMobileNo2.val(data.employeeTemp.mobileNo2);
                                                    txtSalesPersonEmployeeEmail.val(data.employeeTemp.email);
                                                }
                                                else{
                                                    alertMessage("Employee Not Found!",txtSalesPersonEmployeeCode);
                                                    clearSalesPersonEmployeeFields();
                                                }
                                            });
                                        });
                                    </script>
                                        <div class="searchbox ui-widget-header">
                                            <s:textfield id="salesPerson.employee.code" name="salesPerson.employee.code" title="*" required="true" cssClass="required" size="15"></s:textfield>
                                            <sj:a id="salesPerson_btnEmployee" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                        </div>
                                        &nbsp;<s:textfield id="salesPerson.employee.name" name="salesPerson.employee.name" size="28" readonly="true"></s:textfield> 
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right" valign="top">Address</td>
                                <td><s:textarea id="salesPerson.employee.address" name="salesPerson.employee.address" rows="3" cols="47" readonly="true"></s:textarea> </td>
                            </tr>
                            
                            <tr>
                                <td align="right">Zip Code</td>
                                <td><s:textfield id="salesPerson.employee.zipCode" name="salesPerson.employee.zipCode" size="20" readonly="true" maxLength="95"></s:textfield></td>
                            </tr>
                            
                            <tr>
                                <td align="right">City</td>
                                <td colspan="2">
                                    <s:textfield id="salesPerson.employee.city.code" name="salesPerson.employee.city.code" readonly="true" size="15"></s:textfield>
                                    <s:textfield id="salesPerson.employee.city.name" name="salesPerson.employee.city.name" readonly="true" size="25"></s:textfield> 
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right">Country</td>
                                <td colspan="2">
                                    <s:textfield id="salesPerson.employee.city.province.island.country.code" name="salesPerson.employee.city.province.island.country.code" readonly="true" size="15"></s:textfield>
                                    <s:textfield id="salesPerson.employee.city.province.island.country.name" name="salesPerson.employee.city.province.island.country.name" readonly="true" size="25"></s:textfield> 
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right">Mobile No 1</td>
                                <td><s:textfield id="salesPerson.employee.mobileNo1" name="salesPerson.employee.mobileNo1" size="15" readonly="true" maxLength="45"></s:textfield>
                                    &nbsp; Mobile No 2
                                    <s:textfield id="salesPerson.employee.mobileNo2" name="salesPerson.employee.mobileNo2" readonly="true" size="15" maxLength="45"></s:textfield>
                                </td>
                            </tr>
                            
                            <tr>
                                <td align="right">Email</td>
                                <td>
                                    <s:textfield id="salesPerson.employee.email" name="salesPerson.employee.email" size="25" readonly="true" maxLength="45"></s:textfield>
                                </td>
                            </tr>
                            
                        </table>
                    </td>
                </tr>
            </table>
                                                
            <br class="spacer" />  
            <sj:a href="#" id="btnSalesPersonSave" button="true">Save</sj:a>
            <sj:a href="#" id="btnSalesPersonCancel" button="true">Cancel</sj:a>
                
        </s:form>
    </div>