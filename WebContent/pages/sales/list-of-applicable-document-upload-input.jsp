
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #listOfApplicableDocumentUploadDetailInput_grid_pager_center,.ui-dialog-titlebar-close{
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
    
    var listOfApplicableDocumentUploadDetaillastRowId=0,listOfApplicableDocumentUploadDetail_lastSel = -1;

    $(document).ready(function() {
        
        flagIsConfirmedLAD=false;
                
        $("#listOfApplicableDocumentUploadDetailAddRow").keypress(function(e){
           if(e.which!==8 && e.which!==46 && e.which !==0 && (e.which<48 || e.which>57)){
               $("#errmsgAddRow").html("Digits Only").show().fadeOut("slow");
               return false;
           }
        });

        $("#listOfApplicableDocumentUploadDetailAddRow").keyup(function(e){
           $(this).val(function(index, value) {
                value = value.replace(/,/g,'');
                return numberWithCommas(value);
            });
           
        });
        
        $("#btnUnConfirmListOfApplicableDocumentUpload").css("display", "none");
        $('#listOfApplicableDocumentUploadDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnConfirmListOfApplicableDocumentUpload").click(function(ev) {
            if(!$("#frmListOfApplicableDocumentUploadInput").valid()) {
                alertMessage("Field(s) Can't Empty!");
                return;
            }
            
            if($("#listOfApplicableDocumentUploadUpdateMode").val()==="true"){
                listOfApplicableDocumentUploadLoadDataDetail();
            }
            
            flagIsConfirmedLAD=true;
            $("#btnUnConfirmListOfApplicableDocumentUpload").css("display", "block");
            $("#btnConfirmListOfApplicableDocumentUpload").css("display", "none");   
            $('#headerListOfApplicableDocumentUploadInput').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            $('#listOfApplicableDocumentUploadDetailInputGrid').unblock();
        });
        
        $("#btnUnConfirmListOfApplicableDocumentUpload").click(function(ev) {
                var dynamicDialog= $('<div id="conformBox">'+
                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                    '</span>Are You Sure to UnConfirm this Detail?</div>');
                
                var rows = jQuery("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('getGridParam', 'records');
                if(rows<1){
                    $("#btnUnConfirmListOfApplicableDocumentUpload").css("display", "none");
                    $("#btnConfirmListOfApplicableDocumentUpload").css("display", "block");
                    $('#headerListOfApplicableDocumentUploadInput').unblock();
                    $('#listOfApplicableDocumentUploadDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
                                        $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('clearGridData');
                                        $("#btnUnConfirmListOfApplicableDocumentUpload").css("display", "none");
                                        $("#btnConfirmListOfApplicableDocumentUpload").css("display", "block");
                                        $('#headerListOfApplicableDocumentUploadInput').unblock();
                                        $('#listOfApplicableDocumentUploadDetailInputGrid').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
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
        
        $.subscribe("listOfApplicableDocumentUploadDetailInput_grid_onSelect", function() {
            
            var selectedRowID = $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid("getGridParam", "selrow");

            if(selectedRowID!==listOfApplicableDocumentUploadDetail_lastSel) {

                $('#listOfApplicableDocumentUploadDetailInput_grid').jqGrid("saveRow",listOfApplicableDocumentUploadDetail_lastSel); 
                $('#listOfApplicableDocumentUploadDetailInput_grid').jqGrid("editRow",selectedRowID,true);            

                listOfApplicableDocumentUploadDetail_lastSel=selectedRowID;

            }
            else{
                $('#listOfApplicableDocumentUploadDetailInput_grid').jqGrid("saveRow",selectedRowID);
            }
        });
        
        $('#btnListOfApplicableDocumentUploadSave').click(function(ev) {
            
            if(!flagIsConfirmedLAD){
                alertMessage("Please Confirm!",$("#btnConfirmListOfApplicableDocumentUpload"));
                return;
            }
            
            if(listOfApplicableDocumentUploadDetail_lastSel !== -1) {
                $('#listOfApplicableDocumentUploadDetailInput_grid').jqGrid("saveRow",listOfApplicableDocumentUploadDetail_lastSel); 
            }

           
            var listListOfApplicableDocumentUploadDetail = new Array(); 
            var ids = jQuery("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('getDataIDs'); 

            if(ids.length===0){
                alertMessage("Grid Detail Can't Empty!");
                return;
            }

            for(var i=0;i < ids.length;i++){ 
                var data = $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('getRowData',ids[i]); 
                    alert(data.listOfApplicableDocumentUploadDetailUpload);
                    return;
                var listOfApplicableDocumentUploadDetail = { 
                    nameOfDocument  : data.listOfApplicableDocumentUploadDetailNameOfDocument,
                    documentNo      : data.listOfApplicableDocumentUploadDetailDocumentNo,
                    versionEdition  : data.listOfApplicableDocumentUploadDetailVersionEdition
                };
                listListOfApplicableDocumentUploadDetail[i] = listOfApplicableDocumentUploadDetail;
            }
            
//            var counter = 0;
//            window.getData=function(prm){
//                for (var i = 1; i <= 100; i++) {
//                    runAjax(i);
//                    $('.quoteList').append('<li>'+i+'.) '+prm+' : <label id=quoteList_'+(i)+'>Progress List</label></li>');
//                }
//            }
//            window.runAjax=function(idx){
//                $.ajax({
//                    url:'list-of-applicable-document-save',
//                    async: true,
//                    dataType: 'jsonp',
//                    type: 'POST',
//                    data : listOfApplicableDocumentUploadDetail,
//                    success:function(data){
//                        setTimeout(() => { $('#quoteList_'+idx).text(data.quote); }, 1000);
//                    }
//                });
//            }
                        
            formatDateLAD();
                        
            var url = "sales/list-of-applicable-document-save";
            var params = $("#frmListOfApplicableDocumentUploadInput").serialize();
                params += "&listListOfApplicableDocumentUploadDetailJSON=" + $.toJSON(listListOfApplicableDocumentUploadDetail);

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
                                        var url = "sales/list-of-applicable-document-upload-input";
                                        pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT_UPLOAD");
                                    }
                                },
                                {
                                    text : "No",
                                    click : function() {
                                        $(this).dialog("close");
                                        params = "";
                                        var url = "sales/list-of-applicable-document-upload";
                                        pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT_UPLOAD");
                                    }
                                }]
                    });
            });
            
        });
  
        $('#btnListOfApplicableDocumentUploadCancel').click(function(ev) {
            var url = "sales/list-of-applicable-document-upload";
            var params = "";
            pageLoad(url, params, "#tabmnuLIST_OF_APPLICABLE_DOCUMENT_UPLOAD"); 
        });
    }); //EOF Ready

    
    function formatDateLAD(){
        var createdDate=$("#listOfApplicableDocumentUpload\\.createdDate").val();
        $("#listOfApplicableDocumentUpload\\.createdDateTemp").val(createdDate);
    }
    
    function numberWithCommas(x) {
        var parts = x.toString().split(".");
        
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        return parts.join(".");
    }
    
    function listOfApplicableDocumentUploadDetailInputGrid_Delete_OnClick(){
        var selectDetailRowId = $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('getGridParam','selrow');
        
        if (selectDetailRowId === null) {
            alert("Please Select Row");
            return;
        }
        
        $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('delRowData',selectDetailRowId);
        
    }
    
    function listOfApplicableDocumentUploadLoadDataDetail() {
        var url = "sales/list-of-applicable-document-detail-data";
        var params = "listOfApplicableDocument.code=" + $("#listOfApplicableDocumentUpload\\.code").val();
            $.getJSON(url, params, function(data) {
                listOfApplicableDocumentUploadDetaillastRowId = 0;
                for (var i=0; i<data.listListOfApplicableDocumentDetail.length; i++) {
                    listOfApplicableDocumentUploadDetaillastRowId++;
                    $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid("addRowData", listOfApplicableDocumentUploadDetaillastRowId, data.listListOfApplicableDocumentDetail[i]);
                    $("#listOfApplicableDocumentUploadDetailInput_grid").jqGrid('setRowData',listOfApplicableDocumentUploadDetaillastRowId,{
                        listOfApplicableDocumentUploadDetailDelete         : "delete",
                        listOfApplicableDocumentUploadDetailNameOfDocument : data.listListOfApplicableDocumentDetail[i].nameOfDocument,
                        listOfApplicableDocumentUploadDetailDocumentNo     : data.listListOfApplicableDocumentDetail[i].documentNo,
                        listOfApplicableDocumentUploadDetailVersionEdition : data.listListOfApplicableDocumentDetail[i].versionEdition
                    });
                }
            });
    }
               
</script>

<s:url id="remoteurlListOfApplicableDocumentUploadDetailInput" action="" />
<b>LIST OF APPLICABLE DOCUMENT UPLOAD</b>
<hr>
<br class="spacer" />

<div id="listOfApplicableDocumentUploadInput" class="content ui-widget">
    <s:form id="frmListOfApplicableDocumentUploadInput">
        <table cellpadding="2" cellspacing="2" id="headerListOfApplicableDocumentUploadInput">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td>
                    <s:textfield id="listOfApplicableDocumentUpload.code" name="listOfApplicableDocumentUpload.code" key="listOfApplicableDocumentUpload.code" readonly="true" size="22"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Transaction Date *</B></td>
                <td>
                    <sj:datepicker id="listOfApplicableDocumentUpload.transactionDate" name="listOfApplicableDocumentUpload.transactionDate" title=" " readonly="true" disabled="true" displayFormat="dd/mm/yy" required="true" cssClass="required" size="15" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right"><B>SO No *</B></td>
                <td colspan="2">
                    <div colspan="3" class="searchbox ui-widget-header">
                    <s:textfield id="listOfApplicableDocumentUpload.salesOrder.code" name="listOfApplicableDocumentUpload.salesOrder.code" title=" " required="true" readonly="true" cssClass="required" size="30"></s:textfield>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">Branch</td>
                <td colspan="2">
                    <s:textfield id="listOfApplicableDocumentUpload.branch.code" name="listOfApplicableDocumentUpload.branch.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="listOfApplicableDocumentUpload.branch.name" name="listOfApplicableDocumentUpload.branch.name" readonly="true" size="40"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">SO Date</td>
                <td>
                <sj:datepicker id="listOfApplicableDocumentUpload.salesOrder.transactionDate" name="listOfApplicableDocumentUpload.salesOrder.transactionDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="22" showOn="focus" readonly="true" disabled="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td align="right">Blanket Order No</td>
                <td><s:textfield id="listOfApplicableDocumentUpload.salesOrder.blanketOrder.code" name="listOfApplicableDocumentUpload.salesOrder.blanketOrder.code" size="25" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Customer Purchase Order No</td>
                <td><s:textfield id="listOfApplicableDocumentUpload.salesOrder.customerPurchaseOrder.code" name="listOfApplicableDocumentUpload.salesOrder.customerPurchaseOrder.code" size="25" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Sales Person</td>
                <td colspan="2">
                    <s:textfield id="listOfApplicableDocumentUpload.salesOrder.salesPerson.code" name="listOfApplicableDocumentUpload.salesOrder.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="listOfApplicableDocumentUpload.salesOrder.salesPerson.name" name="listOfApplicableDocumentUpload.salesOrder.name" readonly="true" size="40"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Customer</td>
                <td colspan="2">
                    <s:textfield id="listOfApplicableDocumentUpload.salesOrder.customer.code" name="listOfApplicableDocumentUpload.salesOrder.customer.code" readonly="true" size="22"></s:textfield>
                    <s:textfield id="listOfApplicableDocumentUpload.salesOrder.customer.name" name="listOfApplicableDocumentUpload.salesOrder.customer.name" readonly="true" size="40"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right">Ref No</td>
                <td colspan="3"><s:textfield id="listOfApplicableDocumentUpload.refNo" name="listOfApplicableDocumentUpload.refNo" readonly="true" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3"><s:textarea id="listOfApplicableDocumentUpload.remark" name="listOfApplicableDocumentUpload.remark" readonly="true" cols="70" rows="2" height="20"></s:textarea></td>
            </tr> 
            <tr>
                <td align="right">Prepared By</td>
                <td colspan="3"><s:textfield id="listOfApplicableDocumentUpload.preparedBy" name="listOfApplicableDocumentUpload.preparedBy" readonly="true" size="27"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Approved By</td>
                <td colspan="3"><s:textfield id="listOfApplicableDocumentUpload.approvedBy" name="listOfApplicableDocumentUpload.approvedBy" readonly="true" size="27"></s:textfield></td>
            </tr>
            <tr hidden="true">
                <td>
                    <sj:datepicker id="listOfApplicableDocumentUploadDateFirstSession" name="listOfApplicableDocumentUploadDateFirstSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <sj:datepicker id="listOfApplicableDocumentUploadDateLastSession" name="listOfApplicableDocumentUploadDateLastSession" size="15" showOn="focus" style="display:none"></sj:datepicker>
                    <s:textfield id="listOfApplicableDocumentUploadUpdateMode" name="listOfApplicableDocumentUploadUpdateMode" key="listOfApplicableDocumentUploadUpdateMode" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <s:textfield id="listOfApplicableDocumentUpload.createdBy" name="listOfApplicableDocumentUpload.createdBy" key="listOfApplicableDocumentUpload.createdBy" readonly="true" size="22" cssStyle="display:none"></s:textfield>
                    <sj:datepicker id="listOfApplicableDocumentUpload.createdDate" name="listOfApplicableDocumentUpload.createdDate"  size="22" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" cssStyle="display:none"></sj:datepicker>
                    <s:textfield id="listOfApplicableDocumentUpload.createdDateTemp" name="listOfApplicableDocumentUpload.createdDateTemp" size="20" cssStyle="display:none"></s:textfield>
                </td>
            </tr>
            
        </table>
        <table>
            <tr>
                <td align="right">
                    <sj:a href="#" id="btnConfirmListOfApplicableDocumentUpload" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnUnConfirmListOfApplicableDocumentUpload" button="true">Unconfirm</sj:a>
                </td>
            </tr>
        </table>
        <br class="spacer" />
        <div id="listOfApplicableDocumentUploadDetailInputGrid">
            <sjg:grid
                id="listOfApplicableDocumentUploadDetailInput_grid"
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
                width="2000"
                editurl="%{remoteurlListOfApplicableDocumentUploadDetailInput}"
                onSelectRowTopics="listOfApplicableDocumentUploadDetailInput_grid_onSelect"
            >
                <sjg:gridColumn
                    name="listOfApplicableDocumentUploadDetail" index="listOfApplicableDocumentUploadDetail" title="" width="200" sortable="true" editable="true" hidden="true"
                /> 
                <sjg:gridColumn
                    name="listOfApplicableDocumentUploadDetailDelete" index="listOfApplicableDocumentUploadDetailDelete" title="" width="50" align="centre" 
                    editable="true"
                    edittype="button"
                    editoptions="{onClick:'listOfApplicableDocumentUploadDetailInputGrid_Delete_OnClick()', value:'delete'}"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentUploadDetailNameOfDocument" index="listOfApplicableDocumentUploadDetailNameOfDocument" key="listOfApplicableDocumentUploadDetailNameOfDocument" 
                    title="Name Of Document" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentUploadDetailDocumentNo" index="listOfApplicableDocumentUploadDetailDocumentNo" key="listOfApplicableDocumentUploadDetailDocumentNo" 
                    title="DocumentNo" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentUploadDetailVersionEdition" index="listOfApplicableDocumentUploadDetailVersionEdition" key="listOfApplicableDocumentUploadDetailVersionEdition" 
                    title="Version / Edition" width="150" sortable="true" editable="false"
                />
                <sjg:gridColumn
                    name="listOfApplicableDocumentUploadDetailUpload" index="listOfApplicableDocumentUploadDetailUpload" title="" width="250" align="centre" 
                    id="listOfApplicableDocumentUploadDetailUpload" editable="true" edittype="file"
                    editoptions="{enctype:'multipart/form-data'}"
                />
            </sjg:grid >
            
            <script>
//                function UploadImage(respone, postData){
//                    var data = $.parseJSON(respone.responeText);
//                    alert(data.success);
//                    if (data.success === true) {
//                        if ($("#listOfApplicableDocumentUploadDetailUpload").val() !== "") {
//                            ajaxFileUpload(data.id);
//                        }
//                    }  
//
//                    return [data.success, data.message, data.id];
//                }
//                
//                function ajaxFileUpload(id){
//                    $("#loading")
//                    .ajaxStart(function () {
//                        $(this).show();
//                    })
//                    .ajaxComplete(function () {
//                        $(this).hide();
//                    });
//
//                    $.ajaxFileUpload
//                    (
//                        {
//                            url: 'sales/sales-quotation-excel-import',
//                            secureuri: false,
//                            fileElementId: 'listOfApplicableDocumentUploadDetailUpload',
//                            dataType: 'json',
//                            data: { id: id },
//                            success: function (data, status) {
//
//                                if (typeof (data.success) != 'undefined') {
//                                    if (data.success == true) {
//                                        return;
//                                    } else {
//                                        alert(data.message);
//                                    }
//                                }
//                                else {
//                                    return alert('Failed to upload logo!');
//                                }
//                            },
//                            error: function (data, status, e) {
//                                return alert('Failed to upload logo!');
//                            }
//                        }
//                    )          
//                }
            </script>
        </div>
        <table width="100%">
            <tr>
                <td width="20%" valign="top">
                    <table  width="100%">
                        <tr height="10px"/>
                        <tr>
                            <td>
                                <sj:a href="#" id="btnListOfApplicableDocumentUploadSave" button="true" style="width: 60px">Save</sj:a>
                                <sj:a href="#" id="btnListOfApplicableDocumentUploadCancel" button="true" style="width: 60px">Cancel</sj:a>
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
        
    