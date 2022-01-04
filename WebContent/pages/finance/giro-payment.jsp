
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
                       
        $('#giroPaymentSearchStatusRadPending').prop('checked',true);
        $("#giroPaymentSearchGiroStatus").val("Pending");
            
        $('input[name="giroPaymentSearchStatusRad"][value="Pending"]').change(function(ev){
            var value="Pending";
            $("#giroPaymentSearchGiroStatus").val(value);
        });
        $('input[name="giroPaymentSearchStatusRad"][value="Cleared"]').change(function(ev){
            var value="Cleared";
            $("#giroPaymentSearchGiroStatus").val(value);
        });
        $('input[name="giroPaymentSearchStatusRad"][value="Rejected"]').change(function(ev){
            var value="Rejected";
            $("#giroPaymentSearchGiroStatus").val(value);
        });
        $('input[name="giroPaymentSearchStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#giroPaymentSearchGiroStatus").val(value);
        });
        
        $('#btnGiroPaymentNew').click(function(ev) {
            
//            var url="finance/period-closing-confirmation";
//            var params="";
//
//            $.post(url,params,function(result){
//                var data=(result);
//                if (data.error) {
//                    alertMessage(data.errorMessage);
//                    return;
//                }

                var url = "finance/giro-payment-input";
                var params = "";
            
                pageLoad(url, params, "#tabmnuGIRO_PAYMENT");

//            });
            
        });
        
        $('#btnGiroPaymentUpdate').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var selectRowId = $("#giroPayment_grid").jqGrid('getGridParam','selrow');
                var giroPayment = $("#giroPayment_grid").jqGrid("getRowData", selectRowId);

                if (selectRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var url="finance/giro-payment-confirmation";
                var params="giroPayment.code="+giroPayment.code;
                
                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage("Cannot Update this Transaction!<br/>"+data.errorMessage);
                        return;
                    }
                    
                    var url = "finance/giro-payment-input";
                    var params ="giroPaymentUpdateMode=true";
                        params+="&giroPayment.code=" + giroPayment.code;
                    pageLoad(url, params, "#tabmnuGIRO_PAYMENT");
                    
                });
            });
            
            ev.preventDefault();
        });
        
        
        $('#btnGiroPaymentDelete').click(function(ev) {
            
            var url="finance/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#giroPayment_grid").jqGrid('getGridParam','selrow');
                var giroPayment = $("#giroPayment_grid").jqGrid('getRowData', selectedRowId);

                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                    
                var url="finance/giro-payment-confirmation";
                var params="giroPayment.code="+giroPayment.code;
                
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
                        '</span>GRP No: '+giroPayment.code+'<br/><br/>' +    
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
                                    var url = "finance/giro-payment-delete";
                                    var params = "giroPayment.code=" + giroPayment.code;
                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        alertMessage(data.message);
                                        reloadGridGiroPayment();
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
        
        $('#btnGiroPaymentRefresh').click(function(ev) {
            var url = "finance/giro-payment";
            var params = "";
            pageLoad(url, params, "#tabmnuGIRO_PAYMENT");
            ev.preventDefault();   
        });
        
        $('#btnGiroPayment_search').click(function(ev) {
            formatDateGiroPayment();
            $("#giroPayment_grid").jqGrid("clearGridData");
            $("#giroPayment_grid").jqGrid("setGridParam",{url:"finance/giro-payment-data?" + $("#frmGiroPaymentSearchInput").serialize()});
            $("#giroPayment_grid").trigger("reloadGrid");
            formatDateGiroPayment();
            ev.preventDefault();
        });

        $('#btnGiroPaymentPrint').click(function(ev) {
            var selectRowId = $("#giroPayment_grid").jqGrid('getGridParam','selrow');
            
            if (selectRowId === null) {
                alert("Please Select Row!");
                return;
            }
            else{
            var giroPayment = $("#giroPayment_grid").jqGrid('getRowData', selectRowId);
               
            var url = "reports/finance/giro-payment-print-out-pdf?";
            var params ="gpNo=" + giroPayment.code;
            
            window.open(url+params,'giroPayment','width=500,height=500');}
            ev.preventDefault();
            
        });
        
    });//EOF Ready
    
    function formatDateGiroPayment(){
        var firstDate=$("#giroPaymentSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#giroPaymentSearchFirstDate").val(firstDateValue);

        var lastDate=$("#giroPaymentSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#giroPaymentSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridGiroPayment() {
        $("#giroPayment_grid").trigger("reloadGrid");
    };
</script>

<s:url id="remoteurlGiroPayment" action="giro-payment-json" />

    <b>GIRO PAYMENT</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="GiroPaymentButton" cssClass="ikb-buttonset ikb-buttonset-single">
        <table>
        <tr>
            <td><a href="#" id="btnGiroPaymentNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" /><br/>New</a>
            </td>
            <td><a href="#" id="btnGiroPaymentUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" /><br/>Update</a>
            </td>
            <td><a href="#" id="btnGiroPaymentDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" /><br/>Delete</a>
            </td>
            <td><a href="#" id="btnGiroPaymentRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" /><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnGiroPaymentPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" /><br/>Print Out</a>
            </td>
        </tr>
        </table>   
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="GiroPaymentInputSearch" class="content ui-widget">
        <s:form id="frmGiroPaymentSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                        <sj:datepicker id="giroPaymentSearchFirstDate" name="giroPaymentSearchFirstDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                        To
                        <sj:datepicker id="giroPaymentSearchLastDate" name="giroPaymentSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus"></sj:datepicker>
                    </td>
                <tr>
                    <td align="right">Code</td>
                    <td>
                        <s:textfield id="giroPaymentSearchCode" name="giroPaymentSearchCode" size="25"></s:textfield>
                    </td>
                    <td align="right">Status</td>
                    <td>
                        <s:radio id="giroPaymentSearchStatusRad" name="giroPaymentSearchStatusRad" label="" list="{'Pending','Cleared','Rejected','All'}"></s:radio>
                    </td>     
                    <td>
                        <s:textfield id="giroPaymentSearchGiroStatus" name="giroPaymentSearchGiroStatus" value="Pending" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>

            </table>
            <br />
            <sj:a href="#" id="btnGiroPayment_search" button="true">Search</sj:a>
            <br />
            <br />
             
        </s:form>
    </div>
    <br />
                 
    <div id="GiroPaymentGrid">
        <sjg:grid
            id="giroPayment_grid"
            caption="GIRO PAYMENT"
            dataType="json"
            href="%{remoteurlGiroPayment}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listGiroPaymentTemp"
            rowList="10,20,30"
            rowNum="10"
            sortname="transactionDate"
            sortorder="desc"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnugiropayment').width()"
            onSelectRowTopics="giroPayment_grid_onSelect"
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
            name="paymentTo" index="paymentTo" key="paymentTo" title="PaymentTo" width="130" sortable="true" 
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