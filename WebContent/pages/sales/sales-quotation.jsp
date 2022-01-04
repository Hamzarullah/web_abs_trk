
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #salesQuotationDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
        
        $('#salesQuotationSearchValidStatusRadYES').prop('checked',true);
            $("#salesQuotationSearchValidStatus").val("true");
        
        $('input[name="salesQuotationSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#salesQuotationSearchValidStatus").val(value);
        });
        
        $('input[name="salesQuotationSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="true";
            $("#salesQuotationSearchValidStatus").val(value);
        });
                
        $('input[name="salesQuotationSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="false";
            $("#salesQuotationSearchValidStatus").val(value);
        });
        
        $('#salesQuotationSearchSALQUOStatusRadNO\\ STATUS').prop('checked',true);
        $("#salesQuotationSearchSALQUOStatus").val("NO_STATUS");
            
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="BUDGETING"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("BUDGETING");
        });
        
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="APPROVED"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("APPROVED");
        });
        
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="FAILED"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("FAILED");
        });
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="REVIEWING"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("REVIEWING");
        });
        
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="CANCELLED"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("CANCELLED");
        });
        
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="NO_STATUS"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("NO_STATUS");
        });
        
        $('input[name="salesQuotationSearchSALQUOStatusRad"][value="ALL"]').change(function(ev){
            $("#salesQuotationSearchSALQUOStatus").val("");
        });
               
        $.subscribe("salesQuotation_grid_onSelect", function(event, data){
            var selectedRowID = $("#salesQuotation_grid").jqGrid("getGridParam", "selrow"); 
            var salesQuotation = $("#salesQuotation_grid").jqGrid("getRowData", selectedRowID);
            
            $("#salesQuotationDetail_grid").jqGrid("setGridParam",{url:"sales/sales-quotation-detail-data?salesQuotation.code="+ salesQuotation.code});
            $("#salesQuotationDetail_grid").jqGrid("setCaption", "SALES QUOTATION DETAIL : " + salesQuotation.code);
            $("#salesQuotationDetail_grid").trigger("reloadGrid");
            
            $("#salesQuotationTotalTransactionAmount").val(formatNumber(parseFloat(salesQuotation.totalTransactionAmount), 2));
            $("#salesQuotationDiscountPercent").val(formatNumber(parseFloat(salesQuotation.discountPercent), 2));
            $("#salesQuotationDiscountAmount").val(formatNumber(parseFloat(salesQuotation.discountAmount), 2));
            
            var subTotal=parseFloat(salesQuotation.totalTransactionAmount)-parseFloat(salesQuotation.discountAmount);
            $("#salesQuotationSubTotal").val(formatNumber(subTotal, 2));
            $("#salesQuotationVATPercent").val(formatNumber(parseFloat(salesQuotation.vatPercent), 2));
            $("#salesQuotationVATAmount").val(formatNumber(parseFloat(salesQuotation.vatAmount), 2));            
            $("#salesQuotationGrandTotalAmount").val(formatNumber(parseFloat(salesQuotation.grandTotalAmount), 2));  
        });
        
        $('#btnSalesQuotationNew').click(function(ev) {
            
            var url="sales/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var url = "sales/sales-quotation-input";
                var params = "";

                pageLoad(url, params, "#tabmnuSALES_QUOTATION");

            });
                    
        });
        
        $('#btnSalesQuotationUpdate').click(function(ev) {
            
            var url="sales/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#salesQuotation_grid").jqGrid('getGridParam','selrow');
                var salesQuotation = $("#salesQuotation_grid").jqGrid('getRowData', selectedRowId);
                
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                if(salesQuotation.validStatus==="false"){
                    alertMessage("Can't Update");
                    return;
                }
                
                if(salesQuotation.salQUOStatus==="APPROVED"){
                    alertMessage("Can't Upadate SalQuo has already Approved");
                    return;
                }
                
                var url="sales/sales-quotation-authority";
                var params="actionAuthority=UPDATE";

                $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                    var url = "sales/sales-quotation-input";
                    var params = "salesQuotationUpdateMode=true";
                        params+="&salesQuotation.code=" + salesQuotation.code;
                        pageLoad(url, params, "#tabmnuSALES_QUOTATION");
                });

            });      
        });
        $("#btnSalesQuotationClone").click(function (ev) {
            
            var selectRowId = $("#salesQuotation_grid").jqGrid('getGridParam','selrow');
            var salesQuotation = $("#salesQuotation_grid").jqGrid("getRowData", selectRowId);
            var slqCode = salesQuotation.code;
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(salesQuotation.validStatus==="false"){
                alertMessage("Can't Clone");
                return;
             }
             
            if(salesQuotation.salQUOStatus==="APPROVED"){
                alertMessage("Can't Clone SalQuo has already Approved");
                return;
            }
                       
            var url="sales/sales-quotation-authority";
            var params="actionAuthority=INSERT";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                var url = "sales/sales-quotation-input";
                var params = "salesQuotationCloneMode=true" + "&salesQuotation.code=" + slqCode;
                pageLoad(url, params, "#tabmnuSALES_QUOTATION");

            });
            ev.preventDefault();
    
        });
        
        $("#btnSalesQuotationRevise").click(function (ev) {
            
            var selectRowId = $("#salesQuotation_grid").jqGrid('getGridParam','selrow');
            var salesQuotation = $("#salesQuotation_grid").jqGrid("getRowData", selectRowId);
            var rfqCode = salesQuotation.code;
            
            if (selectRowId === null) {
                alertMessage("Please Select Row!");
                return;
            }
            
            if(salesQuotation.validStatus==="false"){
                alertMessage("Can't Revise");
                return;
             }
             
             if(salesQuotation.salQUOStatus==="APPROVED"){
                alertMessage("Can't Revise SalQuo has already Approved");
                return;
            }
            
            var url="sales/sales-quotation-authority";
            var params="actionAuthority=INSERT";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage,"",400);
                    return;
                }
                var url = "sales/sales-quotation-input";
                var params = "salesQuotationReviseMode=true" + "&salesQuotation.code=" + rfqCode;
                pageLoad(url, params, "#tabmnuSALES_QUOTATION");

            });
            ev.preventDefault();
    
        });
        $('#btnSalesQuotationDelete').click(function(ev) {
            
            var url="sales/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var deleteRowId = $("#salesQuotation_grid").jqGrid('getGridParam','selrow');
                var salesQuotation = $("#salesQuotation_grid").jqGrid('getRowData', deleteRowId);

                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                if(salesQuotation.validStatus==="false"){
                    alertMessage("Can't Delete");
                    return;
                }
                
                if(salesQuotation.salQUOStatus==="APPROVED"){
                    alertMessage("Can't Delete SalQuo has already Approved");
                    return;
                }
                    
                    var url = "sales/sales-quotation-delete";
                    var params = "salesQuotation.code=" + salesQuotation.code;

                    var dynamicDialog= $(
                        '<div id="conformBoxError">'+
                        '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                        '</span>Are You Sure To Delete?<br/><br/>' +
                        '<span style="float:left; margin:0 7px 20px 0;">'+
                        '</span>CCN No: '+salesQuotation.code+'<br/><br/>' +    
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
                                    $.post(url, params, function(data) {
                                        if (data.error) {
                                            alertMessage(data.errorMessage);
                                            return;
                                        }
                                        reloadGridSQ();
                                        reloadDetailGridSQ();
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
               
            ev.preventDefault();
        });

        $('#btnSalesQuotationRefresh').click(function(ev) {
            var url = "sales/sales-quotation";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_QUOTATION");
            ev.preventDefault();   
        });
    
        $('#btnSalesQuotation_search').click(function(ev) {
            formatDateSQ();
            $("#salesQuotation_grid").jqGrid("clearGridData");
            $("#salesQuotation_grid").jqGrid("setGridParam",{url:"sales/sales-quotation-data?" + $("#frmSalesQuotationSearchInput").serialize()});
            $("#salesQuotation_grid").trigger("reloadGrid");
            $("#salesQuotationDetail_grid").jqGrid("clearGridData");
            $("#salesQuotationDetail_grid").jqGrid("setCaption", "SALES QUOTATION DETAIL");
            formatDateSQ();
            ev.preventDefault();
           
        });
        
        $("#btnSalesQuotationXlsPrint").click(function(event) {
           var url = "reports/sales/sales-quotation-download-excel";
           var params= "";
           window.open(url+params,'salesQuotation','width=500,height=500');
            
        });
        
//        $("#btnSalesQuotationPrint").click(function(ev) {
//            var selectRowId = $("#salesQuotation_grid").jqGrid('getGridParam','selrow');
//           
//            if (selectRowId === null) {
//                alertMessage("Please Select Row!");
//                return;
//            }
//            else{
//            var salesQuotation = $("#salesQuotation_grid").jqGrid('getRowData', selectRowId);
//               
//            var url = "reports/sales/sales-quotation-print-out-pdf?";
//            var params ="code=" + salesQuotation.code;
//        
//            window.open(url+params,'salesQuotation','width=500,height=500');}
//            ev.preventDefault();
//        });
    });//EOF Ready
    
    function formatDateSQ(){
        var firstDate=$("#salesQuotationSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#salesQuotationSearchFirstDate").val(firstDateValue);

        var lastDate=$("#salesQuotationSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#salesQuotationSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridSQ() {
        $("#salesQuotation_grid").trigger("reloadGrid");
      
    };

    function reloadDetailGridSQ() {
        $("#salesQuotationDetail_grid").trigger("reloadGrid");  
        $("#salesQuotationDetail_grid").jqGrid("clearGridData");
        $("#salesQuotationDetail_grid").jqGrid("setCaption", "SALES QUOTATION DETAIL");
        clearTotalTransactionSalesQuotation();
    };
      function clearTotalTransactionSalesQuotation(){
        $("#salesQuotationTotalTransactionAmount").val("0.00");
        $("#salesQuotationDiscountPercent").val("0.00");
        $("#salesQuotationDiscountAmount").val("0.00");
        $("#salesQuotationSubTotal").val("0.00");
        $("#salesQuotationVATPercent").val("0.00");
        $("#salesQuotationVATAmount").val("0.00");
        $("#salesQuotationOtherFeeAmount").val("0.00");
        $("#salesQuotationGrandTotalAmount").val("0.00");
    };
    function calculateDetailSQ() {
        var ids = jQuery("#salesQuotationDetail_grid").jqGrid('getDataIDs');
        for(var i=0;i<ids.length;i++){
            var qty = $("#" + i + "_quantity").val();
            var price = $("#" + i + "_price").val();


            var amount = (parseFloat(qty) * parseFloat(price));

            $("#salesQuotationDetail_grid").jqGrid("setCell", i, "total", amount);
        }
    };
    
</script>
<s:url id="remoteurlSalesQuotation" action="sales-quotation-json" />    
    <b>SALES QUOTATION</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="salesQuotationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnSalesQuotationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnSalesQuotationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnSalesQuotationRevise" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Revise"/><br/>Revise</a>
            </td>
            <td><a href="#" id="btnSalesQuotationClone" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Clone"/><br/>Clone</a>
            </td>
            <td><a href="#" id="btnSalesQuotationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnSalesQuotationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnSalesQuotationPrint" class="ikb-button ui-state-default"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>
            <td><a href="#" id="btnSalesQuotationXlsPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_excel.PNG" border="0" title="SalQuo Excel"/><br/>SalQuo Excel</a>
                
            </td>  
        </tr>
        </tr>
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />
    
<br class="spacer" />
    <div id="SalesQuotationInputSearch" class="content ui-widget">
        <s:form id="frmSalesQuotationSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="salesQuotationSearchFirstDate" name="salesQuotationSearchFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="salesQuotationSearchLastDate" name="salesQuotationSearchLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr> 
                <tr>
                    <td align="right">SLS-QUO No</td>
                    <td>
                        <s:textfield id="salesQuotationSearchCode" name="salesQuotationSearchCode" size="30" placeHolder=" SQNo"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="salesQuotationCustomerSearchCode" name="salesQuotationCustomerSearchCode" size="20" placeHolder=" Code"></s:textfield>
                        <s:textfield id="salesQuotationCustomerSearchName" name="salesQuotationCustomerSearchName" size="20" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>    
                    <td align="right">Remark</td>
                    <td>
                       <s:textfield id="salesQuotationSearchRemark" name="salesQuotationSearchRemark" size="30" placeHolder=" Remark"></s:textfield>
                    </td>
                    <td align="right"><b>End User</b></td>
                    <td>
                        <s:textfield id="salesQuotationEndUserSearchCode" name="salesQuotationEndUserSearchCode" size="20" placeHolder=" Code"></s:textfield>
                        <s:textfield id="salesQuotationEndUserSearchName" name="salesQuotationEndUserSearchName" size="20" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>    
                    <td align="right">RefNo</td>
                    <td>
                       <s:textfield id="salesQuotationSearchRefNo" name="salesQuotationSearchRefNo" size="30" placeHolder=" Refno"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Quotation Status</B></td>
                    <td>
                        <s:radio id="salesQuotationSearchSALQUOStatusRad" name="salesQuotationSearchSALQUOStatusRad" label="salesQuotationSearchSALQUOStatusRad" list="{'ALL','NO STATUS','REVIEWING','BUDGETING','FAILED','CANCELLED','APPROVED'}"></s:radio>
                        <s:textfield id="salesQuotationSearchSALQUOStatus" name="salesQuotationSearchSALQUOStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><b>Valid Status</b></td>
                    <td>
                        <s:radio id="salesQuotationSearchValidStatusRad" name="salesQuotationSearchValidStatusRad" label="salesQuotationSearchValidStatusRad" list="{'ALL','YES','NO'}"></s:radio>
                        <s:textfield id="salesQuotationSearchValidStatus" name="salesQuotationSearchValidStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnSalesQuotation_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="SalesQuotationGrid">
        <sjg:grid
            id="salesQuotation_grid"
            caption="SALES QUOTATION"
            dataType="json"
            href="%{remoteurlSalesQuotation}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesQuotationTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnusalesquotation').width()"
            onSelectRowTopics="salesQuotation_grid_onSelect"
        >
       <sjg:gridColumn
            name="code" index="code" key="code" title="SLS-QUO No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="salQUOStatus" index="salQUOStatus" key="salQUOStatus" title="SQ Status" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="transactionDate" index="transactionDate" key="transactionDate" 
            title="Transaction Date" width="130" formatter="date"  
            formatoptions="{newformat : 'd/m/Y', srcformat : 'Y/m/d H:i:s' }"  sortable="true" 
        />
       <sjg:gridColumn
            name="rfqCode" index="rfqCode" key="rfqCode" title="RFQ No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="customerName" index="customerName" key="customerName" title="Customer" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="endUserName" index="endUserName" key="endUserName" title="End User" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="salesPersonName" index="salesPersonName" key="salesPersonName" title="Sales Person" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="totalTransactionAmount" index="totalTransactionAmount" key="totalTransactionAmount" title="totalTransactionAmount" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="discountAmount" index="discountAmount" key="discountAmount" title="discountAmount" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="discountPercent" index="discountPercent" key="discountPercent" title="totalTransactionAmount" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="vatPercent" index="vatPercent" key="vatPercent" title="vatPercent" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="vatAmount" index="vatAmount" key="vatAmount" title="vatAmount" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="grandTotalAmount" index="grandTotalAmount" key="grandTotalAmount" title="grandTotalAmount" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true" 
        />
       
        </sjg:grid >
    </div>
    <br class="spacer" />
    <br class="spacer" />
    
    <div id="SalesQuotationDetailGrid">
        <sjg:grid
            id="salesQuotationDetail_grid"
            caption="SALES QUOTATION DETAIL"
            dataType="json"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesQuotationDetailTemp"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnusalesquotation').width()"
            
        >
        <sjg:gridColumn
            name="valveTypeCode" index="valveTypeCode" key="valveTypeCode" title="Valve Type Code" width="100" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="valveTypeName" index="valveTypeName" key="valveTypeName" title="Valve Type Name" width="100" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="valveTag" index="valveTag" key="valveTag" title="Valve Tag" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="dataSheet" index="dataSheet" key="dataSheet" title="Data Sheet" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="description" index="description" key="description" title="Description" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="bodyConstruction" index="bodyConstruction" key="bodyConstruction" title="Body Construction (01)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="typeDesign" index="typeDesign" key="typeDesign" title="Type Design (02)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="seatDesign" index="seatDesign" key="seatDesign" title="Seat Design(03)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="size" index="size" key="size" title="Size (04)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="rating" index="rating" key="rating" title="Rating (05)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="bore" index="bore" key="bore" title="Bore (06)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="endCon" index="endCon" key="endCon" title="EndCon (07)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="body" index="body" key="body" title="Body (08)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="ball" index="ball" key="ball" title="Ball (09)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="seat" index="seat" key="seat" title="Seat (10)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="seatInsert" index="seatInsert" key="seatInsert (11)" title="Seat Insert" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="stem" index="stem" key="stem" title="Stem (12)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="seal" index="seal" key="seal" title="Seal (13)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="bolting" index="bolting" key="bolting" title="Bolt (14)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="disc" index="disc" key="disc" title="Disc (15)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="plates" index="plates" key="plates" title="Plates (16)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="shaft" index="shaft" key="shaft" title="Shaft (17)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="spring" index="spring" key="spring" title="Spring (18)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="armPin" index="armPin" key="armPin" title="Arm Pin (19)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="backseat" index="backseat" key="backseat" title="Backseat (20)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="arm" index="arm" key="arm" title="Arm (21)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="hingePin" index="hingePin" key="hingePin (22)" title="Hinge Pin" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="stopPin" index="stopPin" key="stopPin" title="Stop Pin (23)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="oper" index="oper" key="oper" title="Operator (99)" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="note" index="note" key="note" title="Note" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name = "quantity" index = "quantity" key = "quantity" title = " Quantity" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "unitPrice" index = "unitPrice" key = "unitPrice" title = "Unit Price" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name = "total" index = "total" key = "total" title = "Total" width = "100" sortable = "false" 
            formatter="number"
            align="right"
            formatoptions= "{ thousandsSeparator:','}"
        />
        
        </sjg:grid >
    </div>
    <br class="spacer" />
    <br class="spacer" />
   <div>
    <table>
        <tr>
            <td valign="top">
            </td>
            <td width="100%" >
                <table align="right">
                    <tr>
                        <td align="right"><B>Total Transaction</B></td>
                        <td>
                            <s:textfield id="salesQuotationTotalTransactionAmount" name="salesQuotationTotalTransactionAmount" placeHolder="0.00"  readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Discount</B>
                            <s:textfield id="salesQuotationDiscountPercent" name="salesQuotationDiscountPercent" readonly="true" size="8" placeHolder="0.00" cssStyle="text-align:right"></s:textfield>
                            %
                        </td>
                        <td align="right">
                            <s:textfield id="salesQuotationDiscountAmount" name="salesQuotationDiscountAmount"  placeHolder="0.00"  readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr >
                        <td align="right"><B>Sub Total (Tax Base)</B></td>
                        <td>
                            <s:textfield id="salesQuotationSubTotal" name="salesQuotationSubTotal" placeHolder="0.00" readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>VAT</B>
                            <s:textfield id="salesQuotationVATPercent" name="salesQuotationVATPercent" readonly="true"  size="8" placeHolder="0.00" cssStyle="text-align:right"></s:textfield>
                            %
                        </td>
                        <td align="right">
                            <s:textfield id="salesQuotationVATAmount" name="salesQuotationVATAmount" placeHolder="0.00" readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Grand Total</B></td>
                        <td>
                            <s:textfield id="salesQuotationGrandTotalAmount"  name="salesQuotationGrandTotalAmount" placeHolder="0.00" readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>            
    </table>
</div> 
