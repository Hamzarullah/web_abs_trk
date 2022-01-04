<%@page import="com.inkombizz.action.BaseSession"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<s:url id="remoteurlCustomer" action="customer-address-search-customer" />
<s:url id="remoteurlCustomerAddress" action="" />

<style>
    #customerAddress_grid_pager_center{
        display: none;
    }
</style>
<script type="text/javascript">
    var
            txtCustomerAddressCustomerCode = $("#customerAddress\\.customer\\.code"),
            txtCustomerAddressCustomerName = $("#customerAddress\\.customer\\.name"),
            txtCustomerAddressCustomerAddress = $("#customerAddress\\.customer\\.address"),
            txtCustomerAddressCustomerCityCode = $("#customerAddress\\.customer\\.city\\.code"),
            txtCustomerAddressCustomerCityName = $("#customerAddress\\.customer\\.city\\.name"),
            txtCustomerAddressCustomerCountryCode = $("#customerAddress\\.customer\\.city\\.province\\.island\\.country\\.code"),
            txtCustomerAddressCustomerCountryName = $("#customerAddress\\.customer\\.city\\.province\\.island\\.country\\.name"),
            txtCustomerAddressCustomerPhone1 = $("#customerAddress\\.customer\\.phone1"),
            txtCustomerAddressCustomerPhone2 = $("#customerAddress\\.customer\\.phone2"),
            txtCustomerAddressCustomerFax = $("#customerAddress\\.customer\\.fax"),
            txtCustomerAddressCustomerEmail = $("#customerAddress\\.customer\\.emailAddress"),
            txtCustomerAddressCustomerContactPerson = $("#customerAddress\\.customer\\.contactPerson"),
            txtCustomerAddressCode = $("#customerAddress\\.code"),
            txtCustomerAddressName = $("#customerAddress\\.name"),
            txtCustomerAddressRemark = $("#customerAddress\\.remark"),
            txtCustomerAddressAddress = $("#customerAddress\\.address"),
            txtCustomerAddressPhone1 = $("#customerAddress\\.phone1"),
            txtCustomerAddressPhone2 = $("#customerAddress\\.phone2"),
            txtCustomerAddressEmailAddress = $("#customerAddress\\.emailAddress"),
            txtCustomerAddressFax = $("#customerAddress\\.fax"),
            txtCustomerAddressContactPerson = $("#customerAddress\\.contactPerson"),
            txtCustomerAddressActiveStatus = $("#customerAddress\\.activeStatus"),
            txtCustomerAddressCityCode = $("#customerAddress\\.city\\.code"),
            txtCustomerAddressCityName = $("#customerAddress\\.city\\.name"),
            txtCustomerAddressCountryCode = $("#customerAddress\\.city\\.province\\.island\\.country\\.code"),
            txtCustomerAddressCountryName = $("#customerAddress\\.city\\.province\\.island\\.country\\.name"),
            txtCustomerAddressNPWP=$("#customerAddress\\.npwp"),
            txtCustomerAddressNPWPName=$("#customerAddress\\.npwpName"),
            txtCustomerAddressNPWPAddress=$("#customerAddress\\.npwpAddress"),
            txtCustomerAddressNPWPCityCode=$("#customerAddress\\.npwpCity\\.code"),
            txtCustomerAddressNPWPCityName=$("#customerAddress\\.npwpCity\\.name"),
            txtCustomerAddressNPWPProvinceCode=$("#customerAddress\\.npwpCity\\.province\\.code"),
            txtCustomerAddressNPWPProvinceName=$("#customerAddress\\.npwpCity\\.province\\.name"),
            txtCustomerAddressNPWPIslandCode=$("#customerAddress\\.npwpCity\\.province\\.island\\.code"),
            txtCustomerAddressNPWPIslandName=$("#customerAddress\\.npwpCity\\.province\\.island\\.name"),
            txtCustomerAddressNPWPCountryCode=$("#customerAddress\\.npwpCity\\.province\\.island\\.country\\.code"),
            txtCustomerAddressNPWPCountryName=$("#customerAddress\\.npwpCity\\.province\\.island\\.country\\.name"),
            txtCustomerAddressNPWPZipCode=$("#customerAddress\\.npwpZipCode"),
            txtCustomerAddressInActiveBy = $("#customerAddress\\.inActiveBy"),
            txtCustomerAddressInActiveDate = $("#customerAddress\\.inActiveDate"),
            txtCustomerAddressCreatedBy = $("#customerAddress\\.createdBy"),  
            txtCustomerAddressCreatedDate = $("#customerAddress\\.createdDate"),
            txtCustomerAddressShipToCode = $("#customerAddress\\.shipToStatus"),
            txtCustomerAddressBillToCode = $("#customerAddress\\.billToStatus"),
            
            allFieldsCustomerAddress = $([])
            .add(txtCustomerAddressCode)
            .add(txtCustomerAddressName)
            .add(txtCustomerAddressRemark)
            .add(txtCustomerAddressAddress)
            .add(txtCustomerAddressPhone1)
            .add(txtCustomerAddressPhone2)
            .add(txtCustomerAddressEmailAddress)
            .add(txtCustomerAddressFax)
            .add(txtCustomerAddressActiveStatus)
            .add(txtCustomerAddressShipToCode)
            .add(txtCustomerAddressBillToCode)
            .add(txtCustomerAddressCityCode)
            .add(txtCustomerAddressCityName)
            .add(txtCustomerAddressCountryCode)
            .add(txtCustomerAddressCountryName)
            .add(txtCustomerAddressNPWP)
            .add(txtCustomerAddressNPWPName)
            .add(txtCustomerAddressNPWPAddress)
            .add(txtCustomerAddressNPWPCityCode)
            .add(txtCustomerAddressNPWPCityName)
            .add(txtCustomerAddressNPWPProvinceCode)
            .add(txtCustomerAddressNPWPProvinceName)
            .add(txtCustomerAddressNPWPIslandCode)
            .add(txtCustomerAddressNPWPIslandName)
            .add(txtCustomerAddressNPWPCountryCode)
            .add(txtCustomerAddressNPWPCountryName)
            .add(txtCustomerAddressNPWPZipCode)
            .add(txtCustomerAddressInActiveBy)
            .add(txtCustomerAddressInActiveDate);
            

    function reloadGridCustomerAddress() {
        $("#customerAddress_grid").trigger("reloadGrid");
    };

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("customerAddress");
         $('#customerAddress\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $.subscribe("customer_grid_onSelect", function(event, data){
            var selectedRowID = $("#customerHeader_grid").jqGrid("getGridParam", "selrow"); 
            var customerHeader = $("#customerHeader_grid").jqGrid("getRowData", selectedRowID);
           
            $("#customerAddress_grid").jqGrid("setGridParam",{url:"master/customer-address-reload?customer.code=" + customerHeader.code});
            $("#customerAddress_grid").jqGrid("setCaption", "Customer Address : " + customerHeader.code);
            $("#customerAddress_grid").trigger("reloadGrid");
            
            $("#customer\\.code").val(customerHeader.code);
        });

        $('#searchCustomerAddressActiveStatusRADActive').prop('checked',true);
        $("#searchCustomerAddressStatus").val("yes");
        
        $('input[name="searchCustomerAddressActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchCustomerAddressStatus").val(value);
        });
        
        $('input[name="searchCustomerAddressActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchCustomerAddressStatus").val(value);
        });
                
        $('input[name="searchCustomerAddressActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchCustomerAddressStatus").val(value);
        });
        
        $('#customerAddressStatusActive').change(function (ev) {
            var value = "true";
            $("#customerAddress\\.activeStatus").val(value);
        });

        $('#customerAddressStatusInActive').change(function (ev) {
            var value = "false";
            $("#customerAddress\\.activeStatus").val(value);
        });
        
        $('#customerAddressStatusActive').change(function (ev) {
            var value = "true";
            $("#customerAddress\\.npwpStatus").val(value);
        });
        
        $('#customerAddressNpwpStatusYes').change(function (ev) {
      //      alert("koko");
            $("#customerAddress\\.npwpStatus").val(true);npwp_format();
            txtCustomerAddressNPWP.attr("readonly",false);
            txtCustomerAddressNPWP.val("");
            $("#customerAddress\\.npwpName").val();npwp_format();
            txtCustomerAddressNPWPName.attr("readonly",false);
            
            $("#customerAddress\\.npwpAddress").val();npwp_format();
            txtCustomerAddressNPWPAddress.attr("readonly",false);
            
            $("#customerAddress\\.customer\\.npwpZipCode").val();npwp_format();
            txtCustomerAddressNPWPZipCode.attr("readonly",false);
            
            $("#customerAddress\\.npwpCity\\.code").val();npwp_format();
            txtCustomerAddressNPWPCityCode.attr("readonly",false);
            $("#customerAddress_btnNPWPCity").show();
        });
        $('#customerAddressNpwpStatusNo').change(function (ev) {
            $("#customerAddress\\.npwpStatus").val(false);
            txtCustomerAddressNPWP.attr("readonly",true);
       
            $("#customerAddress\\.npwpName").val();
            txtCustomerAddressNPWPName.attr("readonly",true);
            
            $("#customerAddress\\.npwpAddress").val();
            txtCustomerAddressNPWPAddress.attr("readonly",true);
            
            $("#customerAddress\\.customer\\.npwpZipCode").val();
            txtCustomerAddressNPWPZipCode.attr("readonly",true);
            
            $("#customerAddress\\.npwpCity\\.code").val();
            txtCustomerAddressNPWPCityCode.attr("readonly",true);
            $("#customerAddress_btnNPWPCity").hide();
            
        });

        $('#customerAddressStatusActive').change(function (ev) {
            var value = "false";
            $("#customerAddress\\.npwpStatus").val(value);
        });
        
         $('#customerAddressBillToStatus').click(function(){
            if($('#customerAddressBillToStatus').is(':checked')){
                var value="true";
                $("#customerAddress\\.billToStatus").val(value);
            }
            if(!$('#customerAddressBillToStatus').is(':checked')){
                var value="false";
                $("#customerAddress\\.billToStatus").val(value);
            }
        });
        
        $('#customerAddressShipToStatus').click(function(){
            if($('#customerAddressShipToStatus').is(':checked')){
                var value="true";
                $("#customerAddress\\.shipToStatus").val(value);
            }
            if(!$('#customerAddressShipToStatus').is(':checked')){
                var value="false";
                $("#customerAddress\\.shipToStatus").val(value);
            }
        });

        $("#btnCustomerAddressNew").click(function (ev) {
            
            $('#customerAddressNpwpStatusYes').prop('checked',true);
            $("#customerAddress\\.npwpStatus").val(false);
            
            var urlPeriodClosing="security/data-protection-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/customer-address-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    
                    var selectedRowId = $("#customerHeader_grid").jqGrid("getGridParam", "selrow");
                    if (selectedRowId == null) {
                        alert("Please Select Row Customer");
                        return;
                    }
                    
                    allFieldsCustomerAddress.val('').removeClass('ui-state-error');
                    var customer = $("#customerHeader_grid").jqGrid('getRowData', selectedRowId);

                    showInput("customerAddress");
                    $(".data-view").hide();
//                    $("#frmCustomerAddressSearchInput").hide();
                     txtCustomerAddressCode.attr("readonly", false);

                    $('#customerAddressStatusActive').prop('checked',true);
                    $("#customerAddressStatus").val("yes");

                    $("#customerAddressNpwpStatusYes").prop('checked', true);
                    $("#customerAddress\\.npwpStatus").val(true);

                    $("#customerAddressShipToStatus").prop('checked', false);
                    var value = "false";
                    $("#customerAddress\\.shipToCode").val(value);

                    $("#customerAddressBillToStatus").prop('checked', false);
                    var value = "false";
                    $("#customerAddress\\.billToCode").val(value);

                    $("#customerAddress\\.inActiveDate").val("01/01/1900");

                    
                    $("#customerAddress\\.customer\\.code").attr("readonly", true);
                    $("#customerAddress\\.code").attr("readonly", true);
                    $("#customerAddress\\.customer\\.address").attr("readonly", true);
                    $("#customerAddress\\.code").val("AUTO");
                    
                    $("#customerAddress\\.npwp").attr("readonly", false);
                    $("#customerAddress\\.npwpName").attr("readonly", false);
                    $("#customerAddress\\.npwpAddress").attr("readonly", false);
                    $("#customerAddress\\.customer.npwpZipCode").attr("readonly", false);
                    $("#customerAddress\\.npwpCity.code").attr("readonly", false);
                    
                    var url = "master/customer-get";
                    var params = "customer.code=" + customer.code;
                    params += "&customer.activeStatus=TRUE";
                    params += "&customer.customerStatus=TRUE";
                    
                    $.post(url, params, function (result) {
                        var data = (result);

                        $("#customerAddress\\.customer\\.code").val(data.customerTemp.code);
                        $("#customerAddress\\.customer\\.name").val(data.customerTemp.name);
                        $("#customerAddress\\.customer\\.address").val(data.customerTemp.address);
                        $("#customerAddress\\.customer\\.city\\.code").val(data.customerTemp.cityCode);
                        $("#customerAddress\\.customer\\.city\\.name").val(data.customerTemp.cityName);
                        $("#customerAddress\\.customer\\.city\\.province\\.island\\.country\\.code").val(data.customerTemp.countryCode);
                        $("#customerAddress\\.customer\\.city\\.province\\.island\\.country\\.name").val(data.customerTemp.countryName);
                        $("#customerAddress\\.customer\\.phone1").val(data.customerTemp.phone1);
                        $("#customerAddress\\.customer\\.phone2").val(data.customerTemp.phone2);
                        $("#customerAddress\\.customer\\.fax").val(data.customerTemp.fax);
                        $("#customerAddress\\.customer\\.email").val(data.customerTemp.email);
                        $("#customerAddress\\.customer\\.category\\.code").val(data.customerTemp.customerCategoryCode);
                        $("#customerAddress\\.customer\\.category\\.name").val(data.customerTemp.customerCategoryName);
                        $("#customerAddress\\.customer\\.contactPerson").val(data.customerTemp.contactPerson);
                    });
                    updateRowId = -1;
                    ev.preventDefault();
                });
            });
        });

        $("#btnCustomerAddressUpdate").click(function (ev) {
             var urlPeriodClosing="security/data-protection-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/customer-address-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId=$("#customerAddress_grid").jqGrid("getGridParam","selrow");

                   if(updateRowId===null){
                       alertMessage("Please Select Row Customer Address!");
                       return;
                   }

                   $("#customerAddress_btnPriceType").hide();
                   $("#ui-icon-search-customer-address-price-type").hide();
                   
                   loadCustomer();
                   
                   var customerAddress=$("#customerAddress_grid").jqGrid('getRowData',updateRowId);
                   var url="master/customer-address-find-one-data";
                   var params="code=" + customerAddress.code;
                   
                   txtCustomerAddressCode.attr("readonly",true);

                   $.post(url,params,function (result){
                       var data=(result);
                        txtCustomerAddressCode.val(data.customerAddressTemp.code);
                        txtCustomerAddressName.val(data.customerAddressTemp.name);
                        txtCustomerAddressAddress.val(data.customerAddressTemp.address);
                        txtCustomerAddressRemark.val(data.customerAddressTemp.remark);
                        txtCustomerAddressPhone1.val(data.customerAddressTemp.phone1);
                        txtCustomerAddressPhone2.val(data.customerAddressTemp.phone2);
                        txtCustomerAddressEmailAddress.val(data.customerAddressTemp.emailAddress);
                        txtCustomerAddressContactPerson.val(data.customerAddressTemp.contactPerson);
                        txtCustomerAddressFax.val(data.customerAddressTemp.fax);
                        txtCustomerAddressActiveStatus.val(data.customerAddressTemp.activeStatus);
                        txtCustomerAddressCityCode.val(data.customerAddressTemp.cityCode);
                        txtCustomerAddressCityName.val(data.customerAddressTemp.cityName);
                        txtCustomerAddressCreatedBy.val(data.customerAddressTemp.createdBy);
                        txtCustomerAddressCreatedDate.val(data.customerAddressTemp.createdDate);
                        txtCustomerAddressCountryCode.val(data.customerAddressTemp.countryCode);
                        txtCustomerAddressCountryName.val(data.customerAddressTemp.countryName);
                        txtCustomerAddressNPWP.val(data.customerAddressTemp.npwp);
                        txtCustomerAddressNPWPName.val(data.customerAddressTemp.npwpName);
                        txtCustomerAddressNPWPAddress.val(data.customerAddressTemp.npwpAddress);
                        txtCustomerAddressNPWPZipCode.val(data.customerAddressTemp.npwpZipCode);
                        txtCustomerAddressNPWPCityCode.val(data.customerAddressTemp.npwpCityCode);
                        txtCustomerAddressNPWPCityName.val(data.customerAddressTemp.npwpCityName);
                        txtCustomerAddressNPWPProvinceCode.val(data.customerAddressTemp.npwpProvinceCode);
                        txtCustomerAddressNPWPProvinceName.val(data.customerAddressTemp.npwpProvinceName);
                        txtCustomerAddressNPWPIslandCode.val(data.customerAddressTemp.npwpIslandCode);
                        txtCustomerAddressNPWPIslandName.val(data.customerAddressTemp.npwpIslandName);
                        txtCustomerAddressNPWPCountryCode.val(data.customerAddressTemp.npwpCountryCode);
                        txtCustomerAddressNPWPCountryName.val(data.customerAddressTemp.npwpCountryName);
                        txtCustomerAddressInActiveBy.val(data.customerAddressTemp.inActiveBy); 
                        txtCustomerAddressInActiveDate.val(formatDateRemoveT(data.customerAddressTemp.inActiveDate,true));
                        
                        if(data.customerAddressTemp.npwpStatus===true) {
                            $('#customerAddressNpwpStatusYes').prop('checked',true);
                            $("#customerAddress\\.npwpStatus").val(true);
                            txtCustomerAddressNPWP.attr("readonly",false);
                            npwp_format();
                        }
                        else {                        
                            $('#customerAddressNpwpStatusNo').prop('checked',true);
                            $("#customerAddress\\.npwpStatus").val(false);
                            txtCustomerAddressNPWP.attr("readonly",true);
                            npwp_format();
                            
                            $("#customerAddress\\.npwpStatus").val(false);npwp_format();
                            txtCustomerAddressNPWP.attr("readonly",true);

                            $("#customerAddress\\.npwpName").val();npwp_format();
                            txtCustomerAddressNPWPName.attr("readonly",true);

                            $("#customerAddress\\.npwpAddress").val();npwp_format();
                            txtCustomerAddressNPWPAddress.attr("readonly",true);

                            $("#customerAddress\\.customer\\.npwpZipCode").val();npwp_format();
                            txtCustomerAddressNPWPZipCode.attr("readonly",true);

                            $("#customerAddress\\.npwpCity\\.code").val();npwp_format();
                            txtCustomerAddressNPWPCityCode.attr("readonly",true);
                            $("#customerAddress_btnNPWPCity").hide();
                        }
                        
                        if(data.customerAddressTemp.activeStatus===true) {
                           $('#customerAddress\\.activeStatusActive').prop('checked',true);
                           $("#customerAddress\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#customerAddress\\.activeStatusInActive').prop('checked',true);              
                           $("#customerAddress\\.activeStatus").val("false");
                        }

                        if(data.customerAddressTemp.shipToStatus===true) {
                           $('#customerAddressShipToStatus').prop('checked',true);
                           $("#customerAddress\\.shipToStatus").val("true");
                        }
                        else {                        
                           $('#customerAddressShipToStatus').prop('checked',false);              
                           $("#customerAddress\\.shipToStatus").val("false");
                        }

                        if(data.customerAddressTemp.billToStatus===true) {
                           $('#customerAddressBillToStatus').prop('checked',true);
                           $("#customerAddress\\.billToStatus").val("true");
                        }

                        showInput("customerAddress");
                        $(".data-view").hide();
                   });
                });
            });
        });

        $('#btnCustomerAddressDelete').click(function (ev) {
            var urlPeriodClosing="security/data-protection-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/customer-address-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#customerAddress_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var customerAddress = $("#customerAddress_grid").jqGrid('getRowData', deleteRowId);

                        if (confirm("Are You Sure To Delete (Code : " + customerAddress.code + ")")) {
                            var url = "master/customer-address-delete";
                            var params = "customerAddress.code=" + customerAddress.code;

                            $.post(url, params, function (result) {
                                var data=(result);
                                if (data.error) {
                                    alertMessage(data.errorMessage);
                                    return;
                                }
                                reloadGridCustomerAddress();
                            });
                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnCustomerAddressSave").click(function (ev) {
            if (!$("#frmCustomerAddressInput").valid()) {
                ev.preventDefault();
                return;
            }
            npwp_format();

            var url = "";

            var params = $("#frmCustomerAddressInput").serialize();

            if (updateRowId < 0) {
                url = "master/customer-address-save";
            } else {
                url = "master/customer-address-update";
                //params += "&customerAddress.code="+ txtCustomerAddressCode.val();
            }
            
            //alert("Param : " + params);

            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("customerAddress");
                $(".data-view").show();
                allFieldsCustomerAddress.val('').siblings('label[class="error"]').hide();
                reloadGridCustomerAddress();
            });
            ev.preventDefault();
      
        });


        $("#btnCustomerAddressCancel").click(function (ev) {
            hideInput("customerAddress");
            $(".data-view").show();
            allFieldsCustomerAddress.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnCustomerAddressRefresh').click(function (ev) {
            
            var url = "master/customer-address";
            var params = "";
            pageLoad(url, params, "#tabmnuCUSTOMER_ADDRESS");
            
        });
        
        $("#btnCustomerAddressPrint").click(function(ev) {
            
            var status=$('#customerAddressSearchActiveStatus').val();
            
            var url = "reports/customer-address-print-out-pdf?";
            var params = "activeStatus="+status;
              
            window.open(url+params,'customerAddress','width=500,height=500');
        });
        
        $("#btnCustomerAddress_search").click(function(ev) {
            $("#customerHeader_grid").jqGrid("setGridParam",{url:"master/customer-address-search-customer?" + $("#frmCustomerAddressSearchInput").serialize(), page:1});
            $("#customerHeader_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnCustomerAddressDetail_search").click(function(ev) {
            $("#customerAddress_grid").jqGrid("setGridParam",{url:"master/customer-address-search-customer-detail?" + $("#frmCustomerAddressDetailSearchInput").serialize(), page:1});
            $("#customerAddress_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
    });
    
    function loadCustomer(){
        
        var updateRowId=$("#customerHeader_grid").jqGrid("getGridParam","selrow");
        var customer=$("#customerHeader_grid").jqGrid('getRowData',updateRowId);
//        alert(customer.code);
        
        var url="master/customer-get";
        var params ="customer.code=" + customer.code;
            params += "&customer.activeStatus=TRUE";
            params += "&customer.customerStatus=TRUE";

        $.post(url,params,function (result){
            var data=(result);
            txtCustomerAddressCustomerCode.val(data.customerTemp.code);
            txtCustomerAddressCustomerName.val(data.customerTemp.name);
            txtCustomerAddressCustomerAddress.val(data.customerTemp.address);
            txtCustomerAddressCustomerCityCode.val(data.customerTemp.cityCode);
            txtCustomerAddressCustomerCityName.val(data.customerTemp.cityName);
            txtCustomerAddressCustomerCountryCode.val(data.customerTemp.countryCode);
            txtCustomerAddressCustomerCountryName.val(data.customerTemp.countryName);
            txtCustomerAddressCustomerPhone1.val(data.customerTemp.phone1);
            txtCustomerAddressCustomerPhone2.val(data.customerTemp.phone2);
            txtCustomerAddressCustomerFax.val(data.customerTemp.fax);
            txtCustomerAddressCustomerEmail.val(data.customerTemp.emailAddress);
            txtCustomerAddressCustomerContactPerson.val(data.customerTemp.contactPerson);
            
         });
    }
</script>

<b>CUSTOMER ADDRESS</b>
<hr>
<div class="data-view content ui-widget">
    <s:form id="frmCustomerAddressSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="customerSearchCode" name="customerSearchCode" size="30" placeHolder=" Code"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="customerSearchName" name="customerSearchName" size="30" placeHolder=" Name"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Status
                    <s:textfield id="customerSearchActiveStatus" name="customerSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchCustomerAddressActiveStatusRAD" name="searchCustomerAddressActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>                
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnCustomerAddress_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
    <br class="spacer" />
    <div class="data-view">
        <sjg:grid
            id="customerHeader_grid"
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
            onSelectRowTopics="customer_grid_onSelect"
            width="$('#tabmnuCustomerAddress').width()"
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
                name="countryCode" index="countryCode" key="countryCode" title="Country Code" width="80" sortable="true"
            />
            <sjg:gridColumn
                name="countryName" index="countryName" key="countryName" title="Country Name" width="150" sortable="true"
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
                name="emailAddress" index="emailAddress" key="emailAddress" title="EmailAddress Address" width="250" sortable="true"
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
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
            />
        </sjg:grid >
    </div>
    <div class="data-view">
        <hr/>
        <sj:div id="customerAddressButton" cssClass="ikb-buttonset ikb-buttonset-single">
            <table>
                <tr>
                    <td><a href="#" id="btnCustomerAddressNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                    </td>
                    <td><a href="#" id="btnCustomerAddressUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                    </td>
                    <td><a href="#" id="btnCustomerAddressDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                    </td>
                    <td> <a href="#" id="btnCustomerAddressRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                    </td>
                    <td><a href="#" id="btnCustomerAddressPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                    </td>  
                </tr>

            </table>
        </sj:div>     
    </div>
    <br class="spacer" />
    <br class="spacer" />
    <div class="data-view content ui-widget">
        <s:form id="frmCustomerAddressDetailSearchInput">
            <table>
                <tr>
                    <td align="right" valign="center">Code</td>
                    <td>
                        <s:textfield id="customer.code" name="customer.code" size="30" placeHolder=" Code" style="display:none;"></s:textfield>
                        <s:textfield id="searchCustomerAddressDetailCode" name="searchCustomerAddressDetailCode" size="30" placeHolder=" Code"></s:textfield>
                    </td>
                    <td align="right" valign="centre">Customer Address Island</td>
                    <td>
                        <s:textfield id="searchCustomerAddresDetailAddressCode" name="searchCustomerAddresDetailAddressCode" size="30" placeHolder=" Island Code"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="center">Name</td>
                    <td>
                        <s:textfield id="searchCustomerAddressDetailName" name="searchCustomerAddressDetailName" size="30" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
            </table>
            <br/>
            <sj:a href="#" id="btnCustomerAddressDetail_search" button="true">Search</sj:a>
            <br/>
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
            </div>
        </s:form>
    </div> 
    <br class="spacer" />
    <div class="data-view">
        <sjg:grid
            id="customerAddress_grid"
            caption="CUSTOMER ADDRESS"
            dataType="json"
            href="%{remoteurlCustomerAddress}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listCustomerAddressTemp"
            rowNum="10000"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuCustomerAddress').width()"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="150" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="300" sortable="false"
            /> 
            <sjg:gridColumn
                name="customerCode" index="customerCode" title="Customer Code" width="200" sortable="false"
            />  
            <sjg:gridColumn
                name="customerName" index="customerName" title="Customer Name" width="300" sortable="false"
            />  
            <sjg:gridColumn
                name="address" index="address" title="Address" width="300" sortable="false"
            /> 
            <sjg:gridColumn
                name="cityCode" index="cityCode" title="City Code" width="100" sortable="false"
            />
            <sjg:gridColumn
                name="cityName" index="cityName" title="City Name" width="250" sortable="false"
            />
            <sjg:gridColumn
                name="countryCode" index="countryCode" title="Country Code" width="100" sortable="false"
            />
            <sjg:gridColumn
                name="countryName" index="countryName" title="Country Name" width="250" sortable="false"
            />
            <sjg:gridColumn
                name="zipCode" index="zipCode" title="Zip Code" width="150" sortable="false"
            />
            <sjg:gridColumn
                name="phone1" index="phone1" title="Phone 1" width="150" sortable="false"
            />
            <sjg:gridColumn
                name="phone2" index="phone2" title="Phone 2" width="150" sortable="false"
            />
            <sjg:gridColumn
                name="fax" index="fax" title="Fax" width="150" sortable="false"
            />
            <sjg:gridColumn
                name="emailAddress" index="emailAddress" title="Email" width="250" sortable="false"
            />
            <sjg:gridColumn
                name="npwpName" index="npwpName" key="npwpName" title="NPWP Name" width="100" sortable="true"
            /> 
            <sjg:gridColumn
                name="npwpAddress" index="npwpAddress" key="npwpAddress" title="NPWP Address" width="100" sortable="true"
            /> 
            <sjg:gridColumn
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />   
        </sjg:grid >
    </div>
</div>   

<div id="customerAddressInput" class="content ui-widget">
    <s:form id="frmCustomerAddressInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td style="vertical-align: text-bottom;">
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><B>Customer Code *</B></td>
                            <td><s:textfield id="customerAddress.customer.code" name="customerAddress.customer.code" size="20" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Name *</B></td>
                            <td><s:textfield id="customerAddress.customer.name" name="customerAddress.customer.name" size="40" title="*" required="true" cssClass="required" maxLength="95" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Address *</B></td>
                            <td><s:textarea id="customerAddress.customer.address" name="customerAddress.customer.address" rows="3" cols="40"  title="*" readonly="true"></s:textarea> </td>
                        </tr>
                        <tr>
                            <td align="right"><B>City *</B></td>
                            <td>
                                <s:textfield id="customerAddress.customer.city.code" name="customerAddress.customer.city.code" title="*" required="true" cssClass="required" maxLength="45" size="20" readonly="true"></s:textfield>
                                <s:textfield id="customerAddress.customer.city.name" name="customerAddress.customer.city.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Country</td>
                            <td>
                                <s:textfield id="customerAddress.customer.city.province.island.country.code" name="customerAddress.customer.city.province.island.country.code" size="20" maxLength="45" readonly="true"></s:textfield>
                                <s:textfield id="customerAddress.customer.city.province.island.country.name" name="customerAddress.customer.city.province.island.country.name" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Phone 1 *</B></td>
                            <td>
                                <s:textfield id="customerAddress.customer.phone1" name="customerAddress.customer.phone1" size="20" title="*" required="true" cssClass="required" maxLength="45" readonly="true"></s:textfield>
                                Phone 2 
                                <s:textfield id="customerAddress.customer.phone2" name="customerAddress.customer.phone2" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Fax</td>
                            <td>
                                <s:textfield id="customerAddress.customer.fax" name="customerAddress.customer.fax" size="20" maxLength="45" readonly="true"></s:textfield>
                                Email
                                <s:textfield id="customerAddress.customer.emailAddress" name="customerAddress.customer.emailAddress" size="20" maxLength="45" readonly="true"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Contact Person </td>
                            <td><s:textfield id="customerAddress.customer.contactPerson" name="customerAddress.customer.contactPerson" size="40" maxLength="45" readonly="true"></s:textfield></td>
                        </tr>
                         <tr>
                            <td align="right"><B>Active Status *</B>
                            <s:textfield id="customerAddress.activeStatus" name="customerAddress.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="customerAddress.activeStatus" name="customerAddress.activeStatus" list="{'Active','InActive'}" disabled="true"></s:radio></td>                    
                        </tr>
                    </table>
                </td>
                <td>
                    <table cellpadding="2" cellspacing="2" >
                        <tr>
                            <td align="right"><B>Customer Address Code *</B></td>
                            <td><s:textfield id="customerAddress.code" name="customerAddress.code" size="30" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Name *</B></td>
                            <td><s:textfield id="customerAddress.name" name="customerAddress.name" size="40" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>Address *</B></td>
                            <td><s:textarea id="customerAddress.address" name="customerAddress.address" rows="3" cols="45" title="*" required="true" cssClass="required" ></s:textarea> </td>
                        </tr>
                        <tr>
                            <td align="right"><B>City *</B></td>
                            <td>
                                <script type = "text/javascript">
                                $('#customerAddress_btnCity').click(function (ev) {
                                   window.open("./pages/search/search-city.jsp?iddoc=customerAddress&idsubdoc=city","Search", "scrollbars=1, width=600, height=500");
                                });
                                txtCustomerAddressCityCode.change(function(ev) {

                                        if(txtCustomerAddressCityCode.val()===""){
                                            txtCustomerAddressCityCode.val("");
                                            txtCustomerAddressCityName.val("");
                                            txtCustomerAddressCountryCode.val("");
                                            txtCustomerAddressCountryName.val("");
                                            return;
                                        }
                                        var url = "master/city-get";
                                        var params = "city.code=" + txtCustomerAddressCityCode.val();
                                            params += "&city.activeStatus=TRUE";
                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.cityTemp){
                                                txtCustomerAddressCityCode.val(data.cityTemp.code);
                                                txtCustomerAddressCityName.val(data.cityTemp.name);
                                                txtCustomerAddressCountryCode.val(data.cityTemp.provinceCountryCode);
                                                txtCustomerAddressCountryName.val(data.cityTemp.provinceCountryName);
                                            }
                                            else{
                                                alertMessage("City Not Found!",txtCustomerAddressCityCode);
                                                txtCustomerAddressCityCode.val("");
                                                txtCustomerAddressCityName.val("");
                                                txtCustomerAddressCountryCode.val("");
                                                txtCustomerAddressCountryName.val("");
                                            }
                                        });
                                    });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customerAddress.city.code" name="customerAddress.city.code" title="*" required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                                        <sj:a id="customerAddress_btnCity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="customerAddress.city.name" name="customerAddress.city.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">Country</td>
                            <td>
                                <s:textfield id="customerAddress.city.province.island.country.code" name="customerAddress.city.province.island.country.code" size="20" readonly="true"></s:textfield>
                                <s:textfield id="customerAddress.city.province.island.country.name" name="customerAddress.city.province.island.country.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Phone 1 *</B></td>
                            <td><s:textfield id="customerAddress.phone1" name="customerAddress.phone1" size="20" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                            &nbsp;&nbsp;Phone 2
                            <s:textfield id="customerAddress.phone2" name="customerAddress.phone2" size="20" maxLength="45"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right"><B>Fax *</B></td>
                            <td><s:textfield id="customerAddress.fax" name="customerAddress.fax" size="20" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Email
                            <s:textfield id="customerAddress.emailAddress" name="customerAddress.emailAddress" size="20" maxLength="45"></s:textfield>
                        </tr>
                        <tr>
                            <td align="right">Contact Person</td>
                            <td><s:textfield id="customerAddress.contactPerson" name="customerAddress.contactPerson" size="40" maxLength="45"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>Ship To Status *</B></td>
                            <td colspan="2">
                                <s:checkbox id="customerAddressShipToStatus" name="customerAddressShipToStatus" value="false"></s:checkbox>
                                <s:textfield id="customerAddress.shipToStatus" name="customerAddress.shipToStatus" size="5" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>Bill To Status *</B></td>
                            <td>
                                <s:checkbox id="customerAddressBillToStatus" name="customerAddressBillToStatus" value="false"></s:checkbox>
                                <s:textfield id="customerAddress.billToStatus" name="customerAddress.billToStatus" size="5" cssStyle="display:none"></s:textfield>
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><B>NPWP Status *</B>
                            <s:textfield id="customerAddress.npwpStatus" name="customerAddress.npwpStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                            <td><s:radio id="customerAddressNpwpStatus" name="customerAddressNpwpStatus" list="{'Yes','No'}"></s:radio></td>                    
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>NPWP *</B></td>
                            <td colspan="3">
                                <s:textfield onchange="npwp_format()" id="customerAddress.npwp" name="customerAddress.npwp" ></s:textfield>
                            </td>
                        </tr> 
                        <tr>
                            <td align="right" valign="top"><B>NPWPName *</B></td>
                            <td colspan="3">
                                <s:textarea id="customerAddress.npwpName" name="customerAddress.npwpName"  cols="47" rows="2" height="20"></s:textarea>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top"><B>NPWP Address *</B></td>
                            <td><s:textarea id="customerAddress.npwpAddress" name="customerAddress.npwpAddress" rows="3" cols="40"  title="*" readonly="false"></s:textarea> </td>
                        </tr>
                         <tr>
                            <td align="right"><B>Npwp Zip Code </B></td>
                            <td><s:textfield id="customerAddress.npwpZipCode" name="customerAddress.npwpZipCode" size="40" maxLength="45" readonly="false"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right"><B>NPWP City *</B></td>
                            <td>
                                <script type = "text/javascript">
                                function npwp_format(){
                                    //00.000.000.0-000.000
                                    $(".tooltip-message").remove();
                                    if(txtCustomerAddressNPWP.val()!==""||txtCustomerAddressNPWP.val()==="00.000.000.0-000.000"){
                                        var regex = new RegExp("([0]{2})?[.]([0]{3})?[.]([0]{3})?[.]([0]{1})[-]([0]{3})?[.]([0]{3})");
                                        
//                                        alert(regex.test(txtCustomerAddressNPWP.val()));
                                        if(regex.test(txtCustomerAddressNPWP.val()) || txtCustomerAddressNPWP.val().length !== 20 ) {
                                            txtCustomerAddressNPWP.css("color","red");
                                            txtCustomerAddressNPWP.after('<i class="tooltip-message" style="color:red;">00.000.000.0-000.000</i>');
       //                                   alertMessage("Format NNPWP Salah"+txtCustomerAddressNPWP.val(),txtCustomerAddressNPWP);
                                            return;
                                        }else{
                                                txtCustomerAddressNPWP.removeAttr("style");
                                            if($("#customerAddress\\.npwpStatus").val() === "false"){
                                              txtCustomerAddressNPWP.removeAttr("style");
                                            }
                                        }
                                    }
                                };
                                $('#customerAddress_btnNPWPCity').click(function (ev) {
                                   window.open("./pages/search/search-city.jsp?iddoc=customerAddress&idsubdoc=npwpCity","Search", "scrollbars=1, width=600, height=500");
                                });
                                    txtCustomerAddressNPWPCityCode.change(function(ev) {
                                        if(txtCustomerAddressNPWPCityCode.val()===""){
                                            txtCustomerAddressNPWPCityCode.val("");
                                            txtCustomerAddressNPWPCityName.val("");
                                            txtCustomerAddressNPWPProvinceCode.val("");
                                            txtCustomerAddressNPWPProvinceName.val("");
                                            txtCustomerAddressNPWPIslandCode.val("");
                                            txtCustomerAddressNPWPIslandName.val("");
                                            txtCustomerAddressNPWPCountryCode.val("");
                                            txtCustomerAddressNPWPCountryName.val("");
                                            return;
                                        }
                                        var url = "master/city-get";
                                        var params = "city.code=" + txtCustomerAddressNPWPCityCode.val();
                                            params += "&city.activeStatus=TRUE";
                                        $.post(url, params, function(result) {
                                            var data = (result);
                                            if (data.cityTemp){
                                                txtCustomerAddressNPWPCityCode.val(data.cityTemp.code);
                                                txtCustomerAddressNPWPCityName.val(data.cityTemp.name);
                                                txtCustomerAddressNPWPProvinceCode.val(data.cityTemp.provinceCode);
                                                txtCustomerAddressNPWPProvinceName.val(data.cityTemp.provinceName);
                                                txtCustomerAddressNPWPIslandCode.val(data.cityTemp.islandCode);
                                                txtCustomerAddressNPWPIslandName.val(data.cityTemp.islandName);
                                                txtCustomerAddressNPWPCountryCode.val(data.cityTemp.provinceCountryCode);
                                                txtCustomerAddressNPWPCountryName.val(data.cityTemp.provinceCountryName);
                                            }
                                            else{
                                                alertMessage("City Not Found!",txtCustomerAddressNPWPCityCode);
                                                txtCustomerAddressNPWPCityCode.val("");
                                                txtCustomerAddressNPWPCityName.val("");
                                                txtCustomerAddressNPWPProvinceCode.val("");
                                                txtCustomerAddressNPWPProvinceName.val("");
                                                txtCustomerAddressNPWPIslandCode.val("");
                                                txtCustomerAddressNPWPIslandName.val("");
                                                txtCustomerAddressNPWPCountryCode.val("");
                                                txtCustomerAddressNPWPCountryName.val("");
                                            }
                                        });
                                    });

                                </script>
                                    <div class="searchbox ui-widget-header">
                                        <s:textfield id="customerAddress.npwpCity.code" name="customerAddress.npwpCity.code" title="*" maxLength="45" size="20"></s:textfield>
                                        <sj:a id="customerAddress_btnNPWPCity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                                    </div>
                                        <s:textfield id="customerAddress.npwpCity.name" name="customerAddress.npwpCity.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">NPWP Province</td>
                            <td>
                                <s:textfield id="customerAddress.npwpCity.province.code" name="customerAddress.npwpCity.province.code" size="20" readonly="true"></s:textfield>
                                <s:textfield id="customerAddress.npwpCity.province.name" name="customerAddress.npwpCity.province.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right">NPWP Country</td>
                            <td>
                                <s:textfield id="customerAddress.npwpCity.province.island.country.code" name="customerAddress.npwpCity.province.island.country.code" size="20" readonly="true"></s:textfield>
                                <s:textfield id="customerAddress.npwpCity.province.island.country.name" name="customerAddress.npwpCity.province.island.country.name" size="20" readonly="true"></s:textfield> 
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="top">Remark</td>
                            <td colspan="3">
                                <s:textarea id="customerAddress.remark" name="customerAddress.remark"  cols="47" rows="2" height="20"></s:textarea>
                            </td>
                        </tr> 
                        <tr>
                            <td align="right">InActive By</td>
                            <td><s:textfield id="customerAddress.inActiveBy"  name="customerAddress.inActiveBy" size="20" readonly="true"></s:textfield></td>
                        </tr>
                        <tr>
                            <td align="right">InActive Date</td>
                            <td>
                                <sj:datepicker id="customerAddress.inActiveDate" name="customerAddress.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true" changeYear="true" changeMonth="true" disabled="true"></sj:datepicker>
                            </td>
                        </tr>

                        <tr>
                            <td><s:textfield id="customerAddress.createdBy"  name="customerAddress.createdBy" size="20" style="display:none"></s:textfield></td>
                            <td><s:textfield id="customerAddress.createdDate" name="customerAddress.createdDate" size="20" style="display:none"></s:textfield></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="error ui-state-error ui-corner-all">
                                    <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
                                </div>
                                    <sj:a href="#" id="btnCustomerAddressSave" button="true">Save</sj:a>
                                    <sj:a href="#" id="btnCustomerAddressCancel" button="true">Cancel</sj:a>
                                <br/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div>