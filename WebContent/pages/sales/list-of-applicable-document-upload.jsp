
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #listOfApplicableDocumentUploadDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("listOfApplicableDocumentUpload_grid_onSelect", function(event, data){
            var selectedRowID = $("#listOfApplicableDocumentUpload_grid").jqGrid("getGridParam", "selrow"); 
            var listOfApplicableDocumentUpload = $("#listOfApplicableDocumentUpload_grid").jqGrid("getRowData", selectedRowID);
            
            $("#listOfApplicableDocumentUploadDetail_grid").jqGrid("setGridParam",{url:"sales/list-of-applicable-document-detail-data?listOfApplicableDocument.code="+ listOfApplicableDocumentUpload.code});
            $("#listOfApplicableDocumentUploadDetail_grid").jqGrid("setCaption", "LIST OF APPLICABLE DOCUMENT DETAIL : " + listOfApplicableDocumentUpload.code);
            $("#listOfApplicableDocumentUploadDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnListOfApplicableDocumentUploadUploaded').click(function(ev) {

                var selectedRowId = $("#listOfApplicableDocumentUpload_grid").jqGrid('getGridParam','selrow');
                var listOfApplicableDocumentUpload = $("#listOfApplicableDocumentUpload_grid").jqGrid('getRowData', selectedRowId);

                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                    
                var url = "sales/list-of-applicable-document-upload-input";
                var params = "listOfApplicableDocumentUploadUpdateMode =true" ;
                    params+="&listOfApplicableDocumentUpload.code=" + listOfApplicableDocumentUpload.code;
                    pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT_UPLOAD");
        });
     

//        $('#btnListOfApplicableDocumentUploadDelete').click(function(ev) {
//            var deleteRowId = $("#listOfApplicableDocumentUpload_grid").jqGrid('getGridParam','selrow');
//            var listOfApplicableDocumentUpload = $("#listOfApplicableDocumentUpload_grid").jqGrid('getRowData', deleteRowId);
//                
//            var url = "finance/list-of-applicable-document-delete";
//            var params = "listOfApplicableDocumentUpload.code=" + listOfApplicableDocumentUpload.code;
//
//            var dynamicDialog= $(
//                '<div id="conformBoxError">'+
//                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                '</span>Are You Sure To Delete?<br/><br/>' +
//                '<span style="float:left; margin:0 7px 20px 0;">'+
//                '</span>LAD No: '+listOfApplicableDocumentUpload.code+'<br/><br/>' +    
//                '</div>');
//            dynamicDialog.dialog({
//                title        : "Confirmation",
//                closeOnEscape: false,
//                modal        : true,
//                width        : 300,
//                resizable    : false,
//                buttons      : 
//                            [{
//                                text : "Yes",
//                                click : function() {
//                                    $.post(url, params, function(data) {
//                                        if (data.error) {
//                                            alertMessage(data.errorMessage);
//                                            return;
//                                        }
//                                        reloadGridLAD();
//                                        reloadDetailGridLAD();
//                                    });  
//                                    $(this).dialog("close");
//                                }
//                            },
//                            {
//                                text : "No",
//                                click : function() {
//                                    $(this).dialog("close");                                       
//                                }
//                            }]
//            });
//            ev.preventDefault();
//        });

        $('#btnListOfApplicableDocumentUploadRefresh').click(function(ev) {
            var url = "sales/list-of-applicable-document-upload";
            var params = "";
            pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT_UPLOAD");
            ev.preventDefault();   
        });
        
        $('#btnListOfApplicableDocumentUpload_search').click(function(ev) {
            formatDateLAD();
            $("#listOfApplicableDocumentUpload_grid").jqGrid("clearGridData");
            $("#listOfApplicableDocumentUpload_grid").jqGrid("setGridParam",{url:"sales/list-of-applicable-document-data?" + $("#frmListOfApplicableDocumentUploadSearchInput").serialize()});
            $("#listOfApplicableDocumentUpload_grid").trigger("reloadGrid");
            $("#listOfApplicableDocumentUploadDetail_grid").jqGrid("clearGridData");
            $("#listOfApplicableDocumentUploadDetail_grid").jqGrid("setCaption", "LIST OF APPLICABLE DOCUMENT DETAIL");
            formatDateLAD();
            ev.preventDefault();
        });
        
        $("#btnListOfApplicableDocumentUploadPrint").click(function(ev) {
            var selectRowId = $("#listOfApplicableDocumentUpload_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            else{
            var listOfApplicableDocumentUpload = $("#listOfApplicableDocumentUpload_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/sales/list-of-applicable-document-print-out-pdf?";
            var params ="code=" + listOfApplicableDocumentUpload.code;
        
            window.open(url+params,'listOfApplicableDocumentUpload','width=500,height=500');}
            ev.preventDefault();
        });
    });//EOF Ready
    
    function formatDateLAD(){
        var transactionDateSplit=$("#listOfApplicableDocumentUpload\\.transactionDate").val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        $("#listOfApplicableDocumentUpload\\.transactionDate").val(transactionDate); 
        
        var firstDate=$("#listOfApplicableDocumentUpload\\.transactionFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#listOfApplicableDocumentUpload\\.transactionFirstDate").val(firstDateValue);

        var lastDate=$("#listOfApplicableDocumentUpload\\.transactionLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#listOfApplicableDocumentUpload\\.transactionLastDate").val(lastDateValue);
    }
    
    function reloadGridLAD() {
        $("#listOfApplicableDocumentUpload_grid").trigger("reloadGrid");
      
    };

    function reloadDetailGridLAD() {
        $("#listOfApplicableDocumentUploadDetail_grid").trigger("reloadGrid");  
        $("#listOfApplicableDocumentUploadDetail_grid").jqGrid("clearGridData");
        $("#listOfApplicableDocumentUploadDetail_grid").jqGrid("setCaption", "LIST OF APPLICABLE DOCUMENT DETAIL");
    };
    
</script>
<s:url id="remoteurlListOfApplicableDocumentUpload" action="list-of-applicable-document-json" />    
    <b>LIST OF APPLICABLE DOCUMENT UPLOAD</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="listOfApplicableDocumentUploadButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <!--<a href="#" id="btnListOfApplicableDocumentUploadNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/></a>-->
<!--        <a href="#" id="btnListOfApplicableDocumentUploadUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/></a>
        <a href="#" id="btnListOfApplicableDocumentUploadDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/></a>-->
        <a href="#" id="btnListOfApplicableDocumentUploadRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>        
        <!--<a href="#" id="btnListOfApplicableDocumentUploadPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/></a>-->
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="ListOfApplicableDocumentUploadInputSearch" class="content ui-widget">
        <s:form id="frmListOfApplicableDocumentUploadSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="listOfApplicableDocumentUpload.transactionFirstDate" name="listOfApplicableDocumentUpload.transactionFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="listOfApplicableDocumentUpload.transactionLastDate" name="listOfApplicableDocumentUpload.transactionLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr/>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="listOfApplicableDocumentUpload.code" name="listOfApplicableDocumentUpload.code" size="25" placeHolder=" LAD No"></s:textfield>
                    </td>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="listOfApplicableDocumentUpload.refNo" name="listOfApplicableDocumentUpload.refNo" size="25"></s:textfield>
                    </td>
                    <td align="right">Customer</td>
                    <td>
                        <s:textfield id="listOfApplicableDocumentUpload.salesOrderCustomerCode" name="listOfApplicableDocumentUpload.salesOrderCustomerCode" size="15" placeHolder=" Code"></s:textfield>
                        <s:textfield id="listOfApplicableDocumentUpload.salesOrderCustomerName" name="listOfApplicableDocumentUpload.salesOrderCustomerName" size="35" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">SOD No</td>
                    <td>
                        <s:textfield id="listOfApplicableDocumentUpload.salesOrderCode" name="listOfApplicableDocumentUpload.salesOrderCode" size="25"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="listOfApplicableDocumentUpload.remark" name="listOfApplicableDocumentUpload.remark" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnListOfApplicableDocumentUpload_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="ListOfApplicableDocumentUploadGrid">
        <sjg:grid
            id="listOfApplicableDocumentUpload_grid"
            caption="LIST OF APPLICABLE DOCUMENT"
            dataType="json"
            href="%{remoteurlListOfApplicableDocumentUpload}"
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
            onSelectRowTopics="listOfApplicableDocumentUpload_grid_onSelect"
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
    
    <div>
    <sj:a href="#" id="btnListOfApplicableDocumentUploadUploaded" button="true" style="width: 90px">Upload</sj:a>
    </div>
    
    <br class="spacer" />
    <br class="spacer" />

    <div id="listOfApplicableDocumentUploadDetailGrid">
        <sjg:grid
            id="listOfApplicableDocumentUploadDetail_grid"
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
    

