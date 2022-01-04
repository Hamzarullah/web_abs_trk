
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #journalChartOfAccountInput_grid_pager_center{
        display: none;
    }
</style>

<script type="text/javascript">
    var journalDetail_lastSel=-1;
    function reloadGrid() {
        $("#Journal_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function(){
        hoverButton();
        
        $("#journal\\.code").after(function(){
            getJournalCOA();
        });
        
        $.subscribe("journal_grid_onSelect", function(event, data){
            var selectedRowID = $("#Journal_grid").jqGrid("getGridParam", "selrow"); 
            var journal = $("#Journal_grid").jqGrid("getRowData", selectedRowID);
            $("#journalChartOfAccountInput_grid").jqGrid("setGridParam",{url:"master/journal-detail-data?journal.code=" + journal.code});
            $("#journalChartOfAccountInput_grid").trigger("reloadGrid");
        });
        
        var activeStatus=$("#journal\\.activeStatus").val();
        switch(activeStatus){
            case "true":
                $('#journal\\.activeStatusActive').prop('checked',true);
                break;
            case "false":
                $('#journal\\.activeStatusInActive').prop('checked',true);
                break;
        };
        
        $('input[name="journal\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#journal\\.activeStatus").val(value);
        });
                
        $('input[name="journal\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#journal\\.activeStatus").val(value);
        });
      
        $.subscribe("journalChartOfAccountInput_grid_onSelect", function(event, data){
             var selectedRowID = $("#journalChartOfAccountInput_grid").jqGrid("getGridParam", "selrow");
               if(selectedRowID!==journalDetail_lastSel) {
                   $('#journalChartOfAccountInput_grid').jqGrid("saveRow",journalDetail_lastSel); 
                   $('#journalChartOfAccountInput_grid').jqGrid("editRow",selectedRowID,true); 
                   journalDetail_lastSel=selectedRowID;
               }
               else{
                   $('#journalChartOfAccountInput_grid').jqGrid("saveRow",selectedRowID);
               }
        });
        
        $("#btnJournalSave").click(function(ev) {
            if(journalDetail_lastSel !== -1) {
                $("#journalChartOfAccountInput_grid").jqGrid('saveRow',journalDetail_lastSel); 
            }

            var listJournalChartOfAccount = new Array();            
            var ids = jQuery("#journalChartOfAccountInput_grid").jqGrid('getDataIDs'); 

            for(var i=0;i < ids.length;i++){ 
                var data = $("#journalChartOfAccountInput_grid").jqGrid('getRowData',ids[i]); 

                var journalChartOfAccount = {
                    code                        : data.journalCode+"/"+data.currencyCode+"/"+data.automaticJournalSetupCode,
                    journal                     : {code:data.journalCode},
                    currency                    : {code:data.currencyCode},
                    automaticJournalSetupCode   : data.automaticJournalSetupCode,
                    chartOfAccount              : {code:data.journalChartOfAccountChartOfAccountCode},
                    automaticJournalType        : data.automaticJournalType
                };
                listJournalChartOfAccount[i] = journalChartOfAccount;
            }
            
            var url = "master/journal-save";
            var params = $("#frmJournalInput").serialize();
                params += "&listJournalChartOfAccountJSON=" + $.toJSON(listJournalChartOfAccount);
            
            showLoading();
            
            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var dynamicDialog= $('<div id="conformBox">'+
                                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>'+data.message+'<br/></div>');

                dynamicDialog.dialog({
                    title : "Confirmation:",
                    closeOnEscape: false,
                    modal : true,
                    width: 500,
                    resizable: false,

                    buttons : 
                        [{
                            text : "OK",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "master/journal";
                                pageLoad(url, params, "#tabmnuJOURNAL");
                            }
                        }]
                });
            });
        });
      
      
        $("#btnJournalCancel").click(function(ev){
            var url = "master/journal";
            var params = "";

            pageLoad(url, params, "#tabmnuJOURNAL");     
        });
      
    });
    
    function getJournalCOA(){
        $("#journalChartOfAccountInput_grid").jqGrid("clearGridData", true).trigger("reloadGrid");
        var url = "master/journal-detail-get";
        var params = "journal.code="+$("#journal\\.code").val();
        showLoading();
        $.getJSON(url, params, function(data) {
            journalDetail_lastRowId = 0;
            for (var i=0; i<data.listJournalChartOfAccountTemp.length; i++) {
                journalDetail_lastRowId++;
                $("#journalChartOfAccountInput_grid").jqGrid("addRowData", journalDetail_lastRowId,data.listJournalChartOfAccountTemp[i]);
                $("#journalChartOfAccountInput_grid").jqGrid('setRowData', journalDetail_lastRowId,{
                    journalCode                     : data.listJournalChartOfAccountTemp[i].journalCode,
                    journalName                     : data.listJournalChartOfAccountTemp[i].journalName,
                    currencyCode                    : data.listJournalChartOfAccountTemp[i].currencyCode,
                    currencyName                    : data.listJournalChartOfAccountTemp[i].currencyName,
                    automaticJournalSetupCode       : data.listJournalChartOfAccountTemp[i].automaticJournalSetupCode,
                    automaticJournalType            : data.listJournalChartOfAccountTemp[i].automaticJournalType,
                    journalPosition                 : data.listJournalChartOfAccountTemp[i].journalPosition,
                    journalChartOfAccountChartOfAccountCode : data.listJournalChartOfAccountTemp[i].accountCode,
                    journalChartOfAccountChartOfAccountName : data.listJournalChartOfAccountTemp[i].accountName
                });
            }
            closeLoading();
        });
    }
    
    function tabGetDataJjournalCOA(){
        var selectedRowID = $("#journalChartOfAccountInput_grid").jqGrid("getGridParam", "selrow");
            var coaCode = $("#" + selectedRowID + "_journalChartOfAccountChartOfAccountCode").val();
            var url = "master/chart-of-account-get";
            var params = "chartOfAccount.code=" + coaCode;
            params+= "&chartOfAccount.accountType=S";
            params+= "&chartOfAccount.activeStatus=TRUE";
            
            if(coaCode===""){
                $("#" + selectedRowID + "_journalChartOfAccountChartOfAccountCode").val("");
                $("#journalChartOfAccountInput_grid").jqGrid("setCell", selectedRowID,"journalChartOfAccountChartOfAccountName"," ");
                return;
            }
            
            $.post(url, params, function(result) {
                var data = (result);
                if (data.chartOfAccountTemp){
                    $("#" + selectedRowID + "_journalChartOfAccountChartOfAccountCode").val(data.chartOfAccountTemp.code);
                    $("#journalChartOfAccountInput_grid").jqGrid("setCell", selectedRowID,"journalChartOfAccountChartOfAccountName",data.chartOfAccountTemp.name);
                }
                else{
                    $("#" + selectedRowID + "_journalChartOfAccountChartOfAccountCode").val("");
                    $("#cashPaymentDetailDocumentInput_grid").jqGrid("setCell", selectedRowID,"cashPaymentDetailDocumentChartOfAccountName"," ");
                    alertMessage("COA Not Found");
                }
            });
    }
        
    function journalDetailDocumentInputGrid_SearchAccount_OnClick(){
        window.open("./pages/search/search-chart-of-account.jsp?iddoc=journalChartOfAccount&type=grid","Search", "width=600, height=500");
    }
</script>

<s:url id="remotedetailurlJournalDetailInput" action="" />

<b>JOURNAL</b>
<hr>
<br class="spacer" />
<div id="journalInput" class="content ui-widget">
    <s:form id="frmJournalInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="journal.code" name="journal.code" title="Please Enter Code!" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr> 
            <tr>
                <td align="right"><B>Name *</B></td>
                <td><s:textfield id="journal.name" name="journal.name" size="50" title="Please Enter Name!" required="true" cssClass="required" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="journal.activeStatus" name="journal.activeStatus" readonly="false" size="5" cssStyle="Display:none"></s:textfield></td>
                <td><s:radio id="journal.activeStatus" name="journal.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr> 

            <td><s:textfield id="journal.createdBy"  name="journal.createdBy" size="20" style="display:none"></s:textfield></td>
            <td><s:textfield id="journal.createdDate" name="journal.createdDate" size="20" style="display:none"></s:textfield></td>
        </table>
        <br />
        <sj:a href="#" id="btnJournalSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnJournalCancel" button="true">Cancel</sj:a>
        <br /><br />
    </s:form>
</div>
<br />
    
    <div id="journalGrid">
        <br class="spacer" />
        <div id="journalDetailGrid">
            <sjg:grid
                id="journalChartOfAccountInput_grid"
                dataType="json"
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="journalDetailTemp"
                rowList="10,20,30"
                rowNum="10000"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                editurl="%{remotedetailurlJournalDetailInput}"
                onSelectRowTopics="journalChartOfAccountInput_grid_onSelect"
                width="$('#tabmnujournal').width()"
            >
                <sjg:gridColumn
                    name="journalDetailTemp" index="journalDetailTemp" key="journalDetailTemp" title="" width="100" sortable="true" hidden="true"
                    editable="true"
                />
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
                    name="journalPosition" index="journalPosition" title="Position" width="80" sortable="true" align="center"
                />
                <sjg:gridColumn
                    name="journalDetailChartOfAccountSearch" index="journalDetailChartOfAccountSearch" title="" width="25" align="centre"
                    editable="true" dataType="html" edittype="button"
                    editoptions="{onClick:'journalDetailDocumentInputGrid_SearchAccount_OnClick()', value:'...'}"
                /> 
                <sjg:gridColumn
                    name="journalChartOfAccountChartOfAccountCode" index="journalChartOfAccountChartOfAccountCode" title="Account Code" width="150" sortable="true"
                    editable="true" editoptions="{onChange:'tabGetDataJjournalCOA()'}"
                />
                <sjg:gridColumn
                    name="journalChartOfAccountChartOfAccountName" index="journalChartOfAccountChartOfAccountName" title="Account Name" width="400" sortable="true"
                />
            </sjg:grid >
        </div>
    </div>