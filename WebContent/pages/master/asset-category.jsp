
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
        txtAssetCategoryCode=$("#assetCategory\\.code"),
        txtAssetCategoryName=$("#assetCategory\\.name"),
        rdbAssetCategoryActiveStatus=$("assetCategory\\.activeStatus"),
        txtAssetCategoryInActiveBy = $("#assetCategory\\.inActiveBy"),
        dtpAssetCategoryInActiveDate = $("#assetCategory\\.inActiveDate"),
        txtAssetCategoryRemark=$("#assetCategory\\.remark"),
        txtAssetCategoryCreatedBy = $("#assetCategory\\.createdBy"),
        txtAssetCategoryCreatedDate = $("#assetCategory\\.createdDate"),
        
        allFieldsAssetCategory=$([])
            .add(txtAssetCategoryCode)
            .add(txtAssetCategoryName)
            .add(rdbAssetCategoryActiveStatus)
            .add(txtAssetCategoryRemark)
            .add(txtAssetCategoryInActiveBy)
            .add(txtAssetCategoryCreatedBy)
            .add(txtAssetCategoryCreatedDate);
    
    function reloadGridAssetCategory(){
        $("#assetCategory_grid").trigger("reloadGrid");
    };
    
    $(document).ready(function (){
        hoverButton();
        var updateRowId=-1;
        hideInput("assetCategory");
        
        $('#assetCategory\\.code').keyup(function() {
           this.value = this.value.toUpperCase();
        });
        
        $('#assetCategorySearchActiveStatusRadActive').prop('checked',true);
        $("#assetCategorySearchActiveStatus").val("true");
        
        $('input[name="assetCategorySearchActiveStatusRad"][value="All"]').change(function(ev){
            var value="";
            $("#assetCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="assetCategorySearchActiveStatusRad"][value="Active"]').change(function(ev){
            var value="true";
            $("#assetCategorySearchActiveStatus").val(value);
        });
                
        $('input[name="assetCategorySearchActiveStatusRad"][value="InActive"]').change(function(ev){
            var value="false";
            $("#assetCategorySearchActiveStatus").val(value);
        });
        
        $('input[name="assetCategory\\.activeStatus"][value="Active"]').change(function(ev){
            var value="true";
            $("#assetCategory\\.activeStatus").val(value);
        });
                
        $('input[name="assetCategory\\.activeStatus"][value="InActive"]').change(function(ev){
            var value="false";
            $("#assetCategory\\.activeStatus").val(value);
        });
        
        $("#btnAssetCategoryNew").click(function(ev){
            var url="master/asset-category-authority";
            var params="actionAuthority=INSERT";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_assetCategory();
                showInput("assetCategory");
                hideInput("assetCategorySearch");
                $('#assetCategory\\.activeStatusActive').prop('checked',true);
                $("#assetCategory\\.activeStatus").val("true");
                $("#assetCategory\\.inActiveDate").val("01/01/1900 00:00:00");
                $("#assetCategory\\.createdDate").val("01/01/1900 00:00:00");
                updateRowId = -1;
                txtAssetCategoryCode.attr("readonly",false);

            });
            ev.preventDefault();
        });
        
        
        $("#btnAssetCategorySave").click(function(ev) {
           if(!$("#frmAssetCategoryInput").valid()) {
               handlers_input_assetCategory();
               ev.preventDefault();
               return;
           };
           
           var url = "";
           
           if (updateRowId < 0) 
               url = "master/asset-category-save";
           else
               url = "master/asset-category-update";
                      
           var params = $("#frmAssetCategoryInput").serialize();
            
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
                
                hideInput("assetCategory");
                showInput("assetCategorySearch");
                allFieldsAssetCategory.val('').removeClass('ui-state-error');
                reloadGridAssetCategory();           
           });
           
           ev.preventDefault();
        });
        
        
        $("#btnAssetCategoryUpdate").click(function(ev){
            var url="master/asset-category-authority";
            var params="actionAuthority=UPDATE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                unHandlers_input_assetCategory();
                updateRowId=$("#assetCategory_grid").jqGrid("getGridParam","selrow");
            
                if(updateRowId===null){
                    alertMessage("Please Select Row!");
                    return;
                }

                var assetCategory=$("#assetCategory_grid").jqGrid('getRowData',updateRowId);
                var url="master/asset-category-get-data";
                var params="assetCategory.code=" + assetCategory.code;

                txtAssetCategoryCode.attr("readonly",true);

                $.post(url,params,function (result){
                    var data=(result);
                    
                        txtAssetCategoryCode.val(data.assetCategoryTemp.code);
                        txtAssetCategoryName.val(data.assetCategoryTemp.name);
                        rdbAssetCategoryActiveStatus.val(data.assetCategoryTemp.activeStatus);
                        txtAssetCategoryRemark.val(data.assetCategoryTemp.remark);
                        txtAssetCategoryInActiveBy.val(data.assetCategoryTemp.inActiveBy);
                        var inActiveDate=formatDateRemoveT(data.assetCategoryTemp.inActiveDate,true);
                        dtpAssetCategoryInActiveDate.val(inActiveDate);
                        txtAssetCategoryCreatedBy.val(data.assetCategoryTemp.createdBy);
                        txtAssetCategoryCreatedDate.val(data.assetCategoryTemp.createdDate);

                        if(data.assetCategoryTemp.activeStatus===true) {
                           $('#assetCategory\\.activeStatusActive').prop('checked',true);
                           $("#assetCategory\\.activeStatus").val("true");
                        }
                        else {                        
                           $('#assetCategory\\.activeStatusInActive').prop('checked',true);              
                           $("#assetCategory\\.activeStatus").val("false");
                        }

                        showInput("assetCategory");
                        hideInput("assetCategorySearch");
                });
            });
            ev.preventDefault();
        });
        
        
        $("#btnAssetCategoryDelete").click(function (ev){
            var url="master/asset-category-authority";
            var params="actionAuthority=DELETE";
            $.post(url, params, function(data) {
                if (data.error) {
                    alertMessage(data.errorMessage);
                    return;
                }
                
                var deleteRowID=$("#assetCategory_grid").jqGrid('getGridParam','selrow');
            
                if(deleteRowID===null){
                    alertMessage("Please Select Row!");
                    return;
                }
                var assetCategory=$("#assetCategory_grid").jqGrid('getRowData',deleteRowID);

                var message="Are You Sure To Delete(Code : "+ assetCategory.code + ")?";
                    var url="master/asset-category-delete";
                    var params="assetCategory.code=" + assetCategory.code;
                    alertMessageDelete("assetCategory",url,params,message,400);
               

//                    $.post(url,params,function (data){
//                        if(data.error){
//                            alertMessage(data.errorMessage);
//                            return;
//                        }
//
//                        alertMessage(data.message);
//                        reloadGridAssetCategory();
//                    });
                
            });
            ev.preventDefault();
        });
        

        $("#btnAssetCategoryCancel").click(function(ev) {
            hideInput("assetCategory");
            showInput("assetCategorySearch");
            allFieldsAssetCategory.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        
        $('#btnAssetCategoryRefresh').click(function(ev) {
            $('#assetCategorySearchActiveStatusRadActive').prop('checked',true);
            $("#assetCategorySearchActiveStatus").val("true");
            $("#assetCategory_grid").jqGrid("clearGridData");
            $("#assetCategory_grid").jqGrid("setGridParam",{url:"master/asset-category-data?"});
            $("#assetCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $("#btnAssetCategoryPrint").click(function(ev) {
            
            var status=$('#assetCategorySearchActiveStatus').val();
            
            var url = "reports/asset-category-print-out-pdf?";
            var params = "activeStatus="+status;
              
            window.open(url+params,'assetCategory','width=500,height=500');
        });
        
        $('#btnAssetCategory_search').click(function(ev) {
            $("#assetCategory_grid").jqGrid("clearGridData");
            $("#assetCategory_grid").jqGrid("setGridParam",{url:"master/asset-category-data?" + $("#frmAssetCategorySearchInput").serialize()});
            $("#assetCategory_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        
    });
    
    function unHandlers_input_assetCategory(){
        unHandlersInput(txtAssetCategoryCode);
        unHandlersInput(txtAssetCategoryName);
    }

    function handlers_input_assetCategory(){
        if(txtAssetCategoryCode.val()===""){
            handlersInput(txtAssetCategoryCode);
        }else{
            unHandlersInput(txtAssetCategoryCode);
        }
        if(txtAssetCategoryName.val()===""){
            handlersInput(txtAssetCategoryName);
        }else{
            unHandlersInput(txtAssetCategoryName);
        }
    }
    
    function countryFormatDate(){
        var inActiveDate=formatDate(dtpAssetCategoryInActiveDate.val(),true);
        dtpAssetCategoryInActiveDate.val(inActiveDate);
        $("#assetCategoryTemp\\.inActiveDateTemp").val(inActiveDate);
        
        var createdDate=formatDate(dtpAssetCategoryCreatedDate.val(),true);
        dtpAssetCategoryCreatedDate.val(createdDate);
        $("#assetCategoryTemp\\.createdDateTemp").val(createdDate);
    }
    
</script>

<s:url id="remoteurlAssetCategory" action="asset-category-data" />
<b>ASSET CATEGORY</b>
<hr>
<br class="spacer"/>
<sj:div id="assetCategoryButton" cssClass="ikb-buttonset ikb-buttonset-single">
<table>
        <tr>
            <td>
                <a href="#" id="btnAssetCategoryNew" class="ikb-button ui-state-default ui-corner-left"><img src="images/button_new.png" border="0" title="New"/><br/>New</a>
            </td>
            <td>
                <a href="#" id="btnAssetCategoryUpdate" class="ikb-button ui-state-default"><img src="images/button_update.png" border="0" title="Update"/><br/>Update</a>
            </td>
            <td>
                <a href="#" id="btnAssetCategoryDelete" class="ikb-button ui-state-default"><img src="images/button_remove.png" border="0" title="Delete"/><br/>Delete</a>
            </td>
            <td>
                <a href="#" id="btnAssetCategoryRefresh" class="ikb-button ui-state-default"><img src="images/button_refresh.png" border="0" title="Refresh"/><br/>Refresh</a>
            </td>
            <td>
                <a href="#" id="btnAssetCategoryPrint" class="ikb-button ui-state-default ui-corner-right"><img src="images/button_printer.png" border="0" title="Print Out"/><br/>Print Out</a>
            </td>
        </tr>
</table>
</sj:div>
    
    
<div id="assetCategorySearchInput" class="content ui-widget">
    <br class="spacer"/>
    <br class="spacer"/>
    <s:form id="frmAssetCategorySearchInput">
        <table>
            <tr>
                <td align="right" valign="center" >Code</td>
                <td>
                    <s:textfield id="assetCategorySearchCode" name="assetCategorySearchCode" size="20"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right" valign="center">Name</td>
                <td>
                    <s:textfield id="assetCategorySearchName" name="assetCategorySearchName" size="40"></s:textfield>
                </td>
                <td width="2%"/>
                <td align="right">Status
                    <s:textfield id="assetCategorySearchActiveStatus" name="assetCategorySearchActiveStatus" readonly="false" size="5" style="display:none"></s:textfield>
                </td>
                <td>
                    <s:radio id="assetCategorySearchActiveStatusRad" name="assetCategorySearchActiveStatusRad" list="{'Active','InActive','All'}"></s:radio>
                </td>
            </tr>
        </table>
        <br/>
        <sj:a href="#" id="btnAssetCategory_search" button="true">Search</sj:a>
        <br/>
        <div class="error ui-state-error ui-corner-all">
            <span class="ui-icon ui-icon-alert" style="float: left;margin-right: 1em;"></span>
        </div>
    </s:form>
</div>   
<br class="spacer"/>
<div id="assetCategoryGrid">
    <sjg:grid
        id="assetCategory_grid"
        dataType="json"
        href="%{remoteurlAssetCategory}"
        pager="true"
        navigator="false"
        navigatorView="false"
        navigatorRefresh="false"
        navigatorDelete="false"
        navigatorAdd="false"
        navigatorEdit="false"
        gridModel="listAssetCategoryTemp"
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
                name="name" index="name" title="Name" width="400" sortable="true"
            />
            <sjg:gridColumn
                name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center" 
            />
    </sjg:grid>
</div>
    
<div id="assetCategoryInput" class="content ui-widget">
    <s:form id="frmAssetCategoryInput">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right"><b>Code *</b></td>
                <td><s:textfield id="assetCategory.code" name="assetCategory.code" title="*" required="true" cssClass="required" maxLength="45"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><b>Name *</b></td>
                <td><s:textfield id="assetCategory.name" name="assetCategory.name" size="50" title="*" required="true" cssClass="required" maxLength="95"></s:textfield></td>
            </tr>
            <tr>
                <td align="right"><B>Active Status *</B>
                <s:textfield id="assetCategory.activeStatus" name="assetCategory.activeStatus" readonly="false" size="5" style="display:none"></s:textfield></td>
                <td><s:radio id="assetCategory.activeStatus" name="assetCategory.activeStatus" list="{'Active','InActive'}"></s:radio></td>                    
            </tr>
            <tr>
                <td align="right" valign="top">Remark</td>
                <td colspan="3">
                    <s:textarea id="assetCategory.remark" name="assetCategory.remark"  cols="47" rows="2" height="20"></s:textarea>
                </td>
            </tr> 
            <tr>
                <td align="right">InActive By</td>
                <td><s:textfield id="assetCategory.inActiveBy"  name="assetCategory.inActiveBy" size="20" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">InActive Date</td>
                <td>
                    <sj:datepicker disabled="true" id="assetCategory.inActiveDate" name="assetCategory.inActiveDate" title=" " displayFormat="dd/mm/yy" required="true" cssClass="required" size="20" showOn="focus" timepicker="true" timepickerShowSecond="true" timepickerFormat="hh:mm:ss" readonly="true"></sj:datepicker>
                </td>
            </tr>
            <tr>
                <td><s:textfield id="assetCategory.createdBy"  name="assetCategory.createdBy" size="20" style="display:none"></s:textfield></td>
                <td><s:textfield id="assetCategory.createdDate" name="assetCategory.createdDate" size="20" style="display:none"></s:textfield></td>
            </tr>
            <tr height="50">
                <td></td>
                <td>
                    <sj:a href="#" id="btnAssetCategorySave" button="true">Save</sj:a>
                    <sj:a href="#" id="btnAssetCategoryCancel" button="true">Cancel</sj:a>
                </td>
            </tr>
        </table>
    </s:form>
</div>