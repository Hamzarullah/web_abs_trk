<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<s:url id="remoteurlItemProductHead" action="item-product-head-json" />

<script type="text/javascript">
    var
            txtItemProductHeadCode = $("#itemProductHead\\.code"),
            txtItemProductHeadName = $("#itemProductHead\\.name"),
            txtItemProductHeadItemDivisionCode=$("#itemProductHead\\.itemDivision\\.code"),
            txtItemProductHeadItemDivisionName=$("#itemProductHead\\.itemDivision\\.name"),
            txtItemProductHeadRemark = $("#itemProductHead\\.remark"),
            txtItemProductHeadActiveStatus = $("#itemProductHead\\.activeStatus"),
            txtItemProductHeadInActiveBy = $("#itemProductHead\\.inActiveBy"),
            txtItemProductHeadInActiveDate = $("#itemProductHead\\.inActiveDate"),
            txtItemProductHeadCreatedBy = $("#itemProductHead\\.createdBy"),  
            txtItemProductHeadCreatedDate = $("#itemProductHead\\.createdDate"),
            allFieldsItemProductHead = $([])
            .add(txtItemProductHeadCode)
            .add(txtItemProductHeadName)
            .add(txtItemProductHeadItemDivisionCode)
            .add(txtItemProductHeadItemDivisionName)
            .add(txtItemProductHeadRemark)
            .add(txtItemProductHeadInActiveBy)
            .add(txtItemProductHeadInActiveDate);

    function reloadGridItemProductHead() {
        //$("#itemProductHead_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#itemProductHead_grid").trigger("reloadGrid");
    }
    ;

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("itemProductHead");
        $('#itemProductHead\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        $('#searchItemProductHeadActiveStatusRADActive').prop('checked',true);
            $("#searchItemProductHeadActiveStatus").val("YES");
        
        $('input[name="searchItemProductHeadActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchItemProductHeadActiveStatus").val(value);
        });
        
        $('input[name="searchItemProductHeadActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchItemProductHeadActiveStatus").val(value);
        });
                
        $('input[name="searchItemProductHeadActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchItemProductHeadActiveStatus").val(value);
        });
        
        $('#itemProductHeadStatusActive').change(function (ev) {
            var value = "true";
            $("#itemProductHead\\.activeStatus").val(value);
        });

        $('#itemProductHeadStatusInActive').change(function (ev) {
            var value = "false";
            $("#itemProductHead\\.activeStatus").val(value);
        });

        $("#btnItemProductHeadNew").click(function (ev) {
            
                var url="master/item-product-head-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("itemProductHead");
                    $("#frmItemProductHeadSearchInput").hide();
                     txtItemProductHeadCode.attr("readonly", false);
                    $('#itemProductHeadStatusActive').prop('checked', true);
                    var value = "true";
                    $("#itemProductHead\\.activeStatus").val(value);
                    $("#itemProductHead\\.inActiveDate").val("01/01/1900");
                    updateRowId = -1;
                    ev.preventDefault();
                });
            });
     

        $("#btnItemProductHeadUpdate").click(function (ev) {
            $("#frmItemProductHeadSearchInput").hide();
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/item-product-head-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#itemProductHead_grid").jqGrid("getGridParam", "selrow");

                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        txtItemProductHeadCode.attr("readonly", true);

                        var itemProductHead = $("#itemProductHead_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/item-product-head-get";
                        var params = "itemProductHead.code=" + itemProductHead.code;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtItemProductHeadCreatedBy.val(data.itemProductHead.createdBy);
                            txtItemProductHeadCreatedDate.val(data.itemProductHead.createdDate);
                            txtItemProductHeadCode.val(data.itemProductHead.code);
                            txtItemProductHeadName.val(data.itemProductHead.name);
                            txtItemProductHeadItemDivisionCode.val(data.itemProductHead.itemDivisionCode);
                            txtItemProductHeadItemDivisionName.val(data.itemProductHead.itemDivisionName);
                            txtItemProductHeadRemark.val(data.itemProductHead.remark);
                            txtItemProductHeadInActiveBy.val(data.itemProductHead.inActiveBy);
                            txtItemProductHeadInActiveDate.val(formatDateRemoveT(data.itemProductHead.inActiveDate));

                            if (data.itemProductHead.activeStatus === true) {
                                $('#itemProductHeadStatusActive').prop('checked', true);
                                $("#itemProductHead\\.itemProductHeadStatus").val("true");
                            } else {
                                $('#activeStatusInActive').prop('checked', true);
                                $("#itemProductHead\\.activeStatus").val("false");
                            }

                            showInput("itemProductHead");
                            $("#frmItemProductHeadSearchInput").hide();
                        });
                    }
                    ev.preventDefault();
                });
            });
        });

        $('#btnItemProductHeadDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/item-product-head-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#itemProductHead_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var itemProductHead = $("#itemProductHead_grid").jqGrid('getRowData', deleteRowId);

                        if (confirm("Are You Sure To Delete (Code : " + itemProductHead.code + ")")) {
                            var url = "master/item-product-head-delete";
                            var params = "itemProductHead.code=" + itemProductHead.code;

                            $.post(url, params, function () {
                                reloadGridItemProductHead();
                            });
                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnItemProductHeadSave").click(function (ev) {
//            formatDate(txtItemProductHeadTransactionDate.val(),true);
            if (!$("#frmItemProductHeadInput").valid()) {
       
                ev.preventDefault();
                return;
            };

            var url = "";
            var params = $("#frmItemProductHeadInput").serialize();

            if (updateRowId < 0) {
                url = "master/item-product-head-save";
            } else {
                url = "master/item-product-head-update";
                //params += "&itemProductHead.code="+ txtItemProductHeadCode.val();
            }

           $.post(url, params, function(data) {
                if (data.error) {
               
                    alertMessage(data.errorMessage);
                    return;
                }
                alertMessage(data.message);
                hideInput("itemProductHead");
                $("#frmItemProductHeadSearchInput").show();
                allFieldsItemProductHead.val('').siblings('label[class="error"]').hide();
                reloadGridItemProductHead();
            });
            ev.preventDefault();
        });


        $("#btnItemProductHeadCancel").click(function (ev) {
            hideInput("itemProductHead");
            $("#frmItemProductHeadSearchInput").show();
            allFieldsItemProductHead.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnItemProductHeadRefresh').click(function (ev) {
            reloadGridItemProductHead();
        });
        
        $("#btnItemProductHead_search").click(function(ev) {
            $("#itemProductHead_grid").jqGrid("setGridParam",{url:"master/item-product-head-search?" + $("#frmItemProductHeadSearchInput").serialize(), page:1});
            $("#itemProductHead_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
    });
</script>

<b>Item Product Head</b>
<hr>
<br class="spacer" />
<s:url id="remoteurlItemProductHead" action="item-product-head-search"/>
<sj:div id="itemProductHeadButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemProductHeadNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemProductHeadUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemProductHeadDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemProductHeadRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemProductHeadPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>              
<br class="spacer" />    
<div id="itemDivisionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemProductHeadSearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="searchItemProductHead.code" name="searchItemProductHead.code" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="searchItemProductHead.name" name="searchItemProductHead.name" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="searchItemProductHeadActiveStatus" name="searchItemProductHeadActiveStatus" readonly="Yes" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchItemProductHeadActiveStatusRAD" name="searchItemProductHeadActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemProductHead_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   

<br class="spacer" />

<div id="itemProductHeadGrid">
    <sjg:grid
        id="itemProductHead_grid"
        dataType="json"
        href="%{remoteurlItemProductHead}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemProductHead"
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
            name="itemDivision.code" index="itemDivision.code" key="itemDivision.code" title="ItemDivisionCode" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="itemDivision.name" index="itemDivision.name" key="itemDivision.name" title="ItemDivisionName" width="200" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />   
    </sjg:grid >
</div>

<div id="itemProductHeadInput" class="content ui-widget">
    <s:form id="frmItemProductHeadInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="itemProductHead.code" name="itemProductHead.code" title="Please Enter Code!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="itemProductHead.name" name="itemProductHead.name" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Product Category *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            
                            $('#itemProductHead_btnCountry').click(function(ev) {
                                window.open("./pages/search/search-item-division.jsp?iddoc=itemProductHead&idsubdoc=itemDivision","Search", "Scrollbars=1,width=600, height=500");
                            });
                            txtItemProductHeadItemDivisionCode.change(function(ev) {

                                if(txtItemProductHeadItemDivisionCode.val()===""){
                                    txtItemProductHeadItemDivisionName.val("");
                                    return;
                                }
                                var url = "master/item-product-head";
                                var params = "itemDivision.code=" + txtItemProductHeadItemDivisionCode.val();
                                    params+= "&itemDivision.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.itemDivisionTemp){
                                        txtItemProductHeadItemDivisionCode.val(data.itemDivisionTemp.code);
                                        txtItemProductHeadItemDivisionName.val(data.itemDivisionTemp.name);
                                    }
                                    else{
                                        alertMessage("Country Not Found!",txtItemProductHeadItemDivisionCode);
                                        txtItemProductHeadItemDivisionCode.val("");
                                        txtItemProductHeadItemDivisionName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="itemProductHead.itemDivision.code" name="itemProductHead.itemDivision.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                            <sj:a id="itemProductHead_btnCountry" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="itemProductHead.itemDivision.name" name="itemProductHead.itemDivision.name" cssStyle="width:30%" readonly="true"></s:textfield>
                    </td>
                </tr>      
                <tr>
                    <td align="right"><B>Remark *</B></td>
                    <td><s:textfield id="itemProductHead.remark" name="itemProductHead.remark" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>       
                <tr>
                    <td align="right"><B>Active Status</B></td>
                    <td><s:radio id="itemProductHeadStatus" name="itemProductHeadStatus" list="{'Active','InActive'}"></s:radio></td>
                    <td>
                    <s:textfield style="display:none" id="itemProductHead.activeStatus" name="itemProductHead.activeStatus" title="Please Enter Role Name" required="true" size="50"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="itemProductHead.inActiveBy" name="itemProductHead.inActiveBy" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <s:textfield disabled="true" id="itemProductHead.inActiveDate" name="itemProductHead.inActiveDate" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td><s:textfield id="itemProductHead.createdBy"  name="itemProductHead.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="itemProductHead.createdDate" name="itemProductHead.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnItemProductHeadSave" button="true">Save</sj:a>
        <sj:a href="#" id="btnItemProductHeadCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>