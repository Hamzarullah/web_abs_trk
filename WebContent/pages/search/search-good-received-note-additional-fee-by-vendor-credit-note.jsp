
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<%@ taglib prefix="sjt" uri="/struts-jquery-tree-tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />        
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow-x: hidden;
            overflow-y: auto;
            overflow: scroll;
            /*overflow: -moz-scrollbars-vertical;*/
        }
        input{border-radius: 3px;height:18px}
        #dlgSearch_good_received_note_additional_fee_by_vendor_credit_note_pager_center{
            display: none;
        }
    </style>
    
<script type = "text/javascript">
    
    var search_finance_document_type = '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_vendor_code = '<%= request.getParameter("vendorCode") %>';
    var id_currencyCode_code = '<%= request.getParameter("currencyCode") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){ 
        
        $('#goodReceivedNoteAdditionalFeeByVendorCreditNoteVendorCode').val(id_vendor_code);
        $('#goodReceivedNoteAdditionalFeeByVendorCreditNoteCurrencyCode').val(id_currencyCode_code);
     
        $("#btn_dlg_GoodReceivedNoteAdditionalFeeByVendorCreditNoteSearch").click(function(ev) {
            $("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").jqGrid("setGridParam",{url:"inventory/good-received-note-additional-fee-by-vendor-credit-note?"+$("#frmGoodReceivedNoteAdditionalFeeByVendorCreditNoteSearch").serialize(), page:1});
            $("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").trigger("reloadGrid");
            
        jQuery("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").jqGrid('setGridParam', { gridComplete: function(){
                setHeightGridGrnByVcn();
                }});
        });
        
        $("#dlgGoodReceivedNoteAdditionalFeeByVendorCreditNote_cancelButton").click(function(ev) {
            window.close();
        });
            
        $("#dlgGoodReceivedNoteAdditionalFeeByVendorCreditNote_okButton").click(function(ev){
           
            goodReceivedNoteAdditionalFeeByVendorCreditNoteDetaillastRowId = rowLast;
            if (search_finance_document_type === "grid" ) {
                
                var ids = jQuery("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").jqGrid('getDataIDs');
         
                for(var i=0;i<ids.length;i++){
                    var exist = false;
                    var data = $("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").jqGrid('getRowData',ids[i]);
                    if($("input:checkbox[id='jqg_dlgSearch_good_received_note_additional_fee_by_vendor_credit_note_"+ids[i]+"']").is(":checked")){
                        var idsOpener = jQuery("#" + id_document + "Input_grid", opener.document).jqGrid('getDataIDs');
                        for(var j=0; j<idsOpener.length; j++){
                            var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            // Validasi data exist                           
                            if(id_document === 'vendorCreditNoteAdditionalFeeDetail'){
                                if(data.code === dataExist.vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode){
                                    exist = true;
                                }
                            }
                        }
                        if(exist){
//                            alert("data was in grid");
                        }else{
                            if(id_document === 'vendorCreditNoteAdditionalFeeDetail'){
                                
                                var defRow = {
                                    vendorCreditNoteAdditionalFeeDetailGoodReceivedNoteAdditionalFeeCode  : data.code,
                                    vendorCreditNoteAdditionalFeeDetailUnitOfMeasureCode                  : data.unitOfMeasureCode,
                                    vendorCreditNoteAdditionalFeeDetailQuantity                           : data.quantity,
                                    vendorCreditNoteAdditionalFeeDetailPrice                              : data.price,
                                    vendorCreditNoteAdditionalFeeDetailTotal                              : data.totalAmount,
                                    vendorCreditNoteAdditionalFeeDetailRemark                             : data.remark,
                                    vendorCreditNoteAdditionalFeeDetailCurrencyCode                       : data.currencyCode,
                                    vendorCreditNoteAdditionalFeeDetailCurrencyName                       : data.currencyName
                                };

                                window.opener.addRowDataMultiSelected(goodReceivedNoteAdditionalFeeByVendorCreditNoteDetaillastRowId,defRow);
                                goodReceivedNoteAdditionalFeeByVendorCreditNoteDetaillastRowId++;
                            }
                        }
                    }
                    
                }
               window.opener.vendorCreditNoteCalculateHeader();
                window.close();   
            }     
        });
        
    });
    
</script>
<body>
    
    <div class="ui-widget">
        <s:form id="frmGoodReceivedNoteAdditionalFeeByVendorCreditNoteSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Vendor</td>
                <td>
                    <s:textfield id="goodReceivedNoteAdditionalFeeByVendorCreditNoteVendorCode" name="goodReceivedNoteAdditionalFeeByVendorCreditNoteVendorCode" label="Vendor" readonly="true"></s:textfield>
                    <s:textfield id="goodReceivedNoteAdditionalFeeByVendorCreditNoteCurrencyCode" name="goodReceivedNoteAdditionalFeeByVendorCreditNoteCurrencyCode" label="Currency" readonly="true"></s:textfield>
                </td>
            </tr>
                <td align="right">GRN No</td>
                <td>
                    <s:textfield id="goodReceivedNoteAdditionalFeeByVendorCreditNoteGrnCode" name="goodReceivedNoteAdditionalFeeByVendorCreditNoteGrnCode" label="Grn No" size="41"></s:textfield>
                </td>
            <tr>
            </tr>
                <td align="right">Remark GRN</td>
                <td>
                    <s:textfield id="goodReceivedNoteAdditionalFeeByVendorCreditNoteGrnRemark" name="goodReceivedNoteAdditionalFeeByVendorCreditNoteGrnRemark" label="Remark" size="41"></s:textfield>
                </td>
            <tr>
            </tr>
                <td align="right">Remark Additional GRN</td>
                <td>
                    <s:textfield id="goodReceivedNoteAdditionalFeeByVendorCreditNoteRemarkAdditionalGrn" name="goodReceivedNoteAdditionalFeeByVendorCreditNoteRemarkAdditionalGrn" label="Remark" size="41"></s:textfield>
                </td>
            <tr>
                
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_GoodReceivedNoteAdditionalFeeByVendorCreditNoteSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <s:url id="remoteurldocumentsearch" action="" />
    <div class="ui-widget ui-widget-content">
        <script>
            function setHeightGridGrnByVcn(){   
           var ids = $("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").jqGrid('getDataIDs'); 
            if(parseInt(ids.length) > 15){
                $("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").parents(".ui-jqgrid-bdiv").css('height','475px');
            }else{
                $("#dlgSearch_good_received_note_additional_fee_by_vendor_credit_note").parents(".ui-jqgrid-bdiv").css('height','auto');
                }
             }
            </script>
        <sjg:grid
        id="dlgSearch_good_received_note_additional_fee_by_vendor_credit_note"
        dataType="json"
        href="%{remoteurGoodReceivedNoteAdditionalFeeByVendorCreditNoteSearch}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        navigatorSearch="false"
        gridModel="listGoodReceivedNoteAdditionalFeeByVendorCreditNoteTemp"
        rowNum="10000"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        editinline="true"
        multiselect = "true"
        width="$('#tabmnuGoodReceivedNoteAdditionalFeeByVendorCreditNot').width()"
            
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="grnCode" index="grnCode" key="grnCode" title="GRN No" width="130" sortable="true"
        />
        <sjg:gridColumn
            name="headerCode" index="headerCode" key="headerCode" title="Header Code" width="120" sortable="true" hidden="true"
        />
        <sjg:gridColumn
            name="vendorCode" index="vendorCode" key="vendorCode" title="Vendor Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="vendorName" index="vendorName" key="vendorName" title="Vendor Name" width="120" sortable="true"
        />
        <sjg:gridColumn
            name="currencyCode" index="currencyCode" key="currencyCode" title="Currency Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="currencyName" index="currencyName" key="currencyName" title="Currency Name" width="120" sortable="true"
        />
        <sjg:gridColumn
            name="unitOfMeasureCode" index="unitOfMeasureCode" key="unitOfMeasureCode" title="UOM" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="quantity" index="quantity" key="quantity" title="Quantity" width="100" sortable="true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="price" index="price" key="price" title="Price" width="100" sortable="true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="totalAmount" index="totalAmount" key="totalAmount" title="Total Amount" width="100" sortable="true" align="right"
            formatter="number" editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
        />
        <sjg:gridColumn
            name="remark" index="remark" key="remark" title="Remark Additional GRN" width="150" sortable="true"
        />
        <sjg:gridColumn
            name="grnRemark" index="grnRemark" key="grnRemark" title="Remark GRN" width="150" sortable="true"
        />
        </sjg:grid >      
    </div>
    
    <br></br>
    <sj:a href="#" id="dlgGoodReceivedNoteAdditionalFeeByVendorCreditNote_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgGoodReceivedNoteAdditionalFeeByVendorCreditNote_cancelButton" button="true">Cancel</sj:a>
</body>
</html>
