<%-- 
    Document   : search-vendor
    Created on : May 8, 2018, 2:25:51 PM
    Author     : IKB_CHRISR
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
    <sj:head
        loadAtOnce="true"
        compressed="false"
        jqueryui="true"
        jquerytheme="cupertino"
        loadFromGoogle="false"
        debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
    </style>
    
<script type = "text/javascript">
    
    var search_vendor_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_subdocsub= '<%= request.getParameter("idsubdocsub") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgVendor_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_vendor_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row Vendor!");
                return;
            }

            var data_search_vendor = $("#dlgSearch_vendor_grid").jqGrid('getRowData', selectedRowId);

            if (search_vendor_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"VendorCode",opener.document).val(data_search_vendor.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"VendorName", data_search_vendor.name);           
            
            }
            else {
                if(id_document==="purchaseOrder"){
                    $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_vendor.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_vendor.name);
                    $("#"+id_document+"\\."+id_subdoc+"\\.defaultContactPerson\\.code",opener.document).val(data_search_vendor.defaultContactPersonCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.defaultContactPerson\\.name",opener.document).val(data_search_vendor.defaultContactPersonName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_vendor.address);
                    $("#"+id_document+"\\."+id_subdoc+"\\.phone1",opener.document).val(data_search_vendor.phone1);
                    $("#"+id_document+"\\."+id_subdoc+"\\.phone2",opener.document).val(data_search_vendor.phone2);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.code",opener.document).val(data_search_vendor.cityCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.name",opener.document).val(data_search_vendor.cityName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.province\\.country\\.code",opener.document).val(data_search_vendor.countryCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.province\\.country\\.name",opener.document).val(data_search_vendor.countryName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.email",opener.document).val(data_search_vendor.email);
                    $("#"+id_document+"\\."+id_subdoc+"\\.fax",opener.document).val(data_search_vendor.fax);
                    $("#"+id_document+"\\."+id_subdoc+"\\.serviceSupplyStatus",opener.document).val(data_search_vendor.serviceSupplyStatus);
                    $("#"+id_document+"\\."+id_subdoc+"\\.taxStatus",opener.document).val(data_search_vendor.taxStatus);
                    $("#"+id_document+"\\.taxStatus",opener.document).val(data_search_vendor.taxStatus);
                    $("#"+id_document+"\\.paymentTerm\\.code",opener.document).val(data_search_vendor.paymentTermCode);
                    $("#"+id_document+"\\.paymentTerm\\.name",opener.document).val(data_search_vendor.paymentTermName);
                }else{
                    $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_vendor.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_vendor.name);
                    $("#"+id_document+"\\."+id_subdoc+"\\.defaultContactPerson\\.code",opener.document).val(data_search_vendor.defaultContactPersonCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.defaultContactPerson\\.name",opener.document).val(data_search_vendor.defaultContactPersonName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_vendor.address);
                    $("#"+id_document+"\\."+id_subdoc+"\\.phone1",opener.document).val(data_search_vendor.phone1);
                    $("#"+id_document+"\\."+id_subdoc+"\\.phone2",opener.document).val(data_search_vendor.phone2);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.code",opener.document).val(data_search_vendor.cityCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.name",opener.document).val(data_search_vendor.cityName);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.province\\.country\\.code",opener.document).val(data_search_vendor.countryCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.city\\.province\\.country\\.name",opener.document).val(data_search_vendor.countryName);
                    $("#"+id_document+"\\.paymentTerm\\.code",opener.document).val(data_search_vendor.paymentTermCode);
                    $("#"+id_document+"\\.paymentTerm\\.name",opener.document).val(data_search_vendor.paymentTermName);
                    $("#"+id_document+"\\.paymentTerm\\.days",opener.document).val(data_search_vendor.paymentTermDays);
                    $("#"+id_document+"\\."+id_subdoc+"\\.email",opener.document).val(data_search_vendor.email);
                    $("#"+id_document+"\\."+id_subdoc+"\\.fax",opener.document).val(data_search_vendor.fax);
                    $("#"+id_document+"\\."+id_subdoc+"\\.taxStatus",opener.document).val(data_search_vendor.taxStatus);
                    $("#"+id_document+"\\.taxStatus",opener.document).val(data_search_vendor.taxStatus);
                }
                
                if(id_document==="purchaseOrder"){
                    window.opener.loadImportLocal(data_search_vendor.localImport);
                    var status = data_search_vendor.penaltyStatus;
                    if(status === "true"){
                        status = "YES";
                    }else{
                        status = "NO";
                    }
                    window.opener.enabledDisabledPenaltyPercent(status);
                }

                if (data_search_vendor.taxStatus === "EXCLUDE_TAX") {
                    $("#"+id_document+"\\.vatPercent",opener.document).val("10.00");
                }else if (data_search_vendor.taxStatus === "INCLUDE_TAX") {
                    $("#"+id_document+"\\.vatPercent",opener.document).val("10.00");
                }else {
                    $("#"+id_document+"\\.vatPercent",opener.document).val("0.00");
                }
            }

            window.close();
        });


        $("#dlgVendor_cancelButton").click(function(ev) { 
            data_search_vendor = null;
            window.close();
        });
    
    
        $("#btn_dlg_VendorSearch").click(function(ev) {
            $("#dlgSearch_vendor_grid").jqGrid("setGridParam",{url:"master/vendor-data?" + $("#frmVendorSearch").serialize(), page:1});
            $("#dlgSearch_vendor_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
     });
    
</script>
    
<body>
<s:url id="remoteurlVendorSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmVendorSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="vendorSearchCode" name="vendorSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="vendorSearchName" name="vendorSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_VendorSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="vendorSearchActiveStatus" name="vendorSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_vendor_grid"
                dataType="json"
                href="%{remoteurlVendorSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listVendorTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuvendor').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="defaultContactPersonCode" index="defaultContactPersonCode" title="Contact Person" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="defaultContactPersonName" index="defaultContactPersonName" title="Contact Person" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="address" index="address" title="Address" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="cityCode" index="cityCode" title="City Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="cityName" index="cityName" title="City Name" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="countryCode" index="countryCode" title="Country Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="countryName" index="countryName" title="Country Name" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="phone1" index="phone1" title="Phone1" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="phone2" index="phone2" title="Phone2" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="email" index="email" title="email" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="fax" index="fax" title="fax" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
                <sjg:gridColumn
                    name="paymentTermCode" index="paymentTermCode" title="Payment Term Code" width="100" sortable="true" align="center"
                />
                <sjg:gridColumn
                    name="paymentTermName" index="paymentTermName" title="Payment Term Name" width="100" sortable="true" align="center"
                />
                <sjg:gridColumn
                    name="paymentTermDays" index="paymentTermDays" title="Payment Term Days" width="100" sortable="true" align="center"
                />
                <sjg:gridColumn
                    name="taxStatus" index="taxStatus" title="Tax Status" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="localImport" index="localImport" title="" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="penaltyStatus" index="penaltyStatus" title="" width="100" sortable="true"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgVendor_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgVendor_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>