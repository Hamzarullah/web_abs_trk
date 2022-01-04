
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
       
    var search_purchase_request_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_first_date = '<%= request.getParameter("firstDate") %>';
    var id_last_date = '<%= request.getParameter("lastDate") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        
        $("#dlgPurchaseRequest_okButton").click(function(ev) { 
            var selectedRowId = $("#dlgSearch_purchase_request_grid").jqGrid("getGridParam","selrow");
            
            if(selectedRowId === null){
                alertMsg("Please Select Row PRQ!");
                return;
            }
            
            purchaseRequestItemMaterialRequestDetailLastRowId=rowLast;

            var data_search_purchase_request = $("#dlgSearch_purchase_request_grid").jqGrid('getRowData', selectedRowId);

            if (search_purchase_request_type === "grid" ) {
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                    var ids = jQuery("#dlgSearch_purchase_request_grid").jqGrid('getDataIDs');
                    for(var i=0;i<ids.length;i++){
                            var exist = false;
                            var data = $("#dlgSearch_purchase_request_grid").jqGrid('getRowData',ids[i]);
                            if($("input:checkbox[id='jqg_dlgSearch_purchase_request_grid_"+ids[i]+"']").is(":checked")){
                                for(var j=0; j<idsOpener.length; j++){
                                    var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                                    if(id_document === 'rackItem'){
                                        if(data.code === dataExist.rackItemItemMaterialCode){
                                            exist = true;
                                        }
                                    }
                                }if(exist){
                                    alert('Has been existing in Grid');
                                    return;
                                }else{
                                    if(id_document === 'purchaseOrderPurchaseRequestDetail'){
                                        var defRow = {
                                            purchaseOrderPurchaseRequestDetailDelete                    : "delete",
                                            purchaseOrderPurchaseRequestDetailCode                      : data.code,
                                            purchaseOrderPurchaseRequestDetailTransactionDate           : data.transactionDate,
                                            purchaseOrderPurchaseRequestDetailDocumentType              : data.documentType,
                                            purchaseOrderPurchaseRequestDetailProductionPlanningCode    : data.ppoCode,
                                            purchaseOrderPurchaseRequestDetailBranchCode                : data.branchCode,
                                            purchaseOrderPurchaseRequestDetailBranchName                : data.branchName,
                                            purchaseOrderPurchaseRequestDetailRequestBy                 : data.requestBy,
                                            purchaseOrderPurchaseRequestDetailRefNo                     : data.refNo,
                                            purchaseOrderPurchaseRequestDetailRemark                    : data.remark
                                        };

                                        purchaseRequestItemMaterialRequestDetailLastRowId++;
                                        window.opener.addRowDataMultiSelectedPoJnPr(purchaseRequestItemMaterialRequestDetailLastRowId,defRow);
                                    }

                                }
                            }
                        }
            }
            window.close();
        });

        $("#dlgPurchaseRequest_cancelButton").click(function(ev) { 
            data_search_purchase_request = null;
            window.close();
        });
    
        $("#btn_dlg_PurchaseRequestSearch").click(function(ev) {
            formatDate();
            $("#dlgSearch_purchase_request_grid").jqGrid("setGridParam",{url:"purchasing/purchase-request-search-data?" + $("#frmPurchaseRequestSearch").serialize(), page:1});
            $("#dlgSearch_purchase_request_grid").trigger("reloadGrid");
            formatDate();
        });
        
        
        var firstDate=id_first_date.split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        var lastDate=id_last_date.split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        
        $("#purchaseRequestSearchFirstDate").val(firstDateFormat);
        $("#purchaseRequestSearchLastDate").val(lastDateFormat);
        
    });
    
    function alertMsg(txt_message){
        var dynamicDialog= $(
        '<div id="conformBoxError">'+
            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
            '</span>' +
        '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            resizable: false,
            closeText: "hide",
            buttons : 
            [{
                text : "OK",
                click : function() {
                    $(this).dialog("close");
                }
            }]
        });
    }
    
    function formatDate(){
        var firstDate=$("#purchaseRequestSearchFirstDate").val().split("/");
        var firstDateFormat=firstDate[1]+"/"+firstDate[0]+"/"+firstDate[2];
        $("#purchaseRequestSearchFirstDate").val(firstDateFormat);

        var lastDate=$("#purchaseRequestSearchLastDate").val().split("/");
        var lastDateFormat=lastDate[1]+"/"+lastDate[0]+"/"+lastDate[2];
        $("#purchaseRequestSearchLastDate").val(lastDateFormat);
    }
        
</script>
<body>


    <div class="ui-widget">
        <s:form id="frmPurchaseRequestSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Period *<B/></td>
                <td>
                    <sj:datepicker id="purchaseRequestSearchFirstDate" name="purchaseRequestSearchFirstDate" size="15" displayFormat="dd/mm/yy"  showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                    To
                    <sj:datepicker id="purchaseRequestSearchLastDate" name="purchaseRequestSearchLastDate" size="15" displayFormat="dd/mm/yy" showOn="focus" changeMonth="true" changeYear="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Code</td>
                <td>
                    <s:textfield id="purchaseRequestSearchCode" name="purchaseRequestSearchCode" placeHolder=" PRQ No" label="PRQ No" size="25"></s:textfield>
                </td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_PurchaseRequestSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_purchase_request_grid"
            dataType="json"
            href="%{remoteurlPurchaseRequestSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listPurchaseRequest"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            multiselect="true"
            width="$('#tabmnupurchaserequest').width()"
        >
            <sjg:gridColumn
                name="code" index="code" key="code" title="Code" width="130" sortable="true"
            />
            <sjg:gridColumn
                name="transactionDate" index="transactionDate" key="transactionDate" title="Transaction Date" width="130" 
                formatter="date"  formatoptions="{newformat : 'd/m/Y H:i:s', srcformat : 'Y/m/d H:i:s'}"  sortable="true" 
            />
            <sjg:gridColumn
                name="requestBy" index="requestBy" key="requestBy" title="RequestBy" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="documentType" index="documentType" key="documentType" title="Doc Type" width="40" sortable="true"
            />
            <sjg:gridColumn
                name="ppoCode" index="ppoCode" key="ppoCode" title="PPO No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="branchCode" index="branchCode" key="branchCode" title="Branch Code" width="100" sortable="true" hidden="false"
            />
            <sjg:gridColumn
                name="branchName" index="branchName" key="branchName" title="Branch Name" width="100" sortable="true" hidden="true"
            />
            <sjg:gridColumn
                name="refNo" index="refNo" key="refNo" title="Ref No" width="100" sortable="true"
            />
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="200" sortable="true"
            />
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="dlgPurchaseRequest_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgPurchaseRequest_cancelButton" button="true">Cancel</sj:a>
</body>
</html>