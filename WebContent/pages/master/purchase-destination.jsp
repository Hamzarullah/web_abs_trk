<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    var 
        txtPurchaseDestinationCode = $("#purchaseDestination\\.code"),
        txtPurchaseDestinationName = $("#purchaseDestination\\.name"),
        txtPurchaseDestinationAddress = $("#purchaseDestination\\.address"),
        txtPurchaseDestinationCityCode = $("#purchaseDestination\\.city\\.code"),
        txtPurchaseDestinationCityName = $("#purchaseDestination\\.city\\.name"),
        txtPurchaseDestinationPhone1 = $("#purchaseDestination\\.phone1"),
        txtPurchaseDestinationPhone2 = $("#purchaseDestination\\.phone2"),
        txtPurchaseDestinationFax = $("#purchaseDestination\\.fax"),
        txtPurchaseDestinationEmail = $("#purchaseDestination\\.emailAddress"),
        txtPurchaseDestinationZipCode = $("#purchaseDestination\\.zipCode"),
        txtPurchaseDestinationContactPerson = $("#purchaseDestination\\.contactPerson"),
        chkPurchaseDestinationShipToStatus = $("#purchaseDestination\\.shipToStatus"),
        chkPurchaseDestinationBillToStatus = $("#purchaseDestination\\.billToStatus"),
        rdbPurchaseDestinationActiveStatus = $("#purchaseDestination\\.activeStatus"),
        rdbPurchaseDestinationDefaultShipTo = $("#purchaseDestinationTemp\\.defaultShipToCode"),
        rdbPurchaseDestinationDefaultBillTo = $("#purchaseDestinationTemp\\.defaultBillToCode"),
        txtPurchaseDestinationCreatedBy = $("#purchaseDestination\\.createdBy"),
        dtpPurchaseDestinationCreatedDate = $("#purchaseDestination\\.createdDate"),
        txtPurchaseDestinationRemark=$("#purchaseDestination\\.remark"),
        txtPurchaseDestinationInActiveBy = $("#purchaseDestination\\.inActiveBy"),
        dtpPurchaseDestinationInActiveDate = $("#purchaseDestination\\.inActiveDate"),
                
        allFieldsPurchaseDestination=$([])
            .add(txtPurchaseDestinationCode)
            .add(txtPurchaseDestinationName)
            .add(txtPurchaseDestinationAddress)
            .add(txtPurchaseDestinationCityCode)
            .add(txtPurchaseDestinationCityName)
            .add(txtPurchaseDestinationPhone1)
            .add(txtPurchaseDestinationPhone2)
            .add(txtPurchaseDestinationFax)
            .add(txtPurchaseDestinationEmail)
            .add(txtPurchaseDestinationZipCode)
            .add(txtPurchaseDestinationContactPerson)
            .add(txtPurchaseDestinationCreatedBy)
            .add(txtPurchaseDestinationRemark)
            .add(txtPurchaseDestinationInActiveBy);
            
          

    function reloadGridPurchaseDestination(){
        $("#itemSubCategory_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function(){
        hoverButton();
        var updateRowId = -1;
        hideInput("purchaseDestination");
        
        $("#purchaseDestinationShipToStatus").click(function() {
            if ($(this).is(':checked')) {
                chkPurchaseDestinationShipToStatus.val("true");
            }
            if (!$(this).is(':checked')) {
                chkPurchaseDestinationShipToStatus.val("false");
            }
        });
        
        $('#purchaseDestinationBillToStatus').click(function() {
            if ($(this).is(':checked')) {
                chkPurchaseDestinationBillToStatus.val("true");
            }
            if (!$(this).is(':checked')) {
                chkPurchaseDestinationBillToStatus.val("false");
            }
        });
        
        $('#purchaseDestination\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        //Active Status
        $('#purchaseDestinationSearchActiveStatusRadActive').prop('checked',true);
        $("#purchaseDestinationSearchActiveStatus").val("true");
        
        $('input[name="purchaseDestinationSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#purchaseDestinationSearchActiveStatus").val(value);
        });
        
        $('input[name="purchaseDestinationSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#purchaseDestinationSearchActiveStatus").val(value);
        });
                
        $('input[name="purchaseDestinationSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#purchaseDestinationSearchActiveStatus").val(value);
        });
        
        $('input[name="purchaseDestination\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#purchaseDestination\\.activeStatus").val(value);
            
        });
                
        $('input[name="purchaseDestination\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#purchaseDestination\\.activeStatus").val(value);
        });
        
        // Default Ship To Code
        $('input[name="purchaseDestinationTempDefaultShipToCode"][value="Yes"]').change(function(ev){
            var value="true";
            $("#purchaseDestinationTemp\\.defaultShipToCode").val(value);
        });
        $('input[name="purchaseDestinationTempDefaultShipToCode"][value="No"]').change(function(ev){
            var value="false";
            $("#purchaseDestinationTemp\\.defaultShipToCode").val(value);
        });
        $('#purchaseDestinationTemp\\.defaultShipToCodeNo').prop('checked',true);
        $("#purchaseDestinationTemp\\.defaultShipToCode").val("true");
        
        // Default Bill To Code
        $('input[name="purchaseDestinationTempDefaultBillToCode"][value="Yes"]').change(function(ev){
            var value="true";
            $("#purchaseDestinationTemp\\.defaultBillToCode").val(value);
        });
        $('input[name="purchaseDestinationTempDefaultBillToCode"][value="No"]').change(function(ev){
            var value="false";
            $("#purchaseDestinationTemp\\.defaultBillToCode").val(value);
        });
        
        
        
        $("#btnPurchaseDestinationNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/purchase-destination-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("purchaseDestination");
                    hideInput("purchaseDestinationSearch");
                    updateRowId = -1;
                    txtPurchaseDestinationCode.attr("readonly",true);
                    txtPurchaseDestinationCode.val("AUTO");
                    $('#purchaseDestination\\.activeStatusActive').prop('checked',true);
                    $("#purchaseDestination\\.activeStatus").val("true");

                    $("#purchaseDestination\\.inActiveDate").val("01/01/1900 00:00:00");
                    $("#purchaseDestination\\.createdDate").val("01/01/1900 00:00:00");
                    $("#purchaseDestinationShipToStatus").attr('checked',false);
                    $("#purchaseDestinationBillToStatus").attr('checked',false);
                    $("#purchaseDestination\\.shipToStatus").val("false");
                    $("#purchaseDestination\\.billToStatus").val("false");
                    $('#purchaseDestinationTempDefaultBillToCodeNo').prop('checked',true);
                    $("#purchaseDestinationTemp\\.defaultBillToCode").val("false");
                    $('#purchaseDestinationTempDefaultShipToCodeNo').prop('checked',true);
                    $("#purchaseDestinationTemp\\.defaultShipToCode").val("false");
                    txtPurchaseDestinationCode.attr("readonly",false);
                    allFieldsPurchaseDestination.val('').siblings('label[class="error"]').hide();
                    txtPurchaseDestinationCode.attr("autocomplete", "off");
                });
            });
        });


        $("#btnPurchaseDestinationSave").click(function(ev) {
            
            if(!$("#frmPurchaseDestinationInput").valid()) {
                handlers_input_purchaseDestination();
                ev.preventDefault();
                return;
            };

            var url = "";
            if (updateRowId < 0){
                url = "master/purchase-destination-save";
            }else{
                url = "master/purchase-destination-update";
            }
            
            purchaseDestinationFormatDate();
            
            var params = $("#frmPurchaseDestinationInput").serialize();
            
            $.post(url, params, function(data) {
                if (data.error) {
                    purchaseDestinationFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("purchaseDestination");
                showInput("purchaseDestinationSearch");
                allFieldsPurchaseDestination.val('').siblings('label[class="error"]').hide();
                txtPurchaseDestinationCode.val("AUTO");
                reloadGridPurchaseDestination();
            });
            
            ev.preventDefault();
        });
        
        
        $("#btnPurchaseDestinationUpdate").click(function(ev){
//             var urlPeriodClosing="finance/period-closing-confirmation";
//            var paramsPeriodClosing="";
//
//            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
//                var data=(result);
//                if (data.error) {
//                    alertMessage(data.errorMessage);
//                    return;
//                }
                
                var url="master/purchase-destination-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
        
                    updateRowId = $("#purchaseDestination_grid").jqGrid("getGridParam","selrow");

                    if(updateRowId === null){
                        alertMessage("Please Select Row!");
                        return;
                    }
                    var purchaseDestination = $("#purchaseDestination_grid").jqGrid('getRowData', updateRowId);
                    var url = "master/purchase-destination-get-data";
                    var params = "purchaseDestination.code=" + purchaseDestination.code;

                    txtPurchaseDestinationCode.attr("readonly",true);

                    $.post(url, params, function(result) {

                        var data = (result);

                            txtPurchaseDestinationCode.val(data.purchaseDestinationTemp.code);
                            txtPurchaseDestinationName.val(data.purchaseDestinationTemp.name);
                            txtPurchaseDestinationAddress.val(data.purchaseDestinationTemp.address);
                            txtPurchaseDestinationCityCode.val(data.purchaseDestinationTemp.cityCode);
                            txtPurchaseDestinationCityName.val(data.purchaseDestinationTemp.cityName);
                            txtPurchaseDestinationPhone1.val(data.purchaseDestinationTemp.phone1);
                            txtPurchaseDestinationPhone2.val(data.purchaseDestinationTemp.phone2);
                            txtPurchaseDestinationFax.val(data.purchaseDestinationTemp.fax);
                            txtPurchaseDestinationEmail.val(data.purchaseDestinationTemp.emailAddress);
                            txtPurchaseDestinationZipCode.val(data.purchaseDestinationTemp.zipCode);
                            txtPurchaseDestinationContactPerson.val(data.purchaseDestinationTemp.contactPerson);
                            chkPurchaseDestinationShipToStatus.val(data.purchaseDestinationTemp.shipToStatus);
                            $("#purchaseDestinationShipToStatus").attr('checked',data.purchaseDestinationTemp.shipToStatus);
                            chkPurchaseDestinationBillToStatus.val(data.purchaseDestinationTemp.billToStatus);
                            $("#purchaseDestinationBillToStatus").attr('checked',data.purchaseDestinationTemp.billToStatus);
                            rdbPurchaseDestinationActiveStatus.val(data.purchaseDestinationTemp.activeStatus);
                            txtPurchaseDestinationRemark.val(data.purchaseDestinationTemp.remark);
                            txtPurchaseDestinationInActiveBy.val(data.purchaseDestinationTemp.inActiveBy);
                            txtPurchaseDestinationRemark.val(data.purchaseDestinationTemp.remark);
                            var inActiveDate=formatDateRemoveT(data.purchaseDestinationTemp.inActiveDate,true);
                            dtpPurchaseDestinationInActiveDate.val(inActiveDate);
                            txtPurchaseDestinationCreatedBy.val(data.purchaseDestinationTemp.createdBy);
                            var createdDate=formatDateRemoveT(data.purchaseDestinationTemp.createdDate,true);
                            dtpPurchaseDestinationCreatedDate.val(createdDate);

                            rdbPurchaseDestinationDefaultShipTo.val(data.purchaseDestinationTemp.defaultBillToCode);
                            rdbPurchaseDestinationDefaultBillTo.val(data.purchaseDestinationTemp.defaultShipToCode);

                            if(data.purchaseDestinationTemp.defaultBillToCode===true){
                                $('#purchaseDestinationTempDefaultBillToCodeYes').prop('checked',true);
                            }

                            if(data.purchaseDestinationTemp.defaultBillToCode===false){
                                $('#purchaseDestinationTempDefaultBillToCodeNo').prop('checked',true);
                            }

                            if(data.purchaseDestinationTemp.defaultShipToCode===true){
                                $('#purchaseDestinationTempDefaultShipToCodeYes').prop('checked',true);
                            }
                            if(data.purchaseDestinationTemp.defaultShipToCode===false){
                                $('#purchaseDestinationTempDefaultShipToCodeNo').prop('checked',true);
                            }

                            if(data.purchaseDestinationTemp.activeStatus===true) {
                               $('#purchaseDestination\\.activeStatusActive').prop('checked',true);
                               $("#purchaseDestination\\.activeStatus").val("true");
                            }
                            else {                        
                               $('#purchaseDestination\\.activeStatusInActive').prop('checked',true);              
                               $("#purchaseDestination\\.activeStatus").val("false");
                            }


                        showInput("purchaseDestination");
                        hideInput("purchaseDestinationSearch");

                    }); 
                });
//            });
        });
        
        
        $('#btnPurchaseDestinationDelete').click(function(ev) {
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/purchase-destination-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }

                    var deleteRowId = $("#purchaseDestination_grid").jqGrid('getGridParam','selrow');
                    if (deleteRowId === null) {
                        alertMessage("Please Select Row!");
                        return;
                    }

                    var purchaseDestination = $("#purchaseDestination_grid").jqGrid('getRowData', deleteRowId);
                    var url="master/purchase-destination-delete";
                    var params="purchaseDestination.code=" + purchaseDestination.code;
                    var message="Are You Sure To Delete(Code : "+ purchaseDestination.code + ")?";
                    alertMessageDelete("purchaseDestination",url,params,message,400);

    //                if (confirm("Are You Sure To Delete (Code : " + purchaseDestination.code + ")")) {
    //                    var url = "master/purchase-destination-delete";
    //                    var params = "purchaseDestination.code=" + purchaseDestination.code;
    //                    $.post(url, params, function(data) {
    //                        if (data.error) {
    //                            alertMessage(data.errorMessage);
    //                            return;
    //                        }
    //                        alertMessage(data.message);
    //                        reloadGridPurchaseDestination();
    //                    });
    //                }
                });
            });
        });
        

        $("#btnPurchaseDestinationCancel").click(function(ev) {
            hideInput("purchaseDestination");
            showInput("purchaseDestinationSearch");
            allFieldsPurchaseDestination.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        $("#btnPurchaseDestinationPrint").click(function(ev) {
            var selectRowId = $("#purchaseDestination_grid").jqGrid('getGridParam','selrow');
            var purchaseDestination = $("#purchaseDestination_grid").jqGrid('getRowData', selectRowId);
            
            var url = "reports/purchase-destination-print-out-pdf?";
            var params = "code=" + purchaseDestination.code;
              
            window.open(url+params,'purchaseDestination','width=500,height=500');
        });
        
        $('#btnPurchaseDestinationRefresh').click(function(ev) {
            $('#purchaseDestinationSearchActiveStatusRadActive').prop('checked',true);
            $("#purchaseDestinationSearchActiveStatus").val("true");
            $("#purchaseDestination_grid").jqGrid("clearGridData");
            $("#purchaseDestination_grid").jqGrid("setGridParam",{url:"master/purchase-destination-data?"});
            $("#purchaseDestination_grid").trigger("reloadGrid");
            ev.preventDefault();    
        });
        
        
        $('#btnPurchaseDestination_search').click(function(ev) {
            $("#purchaseDestination_grid").jqGrid("clearGridData");
            $("#purchaseDestination_grid").jqGrid("setGridParam",{url:"master/purchase-destination-data?" + $("#frmPurchaseDestinationSearchInput").serialize()});
            $("#purchaseDestination_grid").trigger("reloadGrid");
            ev.preventDefault();
        });   
    
    });
    
    function reloadGridPurchaseDestination() {
        $("#purchaseDestination_grid").trigger("reloadGrid");
    };
    
    $('#purchaseDestination_btnCity').click(function(ev) {
        window.open("./pages/search/search-city.jsp?iddoc=purchaseDestination&idsubdoc=city","Search", "scrollbars=1, width=550, height=450");
    });
    
//     $('#purchaseDestination_btnCountry').click(function(ev) {
//        window.open("./pages/search/search-country.jsp?iddoc=purchaseDestination&idsubdoc=country","Search", "scrollbars=1, width=550, height=450");
//    });
    
    
//    function unHandlers_input_purchaseDestination(){
//        unHandlersInput(txtPurchaseDestinationCode);
//        unHandlersInput(txtPurchaseDestinationName);
//        unHandlersInput(txtPurchaseDestinationAddress);
//        unHandlersInput(txtPurchaseDestinationCityCode);
//        unHandlersInput(txtPurchaseDestinationPhone1);
//        unHandlersInput(txtPurchaseDestinationContactPerson);
//    }

    function handlers_input_purchaseDestination(){
        
        if(txtPurchaseDestinationCityCode.val()===""){
            handlersInput(txtPurchaseDestinationCityCode);
        }else{
            unHandlersInput(txtPurchaseDestinationCityCode);
        }
        
    }

    
    function purchaseDestinationFormatDate(){
        var inActiveDate=formatDate(dtpPurchaseDestinationInActiveDate.val(),true);
        dtpPurchaseDestinationInActiveDate.val(inActiveDate);
        $("#purchaseDestinationTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpPurchaseDestinationCreatedDate.val(),true);
        dtpPurchaseDestinationCreatedDate.val(createdDate);
        $("#purchaseDestinationTemp\\.createdDateTemp").val(createdDate);
    }
</script>


<s:url id="remoteurlPurchaseDestination" action="purchase-destination-data" />
<b>PURCHASE DESTINATION</b>
<hr>
<br class="spacer" />

<sj:div id="purchaseDestinationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnPurchaseDestinationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnPurchaseDestinationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnPurchaseDestinationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnPurchaseDestinationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPurchaseDestinationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>              
<div id="purchaseDestinationSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmPurchaseDestinationSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre"><b>Code</b></td>
                <td>
                    <s:textfield id="purchaseDestinationSearchCode" name="purchaseDestinationSearchCode" size="30" cssStyle="text-align: center;" ></s:textfield>
                </td>
                <td align="right" valign="centre"><b>Name</b></td>
                <td>
                    <s:textfield id="purchaseDestinationSearchName" name="purchaseDestinationSearchName" size="50"></s:textfield>
                <td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="purchaseDestinationSearchActiveStatus" name="purchaseDestinationSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="purchaseDestinationSearchActiveStatusRad" name="purchaseDestinationSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>  
        </table>
        <br />
        <sj:a href="#" id="btnPurchaseDestination_search" button="true">Search</sj:a>
        <br />
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
        </div>
    </s:form>
</div>
<br class="spacer" />  
<div id="purchaseDestinationGrid">
    <sjg:grid
        id="purchaseDestination_grid"
        dataType="json"
        href="%{remoteurlPurchaseDestination}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPurchaseDestinationTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        onSelectRowTopics="purchaseDestination_grid_onSelect"
        width="$('#tabmnupurchaseDestination').width()"
    >

        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" key="name" title="Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="address" index="address" key="address" title="Address" width="300" sortable="true"
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
            name="emailAddress" index="emailAddress" key="emailAddress" title="Email Address" width="250" sortable="true"
        /> 
        <sjg:gridColumn
            name="contactPerson" index="contactPerson" key="contactPerson" title="Contact Person" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="shipToStatus" index="shipToStatus" title="Ship To Status" width="50" formatter="checkbox" align="center" 
        />
        <sjg:gridColumn
            name="billToStatus" index="billToStatus" title="Bill To Status" width="50" formatter="checkbox" align="center" 
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid >
</div>
 
<div id="purchaseDestinationInput" class="content ui-widget">
    <s:form id="frmPurchaseDestinationInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="purchaseDestination.code" name="purchaseDestination.code" size="25" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: left;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Name *</B></td>
                <td><s:textfield id="purchaseDestination.name" name="purchaseDestination.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top"><B>Address *</B></td>
                <td><s:textarea id="purchaseDestination.address" name="purchaseDestination.address" rows="3" cols="78" title="*" required="true" cssClass="required" ></s:textarea> </td>
            </tr>
            <tr>
                <td align="right">ZipCode</td>
                <td><s:textfield id="purchaseDestination.zipCode" name="purchaseDestination.zipCode" size="50" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>City *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtPurchaseDestinationCityCode.change(function(ev) {

                            if(txtPurchaseDestinationCityCode.val()===""){
                                txtPurchaseDestinationCityCode.val("");
                                txtPurchaseDestinationCityName.val("");
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtPurchaseDestinationCityCode.val();
                                params += "&city.activeStatus=TRUE";
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){
                                    txtPurchaseDestinationCityCode.val(data.cityTemp.code);
                                    txtPurchaseDestinationCityName.val(data.cityTemp.name);
                                }
                                else{
                                    alertMessage("City Not Found!",txtPurchaseDestinationCityCode);
                                    txtPurchaseDestinationCityCode.val("");
                                    txtPurchaseDestinationCityName.val("");
                                }
                            });
                        });

                    </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="purchaseDestination.city.code" name="purchaseDestination.city.code" title="*" required="true" cssClass="required" maxLength="45" size="25"></s:textfield>
                            <sj:a id="purchaseDestination_btnCity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="purchaseDestination.city.name" name="purchaseDestination.city.name" size="50" readonly="true"></s:textfield> 
                </td>
            </tr>
            
<!--            <tr>
                <td align="right">Country</td>
                <td>
                    <%--<s:textfield id="purchaseDestination.city.province.country.code" name="purchaseDestination.city.province.country.code" size="25" readonly="true"></s:textfield>--%>
                    <%--<s:textfield id="purchaseDestination.city.province.country.name" name="purchaseDestination.city.province.country.name" size="50" readonly="true"></s:textfield>--%> 
                </td>
            </tr>-->
            <tr>
                <td align="right"><B>Phone 1 *</B></td>
                <td><s:textfield id="purchaseDestination.phone1" name="purchaseDestination.phone1" size="25" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                &nbsp;&nbsp;Phone 2
                <s:textfield id="purchaseDestination.phone2" name="purchaseDestination.phone2" size="25" maxLength="45"></s:textfield>
                &nbsp;&nbsp;Fax
                <s:textfield id="purchaseDestination.fax" name="purchaseDestination.fax" size="25" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Email</td>
                <td><s:textfield id="purchaseDestination.emailAddress" name="purchaseDestination.emailAddress" size="50" maxLength="45"></s:textfield></td>
            </tr>
            
            <tr>
                <td align="right"><B>Contact Person *</B></td>
                <td><s:textfield id="purchaseDestination.contactPerson" name="purchaseDestination.contactPerson" size="50" maxLength="45"></s:textfield></td>
            </tr>
            
            <tr>
                 <td align="right"><B>Ship To Status *</B></td>
                 <td colspan="2">
                    <s:checkbox id="purchaseDestinationShipToStatus" name="purchaseDestinationShipToStatus" value="false"></s:checkbox>
                    <s:textfield id="purchaseDestination.shipToStatus" name="purchaseDestination.shipToStatus" size="5" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
             
            <tr>
                <td align="right"><B>Bill To Status *</B></td>
                <td colspan="2">
                    <s:checkbox id="purchaseDestinationBillToStatus" name="purchaseDestinationBillToStatus" value="false"></s:checkbox>
                    <s:textfield id="purchaseDestination.billToStatus" name="purchaseDestination.billToStatus" size="5" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
             
            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="purchaseDestination.activeStatus" name="purchaseDestination.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="purchaseDestination.activeStatus" name="purchaseDestination.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr>
            
            <tr>
                <td align="right"><B>Set As Default Bill To *</B>
                <s:textfield id="purchaseDestinationTemp.defaultBillToCode" name="purchaseDestinationTemp.defaultBillToCode" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="purchaseDestinationTempDefaultBillToCode" name="purchaseDestinationTempDefaultBillToCode" list="{'Yes','No'}"></s:radio></td>                    
            </tr>
            
            <tr>
                <td align="right"><B>Set As Default Ship To *</B>
                <s:textfield id="purchaseDestinationTemp.defaultShipToCode" name="purchaseDestinationTemp.defaultShipToCode" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="purchaseDestinationTempDefaultShipToCode" name="purchaseDestinationTempDefaultShipToCode" list="{'Yes','No'}"></s:radio></td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="purchaseDestination.remark" name="purchaseDestination.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="purchaseDestination.inActiveBy"  name="purchaseDestination.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="purchaseDestination.inActiveDate" name="purchaseDestination.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="purchaseDestination.createdBy"  name="purchaseDestination.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="purchaseDestination.createdDate" name="purchaseDestination.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="purchaseDestinationTemp.inActiveDateTemp" name="purchaseDestinationTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="purchaseDestinationTemp.createdDateTemp" name="purchaseDestinationTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnPurchaseDestinationSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnPurchaseDestinationCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>

