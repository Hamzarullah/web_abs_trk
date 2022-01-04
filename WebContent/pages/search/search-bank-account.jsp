
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
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

    var search_bankAccount_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';   
    
    jQuery(document).ready(function(){  
        
        $("#btn_dlg_BankAccountSearch").click(function(ev) {
            $("#dlgSearch_bankAccount_grid").jqGrid("setGridParam",{url:"master/bank-account-data?" + $("#frmBankAccountSearch").serialize(), page:1});
            $("#dlgSearch_bankAccount_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#dlgBankAccount_okButton").click(function(ev) {
            selectedRowId = $("#dlgSearch_bankAccount_grid").jqGrid("getGridParam","selrow");
        
            if(selectedRowId === null){
                alert("Please Select Row Bank Account!");
                return;
            }

            var data_search_bankAccount = $("#dlgSearch_bankAccount_grid").jqGrid('getRowData', selectedRowId);

            if (search_bankAccount_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"BankAccountCode",opener.document).val(data_search_bankAccount.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BankAccountName", data_search_bankAccount.name);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"BankAccountUnitCode", data_search_bankAccount["uom.code"]);
            }    
            else{
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_bankAccount.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_bankAccount.name);
                $("#"+id_document+"\\."+id_subdoc+"\\.bbmVoucherNo",opener.document).val(data_search_bankAccount.bbmVoucherNo);
                $("#"+id_document+"\\."+id_subdoc+"\\.bbkVoucherNo",opener.document).val(data_search_bankAccount.bbkVoucherNo);
                $("#"+id_document+"\\."+id_subdoc+"\\.acNo",opener.document).val(data_search_bankAccount.acNo);
                $("#"+id_document+"\\."+id_subdoc+"\\.acName",opener.document).val(data_search_bankAccount.acName);
                $("#"+id_document+"\\."+id_subdoc+"\\.bankName",opener.document).val(data_search_bankAccount.bankName);
                $("#"+id_document+"\\."+id_subdoc+"\\.bankBranch",opener.document).val(data_search_bankAccount.bankBranch);
                $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccount\\.code",opener.document).val(data_search_bankAccount.chartOfAccountCode);
                $("#"+id_document+"\\."+id_subdoc+"\\.chartOfAccount\\.name",opener.document).val(data_search_bankAccount.chartOfAccountName);
                $("#"+id_document+"\\."+id_subdoc+"\\.documentLimitFrom",opener.document).val(data_search_bankAccount.documentLimitFrom);
                $("#"+id_document+"\\."+id_subdoc+"\\.documentLimitTo",opener.document).val(data_search_bankAccount.documentLimitTo); 
            }
       
            window.close();
        });
        
        $("#dlgBankAccount_cancelButton").click(function(ev) {
            data_search_country = null;
            window.close();
        });
        
    });    
    
</script>
<body>
<s:url id="remoteurlBankAccountSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmBankAccountSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="bankAccountSearchCode" name="bankAccountSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="bankAccountSearchName" name="bankAccountSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_BankAccountSearch" button="true">Search</sj:a></td>
            </tr>
            <td align="right">
                <s:textfield id="bankAccountSearchActiveStatus" name="bankAccountSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
            </td>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_bankAccount_grid"
            dataType="json"
            href="%{remoteurlBankAccountSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listBankAccountTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnubankAccount').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="240" sortable="true"
        />
        <sjg:gridColumn
            name="bbmVoucherNo" index="bbmVoucherNo" title="BBM Voucher No" width="100"
        />
        <sjg:gridColumn
            name="bbkVoucherNo" index="bbkVoucherNo" title="BBK Voucher No" width="100"
        />
         <sjg:gridColumn
            name="chartOfAccountCode" index="chartOfAccountCode" title="Acoount Code" width="100"
        />
        <sjg:gridColumn
            name="chartOfAccountName" index="chartOfAccountName" title="Account Name" width="100"
        />
        <sjg:gridColumn
            name="acNo" index="acNo" title="AC No" width="100"
        />
        <sjg:gridColumn
            name="acName" index="acName" title="AC Name" width="100"
        />
        <sjg:gridColumn
            name="bankName" index="bankName" title="Bank Name" width="100"
        />
        <sjg:gridColumn
            name="bankBranch" index="bankBranch" title="Bank Branch" width="100"
        />
        <sjg:gridColumn
            name="documentLimitFrom" index="documentLimitFrom" title="Document Limit From" width="100"
        />
        <sjg:gridColumn
            name="documentLimitTo" index="documentLimitTo" title="Document Limit To" width="100"
        />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgBankAccount_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgBankAccount_cancelButton" button="true">Cancel</sj:a>
</body>
</html>