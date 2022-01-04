<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/bootstrap.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/bootstrap.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #customerContactDetail_grid_pager_center{
        display: none;
    }
</style>
<script type="text/javascript">
    var vendorDefaultContact_lastRowId = 0, customerDefaultContact_lastSel = -1 ;
    var 
        txtCustomerCode = $("#customer\\.code"),
        txtCustomerName = $("#customer\\.name"),
        txtCustomerAddress = $("#customer\\.address"),
        txtCustomerCityCode = $("#customer\\.city\\.code"),
        txtCustomerCityName = $("#customer\\.city\\.name"),
        txtCustomerProvinceCode=$("#customer\\.city\\.province\\.code"),
        txtCustomerProvinceName=$("#customer\\.city\\.province\\.name"),
        txtCustomerIslandCode=$("#customer\\.city\\.province\\.island\\.code"),
        txtCustomerIslandName=$("#customer\\.city\\.province\\.island\\.name"),
        txtCustomerCountryCode=$("#customer\\.city\\.province\\.island\\.country\\.code"),
        txtCustomerCountryName=$("#customer\\.city\\.province\\.island\\.country\\.name"),
        txtCustomerPaymentTermCode = $("#customer\\.paymentTerm\\.code"),
        txtCustomerPaymentTermName = $("#customer\\.paymentTerm\\.name"),
        txtCustomerCustomerCategoryCode = $("#customer\\.customerCategory\\.code"),
        txtCustomerCustomerCategoryName = $("#customer\\.customerCategory\\.name"),
        txtCustomerDefaultContactPersonCode = $("#customer\\.defaultContactPerson\\.code"),
        txtCustomerDefaultContactPersonName = $("#customer\\.defaultContactPerson\\name"),
        txtCustomerBusinessEntityCode = $("#customer\\.businessEntity\\.code"),
        txtCustomerBusinessEntityName = $("#customer\\.businessEntity\\.name"),
        txtCustomerZipcode = $("#customer\\.zipCode"),
        txtCustomerPhone1 = $("#customer\\.phone1"),
        txtCustomerPhone2 = $("#customer\\.phone2"),
        txtCustomerFax = $("#customer\\.fax"),
        txtCustomerEmail = $("#customer\\.emailAddress"),
        txtCustomerContactPerson = $("#customer\\.contactPerson"),
        txtCustomerTaxCode = $("#customer\\.taxCode"),
        txtCustomerRemark = $("#customer\\.remark"),
        rdbCustomerActiveStatus = $("#customer\\.activeStatus"),
        rdbCustomerCustomerStatus = $("#customer\\.customerStatus"),
        rdbCustomerEndUserStatus = $("#customer\\.endUserStatus"),
        txtCustomerInActiveBy=$("#customer\\.inActiveBy"),
        dtpCustomerInActiveDate=$("#customer\\.inActiveDate"),
        txtCustomerCreatedBy = $("#customer\\.createdBy"),
        dtpCustomerCreatedDate = $("#customer\\.createdDate"),
        
        allFieldsCustomer=$([])
            .add(txtCustomerCode)
            .add(txtCustomerName)
            .add(txtCustomerAddress)
            .add(txtCustomerCityCode)
            .add(txtCustomerCityName)
            .add(txtCustomerProvinceCode)
            .add(txtCustomerProvinceName)
            .add(txtCustomerIslandCode)
            .add(txtCustomerIslandName)
            .add(txtCustomerCountryCode)
            .add(txtCustomerCountryName)
            .add(txtCustomerPaymentTermCode)
            .add(txtCustomerPaymentTermName)
            .add(txtCustomerCustomerCategoryCode)
            .add(txtCustomerCustomerCategoryName)
            .add(txtCustomerBusinessEntityCode)
            .add(txtCustomerBusinessEntityName)
            .add(txtCustomerZipcode)
            .add(txtCustomerPhone1)
            .add(txtCustomerPhone2)
            .add(txtCustomerFax)
            .add(txtCustomerContactPerson)
            .add(txtCustomerEmail)
            .add(txtCustomerRemark)
            .add(txtCustomerTaxCode)
            .add(txtCustomerDefaultContactPersonCode)
            .add(txtCustomerDefaultContactPersonName)
            .add(txtCustomerCreatedBy)
            .add(txtCustomerInActiveBy);
    
    function numberWithCommasItem(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
          
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("customer");
        
        $.subscribe("customer_grid_onSelect", function(event, data){
            var selectedRowID = $("#customer_grid").jqGrid("getGridParam", "selrow"); 
            var customerHeader = $("#customer_grid").jqGrid("getRowData", selectedRowID);
                     
            $("#customerContactDetail_grid").jqGrid("setGridParam",{url:"master/customer-contact-reload?customer.Code="+ customerHeader.code});
            $("#customerContactDetail_grid").jqGrid("setCaption", "CUSTOMER CONTACT DETAIL : " + customerHeader.code);
            $("#customerContactDetail_grid").trigger("reloadGrid");
            
            $("#customerContact_grid").jqGrid("setGridParam",{url:"master/customer-contact-reload?customer.Code="+ customerHeader.code});
            $("#customerContact_grid").jqGrid("setCaption", "CUSTOMER CONTACT DETAIL : " + customerHeader.code);
            $("#customerContact_grid").trigger("reloadGrid");
        });
        
        $('#customer\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#customerSearchActiveStatusRadActive').prop('checked',true);
        $("#customerSearchActiveStatus").val("true");
        
        $('input[name="customerSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#customerSearchActiveStatus").val(value);
        });
        
        $('input[name="customerSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#customerSearchActiveStatus").val(value);
        });
                
        $('input[name="customerSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#customerSearchActiveStatus").val(value);
        });
        
        $('input[name="customer\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#customer\\.activeStatus").val(value);
        });
                
        $('input[name="customer\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#customer\\.activeStatus").val(value);
        });
        $('input[name="customer\\.customerStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#customer\\.customerStatus").val(value);
        });
                
        $('input[name="customer\\.customerStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#customer\\.customerStatus").val(value);
        });
        $('input[name="customer\\.endUserStatus"][value="Yes"]').change(function(ev){
            var value="true";
            $("#customer\\.endUserStatus").val(value);
        });
                
        $('input[name="customer\\.endUserStatus"][value="No"]').change(function(ev){
            var value="false";
            $("#customer\\.endUserStatus").val(value);
        });
        
        $("#btnCustomerNew").click(function(ev){
            var url="master/customer-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_customer();
                allFieldsCustomer.val('').removeClass('ui-state-error');

                showInput("customer");
                hideInput("customerSearch");
                $('#customer\\.activeStatusActive').prop('checked',true);
                $("#customer\\.activeStatus").val("true");
                $('#customer\\.customerStatusYes').prop('checked',true);
                $("#customer\\.customerStatus").val("true");
                $('#customer\\.endUserStatusYes').prop('checked',true);
                $("#customer\\.endUserStatus").val("true");
//                $('#customer\\.wapuStatusYes').prop('checked',true);
//                $("#customer\\.wapuStatus").val("true");
//                $('#customer\\.promoStatusYes').prop('checked',true);
//                $("#customer\\.promoStatus").val("true");
                $("#customer\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#customer\\.createdDate").val("01/01/1900 00:00:00");
                updateRowId = -1;
                txtCustomerCode.attr("readonly",true);
                txtCustomerCode.val("AUTO");
                $("#customer\\.activeStatus").val("true");
                $("#customer\\.customerStatus").val("true");
                $("#customer\\.endUserStatus").val("true");
//                $("#customer\\.wapuStatus").val("true");
//                $("#customer\\.promoStatus").val("true");
            });
            ev.preventDefault();
        });

        $("#btnCustomerSave").click(function(ev) {
            handlers_input_customer();
            if(!$("#frmCustomerInput").valid()) {
                alert("Field(s) Can't Empty!");
                ev.preventDefault();
                return;
            };
            
             if(txtCustomerTaxCode.val().length !== 3){
                alertMessage("Tax Code not less than 3 digits");
                return;
            }
            customerFormatDate();
//            var taxCode=removeCommas($(" var taxCode#customer\\.taxCode").val());
//            txtCustomerTaxCode.val(taxCode);          
//                
//            var customerPlafondLimit=removeCommas($("#customer\\.plafondLimit").val());
//            txtCustomerPlafondLimit.val(customerPlafondLimit);
        
            var url = "";
            if (updateRowId < 0){
                url = "master/customer-save";
            }else{
                url = "master/customer-update";
            }
                
            var params = $("#frmCustomerInput").serialize();
            
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
                
                hideInput("customer");
                showInput("customerSearch");
                allFieldsCustomer.val('').removeClass('ui-state-error');
                reloadGridCustomer();           
            });
            
            ev.preventDefault();
        });
        
        $("#btnCustomerUpdate").click(function(ev){
            var url="master/customer-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_customer();
                updateRowId = $("#customer_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId === null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var customer = $("#customer_grid").jqGrid('getRowData', updateRowId);
                var url = "master/customer-get-data";
                var params = "customer.code=" + customer.code;

                txtCustomerCode.attr("readonly",true);

                $.post(url, params, function(result) {

                    var data = (result);
                        txtCustomerCode.val(data.customerTemp.code);
                        txtCustomerName.val(data.customerTemp.name);
                        txtCustomerAddress.val(data.customerTemp.address);
                        txtCustomerCityCode.val(data.customerTemp.cityCode);
                        txtCustomerCityName.val(data.customerTemp.cityName);
                        txtCustomerProvinceCode.val(data.customerTemp.provinceCode);
                        txtCustomerProvinceName.val(data.customerTemp.provinceName);
                        txtCustomerCountryCode.val(data.customerTemp.countryCode);
                        txtCustomerCountryName.val(data.customerTemp.countryName);
                        txtCustomerZipcode.val(data.customerTemp.zipCode);
                        txtCustomerPhone1.val(data.customerTemp.phone1);
                        txtCustomerPhone2.val(data.customerTemp.phone2);
                        txtCustomerFax.val(data.customerTemp.fax);
                        txtCustomerContactPerson.val(data.customerTemp.contactPerson);
                        txtCustomerEmail.val(data.customerTemp.emailAddress);
                        txtCustomerPaymentTermCode.val(data.customerTemp.paymentTermCode);
                        txtCustomerPaymentTermName.val(data.customerTemp.paymentTermName);
                        txtCustomerTaxCode.val(data.customerTemp.taxCode);
                        txtCustomerCustomerCategoryCode.val(data.customerTemp.customerCategoryCode);
                        txtCustomerCustomerCategoryName.val(data.customerTemp.customerCategoryName);
                        txtCustomerBusinessEntityCode.val(data.customerTemp.businessEntityCode);
                        txtCustomerBusinessEntityName.val(data.customerTemp.businessEntityName);
                        txtCustomerDefaultContactPersonCode.val(data.customerTemp.defaultContactPersonCode);
                        $("#customer\\.defaultContactPerson\\.name").val(data.customerTemp.defaultContactPersonName);
                        txtCustomerRemark.val(data.customerTemp.remark);

                        rdbCustomerActiveStatus.val(data.customerTemp.activeStatus);
                        rdbCustomerCustomerStatus.val(data.customerTemp.customerStatus);
                        rdbCustomerEndUserStatus.val(data.customerTemp.endUserStatus);
                        txtCustomerInActiveBy.val(data.customerTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.customerTemp.inActiveDate,true);
                        dtpCustomerInActiveDate.val(inActiveDate);
                        txtCustomerCreatedBy.val(data.customerTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.customerTemp.createdDate,true);
                        dtpCustomerCreatedDate.val(createdDate);

                        if(data.customerTemp.activeStatus===true) {
                           $('#customer\\.activeStatusActive').prop('checked',true);
                           $("#customer\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#customer\\.activeStatusInActive').prop('checked',true);              
                           $("#customer\\.activeStatus").val("false");
                        }
                        if(data.customerTemp.customerStatus===true) {
                           $('#customer\\.customerStatusYes').prop('checked',true);
                           $("#customer\\.customerStatus").val("true");
                        }
                        else {                        
                           $('#customer\\.customerStatusNo').prop('checked',true);              
                           $("#customer\\.customerStatus").val("false");
                        }
                        if(data.customerTemp.endUserStatus===true) {
                           $('#customer\\.endUserStatusYes').prop('checked',true);
                           $("#customer\\.endUserStatus").val("true");
                        }
                        else {                        
                           $('#customer\\.endUserStatusNo').prop('checked',true);              
                           $("#customer\\.endUserStatus").val("false");
                        }
                        
                    showInput("customer");
                    hideInput("customerSearch");
                });   
            });
            
            ev.preventDefault();
        });
        
        $('#btnCustomerDelete').click(function(ev) {
            var url="master/customer-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowId = $("#customer_grid").jqGrid('getGridParam','selrow');
                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var customer = $("#customer_grid").jqGrid('getRowData', deleteRowId);

//                if (confirm("Are You Sure To Delete (Code : " + customer.code + ")")) {
                    var url = "master/customer-delete";
                    var params = "customer.code=" + customer.code;
                    var message="Are You Sure To Delete(Code : "+ customer.code + ")?";
                    alertMessageDelete("customer",url,params,message,400);
//                    $.post(url, params, function(data) {
//                        if (data.error) {
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//                        alertMessage(data.message);
                        reloadGridCustomer();
//                    });
//                }
            });
            ev.preventDefault();
        });
        

        $("#btnCustomerCancel").click(function(ev) {
            hideInput("customer");
            showInput("customerSearch");
            allFieldsCustomer.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        $("#btnCustomerPrint").click(function(ev) {
            var status=$('#customerSearchActiveStatus').val();
            var url = "reports/customer-print-out-pdf?";
            var params = "activeStatus=" + status;
              
            window.open(url+params,'customer','width=500,height=500');
        });
        
        $('#btnCustomerRefresh').click(function(ev) {
            $('#customerSearchActiveStatusRadActive').prop('checked',true);
            $("#customerSearchActiveStatus").val("true");
            $("#customer_grid").jqGrid("clearGridData");
            $("#customer_grid").jqGrid("setGridParam",{url:"master/customer-data?"});
            $("#customer_grid").trigger("reloadGrid");
            ev.preventDefault();    
        });
        
        
        $('#btnCustomer_search').click(function(ev) {
            $("#customer_grid").jqGrid("clearGridData");
            $("#customer_grid").jqGrid("setGridParam",{url:"master/customer-data?" + $("#frmCustomerSearchInput").serialize()});
            $("#customer_grid").trigger("reloadGrid");
            ev.preventDefault();
        });   
        
        $('#customer_btnCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=customer&idsubdoc=city","Search", "width=1000, height=475");
        });

        $('#customer_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=customer&idsubdoc=paymentTerm","Search", "width=550, height=475");
        });

        $('#customer_btnBusinessEntity').click(function(ev) {
            window.open("./pages/search/search-business-entity.jsp?iddoc=customer&idsubdoc=businessEntity","Search", "width=550, height=475");
        });
        
        $('#customer_btnCustomerCategory').click(function(ev) {
            window.open("./pages/search/search-customer-category.jsp?iddoc=customer&idsubdoc=customerCategory","Search", "width=550, height=475");
        });
        
        $('#customer_btnDefaultCustomerContact').click(function(ev) {
            var ids = jQuery("#customerContactDetail_grid").jqGrid('getDataIDs');
           
            if(ids.length===0){
                alertMessage("Grid Customer Contact Can't Be Empty!");
                return;
            }
            
            if(customerDefaultContact_lastSel !== -1) {
               $('#customerContactDetail_grid').jqGrid("saveRow",customerDefaultContact_lastSel); 
            }

            var listDefaultContactCode = new Array();
            var listCode = new Array();
            
            for(var i=0;i<ids.length;i++){
                var Detail = $("#customerContactDetail_grid").jqGrid('getRowData',ids[i]); 
                listCode = {
                  code:Detail.code
                };
                listDefaultContactCode.push(listCode);
            }
           
            
            var result = Enumerable.From(listDefaultContactCode)
                            .GroupBy("$.code", null,
                                "[$ ]"
                            )
                            .ToArray();
             
                    
            var strr = "";
                    for(var i = 0; i < result.length; i++){
                        if(i == 0){
                            strr = "" + result[i];
                        }else{
                            strr += "," + result[i];
                        }
                    }
        
            window.open("./pages/search/search-customer-contact.jsp?iddoc=customer&idcustomerContactcode="+strr,"Search", "Scrollbars=1, width=550, height=425");
        });
    });
    
    function reloadGridCustomer() {
        $("#customer_grid").trigger("reloadGrid");
    };
    
    function customerFormatDate(){
        
        var inActiveDate=formatDate(dtpCustomerInActiveDate.val(),true);
        dtpCustomerInActiveDate.val(inActiveDate);
        $("#customerTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpCustomerCreatedDate.val(),true);
        dtpCustomerCreatedDate.val(createdDate);
        $("#customerTemp\\.createdDateTemp").val(createdDate);
    }
    
    function unHandlers_input_customer(){
        unHandlersInput(txtCustomerCode);
        unHandlersInput(txtCustomerName);
        unHandlersInput(txtCustomerAddress);
        unHandlersInput(txtCustomerCityCode);
        unHandlersInput(txtCustomerZipcode);
        unHandlersInput(txtCustomerPhone1);
        unHandlersInput(txtCustomerPaymentTermCode);
        unHandlersInput(txtCustomerCustomerCategoryCode);
//        unHandlersInput(txtCustomerNpwp);
//        unHandlersInput(txtCustomerNpwpName);
//        unHandlersInput(txtCustomerNpwpAddress);
//        unHandlersInput(txtCustomerNpwpCityCode);
//        unHandlersInput(txtCustomerNpwpZipcode);
    }

    function handlers_input_customer(){
        if(txtCustomerCode.val()===""){
            handlersInput(txtCustomerCode);
        }else{
            unHandlersInput(txtCustomerCode);
        }
        
        if(txtCustomerName.val()===""){
            handlersInput(txtCustomerName);
        }else{
            unHandlersInput(txtCustomerName);
        }
        
        if(txtCustomerTaxCode.val()===""){
            handlersInput(txtCustomerTaxCode);
        }else{
            unHandlersInput(txtCustomerTaxCode);
        }
        
        if(txtCustomerAddress.val()===""){
            handlersInput(txtCustomerAddress);
        }else{
            unHandlersInput(txtCustomerAddress);
        }
        
        if(txtCustomerCityCode.val()===""){
            handlersInput(txtCustomerCityCode);
        }else{
            unHandlersInput(txtCustomerCityCode);
        }
        
        if(txtCustomerZipcode.val()===""){
            handlersInput(txtCustomerZipcode);
        }else{
            unHandlersInput(txtCustomerZipcode);
        }
        
        if(txtCustomerPhone1.val()===""){
            handlersInput(txtCustomerPhone1);
        }else{
            unHandlersInput(txtCustomerPhone1);
        }
        
        if(txtCustomerPaymentTermCode.val()===""){
            handlersInput(txtCustomerPaymentTermCode);
        }else{
            unHandlersInput(txtCustomerPaymentTermCode);
        }
        
        if(txtCustomerCustomerCategoryCode.val()===""){
            handlersInput(txtCustomerCustomerCategoryCode);
        }else{
            unHandlersInput(txtCustomerCustomerCategoryCode);
        }
    }
</script>


<s:url id="remoteurlCustomer" action="customer-data" />
<s:url id="remoteurlCustomerContactDetail" action="" />
<b>CUSTOMER</b>
<hr>
<br class="spacer" />
    
<sj:div id="customerButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnCustomerNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a></td>
            <td><a href="#" id="btnCustomerUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a></td>
            <td><a href="#" id="btnCustomerDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a></td>
            <td><a href="#" id="btnCustomerRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a></td>
            <td><a href="#" id="btnCustomerPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print Out</a></td>
        </tr>
    </table>
 </sj:div>

<div id="customerSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmCustomerSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre"><b>Code</b></td>
                <td>
                    <s:textfield id="customerSearchCode" name="customerSearchCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="centre"><b>Name</b></td>
                <td>
                    <s:textfield id="customerSearchName" name="customerSearchName" size="25"></s:textfield>
                <td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="customerSearchActiveStatus" name="customerSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="customerSearchActiveStatusRad" name="customerSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>  
        </table>
        <br />
        <sj:a href="#" id="btnCustomer_search" button="true">Search</sj:a>
        <br />
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
        </div>
    </s:form>
</div>
<br class="spacer" />    
    
<div id="customerGrid">
    <sjg:grid
        id="customer_grid"
        dataType="json"
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
        onSelectRowTopics="customer_grid_onSelect"
        width="$('#tabmnucustomer').width()"
    >

        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" key="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="customerStatusCust" index="customerStatusCust" key="customerStatusCust" title="Customer Status" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="endUserStatusCust" index="endUserStatusCust" key="endUserStatusCust" title="End User Status" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="address" index="address" key="address" title="Address" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="taxCode" index="taxCode" key="taxCode" title="Tax Code" width="25" sortable="true"
        />
        <sjg:gridColumn
            name="cityCode" index="cityCode" key="cityCode" title="City Code" width="80" sortable="true"
        />
        <sjg:gridColumn
            name="cityName" index="cityName" key="cityName" title="City Name" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="countryCode" index="countryCode" key="countryCode" title="Country Code" width="80" sortable="true"
        />
        <sjg:gridColumn
            name="countryName" index="countryName" key="countryName" title="Country Name" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="zipCode" index="zipCode" key="zipCode" title="Zip Code" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="phone1" index="phone1" key="phone1" title="Phone 1 " width="125" sortable="true"
        />
        <sjg:gridColumn
            name="phone2" index="phone2" key="phone2" title="Phone 2" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="fax" index="fax" key="fax" title="Fax" width="125" sortable="true"
        />
        <sjg:gridColumn
            name="emailAddress" index="emailAddress" key="emailAddress" title="Email Address" width="225" sortable="true"
        /> 
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="25" formatter="checkbox" align="center" 
        />
    </sjg:grid >
</div>
 
<div id="customerInput" class="content ui-widget">
    <s:form id="frmCustomerInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>Code *</B></td>
                            <td><s:textfield id="customer.code" name="customer.code" size="20" title=" " required="true" cssClass="required" maxLength="16"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Name *</B></td>
                            <td><s:textfield id="customer.name" name="customer.name" size="30" title=" " required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Address *</B></td>
                            <td><s:textarea id="customer.address" name="customer.address" rows="3" cols="40" title=" " required="true" cssClass="required" ></s:textarea> </td>
                        </tr>
                        <tr>
                            <td align="right"><B>City *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtCustomerCityCode.change(function(ev) {
                                    if(txtCustomerCityCode.val()===""){
                                        txtCustomerCityCode.val("");
                                        txtCustomerCityName.val("");
                                        txtCustomerProvinceCode.val("");
                                        txtCustomerProvinceName.val("");
                                        txtCustomerCountryCode.val("");
                                        txtCustomerCountryName.val("");
                                        return;
                                    }
                                    var url = "master/city-get";
                                    var params = "city.code=" + txtCustomerCityCode.val();
                                        params += "&city.activeStatus="+true;
                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.cityTemp){
                                            txtCustomerCityCode.val(data.cityTemp.code);
                                            txtCustomerCityName.val(data.cityTemp.name);
                                            txtCustomerProvinceCode.val(data.cityTemp.provinceCode);
                                            txtCustomerProvinceName.val(data.cityTemp.provinceName);
                                            txtCustomerCountryCode.val(data.cityTemp.provinceCountryCode);
                                            txtCustomerCountryName.val(data.cityTemp.provinceCountryName);
                                        }
                                        else{
                                            alertMessage("City Not Found!",txtCustomerCityCode);
                                            txtCustomerCityCode.val("");
                                            txtCustomerCityName.val("");
                                            txtCustomerProvinceCode.val("");
                                            txtCustomerProvinceName.val("");
                                            txtCustomerCountryCode.val("");
                                            txtCustomerCountryName.val("");
                                        }
                                    });
                                });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customer.city.code" name="customer.city.code" title=" " required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                                        <sj:a id="customer_btnCity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                <s:textfield id="customer.city.name" name="customer.city.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Province</td>
                            <td>
                                <s:textfield id="customer.city.province.code" name="customer.city.province.code" size="20" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="customer.city.province.name" name="customer.city.province.name" size="40%" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Country</td>
                            <td>
                                <s:textfield id="customer.city.province.island.country.code" name="customer.city.province.island.country.code" size="20" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="customer.city.province.island.country.name" name="customer.city.province.island.country.name" size="40%" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Zip Code *</B></td>
                            <td><s:textfield id="customer.zipCode" name="customer.zipCode" size="20" title=" " required="true" cssClass="required" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Phone 1 *</B></td>
                            <td><s:textfield id="customer.phone1" name="customer.phone1" size="20" title=" " required="true" cssClass="required" maxLength="45"></s:textfield>
                            &nbsp;&nbsp;Phone2
                            <s:textfield id="customer.phone2" name="customer.phone2" size="20"  maxLength="45"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Email</td>
                            <td><s:textfield id="customer.emailAddress" name="customer.emailAddress" size="20" maxLength="45"></s:textfield>
                            &nbsp;&nbsp;Fax
                            <s:textfield id="customer.fax" name="customer.fax" size="20" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">Default Contact Person</td>
                            <td>
                                <div class="searchbox ui-widget-header">
                                <s:textfield id="customer.defaultContactPerson.code" name="customer.defaultContactPerson.code" size="20" ></s:textfield>
                                <sj:a id="customer_btnDefaultCustomerContact" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                </div>
                                <s:textfield id="customer.defaultContactPerson.name" name="customer.defaultContactPerson.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td valign="top" colspan="2">
                                <sjg:grid
                                    id="customerContactDetail_grid"
                                    dataType="json"
                                    href="%{remoteurlCustomerContactDetail}"
                                    pager="true"
                                    navigator="false"
                                    navigatorView="false"
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
                                    >
                                        <sjg:gridColumn
                                            name="code" index="code" key="code" title="Code" width="100" sortable="true" hidden="true"
                                        />
                                        <sjg:gridColumn
                                            name="name" index="name" title="Name" width="150" sortable="true"
                                        />
                                        <sjg:gridColumn
                                            name="birthDate" index="birthDate" title="BirthDate" 
                                            sortable="false" align="center"
                                            formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}" 
                                            width="100" editrules="{date: true, required:false}" 
                                        />
                                        <sjg:gridColumn
                                            name="phone" index="phone" title="Phone" width="150" sortable="true"
                                        />
                                        <sjg:gridColumn
                                            name="jobPositionCode" index="jobPositionCode" title="Job Position Code" width="150" sortable="true"
                                        />
                                </sjg:grid>
                              </td>
                            </tr>
                        </table>
                   </td>
                <td valign="top">
                    <table>
                        <tr>
                            <td align="right"><B>Business Entity *</B></td>
                            <td>
                                <script type = "text/javascript">
                                
                                txtCustomerBusinessEntityCode.change(function(ev) {
                                    if(txtCustomerBusinessEntityCode.val()===""){
                                        txtCustomerBusinessEntityCode.val("");
                                        txtCustomerBusinessEntityName.val("");
                                        return;
                                    }
                                    var url = "master/business-entity-get";
                                    var params = "businessEntity.code=" + txtCustomerBusinessEntityCode.val();
                                        params += "&businessEntity.activeStatus=true";
                                        
                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.businessEntityTemp){
                                            txtCustomerBusinessEntityCode.val(data.businessEntityTemp.code);
                                            txtCustomerBusinessEntityName.val(data.businessEntityTemp.name);
                                        }
                                        else{
                                            alertMessage("Business Entity Not Found!",txtCustomerBusinessEntityCode);
                                            txtCustomerBusinessEntityCode.val("");
                                            txtCustomerBusinessEntityName.val("");
                                        }
                                    });
                                });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customer.businessEntity.code" name="customer.businessEntity.code" title=" " required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                                        <sj:a id="customer_btnBusinessEntity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                <s:textfield id="customer.businessEntity.name" name="customer.businessEntity.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Category *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtCustomerCustomerCategoryCode.change(function(ev) {
                                    if(txtCustomerCustomerCategoryCode.val()===""){
                                        txtCustomerCustomerCategoryCode.val("");
                                        txtCustomerCustomerCategoryName.val("");
                                        return;
                                    }
                                    var url = "master/customer-category-get";
                                    var params = "customerCategory.code=" + txtCustomerCustomerCategoryCode.val();
                                        params += "&customerCategory.activeStatus=true";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.customerCategoryTemp){
                                            txtCustomerCustomerCategoryCode.val(data.customerCategoryTemp.code);
                                            txtCustomerCustomerCategoryName.val(data.customerCategoryTemp.name);
                                        }
                                        else{
                                            alertMessage("Customer Category Not Found!",txtCustomerCustomerCategoryCode);
                                            txtCustomerCustomerCategoryCode.val("");
                                            txtCustomerCustomerCategoryName.val("");
                                        }
                                    });
                                });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customer.customerCategory.code" name="customer.customerCategory.code" title=" " required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                                        <sj:a id="customer_btnCustomerCategory" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                <s:textfield id="customer.customerCategory.name" name="customer.customerCategory.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Payment Term *</B></td>
                            <td>
                                <script type = "text/javascript">

                                txtCustomerPaymentTermCode.change(function(ev) {
                                    if(txtCustomerPaymentTermCode.val()===""){
                                        txtCustomerPaymentTermCode.val("");
                                        txtCustomerPaymentTermName.val("");
                                        return;
                                    }
                                    var url = "master/payment-term-get";
                                    var params = "paymentTerm.code=" + txtCustomerPaymentTermCode.val();
                                        params += "&paymentTerm.activeStatus=true";

                                    $.post(url, params, function(result) {
                                        var data = (result);
                                        if (data.paymentTermTemp){
                                            txtCustomerPaymentTermCode.val(data.paymentTermTemp.code);
                                            txtCustomerPaymentTermName.val(data.paymentTermTemp.name);
                                        }
                                        else{
                                            alertMessage("Payment Term Not Found!",txtCustomerPaymentTermCode);
                                            txtCustomerPaymentTermCode.val("");
                                            txtCustomerPaymentTermName.val("");
                                        }
                                    });
                                });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customer.paymentTerm.code" name="customer.paymentTerm.code" title=" " required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                                        <sj:a id="customer_btnPaymentTerm" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                <s:textfield id="customer.paymentTerm.name" name="customer.paymentTerm.name" size="25" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Tax Code *</B></td>
                            <td><s:textfield id="customer.taxCode" name="customer.taxCode" size="5" required="true" cssClass="required" cssStyle="text-align:right" maxLength="3"></s:textfield>&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="right"><B>Customer Status *</B>
                            <s:textfield id="customer.customerStatus" name="customer.customerStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="customer.customerStatus" name="customer.customerStatus" list="{'Yes','No'}"></s:radio></td>                    
                        </tr>
                        <tr>
                            <td align="right"><B>End User Status *</B>
                            <s:textfield id="customer.endUserStatus" name="customer.endUserStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="customer.endUserStatus" name="customer.endUserStatus" list="{'Yes','No'}"></s:radio></td>                    
                        </tr>
                        <tr>
                            <td align="right"><B>Active Status *</B>
                            <s:textfield id="customer.activeStatus" name="customer.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="customer.activeStatus" name="customer.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td>
                                <s:textarea id="customer.remark" name="customer.remark" rows="3" cols="40"></s:textarea>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">InActive By</td>
                            <td><s:textfield id="customer.inActiveBy"  name="customer.inActiveBy" size="20" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">InActive Date</td>
                            <td>
                                <sj:datepicker id="customer.inActiveDate" name="customer.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true" disabled="true"></sj:datepicker>
                                <sj:datepicker id="customer.inActiveDate" name="customer.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true" style="display:none"></sj:datepicker>
                            </td>
                        </tr>
                        <tr>
                            <td><s:textfield id="customer.createdBy"  name="customer.createdBy" size="20" style="display:none"></s:textfield></td>
                            <td><sj:datepicker id="customer.createdDate" name="customer.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus" style="display:none"></sj:datepicker></td>
                        </tr>
                        <tr hidden="true">
                            <td/>
                            <td colspan="2">
                                <s:textfield id="customerTemp.inActiveDateTemp" name="customerTemp.inActiveDateTemp" size="22"></s:textfield>
                                <s:textfield id="customerTemp.createdDateTemp" name="customerTemp.createdDateTemp" size="22"></s:textfield>
                            </td>
                        </tr>
                        <tr height="25">
                            <td></td>
                            <td>
                                <sj:a href="#" id="btnCustomerSave" button="true">Save</sj:a>
                                <sj:a href="#" id="btnCustomerCancel" button="true">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
                            
        </table>
    </s:form>
</div>