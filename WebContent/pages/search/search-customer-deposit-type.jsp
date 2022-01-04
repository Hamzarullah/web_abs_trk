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
    
    var search_customerDepositType_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var id_branchCode= '<%= request.getParameter("branchCode") %>';
        
    jQuery(document).ready(function(){  
        
        $("#customerDepositType\\.branchCode").val(id_branchCode);
        
        $("#dlgCustomerDepositType_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_customerDepositType_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row CustomerDepositType!");
                return;
            }

            var data_search_customerDepositType = $("#dlgSearch_customerDepositType_grid").jqGrid('getRowData', selectedRowId);

            if (search_customerDepositType_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"CustomerDepositTypeCode",opener.document).val(data_search_customerDepositType.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CustomerDepositTypeName", data_search_customerDepositType.name);           
            }
            else {
               $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_customerDepositType.code);
               $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_customerDepositType.name);
               $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccountCode",opener.document).val(data_search_customerDepositType.chartOfAccountCode);
               $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccountName",opener.document).val(data_search_customerDepositType.chartOfAccountName);
            }

            window.close();
        });


        $("#dlgCustomerDepositType_cancelButton").click(function(ev) { 
            data_search_customerDepositType = null;
            window.close();
        });
    
    
        $("#btn_dlg_CustomerDepositTypeSearch").click(function(ev) {
            $("#dlgSearch_customerDepositType_grid").jqGrid("setGridParam",{url:"master/customer-deposit-type-search-data?" + $("#frmCustomerDepositTypeSearch").serialize(), page:1});
            $("#dlgSearch_customerDepositType_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        // Focus Field and Enter to Search data
        $("#customerDepositType\\.name").focus();
        $('form').keypress(function (e) {
            if (e.which === 13) {
                $("#btn_dlg_CustomerDepositTypeSearch").trigger('click');
            }
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlCustomerDepositTypeSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmCustomerDepositTypeSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="customerDepositType.code" name="customerDepositType.code" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="customerDepositType.name" name="customerDepositType.name" size="50"></s:textfield></td>
                </tr>
                <tr hidden="true">
                    <td align="right">Branch</td>
                    <td><s:textfield id="customerDepositType.branchCode" name="customerDepositType.branchCode" size="50" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_CustomerDepositTypeSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="customerDepositType.activeStatus" name="customerDepositType.activeStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_customerDepositType_grid"
                dataType="json"
                href="%{remoteurlCustomerDepositTypeSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listCustomerDepositTypeTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnucustomerDepositType').width()"
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

            <sj:a href="#" id="dlgCustomerDepositType_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgCustomerDepositType_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>