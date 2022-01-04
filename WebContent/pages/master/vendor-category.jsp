
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
        txtVendorCategoryCode=$("#vendorCategory\\.code"),
        txtVendorCategoryName=$("#vendorCategory\\.name"),
        rdbVendorCategoryActiveStatus=$("#vendorCategory\\.activeStatus"),
        txtVendorCategoryRemark=$("#vendorCategory\\.remark"),
        txtVendorCategoryInActiveBy = $("#vendorCategory\\.inActiveBy"),
        dtpVendorCategoryInActiveDate = $("#vendorCategory\\.inActiveDate"),
        txtVendorCategoryCreatedBy = $("#vendorCategory\\.createdBy"),
        dtpVendorCategoryCreatedDate = $("#vendorCategory\\.createdDate"),
        
        allFieldsVendorCategory=$([])
            .add(txtVendorCategoryCode)
            .add(txtVendorCategoryName)
            .add(txtVendorCategoryRemark)
            .add(txtVendorCategoryInActiveBy)
            .add(txtVendorCategoryCreatedBy);


    function reloadGridVendorCategory(){
        $("#vendorCategory_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("vendorCategory");
        
        $('#vendorCategory\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#vendorCategorySearchActiveStatusRadActive').prop('checked',true);
        $("#vendorCategorySearchActiveStatus").val("true");
        
        $('input[name="vendorCategorySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#vendorCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="vendorCategorySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#vendorCategorySearchActiveStatus").val(value);
        });
                
        $('input[name="vendorCategorySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#vendorCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="vendorCategoryActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#vendorCategory\\.activeStatus").val(value);
            $("#vendorCategory\\.inActiveDate").val("01/01/1900 00:00:00");
        });
                
        $('input[name="vendorCategoryActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#vendorCategory\\.activeStatus").val(value);
        });
        
        $("#btnVendorCategoryNew").click(function(ev){
             var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/vendor-category-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_vendorCategory();
                showInput("vendorCategory");
                hideInput("vendorCategorySearch");
                $('#vendorCategoryActiveStatusRadActive').prop('checked',true);
                $("#vendorCategory\\.activeStatus").val("true");
                $("#vendorCategory\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#vendorCategory\\.createdDate").val("01/01/1900 00:00:00");
                txtVendorCategoryCode.attr("autocomplete", "off");
                updateRowId = -1;
                txtVendorCategoryCode.attr("readonly",true);
                txtVendorCategoryCode.val("AUTO");

                });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnVendorCategorySave").click(function(ev) {
           if(!$("#frmVendorCategoryInput").valid()) {
//               handlers_input_vendorCategory();
               ev.preventDefault();
               return;
           };
           
           
           
           var url = "";
           vendorCategoryFormatDate();
           if (updateRowId < 0){
               url = "master/vendor-category-save";
           } else{
               url = "master/vendor-category-update";
           }
           
           var params = $("#frmVendorCategoryInput").serialize();
            
           $.post(url, params, function(data) {
                if (data.error) {
                    vendorCategoryFormatDate();
                    alertMessage(data.errorMessage);
                    return;
                }
                
                if(data.errorMessage){
                    alertMessage(data.errorMessage);
                    return;
                }
                
                alertMessage(data.message);
                
                hideInput("vendorCategory");
                showInput("vendorCategorySearch");
                allFieldsVendorCategory.val('').siblings('label[class="error"]').hide();
                txtVendorCategoryCode.val("AUTO");
                reloadGridVendorCategory();
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnVendorCategoryUpdate").click(function(ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/vendor-category-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
//                unHandlers_input_vendorCategory();
                updateRowId=$("#vendorCategory_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var vendorCategory=$("#vendorCategory_grid").jqGrid('getRowData',updateRowId);
                var url="master/vendor-category-get-data";
                var params="vendorCategory.code=" + vendorCategory.code;

                txtVendorCategoryCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                        txtVendorCategoryCode.val(data.vendorCategoryTemp.code);
                        txtVendorCategoryName.val(data.vendorCategoryTemp.name);
                        rdbVendorCategoryActiveStatus.val(data.vendorCategoryTemp.activeStatus);
                        txtVendorCategoryRemark.val(data.vendorCategoryTemp.remark);
                        txtVendorCategoryInActiveBy.val(data.vendorCategoryTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.vendorCategoryTemp.inActiveDate,true);
                        dtpVendorCategoryInActiveDate.val(inActiveDate);
                        txtVendorCategoryCreatedBy.val(data.vendorCategoryTemp.createdBy);
                        var createdDate=formatDateRemoveT(data.vendorCategoryTemp.createdDate,true);
                        dtpVendorCategoryCreatedDate.val(createdDate);

                        if(data.vendorCategoryTemp.activeStatus===true) {
                           $('#vendorCategoryActiveStatusRadActive').prop('checked',true);
                           $("#vendorCategory\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#vendorCategoryActiveStatusRadInActive').prop('checked',true);              
                           $("#vendorCategory\\.activeStatus").val("false");
                        }

                        showInput("vendorCategory");
                        hideInput("vendorCategorySearch");
                });
            });
            });
//            ev.preventDefault();
        });
        
        
        $("#btnVendorCategoryDelete").click(function (ev){
            var urlPeriodClosing="finance/period-closing-confirmation";
            var paramsPeriodClosing="";

            $.post(urlPeriodClosing,paramsPeriodClosing,function(result){
                var data=(result);
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
            var url="master/vendor-category-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#vendorCategory_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var vendorCategory=$("#vendorCategory_grid").jqGrid('getRowData',deleteRowID);
                var url="master/vendor-category-delete";
                var params="vendorCategory.code=" + vendorCategory.code;
                var message="Are You Sure To Delete(Code : "+ vendorCategory.code + ")?";
                alertMessageDelete("vendorCategory",url,params,message,400);
                
//                var dynamicDialog= $('<div id="conformBox">'+
//                    '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
//                    '</span>Are You Sure To Delete(Code : " '+ vendorCategory.code+ ')?</div>');
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
//                                var url="master/vendor-category-delete";
//                                var params="vendorCategory.code=" + vendorCategory.code;
//
//                                $.post(url,params,function (data){
//                                    if(data.error){
//                                        alertMessage(data.errorMessage);
//                                        return;
//                                    }
//
//                                    alertMessage(data.message);
//                                    reloadGridVendorCategory();
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
                
                
                
//                if(confirm("Are You Sure To Delete(Code : " + vendorCategory.code+ ")")){
//                    var url="master/vendor-category-delete";
//                    var params="vendorCategory.code=" + vendorCategory.code;
//
//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridVendorCategory();
//                    });
//                }
                });
            });
//            ev.preventDefault();
        });
        

        $("#btnVendorCategoryCancel").click(function(ev) {
            hideInput("vendorCategory");
            showInput("vendorCategorySearch");
            allFieldsVendorCategory.val('').siblings('label[class="error"]').hide();
            ev.preventDefault();
        });
        
        
        $('#btnVendorCategoryRefresh').click(function(ev) {
            $('#vendorCategorySearchActiveStatusRadActive').prop('checked',true);
            $("#vendorCategorySearchActiveStatus").val("true");
            $("#vendorCategory_grid").jqGrid("clearGridData");
            $("#vendorCategory_grid").jqGrid("setGridParam",{url:"master/vendor-category-data?"});
            $("#vendorCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnVendorCategoryPrint").click(function(ev) {
            
            var url = "reports/vendor-category-print-out-pdf?";
            var params = "";
              
            window.open(url+params,'vendorCategory','width=500,height=500');
        });
        
        $('#btnVendorCategory_search').click(function(ev) {
            $("#vendorCategory_grid").jqGrid("clearGridData");
            $("#vendorCategory_grid").jqGrid("setGridParam",{url:"master/vendor-category-data?" + $("#frmVendorCategorySearchInput").serialize()});
            $("#vendorCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
//    function unHandlers_input_vendorCategory(){
//        unHandlersInput(txtVendorCategoryCode);
//        unHandlersInput(txtVendorCategoryName);
//    }
//
//    function handlers_input_vendorCategory(){
//        if(txtVendorCategoryCode.val()===""){
//            handlersInput(txtVendorCategoryCode);
//        }else{
//            unHandlersInput(txtVendorCategoryCode);
//        }
//        if(txtVendorCategoryName.val()===""){
//            handlersInput(txtVendorCategoryName);
//        }else{
//            unHandlersInput(txtVendorCategoryName);
//        }
//    }
    
    function vendorCategoryFormatDate(){
        var inActiveDate=formatDate(dtpVendorCategoryInActiveDate.val(),true);
        dtpVendorCategoryInActiveDate.val(inActiveDate);
        $("#vendorCategoryTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpVendorCategoryCreatedDate.val(),true);
        dtpVendorCategoryCreatedDate.val(createdDate);
        $("#vendorCategoryTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlVendorCategory" action="vendor-category-data" />
<b>Vendor Category</b>
<hr>
<br class="spacer"/>


<sj:div id="vendorCategoryButton" cssClass="ikb-buttonset ikb-buttonset-single">
    <table>
        <tr>
            <td><a href="#" id="btnVendorCategoryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td><a href="#" id="btnVendorCategoryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td><a href="#" id="btnVendorCategoryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td> <a href="#" id="btnVendorCategoryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td><a href="#" id="btnVendorCategoryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print</a>
            </td>  
        </tr>
        
    </table>
</sj:div>      
    
<div id="vendorCategorySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmVendorCategorySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="vendorCategorySearchCode" name="vendorCategorySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="vendorCategorySearchName" name="vendorCategorySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="vendorCategorySearchActiveStatus" name="vendorCategorySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="vendorCategorySearchActiveStatusRad" name="vendorCategorySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnVendorCategory_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="vendorCategoryGrid">
    <sjg:grid
        id="vendorCategory_grid"
        dataType="json"
        href="%{remoteurlVendorCategory}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listVendorCategoryTemp"
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
            name="remark" index="remark" title="Remark" width="400" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
        />
    </sjg:grid>
</div>
    
<div id="vendorCategoryInput" class="content ui-widget">
    <s:form id="frmVendorCategoryInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="vendorCategory.code" name="vendorCategory.code" title="*" required="true" cssClass="required" maxLength="45" cssStyle="text-align: center;" ></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="vendorCategory.name" name="vendorCategory.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B></td>
                <td colspan="2">
                    <s:radio id="vendorCategoryActiveStatusRad" name="vendorCategoryActiveStatusRad" list="{'Active','InActive'}"></s:radio>
                    <s:textfield id="vendorCategory.activeStatus" name="vendorCategory.activeStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="vendorCategory.remark" name="vendorCategory.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="vendorCategory.inActiveBy"  name="vendorCategory.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker id="vendorCategory.inActiveDate" name="vendorCategory.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="vendorCategory.createdBy"  name="vendorCategory.createdBy" size="20"></s:textfield>
                    <sj:datepicker id="vendorCategory.createdDate" name="vendorCategory.createdDate" displayFormat="mm/dd/yy"  timepicker="true" timepickerFormat="hh:mm:ss" showOn="focus"></sj:datepicker>
                </td>
            </tr>
            <tr hidden="true">
                <td/>
                <td colspan="2">
                    <s:textfield id="vendorCategoryTemp.inActiveDateTemp" name="vendorCategoryTemp.inActiveDateTemp" size="22"></s:textfield>
                    <s:textfield id="vendorCategoryTemp.createdDateTemp" name="vendorCategoryTemp.createdDateTemp" size="22"></s:textfield>
                </td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnVendorCategorySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnVendorCategoryCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>