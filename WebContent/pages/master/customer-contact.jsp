
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">
     
    var 
        txtCustomerContactCode=$("#customerContact\\.code"),
        txtCustomerContactName=$("#customerContact\\.name"),
        txtCustomerContactPhone=$("#customerContact\\.phone"),
        txtCustomerContactMobileNo=$("#customerContact\\.mobileNo"),
        dtpCustomerContactBirthDate=$("#customerContact\\.birthDate"),
        txtCustomerContactCustomerCode = $("#customerContact\\.customer\\.code"),
        txtCustomerContactCustomerName = $("#customerContact\\.customer\\.name"),
        txtCustomerContactCustomerAddress = $("#customerContact\\.customer\\.address"),
        txtCustomerContactCustomerPhone1 = $("#customerContact\\.customer\\.phone1"),
        txtCustomerContactCustomerPhone2 = $("#customerContact\\.customer\\.phone2"),
        txtCustomerContactCustomerFax = $("#customerContact\\.customer\\.fax"),
        txtCustomerContactCustomerEmail = $("#customerContact\\.customer\\.email"),
        txtCustomerContactCustomerCityCode = $("#customerContact\\.customer\\.city\\.code"),
        txtCustomerContactCustomerCityName = $("#customerContact\\.customer\\.city\\.name"),
        txtCustomerContactJobPositionCode = $("#customerContact\\.jobPosition\\.code"),
        txtCustomerContactJobPositionName = $("#customerContact\\.jobPosition\\.name"),
        txtCustomerContactAddress = $("#customerContact\\.customer\\.address"),
        txtCustomerContactCityCode = $("#customerContact\\.customer\\.city\\.code"),
        txtCustomerContactCityName = $("#customerContact\\.customer\\.city\\.name"),
        txtCustomerContactPhone1 = $("#customerContact\\.customer\\.phone1"),
        txtCustomerContactPhone2 = $("#customerContact\\.customer\\.phone2"),
        txtCustomerContactFax = $("#customerContact\\.customer\\.fax"),
        txtCustomerContactEmail = $("#customerContact\\.customer\\.email"),
        rdbCustomerContactActiveStatus=$("customerContact\\.activeStatus"),
        txtCustomerContactCreatedBy = $("#customerContact\\.createdBy"),
        txtCustomerContactCreatedDate = $("#customerContact\\.createdDate"),
       
        
        allFieldsCustomerContact=$([])
            .add(txtCustomerContactCode)
            .add(txtCustomerContactName)
            .add(txtCustomerContactPhone)
            .add(txtCustomerContactMobileNo)
            .add(dtpCustomerContactBirthDate)
            .add(txtCustomerContactCustomerCode)
            .add(txtCustomerContactCustomerName)
            .add(txtCustomerContactCustomerAddress)
            .add(txtCustomerContactCustomerPhone1)
            .add(txtCustomerContactCustomerPhone2)
            .add(txtCustomerContactCustomerFax)
            .add(txtCustomerContactCustomerEmail)
            .add(txtCustomerContactCustomerCityCode)
            .add(txtCustomerContactCustomerCityName)
            .add(txtCustomerContactJobPositionCode)
            .add(txtCustomerContactJobPositionName)
            .add(txtCustomerContactAddress)
            .add(txtCustomerContactCityCode)
            .add(txtCustomerContactCityName)
            .add(txtCustomerContactPhone1)
            .add(txtCustomerContactPhone2)
            .add(txtCustomerContactFax)
            .add(txtCustomerContactEmail)        
            .add(rdbCustomerContactActiveStatus)
            .add(txtCustomerContactCreatedBy)
            .add(txtCustomerContactCreatedDate)



    function reloadGridCustomerContact(){
        $("#customer_contact_grid").trigger("reloadGrid");
    };
    function formatDateBirthDate() {
        
        var transactionDate = formatDate($("#customerContact\\.birthDate").val(),false);
        $("#customerContact\\.birthDate").val(transactionDate);
        $("#customerContact\\.birthDateTemp").val(transactionDate + " 00:00:00");

    };
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("customerContact");
        
         $.subscribe("customer_header_grid_onSelect", function(event, data){
            var selectedRowID = $("#customer_header_grid").jqGrid("getGridParam", "selrow"); 
            var customerHeader = $("#customer_header_grid").jqGrid("getRowData", selectedRowID);
           
            $("#customer_contact_grid").jqGrid("setGridParam",{url:"master/customer-contact-reload?customer.code=" + customerHeader.code});
            $("#customer_contact_grid").jqGrid("setCaption", "Customer Contact : " + customerHeader.code);
            $("#customer_contact_grid").trigger("reloadGrid");
        });
       
        
        $('#customerContact\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#customerContactSearchActiveStatusRadActive').prop('checked',true);
        $("#customerContactSearchActiveStatus").val("true");
        
        $('input[name="customerContactSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#customerContactSearchActiveStatus").val(value);
        });
        
        $('input[name="customerContactSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#customerContactSearchActiveStatus").val(value);
        });
                
        $('input[name="customerContactSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#customerContactSearchActiveStatus").val(value);
        });
        
        $('input[name="customerContact\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#customerContact\\.activeStatus").val(value);
        });
                
        $('input[name="customerContact\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#customerContact\\.activeStatus").val(value);
        });
        
        $("#btnCustomerContactNew").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/customer-contact-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    txtCustomerContactCode.val("AUTO");
                    var selectedRowId = $("#customer_header_grid").jqGrid("getGridParam", "selrow");
                    if (selectedRowId == null) {
                        alert("Please Select Row Customer");
                        return;
                    }
                    showInput("customerContact");
                    $(".data-view-contact").hide();
                    $('#customerContact\\.activeStatusActive').prop('checked',true);
                    $("#customerContact\\.activeStatus").val("true");
                    $("#frmCustomerContactSearchInput").hide();

                    var today=getDateTimeIndonesianToday(false);
                    $("#customerContact\\.birthDate").val(today);                    

                    txtCustomerContactCode.attr("readonly", false);
        //            $("#customerContact\\.inActiveDate").val("01/01/1900");

                    var customer = $("#customer_header_grid").jqGrid('getRowData', selectedRowId);
                    var url = "master/customer-get";
                    var params = "customer.code=" + customer.code;
                    params += "&customer.activeStatus=TRUE";
                    $("#customerContact\\.customer\\.code").attr("readonly", true);
                    $("#customerContact\\.code").attr("readonly", true);
                    $("#customerContact\\.customer\\.address").attr("readonly", true);
                    $("#customerContact\\.code").val("AUTO");

                    $.post(url, params, function (result) {
                    var data = (result);

                    $("#customerContact\\.customer\\.code").val(data.customerTemp.code);

                    $("#customerContact\\.customer\\.name").val(data.customerTemp.name);
                    $("#customerContact\\.customer\\.address").val(data.customerTemp.address);
                    $("#customerContact\\.customer\\.city\\.code").val(data.customerTemp.cityCode);
                    $("#customerContact\\.customer\\.city\\.name").val(data.customerTemp.cityName);
                    $("#customerContact\\.customer\\.city\\.province\\.island\\.country\\.code").val(data.customerTemp.countryCode);
                    $("#customerContact\\.customer\\.city\\.province\\.island\\.country\\.name").val(data.customerTemp.countryName);
                    $("#customerContact\\.customer\\.phone1").val(data.customerTemp.phone1);
                    $("#customerContact\\.customer\\.phone2").val(data.customerTemp.phone2);
                    $("#customerContact\\.customer\\.fax").val(data.customerTemp.fax);
                    $("#customerContact\\.customer\\.email").val(data.customerTemp.emailAddress);
                    $("#customerContact\\.customer\\.category\\.code").val(data.customerTemp.customerCategoryCode);
                    $("#customerContact\\.customer\\.category\\.name").val(data.customerTemp.customerCategoryName);
                    $("#customerContact\\.customer\\.defaultContactPersonCode").val(data.customerTemp.defaultContactPersonCode);                 
                    });

                    updateRowId = -1;
                    txtCustomerContactCode.val("AUTO");
                    txtCustomerContactCode.attr("readonly",true);
                    ev.preventDefault();
                });
            });

        });
        
        
        $("#btnCustomerContactSave").click(function(ev) {
//           dtpCustomerContactBirthDate.val(formatDate(dtpCustomerContactBirthDate.val(),false));
           if(!$("#frmCustomerContactInput").valid()) {
//                dtpCustomerContactBirthDate.val(formatDate(dtpCustomerContactBirthDate.val(),false));
                ev.preventDefault();
                return;
           };
           
           var url = "";
            formatDateBirthDate();
           if (updateRowId < 0) 
           {url = "master/customer-contact-save";
           }
           else{
               url = "master/customer-contact-update";
           }      
           var params = $("#frmCustomerContactInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    formatDateBirthDate();
                    alertMessage(data.errorMessage);
//                    dtpCustomerContactBirthDate.val(formatDate(dtpCustomerContactBirthDate.val(),false));
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("customerContact");
                $(".data-view-contact").show();
                
                allFieldsCustomerContact.val('').siblings('label[class="error"]').hide();
                txtCustomerContactCode.val("AUTO");
                reloadGridCustomerContact();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnCustomerContactUpdate").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/customer-contact-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }

//                unHandlers_input_customerContact();
                updateRowId=$("#customer_contact_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var customerContact=$("#customer_contact_grid").jqGrid('getRowData',updateRowId);
                var url="master/customer-contact-find-one-data";
                var params="code=" + customerContact.code;
              
                txtCustomerContactCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtCustomerContactCode.val(data.customerContact.code);
                        txtCustomerContactName.val(data.customerContact.name);
                        rdbCustomerContactActiveStatus.val(data.customerContact.activeStatus);
                        txtCustomerContactCreatedBy.val(data.customerContact.createdBy);
                        txtCustomerContactCreatedDate.val(data.customerContact.createdDate);
                        txtCustomerContactPhone.val(data.customerContact.phone);
                        txtCustomerContactMobileNo.val(data.customerContact.mobileNo);
                        dtpCustomerContactBirthDate.val(formatDateRemoveT(data.customerContact.birthDate,true));
                        txtCustomerContactCustomerCode.val(data.customerContact.customer.code); 
                        txtCustomerContactCustomerName.val(data.customerContact.customer.name); 
                        txtCustomerContactJobPositionCode.val(data.customerContact.jobPosition.code);
                        txtCustomerContactJobPositionName.val(data.customerContact.jobPosition.name); 
                        txtCustomerContactAddress.val(data.customerContact.customer.address);
                        txtCustomerContactCityCode.val(data.customerContact.customer.city.code);
                        txtCustomerContactCityName.val(data.customerContact.customer.city.name);
                        txtCustomerContactPhone1.val(data.customerContact.customer.phone1);
                        txtCustomerContactPhone2.val(data.customerContact.customer.phone2);
                        txtCustomerContactFax.val(data.customerContact.customer.fax);
                        txtCustomerContactEmail.val(data.customerContact.customer.email);
                        
                        

                       
                        if(data.customerContact.activeStatus===true) {
                           $('#customerContact\\.activeStatusActive').prop('checked',true);
                           $("#customerContact\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#customerContact\\.activeStatusInActive').prop('checked',true);              
                           $("#customerContact\\.activeStatus").val("false");
                        }
                        
                        
                        showInput("customerContact");
                        $(".data-view-contact").hide();
                });
            });
            });
        });
        
        
        $("#btnCustomerContactDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/customer-contact-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#customer_contact_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var customerContact = $("#customer_contact_grid").jqGrid('getRowData', deleteRowId);
                        if (customerContact.code===customerContact.contactPerson){
                            alertMessage("Can't Delete, Data has been Used in Default Contact Person Master Customer !");
                            return;
                            
                        }
                        if (confirm("Are You Sure To Delete (Code : " + customerContact.code + ")")) {
                            var url = "master/customer-contact-delete";
                            var params = "customerContact.code=" + customerContact.code;

                            $.post(url, params, function () {
                                reloadGridCustomerContact();
                            });
                        }
                    }
                    ev.preventDefault();
                });
            });
        });
        

        $("#btnCustomerContactCancel").click(function(ev) {
            hideInput("customerContact");
            $(".data-view-contact").show();
            allFieldsCustomerContact.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnCustomerContactRefresh').click(function(ev) {
            $("#customer_header_grid").jqGrid("clearGridData");
            $("#customer_contact_grid").trigger("clearGridData");
            $("#customer_header_grid").jqGrid("setGridParam",{url:"master/customer-contact-data?"});
            $("#customer_header_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCustomerContactPrint").click(function(ev) {
            
            var url = "reports/customer-contact-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'customerContact','width=500,height=500');
        });
        
        $('#btnCustomerContact_search').click(function(ev) {
            $("#customer_header_grid").jqGrid("clearGridData");
            $("#customer_contact_grid").trigger("clearGridData");
            $("#customer_header_grid").jqGrid("setGridParam",{url:"master/customer-contact-data?" + $("#frmCustomerContactSearchInput").serialize()});
            $("#customer_header_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $("#customerContact_btnCustomer").click(function(ev){
            window.open("./pages/search/search-customer.jsp?iddoc=customerContact&idsubdoc=customer","Search", "scrollbars=1, width=600, height=500");
        });
        $("#customerContact_btnJobPosition").click(function(ev){
            window.open("./pages/search/search-job-position.jsp?iddoc=customerContact&idsubdoc=jobPosition","Search", "scrollbars=1, width=600, height=500");
        });
            reloadGridCustomerContact();
       
    });

</script>
<s:url id="remoteurlCustomer" action="customer-json" />
<s:url id="remoteurlCustomerAddress" action="" />
<b>VENDOR CONTACT</b>
<hr>
<br class="spacer"/>
<div class="data-view-contact content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmCustomerContactSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="customerContactSearchCode" name="customerContactSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="customerContactSearchName" name="customerContactSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="customerContactSearchActiveStatus" name="customerContactSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="customerContactSearchActiveStatusRad" name="customerContactSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCustomerContact_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div class="data-view-contact">
    <sjg:grid
        id="customer_header_grid"
        dataType="json"
        caption="CUSTOMER"
        href="%{remoteurlCustomer}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCustomerTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="customer_header_grid_onSelect"
        width="$('#tabmnucustomer').width()"
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
<sj:div id="customerContactButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <a href="#" id="btnCustomerContactNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
    <a href="#" id="btnCustomerContactUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
    <a href="#" id="btnCustomerContactDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
    <a href="#" id="btnCustomerContactRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
    <!--<a href="#" id="btnCustomerContactPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>-->
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
        id="customer_contact_grid"
        caption="CUSTOMER CONTACT"
        dataType="json"
        href="%{remoteurlCustomerContact}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listCustomerContactTemp"
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

<div id="customerContactInput" class="content ui-widget">
    <s:form id="frmCustomerContactInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td style="vertical-align: text-bottom;">
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><B>Customer Code *</B></td>
                            <td><s:textfield id="customerContact.customer.code" name="customerContact.customer.code" size="20" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Name *</B></td>
                            <td><s:textfield id="customerContact.customer.name" name="customerContact.customer.name" size="20" title="*" required="true" cssClass="required" maxLength="95" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Contact *</B></td>
                            <td><s:textarea id="customerContact.customer.address" name="customerContact.customer.address" rows="3" cols="40"  title="*" readonly="true"></s:textarea> </td>
                        </tr>
                        <tr>
                            <td align="right"><B>City *</B></td>
                            <td>
                                <s:textfield id="customerContact.customer.city.code" name="customerContact.customer.city.code" title="*" required="true" cssClass="required" maxLength="45" size="20" readonly="true"></s:textfield>
                                <s:textfield id="customerContact.customer.city.name" name="customerContact.customer.city.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Country</td>
                            <td>
                                <s:textfield id="customerContact.customer.city.province.island.country.code" name="customerContact.customer.city.province.island.country.code" size="20" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="customerContact.customer.city.province.island.country.name" name="customerContact.customer.city.province.island.country.name" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Phone 1 *</B></td>
                            <td>
                                <s:textfield id="customerContact.customer.phone1" name="customerContact.customer.phone1" size="20" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                &nbsp;&nbsp;<B>Phone 2 </B>
                                <s:textfield id="customerContact.customer.phone2" name="customerContact.customer.phone2" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Fax</td>
                            <td>
                                <s:textfield id="customerContact.customer.fax" name="customerContact.customer.fax" size="20" maxLength="45" readonly="true"></s:textfield>
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email
                                <s:textfield id="customerContact.customer.email" name="customerContact.customer.email" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                         <tr>
                            <td align="right"><B>Active Status *</B>
                            <s:textfield id="customerContact.activeStatus" name="customerContact.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="customerContact.activeStatus" name="customerContact.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                        </tr>
                    </table>
                </td>
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><b>Code *</b></td>
                            <td><s:textfield id="customerContact.code" name="customerContact.code" title="*" required="true" size="25" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><b>Name *</b></td>
                            <td><s:textfield id="customerContact.name" name="customerContact.name" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Birth Date</td>
                            <td>
                                <%--<sj:datepicker id="customerContact.birthDate" name="customerContact.birthDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>--%>
                                <sj:datepicker id="customerContact.birthDate" name="customerContact.birthDate" required="true" cssClass="required" displayFormat="dd/mm/yy" size="25" showOn="focus"></sj:datepicker>
                                <s:textfield cssStyle="display:none" id="customerContactTemp.birthDateTemp" name="customerContactTemp.birthDateTemp" ></s:textfield>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right"><b>Phone *</b></td>
                            <td><s:textfield id="customerContact.phone" name="customerContact.phone" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><b>Mobile No *</b></td>
                            <td><s:textfield id="customerContact.mobileNo" name="customerContact.mobileNo" size="25" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>

                        <tr>
                            <td align="right"><B>Job Position *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtCustomerContactJobPositionCode.change(function(ev) {

                                        if(txtCustomerContactJobPositionCode.val()===""){
                                            txtCustomerContactJobPositionCode.val("");
                                            txtCustomerContactJobPositionName.val("");
                                            return;
                                        }
                                        var url = "master/job-position-get";
                                        var params = "jobPosition.code=" + txtCustomerContactJobPositionCode.val();
                                            params += "&jobPosition.activeStatus=TRUE";
                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.jobPositionTemp){
                                                txtCustomerContactJobPositionCode.val(data.jobPositionTemp.code);
                                                txtCustomerContactJobPositionName.val(data.jobPositionTemp.name);
                                            }
                                            else{
                                                txtCustomerContactJobPositionCode.val("");
                                                txtCustomerContactJobPositionName.val("");
                                                alertMessage("Job Position Not Found!",txtCustomerContactJobPositionCode);
                                            }
                                        });
                                    });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customerContact.jobPosition.code" name="customerContact.jobPosition.code" title="*" size="20" required="true" cssClass="required" maxLength="45"></s:textfield>
                                        <sj:a id="customerContact_btnJobPosition" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="customerContact.jobPosition.name" name="customerContact.jobPosition.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td><s:textfield id="customerContact.createdBy"  name="customerContact.createdBy" size="20" style="display:none"></s:textfield></td>
                            <td><s:textfield id="customerContact.createdDate" name="customerContact.createdDate" size="20" style="display:none"></s:textfield></td>
                        </tr>
                        <tr>
                            <td/>
                            <td>
                                <div class="error ui-state-error ui-corner-all">
                                    <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
                                </div>
                                    <sj:a href="#" id="btnCustomerContactSave" button="true">Save</sj:a>
                                    <sj:a href="#" id="btnCustomerContactCancel" button="true">Cancel</sj:a>
                                <br/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
    </s:form>
</div>