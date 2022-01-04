
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">
     
    var 
        txtVendorContactCode=$("#vendorContact\\.code"),
        txtVendorContactName=$("#vendorContact\\.name"),
        txtVendorContactPhone=$("#vendorContact\\.phone"),
        txtVendorContactMobileNo=$("#vendorContact\\.mobileNo"),
        dtpVendorContactBirthDate=$("#vendorContact\\.birthDate"),
        txtVendorContactVendorCode = $("#vendorContact\\.vendor\\.code"),
        txtVendorContactVendorName = $("#vendorContact\\.vendor\\.name"),
        txtVendorContactVendorAddress = $("#vendorContact\\.vendor\\.address"),
        txtVendorContactVendorPhone1 = $("#vendorContact\\.vendor\\.phone1"),
        txtVendorContactVendorPhone2 = $("#vendorContact\\.vendor\\.phone2"),
        txtVendorContactVendorFax = $("#vendorContact\\.vendor\\.fax"),
        txtVendorContactVendorEmail = $("#vendorContact\\.vendor\\.email"),
        txtVendorContactVendorCityCode = $("#vendorContact\\.vendor\\.city\\.code"),
        txtVendorContactVendorCityName = $("#vendorContact\\.vendor\\.city\\.name"),
        txtVendorContactVendorCountryCode = $("#vendorContact\\.vendor\\.city\\.province\\.island\\.country\\.code"),
        txtVendorContactVendorCountryName = $("#vendorContact\\.vendor\\.city\\.province\\.island\\.country\\.name"),
        txtVendorContactJobPositionCode = $("#vendorContact\\.jobPosition\\.code"),
        txtVendorContactJobPositionName = $("#vendorContact\\.jobPosition\\.name"),
        txtVendorContactAddress = $("#vendorContact\\.vendor\\.address"),
        txtVendorContactCityCode = $("#vendorContact\\.vendor\\.city\\.code"),
        txtVendorContactCityName = $("#vendorContact\\.vendor\\.city\\.name"),
        txtVendorContactPhone1 = $("#vendorContact\\.vendor\\.phone1"),
        txtVendorContactPhone2 = $("#vendorContact\\.vendor\\.phone2"),
        txtVendorContactFax = $("#vendorContact\\.vendor\\.fax"),
        txtVendorContactEmail = $("#vendorContact\\.vendor\\.email"),
        rdbVendorContactActiveStatus=$("vendorContact\\.activeStatus"),
        txtVendorContactCreatedBy = $("#vendorContact\\.createdBy"),
        txtVendorContactCreatedDate = $("#vendorContact\\.createdDate"),
       
        
        allFieldsVendorContact=$([])
            .add(txtVendorContactCode)
            .add(txtVendorContactName)
            .add(txtVendorContactPhone)
            .add(txtVendorContactMobileNo)
            .add(dtpVendorContactBirthDate)
            .add(txtVendorContactVendorCode)
            .add(txtVendorContactVendorName)
            .add(txtVendorContactVendorAddress)
            .add(txtVendorContactVendorPhone1)
            .add(txtVendorContactVendorPhone2)
            .add(txtVendorContactVendorFax)
            .add(txtVendorContactVendorEmail)
            .add(txtVendorContactVendorCityCode)
            .add(txtVendorContactVendorCityName)
            .add(txtVendorContactVendorCountryCode)
            .add(txtVendorContactVendorCountryName)
            .add(txtVendorContactJobPositionCode)
            .add(txtVendorContactJobPositionName)
            .add(txtVendorContactAddress)
            .add(txtVendorContactCityCode)
            .add(txtVendorContactCityName)
            .add(txtVendorContactPhone1)
            .add(txtVendorContactPhone2)
            .add(txtVendorContactFax)
            .add(txtVendorContactEmail)        
            .add(rdbVendorContactActiveStatus)
            .add(txtVendorContactCreatedBy)
            .add(txtVendorContactCreatedDate)



    function reloadGridVendorContact(){
        $("#vendor_contact_grid").trigger("reloadGrid");
    };
    function formatDateBirthDate() {
        
        var transactionDate = formatDate($("#vendorContact\\.birthDate").val(),false);
        $("#vendorContact\\.birthDate").val(transactionDate);
        $("#vendorContact\\.birthDateTemp").val(transactionDate + " 00:00:00");

    };
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("vendorContact");
         $.subscribe("vendor_header_grid_onSelect", function(event, data){
            var selectedRowID = $("#vendor_header_grid").jqGrid("getGridParam", "selrow"); 
            var vendorHeader = $("#vendor_header_grid").jqGrid("getRowData", selectedRowID);
           
            $("#vendor_contact_grid").jqGrid("setGridParam",{url:"master/vendor-contact-reload-grid?vendor.code=" + vendorHeader.code});
            $("#vendor_contact_grid").jqGrid("setCaption", "Vendor Contact : " + vendorHeader.code);
            $("#vendor_contact_grid").trigger("reloadGrid");
        });
       
        
        $('#vendorContact\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#vendorContactSearchActiveStatusRadActive').prop('checked',true);
        $("#vendorContactSearchActiveStatus").val("true");
        
        $('input[name="vendorContactSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#vendorContactSearchActiveStatus").val(value);
        });
        
        $('input[name="vendorContactSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#vendorContactSearchActiveStatus").val(value);
        });
                
        $('input[name="vendorContactSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#vendorContactSearchActiveStatus").val(value);
        });
        
        $('input[name="vendorContact\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#vendorContact\\.activeStatus").val(value);
        });
                
        $('input[name="vendorContact\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#vendorContact\\.activeStatus").val(value);
        });
        
        $("#btnVendorContactNew").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/vendor-contact-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    txtVendorContactCode.val("AUTO");
                    var selectedRowId = $("#vendor_header_grid").jqGrid("getGridParam", "selrow");
                    if (selectedRowId == null) {
                        alert("Please Select Row Vendor");
                        return;
                    }
                    showInput("vendorContact");
                    $(".data-view-contact").hide();
                    $('#vendorContact\\.activeStatusActive').prop('checked',true);
                    $("#vendorContact\\.activeStatus").val("true");
                    $("#frmVendorContactSearchInput").hide();

//                    var today=getDateTimeIndonesianToday(false);
                    $("#vendorContact\\.birthDate").val();                    

                    txtVendorContactCode.attr("readonly",true);
        //            $("#vendorContact\\.inActiveDate").val("01/01/1900");

                    var vendor = $("#vendor_header_grid").jqGrid('getRowData', selectedRowId);
                    var url = "master/vendor-get";
                    var params = "vendor.code=" + vendor.code;
                    
                    $("#vendorContact\\.vendor\\.code").attr("readonly", true);
                    $("#vendorContact\\.code").attr("readonly", true);
                    $("#vendorContact\\.vendor\\.address").attr("readonly", true);
                    $("#vendorContact\\.code").val("AUTO");

                    $.post(url, params, function (data) {

                    $("#vendorContact\\.vendor\\.code").val(data.vendorTemp.code);

                    $("#vendorContact\\.vendor\\.name").val(data.vendorTemp.name);
                    $("#vendorContact\\.vendor\\.address").val(data.vendorTemp.address);
                    $("#vendorContact\\.vendor\\.city\\.code").val(data.vendorTemp.cityCode);
                    $("#vendorContact\\.vendor\\.city\\.name").val(data.vendorTemp.cityName);
                    $("#vendorContact\\.vendor\\.city\\.province\\.island\\.country\\.code").val(data.vendorTemp.countryCode);
                    $("#vendorContact\\.vendor\\.city\\.province\\.island\\.country\\.name").val(data.vendorTemp.countryName);
                    $("#vendorContact\\.vendor\\.phone1").val(data.vendorTemp.phone1);
                    $("#vendorContact\\.vendor\\.phone2").val(data.vendorTemp.phone2);
                    $("#vendorContact\\.vendor\\.fax").val(data.vendorTemp.fax);
                    $("#vendorContact\\.vendor\\.email").val(data.vendorTemp.emailAddress);
                    $("#vendorContact\\.vendor\\.category\\.code").val(data.vendorTemp.vendorCategoryCode);
                    $("#vendorContact\\.vendor\\.category\\.name").val(data.vendorTemp.vendorCategoryName);
                    $("#vendorContact\\.vendor\\.defaultContactPersonCode").val(data.vendorTemp.defaultContactPersonCode);                 
                    });

                    updateRowId = -1;
                    ev.preventDefault();
                });
            });

        });
        
        
        $("#btnVendorContactSave").click(function(ev) {
//           dtpVendorContactBirthDate.val(formatDate(dtpVendorContactBirthDate.val(),false));
           if(!$("#frmVendorContactInput").valid()) {
//                dtpVendorContactBirthDate.val(formatDate(dtpVendorContactBirthDate.val(),false));
                ev.preventDefault();
                return;
           };
           
           var url = "";
            formatDateBirthDate();
           if (updateRowId < 0) 
           {url = "master/vendor-contact-save";
           }
           else{
               url = "master/vendor-contact-update";
           }      
           var params = $("#frmVendorContactInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    formatDateBirthDate();
                    alertMessage(data.errorMessage);
//                    dtpVendorContactBirthDate.val(formatDate(dtpVendorContactBirthDate.val(),false));
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("vendorContact");
                $(".data-view-contact").show();
                
                allFieldsVendorContact.val('').siblings('label[class="error"]').hide();
                txtVendorContactCode.val("AUTO");
                reloadGridVendorContact();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnVendorContactUpdate").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/vendor-contact-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }

//                unHandlers_input_vendorContact();
                updateRowId=$("#vendor_contact_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var vendorContact=$("#vendor_contact_grid").jqGrid('getRowData',updateRowId);
                var url="master/vendor-contact-find-one-data";
                var params="code=" + vendorContact.code;
              
                txtVendorContactCode.attr("readonly",true);
                $("#vendorContact\\.vendor\\.code").attr("readonly", true);
                
                $.post(url,params,function (result){
                    var data=(result);
                        txtVendorContactCode.val(data.vendorContact.code);
                        txtVendorContactName.val(data.vendorContact.name);
                        rdbVendorContactActiveStatus.val(data.vendorContact.activeStatus);
                        txtVendorContactCreatedBy.val(data.vendorContact.createdBy);
                        txtVendorContactCreatedDate.val(data.vendorContact.createdDate);
                        txtVendorContactPhone.val(data.vendorContact.phone);
                        txtVendorContactMobileNo.val(data.vendorContact.mobileNo);
                        dtpVendorContactBirthDate.val(formatDateRemoveT(data.vendorContact.birthDate,true));
                        txtVendorContactVendorCode.val(data.vendorContact.vendor.code); 
                        txtVendorContactVendorName.val(data.vendorContact.vendor.name); 
                        txtVendorContactJobPositionCode.val(data.vendorContact.jobPosition.code);
                        txtVendorContactJobPositionName.val(data.vendorContact.jobPosition.name); 
                        txtVendorContactAddress.val(data.vendorContact.vendor.address);
                        txtVendorContactCityCode.val(data.vendorContact.vendor.city.code);
                        txtVendorContactCityName.val(data.vendorContact.vendor.city.name);
                        txtVendorContactVendorCountryCode.val(data.vendorContact.vendor.city.province.island.country.code);
                        txtVendorContactVendorCountryName.val(data.vendorContact.vendor.city.province.island.country.name);
                        txtVendorContactPhone1.val(data.vendorContact.vendor.phone1);
                        txtVendorContactPhone2.val(data.vendorContact.vendor.phone2);
                        txtVendorContactFax.val(data.vendorContact.vendor.fax);
                        txtVendorContactEmail.val(data.vendorContact.vendor.email);
                        
                        if(data.vendorContact.activeStatus===true) {
                           $('#vendorContact\\.activeStatusActive').prop('checked',true);
                           $("#vendorContact\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#vendorContact\\.activeStatusInActive').prop('checked',true);              
                           $("#vendorContact\\.activeStatus").val("false");
                        }
                        
                        
                        showInput("vendorContact");
                        $(".data-view-contact").hide();
                        reloadGridVendorContact();
                });
            });
            });
        });
        
        
        $("#btnVendorContactDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/vendor-contact-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#vendor_contact_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var vendorContact = $("#vendor_contact_grid").jqGrid('getRowData', deleteRowId);
                        if (vendorContact.code===vendorContact.contactPerson){
                            alertMessage("Can't Delete, Data has been Used in Default Contact Person Master Vendor !");
                            return;
                            
                        }
//                        if (confirm("Are You Sure To Delete (Code : " + vendorContact.code + ")")) {
                            var url = "master/vendor-contact-delete";
                            var params = "vendorContact.code=" + vendorContact.code;
                            var message="Are You Sure To Delete(Code : "+ vendorContact.code + ")?";
                            alertMessageDelete("vendorContact",url,params,message,400);
//                            $.post(url, params, function () {
                                reloadGridVendorContact();
//                            });
                        }
//                    }
                    ev.preventDefault();
                });
            });
        });
        

        $("#btnVendorContactCancel").click(function(ev) {
            hideInput("vendorContact");
            $(".data-view-contact").show();
            allFieldsVendorContact.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnVendorContactRefresh').click(function(ev) {
            $("#vendor_header_grid").jqGrid("clearGridData");
            $("#vendor_contact_grid").trigger("clearGridData");
            $("#vendor_header_grid").jqGrid("setGridParam",{url:"master/vendor-contact-data?"});
            $("#vendor_header_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnVendorContactPrint").click(function(ev) {
            
            var url = "reports/vendor-contact-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'vendorContact','width=500,height=500');
        });
        
        $('#btnVendorContact_search').click(function(ev) {
            $("#vendor_header_grid").jqGrid("clearGridData");
            $("#vendor_contact_grid").trigger("clearGridData");
            $("#vendor_header_grid").jqGrid("setGridParam",{url:"master/vendor-contact-data?" + $("#frmVendorContactSearchInput").serialize()});
            $("#vendor_header_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $("#vendorContact_btnVendor").click(function(ev){
            window.open("./pages/search/search-vendor.jsp?iddoc=vendorContact&idsubdoc=vendor","Search", "scrollbars=1, width=600, height=500");
        });
        $("#vendorContact_btnJobPosition").click(function(ev){
            window.open("./pages/search/search-job-position.jsp?iddoc=vendorContact&idsubdoc=jobPosition","Search", "scrollbars=1, width=600, height=500");
        });
       
    });

</script>
<s:url id="remoteurlVendor" action="vendor-json" />
<s:url id="remoteurlVendorAddress" action="" />
<b>VENDOR CONTACT</b>
<hr>
<br class="spacer"/>
<div class="data-view-contact content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmVendorContactSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="vendorContactSearchCode" name="vendorContactSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="vendorContactSearchName" name="vendorContactSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="vendorContactSearchActiveStatus" name="vendorContactSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="vendorContactSearchActiveStatusRad" name="vendorContactSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnVendorContact_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div class="data-view-contact">
    <sjg:grid
        id="vendor_header_grid"
        dataType="json"
        caption="VENDOR"
        href="%{remoteurlVendor}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="vendor_header_grid_onSelect"
        width="$('#tabmnuvendor').width()"
    >

        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" key="name" title="Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="address" index="address" key="address" title="Address" width="350" sortable="true"
        />
        <sjg:gridColumn
            name="zipCode" index="zipCode" key="zipCode" title="ZipCode" width="80" sortable="true"
        />
        <sjg:gridColumn
            name="cityCode" index="cityCode" key="cityCode" title="City Code" width="80" sortable="true"
        />
        <sjg:gridColumn
            name="cityName" index="cityName" key="cityName" title="City Name" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="phone1" index="phone1" key="phone1" title="Phone 1 " width="150" sortable="true"
        />
        <sjg:gridColumn
            name="phone2" index="phone2" key="phone2" title="Phone 2" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="fax" index="fax" key="fax" title="Fax" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="email" index="email" key="email" title="Email Address" width="250" sortable="true"
        /> 
        <sjg:gridColumn
            name="npwpName" index="npwpName" key="npwpName" title="NPWP Name" width="100" sortable="true"
        /> 
        <sjg:gridColumn
            name="npwpAddress" index="npwpAddress" key="npwpAddress" title="NPWP Address" width="100" sortable="true"
        /> 
        <sjg:gridColumn
            name="contactPerson" index="contactPerson" key="contactPerson" title="Contact Person" width="100" sortable="true"
        /> 
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="20" formatter="checkbox" align="center" 
        />
    </sjg:grid >
</div>
<div class="data-view-contact">
<hr/>
<sj:div id="vendorContactButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <a href="#" id="btnVendorContactNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
    <a href="#" id="btnVendorContactUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
    <a href="#" id="btnVendorContactDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
    <a href="#" id="btnVendorContactRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
    <!--<a href="#" id="btnVendorContactPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>-->
</sj:div>
<br>
<br>
<br>
<br>
<br>
<br>
</div>
<div class="data-view-contact">
    <sjg:grid
        id="vendor_contact_grid"
        caption="VENDOR CONTACT"
        dataType="json"
        href="%{remoteurlVendorContact}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorContactTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuVENDORContact').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="false"
        />  
       <sjg:gridColumn
            name="jobPositionCode" index="jobPositionCode" title="Job Position Code" width="125" sortable="false"
        />  
        <sjg:gridColumn
            name="jobPositionName" index="jobPositionName" title="Job Position Name" width="125" sortable="false"
        /> 
        <sjg:gridColumn
            name="phone" index="phone" title="phone" width="80" sortable="false"
        />  
        <sjg:gridColumn
            name="mobileNo" index="mobileNo" title="Mobile No" width="100" sortable="false"
        />  
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />
        <sjg:gridColumn
            name="contactPerson" index="contactPerson" key="contactPerson" title="Contact Person" width="100" sortable="true" hidden="true"
        /> 
    </sjg:grid >
</div>

<div id="vendorContactInput" class="content ui-widget">
    <s:form id="frmVendorContactInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td style="vertical-align: text-bottom;">
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><B>Vendor Code *</B></td>
                            <td><s:textfield id="vendorContact.vendor.code" name="vendorContact.vendor.code" size="20" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Name *</B></td>
                            <td><s:textfield id="vendorContact.vendor.name" name="vendorContact.vendor.name" size="20" title="*" required="true" cssClass="required" maxLength="95" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Contact *</B></td>
                            <td><s:textarea id="vendorContact.vendor.address" name="vendorContact.vendor.address" rows="3" cols="40"  title="*" readonly="true"></s:textarea> </td>
                        </tr>
                        <tr>
                            <td align="right"><B>City *</B></td>
                            <td>
                                <s:textfield id="vendorContact.vendor.city.code" name="vendorContact.vendor.city.code" title="*" required="true" cssClass="required" maxLength="45" size="20" readonly="true"></s:textfield>
                                <s:textfield id="vendorContact.vendor.city.name" name="vendorContact.vendor.city.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Country</td>
                            <td>
                                <s:textfield id="vendorContact.vendor.city.province.island.country.code" name="vendorContact.vendor.city.province.island.country.code" size="20" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="vendorContact.vendor.city.province.island.country.name" name="vendorContact.vendor.city.province.island.country.name" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Phone 1 *</B></td>
                            <td>
                                <s:textfield id="vendorContact.vendor.phone1" name="vendorContact.vendor.phone1" size="20" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                &nbsp;&nbsp; Phone 2
                                <s:textfield id="vendorContact.vendor.phone2" name="vendorContact.vendor.phone2" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Fax</td>
                            <td>
                                <s:textfield id="vendorContact.vendor.fax" name="vendorContact.vendor.fax" size="20" maxLength="45" readonly="true"></s:textfield>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email
                                <s:textfield id="vendorContact.vendor.email" name="vendorContact.vendor.email" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><b>Code *</b></td>
                            <td><s:textfield id="vendorContact.code" name="vendorContact.code" title="*" required="true" size="25" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><b>Name *</b></td>
                            <td><s:textfield id="vendorContact.name" name="vendorContact.name" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Birth Date</td>
                            <td>
                                <%--<sj:datepicker id="vendorContact.birthDate" name="vendorContact.birthDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>--%>
                                <sj:datepicker id="vendorContact.birthDate" name="vendorContact.birthDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                <s:textfield cssStyle="display:none" id="vendorContactTemp.birthDateTemp" name="vendorContactTemp.birthDateTemp" ></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right"><b>Phone *</b></td>
                            <td><s:textfield id="vendorContact.phone" name="vendorContact.phone" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><b>Mobile No *</b></td>
                            <td><s:textfield id="vendorContact.mobileNo" name="vendorContact.mobileNo" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>

                        <tr>
                            <td align="right"><B>Job Position *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtVendorContactJobPositionCode.change(function(ev) {

                                        if(txtVendorContactJobPositionCode.val()===""){
                                            txtVendorContactJobPositionCode.val("");
                                            txtVendorContactJobPositionName.val("");
                                            return;
                                        }
                                        var url = "master/job-position-get";
                                        var params = "jobPosition.code=" + txtVendorContactJobPositionCode.val();
                                            params += "&jobPosition.activeStatus=TRUE";
                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.jobPositionTemp){
                                                txtVendorContactJobPositionCode.val(data.jobPositionTemp.code);
                                                txtVendorContactJobPositionName.val(data.jobPositionTemp.name);
                                            }
                                            else{
                                                txtVendorContactJobPositionCode.val("");
                                                txtVendorContactJobPositionName.val("");
                                                alertMessage("Job Position Not Found!",txtVendorContactJobPositionCode);
                                            }
                                        });
                                    });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="vendorContact.jobPosition.code" name="vendorContact.jobPosition.code" title="*" size="20" required="true" cssClass="required" maxLength="45"></s:textfield>
                                        <sj:a id="vendorContact_btnJobPosition" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="vendorContact.jobPosition.name" name="vendorContact.jobPosition.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        <tr>
                            <td align="right"><B>Active Status *</B>
                            <s:textfield id="vendorContact.activeStatus" name="vendorContact.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="vendorContact.activeStatus" name="vendorContact.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                        </tr>    
                        </tr>
                        <tr>
                            <td><s:textfield id="vendorContact.createdBy"  name="vendorContact.createdBy" size="20" style="display:none"></s:textfield></td>
                            <td><s:textfield id="vendorContact.createdDate" name="vendorContact.createdDate" size="20" style="display:none"></s:textfield></td>
                        </tr>
                        <tr>
                            <td/>
                            <td>
                                <div class="error ui-state-error ui-corner-all">
                                    <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
                                </div>
                                    <sj:a href="#" id="btnVendorContactSave" button="true">Save</sj:a>
                                    <sj:a href="#" id="btnVendorContactCancel" button="true">Cancel</sj:a>
                                <br/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
    </s:form>
</div>