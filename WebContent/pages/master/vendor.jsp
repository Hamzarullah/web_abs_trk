
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    var vendorDefaultContact_lastRowId = 0, vendorDefaultContact_lastSel = -1 ;
    
    var 
        txtVendorCode=$("#vendor\\.code"),
        txtVendorName=$("#vendor\\.name"),
        txtVendorAddress=$("#vendor\\.address"),
        txtVendorCityCode=$("#vendor\\.city\\.code"),
        txtVendorCityName=$("#vendor\\.city\\.name"),
        txtVendorProvinceCode=$("#vendor\\.city\\.province\\.code"),
        txtVendorProvinceName=$("#vendor\\.city\\.province\\.name"),
        txtVendorIslandCode=$("#vendor\\.city\\.province\\.island\\.code"),
        txtVendorIslandName=$("#vendor\\.city\\.province\\.island\\.name"),
        txtVendorCountryCode=$("#vendor\\.city\\.province\\.island\\.country\\.code"),
        txtVendorCountryName=$("#vendor\\.city\\.province\\.island\\.country\\.name"),
        txtVendorZipCode=$("#vendor\\.zipCode"),
        txtVendorPhone1=$("#vendor\\.phone1"),
        txtVendorPhone2=$("#vendor\\.phone2"),
        txtVendorEmailAddress=$("#vendor\\.emailAddress"),
        txtVendorFax=$("#vendor\\.fax"),
        txtVendorVendorCategoryCode=$("#vendor\\.vendorCategory\\.code"),
        txtVendorVendorCategoryName=$("#vendor\\.vendorCategory\\.name"),
        txtVendorDefaultContactPersonCode=$("vendor\\.defaultContactPerson\\.code"),
        txtVendorDefaultContactPersonName=$("vendor\\.defaultContactPerson\\.name"),
        txtVendorBusinessEntityCode=$("#vendor\\.businessEntity\\.code"),
        txtVendorBusinessEntityName=$("#vendor\\.businessEntity\\.name"),
        txtVendorNPWP=$("#vendor\\.npwp"),
        txtVendorNPWPName=$("#vendor\\.npwpName"),
        txtVendorNPWPAddress=$("#vendor\\.npwpAddress"),
        txtVendorNPWPCityCode=$("#vendor\\.npwpCity\\.code"),
        txtVendorNPWPCityName=$("#vendor\\.npwpCity\\.name"),
        txtVendorNPWPProvinceCode=$("#vendor\\.npwpCity\\.province\\.code"),
        txtVendorNPWPProvinceName=$("#vendor\\.npwpCity\\.province\\.name"),
        txtVendorNPWPIslandCode=$("#vendor\\.npwpCity\\.province\\.island\\.code"),
        txtVendorNPWPIslandName=$("#vendor\\.npwpCity\\.province\\.island\\.name"),
        txtVendorNPWPCountryCode=$("#vendor\\.npwpCity\\.province\\.island\\.country\\.code"),
        txtVendorNPWPCountryName=$("#vendor\\.npwpCity\\.province\\.island\\.country\\.name"),
        txtVendorNPWPZipCode=$("#vendor\\.npwpZipCode"),
        txtVendorPaymentTermCode=$("#vendor\\.paymentTerm\\.code"),
        txtVendorPaymentTermName=$("#vendor\\.paymentTerm\\.name"),
        rdbVendorLocalImport=$("#vendor\\.localImport"),
        rdbVendorActiveStatus=$("#vendor\\.activeStatus"),
        rdbVendorCriticalStatus=$("#vendor\\.criticalStatus"),
        rdbVendorPenaltyStatus=$("#vendor\\.penaltyStatus"),
        txtVendorScope=$("#vendor\\.scope"),
        txtVendorRemark=$("#vendor\\.remark"),
        txtVendorInActiveBy = $("#vendor\\.inActiveBy"),
        dtpVendorInActiveDate = $("#vendor\\.inActiveDate"),
        txtVendorCreatedBy = $("#vendor\\.createdBy"),
        dtpVendorCreatedDate = $("#vendor\\.createdDate"),
        
        allFieldsVendor=$([])
            .add(txtVendorCode)
            .add(txtVendorName)
            .add(txtVendorAddress)
            .add(txtVendorCityCode)
            .add(txtVendorCityName)
            .add(txtVendorProvinceCode)
            .add(txtVendorProvinceName)
            .add(txtVendorIslandCode)
            .add(txtVendorIslandName)
            .add(txtVendorCountryCode)
            .add(txtVendorCountryName)
            .add(txtVendorZipCode)
            .add(txtVendorPhone1)
            .add(txtVendorPhone2)
            .add(txtVendorEmailAddress)
            .add(txtVendorFax)
            .add(txtVendorVendorCategoryCode)
            .add(txtVendorVendorCategoryName)
            .add(txtVendorBusinessEntityCode)
            .add(txtVendorBusinessEntityName)
            .add(txtVendorDefaultContactPersonCode)
            .add(txtVendorDefaultContactPersonName)
            .add(txtVendorNPWP)
            .add(txtVendorNPWPName)
            .add(txtVendorNPWPAddress)
            .add(txtVendorNPWPCityCode)
            .add(txtVendorNPWPCityName)
            .add(txtVendorNPWPProvinceCode)
            .add(txtVendorNPWPProvinceName)
            .add(txtVendorNPWPIslandCode)
            .add(txtVendorNPWPIslandName)
            .add(txtVendorNPWPCountryCode)
            .add(txtVendorNPWPCountryName)
            .add(txtVendorNPWPZipCode)
            .add(txtVendorPaymentTermCode)
            .add(txtVendorPaymentTermName)
            .add(txtVendorRemark)
            .add(txtVendorScope)
            .add(txtVendorInActiveBy)
            .add(txtVendorCreatedBy);


    function reloadGridVendor(){
        $("#vendor_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("vendor");
        
        $.subscribe("vendor_grid_onSelect", function(event, data){
            var selectedRowID = $("#vendor_grid").jqGrid("getGridParam", "selrow"); 
            var vendorHeader = $("#vendor_grid").jqGrid("getRowData", selectedRowID);
           
            $("#vendorContact_grid").jqGrid("setGridParam",{url:"master/vendor-contact-reload-grid?vendor.code=" + vendorHeader.code});
            $("#vendorContact_grid").jqGrid("setCaption", "Vendor Contact : " + vendorHeader.code);
            $("#vendorContact_grid").trigger("reloadGrid");
            
            var selectedRowID = $("#vendor_grid").jqGrid("getGridParam", "selrow"); 
            var vendor = $("#vendor_grid").jqGrid("getRowData", selectedRowID);
            
            $("#vendorJnContactInput_grid").jqGrid("setGridParam",{url:"master/vendor-contact-reload-grid?vendor.code="+ vendor.code});
            $("#vendorJnContactInput_grid").jqGrid("setCaption", "VENDOR CONTACT DETAIL : " + vendor.code);
            $("#vendorJnContactInput_grid").trigger("reloadGrid");
        });
        
        $('#vendor\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('input[name="vendorlocalImport"][value="Local"]').change(function(ev){
            var value="Local";
            $("#vendor\\.localImport").val(value);
        });
        
         $('input[name="vendorlocalImport"][value="Import"]').change(function(ev){
            var value="Import";
            $("#vendor\\.localImport").val(value);
        });
        
        $('#vendorSearchActiveStatusRadActive').prop('checked',true);
        $("#vendorSearchActiveStatus").val("true");
        
        $('input[name="vendorSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#vendorSearchActiveStatus").val(value);
        });
        
        $('input[name="vendorSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#vendorSearchActiveStatus").val(value);
        });
                
        $('input[name="vendorSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#vendorSearchActiveStatus").val(value);
        });
        
        $('input[name="vendorActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#vendor\\.activeStatus").val(value);
            $("#vendor\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="vendorActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#vendor\\.activeStatus").val(value);
        });
        
        $('input[name="vendorCriticalStatusRad"][value="Yes"]').change(function(ev){
            var value="true";
            $("#vendor\\.criticalStatus").val(value);
        });
                
        $('input[name="vendorCriticalStatusRad"][value="No"]').change(function(ev){
            var value="false";
            $("#vendor\\.criticalStatus").val(value);
        });
        
        $('input[name="vendorPenaltyStatusRad"][value="Yes"]').change(function(ev){
            var value="true";
            $("#vendor\\.penaltyStatus").val(value);
        });
                
        $('input[name="vendorPenaltyStatusRad"][value="No"]').change(function(ev){
            var value="false";
            $("#vendor\\.penaltyStatus").val(value);
        });
        
        $("#btnVendorNew").click(function(ev){
            var url="master/vendor-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_vendor();
                showInput("vendor");
                hideInput("vendorSearch");
     
                $('#vendorActiveStatusRadActive').prop('checked',true);
                $("#vendor\\.activeStatus").val("true");
                $('#vendorCriticalStatusRadYes').prop('checked',true);
                $("#vendor\\.criticalStatus").val("true");
                $('#vendorPenaltyStatusRadYes').prop('checked',true);
                $("#vendor\\.penaltyStatus").val("true");
                $('#vendorLocalImportRadLocal').prop('checked',true);
                $('#vendor\\.localImport').val("Local");
                txtVendorCode.val("AUTO");
                $("#vendor\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#vendor\\.createdDate").val("01/01/1900 00:00:00");
                updateRowId = -1;
                txtVendorCode.attr("readonly",true);
                txtVendorCode.val("AUTO");
                $("#vendorJnContactInput_grid").jqGrid("clearGridData");


                });
//            ev.preventDefault();
        });
        
        
        $("#btnVendorSave").click(function(ev) {
           if(!$("#frmVendorInput").valid()) {
//               handlers_input_vendor();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           vendorFormatDate();
           if (updateRowId < 0){
               url = "master/vendor-save";
           } else{
               url = "master/vendor-update";
           }
           
           var params = $("#frmVendorInput").serialize();
           
           $.post(url, params, function(data) {
                if (data.error) {
                    vendorFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("vendor");
                showInput("vendorSearch");
                allFieldsVendor.val('').siblings('label[class="error"]').hide();
                txtVendorCode.val("AUTO");
                reloadGridVendor();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnVendorUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/vendor-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_vendor();
                updateRowId=$("#vendor_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var vendor=$("#vendor_grid").jqGrid('getRowData',updateRowId);
                var url="master/vendor-get-data";
                var params="vendor.code=" + vendor.code;

                txtVendorCode.attr("readonly",true);
                $.post(url,params,function (result){
                    var data=(result);
                    
                        txtVendorCode.val(data.vendorTemp.code);
                        txtVendorName.val(data.vendorTemp.name);
                        txtVendorAddress.val(data.vendorTemp.address);
                        txtVendorCityCode.val(data.vendorTemp.cityCode);
                        txtVendorCityName.val(data.vendorTemp.cityName);
                        txtVendorProvinceCode.val(data.vendorTemp.provinceCode);
                        txtVendorProvinceName.val(data.vendorTemp.provinceName);
                        txtVendorIslandCode.val(data.vendorTemp.islandCode);
                        txtVendorIslandName.val(data.vendorTemp.islandName);
                        txtVendorCountryCode.val(data.vendorTemp.countryCode);
                        txtVendorCountryName.val(data.vendorTemp.countryName);
                        txtVendorZipCode.val(data.vendorTemp.zipCode);
                        txtVendorPhone1.val(data.vendorTemp.phone1);
                        txtVendorPhone2.val(data.vendorTemp.phone2);
                        txtVendorEmailAddress.val(data.vendorTemp.emailAddress);
                        txtVendorFax.val(data.vendorTemp.fax);
                        txtVendorVendorCategoryCode.val(data.vendorTemp.vendorCategoryCode);
                        txtVendorVendorCategoryName.val(data.vendorTemp.vendorCategoryName);
                        txtVendorBusinessEntityCode.val(data.vendorTemp.businessEntityCode);
                        txtVendorBusinessEntityName.val(data.vendorTemp.businessEntityName);
                        $("#vendor\\.defaultContactPerson\\.code").val(data.vendorTemp.defaultContactPersonCode);
                        $("#vendor\\.defaultContactPerson\\.name").val(data.vendorTemp.defaultContactPersonName);
                        txtVendorNPWP.val(data.vendorTemp.npwp);
                        txtVendorNPWPName.val(data.vendorTemp.npwpName);
                        txtVendorNPWPAddress.val(data.vendorTemp.npwpAddress);
                        txtVendorNPWPCityCode.val(data.vendorTemp.npwpCityCode);
                        txtVendorNPWPCityName.val(data.vendorTemp.npwpCityName);
                        txtVendorNPWPProvinceCode.val(data.vendorTemp.npwpProvinceCode);
                        txtVendorNPWPProvinceName.val(data.vendorTemp.npwpProvinceName);
                        txtVendorNPWPIslandCode.val(data.vendorTemp.npwpIslandCode);
                        txtVendorNPWPIslandName.val(data.vendorTemp.npwpIslandName);
                        txtVendorNPWPCountryCode.val(data.vendorTemp.npwpCountryCode);
                        txtVendorNPWPCountryName.val(data.vendorTemp.npwpCountryName);
                        txtVendorNPWPZipCode.val(data.vendorTemp.npwpZipCode);
                        txtVendorPaymentTermCode.val(data.vendorTemp.paymentTermCode);
                        txtVendorPaymentTermName.val(data.vendorTemp.paymentTermName);
                        rdbVendorLocalImport.val(data.vendorTemp.localImport);
                        rdbVendorActiveStatus.val(data.vendorTemp.activeStatus);
                        rdbVendorCriticalStatus.val(data.vendorTemp.criticalStatus);
                        rdbVendorPenaltyStatus.val(data.vendorTemp.penaltyStatus);
                        txtVendorRemark.val(data.vendorTemp.remark);
                        txtVendorScope.val(data.vendorTemp.scope);
                        txtVendorInActiveBy.val(data.vendorTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.vendorTemp.inActiveDate,true);
                        dtpVendorInActiveDate.val(inActiveDate);
                        txtVendorCreatedBy.val(data.vendorTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.vendorTemp.createdDate,true);
                        dtpVendorCreatedDate.val(createdDate);
                        
                        if(data.vendorTemp.localImport==='LOCAL') {
                           $('#vendorLocalImportRadLocal').prop('checked',true);
                           $("#vendor\\.localImport").val("Local");
                        }
                        else {                        
                           $('#vendorLocalImportRadImport').prop('checked',true);              
                           $("#vendor\\.localImport").val("Import");
                        }
                        if(data.vendorTemp.activeStatus===true) {
                           $('#vendorActiveStatusRadActive').prop('checked',true);
                           $("#vendor\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#vendorActiveStatusRadInActive').prop('checked',true);              
                           $("#vendor\\.activeStatus").val("false");
                        }
                        if(data.vendorTemp.criticalStatus===true) {
                           $('#vendorCriticalStatusRadYes').prop('checked',true);
                           $("#vendor\\.criticalStatus").val("true");
                        }
                        else {                        
                           $('#vendorCriticalStatusRadNo').prop('checked',true);              
                           $("#vendor\\.criticalStatus").val("false");
                        }
                        if(data.vendorTemp.penaltyStatus===true) {
                           $('#vendorPenaltyStatusRadYes').prop('checked',true);
                           $("#vendor\\.pianltyStatus").val("true");
                        }
                        else {                        
                           $('#vendorPenaltyStatusRadNo').prop('checked',true);              
                           $("#vendor\\.pianltyStatus").val("false");
                        }

                        showInput("vendor");
                        hideInput("vendorSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnVendorDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/vendor-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#vendor_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var vendor=$("#vendor_grid").jqGrid('getRowData',deleteRowID);
                var url="master/vendor-delete";
                var params="vendor.code=" + vendor.code;
                var message="Are You Sure To Delete(Code : "+ vendor.code + ")?";
                alertMessageDelete("vendor",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ vendor.code+ ')?</div>');
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
//                                var url="master/vendor-delete";
//                                var params="vendor.code=" + vendor.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridVendor();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + vendor.code+ ")")){
//                    var url="master/vendor-delete";
//                    var params="vendor.code=" + vendor.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridVendor();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnVendorCancel").click(function(ev) {
            hideInput("vendor");
            showInput("vendorSearch");
            allFieldsVendor.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnVendorRefresh').click(function(ev) {
            $('#vendorSearchActiveStatusRadActive').prop('checked',true);
            $("#vendorSearchActiveStatus").val("true");
            $("#vendor_grid").jqGrid("clearGridData");
            $("#vendor_grid").jqGrid("setGridParam",{url:"master/vendor-data?"});
            $("#vendor_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnVendorPrint").click(function(ev) {
            
            var url = "reports/vendor-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'vendor','width=500,height=500');
        });
        
        $("#btnVendorAddItemMaterial").click(function(ev){
            updateRowId = $("#vendor_grid").jqGrid("getGridParam","selrow");
            var vendor = $("#vendor_grid").jqGrid('getRowData', updateRowId);
            var url = "master/vendor-item-material-input";
            var param = "vendorItemMaterial.code=" + vendor.code;

            pageLoad(url, param, "#tabmnuVENDOR");
            ev.preventDefault();  
        });
        
        $('#btnVendor_search').click(function(ev) {
            $("#vendor_grid").jqGrid("clearGridData");
            $("#vendor_grid").jqGrid("setGridParam",{url:"master/vendor-data?" + $("#frmVendorSearchInput").serialize()});
            $("#vendor_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
       $('#vendor_btnCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=vendor&idsubdoc=city","Search", "scrollbars=1, width=700, height=500");
        });
                    
       $('#vendor_btnNPWPCity').click(function(ev) {
            window.open("./pages/search/search-city.jsp?iddoc=vendor&idsubdoc=npwpCity","Search", "scrollbars=1, width=700, height=500");
        });
                    
       $('#vendor_btnBusinessEntity').click(function(ev) {
            window.open("./pages/search/search-business-entity.jsp?iddoc=vendor&idsubdoc=businessEntity","Search", "width=550, height=475");
        });
                    
       $('#vendor_btnPaymentTerm').click(function(ev) {
            window.open("./pages/search/search-payment-term.jsp?iddoc=vendor&idsubdoc=paymentTerm","Search", "scrollbars=1, width=700, height=500");
        });
        $('#vendor_btnVendorCategory').click(function(ev) {
            window.open("./pages/search/search-vendor-category.jsp?iddoc=vendor&idsubdoc=vendorCategory","Search", "scrollbars=1, width=700, height=500");
        });
                    
        $('#vendor_btnDefaultVendorCode').click(function(ev){
            var ids = jQuery("#vendorJnContactInput_grid").jqGrid('getDataIDs');
           
            if(ids.length===0){
                alertMessage("Grid Vendor Contact Can't Be Empty!");
                return;
            }
            
            if(vendorDefaultContact_lastSel !== -1) {
               $('#vendorJnContactInput_grid').jqGrid("saveRow",vendorDefaultContact_lastSel); 
            }

            var listDefaultContactCode = new Array();
            var listCode = new Array();
            
            for(var i=0;i<ids.length;i++){
                var Detail = $("#vendorJnContactInput_grid").jqGrid('getRowData',ids[i]); 
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
        
            window.open("./pages/search/search-vendor-contact-with-array.jsp?iddoc=vendor&idvendorContactcode="+strr,"Search", "Scrollbars=1,width=600, height=500");
        });
    });
    
    function vendorFormatDate(){
        var inActiveDate=formatDate(dtpVendorInActiveDate.val(),true);
        dtpVendorInActiveDate.val(inActiveDate);
        $("#vendorTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpVendorCreatedDate.val(),true);
        dtpVendorCreatedDate.val(createdDate);
        $("#vendorTemp\\.createdDateTemp").val(createdDate);
    }

    
</script>

<s:url id="remoteurlVendor" action="vendor-data" />
<s:url id="remoteurlVendorContactDetail" action="" />
<b>VENDOR</b>
<hr>
<br class="spacer"/>


<sj:div id="vendorButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnVendorNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnVendorUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnVendorDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnVendorRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnVendorPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
            <td><a href="#" id="btnVendorAddItemMaterial" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>Add Item Material</a>
            </td> 
        </tr>
        
    </table>
</sj:div>      
    
<div id="vendorSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmVendorSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="vendorSearchCode" name="vendorSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="vendorSearchName" name="vendorSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="vendorSearchActiveStatus" name="vendorSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="vendorSearchActiveStatusRad" name="vendorSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnVendor_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="vendorGrid">
    <sjg:grid
        id="vendor_grid"
        dataType="json"
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
        width="$('#tabmnuvendor').width()"
        onSelectRowTopics="vendor_grid_onSelect"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="address" index="address" title="Address" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="cityCode" index="cityCode" title="CityCode" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="cityName" index="cityName" title="CityName" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="countryCode" index="countryCode" title="CountryCode" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="countryName" index="countryName" title="CountryName" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="defaultContactPersonCode" index="defaultContactPersonCode" title="Contact Person" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="defaultContactPersonName" index="defaultContactPersonName" title="" width="300" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="zipCode" index="zipCode" title="ZipCode" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="phone1" index="phone1" title="Phone1" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="phone2" index="phone2" title="Phone2" width="300" sortable="true"
        />
         <sjg:gridColumn
            name="fax" index="fax" title="Fax" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="emailAddress" index="emailAddress" title="EmailAddress" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="vendorInput" class="content ui-widget">
    <s:form id="frmVendorInput">
        <table cellpadding="2" cellspacing="2">
             <tr>
                <td valign="top">
                    <table width="100%">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="vendor.code" name="vendor.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: left;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="vendor.name" name="vendor.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Address *</b></td>
                <td><s:textfield id="vendor.address" name="vendor.address" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>City *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        
                        function clearVendorCityFields(){
                            txtVendorCityCode.val("");
                            txtVendorCityName.val("");
                            txtVendorProvinceCode.val("");
                            txtVendorProvinceName.val("");
                            txtVendorIslandCode.val("");
                            txtVendorIslandName.val("");
                            txtVendorCountryCode.val("");
                            txtVendorCountryName.val("");
                            
                        }
                        
                        txtVendorCityCode.change(function(ev) {
                            
                            if(txtVendorCityCode.val()===""){
                                clearVendorCityFields();
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtVendorCityCode.val();
                                params+= "&city.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){
                                    txtVendorCityCode.val(data.cityTemp.code);
                                    txtVendorCityName.val(data.cityTemp.name);
                                    txtVendorProvinceCode.val(data.cityTemp.provinceCode);
                                    txtVendorProvinceName.val(data.cityTemp.provinceName);
                                    txtVendorIslandCode.val(data.cityTemp.provinceIslandCode);
                                    txtVendorIslandName.val(data.cityTemp.provinceIslandName);
                                    txtVendorCountryCode.val(data.cityTemp.provinceCountryCode);
                                    txtVendorCountryName.val(data.cityTemp.provinceCountryName);
                                     
                                }
                                else{
                                    alertMessage("City Not Found!",txtVendorCityCode);
                                    clearVendorCityFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendor.city.code" name="vendor.city.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="vendor_btnCity" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendor.city.name" name="vendor.city.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                    <td align="right">Province </td>
                    <td><s:textfield id="vendor.city.province.code" name="vendor.city.province.code" size="25" title="Please Enter Province!" required="true" cssClass="required" readonly="true"></s:textfield>
                        <s:textfield id="vendor.city.province.name" name="vendor.city.province.name" size="35" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>
<!--            <tr>
                    <td align="right"><B>Island *</B></td>
                    <td>s:textfield id="vendor.city.province.island.code" name="vendor.city.province.island.code" size="25" title="Please Enter Island!" required="true" cssClass="required" readonly="true">/s:textfield>
                        s:textfield id="vendor.city.province.island.name" name="vendor.city.province.island.name" size="45" required="true" cssClass="required" readonly="true">/s:textfield></td>
            </tr>-->
            <tr>
                    <td align="right">Country </td>
                    <td><s:textfield id="vendor.city.province.island.country.code" name="vendor.city.province.island.country.code" size="25" title="Please Enter Country!" required="true" cssClass="required" readonly="true"></s:textfield>
                        <s:textfield id="vendor.city.province.island.country.name" name="vendor.city.province.island.country.name" size="35" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>
             <tr>
                <td align="right"><b>ZipCode *</b></td>
                <td><s:textfield id="vendor.zipCode" name="vendor.zipCode" size="30" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Phone 1 *</b></td>
                <td><s:textfield id="vendor.phone1" name="vendor.phone1" size="30" title="*" required="true" cssClass="required" maxLength="45"></s:textfield>
                Phone 2
                <s:textfield id="vendor.phone2" name="vendor.phone2" size="30" maxLength="45"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Email </td>
                <td>
                <s:textfield id="vendor.emailAddress" name="vendor.emailAddress" size="30" maxLength="45"></s:textfield>
                Fax 
                <s:textfield id="vendor.fax" name="vendor.fax" size="30" title="*" maxLength="95"></s:textfield>
                </td>
            </tr>
           <tr>
                <td align="right"><b>Vendor Category *</b></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearVendorVendorCategoryFields(){
                            txtVendorVendorCategoryCode.val("");
                            txtVendorVendorCategoryName.val("");
                            
                        }
                        
                        txtVendorVendorCategoryCode.change(function(ev) {
                            
                            if(txtVendorVendorCategoryCode.val()===""){
                                clearVendorVendorCategoryFields();
                                return;
                            }
                            var url = "master/vendor-category-get";
                            var params = "vendoryCategory.code=" + txtVendorVendorCategoryCode.val();
                                params+= "&vendorCategory.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.vendorCategoryTemp){
                                    txtVendorVendorCategoryCode.val(data.vendorCategoryTemp.code);
                                    txtVendorVendorCategoryName.val(data.vendorCategoryTemp.name);
                                }
                                
                                else{
                                    alertMessage("Vendor Category Not Found!",txtVendorVendorCategoryCode);
                                    clearVendorVendorCategoryFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendor.vendorCategory.code" name="vendor.vendorCategory.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="vendor_btnVendorCategory" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendor.vendorCategory.name" name="vendor.vendorCategory.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Business Entity *</B></td>
                <td>
                    <script type = "text/javascript">

                    txtVendorBusinessEntityCode.change(function(ev) {
                        if(txtVendorBusinessEntityCode.val()===""){
                            txtVendorBusinessEntityCode.val("");
                            txtVendorBusinessEntityName.val("");
                            return;
                        }
                        var url = "master/business-entity-get";
                        var params = "businessEntity.code=" + txtVendorBusinessEntityCode.val();
                            params += "&businessEntity.activeStatus=true";

                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.businessEntityTemp){
                                txtVendorBusinessEntityCode.val(data.businessEntityTemp.code);
                                txtVendorBusinessEntityName.val(data.businessEntityTemp.name);
                            }
                            else{
                                alertMessage("Business Entity Not Found!",txtVendorBusinessEntityCode);
                                txtVendorBusinessEntityCode.val("");
                                txtVendorBusinessEntityName.val("");
                            }
                        });
                    });

                    </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="vendor.businessEntity.code" name="vendor.businessEntity.code" title=" " required="true" cssClass="required" maxLength="45" size="20"></s:textfield>
                            <sj:a id="vendor_btnBusinessEntity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="vendor.businessEntity.name" name="vendor.businessEntity.name" size="25" readonly="true"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right">Default Contact Person</td>
                <script type = "text/javascript">
                                
                     txtVendorDefaultContactPersonCode.change(function(ev) {

                        if(txtVendorDefaultContactPersonCode.val()===""){
                            txtVendorDefaultContactPersonCode.val("");
                            txtVendorDefaultContactPersonName.val("");
                            return;
                        }
                        var url = "master/vendor-contact-for-vendor-search-data";
                        var params = "vendorCode=" + txtVendorCode.val();
                            params += "&vendorContactSearchCode="+txtVendorDefaultContactPersonCode.val();
                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.vendorContactTemp){
                                txtVendorDefaultContactPersonCode.val(data.vendorContactTemp.code);
                                txtVendorDefaultContactPersonName.val(data.vendorContactTemp.name);
                            }
                            else{
                                alertMessage("Contact Person Not Found!",txtVendorDefaultContactPersonCode);
                                txtVendorDefaultContactPersonCode.val("");
                                txtVendorDefaultContactPersonName.val("");
                            }
                        });
                    });

                </script>
                <td>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendor.defaultContactPerson.code" name="vendor.defaultContactPerson.code" size="20" ></s:textfield>
                        <sj:a id="vendor_btnDefaultVendorCode" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="vendor.defaultContactPerson.name" name="vendor.defaultContactPerson.name" size="25" readonly="true"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td valign="top" colspan="2">
                    <sjg:grid
                        id="vendorJnContactInput_grid"
                        caption="Vendor Contact"
                        href="%{remoteurlVendorContactDetail}"
                        dataType="json"                    
                        pager="true"
                        navigator="false"
                        navigatorView="false"
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
                        editinline="true"
                        width="500"
                    >
                        <sjg:gridColumn
                            name = "code" index = "code" key = "code" title = "Code" width = "100"
                        />
                        <sjg:gridColumn
                            name = "name" index = "name" key = "name" title = "Name" width = "100"
                        />
                        <sjg:gridColumn
                            name="birthDate" index="birthDate" key="birthDate" 
                            title="Birth Date" width="150" search="false" sortable="true" align="center"
                            formatter="date" formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d'}" 
                        />
                        <sjg:gridColumn
                            name = "phone" index = "phone" key = "phone" title = "Phone" width = "50"
                        />
                        <sjg:gridColumn
                            name="jobPositionCode" index="jobPositionCode" key = "jobPositionCode" title="Job Position Code"  width = "100"
                        />
                    </sjg:grid >
                </td>
            </tr>
        </table>             
          <td valign="top">
            <table width="100%">
              <tr>
                <td align="right"><b>NPWP *</b></td>
                <td><s:textfield id="vendor.npwp" name="vendor.npwp" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>NPWPName *</b></td>
                <td><s:textfield id="vendor.npwpName" name="vendor.npwpName" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>NPWPAddress *</b></td>
                <td><s:textfield id="vendor.npwpAddress" name="vendor.npwpAddress" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>NPWPCity *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearVendorNPWPCityFields(){
                            txtVendorNPWPCityCode.val("");
                            txtVendorNPWPCityName.val("");
                            txtVendorNPWPProvinceCode.val("");
                            txtVendorNPWPProvinceName.val("");
                            txtVendorNPWPIslandCode.val("");
                            txtVendorNPWPIslandName.val("");
                            txtVendorNPWPCountryCode.val("");
                            txtVendorNPWPCountryName.val("");
                            
                        }
                        
                        txtVendorNPWPCityCode.change(function(ev) {
                            
                            if(txtVendorNPWPCityCode.val()===""){
                                clearVendorNPWPCityFields();
                                return;
                            }
                            var url = "master/city-get";
                            var params = "city.code=" + txtVendorNPWPCityCode.val();
                                params+= "&city.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.cityTemp){
                                    txtVendorNPWPCityCode.val(data.cityTemp.code);
                                    txtVendorNPWPCityName.val(data.cityTemp.name);
                                    txtVendorNPWPProvinceCode.val(data.cityTemp.provinceCode);
                                    txtVendorNPWPProvinceName.val(data.cityTemp.provinceName);
                                    txtVendorNPWPIslandCode.val(data.cityTemp.provinceIslandCode);
                                    txtVendorNPWPIslandName.val(data.cityTemp.provinceIslandName);
                                    txtVendorNPWPCountryCode.val(data.cityTemp.provinceCountryCode);
                                    txtVendorNPWPCountryName.val(data.cityTemp.provinceCountryName);
                                    
                                     
                                }
                                else{
                                    alertMessage("NPWPCity Not Found!",txtVendorNPWPCityCode);
                                    clearVendorNPWPCityFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendor.npwpCity.code" name="vendor.npwpCity.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="vendor_btnNPWPCity" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendor.npwpCity.name" name="vendor.npwpCity.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                    <td align="right">NPWP Province </td>
                    <td><s:textfield id="vendor.npwpCity.province.code" name="vendor.npwpCity.province.code" size="15" title="Please Enter Province!" required="true" cssClass="required" readonly="true"></s:textfield>
                        <s:textfield id="vendor.npwpCity.province.name" name="vendor.npwpCity.province.name" size="25" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                    <td align="right">NPWP Country</td>
                    <td><s:textfield id="vendor.npwpCity.province.island.country.code" name="vendor.npwpCity.province.island.country.code" size="15" title="Please Enter Country!" required="true" cssClass="required" readonly="true"></s:textfield>
                        <s:textfield id="vendor.npwpCity.province.island.country.name" name="vendor.npwpCity.province.island.country.name" size="25" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>
             <tr>
                <td align="right"><b>NPWP ZipCode *</b></td>
                <td><s:textfield id="vendor.npwpZipCode" name="vendor.npwpZipCode" size="50" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>PaymentTerm *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        
                        function clearVendorPaymentTermFields(){
                            txtVendorPaymentTermCode.val("");
                            txtVendorPaymentTermName.val("");
                            
                        }
                        
                        txtVendorPaymentTermCode.change(function(ev) {
                            
                            if(txtVendorPaymentTermCode.val()===""){
                                clearVendorPaymentTermFields();
                                return;
                            }
                            var url = "master/payment-term-get";
                            var params = "paymentTerm.code=" + txtVendorPaymentTermCode.val();
                                params+= "&paymentTerm.activeStatus=TRUE";
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.paymentTermTemp){
                                    txtVendorPaymentTermCode.val(data.paymentTermTemp.code);
                                    txtVendorPaymentTermName.val(data.paymentTermTemp.name);
                                     
                                }
                                else{
                                    alertMessage("PaymentTerm Not Found!",txtVendorPaymentTermCode);
                                    clearVendorPaymentTermFields();
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header">
                        <s:textfield id="vendor.paymentTerm.code" name="vendor.paymentTerm.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                        <sj:a id="vendor_btnPaymentTerm" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="vendor.paymentTerm.name" name="vendor.paymentTerm.name" cssStyle="width:30%" readonly="true"></s:textfield>
                </td>
            </tr>
             <tr>
                <td align="right"><B>Local / Import *</B></td>
                <td colspan="2">
                    <s:radio id="vendorLocalImportRad" name="vendorLocalImportRad" list="{'Local','Import'}"></s:radio>
                    <s:textfield id="vendor.localImport" name="vendor.localImport" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right"><B>Critical Status *</B></td>
                <td colspan="2">
                    <s:radio id="vendorCriticalStatusRad" name="vendorCriticalStatusRad" list="{'Yes','No'}"></s:radio>
                    <s:textfield id="vendor.criticalStatus" name="vendor.criticalStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right"><B>Penalty Status *</B></td>
                <td colspan="2">
                    <s:radio id="vendorPenaltyStatusRad" name="vendorPenaltyStatusRad" list="{'Yes','No'}"></s:radio>
                    <s:textfield id="vendor.penaltyStatus" name="vendor.penaltyStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Scope</td>
                <td colspan="3">
                    <s:textarea id="vendor.scope" name="vendor.scope" cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="vendorActiveStatusRad" name="vendorActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="vendor.activeStatus" name="vendor.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="vendor.remark" name="vendor.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="vendor.inActiveBy"  name="vendor.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="vendor.inActiveDate" name="vendor.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="vendor.createdBy"  name="vendor.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="vendor.createdDate" name="vendor.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="vendorTemp.inActiveDateTemp" name="vendorTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="vendorTemp.createdDateTemp" name="vendorTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnVendorSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnVendorCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </td> 
      </table>
   </table>             
    </s:form>
</div>