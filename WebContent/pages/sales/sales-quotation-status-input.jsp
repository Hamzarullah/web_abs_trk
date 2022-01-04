
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #salesQuotationStatusDetailInput_grid_pager_center,.ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgExchangeRate,#errmsgAddRow{
        color: red;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
    .tableBottomSQ{
        table-layout: fixed;
        width: 100%;
    }
</style>

<script type="text/javascript">
    
    var salesQuotationStatusDetaillastRowId=0,salesQuotationStatusDetail_lastSel = -1;
    var 
        rdbSalesQuotationStatusSALQUOStatus = $("#salesQuotationStatus\\.salQuoStatus"),
        txtSalesQuotationStatusSALQUOReasonCode = $("#salesQuotationStatus\\.salQuoReason\\.code"),
        txtSalesQuotationStatusSALQUOReasonName = $("#salesQuotationStatus\\.salQuoReason\\.name"),
        txtSalesQuotationStatusSALQUORemark = $("#salesQuotationStatus\\.salQuoRemark"),
                
        allFieldsSalesQuotationStatus = $([])

            .add(rdbSalesQuotationStatusSALQUOStatus)
            .add(txtSalesQuotationStatusSALQUOReasonCode)
            .add(txtSalesQuotationStatusSALQUOReasonName)
            .add(txtSalesQuotationStatusSALQUORemark);


    $(document).ready(function() {
        hoverButton();
        
        var orderStatus = $("#salesQuotationStatus\\.requestForQuotation\\.orderStatus").val();
        if($("#salesQuotationStatusUpdateMode").val()==="true"){
            salesQuotationStatusRequestForQuotationLoad(orderStatus);
            radioButtonStatusSalesQuotation();
        }
//        $('#salesQuotationStatusSALQUOStatusRad').prop('checked',true);
//        $("#salesQuotationStatus\\.salQuoStatus").val("");
        
        $('#salesQuotationStatusSALQUOStatusRadAPPROVED').change(function(ev){
            $("#salesQuotationStatus\\.salQuoStatus").val("APPROVED");
        });
        
        $('#salesQuotationStatusSALQUOStatusRadREVIEWING').change(function(ev){
            $("#salesQuotationStatus\\.salQuoStatus").val("REVIEWING");
        });
                
        $('#salesQuotationStatusSALQUOStatusRadBUDGETING').change(function(ev){
            $("#salesQuotationStatus\\.salQuoStatus").val("BUDGETING");
        });
        
        $('#salesQuotationStatusSALQUOStatusRadFAILED').change(function(ev){
            $("#salesQuotationStatus\\.salQuoStatus").val("FAILED");
        });
        
        $('#salesQuotationStatusSALQUOStatusRadCANCELLED').change(function(ev){
            $("#salesQuotationStatus\\.salQuoStatus").val("CANCELLED");
        });
        
        $.subscribe("salesQuotationStatusDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#salesQuotationStatusDetailInput_grid").jqGrid("getGridParam", "selrow");
        });
        
        salesQuotationStatusLoadDataDetail();
        
        $('#btnSalesQuotationStatusSave').click(function(ev) {
                if($("#salesQuotationStatus\\.salQuoStatus").val()==="") {
                    alertMessage("Apporval Status Can't be Empty");
                    return;
                }
                
                var ids = jQuery("#salesQuotationStatusDetailInput_grid").jqGrid('getDataIDs');
                
                if(ids.length === 0){
                    alertMessage('Fulfilled the Detail Grid in Sales Quotation');
                    return;
                }
                
                var dynamicDialog= $(
                    '<div id="conformBoxError">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure To Update Status?<br/><br/>' +
                    '<span style="float:left; margin:0 7px 20px 0;">'+
                    '</span>SAL QUO No: '+$("#salesQuotationStatus\\.code").val()+'<br/><br/>' +    
                    '</div>');
                dynamicDialog.dialog({
                    title           : "Confirmation",
                    closeOnEscape   : false,
                    modal           : true,
                    width           : 300,
                    resizable       : false,
                    buttons         : 
                                    [{
                                        text : "Yes",
                                        click : function() {               
                                            var url = "sales/sales-quotation-status-save";
                                            var params = "salQuoStatus="+rdbSalesQuotationStatusSALQUOStatus.val();
                                            params+="&salQuoReasonCode="+txtSalesQuotationStatusSALQUOReasonCode.val();
                                            params+="&salQuoRemark="+txtSalesQuotationStatusSALQUORemark.val();
                                            params+="&salesQuotationCode="+$("#salesQuotationStatus\\.code").val();
                                            $.post(url, params, function(data) {
                                                if (data.error) {
                                                    alertMessage(data.errorMessage);
                                                    return;
                                                }
                                                alertMessage(data.message);

                                                var url = "sales/sales-quotation-status";
                                                var params = "";
                                                pageLoad(url, params, "#tabmnuSALES_QUOTATION_STATUS"); 
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
  
        $('#btnSalesQuotationStatusCancel').click(function(ev) {
            var url = "sales/sales-quotation-status";
            var params = "";
            pageLoad(url, params, "#tabmnuSALES_QUOTATION_STATUS"); 
        });
        
        var subTotal = parseFloat($("#salesQuotationStatus\\.totalTransactionAmount").val()) - parseFloat($("#salesQuotationStatus\\.discountAmount").val());

        $("#salesQuotationStatus\\.totalTransactionAmount").val(formatNumber(parseFloat($("#salesQuotationStatus\\.totalTransactionAmount").val()), 2));
        $("#salesQuotationStatus\\.discountPercent").val(formatNumber(parseFloat($("#salesQuotationStatus\\.discountPercent").val()), 2));
        $("#salesQuotationStatus\\.discountAmount").val(formatNumber(parseFloat($("#salesQuotationStatus\\.discountAmount").val()), 2));
        $("#salesQuotationStatus\\.taxBaseAmount").val(formatNumber(subTotal, 2));
        $("#salesQuotationStatus\\.vatPercent").val(formatNumber(parseFloat($("#salesQuotationStatus\\.vatPercent").val()), 2));
        $("#salesQuotationStatus\\.vatAmount").val(formatNumber(parseFloat($("#salesQuotationStatus\\.vatAmount").val()), 2));
        $("#salesQuotationStatus\\.grandTotalAmount").val(formatNumber(parseFloat($("#salesQuotationStatus\\.grandTotalAmount").val()), 2));
     
    }); //EOF Ready
    
    
    function salesQuotationStatusLoadDataDetail() {
        var url = "sales/sales-quotation-detail-data";
        var params = "salesQuotation.code=" +$("#salesQuotationStatus\\.code").val();
        
            $.getJSON(url, params, function(data) {
                salesQuotationStatusDetaillastRowId = 0;
                for (var i=0; i<data.listSalesQuotationDetailTemp.length; i++) {
                    salesQuotationStatusDetaillastRowId++;
                    $("#salesQuotationStatusDetailInput_grid").jqGrid("addRowData", salesQuotationStatusDetaillastRowId, data.listSalesQuotationDetailTemp[i]);
                    $("#salesQuotationStatusDetailInput_grid").jqGrid('setRowData',salesQuotationStatusDetaillastRowId,{
                        salesQuotationStatusDetailDelete              : "delete",
                        salesQuotationStatusDetailBodyConstruction    : data.listSalesQuotationDetailTemp[i].bodyConstruction,
                        salesQuotationStatusDetailBore                : data.listSalesQuotationDetailTemp[i].bore,
                        salesQuotationStatusDetailDisc                : data.listSalesQuotationDetailTemp[i].disc,
                        salesQuotationStatusDetailPlates              : data.listSalesQuotationDetailTemp[i].plates,
                        salesQuotationStatusDetailShaft               : data.listSalesQuotationDetailTemp[i].shaft,
                        salesQuotationStatusDetailSpring              : data.listSalesQuotationDetailTemp[i].spring,
                        salesQuotationStatusDetailArmPin              : data.listSalesQuotationDetailTemp[i].armPin,
                        salesQuotationStatusDetailHingePin            : data.listSalesQuotationDetailTemp[i].hingePin,
                        salesQuotationStatusDetailStopPin             : data.listSalesQuotationDetailTemp[i].stopPin,
                        salesQuotationStatusDetailArm                 : data.listSalesQuotationDetailTemp[i].arm,
                        salesQuotationStatusDetailBackseat            : data.listSalesQuotationDetailTemp[i].backseat,
                        salesQuotationStatusDetailUnitPrice           : data.listSalesQuotationDetailTemp[i].unitPrice,
                        salesQuotationStatusDetailNote                : data.listSalesQuotationDetailTemp[i].note,
                        salesQuotationStatusDetailValveTag            : data.listSalesQuotationDetailTemp[i].valveTag,
                        salesQuotationStatusDetailDataSheet           : data.listSalesQuotationDetailTemp[i].dataSheet,
                        salesQuotationStatusDetailDescription         : data.listSalesQuotationDetailTemp[i].description,
                        salesQuotationStatusDetailType                : data.listSalesQuotationDetailTemp[i].type,
                        salesQuotationStatusDetailSize                : data.listSalesQuotationDetailTemp[i].size,
                        salesQuotationStatusDetailRating              : data.listSalesQuotationDetailTemp[i].rating,
                        salesQuotationStatusDetailEndCon              : data.listSalesQuotationDetailTemp[i].endCon,
                        salesQuotationStatusDetailBody                : data.listSalesQuotationDetailTemp[i].body,
                        salesQuotationStatusDetailBall                : data.listSalesQuotationDetailTemp[i].ball,
                        salesQuotationStatusDetailSeat                : data.listSalesQuotationDetailTemp[i].seat,
                        salesQuotationStatusDetailStem                : data.listSalesQuotationDetailTemp[i].stem,
                        salesQuotationStatusDetailSeatInsert          : data.listSalesQuotationDetailTemp[i].seatInsert,
                        salesQuotationStatusDetailSeal                : data.listSalesQuotationDetailTemp[i].seal,
                        salesQuotationStatusDetailBolting             : data.listSalesQuotationDetailTemp[i].bolting,
                        salesQuotationStatusDetailSeatDesign          : data.listSalesQuotationDetailTemp[i].seatDesign,
                        salesQuotationStatusDetailOper                : data.listSalesQuotationDetailTemp[i].oper,
                        salesQuotationStatusDetailQuantity            : data.listSalesQuotationDetailTemp[i].quantity,
                        salesQuotationStatusDetailTotal               : data.listSalesQuotationDetailTemp[i].total,
                        salesQuotationStatusDetailValveTypeCode       : data.listSalesQuotationDetailTemp[i].valveTypeCode,
                        salesQuotationStatusDetailValveTypeName       : data.listSalesQuotationDetailTemp[i].valveTypeName
                    });
                }
//                }  calculateSalesQuotationDetail();
            });
    }
    
    function salesQuotationStatusRequestForQuotationLoad(orderStatus){
        if (orderStatus === 'BLANKET_ORDER'){
             $('#salesQuotationStatusRequestForQuotationRadBLANKET_ORDER').prop('checked',true);
             $('#salesQuotationStatusRequestForQuotationRadSALES_ORDER').prop('disabled',true);
        }
        if  (orderStatus === 'SALES_ORDER'){
            $('#salesQuotationStatusRequestForQuotationRadSALES_ORDER').prop('checked',true);
            $('#salesQuotationStatusRequestForQuotationRadBLANKET_ORDER').prop('disabled',true);
        }
        
    }
    
    function radioButtonStatusSalesQuotation(){
 
        //SFS
        if ($("#salesQuotationStatus\\.salQuoStatus").val()==="APPROVED"){
            $('#salesQuotationStatusSALQUOStatusRadAPPROVED').prop('checked',true);
        }
        if ($("#salesQuotationStatus\\.salQuoStatus").val()==="REVIEWING"){
            $('#salesQuotationStatusSALQUOStatusRadREVIEWING').prop('checked',true);
        }
        if ($("#salesQuotationStatus\\.salQuoStatus").val()==="BUDGETING"){
            $('#salesQuotationStatusSALQUOStatusRadBUDGETING').prop('checked',true);
        }
        if ($("#salesQuotationStatus\\.salQuoStatus").val()==="FAILED"){
            $('#salesQuotationStatusSALQUOStatusRadFAILED').prop('checked',true);
        }
        if ($("#salesQuotationStatus\\.salQuoStatus").val()==="CANCELLED"){
            $('#salesQuotationStatusSALQUOStatusRadCANCELLED').prop('checked',true);
        }
   
    }
               
</script>

<s:url id="remoteurlSalesQuotationStatusDetailInput" action="" />
<b>SALES QUOTATION STATUS</b>
<hr>
<br class="spacer" />

<div id="salesQuotationStatusInput" class="content ui-widget">
    <s:form id="frmSalesQuotationStatusInput">
        <table cellpadding="2" cellspacing="2" id="headerSalesQuotationStatusInput">
        <tr>
            <td valign="top">
         <table>
           <tr>
                <td align="right" hidden = "true">SLS-QOU No
                <s:textfield id="salesQuotationStatus.salQuoNo" name="salesQuotationStatus.salQuoNo" key="salesQuotationStatus.rfqNo" size="25"></s:textfield>
                <s:textfield id="salesQuotationStatusUpdateMode" name="salesQuotationStatusUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationStatusCloneMode" name="salesQuotationStatusCloneMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationStatusReviseMode" name="salesQuotationStatusReviseMode" size="20" cssStyle="display:none"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>SLS-QOU No *</B></td>
                <td>
                    <s:textfield id="salesQuotationStatus.code" name="salesQuotationStatus.code" key="salesQuotationStatus.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="salesQuotationStatusTemp.code" name="salesQuotationStatusTemp.code" key="salesQuotationStatusTemp.code" readonly="true" hidden = "true" size="22"></s:textfield>
                    <s:textfield id="salesQuotationStatusUpdateMode" name="salesQuotationStatusUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="salesQuotationStatusCloneMode" name="salesQuotationStatusCloneMode" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="salesQuotationStatusReviseMode" name="salesQuotationStatusReviseMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" hidden = "true">Revision
                <s:textfield id="salesQuotationStatus.revision" name="salesQuotationStatus.revision" key="salesQuotationStatus.revision" size="25"></s:textfield>
                <s:textfield id="salesQuotationStatusUpdateMode" name="salesQuotationStatusUpdateMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationStatusCloneMode" name="salesQuotationStatusCloneMode" size="20" cssStyle="display:none"></s:textfield>
                <s:textfield id="salesQuotationStatusReviseMode" name="salesQuotationStatusReviseMode" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref Sal Quo No </td>
                <td><s:textfield id="salesQuotationStatus.refQUOCode" name="salesQuotationStatus.refQUOCode" key="salesQuotationStatus.refQUOCode" readonly="true" size="25"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="salesQuotationStatus.transactionDate" name="salesQuotationStatus.transactionDate" displayFormat="dd/mm/yy" readonly="true" disabled="true" title=" " showOn="focus" size="22"></sj:datepicker>
                    <sj:datepicker id="salesQuotationStatusTransactionDate" name="salesQuotationStatusTransactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="salesQuotationStatusTemp.transactionDateTemp" name="salesQuotationStatusTemp.transactionDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>RFQ No *</B></td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.code" name="salesQuotationStatus.requestForQuotation.code" title=" " required="true" cssClass="required" maxLength="45" readonly="true" size="20"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Order Status</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.orderStatus" name="salesQuotationStatus.requestForQuotation.orderStatus" readonly="true" size="20" style="display:none"></s:textfield>
                    <s:radio id="salesQuotationStatusRequestForQuotationRad" name="salesQuotationStatusRequestForQuotationRad" list="{'BLANKET_ORDER','SALES_ORDER'}" ></s:radio></td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.branch.code" name="salesQuotationStatus.requestForQuotation.branch.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.branch.name" name="salesQuotationStatus.requestForQuotation.branch.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Project</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.project.code" name="salesQuotationStatus.requestForQuotation.project.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.project.name" name="salesQuotationStatus.requestForQuotation.project.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Subject</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.subject" name="salesQuotationStatus.requestForQuotation.subject" size="20" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Currency</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.currency.code" name="salesQuotationStatus.requestForQuotation.currency.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.currency.name" name="salesQuotationStatus.requestForQuotation.currency.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.customer.code" name="salesQuotationStatus.requestForQuotation.customer.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.customer.name" name="salesQuotationStatus.requestForQuotation.customer.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">End User</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.endUser.code" name="salesQuotationStatus.requestForQuotation.endUser.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.endUser.name" name="salesQuotationStatus.requestForQuotation.endUser.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Attn</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.attn" name="salesQuotationStatus.requestForQuotation.attn" size="20" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Sales Person</td>
                <td>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.salesPerson.code" name="salesQuotationStatus.requestForQuotation.salesPerson.code" size="20" maxLength="45" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.requestForQuotation.salesPerson.name" name="salesQuotationStatus.requestForQuotation.salesPerson.name" size="35%" maxLength="45" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:120px"><B>Ship To (City) *</B></td>
                <td colspan="2">
                    <s:textfield id="salesQuotationStatus.city.code" name="salesQuotationStatus.city.code" size="22" readonly="true" ></s:textfield>
                    <s:textfield id="salesQuotationStatus.city.name" name="salesQuotationStatus.city.name" size="40" readonly="true" required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:120px"><B>Term Of Delivery *</B></td>
                <td colspan="2">
                    <s:textfield id="salesQuotationStatus.termOfDelivery.code" name="salesQuotationStatus.termOfDelivery.code" size="22" readonly="true"></s:textfield>
                    <s:textfield id="salesQuotationStatus.termOfDelivery.name" name="salesQuotationStatus.termOfDelivery.name" size="40" readonly="true" required="true" cssClass="required"></s:textfield>
                </td>
            </tr>
            </table>
       </td>
       <td valign="top">
        <table>
            <tr>
                <td align="right">Price Validity</td>
                <td colspan="3">
                    <s:textfield id="salesQuotationStatus.priceValidity" name="salesQuotationStatus.priceValidity" readonly="true" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Certificate Documentation</td>
                <td colspan="3">
                    <s:textarea id="salesQuotationStatus.certificateDocumentation" name="salesQuotationStatus.certificateDocumentation" readonly="true" cols="70" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Testing</td>
                <td colspan="3">
                    <s:textarea id="salesQuotationStatus.testing" name="salesQuotationStatus.testing" readonly="true" cols="70" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Inspection</td>
                <td colspan="3">
                    <s:textarea id="salesQuotationStatus.inspection" name="salesQuotationStatus.inspection" readonly="true" cols="70" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Painting</td>
                <td colspan="3">
                    <s:textarea id="salesQuotationStatus.painting" name="salesQuotationStatus.painting" readonly="true" cols="70" rows="2" height="20"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Packing</td>
                <td colspan="3">
                    <s:textfield id="salesQuotationStatus.packing" name="salesQuotationStatus.packing" readonly="true" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Tagging</td>
                <td colspan="3">
                    <s:textfield id="salesQuotationStatus.tagging" name="salesQuotationStatus.tagging" readonly="true" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Warranty</td>
                <td colspan="3">
                    <s:textfield id="salesQuotationStatus.warranty" name="salesQuotationStatus.warranty" readonly="true" size="27"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3">
                    <s:textfield id="salesQuotationStatus.refNo" name="salesQuotationStatus.refNo" size="27" readonly="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="salesQuotationStatus.remark" name="salesQuotationStatus.remark"  cols="70" rows="2" height="20" readonly="true"></s:textarea>
                </td>
            </tr>
            <tr>
                <td align="right">Sales Quotation Status </td>
                <s:textfield id="salesQuotationStatus.salQuoStatus" name="salesQuotationStatus.salQuoStatus" readonly="false" size="15" style="display:none"></s:textfield>
                <td><s:radio id="salesQuotationStatusSALQUOStatusRad" name="salesQuotationStatusSALQUOStatusRad" list="{'APPROVED','REVIEWING','BUDGETING','FAILED','CANCELLED'}"></s:radio></td>
            </tr>
            <tr>
                <td align="right" valign="top">Sales Quotation Reason</td>
                <td colspan="2">
                <script type = "text/javascript">

                      
                    $('#salesQuotationStatus_btnReason').click(function(ev) {
                        window.open("./pages/search/search-reason.jsp?iddoc=salesQuotationStatus&idsubdoc=salQuoReason","Search", "width=600, height=500");
                    });
                    
                    txtSalesQuotationStatusSALQUOReasonCode.change(function(ev) {

                        if(txtSalesQuotationStatusSALQUOReasonCode.val()===""){
                            txtSalesQuotationStatusSALQUOReasonCode.val("");
                            return;
                        }
                        var url = "master/reason-get";
                        var params = "reason.code=" + txtSalesQuotationStatusSALQUOReasonCode.val();
                            params += "&reason.activeStatus=TRUE";
                            alert(params);
                            return;
                        $.post(url, params, function(result) {
                            var data = (result);
                            if (data.reasonTemp){
                                txtSalesQuotationStatusSALQUOReasonCode.val(data.reasonTemp.code);
                                txtSalesQuotationStatusSALQUOReasonName.val(data.reasonTemp.name);
                            }
                            else{
                                alertMessage("Reason Not Found!",txtSalesQuotationStatusSALQUOReasonCode);
                                txtSalesQuotationStatusSALQUOReasonCode.val("");
                                txtSalesQuotationStatusSALQUOReasonName.val("");
                            }
                        });
                    });
                </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="salesQuotationStatus.salQuoReason.code" name="salesQuotationStatus.salQuoReason.code" size="25"></s:textfield>
                        <sj:a id="salesQuotationStatus_btnReason" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-branch-bank-received" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                    <s:textfield id="salesQuotationStatus.salQuoReason.name" name="salesQuotationStatus.salQuoReason.name" size="30" readonly="true"></s:textfield>
                </td>    
            </tr>
            <tr>
                <td align="right" valign="top">Sales Quotation Remark</td>
                <td colspan="3">
                    <s:textarea id="salesQuotationStatus.salQuoRemark" name="salesQuotationStatus.salQuoRemark"  cols="70" rows="2" height="20" readonly="false"></s:textarea>
                </td>
            </tr>
            <tr hidden="true">
                <td>
                    <s:textfield id="salesQuotationStatus.createdBy" name="salesQuotationStatus.createdBy" key="salesQuotationStatus.createdBy" readonly="true" size="22"></s:textfield>
                    <sj:datepicker id="salesQuotationStatus.createdDate" name="salesQuotationStatus.createdDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss"></sj:datepicker>
                    <sj:datepicker id="salesQuotationStatusTransactionDateFirstSession" name="salesQuotationStatusTransactionDateFirstSession" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    <sj:datepicker id="salesQuotationStatusTransactionDateLastSession" name="salesQuotationStatusTransactionDateLastSession" size="15" showOn="focus" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="salesQuotationStatusTemp.createdDateTemp" name="salesQuotationStatusTemp.createdDateTemp" size="20"></s:textfield>
                </td>
            </tr>
        </table>
    </td>
        <br class="spacer" />
        <div id="salesQuotationStatusDetailInputGrid">
            <sjg:grid
                id="salesQuotationStatusDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listSalesQuotationDetail"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="$('#tabmnuSalesQuotationStatusDetail').width()"
                editurl="%{remoteurlSalesQuotationStatusDetailInput}"
                onSelectRowTopics="salesQuotationStatusDetailInput_grid_onSelect"
                >
                <sjg:gridColumn
                    name="salesQuotationStatusDetailValveTypeCode" index="salesQuotationStatusDetailValveTypeCode" key="salesQuotationStatusDetailValveTypeCode" 
                    title="Valve Type Code" width="200" sortable="true" editable="false" edittype="text"
                />     
                <sjg:gridColumn
                    name="salesQuotationStatusDetailValveTypeName" index="salesQuotationStatusDetailValveTypeName" key="salesQuotationStatusDetailValveTypeName" 
                    title="Valve Type Name" width="200" sortable="true" editable="false" edittype="text" 
                />     
                <sjg:gridColumn
                    name="salesQuotationStatusDetailValveTag" index="salesQuotationStatusDetailValveTag" key="salesQuotationStatusDetailValveTag" 
                    title="Valve Tag" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailDataSheet" index="salesQuotationStatusDetailDataSheet" key="salesQuotationStatusDetailDataSheet" 
                    title="Data Sheet" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailDescription" index="salesQuotationStatusDetailDescription" key="salesQuotationStatusDetailDescription" 
                    title="Description" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailBodyConstruction" index="salesQuotationStatusDetailBodyConstruction" key="salesQuotationStatusDetailBodyConstruction" 
                    title="Body Construction (01)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailTypeDesign" index="salesQuotationStatusDetailTypeDesign" key="salesQuotationStatusDetailTypeDesign" 
                    title="Type Design (02)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailSeatDesign" index="salesQuotationStatusDetailSeatDesign" key="salesQuotationStatusDetailSeatDesign" 
                    title="Seat Design (03)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailSize" index="salesQuotationStatusDetailSize" key="salesQuotationStatusDetailSize" 
                    title="Size (04)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailRating" index="salesQuotationStatusDetailRating" key="salesQuotationStatusDetailRating" 
                    title="Rating (05)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailBore" index="salesQuotationStatusDetailBore" key="salesQuotationStatusDetailBore" 
                    title="Bore (06)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailEndCon" index="salesQuotationStatusDetailEndCon" key="salesQuotationStatusDetailEndCon" 
                    title="End Con (07)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailBody" index="salesQuotationStatusDetailBody" key="salesQuotationStatusDetailBody" 
                    title="Body (08)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailBall" index="salesQuotationStatusDetailBall" key="salesQuotationStatusDetailBall" 
                    title="Ball (09)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailSeat" index="salesQuotationStatusDetailSeat" key="salesQuotationStatusDetailSeat" 
                    title="Seat (10)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailSeatInsert" index="salesQuotationStatusDetailSeatInsert" key="salesQuotationStatusDetailSeatInsert" 
                    title="Seat Insert (11)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailStem" index="salesQuotationStatusDetailStem" key="salesQuotationStatusDetailStem" 
                    title="Stem (12)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailSeal" index="salesQuotationStatusDetailSeal" key="salesQuotationStatusDetailSeal" 
                    title="Seal (13)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailBolting" index="salesQuotationStatusDetailBolting" key="salesQuotationStatusDetailBolting" 
                    title="Bolt (14)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailDisc" index="salesQuotationStatusDetailDisc" key="salesQuotationStatusDetailDisc" 
                    title="Disc (15)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailPlates" index="salesQuotationStatusDetailPlates" key="salesQuotationStatusDetailPlates" 
                    title="Plates (16)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailShaft" index="salesQuotationStatusDetailShaft" key="salesQuotationStatusDetailShaft" 
                    title="Shaft (17)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailSpring" index="salesQuotationStatusDetailSpring" key="salesQuotationStatusDetailSpring" 
                    title="Spring (18)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailArmPin" index="salesQuotationStatusDetailArmPin" key="salesQuotationStatusDetailArmPin" 
                    title="Arm Pin (19)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailBackseat" index="salesQuotationStatusDetailBackseat" key="salesQuotationStatusDetailBackseat" 
                    title="Backseat (20)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailArm" index="salesQuotationStatusDetailArm" key="salesQuotationStatusDetailArm" 
                    title="Arm (21)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailHingePin" index="salesQuotationStatusDetailHingePin" key="salesQuotationStatusDetailHingePin" 
                    title="Hinge Pin (22)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailStopPin" index="salesQuotationStatusDetailStopPin" key="salesQuotationStatusDetailStopPin" 
                    title="Stop Pin (23)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailOper" index="salesQuotationStatusDetailOper" key="salesQuotationStatusDetailOper" 
                    title="Operator (99)" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailNote" index="salesQuotationStatusDetailNote" key="salesQuotationStatusDetailNote" 
                    title="Note" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailQuantity" index="salesQuotationStatusDetailQuantity" key="salesQuotationStatusDetailQuantity" title="Quantity" 
                    width="80" align="right" editable="false" edittype="false" 
                    formatter="number" editrules="{ double: true }"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailUnitPrice" index="salesQuotationStatusDetailUnitPrice" key="salesQuotationStatusDetailUnitPrice" title="UnitPrice" 
                    width="150" align="right" editable="false" edittype="text" formatoptions= "{ thousandsSeparator:','}"
                    formatter="number" editrules="{ double: true }"
                />
                <sjg:gridColumn
                    name="salesQuotationStatusDetailTotal" index="salesQuotationStatusDetailTotal" key="salesQuotationStatusDetailTotal" title="Total" 
                    width="150" align="right" editable="false" edittype="text"
                    formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                />
            </sjg:grid >
        </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                       <tr height="10px"/>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnSalesQuotationStatusSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnSalesQuotationStatusCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
        </table>
    </s:form>
    <s:form id="frmSalesQuotationStatus">
            <table width="100%">
                <tr>
                    <td align="right"><B>Total Transaction</B></td>
                    <td width="100px">
                        <s:textfield id="salesQuotationStatus.totalTransactionAmount" name="salesQuotationStatus.totalTransactionAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Discount
                        <s:textfield id="salesQuotationStatus.discountPercent" name="salesQuotationStatus.discountPercent" readonly="true" size="5" cssStyle="text-align:right"></s:textfield>
                        %
                    </td>
                    <td><s:textfield id="salesQuotationStatus.discountAmount" name="salesQuotationStatus.discountAmount" readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Sub Total(Tax Base)</B></td>
                    <td>
                        <s:textfield id="salesQuotationStatus.taxBaseAmount" name="salesQuotationStatus.taxBaseAmount" readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">VAT
                    <s:textfield id="salesQuotationStatus.vatPercent" name="salesQuotationStatus.vatPercent" readonly="true" size="5" cssStyle="text-align:right"></s:textfield>
                        %
                    </td>
                    <td><s:textfield id="salesQuotationStatus.vatAmount" name="salesQuotationStatus.vatAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Grand Total</B></td>
                    <td>
                        <s:textfield id="salesQuotationStatus.grandTotalAmount" name="salesQuotationStatus.grandTotalAmount"  readonly="true" cssStyle="text-align:right" size="25"></s:textfield>
                    </td>
                </tr>
            </table>
        </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />
        
    