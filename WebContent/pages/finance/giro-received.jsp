
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
    
    $(document).ready(function(){
        
        hoverButton();
                       
        $('#giroReceivedSearchStatusRadPending').prop('checked',true);
        $("#giroReceivedSearchGiroStatus").val("Pending");
            
        $('input[name="giroReceivedSearchStatusRad"][value="Pending"]').change(function(ev){
            var value="Pending";
            $("#giroReceivedSearchGiroStatus").val(value);
        });
        $('input[name="giroReceivedSearchStatusRad"][value="Cleared"]').change(function(ev){
            var value="Cleared";
            $("#giroReceivedSearchGiroStatus").val(value);
        });
        $('input[name="giroReceivedSearchStatusRad"][value="Rejected"]').change(function(ev){
            var value="Rejected";
            $("#giroReceivedSearchGiroStatus").val(value);
        });
        $('input[name="giroReceivedSearchStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#giroReceivedSearchGiroStatus").val(value);
        });
        
        $('#btnGiroReceivedNew').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "finance/giro-received-input";
                var params = "";
            
                pageLoad(url, params, "#tabmnuGIRO_RECEIVED");

            });
            
        });
        
        $('#btnGiroReceivedUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#giroReceived_grid").jqGrid('getGridParam','selrow');
                var giroReceived = $("#giroReceived_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="finance/giro-received-confirmation";
                var params="giroReceived.code="+giroReceived.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/giro-received-input";
                    var params ="giroReceivedUpdateMode=true";
                        params+="&giroReceived.code=" + giroReceived.code;
                    pageLoad(url, params, "#tabmnuGIRO_RECEIVED");
                    
                });
            });
            
            ev.preventDefault();
        });
        
        
        $('#btnGiroReceivedDelete').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#giroReceived_grid").jqGrid('getGridParam','selrow');
                var giroReceived = $("#giroReceived_grid").jqGrid('getRowData', selectedRowId);

                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                    
                var url="finance/giro-received-confirmation";
                var params="giroReceived.code="+giroReceived.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Delete this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>GRR No: '+giroReceived.code+'<br/><br/>' +    
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
                                    var url = "finance/giro-received-delete";
                                    var params = "giroReceived.code=" + giroReceived.code;
                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        alertMessage(data.message);
                                        reloadGridGiroReceived();
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
            ev.preventDefault();
        });
        
        $('#btnGiroReceivedRefresh').click(function(ev) {
            var url = "finance/giro-received";
            var params = "";
            pageLoad(url, params, "#tabmnuGIRO_RECEIVED");
            ev.preventDefault();   
        });
        
        $('#btnGiroReceived_search').click(function(ev) {
            formatDateGiroReceived();
            $("#giroReceived_grid").jqGrid("clearGridData");
            $("#giroReceived_grid").jqGrid("setGridParam",{url:"finance/giro-received-data?" + $("#frmGiroReceivedSearchInput").serialize()});
            $("#giroReceived_grid").trigger("reloadGrid");
            formatDateGiroReceived();
            ev.preventDefault();
        });

        $('#btnGiroReceivedPrint').click(function(ev) {
            var selectRowId = $("#giroReceived_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alert("Please Select Row!");
                return;
            }
            else{
            var giroReceived = $("#giroReceived_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/finance/giro-received-print-out-pdf?";
            var params ="grNo=" + giroReceived.code;
           
            window.open(url+params,'giroReceived','width=500,height=500');}
            ev.preventDefault();
            
        });
        
    });//EOF Ready
    
    function formatDateGiroReceived(){
        var firstDate=$("#giroReceivedSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#giroReceivedSearchFirstDate").val(firstDateValue);

        var lastDate=$("#giroReceivedSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#giroReceivedSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridGiroReceived() {
        $("#giroReceived_grid").trigger("reloadGrid");
    };
</script>

<s:url id="remoteurlGiroReceived" action="giro-received-json" />

    <b>GIRO RECEIVED</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="GiroReceivedButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
            <tr>
                <td><a href="#" id="btnGiroReceivedNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
                </td>
                <td><a href="#" id="btnGiroReceivedUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
                </td>
                <td><a href="#" id="btnGiroReceivedDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
                </td>
                <td> <a href="#" id="btnGiroReceivedRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
                </td>
                <td><a href="#" id="btnGiroReceivedPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
                </td>  
            </tr>
        </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="GiroReceivedInputSearch" class="content ui-widget">
        <s:form id="frmGiroReceivedSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="giroReceivedSearchFirstDate" name="giroReceivedSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="giroReceivedSearchLastDate" name="giroReceivedSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="giroReceivedSearchCode" name="giroReceivedSearchCode" size="25"></s:textfield>
                    </td>
                    <td align="right">Status</td>
                    <td>
                        <s:radio id="giroReceivedSearchStatusRad" name="giroReceivedSearchStatusRad" label="" list="{'Pending','Cleared','Rejected','All'}"></s:radio>
                    </td>     
                    <td>
                        <s:textfield id="giroReceivedSearchGiroStatus" name="giroReceivedSearchGiroStatus" value="Pending" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>

            </table>
            <br />
            <sj:a href="#" id="btnGiroReceived_search" button="true">Search</sj:a>
            <br />
            <br />
             
        </s:form>
    </div>
    <br />
                 
    <div id="GiroReceivedGrid">
        <sjg:grid
            id="giroReceived_grid"
            caption="GIRO RECEIVED"
            dataType="json"
            href="%{remoteurlGiroReceived}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listGiroReceivedTemp"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnugiroreceived').width()"
            onSelectRowTopics="giroReceived_grid_onSelect"
        >
        <sjg:gridColumn
            name = "branchCode" id="branchCode" index = "branchCode" key = "branchCode" 
            title = "Branch" width = "100" sortable = "true" hidden="true" align="center"
        />
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Transaction Date" width="120" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="dueDate" index="dueDate" key="dueDate" formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"   title="Due Date" width="130" search="false" sortable="true" align="center"
        />
        <sjg:gridColumn
            name="giroNo" index="giroNo" key="giroNo" title="Giro No" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="bankCode" index="bankCode" key="bankCode" title="Bank Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="bankName" index="bankName" key="bankName" title="Bank Name" width="150" sortable="true" align="left"
        />
        <sjg:gridColumn
            name="receivedFrom" index="receivedFrom" key="receivedFrom" title="Received From" width="130" sortable="true" 
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency" width="60" sortable="true" align="center"
        />
        <sjg:gridColumn
            name = "amount" index = "amount" key = "amount" title = "Amount" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="giroStatus" index="giroStatus" key="giroStatus" title="Status" width="80" sortable="true"
        />
        </sjg:grid >
    </div>