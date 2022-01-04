
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #listOfApplicableDocumentDetailInput_grid_pager_center,.ui-dialog-titlebar-close{
        display: none;
    }
    #errmsgAddRow{
        color: red;
    }
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
    
    var listOfApplicableDocumentDetaillastRowId=0,listOfApplicableDocumentDetail_lastSel = -1;
    var 
        txtListOfApplicableDocumentCode = $("#listOfApplicableDocument\\.code"),
        dtpListOfApplicableDocumentTransactionDate = $("#listOfApplicableDocument\\.transactionDate");


    $(document).ready(function() {
        
        flagIsConfirmedLAD=false;
                
        $("#listOfApplicableDocumentDetailAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#listOfApplicableDocumentDetailAddRow").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
           
        });
        
        if($('#enumListApplicableDocumentActivity').val() === 'UPDATE'){
            $("#listOfApplicableDocument\\.salesOrder\\.code").attr('readonly',true);
            $("#listOfApplicableDocument\\.salesOrder\\.code").focus();
            $("#listOfApplicableDocument_btnCustomerSalesOrder").hide();
        }
        
        $("#btnUnConfirmListOfApplicableDocument").css("display", "none");
        $('#listOfApplicableDocumentDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmListOfApplicableDocument").click(function(ev) {
            handlers_input_list_of_applicable_document();
            if(!$("#frmListOfApplicableDocumentInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
//            var date1 = dtpListOfApplicableDocumentTransactionDate.val().split("/");
//            var month1 = date1[1];
//            var year1 = date1[2].split(" ");
//            var date2 = $("#listOfApplicableDocumentTransactionDate").val().split("/");
//            var month2 = date2[1];
//            var year2 = date2[2].split(" ");
//            
//            
//            if(parseFloat(month1) !== parseFloat($("#panel_periodMonth").val()) || parseFloat(month2) !== parseFloat($("#panel_periodMonth").val())){
//                if($("#listOfApplicableDocumentUpdateMode").val()==="true"){
//                    alertMessage("Transaction Month Must Between Session Period Month!<br/><br/><br/>Current Transaction Date "+$("#listOfApplicableDocumentTransactionDate").val(),dtpListOfApplicableDocumentTransactionDate);
//                }else{
//                    alertMessage("Transaction Month Must Between Session Period Month!",dtpListOfApplicableDocumentTransactionDate);
//                }
//                return;
//            }
//
//            if(parseFloat(year1) !== parseFloat($("#panel_periodYear").val()) || parseFloat(year2) !== parseFloat($("#panel_periodYear").val())){
//                if($("#listOfApplicableDocumentUpdateMode").val()==="true"){
//                    alertMessage("Transaction Year Must Between Session Period Year!<br/><br/><br/>Current Transaction Date "+$("#listOfApplicableDocumentTransactionDate").val(),dtpListOfApplicableDocumentTransactionDate);
//                }else{
//                    alertMessage("Transaction Year Must Between Session Period Year!",dtpListOfApplicableDocumentTransactionDate);
//                }
//                return;
//            }
            
            if($('#enumListApplicableDocumentActivity').val() === 'UPDATE' || $('#enumListApplicableDocumentActivity').val() === 'CLONE'){
                    listOfApplicableDocumentLoadDataDetail();
            }
            
            if($('#enumListApplicableDocumentActivity').val() === 'NEW'){
                formatDateLAD();
                        
                var url = "sales/list-of-applicable-document-save";
                var params = $("#frmListOfApplicableDocumentInput").serialize();
                
                $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateLAD();
                    alertMessage(data.errorMessage);
                    return;
                }
               
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
                dynamicDialog.dialog({
                    title        : "Confirmation:",
                    closeOnEscape: false,
                    modal        : true,
                    width        : 400,
                    resizable    : false,
                    closeText    : "hide",
                    buttons      : 
                        [{
                            text : "Yes",
                            click : function() {
                                $(this).dialog("close");
                                var url = "sales/list-of-applicable-document-input";
                                    params = "enumListApplicableDocumentActivity=UPDATE";
                                    params+= "&listOfApplicableDocument.code=" + data.codeLad;
                                pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");
                            }
                        },
                        {
                            text : "No",
                            click : function() {
                                $(this).dialog("close");
                                params = "";
                                var url = "sales/list-of-applicable-document-input";
                                pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");
                            }
                        }]
                    });
                });
            }
            
            flagIsConfirmedLAD=true;
            $("#btnUnConfirmListOfApplicableDocument").css("display", "block");
            $("#btnConfirmListOfApplicableDocument").css("display", "none");   
            $('#headerListOfApplicableDocumentInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#listOfApplicableDocumentDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmListOfApplicableDocument").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#listOfApplicableDocumentDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    $("#btnUnConfirmListOfApplicableDocument").css("display", "none");
                    $("#btnConfirmListOfApplicableDocument").css("display", "block");
                    $('#headerListOfApplicableDocumentInput').unblock();
                    $('#listOfApplicableDocumentDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                    flagIsConfirmedLAD=false;
                    return;
                }
                
                dynamicDialog.dialog({
                    title        : "Confirmation:",
                    closeOnEscape: false,
                    modal        : true,
                    width        : 400,
                    resizable    : false,
                    buttons      : 
                                [{
                                    text : "Yes",
                                    click : function() {

                                        $(this).dialog("close");
                                        flagIsConfirmedLAD=false;
                                        $("#listOfApplicableDocumentDetailInput_grid").jqGrid('clearGridData');
                                        $("#btnUnConfirmListOfApplicableDocument").css("display", "none");
                                        $("#btnConfirmListOfApplicableDocument").css("display", "block");
                                        $('#headerListOfApplicableDocumentInput').unblock();
                                        $('#listOfApplicableDocumentDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $.subscribe("listOfApplicableDocumentDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#listOfApplicableDocumentDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==listOfApplicableDocumentDetail_lastSel) {

                $('#listOfApplicableDocumentDetailInput_grid').jqGrid("saveRow",listOfApplicableDocumentDetail_lastSel); 
                $('#listOfApplicableDocumentDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                listOfApplicableDocumentDetail_lastSel=selectedRowID;

            }
            else{
                $('#listOfApplicableDocumentDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });


        $('#btnListOfApplicableDocumentAddDetail').click(function(ev) {
            
            if(!flagIsConfirmedLAD){
                alertMessage("Please Confirm!",$("#btnConfirmListOfApplicableDocument"));
                return;
            }
            
            var AddRowCount =parseFloat(removeCommas($("#listOfApplicableDocumentDetailAddRow").val()));

            for(var i=0; i<AddRowCount; i++){
                var defRow = {};
                listOfApplicableDocumentDetaillastRowId++;
                $("#listOfApplicableDocumentDetailInput_grid").jqGrid("addRowData", listOfApplicableDocumentDetaillastRowId, defRow);

                be = "<input style='height:22px;width:20px;' type='button' value='EBUTTTONNS' onclick=\"alert('click ni');\" />";
                $("#listOfApplicableDocumentDetailInput_grid").jqGrid('setRowData',listOfApplicableDocumentDetaillastRowId,{Buttons:be});
                ev.preventDefault();
            } 
        });
        
        $('#btnListOfApplicableDocumentSave').click(function(ev) {
            
//            if(!flagIsConfirmedLAD){
//                alertMessage("Please Confirm!",$("#btnConfirmListOfApplicableDocument"));
//                return;
//            }
            
            if(listOfApplicableDocumentDetail_lastSel !== -1) {
                $('#listOfApplicableDocumentDetailInput_grid').jqGrid("saveRow",listOfApplicableDocumentDetail_lastSel); 
            }

            var listListOfApplicableDocumentDetail = new Array(); 
            var ids = jQuery("#listOfApplicableDocumentDetailInput_grid").jqGrid('getDataIDs'); 

            if(ids.length===0){
                alertMessage("Grid Detail Can't Empty!");
                return;
            }

            for(var i=0;i < ids.length;i++){ 
                var data = $("#listOfApplicableDocumentDetailInput_grid").jqGrid('getRowData',ids[i]); 

                var listOfApplicableDocumentDetail = { 
                    nameOfDocument  : data.listOfApplicableDocumentDetailNameOfDocument,
                    documentNo      : data.listOfApplicableDocumentDetailDocumentNo,
                    versionEdition  : data.listOfApplicableDocumentDetailVersionEdition
                };
                listListOfApplicableDocumentDetail[i] = listOfApplicableDocumentDetail;
            }
                        
            formatDateLAD();
                        
            var url = "sales/list-of-applicable-document-save";
            var params = $("#frmListOfApplicableDocumentInput").serialize();
                params += "&listListOfApplicableDocumentDetailJSON=" + $.toJSON(listListOfApplicableDocumentDetail);

            $.post(url, params, function(data) {
                closeLoading();
                if (data.error) {
                    formatDateLAD();
                    alertMessage(data.errorMessage);
                    return;
                }
               
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>'+data.message+'<br/>Do You Want Input Other Transaction?</div>');
                dynamicDialog.dialog({
                    title        : "Confirmation:",
                    closeOnEscape: false,
                    modal        : true,
                    width        : 400,
                    resizable    : false,
                    closeText    : "hide",
                    buttons      : 
                                [{
                                    text : "Yes",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/list-of-applicable-document-input";
                                        pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/list-of-applicable-document";
                                        pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnListOfApplicableDocumentCancel').click(function(ev) {
            var url = "sales/list-of-applicable-document";
            var params = "";
            pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT"); 
        });
        
        $('#listOfApplicableDocument_btnCustomerSalesOrder').click(function(ev) {
            window.open("./pages/search/search-customer-sales-order.jsp?iddoc=listOfApplicableDocument&firstDate="+$("#listOfApplicableDocumentDateFirstSession").val()+"&lastDate="+$("#listOfApplicableDocumentDateLastSession").val(),"Search", "Scrollbars=1,width=600, height=500");
        });
    }); //EOF Ready

    
    function formatDateLAD(){
        var transactionDateSplit=dtpListOfApplicableDocumentTransactionDate.val().split('/');
        var transactionDate =transactionDateSplit[1]+"/"+transactionDateSplit[0]+"/"+transactionDateSplit[2];
        dtpListOfApplicableDocumentTransactionDate.val(transactionDate);
        
        var createdDate=$("#listOfApplicableDocument\\.createdDate").val();
        $("#listOfApplicableDocument\\.createdDateTemp").val(createdDate);
    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function listOfApplicableDocumentDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#listOfApplicableDocumentDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#listOfApplicableDocumentDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        
    }
    
    function listOfApplicableDocumentLoadDataDetail() {
        var url = "sales/list-of-applicable-document-detail-data";
//        
        if($('#enumListApplicableDocumentActivity').val() === 'UPDATE'){
            var params = "listOfApplicableDocument.code="+$('#listOfApplicableDocument\\.code').val(); 
        }else{
            var params = "listOfApplicableDocument.code="+$("#listOfApplicableDocument\\.codeLAD").val();
        }
            $.getJSON(url, params, function(data) {
                listOfApplicableDocumentDetaillastRowId = 0;
                for (var i=0; i<data.listListOfApplicableDocumentDetail.length; i++) {
                    listOfApplicableDocumentDetaillastRowId++;
                    $("#listOfApplicableDocumentDetailInput_grid").jqGrid("addRowData", listOfApplicableDocumentDetaillastRowId, data.listListOfApplicableDocumentDetail[i]);
                    $("#listOfApplicableDocumentDetailInput_grid").jqGrid('setRowData',listOfApplicableDocumentDetaillastRowId,{
                        listOfApplicableDocumentDetailDelete         : "delete",
                        listOfApplicableDocumentDetailNameOfDocument : data.listListOfApplicableDocumentDetail[i].nameOfDocument,
                        listOfApplicableDocumentDetailDocumentNo     : data.listListOfApplicableDocumentDetail[i].documentNo,
                        listOfApplicableDocumentDetailVersionEdition : data.listListOfApplicableDocumentDetail[i].versionEdition
                    });
                }
            });
    }
        
    function handlers_input_list_of_applicable_document(){
        if(dtpListOfApplicableDocumentTransactionDate.val()===""){
            handlersInput(dtpListOfApplicableDocumentTransactionDate);
        }else{
            unHandlersInput(dtpListOfApplicableDocumentTransactionDate);
        }  
    }
           
</script>

<s:url id="remoteurlListOfApplicableDocumentDetailInput" action="" />
<b>LIST OF APPLICABLE DOCUMENT</b>
<hr>
<br class="spacer" />

<div id="listOfApplicableDocumentInput" class="content ui-widget">
    <s:form id="frmListOfApplicableDocumentInput">
        <table cellpadding="2" cellspacing="2" id="headerListOfApplicableDocumentInput">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td>
                    <s:textfield id="listOfApplicableDocument.code" name="listOfApplicableDocument.code" key="listOfApplicableDocument.code" readonly="true" size="22"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="listOfApplicableDocument.transactionDate" name="listOfApplicableDocument.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>SO No *</B></td>
                <td colspan="2">
                    <div colspan="3" class="searchbox ui-widget-header">
                        <s:textfield id="listOfApplicableDocument.salesOrder.code" name="listOfApplicableDocument.salesOrder.code" title=" " required="true" cssClass="required" size="30"></s:textfield>
                        <sj:a id="listOfApplicableDocument_btnCustomerSalesOrder" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td colspan="2">
                    <s:textfield id="listOfApplicableDocument.salesOrder.branch.code" name="listOfApplicableDocument.salesOrder.branch.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="listOfApplicableDocument.salesOrder.branch.name" name="listOfApplicableDocument.salesOrder.branch.name" readonly="true" size="40"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">SO Date</td>
                <td>
                <sj:datepicker id="listOfApplicableDocument.salesOrder.transactionDate" name="listOfApplicableDocument.salesOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Blanket Order No</td>
                <td><s:textfield id="listOfApplicableDocument.salesOrder.blanketOrder.code" name="listOfApplicableDocument.salesOrder.blanketOrder.code" size="25" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Customer Purchase Order No</td>
                <td><s:textfield id="listOfApplicableDocument.salesOrder.customerPurchaseOrder.code" name="listOfApplicableDocument.salesOrder.customerPurchaseOrder.code" size="25" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Sales Person</td>
                <td colspan="2">
                    <s:textfield id="listOfApplicableDocument.salesOrder.salesPerson.code" name="listOfApplicableDocument.salesOrder.salesPerson.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="listOfApplicableDocument.salesOrder.salesPerson.name" name="listOfApplicableDocument.salesOrder.salesPerson.name" readonly="true" size="40"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td colspan="2">
                    <s:textfield id="listOfApplicableDocument.salesOrder.customer.code" name="listOfApplicableDocument.salesOrder.customer.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="listOfApplicableDocument.salesOrder.customer.name" name="listOfApplicableDocument.salesOrder.customer.name" readonly="true" size="40"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="listOfApplicableDocument.refNo" name="listOfApplicableDocument.refNo" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3"><s:textarea id="listOfApplicableDocument.remark" name="listOfApplicableDocument.remark"  cols="70" rows="2" height="20"></s:textarea></td>
            </tr> 
            <tr>
                <td align="right">Prepared By</td>
                <td colspan="3"><s:textfield id="listOfApplicableDocument.preparedBy" name="listOfApplicableDocument.preparedBy" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Approved By</td>
                <td colspan="3"><s:textfield id="listOfApplicableDocument.approvedBy" name="listOfApplicableDocument.approvedBy" size="27"></s:textfield></td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="listOfApplicableDocumentDateFirstSession" name="listOfApplicableDocumentDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="listOfApplicableDocumentDateLastSession" name="listOfApplicableDocumentDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="enumListApplicableDocumentActivity" name="enumListApplicableDocumentActivity" size="20" cssStyle="display:none"></s:textfield>
                    <s:textfield id="listOfApplicableDocument.codeLAD" name="listOfApplicableDocument.codeLAD" key="listOfApplicableDocument.codeLAD" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <s:textfield id="listOfApplicableDocument.createdBy" name="listOfApplicableDocument.createdBy" key="listOfApplicableDocument.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="listOfApplicableDocument.createdDate" name="listOfApplicableDocument.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="listOfApplicableDocument.createdDateTemp" name="listOfApplicableDocument.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmListOfApplicableDocument" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmListOfApplicableDocument" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="listOfApplicableDocumentDetailInputGrid">
            <sjg:grid
                id="listOfApplicableDocumentDetailInput_grid"
                dataType="local"                    
                pager="true"
                navigator="false"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                gridModel="listListOfApplicableDocumentDetail"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                editinline="true"
                width="800"
                editurl="%{remoteurlListOfApplicableDocumentDetailInput}"
                onSelectRowTopics="listOfApplicableDocumentDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="listOfApplicableDocumentDetail" index="listOfApplicableDocumentDetail" title="" width="200" sortable="true" editable="true" hidden="true"
                /> 
                <sjg:gridColumn
                    name="listOfApplicableDocumentDetailDelete" index="listOfApplicableDocumentDetailDelete" title="" width="50" align="centre"
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'listOfApplicableDocumentDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentDetailNameOfDocument" index="listOfApplicableDocumentDetailNameOfDocument" key="listOfApplicableDocumentDetailNameOfDocument" 
                    title="Name Of Document" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentDetailDocumentNo" index="listOfApplicableDocumentDetailDocumentNo" key="listOfApplicableDocumentDetailDocumentNo" 
                    title="DocumentNo" width="150" sortable="true" editable="true"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentDetailVersionEdition" index="listOfApplicableDocumentDetailVersionEdition" key="listOfApplicableDocumentDetailVersionEdition" 
                    title="Version / Edition" width="150" sortable="true" editable="true"
                />
            </sjg:grid >
        </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                        <tr>
                            <td>
                                <s:textfield id="listOfApplicableDocumentDetailAddRow" name="listOfApplicableDocumentDetailAddRow" cssStyle="text-align:right" size="8" value="1"></s:textfield>
                                <sj:a href="#" id="btnListOfApplicableDocumentAddDetail" button="true"  style="width: 60px">Add</sj:a>&nbsp;<span id="errmsgAddRow"></span>
                            </td>
                        </tr>
                        <tr height="10px"/>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnListOfApplicableDocumentSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnListOfApplicableDocumentCancel" button="true" style="width: 60px">Cancel</sj:a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </s:form>
</div> 
<br class="spacer" />
<br class="spacer" />