
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

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
            overflow: scroll;
        }
    </style>
    
<script type = "text/javascript">

    var search_additionalFee_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';   
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        
        $("#btn_dlg_AdditionalFeeSearch").click(function(ev) {
            $("#dlgSearch_additionalFee_grid").jqGrid("setGridParam",{url:"master/additional-fee-data-purchase?" + $("#frmAdditionalFeeSearch").serialize(), page:1});
            $("#dlgSearch_additionalFee_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#dlgAdditionalFee_okButton").click(function(ev) {
            selectedRowId = $("#dlgSearch_additionalFee_grid").jqGrid("getGridParam","selrow");
        
            if(selectedRowId === null){
                alert("Please Select Row Additional Fee!");
                return;
            }
            
            purchaseOrderDetailAdditionalRowId = rowLast;

            var data_search_additionalFee = $("#dlgSearch_additionalFee_grid").jqGrid('getRowData', selectedRowId);

            var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
            var ids = jQuery("#dlgSearch_additionalFee_grid").jqGrid('getDataIDs');
            for(var i=0;i<ids.length;i++){
                    var exist = false;
                    var data = $("#dlgSearch_additionalFee_grid").jqGrid('getRowData',ids[i]);
                    if($("input:checkbox[id='jqg_dlgSearch_additionalFee_grid_"+ids[i]+"']").is(":checked")){
                        for(var j=0; j<idsOpener.length; j++){
                            var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            if(id_document === 'purchaseOrderAdditionalFee'){
                                if(data.code === dataExist.purchaseOrderAdditionalFeeCode){
                                    exist = true;
                                }
                            }
                        }if(exist){
                            alert('Has been existing in Grid');
                            return;
                        }else{
                            if(id_document === 'purchaseOrderAdditionalFee'){
                                let defRow = {
                                    purchaseOrderAdditionalFeeDelete                        : "delete",
                                    purchaseOrderAdditionalFeeCode                          : data.code,
                                    purchaseOrderAdditionalFeeName                          : data.name,
                                    purchaseOrderAdditionalFeePurchaseChartOfAccountCode    : data.purchaseChartOfAccountCode,
                                    purchaseOrderAdditionalFeePurchaseChartOfAccountName    : data.purchaseChartOfAccountName

                                };
                                
                                purchaseOrderDetailAdditionalRowId++;
                                window.opener.addRowDataMultiSelectedAdditionalFeePurchase(purchaseOrderDetailAdditionalRowId,defRow);
                                
                            }

                        }
                    }
                }
       
            window.close();
        });
        
        $("#dlgAdditionalFee_cancelButton").click(function(ev) {
            data_search_country = null;
            window.close();
        });
        
    });    
    
</script>
<body>
<s:url id="remoteurlAdditionalFeeSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmAdditionalFeeSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="additionalFeeSearchCode" name="additionalFeeSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="additionalFeeSearchName" name="additionalFeeSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_AdditionalFeeSearch" button="true">Search</sj:a></td>
            </tr>
            <td align="right">
                <s:textfield id="additionalFeeSearchActiveStatus" name="additionalFeeSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
            </td>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_additionalFee_grid"
            dataType="json"
            href="%{remoteurlAdditionalFeeSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listAdditionalFeeTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            multiselect = "true"
            width="$('#tabmnuadditionalFee').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="240" sortable="true"
        />
        <sjg:gridColumn
            name="salesChartOfAccountCode" index="salesChartOfAccountCode" title="Sales Acoount Code" width="100"
        />
        <sjg:gridColumn
            name="salesChartOfAccountName" index="salesChartOfAccountName" title="Sales Account Name" width="100"
        />
        <sjg:gridColumn
            name="purchaseChartOfAccountCode" index="purchaseChartOfAccountCode" title="Purchase Acoount Code" width="100"
        />
        <sjg:gridColumn
            name="purchaseChartOfAccountName" index="purchaseChartOfAccountName" title="Purchase Account Name" width="100"
        />
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgAdditionalFee_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgAdditionalFee_cancelButton" button="true">Cancel</sj:a>
</body>
</html>