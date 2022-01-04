

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

    var
            txtBranchCode = $("#branch\\.code"),
            txtBranchName = $("#branch\\.name"),
            txtBranchAddress = $("#branch\\.address"),
            txtBranchPhone1 = $("#branch\\.phone1"),
            txtBranchPhone2 = $("#branch\\.phone2"),
            txtBranchFax = $("#branch\\.fax"),
            txtBranchCityCode = $("#branch\\.city\\.code"),
            txtBranchCityName = $("#branch\\.city\\.name"),
            txtBranchContactPerson = $("#branch\\.contactPerson"),
            txtBranchEmail = $("#branch\\.emailAddress"),
            
            txtBranchBillToCode = $("#branch\\.billTo\\.code"),
            txtBranchBillToName = $("#branch\\.billTo\\.name"),
            
            txtBranchShipToCode = $("#branch\\.shipTo\\.code"),
            txtBranchShipToName = $("#branch\\.shipTo\\.name"),
            
            txtBranchRemark = $("#branch\\.remark"),
            rdbBranchActiveStatus = $("#branch\\.activeStatus"),
            txtBranchInActiveBy = $("#branch\\.inActiveBy"),
            txtBranchInActiveDate = $("#branch\\.inActiveDate"),
            txtBranchCreatedBy = $("#branch\\.createdBy"),
            txtBranchCreatedDate = $("#branch\\.createdDate"),
            allFieldsBranch = $([])
            .add(txtBranchCode)
            .add(txtBranchName)
            .add(txtBranchAddress)
            .add(txtBranchPhone1)
            .add(txtBranchPhone2)
            .add(txtBranchFax)
            .add(txtBranchCityCode)
            .add(txtBranchCityName)
            .add(txtBranchContactPerson)
            .add(txtBranchEmail)
            .add(txtBranchRemark)
            .add(rdbBranchActiveStatus)
            .add(txtBranchInActiveBy)
            .add(txtBranchInActiveDate)
            .add(txtBranchCreatedBy)
            .add(txtBranchCreatedDate);

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("branch");
        $('#branch\\.code').keyup(function () {
            this.value = this.value.toUpperCase();
        });

        $('#branchSearchActiveStatusRadActive').prop('checked', true);
        $("#branchSearchActiveStatus").val("true");

        $('input[name="branchSearchActiveStatusRad"][value="All"]').change(function (ev) {
            var value = "";
            $("#branchSearchActiveStatus").val(value);
        });

        $('input[name="branchSearchActiveStatusRad"][value="Active"]').change(function (ev) {
            var value = "true";
            $("#branchSearchActiveStatus").val(value);
        });

        $('input[name="branchSearchActiveStatusRad"][value="InActive"]').change(function (ev) {
            var value = "false";
            $("#branchSearchActiveStatus").val(value);
        });


        $('input[name="branch\\.activeStatus"][value="Active"]').change(function (ev) {
            var value = "true";
            $("#branch\\.activeStatus").val(value);

        });

        $('input[name="branch\\.activeStatus"][value="InActive"]').change(function (ev) {
            var value = "false";
            $("#branch\\.activeStatus").val(value);
        });

        $("#btnBranchNew").click(function (ev) {
            var url = "master/branch-authority";
            var params = "actionAuthority=INSERT";
            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_branch();
                showInput("branch");
                hideInput("branchSearch");
                $("#branch\\.inActiveDate").val("01/01/1900");
                $('#branch\\.activeStatusActive').prop('checked', true);
                $("#branch\\.activeStatus").val("true");
                updateRowId = -1;
                txtBranchCode.attr("readonly", false);
            });
            ev.preventDefault();
        });
        
        $("#btnBranchPrint").click(function (ev) {
            var status = $('#branchSearchActiveStatus').val();
            var url = "master/branch-print-out-pdf?";
            var params = "activeStatus=" + status;

            window.open(url + params, 'branch', 'width=500,height=500');
        });
        
        $("#btnBranchSave").click(function (ev) {

            if (!$("#frmBranchInput").valid()) {
                handlers_input_branch();
                ev.preventDefault();
                return;
            }
            ;

            var url = "";

            if (updateRowId < 0) {
                url = "master/branch-save";
            } else {
                url = "master/branch-update";
            }

            var params = $("#frmBranchInput").serialize();

            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                if (data.errorMessage) {
                    alertMessage(data.errorMessage);
                    return;
                }

                alertMessage(data.message);

                hideInput("branch");
                showInput("branchSearch");
                allFieldsBranch.val('').removeClass('ui-state-error');
                reloadGridBranch();
            });

            ev.preventDefault();
        });

        $("#btnBranchUpdate").click(function (ev) {
            var url = "master/branch-authority";
            var params = "actionAuthority=UPDATE";
            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_branch();
                updateRowId = $("#branch_grid").jqGrid("getGridParam", "selrow");

                if (updateRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var branch = $("#branch_grid").jqGrid('getRowData', updateRowId);
                var url = "master/branch-get-data";
                var params = "branch.code=" + branch.code;

                txtBranchCode.attr("readonly", true);

                $.post(url, params, function (result) {
                    var data = (result);
                    txtBranchCode.val(data.branchTemp.code);
                    txtBranchName.val(data.branchTemp.name);
                    txtBranchAddress.val(data.branchTemp.address);
                    txtBranchPhone1.val(data.branchTemp.phone1);
                    txtBranchPhone2.val(data.branchTemp.phone2);
                    txtBranchFax.val(data.branchTemp.fax);
                    txtBranchCityCode.val(data.branchTemp.cityCode);
                    txtBranchCityName.val(data.branchTemp.cityName);
                    txtBranchContactPerson.val(data.branchTemp.contactPerson);
                    txtBranchEmail.val(data.branchTemp.emailAddress);
                    txtBranchRemark.val(data.branchTemp.remark);
                    rdbBranchActiveStatus.val(data.branchTemp.activeStatus);
                    txtBranchInActiveBy.val(data.branchTemp.inActiveBy);
                    txtBranchInActiveDate.val(data.branchTemp.inActiveDate);
                    txtBranchCreatedBy.val(data.branchTemp.createdBy);
                    txtBranchCreatedDate.val(data.branchTemp.createdDate);

                    txtBranchBillToCode.val(data.branchTemp.billToCode);
                    txtBranchBillToName.val(data.branchTemp.billToName);
                    $("#branch\\.billTo\\.address").val(data.branchTemp.billToAddress);
                    $("#branch\\.billTo\\.contactPerson").val(data.branchTemp.billToContactPerson);
                    $("#branch\\.billTo\\.phone1").val(data.branchTemp.billToPhone1);

                    txtBranchShipToCode.val(data.branchTemp.shipToCode);
                    txtBranchShipToName.val(data.branchTemp.shipToName);
                    $("#branch\\.shipTo\\.address").val(data.branchTemp.shipToAddress);
                    $("#branch\\.shipTo\\.contactPerson").val(data.branchTemp.shipToContactPerson);
                    $("#branch\\.shipTo\\.phone1").val(data.branchTemp.shipToPhone1);
                    
                    if (data.branchTemp.activeStatus === true) {
                        $('#branch\\.activeStatusActive').prop('checked', true);
                        $("#branch\\.activeStatus").val("true");
                    } else {
                        $('#branch\\.activeStatusInActive').prop('checked', true);
                        $("#branch\\.activeStatus").val("false");
                    }

                    showInput("branch");
                    hideInput("branchSearch");
                });
            });
            ev.preventDefault();
        });


        $('#btnBranchDelete').click(function (ev) {
            var url = "master/branch-authority";
            var params = "actionAuthority=DELETE";
            $.post(url, params, function (data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }

                var deleteRowId = $("#branch_grid").jqGrid('getGridParam', 'selrow');

                if (deleteRowId === null) {
                    alertMessage("Please Select Row!");
                    return;
                }
                var branch = $("#branch_grid").jqGrid('getRowData', deleteRowId);

//                if (confirm("Are You Sure To Delete (Code : " + branch.code + ")")) {
                var url = "master/branch-delete";
                var params = "branch.code=" + branch.code;
                var message = "Are You Sure To Delete(Code : " + branch.code + ")?";
                alertMessageDelete("branch", url, params, message, 400);
//                    $.post(url, params, function(data) {
//                        if (data.error) {
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//                        alertMessage(data.message);
                reloadGridBranch();
//                    });
//                }
            });
            ev.preventDefault();
        });


        $("#btnBranchCancel").click(function (ev) {
            hideInput("branch");
            showInput("branchSearch");
            allFieldsBranch.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });

        $('#btnBranchRefresh').click(function (ev) {
            $('#branchSearchActiveStatusRadActive').prop('checked', true);
            $("#branchSearchActiveStatus").val("true");
            $("#branch_grid").jqGrid("clearGridData");
            $("#branch_grid").jqGrid("setGridParam", {url: "master/branch-data?"});
            $("#branch_grid").trigger("reloadGrid");
            ev.preventDefault();
        });

        $('#btnBranch_search').click(function (ev) {
            $("#branch_grid").jqGrid("clearGridData");
            $("#branch_grid").jqGrid("setGridParam", {url: "master/branch-data?" + $("#frmBranchSearchInput").serialize()});
            $("#branch_grid").trigger("reloadGrid");
            ev.preventDefault();
        });

        $('#branch_btnCity').click(function (ev) {
            window.open("./pages/search/search-city.jsp?iddoc=branch&idsubdoc=city", "Search", "width=600, height=500");
        });

    });

    function reloadGridBranch() {
        $("#branch_grid").trigger("reloadGrid");
    }
    ;

    function unHandlers_input_branch() {
        unHandlersInput(txtBranchCode);
        unHandlersInput(txtBranchName);
        unHandlersInput(txtBranchAddress);
        unHandlersInput(txtBranchPhone1);
        unHandlersInput(txtBranchCityCode);
        unHandlersInput(txtBranchContactPerson);
        unHandlersInput(txtBranchEmail);
        unHandlersInput(txtBranchRemark);
        unHandlersInput(txtBranchBillToCode);
        unHandlersInput(txtBranchShipToCode);
    }

    function handlers_input_branch() {
        if (txtBranchCode.val() === "") {
            handlersInput(txtBranchCode);
        } else {
            unHandlersInput(txtBranchCode);
        }

        if (txtBranchName.val() === "") {
            handlersInput(txtBranchName);
        } else {
            unHandlersInput(txtBranchName);
        }

        if (txtBranchAddress.val() === "") {
            handlersInput(txtBranchAddress);
        } else {
            unHandlersInput(txtBranchAddress);
        }

        if (txtBranchPhone1.val() === "") {
            handlersInput(txtBranchPhone1);
        } else {
            unHandlersInput(txtBranchPhone1);
        }

        if (txtBranchCityCode.val() === "") {
            handlersInput(txtBranchCityCode);
        } else {
            unHandlersInput(txtBranchCityCode);
        }

        if (txtBranchContactPerson.val() === "") {
            handlersInput(txtBranchContactPerson);
        } else {
            unHandlersInput(txtBranchContactPerson);
        }

        if (txtBranchEmail.val() === "") {
            handlersInput(txtBranchEmail);
        } else {
            unHandlersInput(txtBranchEmail);
        }
        if (txtBranchRemark.val() === "") {
            handlersInput(txtBranchRemark);
        } else {
            unHandlersInput(txtBranchRemark);
        }
        if (txtBranchBillToCode.val() === "") {
            handlersInput(txtBranchBillToCode);
        } else {
            unHandlersInput(txtBranchBillToCode);
        }
        if (txtBranchShipToCode.val() === "") {
            handlersInput(txtBranchShipToCode);
        } else {
            unHandlersInput(txtBranchShipToCode);
        }
    }

</script>

<s:url id="remoteurlBranch" action="branch-data" />
<b>BRANCH</b>
<hr>
<br class="spacer" />
<sj:div id="branchButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnBranchNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnBranchUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnBranchDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td><a href="#" id="btnBranchRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnBranchPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print Out</a>
            </td>
        </tr>
    </table>
</sj:div>
<div id="branchSearchInput" class="content ui-widget">
    <br class="spacer" />
    <br class="spacer" />
    <s:form id="frmBranchSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="centre"><b>Code</b></td>
                <td>
                    <s:textfield id="branchSearchCode" name="branchSearchCode" size="20"></s:textfield>
                    </td>
                    <td align="right" valign="centre"><b>Name</b></td>
                    <td>
                    <s:textfield id="branchSearchName" name="branchSearchName" size="50"></s:textfield>
                    </td>
                    <td width="2%"/>
                    <td align="right">Status
                    <s:textfield id="branchSearchActiveStatus" name="branchSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>
                    <td>
                    <s:radio id="branchSearchActiveStatusRad" name="branchSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                    </td>
                </tr>  
            </table>
            <br />
        <sj:a href="#" id="btnBranch_search" button="true">Search</sj:a>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
    </s:form>
</div>
<br class="spacer" />  

<div id="branchGrid">
    <sjg:grid
        id="branch_grid"
        dataType="json"
        href="%{remoteurlBranch}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listBranchTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnubranch').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="80" sortable="true"
            />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="address" index="address" title="Address" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="cityCode" index="cityCode" title="City" width="50" sortable="true"
            />
        <sjg:gridColumn
            name="phone1" index="phone1" title="Phone 1" width="150" sortable="true"
            />   
        <sjg:gridColumn
            name="phone2" index="phone2" title="Phone 2" width="150" sortable="true"
            />
        <sjg:gridColumn
            name="fax" index="fax" title="Fax" width="200" sortable="true"
            />
        <sjg:gridColumn
            name="emailAddress" index="emailAddress" title="Email Address" width="200" sortable="true"
            />
        <sjg:gridColumn
            name="contactPerson" index="contactPerson" title="Contact Person" width="150" sortable="true"
            />
        <sjg:gridColumn
            name="remark" index="remark" title="Remark" width="150" sortable="true"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />    
    </sjg:grid >
</div>

<div id="branchInput" class="content ui-widget">
    <s:form id="frmBranchInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="branch.code" name="branch.code" title=" " required="true" cssClass="required" maxLength="45"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="branch.name" name="branch.name" size="50" title=" " required="true" cssClass="required" maxLength="95"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right" valign="top"><B>Address *</B></td>
                    <td><s:textarea id="branch.address" name="branch.address" rows="3" cols="81" title=" " required="true" cssClass="required" ></s:textarea> </td>
                </tr>
                <tr>
                    <td align="right"><B>City *</B></td>
                    <td>
                        <script type = "text/javascript">
                            txtBranchCityCode.change(function (ev) {

                                if (txtBranchCityCode.val() === "") {
                                    txtBranchCityName.val("");
                                    return;
                                }

                                var url = "master/city-get";
                                var params = "city.code=" + txtBranchCityCode.val();
                                params += "&city.activeStatus=TRUE";

                                $.post(url, params, function (result) {
                                    var data = (result);
                                    if (data.cityTemp) {
                                        txtBranchCityCode.val(data.cityTemp.code);
                                        txtBranchCityName.val(data.cityTemp.name);
                                    } else {
                                        alertMessage("City Not Found!", txtBranchCityCode);
                                        txtBranchCityCode.val("");
                                        txtBranchCityName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="branch.city.code" name="branch.city.code" title=" " required="true" cssClass="required" size="25"></s:textfield>
                        <sj:a id="branch_btnCity" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                    <s:textfield id="branch.city.name" name="branch.city.name" size="50" readonly="true"></s:textfield> 
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Phone 1 *</B></td>
                    <td><s:textfield id="branch.phone1" name="branch.phone1" size="25" title=" " required="true" cssClass="required"></s:textfield>
                        Phone 2
                    <s:textfield id="branch.phone2" name="branch.phone2" size="25"></s:textfield>
                        Fax
                    <s:textfield id="branch.fax" name="branch.fax" size="25"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Email</td>
                    <td><s:textfield id="branch.emailAddress" name="branch.emailAddress" size="50" required="true" cssClass="required" title=" "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Contact Person *</B></td>
                    <td><s:textfield id="branch.contactPerson" name="branch.contactPerson" title=" " required="true" cssClass="required" size="50"></s:textfield></td>
                </tr>

                <!--Bill To-->
                <tr>
                    <td align = "right"><B>Bill To *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            $('#branch_btnBillTo').click(function (ev) {
                                window.open("./pages/search/search-purchase-destination.jsp?iddoc=branch&idsubdoc=billTo&billTo=TRUE", "Search", "Scrollbars=1,width=600, height=500");
                            });

                            txtBranchBillToCode.change(function (ev) {

                                if (txtBranchBillToCode.val() === "") {
                                    txtBranchBillToName.val("");
                                    return;
                                }
                                var url = "master/purchase-destination-get-bill-and-ship";
                                var params = "code=" + txtBranchBillToCode.val();
                                params += "&activeStatus=TRUE";
                                params += "&statusBillShip=BillTo";

                                $.post(url, params, function (result) {
                                    var data = (result);
                                    if (data.purchaseDestinationTemp) {
                                        txtBranchBillToCode.val(data.purchaseDestinationTemp.code);
                                        txtBranchBillToName.val(data.purchaseDestinationTemp.name);
                                        $("#branch\\.billTo\\.address").val(data.purchaseDestinationTemp.address);
                                        $("#branch\\.billTo\\.contactPerson").val(data.purchaseDestinationTemp.contactPerson);
                                        $("#branch\\.billTo\\.phone1").val(data.purchaseDestinationTemp.phone1);
                                    } else {
                                        alertMessage("Bill To Not Found!", txtBranchBillToCode);
                                        txtBranchBillToCode.val("");
                                        txtBranchBillToName.val("");
                                        $("#branch\\.billTo\\.address").val("");
                                        $("#branch\\.billTo\\.contactPerson").val("");
                                        $("#branch\\.billTo\\.phone1").val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="branch.billTo.code" name="branch.billTo.code" cssClass="required" required="true" title=" " size= "20"></s:textfield>
                        <sj:a id="branch_btnBillTo" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                        <s:textfield id="branch.billTo.name" name="branch.billTo.name" readonly="true" size= "23"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Address</td>
                    <td>
                    <s:textarea id="branch.billTo.address" name="branch.billTo.address" cols="47" rows="3" readonly="true"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right">Contact Person</td>
                    <td><s:textfield id="branch.billTo.contactPerson" name="branch.billTo.contactPerson" readonly="true" size= "49"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Phone 1</td>
                    <td><s:textfield id="branch.billTo.phone1" name="branch.billTo.phone1" readonly="true" size= "49"></s:textfield></td>
                </tr>
                <!--END Bill To-->

                <!--Ship To-->
                <tr>
                    <td align = "right"><B>Ship To *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">

                            $('#branch_btnShipTo').click(function (ev) {
                                window.open("./pages/search/search-purchase-destination.jsp?iddoc=branch&idsubdoc=shipTo&shipTo=TRUE", "Search", "Scrollbars=1,width=600, height=500");
                            });

                            txtBranchShipToCode.change(function (ev) {

                                if (txtBranchShipToCode.val() === "") {
                                    txtBranchShipToName.val("");
                                    return;
                                }
                                var url = "master/purchase-destination-get-bill-and-ship";
                                var params = "code=" + txtBranchShipToCode.val();
                                params += "&activeStatus=TRUE";
                                params += "&statusBillShip=ShipTo";

                                $.post(url, params, function (result) {
                                    var data = (result);
                                    if (data.purchaseDestinationTemp) {
                                        txtBranchShipToCode.val(data.purchaseDestinationTemp.code);
                                        txtBranchShipToName.val(data.purchaseDestinationTemp.name);
                                        $("#branch\\.shipTo\\.address").val(data.purchaseDestinationTemp.address);
                                        $("#branch\\.shipTo\\.contactPerson").val(data.purchaseDestinationTemp.contactPerson);
                                        $("#branch\\.shipTo\\.phone1").val(data.purchaseDestinationTemp.phone1);
                                    } else {
                                        alertMessage("Ship To Not Found!", txtBranchShipToCode);
                                        txtBranchShipToCode.val("");
                                        txtBranchShipToName.val("");
                                        $("#branch\\.shipTo\\.address").val("");
                                        $("#branch\\.shipTo\\.contactPerson").val("");
                                        $("#branch\\.shipTo\\.phone1").val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                        <s:textfield id="branch.shipTo.code" name="branch.shipTo.code" cssClass="required" required="true" title=" " size= "20"></s:textfield>
                        <sj:a id="branch_btnShipTo" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a></div>
                        <s:textfield id="branch.shipTo.name" name="branch.shipTo.name" readonly="true" size= "23"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right">Address</td>
                    <td>
                    <s:textarea id="branch.shipTo.address" name="branch.shipTo.address" cols="47" rows="3" readonly="true"></s:textarea>
                    </td>
                </tr>
                <tr>
                    <td align="right">Contact Person</td>
                    <td><s:textfield id="branch.shipTo.contactPerson" name="branch.shipTo.contactPerson" readonly="true" size= "49"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Phone 1</td>
                    <td><s:textfield id="branch.shipTo.phone1" name="branch.shipTo.phone1" readonly="true" size= "49"></s:textfield></td>
                </tr>
                <!--END Ship To-->

                <tr>
                    <td align="right"><B>Remark</B></td>
                    <td><s:textfield id="branch.remark" name="branch.remark" title=" " required="true" cssClass="required" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">InActive By</td>
                    <td><s:textfield id="branch.inActiveBy"  name="branch.inActiveBy" size="20" readonly="true"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">InActive Date</td>
                    <td>
                    <sj:datepicker id="branch.inActiveDate" name="branch.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true" changeYear="true" changeMonth="true" disabled="true"></sj:datepicker>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Active Status *</B>
                    <s:textfield id="branch.activeStatus" name="branch.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="branch.activeStatus" name="branch.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
                </tr>
                <tr>
                    <td><s:textfield id="branch.createdBy"  name="branch.createdBy" size="20" style="display:none"></s:textfield></td>
                <td><s:textfield id="branch.createdDate" name="branch.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
                <tr height="50">
                    <td></td>
                    <td>
                    <sj:a href="#" id="btnBranchSave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnBranchCancel" button="true">Cancel</sj:a>
                    </td>
                </tr>
            </table>
    </s:form>
</div>