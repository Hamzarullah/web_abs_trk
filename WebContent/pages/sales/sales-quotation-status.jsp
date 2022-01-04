
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #salesQuotationStatusDetail_grid_pager_center{
        display: none;
    }    
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>
<script type="text/javascript">
                       
    $(document).ready(function(){
        
        hoverButton();
        
        $('#salesQuotationStatusSearchValidStatusRadYES').prop('checked',true);
            $("#salesQuotationStatusSearchValidStatus").val("true");
        
        $('input[name="salesQuotationStatusSearchValidStatusRad"][value="ALL"]').change(function(ev){
            var value="";
            $("#salesQuotationStatusSearchValidStatus").val(value);
        });
        
        $('input[name="salesQuotationStatusSearchValidStatusRad"][value="YES"]').change(function(ev){
            var value="TRUE";
            $("#salesQuotationStatusSearchValidStatus").val(value);
        });
                
        $('input[name="salesQuotationStatusSearchValidStatusRad"][value="NO"]').change(function(ev){
            var value="FALSE";
            $("#salesQuotationStatusSearchValidStatus").val(value);
        });
        
        $('#salesQuotationStatusSearchSALQUOStatusRadNO\\ STATUS').prop('checked',true);
            $("#salesQuotationStatusSearchSALQUOStatus").val("NO_STATUS");
            
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="NO_STATUS"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("NO_STATUS");
        });
        
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="BUDGETING"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("BUDGETING");
        });
        
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="APPROVED"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("APPROVED");
        });
        
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="FAILED"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("FAILED");
        });
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="REVIEWING"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("REVIEWING");
        });
        
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="CANCELLED"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("CANCELLED");
        });
        
        $('input[name="salesQuotationStatusSearchSALQUOStatusRad"][value="ALL"]').change(function(ev){
            $("#salesQuotationStatusSearchSALQUOStatus").val("");
        });
               
        $.subscribe("salesQuotationStatus_grid_onSelect", function(event, data){
            var selectedRowID = $("#salesQuotationStatus_grid").jqGrid("getGridParam", "selrow"); 
            var salesQuotationStatus = $("#salesQuotationStatus_grid").jqGrid("getRowData", selectedRowID);
            
            $("#salesQuotationStatusDetail_grid").jqGrid("setGridParam",{url:"sales/sales-quotation-detail-data?salesQuotation.code="+ salesQuotationStatus.code});
            $("#salesQuotationStatusDetail_grid").jqGrid("setCaption", "SALES QUOTATION STATUS DETAIL : " + salesQuotationStatus.code);
            $("#salesQuotationStatusDetail_grid").trigger("reloadGrid");
            
            $("#salesQuotationStatusTotalTransactionAmount").val(formatNumber(parseFloat(salesQuotationStatus.totalTransactionAmount), 2));
            $("#salesQuotationStatusDiscountPercent").val(formatNumber(parseFloat(salesQuotationStatus.discountPercent), 2));
            $("#salesQuotationStatusDiscountAmount").val(formatNumber(parseFloat(salesQuotationStatus.discountAmount), 2));
            
            var subTotal=parseFloat(salesQuotationStatus.totalTransactionAmount)-parseFloat(salesQuotationStatus.discountAmount);
            $("#salesQuotationStatusSubTotal").val(formatNumber(subTotal, 2));
            $("#salesQuotationStatusVATPercent").val(formatNumber(parseFloat(salesQuotationStatus.vatPercent), 2));
            $("#salesQuotationStatusVATAmount").val(formatNumber(parseFloat(salesQuotationStatus.vatAmount), 2));            
            $("#salesQuotationStatusGrandTotalAmount").val(formatNumber(parseFloat(salesQuotationStatus.grandTotalAmount), 2));  
        });
        
        $('#btnSalesQuotationStatusApproved').click(function(ev) {
            
            var url="sales/period-closing-confirmation";
            var params="";

            $.post(url,params,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var selectedRowId = $("#salesQuotationStatus_grid").jqGrid('getGridParam','selrow');
                var salesQuotationStatus = $("#salesQuotationStatus_grid").jqGrid('getRowData', selectedRowId);
                
                if(salesQuotationStatus.validStatus==="false"){
                    alertMessage("It Can't be Updated");
                    return;
                }
                
                if(salesQuotationStatus.salQUOStatus==="APPROVED"){
                    alertMessage("Cannot Change this Sales Quotation, since Status Approved / Failed / Cancelled");
                    return;
                }
                
                if(salesQuotationStatus.salQUOStatus==="FAILED"){
                    alertMessage("Cannot Change this Sales Quotation, since Status Approved / Failed / Cancelled");
                    return;
                }
                
                if(salesQuotationStatus.salQUOStatus==="CANCELLED"){
                    alertMessage("Cannot Change this Sales Quotation, since Status Approved / Failed / Cancelled");
                    return;
                }
                
                if (selectedRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                
                var ids = jQuery("#salesQuotationStatusDetail_grid").jqGrid('getDataIDs');
                
                if(ids.length === 0){
                    alertMessage('Fulfilled the Detail Grid in Sales Quotation');
                    return;
                }

                var url = "sales/sales-document-existing";
                var params = "salesDocument.documentNo=" + salesQuotationStatus.code;

                $.post(url,params,function(result){
                    var data=(result);
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    
                    var url = "sales/sales-quotation-status-input";
                    var params = "salesQuotationStatusUpdateMode =true" ;
                        params+="&salesQuotationStatus.code=" + salesQuotationStatus.code;
//                        alert(params);
                        pageLoad(url, params, "#tabmnuSALES_QUOTATION_STATUS");
                });

            });      
        });

        $('#btnSalesQuotationStatusRefresh').click(function(ev) {
            var url = "sales/sales-quotation-status";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_QUOTATION_STATUS");
            ev.preventDefault();   
        });
        
        $('#btnSalesQuotationStatus_search').click(function(ev) {
            formatDateSQStatus();
            $("#salesQuotationStatus_grid").jqGrid("clearGridData");
            $("#salesQuotationStatus_grid").jqGrid("setGridParam",{url:"sales/sales-quotation-status-data?" + $("#frmSalesQuotationStatusSearchInput").serialize()});
            $("#salesQuotationStatus_grid").trigger("reloadGrid");
            $("#salesQuotationStatusDetail_grid").jqGrid("clearGridData");
            $("#salesQuotationStatusDetail_grid").jqGrid("setCaption", "SALES QUOTATION STATUS DETAIL");
            formatDateSQStatus();
            ev.preventDefault();
           
        });
    });//EOF Ready
    
    function formatDateSQStatus(){
        var firstDate=$("#salesQuotationStatusSearchFirstDate").val();
        var firstDateValues= firstDate.split('/');
        var firstDateValue =firstDateValues[1]+"/"+firstDateValues[0]+"/"+firstDateValues[2];
        $("#salesQuotationStatusSearchFirstDate").val(firstDateValue);

        var lastDate=$("#salesQuotationStatusSearchLastDate").val();
        var lastDateValues= lastDate.split('/');
        var lastDateValue =lastDateValues[1]+"/"+lastDateValues[0]+"/"+lastDateValues[2];
        $("#salesQuotationStatusSearchLastDate").val(lastDateValue);
    }
    
    function reloadGridSQStatus() {
        $("#salesQuotationStatus_grid").trigger("reloadGrid");
      
    };

    function reloadDetailGridSQStatus() {
        $("#salesQuotationStatusDetail_grid").trigger("reloadGrid");  
        $("#salesQuotationStatusDetail_grid").jqGrid("clearGridData");
        $("#salesQuotationStatusDetail_grid").jqGrid("setCaption", "SALES QUOTATION DETAIL");
        clearTotalTransactionSalesQuotationStatus();
    };
      function clearTotalTransactionSalesQuotationStatus(){
        $("#salesQuotationStatusTotalTransactionAmount").val("0.00");
        $("#salesQuotationStatusDiscountPercent").val("0.00");
        $("#salesQuotationStatusDiscountAmount").val("0.00");
        $("#salesQuotationStatusSubTotal").val("0.00");
        $("#salesQuotationStatusVATPercent").val("0.00");
        $("#salesQuotationStatusVATAmount").val("0.00");
        $("#salesQuotationStatusOtherFeeAmount").val("0.00");
        $("#salesQuotationStatusGrandTotalAmount").val("0.00");
    };
    function calculateDetailSQStatus() {
        var ids = jQuery("#salesQuotationStatusDetail_grid").jqGrid('getDataIDs');
        for(var i=0;i<ids.length;i++){
            var qty = $("#" + i + "_quantity").val();
            var price = $("#" + i + "_price").val();


            var amount = (parseFloat(qty) * parseFloat(price));

            $("#salesQuotationStatusDetail_grid").jqGrid("setCell", i, "total", amount);
        }
    };
    
</script>
<s:url id="remoteurlSalesQuotationStatus" action="sales-quotation-status-data" />    
    <b>SALES QUOTATION STATUS</b>
    <hr/>
    <br class="spacer" />
    <sj:div id="salesQuotationStatusButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td> <a href="#" id="btnSalesQuotationStatusRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
<!--            <td><a href="#" id="btnSalesQuotationStatusPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  -->
        </tr>
    </table>
    </sj:div>
    <br class="spacer" />
    <br class="spacer" />

    <div id="SalesQuotationStatusInputSearch" class="content ui-widget">
        <s:form id="frmSalesQuotationStatusSearchInput">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right"><b>Period *</b></td>
                    <td>
                        <sj:datepicker id="salesQuotationStatusSearchFirstDate" name="salesQuotationStatusSearchFirstDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                        To
                        <sj:datepicker id="salesQuotationStatusSearchLastDate" name="salesQuotationStatusSearchLastDate" size="20" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    </td>
                </tr> 
                <tr>
                    <td align="right">SLS-QUO No</td>
                    <td>
                        <s:textfield id="salesQuotationStatusSearchCode" name="salesQuotationStatusSearchCode" size="30" placeHolder=" SQNo"></s:textfield>
                    </td>
                    <td align="right"><b>Customer</b></td>
                    <td>
                        <s:textfield id="salesQuotationStatusCustomerSearchCode" name="salesQuotationStatusCustomerSearchCode" size="20" placeHolder=" Code"></s:textfield>
                        <s:textfield id="salesQuotationStatusCustomerSearchName" name="salesQuotationStatusCustomerSearchName" size="20" placeHolder=" Name"></s:textfield>
                    </td>
                </tr>
                <tr>    
                    <td align="right">Remark</td>
                    <td>
                       <s:textfield id="salesQuotationStatusSearchRemark" name="salesQuotationStatusSearchRemark" size="30" placeHolder=" Remark"></s:textfield>
                    </td>
                </tr>
                <tr>    
                    <td align="right">Ref No</td>
                    <td>
                       <s:textfield id="salesQuotationStatusSearchRefNo" name="salesQuotationStatusSearchRefNo" size="30" placeHolder=" RefNo"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Quotation Status</B></td>
                    <td>
                        <s:radio id="salesQuotationStatusSearchSALQUOStatusRad" name="salesQuotationStatusSearchSALQUOStatusRad" label="salesQuotationStatusSearchSALQUOStatusRad" list="{'ALL','NO STATUS','REVIEWING','BUDGETING','FAILED','CANCELLED','APPROVED'}"></s:radio>
                        <s:textfield id="salesQuotationStatusSearchSALQUOStatus" name="salesQuotationStatusSearchSALQUOStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><b>Valid Status</b></td>
                    <td>
                        <s:radio id="salesQuotationStatusSearchValidStatusRad" name="salesQuotationStatusSearchValidStatusRad" label="salesQuotationStatusSearchValidStatusRad" list="{'ALL','YES','NO'}"></s:radio>
                        <s:textfield id="salesQuotationStatusSearchValidStatus" name="salesQuotationStatusSearchValidStatus" size="20" style="Display:none" ></s:textfield>
                    </td>
                </tr>
            </table>
            <br class="spacer" />
            <sj:a href="#" id="btnSalesQuotationStatus_search" button="true">Search</sj:a>
            <br class="spacer" />
            <br class="spacer" />
        </s:form>
    </div>
    <br class="spacer" />
                  
    <div id="SalesQuotationStatusGrid">
        <sjg:grid
            id="salesQuotationStatus_grid"
            caption="SALES QUOTATION STATUS"
            dataType="json"
            href="%{remoteurlSalesQuotationStatus}"
            pager="true"
            navigator="false"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            gridModel="listSalesQuotationStatusTemp"
            rowList="10,20,30"
            rowNum="10"
            sortable="true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuSALES_QUOTATION_STATUS').width()"
            onSelectRowTopics="salesQuotationStatus_grid_onSelect"
        >
       <sjg:gridColumn
            name="code" index="code" key="code" title="SLS-QUO No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="salQUOStatus" index="salQUOStatus" key="salQUOStatus" title="Sales Quotation Status" width="130" sortable="true" 
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
            name="customerCode" index="customerCode" key="customerCode" title="Customer Code" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="customerName" index="customerName" key="customerName" title="Customer " width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="endUserName" index="endUserName" key="endUserName" title="End User" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="salesPersonCode" index="salesPersonCode" key="salesPersonCode" title="Sales Person Code" width="130" sortable="true" hidden="true"
        />
       <sjg:gridColumn
            name="salesPersonName" index="salesPersonName" key="salesPersonName" title="Sales Person " width="130" sortable="true" 
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
            name="refNo" index="refNo" key="refNo" title="Ref No" width="130" sortable="true" 
        />
       <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark" width="130" sortable="true" 
        />
       
        </sjg:grid >
    </div>
    <br class="spacer" />
    <br class="spacer" />
    
    <div>
    <sj:a href="#" id="btnSalesQuotationStatusApproved" button="true" style="width: 90px">Status</sj:a>
    </div>
    
    <br class="spacer" />
    <br class="spacer" />
    <div id="SalesQuotationStatusDetailGrid">
        <sjg:grid
            id="salesQuotationStatusDetail_grid"
            caption="SALES QUOTATION STATUS DETAIL"
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
            width="$('#tabmnuSALES_QUOTATION_STATUS').width()"
            
        ><sjg:gridColumn
            name="valveTypeCode" index="valveTypeCode" key="valveTypeCode" title="Valve Type Code" width="85" sortable="true"  align="left"
        />
        <sjg:gridColumn
            name="valveTypeName" index="valveTypeName" key="valveTypeName" title="Valve Type Name" width="85" sortable="true"  align="left"
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
                            <s:textfield id="salesQuotationStatusTotalTransactionAmount" name="salesQuotationStatusTotalTransactionAmount" placeHolder="0.00"  readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Discount</B>
                            <s:textfield id="salesQuotationStatusDiscountPercent" name="salesQuotationStatusDiscountPercent" readonly="true" size="8" placeHolder="0.00" cssStyle="text-align:right"></s:textfield>
                            %
                        </td>
                        <td align="right">
                            <s:textfield id="salesQuotationStatusDiscountAmount" name="salesQuotationStatusDiscountAmount"  placeHolder="0.00"  readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr >
                        <td align="right"><B>Sub Total (Tax Base)</B></td>
                        <td>
                            <s:textfield id="salesQuotationStatusSubTotal" name="salesQuotationStatusSubTotal" placeHolder="0.00" readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>VAT</B>
                            <s:textfield id="salesQuotationStatusVATPercent" name="salesQuotationStatusVATPercent" readonly="true"  size="8" placeHolder="0.00" cssStyle="text-align:right"></s:textfield>
                            %
                        </td>
                        <td align="right">
                            <s:textfield id="salesQuotationStatusVATAmount" name="salesQuotationStatusVATAmount" placeHolder="0.00" readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><B>Grand Total</B></td>
                        <td>
                            <s:textfield id="salesQuotationStatusGrandTotalAmount"  name="salesQuotationStatusGrandTotalAmount" placeHolder="0.00" readonly="true" cssStyle="text-align:right"></s:textfield>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>            
    </table>
</div> 
