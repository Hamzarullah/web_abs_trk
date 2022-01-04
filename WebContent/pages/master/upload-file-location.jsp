
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<style>
    .ui-dialog-titlebar-close{
        display: none;
    }
</style>

<script type="text/javascript">
     
    var 
        txtUploadFileLocationCode=$("#uploadFileLocation\\.code"),
        txtUploadFileLocationName=$("#uploadFileLocation\\.name"),
        txtUploadFileLocationShareFolderCode=$("#uploadFileLocation\\.shareFolder\\.code"),
        txtUploadFileLocationShareFolderName=$("#uploadFileLocation\\.shareFolder\\.name"),
        rdbUploadFileLocationActiveStatus=$("#uploadFileLocation\\.activeStatus"),
        txtUploadFileLocationRemark=$("#uploadFileLocation\\.remark"),
        txtUploadFileLocationInActiveBy = $("#uploadFileLocation\\.inActiveBy"),
        dtpUploadFileLocationInActiveDate = $("#uploadFileLocation\\.inActiveDate"),
        txtUploadFileLocationCreatedBy = $("#uploadFileLocation\\.createdBy"),
        dtpUploadFileLocationCreatedDate = $("#uploadFileLocation\\.createdDate"),
        
        allFieldsUploadFileLocation=$([])
            .add(txtUploadFileLocationCode)
            .add(txtUploadFileLocationName)
            .add(txtUploadFileLocationShareFolderCode)
            .add(txtUploadFileLocationShareFolderName)
            .add(txtUploadFileLocationRemark)
            .add(txtUploadFileLocationInActiveBy)
            .add(txtUploadFileLocationCreatedBy);


    function reloadGridUploadFileLocation(){
        $("#uploadFileLocation_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("uploadFileLocation");
        
        $('#uploadFileLocation\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#uploadFileLocationSearchActiveStatusRadActive').prop('checked',true);
        $("#uploadFileLocationSearchActiveStatus").val("true");
        
        $('input[name="uploadFileLocationSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#uploadFileLocationSearchActiveStatus").val(value);
        });
        
        $('input[name="uploadFileLocationSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#uploadFileLocationSearchActiveStatus").val(value);
        });
                
        $('input[name="uploadFileLocationSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#uploadFileLocationSearchActiveStatus").val(value);
        });
        
        $('input[name="uploadFileLocationActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#uploadFileLocation\\.activeStatus").val(value);
            $("#uploadFileLocation\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="uploadFileLocationActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#uploadFileLocation\\.activeStatus").val(value);
        });
        
        $("#btnUploadFileLocationNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/upload-file-location-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_uploadFileLocation();
                showInput("uploadFileLocation");
                hideInput("uploadFileLocationSearch");
                $('#uploadFileLocationActiveStatusRadActive').prop('checked',true);
                $("#uploadFileLocation\\.activeStatus").val("true");
                $("#uploadFileLocation\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#uploadFileLocation\\.createdDate").val("01/01/1900 00:00:00");
                txtUploadFileLocationCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtUploadFileLocationCode.attr("readonly",false);

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnUploadFileLocationSave").click(function(ev) {
           if(!$("#frmUploadFileLocationInput").valid()) {
//               handlers_input_uploadFileLocation();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           uploadFileLocationFormatDate();
           if (updateRowId < 0){
               url = "master/upload-file-location-save";
           } else{
               url = "master/upload-file-location-update";
           }
           
           var params = $("#frmUploadFileLocationInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    uploadFileLocationFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("uploadFileLocation");
                showInput("uploadFileLocationSearch");
                allFieldsUploadFileLocation.val('').siblings('label[class="error"]').hide();
                reloadGridUploadFileLocation();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnUploadFileLocationUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/upload-file-location-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_uploadFileLocation();
                updateRowId=$("#uploadFileLocation_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var uploadFileLocation=$("#uploadFileLocation_grid").jqGrid('getRowData',updateRowId);
                var url="master/upload-file-location-get-data";
                var params="uploadFileLocation.code=" + uploadFileLocation.code;

                txtUploadFileLocationCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtUploadFileLocationCode.val(data.uploadFileLocationTemp.code);
                        txtUploadFileLocationName.val(data.uploadFileLocationTemp.name);
                        txtUploadFileLocationShareFolderCode.val(data.uploadFileLocationTemp.shareFolderCode);
                        txtUploadFileLocationShareFolderName.val(data.uploadFileLocationTemp.shareFolderName);
                        rdbUploadFileLocationActiveStatus.val(data.uploadFileLocationTemp.activeStatus);
                        txtUploadFileLocationRemark.val(data.uploadFileLocationTemp.remark);
                        txtUploadFileLocationInActiveBy.val(data.uploadFileLocationTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.uploadFileLocationTemp.inActiveDate,true);
                        dtpUploadFileLocationInActiveDate.val(inActiveDate);
                        txtUploadFileLocationCreatedBy.val(data.uploadFileLocationTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.uploadFileLocationTemp.createdDate,true);
                        dtpUploadFileLocationCreatedDate.val(createdDate);

                        if(data.uploadFileLocationTemp.activeStatus===true) {
                           $('#uploadFileLocationActiveStatusRadActive').prop('checked',true);
                           $("#uploadFileLocation\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#uploadFileLocationActiveStatusRadInActive').prop('checked',true);              
                           $("#uploadFileLocation\\.activeStatus").val("false");
                        }

                        showInput("uploadFileLocation");
                        hideInput("uploadFileLocationSearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnUploadFileLocationDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/upload-file-location-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#uploadFileLocation_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var uploadFileLocation=$("#uploadFileLocation_grid").jqGrid('getRowData',deleteRowID);
                var url="master/upload-file-location-delete";
                var params="uploadFileLocation.code=" + uploadFileLocation.code;
                var message="Are You Sure To Delete(Code : "+ uploadFileLocation.code + ")?";
                alertMessageDelete("uploadFileLocation",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ uploadFileLocation.code+ ')?</div>');
//
//                dynamicDialog.dialog({
//                    title : "Confirmation:",
//                    closeOnEscape: false,
//                    modal : true,
//                    width: 500,
//                    resizable: false,
//                    buttons : 
//                        [{
//                            text : "Yes",
//                            click : function() {
//
//                                $(this).dialog("close");
//                                var url="master/upload-file-location-delete";
//                                var params="uploadFileLocation.code=" + uploadFileLocation.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridUploadFileLocation();
//                                });
//                            }
//                        },
//                        {
//                            text : "No",
//                            click : function() {
//
//                                $(this).dialog("close");
//                            }
//                        }]
//                });
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + uploadFileLocation.code+ ")")){
//                    var url="master/upload-file-location-delete";
//                    var params="uploadFileLocation.code=" + uploadFileLocation.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridUploadFileLocation();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnUploadFileLocationCancel").click(function(ev) {
            hideInput("uploadFileLocation");
            showInput("uploadFileLocationSearch");
            allFieldsUploadFileLocation.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnUploadFileLocationRefresh').click(function(ev) {
            $('#uploadFileLocationSearchActiveStatusRadActive').prop('checked',true);
            $("#uploadFileLocationSearchActiveStatus").val("true");
            $("#uploadFileLocation_grid").jqGrid("clearGridData");
            $("#uploadFileLocation_grid").jqGrid("setGridParam",{url:"master/upload-file-location-data?"});
            $("#uploadFileLocation_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnUploadFileLocationPrint").click(function(ev) {
            
            var url = "reports/upload-file-location-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'uploadFileLocation','width=500,height=500');
        });
        
        $('#btnUploadFileLocation_search').click(function(ev) {
            $("#uploadFileLocation_grid").jqGrid("clearGridData");
            $("#uploadFileLocation_grid").jqGrid("setGridParam",{url:"master/upload-file-location-data?" + $("#frmUploadFileLocationSearchInput").serialize()});
            $("#uploadFileLocation_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#uploadFileLocation_btnShareFolder').click(function (ev) {
            window.open("./pages/search/search-share-folder.jsp?iddoc=uploadFileLocation&idsubdoc=shareFolder", "Search", "width=600, height=500");
        });
        
    });
    
//    function unHandlers_input_uploadFileLocation(){
//        unHandlersInput(txtUploadFileLocationCode);
//        unHandlersInput(txtUploadFileLocationName);
//    }
//
//    function handlers_input_uploadFileLocation(){
//        if(txtUploadFileLocationCode.val()===""){
//            handlersInput(txtUploadFileLocationCode);
//        }else{
//            unHandlersInput(txtUploadFileLocationCode);
//        }
//        if(txtUploadFileLocationName.val()===""){
//            handlersInput(txtUploadFileLocationName);
//        }else{
//            unHandlersInput(txtUploadFileLocationName);
//        }
//    }
    
    function uploadFileLocationFormatDate(){
        var inActiveDate=formatDate(dtpUploadFileLocationInActiveDate.val(),true);
        dtpUploadFileLocationInActiveDate.val(inActiveDate);
        $("#uploadFileLocationTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpUploadFileLocationCreatedDate.val(),true);
        dtpUploadFileLocationCreatedDate.val(createdDate);
        $("#uploadFileLocationTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlUploadFileLocation" action="upload-file-location-data" />
<b>UploadFileLocation</b>
<hr>
<br class="spacer"/>


<sj:div id="uploadFileLocationButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnUploadFileLocationNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnUploadFileLocationUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnUploadFileLocationDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnUploadFileLocationRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnUploadFileLocationPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="uploadFileLocationSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmUploadFileLocationSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="uploadFileLocationSearchCode" name="uploadFileLocationSearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="uploadFileLocationSearchName" name="uploadFileLocationSearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="uploadFileLocationSearchActiveStatus" name="uploadFileLocationSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="uploadFileLocationSearchActiveStatusRad" name="uploadFileLocationSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnUploadFileLocation_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="uploadFileLocationGrid">
    <sjg:grid
        id="uploadFileLocation_grid"
        dataType="json"
        href="%{remoteurlUploadFileLocation}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listUploadFileLocationTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
    >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="shareFolderCode" index="shareFolderCode" title="Share Folder Code" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="shareFolderName" index="shareFolderName" title="Share Folder Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="uploadFileLocationInput" class="content ui-widget">
    <s:form id="frmUploadFileLocationInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="uploadFileLocation.code" name="uploadFileLocation.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="uploadFileLocation.name" name="uploadFileLocation.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Share Folder *</B></td>
                <td colspan="2">
                    <script type = "text/javascript">
                        txtUploadFileLocationShareFolderCode.change(function (ev) {

                            if (txtUploadFileLocationShareFolderCode.val() === "") {
                                txtUploadFileLocationShareFolderName.val("");
                                return;
                            }

                            var url = "master/share-folder-get";
                            var params = "shareFolder.code=" + txtUploadFileLocationShareFolderCode.val();
                            params += "&shareFolder.activeStatus=TRUE";

                            $.post(url, params, function (result) {
                                var data = (result);
                                if (data.shareFolderTemp) {
                                    txtUploadFileLocationShareFolderCode.val(data.shareFolderTemp.code);
                                    txtUploadFileLocationShareFolderName.val(data.shareFolderTemp.name);
                                } else {
                                    alertMessage("ShareFolder Not Found!", txtUploadFileLocationShareFolderCode);
                                    txtUploadFileLocationShareFolderCode.val("");
                                    txtUploadFileLocationShareFolderName.val("");
                                }
                            });
                        });
                    </script>
                    <div class="searchbox ui-widget-header" hidden="true">
                    <s:textfield id="uploadFileLocation.shareFolder.code" name="uploadFileLocation.shareFolder.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                    <sj:a id="uploadFileLocation_btnShareFolder" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-share-folder-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                <s:textfield id="uploadFileLocation.shareFolder.name" name="uploadFileLocation.shareFolder.name" size="20" readonly="true"></s:textfield>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="uploadFileLocationActiveStatusRad" name="uploadFileLocationActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="uploadFileLocation.activeStatus" name="uploadFileLocation.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="uploadFileLocation.remark" name="uploadFileLocation.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="uploadFileLocation.inActiveBy"  name="uploadFileLocation.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="uploadFileLocation.inActiveDate" name="uploadFileLocation.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="uploadFileLocation.createdBy"  name="uploadFileLocation.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="uploadFileLocation.createdDate" name="uploadFileLocation.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="uploadFileLocationTemp.inActiveDateTemp" name="uploadFileLocationTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="uploadFileLocationTemp.createdDateTemp" name="uploadFileLocationTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnUploadFileLocationSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnUploadFileLocationCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>