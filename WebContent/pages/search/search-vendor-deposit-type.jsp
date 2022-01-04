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
    
    var search_vendorDepositType_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_branchCode= '<%= request.getParameter("branchCode") %>';
        
    jQuery(document).ready(function(){  
        
        $("#vendorDepositType\\.branchCode").val(id_branchCode);
        
        $("#dlgVendorDepositType_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_vendorDepositType_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row VendorDepositType!");
                return;
            }

            var data_search_vendorDepositType = $("#dlgSearch_vendorDepositType_grid").jqGrid('getRowData', selectedRowId);

            if (search_vendorDepositType_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"VendorDepositTypeCode",opener.document).val(data_search_vendorDepositType.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"VendorDepositTypeName", data_search_vendorDepositType.name);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_vendorDepositType.code);
               $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_vendorDepositType.name);
               $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccountCode",opener.document).val(data_search_vendorDepositType.chartOfAccountCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccountName",opener.document).val(data_search_vendorDepositType.chartOfAccountName);
            }

            window.close();
        });


        $("#dlgVendorDepositType_cancelButton").click(function(ev) { 
            data_search_vendorDepositType = null;
            window.close();
        });
    
    
        $("#btn_dlg_VendorDepositTypeSearch").click(function(ev) {
            $("#dlgSearch_vendorDepositType_grid").jqGrid("setGridParam",{url:"master/vendor-deposit-type-search-data?" + $("#frmVendorDepositTypeSearch").serialize(), page:1});
            $("#dlgSearch_vendorDepositType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        // Focus Field and Enter to Search data
        $("#vendorDepositType\\.name").focus();
        $('form').keypress(function (e) {
            if (e.which === 13) {
                $("#btn_dlg_VendorDepositTypeSearch").trigger('click');
            }
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlVendorDepositTypeSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmVendorDepositTypeSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="vendorDepositType.code" name="vendorDepositType.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="vendorDepositType.name" name="vendorDepositType.name" size="50"></s:textfield></td>
                </tr>
                <tr hidden="true">
                    <td align="right">Branch</td>
                    <td><s:textfield id="vendorDepositType.branchCode" name="vendorDepositType.branchCode" size="50" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_VendorDepositTypeSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="vendorDepositType.activeStatus" name="vendorDepositType.activeStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_vendorDepositType_grid"
                dataType="json"
                href="%{remoteurlVendorDepositTypeSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listVendorDepositTypeTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuvendorDepositType').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="chartOfAccountCode" index="chartOfAccountCode" title="Chart Of Account Code" width="250" sortable="true"
                />
                <sjg:gridColumn
                    name="chartOfAccountName" index="chartOfAccountName" title="Chart Of Account Name" width="300" sortable="true"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgVendorDepositType_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgVendorDepositType_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>