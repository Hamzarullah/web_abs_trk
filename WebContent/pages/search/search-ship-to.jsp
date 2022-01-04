<%-- 
    Document   : search-ship-to
    Created on : Nov 13, 2017, 5:45:58 PM
    Author     : jason
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
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    
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
    
    var search_customerAddress_type = '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc = '<%= request.getParameter("idsubdoc") %>';
    var customerCode = '<%= request.getParameter("customerCode") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgCustomerAddress_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_customerAddress_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row CustomerAddress!");
                return;
            }

            var data_search_customerAddress = $("#dlgSearch_customerAddress_grid").jqGrid('getRowData', selectedRowId);

            if (search_customerAddress_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+".customerAddress.code",opener.document).val(data_search_customerAddress.code);
                $("#"+id_document+"Input",opener.document).jqGrid("setCell", selectedRowID, id_document+".customerAddress.name", data_search_customerAddress.name);           
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_customerAddress.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_customerAddress.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_customerAddress.address);
                $("#"+id_document+"\\."+id_subdoc+"\\.phone1",opener.document).val(data_search_customerAddress.phone1);
                $("#"+id_document+"\\."+id_subdoc+"\\.fax",opener.document).val(data_search_customerAddress.fax);
                $("#"+id_document+"\\."+id_subdoc+"\\.city\\.name",opener.document).val(data_search_customerAddress.cityName);
                $("#"+id_document+"\\."+id_subdoc+"\\.contactPerson",opener.document).val(data_search_customerAddress.contactPerson);
            }

            window.close();
        });


        $("#dlgCustomerAddress_cancelButton").click(function(ev) { 
            data_search_customerAddress = null;
            window.close();
        });
    
    
        $("#btn_dlg_CustomerAddressSearch").click(function(ev) {
            if (customerCode ==="" || customerCode ==="null" ){
            $("#dlgSearch_customerAddress_grid").jqGrid("setGridParam",{url:"master/customer-address-search-customer-detail?" + $("#frmCustomerAddressSearch").serialize(), page:1});
            $("#dlgSearch_customerAddress_grid").trigger("reloadGrid");
            ev.preventDefault();
            }
        });
        
        $("#customerAddressSearchCustomerCode").val(customerCode);
        
     });
    
</script>
    
<body>
<s:url id="remoteurlCustomerAddressSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmCustomerAddressSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="customerAddressSearchCode" name="customerAddressSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="customerAddressSearchName" name="customerAddressSearchName" size="50"></s:textfield></td>
                </tr>
                <tr style="display: none;">
                    <td align="right">Customer Code</td>
                    <td><s:textfield id="customerAddressSearchCustomerCode" name="customerAddressSearchCustomerCode" size="50" readonly="true"></s:textfield></td>
                </tr>
                <tr style="display:none;">
                    <td align="right"></td>
                    <td><s:textfield id="searchCustomerAddresDetailStatus" name="searchCustomerAddresDetailStatus" size="50" value="ShipTo"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerAddressSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="customerAddressSearchActiveStatus" name="customerAddressSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_customerAddress_grid"
                dataType="json"
                href="%{remoteurlCustomerAddressSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listCustomerAddressTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnucustomerAddress').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" key="name" title="Name" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="customerCode" index="customerCode" title="Customer Code" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="customerName" index="customerName" title="Customer Name" width="300" sortable="true"
                />
                <sjg:gridColumn
                    name="address" index="address" title="Address" width="300" sortable="true"
                />
                <sjg:gridColumn
                    name="phone1" index="phone1" title="Phone 1" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="fax" index="fax" title="Fax" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="cityName" index="cityName" title="City Name" width="300" sortable="true"
                />
                <sjg:gridColumn
                    name="contactPerson" index="contactPerson" title="Contact Person" width="150" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgCustomerAddress_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgCustomerAddress_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>
