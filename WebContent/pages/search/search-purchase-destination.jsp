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
        overflow: scroll;
    }
</style>
    
<script type = "text/javascript">
    
    var search_purchaseDestination_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var ship_To= '<%= request.getParameter("shipTo") %>';
    var bill_To= '<%= request.getParameter("billTo") %>';
        
    jQuery(document).ready(function(){  
        
        $("#dlgPurchaseDestination_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_purchaseDestination_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row PurchaseDestination!");
                return;
            }

            var data_search_purchaseDestination = $("#dlgSearch_purchaseDestination_grid").jqGrid('getRowData', selectedRowId);

            if (search_purchaseDestination_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"PurchaseDestinationCode",opener.document).val(data_search_purchaseDestination.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"PurchaseDestinationName", data_search_purchaseDestination.name);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Address", data_search_purchaseDestination.address);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ContactPerson", data_search_purchaseDestination.contactPerson);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Phone1", data_search_purchaseDestination.phone1);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_purchaseDestination.code);
               $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_purchaseDestination.name);
               $("#"+id_document+"\\."+id_subdoc+"\\.address",opener.document).val(data_search_purchaseDestination.address);
            }  $("#"+id_document+"\\."+id_subdoc+"\\.contactPerson",opener.document).val(data_search_purchaseDestination.contactPerson);
               $("#"+id_document+"\\."+id_subdoc+"\\.phone1",opener.document).val(data_search_purchaseDestination.phone1);

            window.close();
        });


        $("#dlgPurchaseDestination_cancelButton").click(function(ev) { 
            data_search_purchaseDestination = null;
            window.close();
        });
    
    
        $("#btn_dlg_PurchaseDestinationSearch").click(function(ev) {
            $("#dlgSearch_purchaseDestination_grid").jqGrid("setGridParam",{url:"master/purchase-destination-search-data?" + $("#frmPurchaseDestinationSearch").serialize(), page:1});
            $("#dlgSearch_purchaseDestination_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#purchaseDestinationSearchShipTo").val(ship_To);
        $("#purchaseDestinationSearchBillTo").val(bill_To);
     });
    
</script>
    
<body>
<s:url id="remoteurlPurchaseDestinationSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmPurchaseDestinationSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="purchaseDestinationSearchCode" name="purchaseDestinationSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="purchaseDestinationSearchName" name="purchaseDestinationSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_PurchaseDestinationSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="purchaseDestinationSearchActiveStatus" name="purchaseDestinationSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
                <td align="right">
                    <s:textfield id="purchaseDestinationSearchShipTo" name="purchaseDestinationSearchShipTo" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td align="right">
                    <s:textfield id="purchaseDestinationSearchBillTo" name="purchaseDestinationSearchBillTo" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_purchaseDestination_grid"
                dataType="json"
                href="%{remoteurlPurchaseDestinationSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listPurchaseDestinationTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnupurchaseDestination').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="address" index="address" title="Address" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="contactPerson" index="contactPerson" title="Contact Person" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="phone1" index="phone1" title="Phone 1" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgPurchaseDestination_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgPurchaseDestination_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>