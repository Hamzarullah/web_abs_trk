<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>

<script type="text/javascript">

//    var     txtPriceTypeCountryCode = $("#priceType\\.country\\.code"),
//            txtPriceTypeCountryName = $("#priceType\\.country\\.name"),
            txtPriceTypeCode = $("#priceType\\.code"),
            txtPriceTypeName = $("#priceType\\.name"),
            txtPriceTypeActiveStatus = $("#priceType\\.activeStatus"),
            chkPriceTypeActiveStatus = $("#priceTypeActiveStatus"),
            lblActivePriceType = $("#lblActivePriceType"),
            txtPriceTypeRemark = $("#priceType\\.remark"),
            txtPriceTypeInActiveBy = $("#priceType\\.inActiveBy"),
            txtPriceTypeInActiveDate = $("#priceType\\.inActiveDate"),
            txtPriceTypeCreatedBy = $("#priceType\\.createdBy"), 
            txtPriceTypeCreatedDate = $("#priceType\\.createdDate"),
            allFieldsPriceType = $([])
//            .add(txtPriceTypeCountryCode)
//            .add(txtPriceTypeCountryName)
            .add(txtPriceTypeCode)
            .add(txtPriceTypeName)
            .add(txtPriceTypeRemark)
            .add(txtPriceTypeInActiveBy)
            .add(txtPriceTypeInActiveDate);

    function reloadGridPriceType() {
        $("#priceType_grid").jqGrid('setGridWidth', $("#tabs").width() - 30, false);
        $("#priceType_grid").jqGrid("setGridParam",{url:"master/price-type-search-data?" + $("#frmPriceTypeSearchInput").serialize()});
        $("#priceType_grid").trigger("reloadGrid");
    }

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("priceType");
        $('#priceType\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        $('input[name="priceTypeSearchActiveStatusRad"][value="Active"]').prop('checked',true);
        $("#priceTypeSearchActiveStatus").val("Active");
        
        $('input[name="priceTypeSearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="All";
            $("#priceTypeSearchActiveStatus").val(value);
        });
        
        $('input[name="priceTypeSearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="Active";
            $("#priceTypeSearchActiveStatus").val(value);
        });
                
        $('input[name="priceTypeSearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="InActive";
            $("#priceTypeSearchActiveStatus").val(value);
        });
        $('#priceTypeActiveStatusActive').change(function(ev){
            var value="true";
            $("#priceType\\.activeStatus").val(value);
        });
                
        $('#priceTypeActiveStatusInActive').change(function(ev){
            var value="false";
            $("#priceType\\.activeStatus").val(value);
        });

        $('#btnPriceTypeNew').click(function (ev) {
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/price-type-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("priceType");
                    hideInput("priceTypeSearch");
                    txtPriceTypeCode.attr("readonly", false);
                    updateRowId = -1;
                    $('#priceTypeActiveStatusActive').prop('checked',true);
                    var value="true";
                    $("#priceType\\.activeStatus").val(value);
                    $("#priceType\\.inActiveDate").val("01/01/1900");
                    //txtPriceTypeCode.attr("readonly", false);
                    ev.preventDefault();
                 });
             });
        });

        $('#btnPriceTypeUpdate').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/price-type-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#priceType_grid").jqGrid('getGridParam', 'selrow');
                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        chkPriceTypeActiveStatus.attr("disabled", false);
                        txtPriceTypeCode.attr("readonly", true);

                        var priceType = $("#priceType_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/price-type-get";
                        var params = "priceType.code=" + priceType.code;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtPriceTypeCreatedBy.val(data.priceType.createdBy);
                            txtPriceTypeCreatedDate.val(data.priceType.createdDate);
        //                    txtPriceTypeCountryCode.val(data.priceType.country.code);
        //                    txtPriceTypeCountryName.val(data.priceType.country.name);
                            txtPriceTypeCode.val(data.priceType.code);
                            txtPriceTypeName.val(data.priceType.name);
                            chkPriceTypeActiveStatus.attr('checked', data.priceType.activeStatus);
                            txtPriceTypeRemark.val(data.priceType.remark);
                            txtPriceTypeInActiveBy.val(data.priceType.inActiveBy);
                            var inActiveDate = data.priceType.inActiveDate;
                            var inActiveDate = inActiveDate.split('T')[0];
                            var inActiveDate = inActiveDate.split('-');
                            var inActiveDate = inActiveDate[1]+"/"+inActiveDate[2]+"/"+inActiveDate[0];
                            txtPriceTypeInActiveDate.val(inActiveDate);

                            if(data.priceType.activeStatus===true) {
                               $('#priceTypeActiveStatusActive').prop('checked',true);
                               $("#priceType\\.activeStatus").val("true");
                            }
                            else {                        
                               $('#priceTypeActiveStatusInActive').prop('checked',true);              
                               $("#priceType\\.activeStatus").val("false");
                            }

                            showInput("priceType");
                            hideInput("priceTypeSearch");
                        });
                    }
                    ev.preventDefault();
            });
            });
        });

        $('#btnPriceTypeSave').click(function (ev) {
            if (!$("#frmPriceTypeInput").valid()) {
                ev.preventDefault();
                return;
            }

            var url = "";

            if (updateRowId < 0)
                url = "master/price-type-save";
            else
                url = "master/price-type-update";

            var params = $("#frmPriceTypeInput").serialize();

            $.post(url, params, function () {
                hideInput("priceType");
                showInput("priceTypeSearch");
                allFieldsPriceType.val('').siblings('label[class="error"]').hide();
                reloadGridPriceType();
            });
            ev.preventDefault();
        });

        $('#btnPriceTypeDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/price-type-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#priceType_grid").jqGrid('getGridParam', 'selrow');
                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var priceType = $("#priceType_grid").jqGrid('getRowData', deleteRowId);
                        if (confirm("Are You Sure To Delete (Code : " + priceType.code + ")")) {
                            var url = "master/price-type-delete";
                            var params = "priceType.code=" + priceType.code;
                            $.post(url, params, function () {
                                reloadGridPriceType();
                            });
                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $('#btnPriceTypeCancel').click(function (ev) {
            hideInput("priceType");
            showInput("priceTypeSearch");
            allFieldsPriceType.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        $('#btnPriceType_search').click(function(ev) {
            $("#priceType_grid").jqGrid("clearGridData");
            $("#priceType_grid").jqGrid("setGridParam",{url:"master/price-type-search-data?" + $("#frmPriceTypeSearchInput").serialize()});
            $("#priceType_grid").trigger("reloadGrid");
            ev.preventDefault();
            
        });

        $('#btnPriceTypeRefresh').click(function (ev) {
            reloadGridPriceType();
        });
    });

</script>

<s:url id="remoteurlPriceType" action="price-type-search-data" />

<b>PRICE TYPE</b>
<hr>
<br class="spacer" />
<sj:div id="priceTypeButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnPriceTypeNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnPriceTypeUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnPriceTypeDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnPriceTypeRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>


<div id="priceTypeSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmPriceTypeSearchInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right" valign="center" ><b>Code</b></td>
                <td>
                    <s:textfield id="priceTypeSearchCode" name="priceTypeSearchCode" size="20"></s:textfield>
                </td>
                <td align="right" valign="center"><b>Name</b></td>
                <td>
                    <s:textfield id="priceTypeSearchName" name="priceTypeSearchName" size="50"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="priceTypeSearchActiveStatus" name="priceTypeSearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="priceTypeSearchActiveStatusRad" name="priceTypeSearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnPriceType_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
        <br/>
    </s:form>
</div>

<div id="priceTypeGrid">
    <sjg:grid
        id="priceType_grid"
        caption="PriceType"
        dataType="json"
        href="%{remoteurlPriceType}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listPriceTypeTemp"
        rowList="10,20,30"
        rowNum="10"
        viewrecords="true"
        rownumbers="true"
        shrinkToFit="false"
        width="$('#tabmnuCAR_BRAND').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="50" sortable="true"
            />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
            />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
            />  
    </sjg:grid >
</div>

<div id="priceTypeInput" class="content ui-widget">
    <s:form id="frmPriceTypeInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="priceType.code" name="priceType.code" title="Please Enter Code <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="priceType.name" name="priceType.name" size="50" title="Please Enter Name <br>" required="true" cssClass="required"></s:textfield></td>
                </tr>

                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="priceTypeActiveStatus" name="priceTypeActiveStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="priceType.activeStatus" name="priceType.activeStatus"  required="true" size="50"></s:textfield>
                    </td>
                </tr>
                 <tr>
                    <td align="right"><B>Remark</B></td>
                    <td>
                    <s:textfield id="priceType.remark" name="priceType.remark" title="Please Enter Remark" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="priceType.inActiveBy" name="priceType.inActiveBy" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <s:textfield disabled="true" id="priceType.inActiveDate" name="priceType.inActiveDate" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr> 
                    <td><s:textfield id="priceType.createdBy"  name="priceType.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="priceType.createdDate" name="priceType.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnPriceTypeSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnPriceTypeCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>