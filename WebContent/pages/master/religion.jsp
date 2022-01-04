<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>
<script type="text/javascript" src="<s:url value="/js/linq.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/linq.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<s:url id="remoteurlReligion" action="religion-json" />

<script type="text/javascript">
    var
            txtReligionCode = $("#religion\\.code"),
            txtReligionName = $("#religion\\.name"),
            txtReligionRemark = $("#religion\\.remark"),
            txtReligionActiveStatus = $("#religion\\.activeStatus"),
            txtReligionInActiveBy = $("#religion\\.inActiveBy"),
            txtReligionInActiveDate = $("#religion\\.inActiveDate"),
            txtReligionCreatedBy = $("#religion\\.createdBy"),  
            txtReligionCreatedDate = $("#religion\\.createdDate"),
            allFieldsReligion = $([])
            .add(txtReligionCode)
            .add(txtReligionName)
            .add(txtReligionRemark)
            .add(txtReligionInActiveBy)
            .add(txtReligionInActiveDate);

    function reloadGridReligion() {
        //$("#religion_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#religion_grid").trigger("reloadGrid");
    }
    ;

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("religion");
        $('#religion\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        $('#searchReligionActiveStatusRADActive').prop('checked',true);
            $("#searchReligionActiveStatus").val("yes");
        
        $('input[name="searchReligionActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchReligionActiveStatus").val(value);
        });
        
        $('input[name="searchReligionActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchReligionActiveStatus").val(value);
        });
                
        $('input[name="searchReligionActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchReligionActiveStatus").val(value);
        });
        
        $('#religionStatusActive').change(function (ev) {
            var value = "true";
            $("#religion\\.activeStatus").val(value);
        });

        $('#religionStatusInActive').change(function (ev) {
            var value = "false";
            $("#religion\\.activeStatus").val(value);
        });


        $("#btnReligionNew").click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/religion-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("religion");
                    $("#frmReligionSearchInput").hide();
                     txtReligionCode.attr("readonly", false);
                    $('#religionStatusActive').prop('checked', true);
                    var value = "true";
                    $("#religion\\.activeStatus").val(value);
                    $("#religion\\.inActiveDate").val("01/01/1900");
                    updateRowId = -1;
                    ev.preventDefault();
                });
            });
        });

        $("#btnReligionUpdate").click(function (ev) {
            $("#frmReligionSearchInput").hide();
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/religion-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#religion_grid").jqGrid("getGridParam", "selrow");

                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        txtReligionCode.attr("readonly", true);

                        var religion = $("#religion_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/religion-get";
                        var params = "religion.code=" + religion.code;

                        $.post(url, params, function (result) {
                            var data = (result);
                            txtReligionCreatedBy.val(data.religion.createdBy);
                            txtReligionCreatedDate.val(data.religion.createdDate);
                            txtReligionCode.val(data.religion.code);
                            txtReligionName.val(data.religion.name);
                            txtReligionRemark.val(data.religion.remark);
                            txtReligionInActiveBy.val(data.religion.inActiveBy);
                            txtReligionInActiveDate.val(formatDateRemoveT(data.religion.inActiveDate));

                            if (data.religion.activeStatus === true) {
                                $('#religionStatusActive').prop('checked', true);
                                $("#religion\\.activeStatus").val("true");
                            } else {
                                $('#religionStatusInActive').prop('checked', true);
                                $("#religion\\.activeStatus").val("false");
                            }

                            showInput("religion");
                            $("#frmReligionSearchInput").hide();
                        });
                    }
                    ev.preventDefault();
                });
            });
        });

        $('#btnReligionDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var url="master/religion-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#religion_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var religion = $("#religion_grid").jqGrid('getRowData', deleteRowId);

//                        if (confirm("Are You Sure To Delete (Code : " + religion.code + ")")) {
                            var url = "master/religion-delete";
                            var params = "religion.code=" + religion.code;
                            var message="Are You Sure To Delete(Code : "+ religion.code + ")?";
                            alertMessageDelete("religion",url,params,message,400);
//                            $.post(url, params, function () {
                                reloadGridReligion();
//                            });
//                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnReligionSave").click(function (ev) {
            if (!$("#frmReligionInput").valid()) {
                ev.preventDefault();
                return;
            }
            ;

            var url = "";

            var params = $("#frmReligionInput").serialize();

            if (updateRowId < 0) {
                url = "master/religion-save";
            } else {
                url = "master/religion-update";
                //params += "&religion.code="+ txtReligionCode.val();
            }

            //alert("Param : " + params);
            
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("religion");
                showInput("religionSearch");
                allFieldsReligion.val('').siblings('label[class="error"]').hide();
                reloadGridReligion();           
            });

            ev.preventDefault();
        });


        $("#btnReligionCancel").click(function (ev) {
            hideInput("religion");
            $("#frmReligionSearchInput").show();
            allFieldsReligion.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnReligionRefresh').click(function (ev) {
            reloadGridReligion();
        });
        
        $("#btnReligion_search").click(function(ev) {
            $("#religion_grid").jqGrid("setGridParam",{url:"master/religion-search?" + $("#frmReligionSearchInput").serialize(), page:1});
            $("#religion_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
    });
</script>

<b>RELIGION</b>
<hr>
<br class="spacer"/>

<sj:div id="religionButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnReligionNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnReligionUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnReligionDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnReligionRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnReligionPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>  
<br class="spacer" />    
<div id="countrySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmReligionSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="searchReligion.code" name="searchReligion.code" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="searchReligion.name" name="searchReligion.name" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="searchReligionActiveStatus" name="searchReligionActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchReligionActiveStatusRAD" name="searchReligionActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnReligion_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   

<br class="spacer" />

<div id="religionGrid">
    <sjg:grid
        id="religion_grid"
        dataType="json"
        href="%{remoteurlReligion}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listReligion"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuRELIGION').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="false"
        />  
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />   
    </sjg:grid >
</div>

<div id="religionInput" class="content ui-widget">
    <s:form id="frmReligionInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="religion.code" name="religion.code" title="Please Enter Code!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="religion.name" name="religion.name" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>       
                <tr>
                    <td align="right">Remark </td>
                    <td><s:textfield id="religion.remark" name="religion.remark" size="50" title="Please Enter Name!" ></s:textfield></td>
                </tr>       
                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="religionStatus" name="religionStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="religion.activeStatus" name="religion.activeStatus" title="Please Enter Role Name" required="true" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="religion.inActiveBy" name="religion.inActiveBy" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <s:textfield disabled="true" id="religion.inActiveDate" name="religion.inActiveDate" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td><s:textfield id="religion.createdBy"  name="religion.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="religion.createdDate" name="religion.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnReligionSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnReligionCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>