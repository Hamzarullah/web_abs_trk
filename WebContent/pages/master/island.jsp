<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<s:url id="remoteurlIsland" action="island-json" />

<script type="text/javascript">
    var
            txtIslandCode = $("#island\\.code"),
            txtIslandName = $("#island\\.name"),
            txtIslandCountryCode=$("#island\\.country\\.code"),
            txtIslandCountryName=$("#island\\.country\\.name"),
            txtIslandRemark = $("#island\\.remark"),
            txtIslandActiveStatus = $("#island\\.activeStatus"),
            txtIslandInActiveBy = $("#island\\.inActiveBy"),
            txtIslandInActiveDate = $("#island\\.inActiveDate"),
            txtIslandCreatedBy = $("#island\\.createdBy"),  
            txtIslandCreatedDate = $("#island\\.createdDate"),
            allFieldsIsland = $([])
            .add(txtIslandCode)
            .add(txtIslandName)
            .add(txtIslandCountryCode)
            .add(txtIslandCountryName)
            .add(txtIslandRemark)
            .add(txtIslandInActiveBy)
            .add(txtIslandInActiveDate);

    function reloadGridIsland() {
        //$("#island_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#island_grid").trigger("reloadGrid");
    }
    ;

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("island");
        $('#island\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        $('#searchIslandActiveStatusRADActive').prop('checked',true);
            $("#searchIslandActiveStatus").val("YES");
        
        $('input[name="searchIslandActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchIslandActiveStatus").val(value);
        });
        
        $('input[name="searchIslandActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchIslandActiveStatus").val(value);
        });
                
        $('input[name="searchIslandActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchIslandActiveStatus").val(value);
        });
        
        $('#islandStatusActive').change(function (ev) {
            var value = "true";
            $("#island\\.activeStatus").val(value);
        });

        $('#islandStatusInActive').change(function (ev) {
            var value = "false";
            $("#island\\.activeStatus").val(value);
        });

        $("#btnIslandNew").click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/island-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("island");
                    $("#frmIslandSearchInput").hide();
                     txtIslandCode.attr("readonly", false);
                    $('#islandStatusActive').prop('checked', true);
                    var value = "true";
                    $("#island\\.activeStatus").val(value);
                    $("#island\\.inActiveDate").val("01/01/1900");
                    updateRowId = -1;
                    ev.preventDefault();
                });
            });
        });

        $("#btnIslandUpdate").click(function (ev) {
            $("#frmIslandSearchInput").hide();
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/island-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#island_grid").jqGrid("getGridParam", "selrow");

                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        txtIslandCode.attr("readonly", true);

                        var island = $("#island_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/island-get";
                        var params = "island.code=" + island.code;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtIslandCreatedBy.val(data.island.createdBy);
                            txtIslandCreatedDate.val(data.island.createdDate);
                            txtIslandCode.val(data.island.code);
                            txtIslandName.val(data.island.name);
                            txtIslandCountryCode.val(data.island.country['code']);
                            txtIslandCountryName.val(data.island.country['name']);
                            txtIslandRemark.val(data.island.remark);
                            txtIslandInActiveBy.val(data.island.inActiveBy);
                            txtIslandInActiveDate.val(formatDateRemoveT(data.island.inActiveDate));

                            if (data.island.activeStatus === true) {
                                $('#islandStatusActive').prop('checked', true);
                                $("#island\\.islandStatus").val("true");
                            } else {
                                $('#activeStatusInActive').prop('checked', true);
                                $("#island\\.activeStatus").val("false");
                            }

                            showInput("island");
                            $("#frmIslandSearchInput").hide();
                        });
                    }
                    ev.preventDefault();
                });
            });
        });

        $('#btnIslandDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/island-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#island_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alertMessage("Please Select Row");
                    } else {
                        var island = $("#island_grid").jqGrid('getRowData', deleteRowId);

//                        if (confirm("Are You Sure To Delete (Code : " + island.code + ")")) {
                            var url = "master/island-delete";
                            var params = "island.code=" + island.code;
                            var message="Are You Sure To Delete(Code : "+ island.code + ")?";
                            alertMessageDelete("island",url,params,message,400);
                            
//                            $.post(url, params, function () {
                                reloadGridIsland();
//                            });
//                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnIslandSave").click(function (ev) {
//            formatDate(txtIslandTransactionDate.val(),true);
            if (!$("#frmIslandInput").valid()) {
                formatDate(txtIslandTransactionDate.val(),true);
                ev.preventDefault();
                return;
            };

            var url = "";
            var params = $("#frmIslandInput").serialize();

            if (updateRowId < 0) {
                url = "master/island-save";
            } else {
                url = "master/island-update";
                //params += "&island.code="+ txtIslandCode.val();
            }

           $.post(url, params, function(data) {
                if (data.error) {
                    formatDate(txtIslandTransactionDate.val(),true);
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("island");
                $("#frmIslandSearchInput").show();
                allFieldsIsland.val('').siblings('label[class="error"]').hide();
                reloadGridIsland();
            });
            ev.preventDefault();
        });


        $("#btnIslandCancel").click(function (ev) {
            hideInput("island");
            $("#frmIslandSearchInput").show();
            allFieldsIsland.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnIslandRefresh').click(function (ev) {
            reloadGridIsland();
        });
        
        $("#btnIsland_search").click(function(ev) {
            $("#island_grid").jqGrid("setGridParam",{url:"master/island-search?" + $("#frmIslandSearchInput").serialize(), page:1});
            $("#island_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
    });
</script>

<b>ISLAND</b>
<hr>
<br class="spacer" />

<sj:div id="islandButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnIslandNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnIslandUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnIslandDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnIslandRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnIslandPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>              
<br class="spacer" />    
<div id="countrySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmIslandSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="searchIsland.code" name="searchIsland.code" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="searchIsland.name" name="searchIsland.name" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="searchIslandActiveStatus" name="searchIslandActiveStatus" readonly="Yes" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchIslandActiveStatusRAD" name="searchIslandActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnIsland_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   

<br class="spacer" />

<div id="islandGrid">
    <sjg:grid
        id="island_grid"
        dataType="json"
        href="%{remoteurlIsland}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listIsland"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuISLAND').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="false"
        /> 
        <sjg:gridColumn
            name="country.code" index="country.code" key="country.code" title="Country Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="country.name" index="country.name" key="country.name" title="Country Name" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />   
    </sjg:grid >
</div>

<div id="islandInput" class="content ui-widget">
    <s:form id="frmIslandInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="island.code" name="island.code" title="Please Enter Code!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="island.name" name="island.name" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Country *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            
                            $('#island_btnCountry').click(function(ev) {
                                window.open("./pages/search/search-country.jsp?iddoc=island&idsubdoc=country","Search", "Scrollbars=1,width=600, height=500");
                            });
                            txtIslandCountryCode.change(function(ev) {

                                if(txtIslandCountryCode.val()===""){
                                    txtIslandCountryName.val("");
                                    return;
                                }
                                var url = "master/country-get";
                                var params = "country.code=" + txtIslandCountryCode.val();
                                    params+= "&country.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.countryTemp){
                                        txtIslandCountryCode.val(data.countryTemp.code);
                                        txtIslandCountryName.val(data.countryTemp.name);
                                    }
                                    else{
                                        alertMessage("Country Not Found!",txtIslandCountryCode);
                                        txtIslandCountryCode.val("");
                                        txtIslandCountryName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="island.country.code" name="island.country.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                            <sj:a id="island_btnCountry" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="island.country.name" name="island.country.name" cssStyle="width:30%" readonly="true"></s:textfield>
                    </td>
                </tr>      
                <tr>
                    <td align="right"><B>Remark *</B></td>
                    <td><s:textfield id="island.remark" name="island.remark" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>       
                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="islandStatus" name="islandStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="island.activeStatus" name="island.activeStatus" title="Please Enter Role Name" required="true" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="island.inActiveBy" name="island.inActiveBy" title=" " size="20" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <sj:datepicker disabled="true" disabled="true" id="island.inActiveDate" name="island.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td><s:textfield id="island.createdBy"  name="island.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="island.createdDate" name="island.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnIslandSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnIslandCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>