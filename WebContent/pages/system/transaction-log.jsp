
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

            
    $(document).ready(function(){
        hoverButton();
        
                
        $('#btnTransactionLogRefresh').click(function(ev) {
            var url = "system/transaction-log";
            var params = "";
            
            pageLoad(url, params, "#tabmnuTRANSACTION_LOG");   
        });
        
        $('#btnTransactionLog_search').click(function(ev) {
            formatDateTL();
            $("#transactionLog_grid").jqGrid("clearGridData");
            $("#transactionLog_grid").jqGrid("setGridParam",{url:"system/transaction-log-data?"+ $("#frmTransactionLogSearchInput").serialize()});
            $("#transactionLog_grid").trigger("reloadGrid");
            formatDateTL();
           
        });
        
        $("#btnTransactionLogPrint").click(function(ev) {
            var selectRowId = $("#transactionLog_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alertEx("Please Select Row!");
                return;
            }
            
            var transactionLog = $("#transactionLog_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/inventory/inventory-in-print-in-pdf?";
            var params = "code=" + transactionLog.code;
              
            window.open(url+params,'transactionLog','width=500,height=500');
        });
    });
        
    function formatDateTL(){
        var firstDate=$("#transactionLogSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#transactionLogSearchFirstDate").val(firstDateValue);

        var lastDate=$("#transactionLogSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#transactionLogSearchLastDate").val(lastDateValue);
    }
</script>
<s:url id="remoteurlTransactionLog" action="transaction-log-json" />
<b> TRANSACTION LOG</b>
<hr>
<br class="spacer" />
    <sj:div id="transactionLogButton" cssClass="ikb-buttonset ikb-buttonset-single">
         <a href="#" id="btnTransactionLogRefresh" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_refresh.png" border="0" title="Refresh"/></a>
        <a href="#" id="btnTransactionLogPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print In"/></a>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="transactionLogInputSearch" class="content ui-widget">
        <s:form id="frmTransactionLogSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period * </B></td>
                    <td>
                        <sj:datepicker id="transactionLogSearchFirstDate" name="transactionLogSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        <B>To*</B>
                        <sj:datepicker id="transactionLogSearchLastDate" name="transactionLogSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="transactionLogSearchTransactionCode" name="transactionLogSearchTransactionCode" placeHolder="Transaction Code" size="30"></s:textfield>
                    </td>
                    <td align="right">Module Code</td>
                    <td>
                        <s:textfield id="transactionLogSearchModuleCode" name="transactionLogSearchModuleCode" placeHolder="Module Code" size="30"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Action Type *</B></td>
                    <td>
                        <s:select label="Select Action Type" 
                            headerValue="Action"
                            list="{'ALL','INSERT','UPDATE','DELETE'}" 
                            name="transactionLogSearchActionType" style="width: 115px"/>
                    </td>
                    <td align="right">User</td>
                    <td>
                        <s:textfield id="transactionLogSearchUserCode" name="transactionLogSearchUserCode" placeHolder="User" size="30"></s:textfield>
                    </td>
                </tr>
            </table>
            <br />
            <sj:a href="#" id="btnTransactionLog_search" button="true">Search</sj:a>
            <br />
        </s:form>
    </div>
    <br class="spacer" />
                     
   <div id="transactionLogGrid">
        <sjg:grid
            id="transactionLog_grid"
            caption="TRANSACTION LOG"
            dataType="json"
            href="%{remoteurlTransactionLog}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listTransactionLogTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnutransactionLog').width()"
            onSelectRowTopics="transactionLog_grid_onSelect"
            >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="400" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="transactionCode" index="transactionCode" key="transactionCode" title="Transaction Code" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="logDate" index="logDate" key="logDate" 
                title="Log Date" width="150" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="actionType" index="actionType" key="actionType" title="Action Type" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="moduleCode" index="moduleCode" key="moduleCode" title="Module Code" width="250" sortable="true" 
            />
            <sjg:gridColumn
                name="logDate" index="logDate" key="logDate" 
                title="Log Date" width="150" formatter="date"  
                formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="userCode" index="userCode" key="userCode" title="User" width="150" sortable="true" 
            />
            <sjg:gridColumn
                name="IPNo" index="IPNo" key="IPNo" title="IP No" width="150" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="description" index="description" key="description" title="Description" width="300" sortable="true"
            />    
        </sjg:grid>
    </div>
    
   

    

    

