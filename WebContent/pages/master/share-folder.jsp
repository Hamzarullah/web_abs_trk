
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
            txtShareFolderCode = $("#shareFolder\\.code"),
            txtShareFolderName = $("#shareFolder\\.name"),
            txtShareFolderFolderName = $("#shareFolder\\.folderName"),
            txtShareFolderServerCode = $("#shareFolder\\.server\\.code"),
            txtShareFolderServerName = $("#shareFolder\\.server\\.name"),
            rdbShareFolderActiveStatus = $("#shareFolder\\.activeStatus"),
            txtShareFolderRemark = $("#shareFolder\\.remark"),
            txtShareFolderInActiveBy = $("#shareFolder\\.inActiveBy"),
            dtpShareFolderInActiveDate = $("#shareFolder\\.inActiveDate"),
            txtShareFolderCreatedBy = $("#shareFolder\\.createdBy"),
            dtpShareFolderCreatedDate = $("#shareFolder\\.createdDate"),
            allFieldsShareFolder = $([])
            .add(txtShareFolderCode)
            .add(txtShareFolderName)
            .add(txtShareFolderFolderName)
            .add(txtShareFolderServerCode)
            .add(txtShareFolderServerName)
            .add(txtShareFolderRemark)
            .add(txtShareFolderInActiveBy)
            .add(txtShareFolderCreatedBy);


    function reloadGridShareFolder() {
        $("#shareFolder_grid").trigger("reloadGrid");
    }
    ;


    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("shareFolder");

        $('#shareFolder\\.code').keyup(function () {
            this.value = this.value.toUpperCase();
        });

        $('#shareFolderSearchActiveStatusRadActive').prop('checked', true);
        $("#shareFolderSearchActiveStatus").val("true");

        $('input[name="shareFolderSearchActiveStatusRad"][value="All"]').change(function (ev) {
            var value = "";
            $("#shareFolderSearchActiveStatus").val(value);
        });

        $('input[name="shareFolderSearchActiveStatusRad"][value="Active"]').change(function (ev) {
            var value = "true";
            $("#shareFolderSearchActiveStatus").val(value);
        });

        $('input[name="shareFolderSearchActiveStatusRad"][value="InActive"]').change(function (ev) {
            var value = "false";
            $("#shareFolderSearchActiveStatus").val(value);
        });

        $('input[name="shareFolderActiveStatusRad"][value="Active"]').change(function (ev) {
            var value = "true";
            $("#shareFolder\\.activeStatus").val(value);
            $("#shareFolder\\.inActiveDate").val("01/01/1900 00:00:00");
        });

        $('input[name="shareFolderActiveStatusRad"][value="InActive"]').change(function (ev) {
            var value = "false";
            $("#shareFolder\\.activeStatus").val(value);
        });

        $("#btnShareFolderNew").click(function (ev) {
            var urlPeriodClosing = "finance/period-closing-confirmation";
            var paramsPeriodClosing = "";

            $.post(urlPeriodClosing, paramsPeriodClosing, function (result) {
                var data = (result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url = "master/share-folder-authority";
                var params = "actionAuthority=INSERT";
                $.post(url, params, function (data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
//                unHandlers_input_shareFolder();
                    showInput("shareFolder");
                    hideInput("shareFolderSearch");
                    $('#shareFolderActiveStatusRadActive').prop('checked', true);
                    $("#shareFolder\\.activeStatus").val("true");
                    $("#shareFolder\\.inActiveDate").val("01/01/1900 00:00:00");
                    $("#shareFolder\\.createdDate").val("01/01/1900 00:00:00");
                    txtShareFolderCode.attr("autocomplete", "off");
                    updateRowId = -1;
                    txtShareFolderCode.attr("readonly", false);

                });
            });
//            ev.preventDefault();
        });


        $("#btnShareFolderSave").click(function (ev) {
            if (!$("#frmShareFolderInput").valid()) {
//               handlers_input_shareFolder();
                ev.preventDefault();
                return;
            }
            ;



            var url = "";
            shareFolderFormatDate();
            if (updateRowId < 0) {
                url = "master/share-folder-save";
            } else {
                url = "master/share-folder-update";
            }

            var params = $("#frmShareFolderInput").serialize();

            $.post(url, params, function (data) {
                if (data.error) {
                    shareFolderFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }

                if (data.errorMessage) {
                    alertMessage(data.errorMessage);
                    return;
                }

                alertMessage(data.message);

                hideInput("shareFolder");
                showInput("shareFolderSearch");
                allFieldsShareFolder.val('').siblings('label[class="error"]').hide();
                reloadGridShareFolder();
            });

            ev.preventDefault();
        });


        $("#btnShareFolderUpdate").click(function (ev) {
            var urlPeriodClosing = "finance/period-closing-confirmation";
            var paramsPeriodClosing = "";

            $.post(urlPeriodClosing, paramsPeriodClosing, function (result) {
                var data = (result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url = "master/share-folder-authority";
                var params = "actionAuthority=UPDATE";
                $.post(url, params, function (data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
//                unHandlers_input_shareFolder();
                    updateRowId = $("#shareFolder_grid").jqGrid("getGridParam", "selrow");

                    if (updateRowId === null) {
                        alertMessage("Please Select Row!");
                        return;
                    }

                    var shareFolder = $("#shareFolder_grid").jqGrid('getRowData', updateRowId);
                    var url = "master/share-folder-get-data";
                    var params = "shareFolder.code=" + shareFolder.code;

                    txtShareFolderCode.attr("readonly", true);

                    $.post(url, params, function (result) {
                        var data = (result);
                        txtShareFolderCode.val(data.shareFolderTemp.code);
                        txtShareFolderName.val(data.shareFolderTemp.name);
                        txtShareFolderFolderName.val(data.shareFolderTemp.folderName);
                        txtShareFolderServerCode.val(data.shareFolderTemp.serverCode);
                        txtShareFolderServerName.val(data.shareFolderTemp.serverName);
                        rdbShareFolderActiveStatus.val(data.shareFolderTemp.activeStatus);
                        txtShareFolderRemark.val(data.shareFolderTemp.remark);
                        txtShareFolderInActiveBy.val(data.shareFolderTemp.inActiveBy);
                        var inActiveDate = formatDateRemoveT(data.shareFolderTemp.inActiveDate, true);
                        dtpShareFolderInActiveDate.val(inActiveDate);
                        txtShareFolderCreatedBy.val(data.shareFolderTemp.createdBy);
                        var createdDate = formatDateRemoveT(data.shareFolderTemp.createdDate, true);
                        dtpShareFolderCreatedDate.val(createdDate);

                        if (data.shareFolderTemp.activeStatus === true) {
                            $('#shareFolderActiveStatusRadActive').prop('checked', true);
                            $("#shareFolder\\.activeStatus").val("true");
                        } else {
                            $('#shareFolderActiveStatusRadInActive').prop('checked', true);
                            $("#shareFolder\\.activeStatus").val("false");
                        }

                        showInput("shareFolder");
                        hideInput("shareFolderSearch");
                    });
                });
            });
//            ev.preventDefault();
        });


        $("#btnShareFolderDelete").click(function (ev) {
            var urlPeriodClosing = "finance/period-closing-confirmation";
            var paramsPeriodClosing = "";

            $.post(urlPeriodClosing, paramsPeriodClosing, function (result) {
                var data = (result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url = "master/share-folder-authority";
                var params = "actionAuthority=DELETE";
                $.post(url, params, function (data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }

                    var deleteRowID = $("#shareFolder_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowID === null) {
                        alertMessage("Please Select Row!");
                        return;
                    }
                    var shareFolder = $("#shareFolder_grid").jqGrid('getRowData', deleteRowID);
                    var url = "master/share-folder-delete";
                    var params = "shareFolder.code=" + shareFolder.code;
                    var message = "Are You Sure To Delete(Code : " + shareFolder.code + ")?";
                    alertMessageDelete("shareFolder", url, params, message, 400);

//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ shareFolder.code+ ')?</div>');
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
//                                var url="master/share-folder-delete";
//                                var params="shareFolder.code=" + shareFolder.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridShareFolder();
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



//                if(confirm("Are You Sure To Delete(Code : " + shareFolder.code+ ")")){
//                    var url="master/share-folder-delete";
//                    var params="shareFolder.code=" + shareFolder.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridShareFolder();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });


        $("#btnShareFolderCancel").click(function (ev) {
            hideInput("shareFolder");
            showInput("shareFolderSearch");
            allFieldsShareFolder.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });


        $('#btnShareFolderRefresh').click(function (ev) {
            $('#shareFolderSearchActiveStatusRadActive').prop('checked', true);
            $("#shareFolderSearchActiveStatus").val("true");
            $("#shareFolder_grid").jqGrid("clearGridData");
            $("#shareFolder_grid").jqGrid("setGridParam", {url: "master/share-folder-data?"});
            $("#shareFolder_grid").trigger("reloadGrid");
            ev.preventDefault();
        });

        $("#btnShareFolderPrint").click(function (ev) {

            var url = "reports/share-folder-print-out-pdf?";
            var params = "";

            window.open(url + params, 'shareFolder', 'width=500,height=500');
        });

        $('#btnShareFolder_search').click(function (ev) {
            $("#shareFolder_grid").jqGrid("clearGridData");
            $("#shareFolder_grid").jqGrid("setGridParam", {url: "master/share-folder-data?" + $("#frmShareFolderSearchInput").serialize()});
            $("#shareFolder_grid").trigger("reloadGrid");
            ev.preventDefault();
        });

        $('#shareFolder_btnServer').click(function (ev) {
            window.open("./pages/search/search-server.jsp?iddoc=shareFolder&idsubdoc=server", "Search", "width=600, height=500");
        });


    });

//    function unHandlers_input_shareFolder(){
//        unHandlersInput(txtShareFolderCode);
//        unHandlersInput(txtShareFolderName);
//    }
//
//    function handlers_input_shareFolder(){
//        if(txtShareFolderCode.val()===""){
//            handlersInput(txtShareFolderCode);
//        }else{
//            unHandlersInput(txtShareFolderCode);
//        }
//        if(txtShareFolderName.val()===""){
//            handlersInput(txtShareFolderName);
//        }else{
//            unHandlersInput(txtShareFolderName);
//        }
//    }

    function shareFolderFormatDate() {
        var inActiveDate = formatDate(dtpShareFolderInActiveDate.val(), true);
        dtpShareFolderInActiveDate.val(inActiveDate);
        $("#shareFolderTemp\\.inActiveDateTemp").val(inActiveDate);

        var createdDate = formatDate(dtpShareFolderCreatedDate.val(), true);
        dtpShareFolderCreatedDate.val(createdDate);
        $("#shareFolderTemp\\.createdDateTemp").val(createdDate);
    }

</script>

<s:url id="remoteurlShareFolder" action="share-folder-data" />
<b>ShareFolder</b>
<hr>
<br class="spacer"/>


<sj:div id="shareFolderButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnShareFolderNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnShareFolderUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnShareFolderDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnShareFolderRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnShareFolderPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>

    </table>
</sj:div>      

<div id="shareFolderSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmShareFolderSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="shareFolderSearchCode" name="shareFolderSearchCode" size="20"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right" valign="center">Name</td>
                    <td>
                    <s:textfield id="shareFolderSearchName" name="shareFolderSearchName" size="40"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right">Status
                    <s:textfield id="shareFolderSearchActiveStatus" name="shareFolderSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>
                    <td>
                    <s:radio id="shareFolderSearchActiveStatusRad" name="shareFolderSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                    </td>
                </tr>
            </table>
            <br/>
        <sj:a href="#" id="btnShareFolder_search" button="true">Search</sj:a>
            <br/>
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
            </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="shareFolderGrid">
    <sjg:grid
        id="shareFolder_grid"
        dataType="json"
        href="%{remoteurlShareFolder}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listShareFolderTemp"
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
            name="folderName" index="folderName" title="Folder Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="serverCode" index="serverCode" title="Server Code" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="serverName" index="serverName" title="Server Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="400" sortable="true"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
            />
    </sjg:grid>
</div>

<div id="shareFolderInput" class="content ui-widget">
    <s:form id="frmShareFolderInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="shareFolder.code" name="shareFolder.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><b>Name *</b></td>
                    <td><s:textfield id="shareFolder.name" name="shareFolder.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><b>Folder Name *</b></td>
                    <td><s:textfield id="shareFolder.folderName" name="shareFolder.folderName" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Server *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            txtShareFolderServerCode.change(function (ev) {

                                if (txtShareFolderServerCode.val() === "") {
                                    txtShareFolderServerName.val("");
                                    return;
                                }



                                var url = "master/server-get";
                                var params = "server.code=" + txtShareFolderServerCode.val();
                                params += "&server.activeStatus=TRUE";

                                $.post(url, params, function (result) {
                                    var data = (result);
                                    if (data.serverTemp) {
                                        txtShareFolderServerCode.val(data.serverTemp.code);
                                        txtShareFolderServerName.val(data.serverTemp.name);
                                    } else {
                                        alertMessage("Server Not Found!", txtShareFolderServerCode);
                                        txtShareFolderServerCode.val("");
                                        txtShareFolderServerName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header" hidden="true">
                        <s:textfield id="shareFolder.server.code" name="shareFolder.server.code" size="15" title=" " required="true" cssClass="required"></s:textfield>
                        <sj:a id="shareFolder_btnServer" href="#" openDialog="">&nbsp;&nbsp;<span id="ui-icon-search-server-sales-order" class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="shareFolder.server.name" name="shareFolder.server.name" size="20" readonly="true"></s:textfield>
                </tr>
                <tr>
                    <td align="right"><B>Active Status *</B></td>
                    <td colspan="2">
                    <s:radio id="shareFolderActiveStatusRad" name="shareFolderActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="shareFolder.activeStatus" name="shareFolder.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>                    
                </tr>
                <tr>
                    <td align="right" valign="top">Remark</td>
                    <td colspan="3">
                    <s:textarea id="shareFolder.remark" name="shareFolder.remark"  cols="47" rows="2" height="20"></s:textarea>
                    </td>
                </tr> 
                <tr>
                    <td align="right">InActive By</td>
                    <td><s:textfield id="shareFolder.inActiveBy"  name="shareFolder.inActiveBy" size="20" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">InActive Date</td>
                    <td>
                    <sj:datepicker id="shareFolder.inActiveDate" name="shareFolder.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                    </td>
                </tr>
                <tr hidden="true">
                    <td/>
                    <td colspan="2">
                    <s:textfield id="shareFolder.createdBy"  name="shareFolder.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="shareFolder.createdDate" name="shareFolder.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                    </td>
                </tr>
                <tr hidden="true">
                    <td/>
                    <td colspan="2">
                    <s:textfield id="shareFolderTemp.inActiveDateTemp" name="shareFolderTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="shareFolderTemp.createdDateTemp" name="shareFolderTemp.createdDateTemp" size="22"></s:textfield>
                    </td>
                </tr>
                <tr height="50">
                    <td></td>
                    <td>
                    <sj:a href="#" id="btnShareFolderSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnShareFolderCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
    </s:form>
</div>