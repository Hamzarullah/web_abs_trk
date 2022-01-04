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

        var search_cashAccount_type= '<%= request.getParameter("type") %>';
        var id_document = '<%= request.getParameter("iddoc") %>';
        var id_subdoc = '<%= request.getParameter("idsubdoc") %>';
        
        jQuery(document).ready(function(){  

            $("#dlgCashAccount_okButton").click(function(ev) { 
                selectedRowId = $("#dlgSearch_cashAccount_grid").jqGrid("getGridParam","selrow");

                if(selectedRowId === null){
                    alert("Please Select Row CashAccount");
                    return;
                }

                var data_search_cashAccount = $("#dlgSearch_cashAccount_grid").jqGrid('getRowData', selectedRowId);
                    
                if (search_cashAccount_type === "grid" ) {
                    var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                    $("#"+selectedRowID+"_"+id_document+"CashAccountCode",opener.document).val(data_search_cashAccount.code);
                    $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"CashAccountName", data_search_cashAccount.name);           
                }else{
                    $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_cashAccount.code);
                    $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_cashAccount.name);
                    $("#"+id_document+"\\."+id_subdoc+"\\.bkkVoucherNo",opener.document).val(data_search_cashAccount.bkkVoucherNo);
                    $("#"+id_document+"\\."+id_subdoc+"\\.bkmVoucherNo",opener.document).val(data_search_cashAccount.bkmVoucherNo);
                    $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccount\\.code",opener.document).val(data_search_cashAccount.chartOfAccountCode);
                    $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccount\\.name",opener.document).val(data_search_cashAccount.chartOfAccountName); 
                    $("#"+id_document+"\\."+id_subdoc+"\\.documentLimitFrom",opener.document).val(data_search_cashAccount.documentLimitFrom);
                    $("#"+id_document+"\\."+id_subdoc+"\\.documentLimitTo",opener.document).val(data_search_cashAccount.documentLimitTo);
                }
                                
                window.close();
               
            });


            $("#dlgCashAccount_cancelButton").click(function(ev) { 
                data_search_cashAccount = null;
                window.close();
            });


            $("#btn_dlg_CashAccountSearch").click(function(ev) {
                $("#dlgSearch_cashAccount_grid").jqGrid("setGridParam",{url:"master/cash-account-data?" + $("#frmCashAccountSearch").serialize(), page:1});
                $("#dlgSearch_cashAccount_grid").trigger("reloadGrid");
                ev.preventDefault();
            });


         });

    </script>
<body>
    <s:url id="remoteurlCashAccountSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmCashAccountSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td>
                    <s:textfield id="cashAccountSearchCode" name="cashAccountSearchCode" label="Code "></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td>
                    <s:textfield id="cashAccountSearchName" name="cashAccountSearchName" size="50"></s:textfield>
                </td>
                <td align="right">
                    <s:textfield id="cashAccountSearchActiveStatus" name="cashAccountSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_CashAccountSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>

    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_cashAccount_grid"
            dataType="json"
            href="%{remoteurlCashAccountSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listCashAccountTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnucashAccount').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="330" sortable="true"
            />
            <sjg:gridColumn
                 name="chartOfAccountCode" index="chartOfAccountCode" title="Account No" width="300" sortable="true"
             />
             <sjg:gridColumn
                 name="chartOfAccountName" index="chartOfAccountName" title="Account Name" width="300" sortable="true"
             />
             <sjg:gridColumn
                 name="bkmVoucherNo" index="bkmVoucherNo" title="BKM Voucher No" width="300" sortable="true"
             />
             <sjg:gridColumn
                 name="bkkVoucherNo" index="bkkVoucherNo" title="BKK Voucher No" width="300" sortable="true"
             />
             <sjg:gridColumn
                 name="documentLimitFrom" index="documentLimitFrom" title="Document Limit From" width="300" sortable="true"
             />
             <sjg:gridColumn
                 name="documentLimitTo" index="documentLimitTo" title="Document Limit To" width="300" sortable="true"
             />
            <sjg:gridColumn
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />
        </sjg:grid >

    </div>
    <br class="spacer"/>
    <sj:a href="#" id="dlgCashAccount_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgCashAccount_cancelButton" button="true">Cancel</sj:a>
</body>
</html>