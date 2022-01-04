<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js" />"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />
<s:url id="remoteurlItemCategory" action="item-category-json" />

<script type="text/javascript">
    var
            txtItemCategoryCode = $("#itemCategory\\.code"),
            txtItemCategoryName = $("#itemCategory\\.name"),
            txtItemCategoryItemDivisionCode=$("#itemCategory\\.itemDivision\\.code"),
            txtItemCategoryItemDivisionName=$("#itemCategory\\.itemDivision\\.name"),
            txtItemCategoryRemark = $("#itemCategory\\.remark"),
            txtItemCategoryActiveStatus = $("#itemCategory\\.activeStatus"),
            txtItemCategoryInActiveBy = $("#itemCategory\\.inActiveBy"),
            txtItemCategoryInActiveDate = $("#itemCategory\\.inActiveDate"),
            txtItemCategoryCreatedBy = $("#itemCategory\\.createdBy"),  
            txtItemCategoryCreatedDate = $("#itemCategory\\.createdDate"),
            allFieldsItemCategory = $([])
            .add(txtItemCategoryCode)
            .add(txtItemCategoryName)
            .add(txtItemCategoryItemDivisionCode)
            .add(txtItemCategoryItemDivisionName)
            .add(txtItemCategoryRemark)
            .add(txtItemCategoryInActiveBy)
            .add(txtItemCategoryInActiveDate);

    function reloadGridItemCategory() {
        //$("#itemCategory_grid").jqGrid('setGridWidth',$("#tabs").width() - 30, false);
        $("#itemCategory_grid").trigger("reloadGrid");
    }
    ;

    $(document).ready(function () {
        hoverButton();
        var updateRowId = -1;
        hideInput("itemCategory");
        $('#itemCategory\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });

        $('#searchItemCategoryActiveStatusRADActive').prop('checked',true);
            $("#searchItemCategoryActiveStatus").val("YES");
        
        $('input[name="searchItemCategoryActiveStatusRAD"][value="All"]').change(function(ev){
            var value="ALL";
            $("#searchItemCategoryActiveStatus").val(value);
        });
        
        $('input[name="searchItemCategoryActiveStatusRAD"][value="Active"]').change(function(ev){
            var value="YES";
            $("#searchItemCategoryActiveStatus").val(value);
        });
                
        $('input[name="searchItemCategoryActiveStatusRAD"][value="InActive"]').change(function(ev){
            var value="NO";
            $("#searchItemCategoryActiveStatus").val(value);
        });
        
         $('input[name="itemCategoryActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemCategory\\.activeStatus").val(value);
            $("#itemCategory\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemCategoryActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemCategory\\.activeStatus").val(value);
        });

        $("#btnItemCategoryNew").click(function (ev) {
            
                var url="master/item-category-authority";
                var params="actionAuthority=INSERT";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    showInput("itemCategory");
                    $("#frmItemCategorySearchInput").hide();
                     txtItemCategoryCode.attr("readonly", false);
                    $('#itemCategoryActiveStatusRadActive').prop('checked', true);
                    var value = "true";
                    $("#itemCategory\\.activeStatus").val(value);
                    $("#itemCategory\\.inActiveDate").val("01/01/1900");
                    updateRowId = -1;
                    txtItemCategoryCode.attr("readonly",true);
                    txtItemCategoryCode.val("AUTO");
                    ev.preventDefault();
                });
            });
     

        $("#btnItemCategoryUpdate").click(function (ev) {
            $("#frmItemCategorySearchInput").hide();
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/item-category-authority";
                var params="actionAuthority=UPDATE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    updateRowId = $("#itemCategory_grid").jqGrid("getGridParam", "selrow");

                    if (updateRowId == null) {
                        alert("Please Select Row");
                    } else {
                        txtItemCategoryCode.attr("readonly", true);

                        var itemCategory = $("#itemCategory_grid").jqGrid('getRowData', updateRowId);
                        var url = "master/item-category-get";
                        var params = "itemCategory.code=" + itemCategory.code;
                        $.post(url, params, function (result) {
                            var data = (result);
                            txtItemCategoryCreatedBy.val(data.itemCategory.createdBy);
                            txtItemCategoryCreatedDate.val(data.itemCategory.createdDate);
                            txtItemCategoryCode.val(data.itemCategory.code);
                            txtItemCategoryName.val(data.itemCategory.name);
                            txtItemCategoryItemDivisionCode.val(data.itemCategory.itemDivision.code);
                            txtItemCategoryItemDivisionName.val(data.itemCategory.itemDivision.name);
                            txtItemCategoryRemark.val(data.itemCategory.remark);
                            txtItemCategoryInActiveBy.val(data.itemCategory.inActiveBy);
                            txtItemCategoryInActiveDate.val(formatDateRemoveT(data.itemCategory.inActiveDate));

                            if (data.itemCategory.activeStatus === true) {
                                $('#itemCategoryActiveStatusRadActive').prop('checked', true);
                                $("#itemCategory\\.activeStatus").val("true");
                            } else {
                                $('#itemCategoryActiveStatusRadInActive').prop('checked', true);
                                $("#itemCategory\\.activeStatus").val("false");
                            }

                            showInput("itemCategory");
                            $("#frmItemCategorySearchInput").hide();
//                            txtItemCategoryCode.val("AUTO");
                            reloadGridItemCategory();
                            ev.preventDefault();

                        });
                    }
                });
            });
        });

        $('#btnItemCategoryDelete').click(function (ev) {
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                var url="master/item-category-authority";
                var params="actionAuthority=DELETE";
                $.post(url, params, function(data) {
                    if (data.error) {
                        alertMessage(data.errorMessage);
                        return;
                    }
                    var deleteRowId = $("#itemCategory_grid").jqGrid('getGridParam', 'selrow');

                    if (deleteRowId == null) {
                        alert("Please Select Row");
                    } else {
                        var itemCategory = $("#itemCategory_grid").jqGrid('getRowData', deleteRowId);

                        if (confirm("Are You Sure To Delete (Code : " + itemCategory.code + ")")) {
                            var url = "master/item-category-delete";
                            var params = "itemCategory.code=" + itemCategory.code;

                            $.post(url, params, function () {
                                reloadGridItemCategory();
                            });
                        }
                    }
                    ev.preventDefault();
                });
            });
        });

        $("#btnItemCategorySave").click(function (ev) {
//            formatDate(txtItemCategoryTransactionDate.val(),true);
            if (!$("#frmItemCategoryInput").valid()) {
       
                ev.preventDefault();
                return;
            };

            var url = "";
            var params = $("#frmItemCategoryInput").serialize();

            if (updateRowId < 0) {
                url = "master/item-category-save";
            } else {
                url = "master/item-category-update";
                //params += "&itemCategory.code="+ txtItemCategoryCode.val();
            }
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
                hideInput("itemCategory");
                $("#frmItemCategorySearchInput").show();
                
                allFieldsItemCategory.val('').siblings('label[class="error"]').hide();
                txtItemCategoryCode.val("AUTO");
                reloadGridItemCategory();
            });
            ev.preventDefault();
        });


        $("#btnItemCategoryCancel").click(function (ev) {
            hideInput("itemCategory");
            $("#frmItemCategorySearchInput").show();
            allFieldsItemCategory.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });

        $('#btnItemCategoryRefresh').click(function (ev) {
            reloadGridItemCategory();
        });
        
        $("#btnItemCategory_search").click(function(ev) {
            $("#itemCategory_grid").jqGrid("setGridParam",{url:"master/item-category-search?" + $("#frmItemCategorySearchInput").serialize(), page:1});
            $("#itemCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
    });
   
</script>

<b>Item Category</b>
<hr>
<br class="spacer" />
<s:url id="remoteurlItemCategory" action="item-category-search"/>
<sj:div id="itemCategoryButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemCategoryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemCategoryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemCategoryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemCategoryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemCategoryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
       
    </table>
</sj:div>              
<br class="spacer" />    
<div id="itemDivisionSearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemCategorySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="searchItemCategory.code" name="searchItemCategory.code" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="searchItemCategory.name" name="searchItemCategory.name" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="searchItemCategoryActiveStatus" name="searchItemCategoryActiveStatus" readonly="Yes" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="searchItemCategoryActiveStatusRAD" name="searchItemCategoryActiveStatusRAD" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemCategory_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   

<br class="spacer" />

<div id="itemCategoryGrid">
    <sjg:grid
        id="itemCategory_grid"
        dataType="json"
        href="%{remoteurlItemCategory}"
        pager="true"
        navigator="true"
        navigatorView="true"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemCategory"
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

<div id="itemCategoryInput" class="content ui-widget">
    <s:form id="frmItemCategoryInput">
        <table cellpadding="2" cellspacing="2" >
            <tr>
                <td align="right"><B>Code *</B></td>
                <td><s:textfield id="itemCategory.code" name="itemCategory.code" title="Please Enter Code!" required="true" cssClass="required" cssStyle="text-align: center;" ></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Name *</B></td>
                    <td><s:textfield id="itemCategory.name" name="itemCategory.name" size="50" title="Please Enter Name!" required="true" cssClass="required"></s:textfield></td>
                </tr>
                <tr>
                    <td align="right"><B>Item Division *</B></td>
                    <td colspan="2">
                        <script type = "text/javascript">
                            
                            $('#itemCategory_btnItemDivision').click(function(ev) {
                                window.open("./pages/search/search-item-division.jsp?iddoc=itemCategory&idsubdoc=itemDivision","Search", "Scrollbars=1,width=600, height=500");
                            });
                            txtItemCategoryItemDivisionCode.change(function(ev) {

                                if(txtItemCategoryItemDivisionCode.val()===""){
                                    txtItemCategoryItemDivisionName.val("");
                                    return;
                                }
                                var url = "master/item-division-get";
                                var params = "itemDivision.code=" + txtItemCategoryItemDivisionCode.val();
                                    params+= "&itemDivision.activeStatus=TRUE";

                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.itemDivisionTemp){
                                        txtItemCategoryItemDivisionCode.val(data.itemDivisionTemp.code);
                                        txtItemCategoryItemDivisionName.val(data.itemDivisionTemp.name);
                                    }
                                    else{
                                        alertMessage("Item Division Not Found!",txtItemCategoryItemDivisionCode);
                                        txtItemCategoryItemDivisionCode.val("");
                                        txtItemCategoryItemDivisionName.val("");
                                    }
                                });
                            });
                        </script>
                        <div class="searchbox ui-widget-header">
                            <s:textfield id="itemCategory.itemDivision.code" name="itemCategory.itemDivision.code" size="20" title="*" required="true" cssClass="required"></s:textfield>
                            <sj:a id="itemCategory_btnItemDivision" href="#" openDialog=""> &nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                        </div>
                            <s:textfield id="itemCategory.itemDivision.name" name="itemCategory.itemDivision.name" size="24" readonly="true"></s:textfield>
                    </td>
                </tr>      
                <tr>
                    <td align="right">Remark </td>
                    <td><s:textfield id="itemCategory.remark" name="itemCategory.remark" size="50"></s:textfield></td>
                </tr>       
                <tr>
                    <td align="right"><B>Active Status *</B></td>
                    <td colspan="2">
                        <s:radio id="itemCategoryActiveStatusRad" name="itemCategoryActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                        <s:textfield id="itemCategory.activeStatus" name="itemCategory.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                    </td>                    
                </tr>
                <tr>
                    <td align="right"><B>InActive By</B></td>
                    <td>
                    <s:textfield disabled="true" id="itemCategory.inActiveBy" name="itemCategory.inActiveBy" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr> 
                <tr>
                    <td align="right"><B>InActive Date</B></td>
                    <td>
                    <s:textfield disabled="true" id="itemCategory.inActiveDate" name="itemCategory.inActiveDate" title="Please Enter Remark" size="50" readonly="true"></s:textfield>
                    </td>
                </tr>
                <tr>
                    <td><s:textfield id="itemCategory.createdBy"  name="itemCategory.createdBy" size="20" style="display:none"></s:textfield></td>
                    <td><s:textfield id="itemCategory.createdDate" name="itemCategory.createdDate" size="20" style="display:none"></s:textfield></td>
                </tr>
            </table>
            <br />
            <div class="error ui-state-error ui-corner-all">
                <span class="ui-icon ui-icon-alert" style="float:left;margin-right:1em;"></span>
            </div>
            <br />
        <sj:a href="#" id="btnItemCategorySave" button="true">Save</sj:a>
        <sj:a href="#" id="btnItemCategoryCancel" button="true">Cancel</sj:a>
            <br /><br />
    </s:form>
</div>