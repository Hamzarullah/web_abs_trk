
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
        txtItemSubCategoryCode=$("#itemSubCategory\\.code"),
        txtItemSubCategoryName=$("#itemSubCategory\\.name"),
        txtItemSubCategoryItemCategoryCode=$("#itemSubCategory\\.itemCategory\\.code"),
        txtItemSubCategoryItemCategoryName=$("#itemSubCategory\\.itemCategory\\.name"),
        txtItemDivisionCode=$("#itemSubCategory\\.itemCategory\\.itemDivision\\.code"),
        txtItemDivisionName=$("#itemSubCategory\\.itemCategory\\.itemDivision\\.name"),
        rdbItemSubCategoryActiveStatus=$("#itemSubCategory\\.activeStatus"),
        txtItemSubCategoryRemark=$("#itemSubCategory\\.remark"),
        txtItemSubCategoryInActiveBy = $("#itemSubCategory\\.inActiveBy"),
        dtpItemSubCategoryInActiveDate = $("#itemSubCategory\\.inActiveDate"),
        txtItemSubCategoryCreatedBy = $("#itemSubCategory\\.createdBy"),
        dtpItemSubCategoryCreatedDate = $("#itemSubCategory\\.createdDate"),
        
        allFieldsItemSubCategory=$([])
            .add(txtItemSubCategoryCode)
            .add(txtItemSubCategoryName)
            .add(txtItemSubCategoryItemCategoryCode)
            .add(txtItemSubCategoryItemCategoryName)
            .add(txtItemSubCategoryRemark)
            .add(txtItemSubCategoryInActiveBy)
            .add(txtItemSubCategoryCreatedBy);


    function reloadGridItemSubCategory(){
        $("#itemSubCategory_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("itemSubCategory");
        
        $('#itemSubCategory\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#itemSubCategorySearchActiveStatusRadActive').prop('checked',true);
        $("#itemSubCategorySearchActiveStatus").val("true");
        
        $('input[name="itemSubCategorySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#itemSubCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="itemSubCategorySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSubCategorySearchActiveStatus").val(value);
        });
                
        $('input[name="itemSubCategorySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSubCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="itemSubCategoryActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#itemSubCategory\\.activeStatus").val(value);
            $("#itemSubCategory\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="itemSubCategoryActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#itemSubCategory\\.activeStatus").val(value);
        });
        
        $("#btnItemSubCategoryNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-sub-category-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSubCategory();
                showInput("itemSubCategory");
                hideInput("itemSubCategorySearch");
                $('#itemSubCategoryActiveStatusRadActive').prop('checked',true);
                $("#itemSubCategory\\.activeStatus").val("true");
                $("#itemSubCategory\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#itemSubCategory\\.createdDate").val("01/01/1900 00:00:00");
                txtItemSubCategoryCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtItemSubCategoryCode.attr("readonly",true);
                txtItemSubCategoryCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSubCategorySave").click(function(ev) {
           if(!$("#frmItemSubCategoryInput").valid()) {
//               handlers_input_itemSubCategory();
               ev.preventDefault();
               return;
           };
           
           var url = "";
           itemSubCategoryFormatDate();
           if (updateRowId < 0){
               url = "master/item-sub-category-save";
           } else{
               url = "master/item-sub-category-update";
           }
           
           var params = $("#frmItemSubCategoryInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    itemSubCategoryFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("itemSubCategory");
                showInput("itemSubCategorySearch");
                allFieldsItemSubCategory.val('').siblings('label[class="error"]').hide();
                txtItemSubCategoryCode.val("AUTO");
                reloadGridItemSubCategory();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnItemSubCategoryUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-sub-category-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_itemSubCategory();
                updateRowId=$("#itemSubCategory_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var itemSubCategory=$("#itemSubCategory_grid").jqGrid('getRowData',updateRowId);
                var url="master/item-sub-category-get-data";
                var params="itemSubCategory.code=" + itemSubCategory.code;

                txtItemSubCategoryCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtItemSubCategoryCode.val(data.itemSubCategoryTemp.code);
                        txtItemSubCategoryName.val(data.itemSubCategoryTemp.name);
                        txtItemSubCategoryItemCategoryCode.val(data.itemSubCategoryTemp.itemCategoryCode);
                        txtItemSubCategoryItemCategoryName.val(data.itemSubCategoryTemp.itemCategoryName);
                        rdbItemSubCategoryActiveStatus.val(data.itemSubCategoryTemp.activeStatus);
                        txtItemSubCategoryRemark.val(data.itemSubCategoryTemp.remark);
                        txtItemSubCategoryInActiveBy.val(data.itemSubCategoryTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.itemSubCategoryTemp.inActiveDate,true);
                        dtpItemSubCategoryInActiveDate.val(inActiveDate);
                        txtItemSubCategoryCreatedBy.val(data.itemSubCategoryTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.itemSubCategoryTemp.createdDate,true);
                        dtpItemSubCategoryCreatedDate.val(createdDate);

                        if(data.itemSubCategoryTemp.activeStatus===true) {
                           $('#itemSubCategoryActiveStatusRadActive').prop('checked',true);
                           $("#itemSubCategory\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#itemSubCategoryActiveStatusRadInActive').prop('checked',true);              
                           $("#itemSubCategory\\.activeStatus").val("false");
                        }

                        showInput("itemSubCategory");
                        hideInput("itemSubCategorySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnItemSubCategoryDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/item-sub-category-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#itemSubCategory_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var itemSubCategory=$("#itemSubCategory_grid").jqGrid('getRowData',deleteRowID);
                var url="master/item-sub-category-delete";
                var params="itemSubCategory.code=" + itemSubCategory.code;
                var message="Are You Sure To Delete(Code : "+ itemSubCategory.code + ")?";
                alertMessageDelete("itemSubCategory",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ itemSubCategory.code+ ')?</div>');
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
//                                var url="master/item-product-category-delete";
//                                var params="itemSubCategory.code=" + itemSubCategory.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridItemSubCategory();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + itemSubCategory.code+ ")")){
//                    var url="master/item-product-category-delete";
//                    var params="itemSubCategory.code=" + itemSubCategory.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridItemSubCategory();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnItemSubCategoryCancel").click(function(ev) {
            hideInput("itemSubCategory");
            showInput("itemSubCategorySearch");
            allFieldsItemSubCategory.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnItemSubCategoryRefresh').click(function(ev) {
            $('#itemSubCategorySearchActiveStatusRadActive').prop('checked',true);
            $("#itemSubCategorySearchActiveStatus").val("true");
            $("#itemSubCategory_grid").jqGrid("clearGridData");
            $("#itemSubCategory_grid").jqGrid("setGridParam",{url:"master/item-sub-category-data?"});
            $("#itemSubCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnItemSubCategoryPrint").click(function(ev) {
            
            var url = "reports/item-sub-category-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'itemSubCategory','width=500,height=500');
        });
        
        $('#btnItemSubCategory_search').click(function(ev) {
            $("#itemSubCategory_grid").jqGrid("clearGridData");
            $("#itemSubCategory_grid").jqGrid("setGridParam",{url:"master/item-sub-category-data?" + $("#frmItemSubCategorySearchInput").serialize()});
            $("#itemSubCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_itemSubCategory(){
//        unHandlersInput(txtItemSubCategoryCode);
//        unHandlersInput(txtItemSubCategoryName);
//    }
//
//    function handlers_input_itemSubCategory(){
//        if(txtItemSubCategoryCode.val()===""){
//            handlersInput(txtItemSubCategoryCode);
//        }else{
//            unHandlersInput(txtItemSubCategoryCode);
//        }
//        if(txtItemSubCategoryName.val()===""){
//            handlersInput(txtItemSubCategoryName);
//        }else{
//            unHandlersInput(txtItemSubCategoryName);
//        }
//    }
    
    function itemSubCategoryFormatDate(){
        var inActiveDate=formatDate(dtpItemSubCategoryInActiveDate.val(),true);
        dtpItemSubCategoryInActiveDate.val(inActiveDate);
        $("#itemSubCategoryTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpItemSubCategoryCreatedDate.val(),true);
        dtpItemSubCategoryCreatedDate.val(createdDate);
        $("#itemSubCategoryTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlItemSubCategory" action="item-sub-category-data" />
<b>ITEM SUB CATEGORY</b>
<hr>
<br class="spacer"/>


<sj:div id="itemSubCategoryButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnItemSubCategoryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnItemSubCategoryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnItemSubCategoryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnItemSubCategoryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnItemSubCategoryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="itemSubCategorySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmItemSubCategorySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="itemSubCategorySearchCode" name="itemSubCategorySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="itemSubCategorySearchName" name="itemSubCategorySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="itemSubCategorySearchActiveStatus" name="itemSubCategorySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="itemSubCategorySearchActiveStatusRad" name="itemSubCategorySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnItemSubCategory_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="itemSubCategoryGrid">
    <sjg:grid
        id="itemSubCategory_grid"
        dataType="json"
        href="%{remoteurlItemSubCategory}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listItemSubCategoryTemp"
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
            name="itemCategoryCode" index="itemCategoryCode" title="Item Category Code" width="300" sortable="true"
        />
         <sjg:gridColumn
            name="itemCategoryName" index="itemCategoryName" title="Item Category Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="itemSubCategoryInput" class="content ui-widget">
    <s:form id="frmItemSubCategoryInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="itemSubCategory.code" name="itemSubCategory.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="itemSubCategory.name" name="itemSubCategory.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Item Category *</B></td>
                <td>
                    <script type = "text/javascript">

                    $('#itemSubCategory_btnItemCategory').click(function(ev) {
                        window.open("./pages/search/search-item-category.jsp?iddoc=itemSubCategory&idsubdoc=itemCategory","Search", "scrollbars=1, width=700, height=500");
                    });
                        txtItemSubCategoryItemCategoryCode.change(function(ev) {

                            if(txtItemSubCategoryItemCategoryCode.val()===""){
                                txtItemSubCategoryItemCategoryCode.val("");
                                txtItemSubCategoryItemCategoryName.val("");
                                return;
                            }

                            var url = "master/item-category-get-data";
                            var params = "itemCategory.code=" + txtItemSubCategoryItemCategoryCode.val();
                            params += "&itemCategory.activeStatus="+true;
                            
                            $.post(url, params, function(result) {
                                var data = (result);
                                if (data.itemCategoryTemp){
                                    txtItemSubCategoryItemCategoryCode.val(data.itemCategoryTemp.code);
                                    txtItemSubCategoryItemCategoryName.val(data.itemCategoryTemp.name);
                                    txtItemDivisionCode.val(data.itemCategoryTemp.itemDivisionCode);
                                    txtItemDivisionName.val(data.itemCategoryTemp.itemDivisionName);
                                }
                                else{
                                    txtItemSubCategoryItemCategoryCode.val("");
                                    txtItemSubCategoryItemCategoryName.val("");
                                    alert("Item Category Not Found");
                                }
                            });
                        });

                    </script>
                    <div class="searchbox ui-widget-header">
                    <s:textfield id="itemSubCategory.itemCategory.code" name="itemSubCategory.itemCategory.code" title="*" required="true" cssClass="required" size="25" maxLength="45"></s:textfield>
                        <sj:a id="itemSubCategory_btnItemCategory" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                    </div>
                        <s:textfield id="itemSubCategory.itemCategory.name" name="itemSubCategory.itemCategory.name" size="45" readonly="true" disabled="true"></s:textfield> 
                </td>
            </tr>
            <tr>
                <td align="right"><b>Item Division *</b></td>
                <td>
                    <s:textfield id="itemSubCategory.itemCategory.itemDivision.code" name="itemSubCategory.itemCategory.itemDivision.code" title="*" required="true" cssClass="required" maxLength="45" readonly="true" disabled="true"></s:textfield>
                    <s:textfield id="itemSubCategory.itemCategory.itemDivision.name" name="itemSubCategory.itemCategory.itemDivision.name" title="*" required="true" cssClass="required" maxLength="45" readonly="true" disabled="true"></s:textfield>
                </td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="itemSubCategoryActiveStatusRad" name="itemSubCategoryActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="itemSubCategory.activeStatus" name="itemSubCategory.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="itemSubCategory.remark" name="itemSubCategory.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="itemSubCategory.inActiveBy"  name="itemSubCategory.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="itemSubCategory.inActiveDate" name="itemSubCategory.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSubCategory.createdBy"  name="itemSubCategory.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="itemSubCategory.createdDate" name="itemSubCategory.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="itemSubCategoryTemp.inActiveDateTemp" name="itemSubCategoryTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="itemSubCategoryTemp.createdDateTemp" name="itemSubCategoryTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnItemSubCategorySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnItemSubCategoryCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>