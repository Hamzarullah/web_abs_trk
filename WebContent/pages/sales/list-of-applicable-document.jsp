
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #listOfApplicableDocumentDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("listOfApplicableDocument_grid_onSelect", function(event, data){
            var selectedRowID = $("#listOfApplicableDocument_grid").jqGrid("getGridParam", "selrow"); 
            var listOfApplicableDocument = $("#listOfApplicableDocument_grid").jqGrid("getRowData", selectedRowID);
            
            $("#listOfApplicableDocumentDetail_grid").jqGrid("setGridParam",{url:"sales/list-of-applicable-document-detail-data?listOfApplicableDocument.code="+ listOfApplicableDocument.code});
            $("#listOfApplicableDocumentDetail_grid").jqGrid("setCaption", "LIST OF APPLICABLE DOCUMENT DETAIL : " + listOfApplicableDocument.code);
            $("#listOfApplicableDocumentDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnListOfApplicableDocumentNew').click(function(ev) {
            
            var url = "sales/list-of-applicable-document-input";
            var params = "enumListApplicableDocumentActivity=NEW";

            pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");
                    
        });

        $('#btnListOfApplicableDocumentDelete').click(function(ev) {
            var deleteRowId = $("#listOfApplicableDocument_grid").jqGrid('getGridParam','selrow');
            var listOfApplicableDocument = $("#listOfApplicableDocument_grid").jqGrid('getRowData', deleteRowId);
                
            var url = "finance/list-of-applicable-document-delete";
            var params = "listOfApplicableDocument.code=" + listOfApplicableDocument.code;

            var dynamicDialog= $(
                '<div id="conformBoxError">'+
                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>Are You Sure To Delete?<br/><br/>' +
                '<span style="float:left; margin:0 7px 20px 0;">'+
                '</span>LAD No: '+listOfApplicableDocument.code+'<br/><br/>' +    
                '</div>');
            dynamicDialog.dialog({
                title        : "Confirmation",
                closeOnEscape: false,
                modal        : true,
                width        : 300,
                resizable    : false,
                buttons      : 
                            [{
                                text : "Yes",
                                click : function() {
                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridLAD();
                                        reloadDetailGridLAD();
                                    });  
                                    $(this).dialog("close");
                                }
                            },
                            {
                                text : "No",
                                click : function() {
                                    $(this).dialog("close");                                       
                                }
                            }]
            });
            ev.preventDefault();
        });

        $('#btnListOfApplicableDocumentRefresh').click(function(ev) {
            var url = "sales/list-of-applicable-document";
            var params = "";
            pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");
            ev.preventDefault();   
        });
        
        $('#btnListOfApplicableDocument_search').click(function(ev) {
            formatDateLAD();
            $("#listOfApplicableDocument_grid").jqGrid("clearGridData");
            $("#listOfApplicableDocument_grid").jqGrid("setGridParam",{url:"sales/list-of-applicable-document-data?" + $("#frmListOfApplicableDocumentSearchInput").serialize()});
            $("#listOfApplicableDocument_grid").trigger("reloadGrid");
            $("#listOfApplicableDocumentDetail_grid").jqGrid("clearGridData");
            $("#listOfApplicableDocumentDetail_grid").jqGrid("setCaption", "LIST OF APPLICABLE DOCUMENT DETAIL");
            formatDateLAD();
            ev.preventDefault();
           
        });
        
        $("#btnListOfApplicableDocumentClone").click(function (ev) {
            
            var selectRowId = $("#listOfApplicableDocument_grid").jqGrid('getGridParam','selrow');
            var listOfApplicableDocument = $("#listOfApplicableDocument_grid").jqGrid("getRowData", selectRowId);
            var listOfApplicableDocumentCode = listOfApplicableDocument.code;
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="sales/list-of-applicable-document-authority";
            var params="actionAuthority=INSERT";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                var url = "sales/list-of-applicable-document-input";
                var params = "enumListApplicableDocumentActivity=CLONE";
                    params+="&listOfApplicableDocument.code=" + listOfApplicableDocumentCode;
                pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");

            });
            ev.preventDefault();
    
        });
        
        $("#btnListOfApplicableDocumentUpdate").click(function(ev){
            var selectRowId = $("#listOfApplicableDocument_grid").jqGrid('getGridParam','selrow');
            var listOfApplicableDocument = $("#listOfApplicableDocument_grid").jqGrid("getRowData", selectRowId);
            var listOfApplicableDocumentCode = listOfApplicableDocument.code;
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="sales/list-of-applicable-document-authority";
            var params="actionAuthority=INSERT";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                var url = "sales/list-of-applicable-document-input";
                var params = "enumListApplicableDocumentActivity=UPDATE";
                    params+="&listOfApplicableDocument.code=" + listOfApplicableDocumentCode;
                pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");

            });
            ev.preventDefault();
        });
        
        $("#btnListOfApplicableDocumentPrint").click(function(ev) {
            var selectRowId = $("#listOfApplicableDocument_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            else{
            var listOfApplicableDocument = $("#listOfApplicableDocument_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/sales/list-of-applicable-document-print-out-pdf?";
            var params ="code=" + listOfApplicableDocument.code;
        
            window.open(url+params,'listOfApplicableDocument','width=500,height=500');}
            ev.preventDefault();
        });
    });//EOF Ready
    
    function formatDateLAD(){
        var firstDate=$("#listOfApplicableDocument\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#listOfApplicableDocument\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#listOfApplicableDocument\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#listOfApplicableDocument\\.transactionLastDate").val(lastDateValue);
    }
    
    function reloadGridLAD() {
        $("#listOfApplicableDocument_grid").trigger("reloadGrid");
      
    };

    function reloadDetailGridLAD() {
        $("#listOfApplicableDocumentDetail_grid").trigger("reloadGrid");  
        $("#listOfApplicableDocumentDetail_grid").jqGrid("clearGridData");
        $("#listOfApplicableDocumentDetail_grid").jqGrid("setCaption", "LIST OF APPLICABLE DOCUMENT DETAIL");
    };
    
</script>
<s:url id="remoteurlListOfApplicableDocument" action="list-of-applicable-document-json" />    
    <b>LIST OF APPLICABLE DOCUMENT</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="listOfApplicableDocumentButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <a href="#" id="btnListOfApplicableDocumentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/>New</a>
        <a href="#" id="btnListOfApplicableDocumentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/>Update</a>
        <a href="#" id="btnListOfApplicableDocumentClone" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Clone"/>Clone</a>
        <a href="#" id="btnListOfApplicableDocumentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/>Refresh</a>        
        <a href="#" id="btnListOfApplicableDocumentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/>Print</a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="ListOfApplicableDocumentInputSearch" class="content ui-widget">
        <s:form id="frmListOfApplicableDocumentSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="listOfApplicableDocument.transactionFirstDate" name="listOfApplicableDocument.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="listOfApplicableDocument.transactionLastDate" name="listOfApplicableDocument.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">LAD-No</td>
                    <td>
                        <s:textfield id="listOfApplicableDocument.code" name="listOfApplicableDocument.code" size="25" placeHolder=" LAD No"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="listOfApplicableDocument.refNo" name="listOfApplicableDocument.refNo" size="25"></s:textfield>
                    </td>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="listOfApplicableDocument.salesOrderCustomerCode" name="listOfApplicableDocument.salesOrderCustomerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="listOfApplicableDocument.salesOrderCustomerName" name="listOfApplicableDocument.salesOrderCustomerName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">SOD No</td>
                    <td>
                        <s:textfield id="listOfApplicableDocument.salesOrderCode" name="listOfApplicableDocument.salesOrderCode" size="25"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="listOfApplicableDocument.remark" name="listOfApplicableDocument.remark" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnListOfApplicableDocument_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="ListOfApplicableDocumentGrid">
        <sjg:grid
            id="listOfApplicableDocument_grid"
            caption="LIST OF APPLICABLE DOCUMENT"
            dataType="json"
            href="%{remoteurlListOfApplicableDocument}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listListOfApplicableDocument"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnulistofapplicabledocument').width()"
            onSelectRowTopics="listOfApplicableDocument_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" title = "Branch" width = "50" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="salesOrderCode" index="salesOrderCode" key="salesOrderCode" title="SalesOrderCode" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="salesOrderSource" index="salesOrderSource" key="salesOrderSource" title="SalesOrderSource" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="salesOrderCustomerCode" index="salesOrderCustomerCode" key="salesOrderCustomerCode" title="Customer Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="salesOrderCustomerName" index="salesOrderCustomerName" key="salesOrderCustomerName" title="Customer Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="salesOrderSalesPersonCode" index="salesOrderSalesPersonCode" key="salesOrderSalesPersonCode" title="SalesPerson Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="salesOrderSalesPersonName" index="salesOrderSalesPersonName" key="salesOrderSalesPersonName" title="SalesPerson Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        </sjg:grid >
    </div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="listOfApplicableDocumentDetailGrid">
        <sjg:grid
            id="listOfApplicableDocumentDetail_grid"
            caption="LIST OF APPLICABLE DOCUMENT DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="true"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listListOfApplicableDocumentDetail"
            width="$('#tabmnulistofapplicabledocumentdetail').width()"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "nameOfDocument" id="nameOfDocument" index = "nameOfDocument" key = "nameOfDocument" title = "NameOfDocument" width = "150"
            />
            <sjg:gridColumn
                name = "documentNo" id="documentNo" index = "documentNo" key = "documentNo" title = "DocumentNo" width = "150"
            />
            <sjg:gridColumn
                name = "versionEdition" id="versionEdition" index = "versionEdition" key = "versionEdition" title = "VersionEdition" width = "200"
            />
        </sjg:grid >
        <br class="spacer" />
        <br class="spacer" />
    

