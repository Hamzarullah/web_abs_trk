
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #generalJournalDetail_grid_pager_center{
        display: none;
    }
</style>

<s:url id="remoteurlGeneralJournal" action="general-journal-json" />
<script type="text/javascript">
                    
    $(document).ready(function(){
        
        hoverButton();
               
        $.subscribe("generalJournal_grid_onSelect", function(event, data){
            var selectedRowID = $("#generalJournal_grid").jqGrid("getGridParam", "selrow"); 
            var generalJournal = $("#generalJournal_grid").jqGrid("getRowData", selectedRowID);
            
            $("#generalJournalDetail_grid").jqGrid("setGridParam",{url:"finance/general-journal-detail-data?generalJournal.code="+ generalJournal.code});
            $("#generalJournalDetail_grid").jqGrid("setCaption", "General Journal Detail : " + generalJournal.code);
            $("#generalJournalDetail_grid").trigger("reloadGrid");
        });
        
        $('#btnGeneralJournalNew').click(function(ev) {
            var url="security/data-protection-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/general-journal-input";
                var params = "";
                pageLoad(url, params, "#tabmnuGENERAL_JOURNAL"); 

            });        
        });
        
        $('#btnGeneralJournalUpdate').click(function(ev) {

            var selectRowId = $("#generalJournal_grid").jqGrid('getGridParam','selrow');
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="security/data-protection-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var generalJournal = $("#generalJournal_grid").jqGrid("getRowData", selectRowId);
                       
                var url = "finance/general-journal-input";
                var params = "generalJournalUpdateMode=true" + "&generalJournal.code=" + generalJournal.code;
                pageLoad(url, params, "#tabmnuGENERAL_JOURNAL");

            });
        });
        

        $('#btnGeneralJournalRefresh').click(function(ev) {
            var url = "finance/general-journal";
            var params = "";
            pageLoad(url, params, "#tabmnuGENERAL_JOURNAL");
            ev.preventDefault();   
        });
        
        
        $('#btnGeneralJournal_search').click(function(ev) {
            formatDateGeneralJournal();
            $("#generalJournal_grid").jqGrid("clearGridData");
            $("#generalJournal_grid").jqGrid("setGridParam",{url:"finance/general-journal-data?" + $("#frmGeneralJournalSearchInput").serialize()});
            $("#generalJournal_grid").trigger("reloadGrid");
            $("#generalJournalDetail_grid").jqGrid("clearGridData");
            $("#generalJournalDetail_grid").jqGrid("setCaption", "General Journal Detail");
            ev.preventDefault();
            formatDateGeneralJournal();
        });
        
        
        $('#btnGeneralJournalDelete').click(function(ev) {
            var selectedRowId = $("#generalJournal_grid").jqGrid('getGridParam','selrow');
            if (selectedRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var url="security/data-protection-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage); 
                    return;
                }

                var generalJournal = $("#generalJournal_grid").jqGrid('getRowData', selectedRowId);
            
                var url = "finance/general-journal-authority-delete";
                var params ="&actionAuthority=DELETE";

                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage); 
                        return;
                    }

                    var dynamicDialog= $(
                                    '<div id="conformBoxError">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>Are You Sure To Delete?<br/><br/>' +
                                    '<span style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>GJM No: '+generalJournal.code+'<br/><br/>' +    
                                    '</div>');
                        dynamicDialog.dialog({
                            title : "Confirmation",
                            closeOnEscape: false,
                            modal : true,
                            width: 300,
                            resizable: false,
                            buttons : 
                                [{
                                    text : "Yes",
                                    click : function() {
                                        var url = "finance/general-journal-delete";
                                        var params = "generalJournal.code=" + generalJournal.code;

                                        $.post(url, params, function(data) {
                                            if (data.error) {
                                                alert(data.errorMessage);
                                                return;
                                            }
                                            reloadGridGeneralJournal();
                                            reloadGridGeneralJournalDetailAfterDelete();
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
                });   

            });
        });
        
        $("#btnGeneralJournalPrint").click(function(ev) {
            var selectRowId = $("#generalJournal_grid").jqGrid('getGridParam','selrow');
           
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            var generalJournal = $("#generalJournal_grid").jqGrid('getRowData', selectRowId);
            var generalJournalDetail = $("#generalJournalDetail_grid").jqGrid('getRowData', selectRowId);
            var grandTotalAmount1 = (Math.floor(generalJournalDetail.debit)).toString();
            var arr = generalJournalDetail.debit.split('.');
            var grandTotalAmount2 = arr[1];
            
            var url = "finance/general-journal-print-out-pdf?";
            var params ="gjNo=" + generalJournal.code;
                params += "&bankReceivedTemp.terbilang=" + terbilangKoma(grandTotalAmount1,grandTotalAmount2,generalJournal.currencyName);
            window.open(url+params,'generalJournal','width=500,height=500');
        });
    });//EOF Ready
    
    function reloadGridGeneralJournal() {
        $("#generalJournal_grid").trigger("reloadGrid");  
    };
    
    function reloadGridGeneralJournalDetailAfterDelete() {
        $("#generalJournalDetail_grid").jqGrid("clearGridData");
        $("#generalJournalDetail_grid").jqGrid("setCaption", "GENERAL JOURNAL DETAIL");
    };
        
    function formatDateGeneralJournal(){
        var firstDate=$("#generalJournalSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#generalJournalSearchFirstDate").val(firstDateValue);

        var lastDate=$("#generalJournalSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#generalJournalSearchLastDate").val(lastDateValue);
    }
</script>
    
    <b>GENERAL JOURNAL</b>
    <hr>
    <br class="spacer" />
 
    <sj:div id="GeneralJournalButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnGeneralJournalNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnGeneralJournalUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnGeneralJournalDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnGeneralJournalRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnGeneralJournalPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
    </sj:div>   
    <br class="spacer" />
    <br class="spacer" />

    <div id="GeneralJournalInputSearch" class="content ui-widget">
        <s:form id="frmGeneralJournalSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="generalJournalSearchFirstDate" name="generalJournalSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="generalJournalSearchLastDate" name="generalJournalSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">GJM No</td>
                    <td>
                        <s:textfield id="generalJournalSearchCode" name="generalJournalSearchCode" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Ref No</td>
                    <td>
                        <s:textfield id="generalJournalSearchRefNo" name="generalJournalSearchRefNo" size="25"></s:textfield>
                    </td>
                    <td align="right">Remark</td>
                    <td>
                        <s:textfield id="generalJournalSearchRemark" name="generalJournalSearchRemark" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnGeneralJournal_search" button="true">Search</sj:a>
            <br class="spacer" />
             
        </s:form>
    </div>
    <br />
                  
    <div id="GeneralJournalGrid">
        <sjg:grid
            id="generalJournal_grid"
            caption="GENERAL JOURNAL"
            dataType="json"
            href="%{remoteurlGeneralJournal}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listGeneralJournalTemp"
            rowList="10,20,30"
            rowNum="10"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            onSelectRowTopics="generalJournal_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" title = "Branch" 
            width = "100" sortable = "true" align="center" hidden="true"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="120" formatter="date"  
            formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            align="center"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="currencyName" width="100" sortable="true" align="center" 
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="currencyName" width="100" sortable="true" align="center" hidden="true"
        />
        <sjg:gridColumn
            name = "exchangeRate" index = "exchangeRate" key = "exchangeRate" title = "Exchange Rate" width = "100" sortable = "false" 
            formatter="number" editrules="{ double: true }"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="400" sortable="true"  align="left"
        />
        </sjg:grid >
    </div>
    
    <!-- GRID DETAIL -->    
    <br class="spacer" />
    <br class="spacer" />

    <div id="generalJournalDetailGrid">
        <sjg:grid
            id="generalJournalDetail_grid"
            caption="General Journal Detail"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorSearch="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listGeneralJournalDetailTemp"
            width="$('#tabmnugeneraljournaldetail').width()"
            viewrecords="true"
            rownumbers="true"
            rowNum="10000"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name = "code" id="code" index = "code" key = "code" title = "Code" width = "100" sortable = "true" hidden="true" 
            />
            <sjg:gridColumn
                name = "documentNo" id="documentNo" index = "documentNo" key = "documentNo" title = "Document No" width = "150" sortable = "true"
            />
            <sjg:gridColumn
                name = "documentType" id="documentType" index = "documentType" key = "documentType" title = "Type" width = "60" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "currencyCode" id="currencyCode" index = "currencyCode" key = "currencyCode" title = "Currency" width = "80" sortable = "true"  align="center"
            />
            <sjg:gridColumn
                name = "currencyName" id="currencyName" index = "currencyName" key = "currencyName" title = "currencyName" width = "80" sortable = "true"  align="center" hidden="true"
            />
            <sjg:gridColumn
                name = "exchangeRate" id="exchangeRate" index = "exchangeRate" key = "exchangeRate" 
                title = "Exchange Rate" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "chartOfAccountCode" id="chartOfAccountCode" index = "chartOfAccountCode" key = "chartOfAccountCode" title = "Chart Of Account Code" width = "150" sortable = "true" align="center"
            />
            <sjg:gridColumn
                name = "chartOfAccountName" id="chartOfAccountName" index = "chartOfAccountName" key = "chartOfAccountName" title = "Chart Of Account Name" width = "200" sortable = "true"
            />
            <sjg:gridColumn
                name = "transactionStatus" id="transactionStatus" index = "transactionStatus" key = "transactionStatus" title = "Transaction Status" width = "150" sortable = "true" align="center" 
            />
            <sjg:gridColumn
                name = "debit" index = "debit" key = "debit" title = "Debit" width = "100" sortable = "false" align="right"
                formatter="number" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "debitIDR" id="debitIDR" index = "debitIDR" key = "debitIDR" 
                title = "Debit IDR" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "credit" id="credit" index = "credit" key = "credit" 
                title = "Credit" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "creditIDR" id="creditIDR" index = "creditIDR" key = "creditIDR" 
                title = "Credit IDR" width = "100" sortable = "true" align="right"
                formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
            />
            <sjg:gridColumn
                name = "remark" id="remark" index = "remark" key = "remark" title = "Remark" width = "150" sortable = "true"
            />
            
        </sjg:grid >
        <br/>
        <br/>
    

