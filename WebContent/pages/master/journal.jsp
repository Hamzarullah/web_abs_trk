
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #journalChartOfAccount_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
  
    function reloadGrid() {
        $("#Journal_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function(){
        hoverButton();
        
        $.subscribe("journal_grid_onSelect", function(event, data){
            var selectedRowID = $("#Journal_grid").jqGrid("getGridParam", "selrow"); 
            var journal = $("#Journal_grid").jqGrid("getRowData", selectedRowID);
            $("#journalChartOfAccount_grid").jqGrid("setGridParam",{url:"master/journal-detail-data?journal.code=" + journal.code});
            $("#journalChartOfAccount_grid").trigger("reloadGrid");
        });
        
        $("#btnJournalNew").click(function(ev){
            var url = "master/journal-input";
            var params = "";

            pageLoad(url, params, "#tabmnuJOURNAL");     
        });
        
        
        $("#btnJournalUpdate").click(function(ev){
            var selectedRowID = $("#Journal_grid").jqGrid('getGridParam','selrow');
            var journal = $("#Journal_grid").jqGrid('getRowData', selectedRowID);
            
            if (selectedRowID === null) {
                alert("Please Select Row!");
                return;
            }
            var url = "master/journal-input";
            var params = "journal.code="+journal.code;

            pageLoad(url, params, "#tabmnuJOURNAL");     
        });
        
        $('#btnJournalDelete').click(function(ev) {
            var deleteRowId = $("#Journal_grid").jqGrid('getGridParam','selrow');
            
            if (deleteRowId === null) {
                alert("Please Select Row");
            }
            else {
                var journal = $("#Journal_grid").jqGrid('getRowData', deleteRowId);
                
                if (confirm("Are You Sure To Delete (Code : " + journal.code + ")")) {
                    var url = "master/journal-delete";
                    var params = "journal.code=" + journal.code;
                    
                    $.post(url, params, function(data) {
                        if (data.error) {
                            alert(data.errorMessage);
                            return;
                        }

                        alert(data.message);
                        reloadGrid();
                    });
                }
            }
            ev.preventDefault();
        });
              
        $('#btnJournalRefresh').click(function(ev) {
            $("#Journal_grid").jqGrid("clearGridData");
            $("#Journal_grid").jqGrid("setGridParam",{url:"master/journal-data?"});
            $("#Journal_grid").trigger("reloadGrid");
            ev.preventDefault();    
        });
        
        $("#btnJournalPrint").click(function(ev) {
            
            var url = "reports/journal-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'journal','width=500,height=500');
        });
        
        $('#btnJournal_search').click(function(ev) {
            $("#Journal_grid").jqGrid("clearGridData");
            $("#Journal_grid").jqGrid("setGridParam",{url:"master/journal-data?" + $("#frmJournalSearchInput").serialize()});
            $("#Journal_grid").trigger("reloadGrid");
            ev.preventDefault();
       });
       
       
    });
    
    
</script>

<s:url id="remoteurlJournal" action="journal-data" />
<b>JOURNAL</b>
<hr>
<br class="spacer" />

    <sj:div id="journalButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnJournalUpdate" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_update.png" border="0" /><br/>Update</a></td>
                <td><a href="#" id="btnJournalRefresh" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_refresh.png" border="0" /><br/>Refresh</a></td>
            </tr>
        </table>
        
        
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />
    
    <div id="journalGrid">
        <sjg:grid
            id="Journal_grid"
            dataType="json"
            href="%{remoteurlJournal}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listJournalTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            onSelectRowTopics="journal_grid_onSelect"
            shrinkToFit="false"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="name" index="name" title="Name" width="400" sortable="true"
            />     
        </sjg:grid >
        <br class="spacer" />
        <br class="spacer" />
        <div id="journalDetailGrid">
            <sjg:grid
                id="journalChartOfAccount_grid"
                dataType="json"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listJournalChartOfAccountTemp"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnujournal').width()"
            >
                <sjg:gridColumn
                    name="journalCode" index="journalCode" key="journalCode" title="JournalCode" width="100" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="journalName" index="journalName" key="journalName" title="JournalName" width="300" sortable="true" hidden="true"
                />
                <sjg:gridColumn
                    name="currencyCode" index="currencyCode" title="Currency" width="60" sortable="true"
                />
                <sjg:gridColumn
                    name="currencyName" index="currencyName" title="Currency Name" width="400" sortable="true" hidden="true"
                />  
                <sjg:gridColumn
                    name="automaticJournalSetupCode" index="automaticJournalSetupCode" title="Automatic JournalType Setup" width="400" sortable="true" hidden="true"
                /> 
                <sjg:gridColumn
                    name="automaticJournalType" index="automaticJournalType" title="Automatic JournalType" width="400" sortable="true"
                /> 
                <sjg:gridColumn
                    name="journalPosition" index="journalPosition" title="Position" width="60" sortable="true" align="center"
                />
                <sjg:gridColumn
                    name="accountCode" index="accountCode" title="Account Code" width="130" sortable="true"
                />
                <sjg:gridColumn
                    name="accountName" index="accountName" title="Account Name" width="400" sortable="true"
                />
            </sjg:grid >
        </div>
    </div>